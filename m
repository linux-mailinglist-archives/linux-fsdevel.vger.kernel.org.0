Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94959741F4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 06:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjF2Eek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 00:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjF2Eej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 00:34:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D251FE8;
        Wed, 28 Jun 2023 21:34:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0277D614BE;
        Thu, 29 Jun 2023 04:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBC7C433C8;
        Thu, 29 Jun 2023 04:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688013277;
        bh=Nk3JAf0hVqcZqbMDWTF4i9Dk+WqJ/ybiHoB+uAe89rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSomkv906q4jECtjq1brh87cRhtHkqxP5i6pwFvkKCLBbiWUxqFaDPIvgJ8PmxN1w
         wlI85kHcYh0TLDEICgZ05l8dm9UoPMTFQc0poef9Aud0Cr7iv7n2p6CN9Ztt99EoIT
         47htg7un2F0soh4QTcQ2+QxJVh3VBXPY8xqNIryd8Vq1Z7dpVTWXQWRy3E7bO/lpgF
         1AtzuXTW+ufPAf1NDaKfFjzQK27icHDPKkmHaYbj46Oa71dozc0oJABfHIOWdi2GAl
         G3ONkilxieEwNquKpkjL4sLUDwYm9emVWBM4RoFve1MjjSa0/Abh22r5by+S7fFj1y
         W0a4sNY0uJRCw==
Date:   Wed, 28 Jun 2023 21:34:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Matthew Wilcox <willy@infradead.org>, axboe@kernel.dk,
        song@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/7] block: add queue_logical_block_mask() and
 bdev_logical_block_mask()
Message-ID: <20230629043436.GL11467@frogsfrogsfrogs>
References: <20230628093500.68779-1-frank.li@vivo.com>
 <ZJxj6odz49iB5Mmm@casper.infradead.org>
 <ee27ca83-a144-7468-4515-efa93f01aa43@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee27ca83-a144-7468-4515-efa93f01aa43@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:44:35AM +0800, Yangtao Li wrote:
> On 2023/6/29 0:46, Matthew Wilcox wrote:
> 
> > On Wed, Jun 28, 2023 at 05:34:54PM +0800, Yangtao Li wrote:
> > > Introduce queue_logical_block_mask() and bdev_logical_block_mask()
> > > to simplify code, which replace (queue_logical_block_size(q) - 1)
> > > and (bdev_logical_block_size(bdev) - 1).
> > The thing is that I know what queue_logical_block_size - 1 does.
> > That's the low bits.  _Which_ bits are queue_logical_block_mask?
> > The high bits or the low bits?  And before you say "It's obviously",
> > we have both ways round in the kernel today.
> 
> 
> I guess for this you mentioned, can we name it bdev_logical_block_lmask and
> queue_logical_block_lmask?

{bdev,queue}_offset_in_lba() ?

--D

> 
> Thx,
> 
> > 
> > I am not in favour of this change.  I might be in favour of bool
> > queue_logical_block_aligned(q, x), but even then it doesn't seem worth
> > the bits.
