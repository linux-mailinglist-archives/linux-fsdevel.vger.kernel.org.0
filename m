Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B8539DEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 09:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350192AbiFAHLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 03:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347985AbiFAHLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:11:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468BF1094;
        Wed,  1 Jun 2022 00:11:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD10561348;
        Wed,  1 Jun 2022 07:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF87AC385B8;
        Wed,  1 Jun 2022 07:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654067502;
        bh=msvXeenbVZkFFjDrBwDGhupiSlP9tbiX4Ft0x4Ech6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZEnabnhlnptNTwlqLetggxM0qB9RfzMjTfcYWooe8t39hTdz3Neg44WxfFOcxWZu
         GseZdVPiLFptSKd3XGZrDbTo0pqhWAuzVVytqByTMVvrg7cTHwE5Us4XzXdaC1HF2A
         N7C/oVr7CcFSN7FzyEo5KvBCsd05XUmyRQWCU8fAifVwI3KXc2jMeaPQLOV2YzvPgL
         kQwoBIZv/IQN/ugsODtQsBIXGRrpjAqSJw2oNo3+a00mim7kk7GVOHTsm81sGj98yl
         rGA8dmLVmIrzLofXBsyt6/uCMb+3xHt8UV0mZ4S4ty748cnysXqJMXPeWgKtyEfQVg
         unHxy8dSjbJjw==
Date:   Wed, 1 Jun 2022 00:11:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 00/11] direct-io dma alignment
Message-ID: <YpcRLKwZpN+NQRxn@sol.localdomain>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 31, 2022 at 12:11:26PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The most significant change from v4 is the alignment is now checked
> prior to building the bio. This gets the expected EINVAL error for
> misaligned userspace iovecs in all cases now (Eric Biggers).
> 
> I've removed the legacy fs change, so only iomap filesystems get to use
> this alignement capability (Christoph Hellwig).
> 
> The block fops check for alignment returns a bool now (Damien).
> 
> Adjusted some comments, docs, and other minor style issues.
> 
> Reviews added for unchanged or trivially changed patches, removed
> reviews for ones that changed more significantly.
> 
> As before, I tested using 'fio' with forced misaligned user buffers on
> raw block, xfs, and ext4 (example raw block profile below).
> 

I still don't think you've taken care of all the assumptions that bv_len is a
multiple of logical block size, or at least SECTOR_SIZE.  Try this:

	git grep -E 'bv_len (>>|/)'

Also:

	git grep '<.*bv_len;'

Also take a look at bio_for_each_segment(), specifically how iter->bi_sector is
updated.

- Eric
