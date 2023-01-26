Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0242767D767
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 22:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjAZVJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 16:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjAZVJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:09:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0D22B622;
        Thu, 26 Jan 2023 13:09:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75D5AB81E0F;
        Thu, 26 Jan 2023 21:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DE0C433EF;
        Thu, 26 Jan 2023 21:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674767380;
        bh=Ivb1qksbftnFFwvDhNXLsTVGImL1pbxAjiwYLOBHQsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nF6ug6pmpwMcAqKOp/z/tD8sE9npc/WR1N/hE9Y7vQx3dDVnVobGjNK5dTqE5bE1i
         0YBVBVQom+7UFk+hD/2xL/FGhFiJTuFkq9BfGGdspSYiIf8DCuFHhuib6jq11GlLJy
         sU4C7ZEMc5g4JnsVWldKWO8o/xtkt5QtyW76SdQY1DNb/GhGmD/nD90U1roBWvM8lr
         qTuef0W+uUcng+5qUuFTAfLEfISJ5avDNwIDznLsATeN+VEV+BIqU/G55ZMPGKGwWU
         Cy3qec5Tew/DL1AiukspURbjnllpwFhOeWKMxcxGKA+9d5hHRankRgrqjVUyPLoUTx
         OqMzjeo4mV3qg==
Date:   Thu, 26 Jan 2023 13:09:38 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        linux-ext4@vger.kernel.org, Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 3/5] fs: f2fs: initialize fsdata in pagecache_write()
Message-ID: <Y9LsEgN3ZdmC1aQp@google.com>
References: <20221121112134.407362-1-glider@google.com>
 <20221121112134.407362-3-glider@google.com>
 <Y3vXL3Lw+DnVkQYC@gmail.com>
 <Y84wVf+pZ7tRwCh8@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y84wVf+pZ7tRwCh8@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/22, Eric Biggers wrote:
> On Mon, Nov 21, 2022 at 07:53:19PM +0000, Eric Biggers wrote:
> > On Mon, Nov 21, 2022 at 12:21:32PM +0100, Alexander Potapenko wrote:
> > > When aops->write_begin() does not initialize fsdata, KMSAN may report
> > > an error passing the latter to aops->write_end().
> > > 
> > > Fix this by unconditionally initializing fsdata.
> > > 
> > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > Fixes: 95ae251fe828 ("f2fs: add fs-verity support")
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> > > ---
> > >  fs/f2fs/verity.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
> > > index c352fff88a5e6..3f4f3295f1c66 100644
> > > --- a/fs/f2fs/verity.c
> > > +++ b/fs/f2fs/verity.c
> > > @@ -81,7 +81,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
> > >  		size_t n = min_t(size_t, count,
> > >  				 PAGE_SIZE - offset_in_page(pos));
> > >  		struct page *page;
> > > -		void *fsdata;
> > > +		void *fsdata = NULL;
> > >  		int res;
> > >  
> > >  		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
> > 
> > Reviewed-by: Eric Biggers <ebiggers@google.com>
> > 
> 
> Jaegeuk, can you please apply this patch?

Yup, applied.

> 
> - Eric
