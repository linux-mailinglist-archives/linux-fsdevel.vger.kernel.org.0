Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8208B777CEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjHJP5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 11:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbjHJP5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541521994;
        Thu, 10 Aug 2023 08:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E369E66112;
        Thu, 10 Aug 2023 15:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA41C433C7;
        Thu, 10 Aug 2023 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691683026;
        bh=k+0hriTLgqlay4j5d2D8hsnyhR1p1Uo2rvxvVbvjk20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cq1+RYpOf/dpj9Ex4Aq+Pk0UdxzluXEPyZ2wq6nyBPypfunvwgea22KiY8po6muY+
         18mDN04IOsNi2Ij1TOaRobtt/uw/pzxr5OojiWdbfDdn9G5wMWHF0SpWzXNp/Mn79y
         0yShEovF4IyaS+2hWaeSagtr+K1aq9DJIC+GBvDl2ux497v9XbBhEf8caAszVZ0/yS
         K1nfyIDjojLE+Ul6d8ttKvyIwkdwSTf8y9sNQM2WaWru+nXdwS0mLnJZ9K4iKNt0j6
         zzvuuw9vgdbFYr239u3uIdIiYTGbrcggcabaM5j5PdXI7kUUyRFI1GtBN0tLPFbROG
         WUFFGgqdjk1rA==
Date:   Thu, 10 Aug 2023 08:57:05 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/13] xfs: document the invalidate_bdev call in
 invalidate_bdev
Message-ID: <20230810155705.GC11352@frogsfrogsfrogs>
References: <20230809220545.1308228-1-hch@lst.de>
 <20230809220545.1308228-8-hch@lst.de>
 <ZNUAp8FJIKU1/sTn@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNUAp8FJIKU1/sTn@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:22:15PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 09, 2023 at 03:05:39PM -0700, Christoph Hellwig wrote:
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
> > +	 * no longer reflects what's on disk, xfs_db reads the stale metadata,
> > +	 * and fails to find /a.  Most of the time this succeeds because closing
> > +	 * a bdev invalidates the page cache, but when processes race, everyone
> > +	 * loses.
> > +	 */
> >  	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
> >  		blkdev_issue_flush(mp->m_logdev_targp->bt_bdev);
> >  		invalidate_bdev(mp->m_logdev_targp->bt_bdev);
> 
> While I have no complaints with this as a commit message, it's just too
> verbose for an inline comment, IMO.  Something pithier and more generic
> would seem appropriate.  How about:
> 
> 	/*
> 	 * Prevent userspace (eg blkid or xfs_db) from seeing stale data.
> 	 * XFS is not coherent with the bdev's page cache.

"XFS' buffer cache is not coherent with the bdev's page cache."
?

--D

> 	 */
