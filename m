Return-Path: <linux-fsdevel+bounces-59304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF44CB371CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 19:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF183B0858
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445832F291D;
	Tue, 26 Aug 2025 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vKw9VswP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6E2F2909
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230906; cv=none; b=b2aeckdlpFZnJbBiGhui0EwC4Ql8q/ATI2iAPBtAh+vw0zukXyogrr8u1uKLMWkNercmq5b/nX0Vkl5ig++/RqCW66IkoQYwH/aBh1wH1h9cBDTC+SfnUPOgpf2hWasbJyBogdpHKMJM71vu7yW7GpfxftgYEVbZdWip4dqtYWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230906; c=relaxed/simple;
	bh=FgwVYFGo1/rfIhHINSgG9EPeemKxkdiMmXV1A3j3F3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfMqwoVyD4MVOKky1HweIGt8TSGIreKM0sC7IyiQCeCsLQ1KH/d+tVHX9plO9GYgjAxZmrj/i9O3QAlyFI9XaDnV+lSV9Uq+pwf0a103BtwjF+bEWagatz1fRvn12MPNopeDD8U/ArHnPse/v7GOJHt+azKV/IxUtrZN0UloDZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vKw9VswP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g124MMY6JsYeXenn+n5YFsQWIiZPUgQhqXLTHtwHBHk=; b=vKw9VswPByrtYLW3sjC77rN424
	tjFajv9b24lbntHckJ19WZBys/UtHgTt6SwQvD2hNbYyQdi+PwwI4isCt2dJlCCGiU5K7dQQG0gZ3
	dKAVPSuAx+zxl3xUMaDqVXSH4D5LGzOlGXXAnJKFzuEzk+JT+MF6sAyliYtCf3FDqai6a4Rw8WD3d
	ro9VNi+xtWNmzBEUwsoLCLu+4+/6OPtMmdHQTPFBZ1ApGMXefP/nicCnkD4onLYx43detGfoPuj/G
	70/dmzCK/M5kP/5wtdvJ3Ba/EWIqB+bsFecLu5eHvMoqcdHcsXTJDqj5CmKm7dNPiVedUki+5dE5k
	JbiAUUCg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqxsr-00000003f96-2qAW;
	Tue, 26 Aug 2025 17:55:01 +0000
Date: Tue, 26 Aug 2025 18:55:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 25/52] do_new_mount_rc(): use __free() to deal with
 dropping mnt on failure
Message-ID: <20250826175501.GU39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-25-viro@zeniv.linux.org.uk>
 <20250825-zugute-verkohlen-945073b3851f@brauner>
 <20250825160939.GL39973@ZenIV>
 <20250826-kronleuchter-vortag-af3c087ae46a@brauner>
 <20250826170044.GT39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826170044.GT39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 26, 2025 at 06:00:44PM +0100, Al Viro wrote:

> FWIW, I wonder if the things would be cleaner if we did security_sb_kern_mount()
> and mount_too_revealing() *after* unlocking the superblock and getting a vfsmount.
> The latter definitely doesn't give a damn about superblock being locked and
> AFAICS neither does the only in-tree instance of ->sb_kern_mount().
> That way we have the real initialization reasonably close to __free() and
> control flow is easier to follow...

Or, better yet, take vfs_get_tree() from do_new_mount() to do_new_mount_fc()
and collapse it with "unlock ->s_umount and call vfs_create_mount()" into
a call of fc_mount(), like the delta below (on top of posted queue, would get reordered
ealier in it and pick the bits of #25 along the way).

Does anyone have objections here?  The only real change is that security_sb_kern_mount()
gets called outside of ->s_umount exclusive scope; no in-tree instances care, but I'd
Cc that to LSM list...

diff --git a/fs/namespace.c b/fs/namespace.c
index 63b74d7384fd..6f062dc7f9bf 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3690,22 +3690,18 @@ static int do_new_mount_fc(struct fs_context *fc, const struct path *mountpoint,
 			   unsigned int mnt_flags)
 {
 	struct super_block *sb = fc->root->d_sb;
+	struct vfsmount *mnt __free(mntput) = fc_mount(fc);
 	int error;
 
-	error = security_sb_kern_mount(sb);
-	if (!error && mount_too_revealing(sb, &mnt_flags))
-		error = -EPERM;
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
 
-	if (unlikely(error)) {
-		fc_drop_locked(fc);
+	error = security_sb_kern_mount(sb);
+	if (unlikely(error))
 		return error;
-	}
 
-	up_write(&sb->s_umount);
-
-	struct vfsmount *mnt __free(mntput) = vfs_create_mount(fc);
-	if (IS_ERR(mnt))
-		return PTR_ERR(mnt);
+	if (mount_too_revealing(sb, &mnt_flags))
+		return -EPERM;
 
 	mnt_warn_timestamp_expiry(mountpoint, mnt);
 
@@ -3767,8 +3763,6 @@ static int do_new_mount(const struct path *path, const char *fstype,
 		err = parse_monolithic_mount_data(fc, data);
 	if (!err && !mount_capable(fc))
 		err = -EPERM;
-	if (!err)
-		err = vfs_get_tree(fc);
 	if (!err)
 		err = do_new_mount_fc(fc, path, mnt_flags);
 

