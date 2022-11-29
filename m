Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4AA63BA71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 08:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiK2HOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 02:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiK2HOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:14:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B840B2657F;
        Mon, 28 Nov 2022 23:14:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A1D6B81168;
        Tue, 29 Nov 2022 07:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A2DC433C1;
        Tue, 29 Nov 2022 07:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669706067;
        bh=us0xxwnUQweVKC2bsLBc59jamq4rwG2vuwf65B53Rfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r3nhquNGwkJp4h1DWM5InakWl/6nwkm3jRfMDQ4lUMMThLJt5JHODtnj5i9KOeCjD
         rJ+AnZT6nsQftI8YgD9rRkyM2aLU5Xgbpwjwt15+gCXYo7kBS3B0wcVEa9PnpQIHFk
         5wyisa7hgbnwQtoYl5BhpUUwq3pOo4k/iiZOabj6x0K4LbEMpsuydNgnKblZ9FR5B3
         RocI8vGci7EUzd9I5go+yXZgt0qfnd23ZHKVtLTeYqkFbZ2sBMav/0Z4s8nFn2bSY3
         YiPXhOeHCpttvtenaGLh9U6ffjWm+vcBat7foTSoE0at5HWRe6g1ZwZnvditRm75QT
         WVe4ZGFsIFJyA==
Date:   Mon, 28 Nov 2022 23:14:25 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v4] fsverity: stop using PG_error to track error status
Message-ID: <Y4WxUZesKJ79mI9e@sol.localdomain>
References: <20221125190642.12787-1-ebiggers@kernel.org>
 <Y4WrSeIf+E6+tL1y@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4WrSeIf+E6+tL1y@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:48:41PM -0800, Jaegeuk Kim wrote:
> >  static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
> >  {
> >  	struct bio_vec *bv;
> >  	struct bvec_iter_all iter_all;
> > +	struct bio_post_read_ctx *ctx = bio->bi_private;
> >  
> > -	/*
> > -	 * Update and unlock the bio's pagecache pages, and put the
> > -	 * decompression context for any compressed pages.
> > -	 */
> >  	bio_for_each_segment_all(bv, bio, iter_all) {
> >  		struct page *page = bv->bv_page;
> >  
> >  		if (f2fs_is_compressed_page(page)) {
> > -			if (bio->bi_status)
> > +			if (!ctx->decompression_attempted)
> 
> If seems this causes a panic due to the ctx nullified by f2fs_verify_bio.
> 

Thanks for catching that!  I've sent out v5 that checks for 'ctx &&
!ctx->decompression_attempted' here.  That's the right thing to do, since if ctx
is NULL then decompression must have been attempted.

I'd like to get rid of freeing the bio_post_read_ctx in f2fs_verify_bio().
But I believe it's still needed, at least in theory.

Do you have a suggestion for testing f2fs compression + verity with xfstests?
I missed this because compression isn't covered by the "verity" group tests.
Maybe there should be an "f2fs/compress" config in xfstests-bld that uses mkfs
and mount options that cause all files to be automatically compressed, similar
to how f2fs/encrypt automatically encrypts all files with test_dummy_encryption.

- Eric
