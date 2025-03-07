Return-Path: <linux-fsdevel+bounces-43388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B85A55C20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 01:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292681897295
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 00:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB1E81732;
	Fri,  7 Mar 2025 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQjjERBB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3110825569;
	Fri,  7 Mar 2025 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308309; cv=none; b=XDBcTWabqgUxIY6bPRl2GlXrRF0qA0tqTTmCW//834qiTY1TNcENgm5Ye6W/3KK0GHiGbLa9zS2fKPF9yZoimt/FfbfpWLHLNAMat89kcs0XBaO4ghkNWDva3yyoVXhIdIJd0mDnyXZgZLiHFfzOEvB5rAxfwnWGeXl2xxmpYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308309; c=relaxed/simple;
	bh=kDqnrV6AT+oYvf0XVF5vafW+A8CbNZE/gfr7dugbRrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3WMjRYQUjUjLT0RmaqDCAzJj4e1FJzUnAmPQo9Vyhkl/b8JvaJcdt86He4621GCzWizO2NWYBnEtzlYpwtR+z2neORqnFhnTMxQuJaIpYmJd7yQk+i4fbzYy5Fp1FLgcCy/85Gn8gC2oZj+Sod8aPN8TkZ3U3XWyYeZ7t8jUTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQjjERBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3B4C4CEE0;
	Fri,  7 Mar 2025 00:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741308308;
	bh=kDqnrV6AT+oYvf0XVF5vafW+A8CbNZE/gfr7dugbRrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQjjERBBJy0UuejkV6kZAmPPLMrau9rb1AIsfQDOGILqsv/t/wCgCNhEYJZfsdh11
	 2CL7LhjJffwOrIUblzxUVEzCuOAgvZDqF9ZdcIUVMh2STDYm5DBSdfVy3LIQITE53N
	 Aer57sF6jscs55UvI5hkOJNXaRKJdswMEdLvV+hGgBjGlRRZf+dYHNqkbQIakZbPAy
	 0p+aDyrfJaCgvmkew1tFCbvzytm9wbqS37pwnQBCJxXu0LLcJaOrZBZ9CM+KQovhPi
	 rRaX1StGq9wQI9X3xaKWCWZie9k2V0aP2y0GNwJmRxoAnljx+Ok8VYSKseanHB8b7f
	 8YlPDM+3If2dQ==
Date: Thu, 6 Mar 2025 16:45:06 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: brauner@kernel.org, hare@suse.de, willy@infradead.org,
	david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org,
	john.g.garry@oracle.com, hch@lst.de, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [PATCH] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()
Message-ID: <Z8pBkuPn3kwf1Jvm@bombadil.infradead.org>
References: <20250305015301.1610092-1-mcgrof@kernel.org>
 <bgqqfjiumcr5csde4qzom2vs2ktnneok3gdffvu6tlyc3ih7x3@tioflbnatc5w>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bgqqfjiumcr5csde4qzom2vs2ktnneok3gdffvu6tlyc3ih7x3@tioflbnatc5w>

On Thu, Mar 06, 2025 at 01:39:49PM -0500, Kent Overstreet wrote:
> On Tue, Mar 04, 2025 at 05:53:01PM -0800, Luis Chamberlain wrote:
> > The commit titled "block/bdev: lift block size restrictions to 64k"
> > lifted the block layer's max supported block size to 64k inside the
> > helper blk_validate_block_size() now that we support large folios.
> > However in lifting the block size we also removed the silly use
> > cases many filesystems have to use sb_set_blocksize() to *verify*
> > that the block size < PAGE_SIZE. The call to sb_set_blocksize() can
> > happen in-kernel given mkfs utilities *can* create for example an
> > ext4 32k block size filesystem on x86_64, the issue we want to prevent
> > is mounting it on x86_64 unless the filesystem supports LBS.
> > 
> > While, we could argue that such checks should be filesystem specific,
> > there are much more users of sb_set_blocksize() than LBS enabled
> > filesystem on linux-next, so just do the easier thing and bring back
> > the PAGE_SIZE check for sb_set_blocksize() users.
> > 
> > This will ensure that tests such as generic/466 when run in a loop
> > against say, ext4, won't try to try to actually mount a filesystem with
> > a block size larger than your filesystem supports given your PAGE_SIZE
> > and in the worst case crash.
> > 
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> bcachefs doesn't use sb_set_blocksize() - but it appears it should, and
> it does also support bs > ps in -next.
> 
> Can we get a proper helper for lbs filesystems?

What do you think of this last recommention I had?

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

