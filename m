Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B196F63C5D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 17:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiK2Q65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 11:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbiK2Q4o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:56:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7406931E;
        Tue, 29 Nov 2022 08:51:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E48F06182F;
        Tue, 29 Nov 2022 16:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B39C433D6;
        Tue, 29 Nov 2022 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669740667;
        bh=LYZJsu1DOlRQkmkTy7jSyaGxwY1+2mNBCvXV9Xgev8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOLogoxhcyZA3N5S2zyPuNJoGHUstbKWRioer7l/SCiUpR522WqAdEk1LE8tJxYPW
         9FAYyVMlIW4Of/Y23n1jkPzgyTc+QLOT04hID5rcJzrjRz543axOVHzO0wiMoLalCW
         k9yVOoOQP+yqKyDY+jXefpZ9BtPiesiu35bIrNfe2vX62DBtvMdtMj98Sue/qiH2zz
         T1AdNXDXjJk/T9Dq2FnVDKqxiQtJLL7HnqX35f16fpq7dHPnp65lQ5zECBC01tsS92
         rOj7snaNP+UryAUECK0o9EFBb0PugZ5nLrM+d/cQIcoe3SIz0a5+W/NI8UBEsjQ0BL
         keZ0N/w1jhtbQ==
Date:   Tue, 29 Nov 2022 08:51:05 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v4] fsverity: stop using PG_error to track error status
Message-ID: <Y4Y4eaMvCBZMgig0@google.com>
References: <20221125190642.12787-1-ebiggers@kernel.org>
 <Y4WrSeIf+E6+tL1y@google.com>
 <Y4WxUZesKJ79mI9e@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4WxUZesKJ79mI9e@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/28, Eric Biggers wrote:
> On Mon, Nov 28, 2022 at 10:48:41PM -0800, Jaegeuk Kim wrote:
> > >  static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
> > >  {
> > >  	struct bio_vec *bv;
> > >  	struct bvec_iter_all iter_all;
> > > +	struct bio_post_read_ctx *ctx = bio->bi_private;
> > >  
> > > -	/*
> > > -	 * Update and unlock the bio's pagecache pages, and put the
> > > -	 * decompression context for any compressed pages.
> > > -	 */
> > >  	bio_for_each_segment_all(bv, bio, iter_all) {
> > >  		struct page *page = bv->bv_page;
> > >  
> > >  		if (f2fs_is_compressed_page(page)) {
> > > -			if (bio->bi_status)
> > > +			if (!ctx->decompression_attempted)
> > 
> > If seems this causes a panic due to the ctx nullified by f2fs_verify_bio.
> > 
> 
> Thanks for catching that!  I've sent out v5 that checks for 'ctx &&
> !ctx->decompression_attempted' here.  That's the right thing to do, since if ctx
> is NULL then decompression must have been attempted.
> 
> I'd like to get rid of freeing the bio_post_read_ctx in f2fs_verify_bio().
> But I believe it's still needed, at least in theory.
> 
> Do you have a suggestion for testing f2fs compression + verity with xfstests?
> I missed this because compression isn't covered by the "verity" group tests.
> Maybe there should be an "f2fs/compress" config in xfstests-bld that uses mkfs
> and mount options that cause all files to be automatically compressed, similar
> to how f2fs/encrypt automatically encrypts all files with test_dummy_encryption.

I used for fsstress+fault_injection+shutdown loop with compressed and
non-compressed directories with:

# mkfs.f2fs -f -O extra_attr -O project_quota -O compression -g android /dev/$DEV
# mount -t f2fs -o discard,fsync_mode=nobarrier,reserve_root=32768,checkpoint_merge,atgc,compress_cache /dev/$DEV $TESTDIR
# mkdir $TESTDIR/comp
# f2fs_io setflags compression $TESTDIR/comp
# fsstress [options] -d $TESTDIR/comp

I think you can simply mount with "-o compress_extension=*" to compress
everything.

> 
> - Eric
