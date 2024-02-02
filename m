Return-Path: <linux-fsdevel+bounces-10002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F88F846F52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2361C2260D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC821386C4;
	Fri,  2 Feb 2024 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+l+oPAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD441168AB;
	Fri,  2 Feb 2024 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874353; cv=none; b=bQVTjLZh4vnlqNyZoxUHl/XM8o6PnRekLigxtJ/ijkri8s2DWB8NKzjypzTvK5V/xh2lg650MxdUdp/EwM5z7GTgKv3Esf5Xwd1b8HIzbH0fhjYUYHeqdgzvlSQX6sZneo3kcBQuZhlUdKrCJRAsHazKu/NpG2gXyezQdhcW3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874353; c=relaxed/simple;
	bh=aim013CUjKQXaDZJc+hl+bUNXMr4WAt6Ni7uFqWvyjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqOKz+tApM0Kfl0JVada3vAADnDXzMcJdLBwaQFwbBC/vdfO6I9icVNfZnUZX55XydRjUZtxnE1+zs6Nsw0KB47AXEFGPKdWAwnnBw7rDkBbevn2XZMGv1RSILULOxjP081jyl5Bvntelst8zuv8TVfzUqJ/pNxFkrVoAuI1Rok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+l+oPAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A46C433C7;
	Fri,  2 Feb 2024 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874353;
	bh=aim013CUjKQXaDZJc+hl+bUNXMr4WAt6Ni7uFqWvyjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+l+oPAAphj+YL+emyX1nHkt3caLzoDvbC0AMFrYjCQuM5XRSK2E+pIJFrKmecFtx
	 MkQqoHcGOk+ifx2b49NaM3dNoZKuy2mueZSjTEMHoXys88a7CBpdMUeFm1so8fBKXp
	 NlnAqlk+Irx37zYyTfDIEXdUo2mGCHeYwRjg3/dN6xrxcMCCRoY9q5PBtyuRyQ98Ka
	 o7qYd3npaRvELjjjbAYb8J9NiGGn+czeyJzpi8JySVAUnRsUJXajdumB7Z5rApfyUg
	 Ssxx7UzmMVOj6zVjx4DGQF2hcdldH2TXdXUerC79K+XispJ8+JiVt5om8a9bBFx9h2
	 9ymtQI3yZoL1g==
Date: Fri, 2 Feb 2024 12:45:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 31/34] block: use file->f_op to indicate restricted
 writes
Message-ID: <20240202-umworben-hausdach-0d23c6b08f35@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org>
 <20240201110858.on47ef4cmp23jhcv@quack3>
 <20240201-lauwarm-kurswechsel-75ed33e41ba2@brauner>
 <20240201173631.pda5jvi573hevpil@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="t5hmy42akisw67af"
Content-Disposition: inline
In-Reply-To: <20240201173631.pda5jvi573hevpil@quack3>


--t5hmy42akisw67af
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Feb 01, 2024 at 06:36:31PM +0100, Jan Kara wrote:
> On Thu 01-02-24 17:16:02, Christian Brauner wrote:
> > On Thu, Feb 01, 2024 at 12:08:58PM +0100, Jan Kara wrote:
> > > On Tue 23-01-24 14:26:48, Christian Brauner wrote:
> > > > Make it possible to detected a block device that was opened with
> > > > restricted write access solely based on its file operations that it was
> > > > opened with. This avoids wasting an FMODE_* flag.
> > > > 
> > > > def_blk_fops isn't needed to check whether something is a block device
> > > > checking the inode type is enough for that. And def_blk_fops_restricted
> > > > can be kept private to the block layer.
> > > > 
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > 
> > > I don't think we need def_blk_fops_restricted. If we have BLK_OPEN_WRITE
> > > file against a bdev with bdev_writes_blocked() == true, we are sure this is
> > > the handle blocking other writes so we can unblock them in
> > > bdev_yield_write_access()...
> 
> ...
> 
> > -       if (mode & BLK_OPEN_RESTRICT_WRITES)
> > +       if (mode & BLK_OPEN_WRITE) {
> > +               if (bdev_writes_blocked(bdev))
> > +                       bdev_unblock_writes(bdev);
> > +               else
> > +                       bdev->bd_writers--;
> > +       }
> > +       if (bdev_file->f_op == &def_blk_fops_restricted)
> 
> Uh, why are you leaving def_blk_fops_restricted check here? I'd expect you
> can delete def_blk_fops_restricted completely...

Copy-paste error when dumping this into here. Here's the full patch.

--t5hmy42akisw67af
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-block-don-t-rely-on-BLK_OPEN_RESTRICT_WRITES-when-yi.patch"

From 25609e947674d2c24fb18edd0dabb5a49f27f23d Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 23 Jan 2024 14:26:48 +0100
Subject: [PATCH] block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding
 write access

Make it possible to detected a block device that was opened with
restricted write access based only on BLK_OPEN_WRITE and
bdev->bd_writers < 0 so we won't have to claim another FMODE_* flag.

Link: https://lore.kernel.org/r/20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org
base-commit: 0bd1bf95a554f5f877724c27dbe33d4db0af4d0c
change-id: 20240129-vfs-bdev-file-bd_inode-385a56c57a51
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 9be8c3c683ae..b19cbcd6a4bf 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -799,16 +799,21 @@ static void bdev_claim_write_access(struct block_device *bdev, blk_mode_t mode)
 		bdev->bd_writers++;
 }
 
-static void bdev_yield_write_access(struct block_device *bdev, blk_mode_t mode)
+static void bdev_yield_write_access(struct file *bdev_file, blk_mode_t mode)
 {
+	struct block_device *bdev;
+
 	if (bdev_allow_write_mounted)
 		return;
 
+	bdev = file_bdev(bdev_file);
 	/* Yield exclusive or shared write access. */
-	if (mode & BLK_OPEN_RESTRICT_WRITES)
-		bdev_unblock_writes(bdev);
-	else if (mode & BLK_OPEN_WRITE)
-		bdev->bd_writers--;
+	if (mode & BLK_OPEN_WRITE) {
+		if (bdev_writes_blocked(bdev))
+			bdev_unblock_writes(bdev);
+		else
+			bdev->bd_writers--;
+	}
 }
 
 /**
@@ -1020,7 +1025,7 @@ void bdev_release(struct file *bdev_file)
 		sync_blockdev(bdev);
 
 	mutex_lock(&disk->open_mutex);
-	bdev_yield_write_access(bdev, handle->mode);
+	bdev_yield_write_access(bdev_file, handle->mode);
 
 	if (handle->holder)
 		bd_end_claim(bdev, handle->holder);
-- 
2.43.0


--t5hmy42akisw67af--

