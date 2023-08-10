Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31BE7772C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjHJIUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 04:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHJIUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE5DAC;
        Thu, 10 Aug 2023 01:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7406064821;
        Thu, 10 Aug 2023 08:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C0EC433C7;
        Thu, 10 Aug 2023 08:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691655616;
        bh=vkpB0KymfAHadNZg+1KHRj1yxHafNU8RXYifonw0meo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2jnnle2t4DlMDLubGGIHqU7oPc1+V9cD7ZYRAlBIYardd0Xu3v/Mtlvc+h0vEAxX
         6So+eaOBkkY6ufhPZPXLxFy8Z6Dg8EabpjfaaSjPv3XFd4L7AOyhfoZ76K5zHa0EbZ
         2YXllfejU96WbzGV/hmrdeEEmKN5Usy3Ogc9DKUiRq7Ksi+LFydsVYRXfFe4MBopAj
         9Auj7rm3Ql6+abI04i5dIucMXMdOMimkOgjxa3a8NdiIMHJiwTGdhAcas8PnIONiBM
         9IME5pWvbPYFbWHG9z8hCvoVwQvMYQ5s82tqFgKNhqv9hox9AT+SoTGahF7Kn17+vk
         d7tWWKVYT4mRQ==
Date:   Thu, 10 Aug 2023 10:20:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/13] xfs: document the invalidate_bdev call in
 invalidate_bdev
Message-ID: <20230810-labyrinth-weshalb-2a2e90537a2d@brauner>
References: <20230809220545.1308228-1-hch@lst.de>
 <20230809220545.1308228-8-hch@lst.de>
 <20230809223923.GX11352@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809223923.GX11352@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:39:23PM -0700, Darrick J. Wong wrote:
> On Wed, Aug 09, 2023 at 03:05:39PM -0700, Christoph Hellwig wrote:
> > Copy and paste the commit message from Darrick into a comment to explain
> > the seemly odd invalidate_bdev in xfs_shutdown_devices.
> 
>       ^ seemingly?
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/xfs/xfs_super.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 4ae3b01ed038c7..c169beb0d8cab3 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -399,6 +399,32 @@ STATIC void
> >  xfs_shutdown_devices(
> >  	struct xfs_mount	*mp)
> >  {
> > +	/*
> > +	 * Udev is triggered whenever anyone closes a block device or unmounts
> > +	 * a file systemm on a block device.
> > +	 * The default udev rules invoke blkid to read the fs super and create
> > +	 * symlinks to the bdev under /dev/disk.  For this, it uses buffered
> > +	 * reads through the page cache.
> > +	 *
> > +	 * xfs_db also uses buffered reads to examine metadata.  There is no
> > +	 * coordination between xfs_db and udev, which means that they can run
> > +	 * concurrently.  Note there is no coordination between the kernel and
> > +	 * blkid either.
> > +	 *
> > +	 * On a system with 64k pages, the page cache can cache the superblock
> > +	 * and the root inode (and hence the root directory) with the same 64k
> > +	 * page.  If udev spawns blkid after the mkfs and the system is busy
> > +	 * enough that it is still running when xfs_db starts up, they'll both
> > +	 * read from the same page in the pagecache.
> > +	 *
> > +	 * The unmount writes updated inode metadata to disk directly.  The XFS
> > +	 * buffer cache does not use the bdev pagecache, nor does it invalidate
> > +	 * the pagecache on umount.  If the above scenario occurs, the pagecache
> 
> This sentence reads a little strangely, since "nor does it invalidate"
> would seem to conflict with the invalidate_bdev call below.  I suggest
> changing the verb a bit:
> 
> "The XFS buffer cache does not use the bdev pagecache, so it needs to
> invalidate that pagecache on unmount."
> 
> With those two things changed,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Fixed in-tree.
