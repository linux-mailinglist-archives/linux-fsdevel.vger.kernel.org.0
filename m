Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0782F677556
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 07:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjAWG7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 01:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjAWG7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:59:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48FA13DE9;
        Sun, 22 Jan 2023 22:59:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3251DB80BEA;
        Mon, 23 Jan 2023 06:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896E9C433EF;
        Mon, 23 Jan 2023 06:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674457175;
        bh=oruDvn5Mc2ikihY0Gp535LHpXV69DqgvDQhed9bm0sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uM2qnvMoyR6bH/uoiqSTyrjMVyhh39uGnNOhVzwhonP5ZJytyfswVZ6vOdWk5IpOY
         koWxTemvu1K3WD2Otz898dCYddboAHzeEA96tjy780rry22qmpU7T5uCQ/0vPcKSyY
         52aYTfinuWF/MVqHIVqG+QRd0ZJtV7tC6JB+784Nwg00GDmBR/ruk/9NOe5ukFY/bT
         moEazkRfdn7KuPw2mPP7wM3mjekVMraLHkYVfKKkuUDyUg92o9FpiwwnBQzVPgk+TC
         HzliX49T3rLuvDIuj13oRaOnqBif9i1ETGVsCkezHqGk139Ee3v8CRZnxKN0TWHkI/
         J3lYtuGfD6Ksg==
Date:   Sun, 22 Jan 2023 22:59:33 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     tytso@mit.edu, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
        akpm@linux-foundation.org, linux-ext4@vger.kernel.org,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 3/5] fs: f2fs: initialize fsdata in pagecache_write()
Message-ID: <Y84wVf+pZ7tRwCh8@sol.localdomain>
References: <20221121112134.407362-1-glider@google.com>
 <20221121112134.407362-3-glider@google.com>
 <Y3vXL3Lw+DnVkQYC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3vXL3Lw+DnVkQYC@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 07:53:19PM +0000, Eric Biggers wrote:
> On Mon, Nov 21, 2022 at 12:21:32PM +0100, Alexander Potapenko wrote:
> > When aops->write_begin() does not initialize fsdata, KMSAN may report
> > an error passing the latter to aops->write_end().
> > 
> > Fix this by unconditionally initializing fsdata.
> > 
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Fixes: 95ae251fe828 ("f2fs: add fs-verity support")
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> >  fs/f2fs/verity.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
> > index c352fff88a5e6..3f4f3295f1c66 100644
> > --- a/fs/f2fs/verity.c
> > +++ b/fs/f2fs/verity.c
> > @@ -81,7 +81,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
> >  		size_t n = min_t(size_t, count,
> >  				 PAGE_SIZE - offset_in_page(pos));
> >  		struct page *page;
> > -		void *fsdata;
> > +		void *fsdata = NULL;
> >  		int res;
> >  
> >  		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> 

Jaegeuk, can you please apply this patch?

- Eric
