Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E06272CB53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 18:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjFLQTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 12:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjFLQTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:19:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B8410FC;
        Mon, 12 Jun 2023 09:19:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D57962B6C;
        Mon, 12 Jun 2023 16:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B28C433D2;
        Mon, 12 Jun 2023 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686586753;
        bh=1Pg6K/mRbNwSUBb2+JQVUVkftOwerQBSw3ZHxkdQIwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isGY9OrhG/Kov6/wT9QytolJi0sZtDOYrW3YCL0j0GnYT5fj4DgrV+393PwgenCKy
         FxH6NkbKUif7VYLtcyvUNtzds02/tcJHgy2hIP/YYP30urvlCCiLKQSYGQUt3qWTae
         FGmYgPH4xjt6jtpNNil/OHqtDuiEiz4+a0foVdOkCYMpqIYvYPCJaDoNUwgfsj3Zcr
         xaJMTqdmijzLSNIsi6wZaS5VrCqWykUAPhQiuabzbWX9mt95xgmqH4Mgl4xOxizX8Q
         VxmlviBblrOVbJhAGgCdQOJgst55jkzRK9iyahdBDAFFcpidkHXIWOn5VJpxLwBe5N
         jnfOJfTlNXwyA==
Date:   Mon, 12 Jun 2023 09:19:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, hch@infradead.org, corbet@lwn.net,
        snitzer@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org,
        linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/11] blksnap - block devices snapshots module
Message-ID: <20230612161911.GA1200@sol.localdomain>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612135228.10702-1-sergei.shtepa@veeam.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 03:52:17PM +0200, Sergei Shtepa wrote:
> Hi all.
> 
> I am happy to offer a improved version of the Block Devices Snapshots
> Module. It allows to create non-persistent snapshots of any block devices.
> The main purpose of such snapshots is to provide backups of block devices.
> See more in Documentation/block/blksnap.rst.

How does blksnap interact with blk-crypto?

I.e., what happens if a bio with a ->bi_crypt_context set is submitted to a
block device that has blksnap active?

If you are unfamiliar with blk-crypto, please read
Documentation/block/inline-encryption.rst

It looks like blksnap hooks into the block layer directly, via the new
"blkfilter" mechanism.  I'm concerned that it might ignore ->bi_crypt_context
and write data to the disk in plaintext, when it is supposed to be encrypted.

- Eric
