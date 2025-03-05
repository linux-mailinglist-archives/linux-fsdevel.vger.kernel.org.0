Return-Path: <linux-fsdevel+bounces-43294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73473A50BFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7491703F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 19:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469452561D0;
	Wed,  5 Mar 2025 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4fkjJpY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951E4254B09;
	Wed,  5 Mar 2025 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204539; cv=none; b=Mi+AMpfz79OK3Vr7ygagTJPtm35LKUgztntj2U07h5b4I4SsIBZOycA1nYy7GL5FnyNVohaWZIoSINsfRSgL0mBLsO+sidGP7D2Uz8HoqJ7W60ez+Vuylj1u3I81zdbvpMzng9mzFgqd2yIQ0vDlBQTV9vatN7Jr0blwCWpMm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204539; c=relaxed/simple;
	bh=8Pi9k7DrvKthL1MuanmkdkV6KFC0FH691EfVrLc2rWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoHuE+yN8SKoGJEboIAlImVR263JOJg2tRQVp2KToJEFdtQ+5WGNn0Q7tlbKIv5NwCw5VbSIdKNRDHl8LYE11ikqK1Ktr9W3piwRe8utakaP4+iYU7iWRCquqsSHpbCVp9u+RSqoFgKMHB/ehgcCx5Q1sRSD5KjRdAjS2ildvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4fkjJpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EA5C4CED1;
	Wed,  5 Mar 2025 19:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741204539;
	bh=8Pi9k7DrvKthL1MuanmkdkV6KFC0FH691EfVrLc2rWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k4fkjJpYo9TeEfrG+XOTafCgzjrj6icd0DGTyQhzvVLpyCZtRCLk+/Kum4K9Om2iw
	 25NFh2ZNGoE/h+2fMT8AbiqWILIa/u36NidjMD0o+vIrj18x5VoL3f5Ck4vBStbAaB
	 GKrWfCEVZbT8ibCrXhvZDoNYrkW3+IuKu1+T2ymomaWUwC7U6/ye/s9sj5vV1dWGGZ
	 fPd81/shlGg9Y6QrWKbklANtsPU7EOcoGx8t4yqtP7QI/9BbNEwlezveIQ+jG0Ad3K
	 2dG6IXWgFFpCq+u3najwWhIhQ90vCjCTshyzNWqGJyaiid5QZQHqP2DRmHR1SH4zps
	 esd2ulnUEeBQg==
Date: Wed, 5 Mar 2025 11:55:37 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, brauner@kernel.org, hare@suse.de,
	david@fromorbit.com, kbusch@kernel.org, john.g.garry@oracle.com,
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()'
Message-ID: <Z8isOYkBnMtQgzXw@bombadil.infradead.org>
References: <20250305015301.1610092-1-mcgrof@kernel.org>
 <Z8fpZWHNs8eI5g38@casper.infradead.org>
 <20250305063330.GA2803730@frogsfrogsfrogs>
 <Z8hck6aKEopiezug@casper.infradead.org>
 <Z8iEMv354ThMRr0b@bombadil.infradead.org>
 <20250305184834.GE2803771@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305184834.GE2803771@frogsfrogsfrogs>

On Wed, Mar 05, 2025 at 10:48:34AM -0800, Darrick J. Wong wrote:
> On Wed, Mar 05, 2025 at 09:04:50AM -0800, Luis Chamberlain wrote:
> > On Wed, Mar 05, 2025 at 02:15:47PM +0000, Matthew Wilcox wrote:
> > > On Tue, Mar 04, 2025 at 10:33:30PM -0800, Darrick J. Wong wrote:
> > > > > So this is expedient because XFS happens to not call sb_set_blocksize()?
> > > > > What is the path forward for filesystems which call sb_set_blocksize()
> > > > > today and want to support LBS in future?
> > > > 
> > > > Well they /could/ set sb_blocksize/sb_blocksize_bits themselves, like
> > > > XFS does.
> > > 
> > > I'm kind of hoping that isn't the answer.
> > 
> > set_blocksize() can be used. The only extra steps the filesystem needs
> > to in addition is:
> > 
> > 	sb->s_blocksize = size;
> > 	sb->s_blocksize_bits = blksize_bits(size);
> > 
> > Which is what both XFS and bcachefs do.
> > 
> > We could modify sb to add an LBS flag but that alone would not suffice
> > either as the upper limit is still a filesystem specific limit. Additionally
> > it also does not suffice for filesystems that support a different device
> > for metadata writes, for instance XFS supports this and uses the sector
> > size for set_blocksize().
> > 
> > So I think that if ext4 for example wants to use LBS then simply it
> > would open code the above two lines and use set_blocksize(). Let me know
> > if you have any other recommendations.
> 
> int sb_set_large_blocksize(struct super_block *sb, int size)
> {
> 	if (set_blocksize(sb->s_bdev_file, size))
> 		return 0;
> 	sb->s_blocksize = size;
> 	sb->s_blocksize_bits = blksize_bits(size);
> 	return sb->s_blocksize;
> }
> EXPORT_SYMBOL_GPL(sb_set_large_blocksize);
> 
> int sb_set_blocksize(struct super_block *sb, int size)
> {
> 	if (size > PAGE_SIZE)
> 		return 0;
> 	return sb_set_large_blocksize(sb, size);
> }
> EXPORT_SYMBOL(sb_set_blocksize);
> 
> Though you'll note that this doesn't help XFS, or any other filesystem
> where the bdev block size isn't set to the fs block size.  But xfs can
> just be weird on its own like always. ;)

Actually, I failed to also notice XFS implicitly calls sb_set_large_blocksize()
through:

xfs_fs_get_tree() -->
  get_tree_bdev() -->
    get_tree_bdev_flags() -->
      get_tree_bdev_flags() -->
        sb_set_blocksize()

We just don't care if sb_set_blocksize() if fails inside get_tree_bdev_flags().
To be clear this has been the case since we added and tested LBS on XFS.

So if we wanted something more automatic, how about:

diff --git a/block/bdev.c b/block/bdev.c
index 3bd948e6438d..4844d1e27b6f 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -181,6 +181,8 @@ EXPORT_SYMBOL(set_blocksize);
 
 int sb_set_blocksize(struct super_block *sb, int size)
 {
+	if (!(sb->s_type->fs_flags & FS_LBS) && size > PAGE_SIZE)
+		return 0;
 	if (set_blocksize(sb->s_bdev_file, size))
 		return 0;
 	/* If we get here, we know size is validated */
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 90ade8f648d9..e99e378d68ea 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -2396,7 +2396,7 @@ static struct file_system_type bcache_fs_type = {
 	.name			= "bcachefs",
 	.init_fs_context	= bch2_init_fs_context,
 	.kill_sb		= bch2_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_LBS,
 };
 
 MODULE_ALIAS_FS("bcachefs");
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d92d7a07ea89..3d8b80165d48 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2118,7 +2118,8 @@ static struct file_system_type xfs_fs_type = {
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= xfs_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
+				  FS_LBS,
 };
 MODULE_ALIAS_FS("xfs");
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2c3b2f8a621f..16d17bd82be0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2616,6 +2616,7 @@ struct file_system_type {
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
 #define FS_MGTIME		64	/* FS uses multigrain timestamps */
+#define FS_LBS			128	/* FS supports LBS */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;

