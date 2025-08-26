Return-Path: <linux-fsdevel+bounces-59298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD218B370D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 19:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A27344E1150
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C625B2E1751;
	Tue, 26 Aug 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dGy2awW1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ADA2E1C6B
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227649; cv=none; b=p6dGibi0YPa0eKRKZVhhnt+3I7thq8T2R6G69KvaOGE1xJzBrZFN0NktPJh8NQnvKUiGM7YiisajymuSfYztHhwqcJsqI04A5ybaxf9OCnqX4IiaXPL5TlyaVxJXXmpVIBhXRdX4dpMm5q82Bwnh28+FnW84BzmpKqoSRDiJG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227649; c=relaxed/simple;
	bh=CZoT3WwYG8/WatQvcMIuac5Eho2eM/0lU6Bz3kN1luo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqq0eetgL0WuH/OJzQDL6On3Pg4iUKJ+BO2yozOeSg8M3C1FxW27jtwUQhfSh0iVKmn/EQ1GeKUr5uhiKI338DxEbiLkslN18VUB137QNRzm9yX8teuIdm8UctgOwaeQfoL89q7la/7oK5UeARksNcpO1731NQrjDEEKGBOIo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dGy2awW1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ryOu/ScWQW2Fh/AKwjl9NL1eGXjISkuFw7vMk0OR+QY=; b=dGy2awW1nd/vKJ1cZbsWhNmdLb
	PBpNy+C/ma3Rmj/ekbux3uFmnjtqF/bhPmTCeAaUHnB9uBmNXFKQ4j1N+EM2xmRt4/+RG+e0XtHE8
	gt5sPewXAXYMu/0FY05huwgubFL4OX4O/Gq+sOs0nqh1/0QpkcI5YclRz826qi6TQasATDHQ0NlD3
	VvDwsBWyaR353Udax+OzLN/zgl4tnSf8vSwLATTt4OaQ6c2VKWC76Feqd3xq+Ue0sWnVMlrUz+pwX
	nrThbxR7PugsKQb9HrjuFrSOI1yU6Mm08lX6X7M/vLW3ApBZ7ZtnT7QEEm9Yz8CRTowxalJjMtMIF
	BpDWgBKg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqx2K-00000002nJ6-1WGS;
	Tue, 26 Aug 2025 17:00:44 +0000
Date: Tue, 26 Aug 2025 18:00:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 25/52] do_new_mount_rc(): use __free() to deal with
 dropping mnt on failure
Message-ID: <20250826170044.GT39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-25-viro@zeniv.linux.org.uk>
 <20250825-zugute-verkohlen-945073b3851f@brauner>
 <20250825160939.GL39973@ZenIV>
 <20250826-kronleuchter-vortag-af3c087ae46a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-kronleuchter-vortag-af3c087ae46a@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 26, 2025 at 10:27:56AM +0200, Christian Brauner wrote:

> > Declaring it above, initializing with NULL and reassigning here?
> > That's actually just as wrong, if not more so - any assignment added
> 
> I disagree. I do very much prefer having cleanups at the top of the
> function or e.g.,:
> 
> if (foo) {
> 	struct vfsmount *mnt __free(mntput) = vfs_create_mount(fc);
> }
> 
> Because it is really easy to figure out visually. But just doing it
> somewhere in the middle is just confusing.

So basically you treat __free() simply as a syntax sugar for "call this
on exits from this block", rather than an approximation for "here's an
auto object we've created, this should be called to destroy it at the
end of its scope/lifetime"?

IMO it's a bad practice - it makes life much harder when you are tracing
callchains, etc.

FWIW, I wonder if the things would be cleaner if we did security_sb_kern_mount()
and mount_too_revealing() *after* unlocking the superblock and getting a vfsmount.
The latter definitely doesn't give a damn about superblock being locked and
AFAICS neither does the only in-tree instance of ->sb_kern_mount().
That way we have the real initialization reasonably close to __free() and
control flow is easier to follow...

Folks, how about something like the delta below (on top of the posted queue)?

diff --git a/fs/namespace.c b/fs/namespace.c
index 63b74d7384fd..191e7f776de5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3689,24 +3689,22 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
 static int do_new_mount_fc(struct fs_context *fc, const struct path *mountpoint,
 			   unsigned int mnt_flags)
 {
+	struct vfsmount *mnt __free(mntput) = NULL;
 	struct super_block *sb = fc->root->d_sb;
 	int error;
 
-	error = security_sb_kern_mount(sb);
-	if (!error && mount_too_revealing(sb, &mnt_flags))
-		error = -EPERM;
-
-	if (unlikely(error)) {
-		fc_drop_locked(fc);
-		return error;
-	}
-
 	up_write(&sb->s_umount);
-
-	struct vfsmount *mnt __free(mntput) = vfs_create_mount(fc);
+	mnt = vfs_create_mount(fc);
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
+	error = security_sb_kern_mount(sb);
+	if (unlikely(error))
+		return error;
+
+	if (mount_too_revealing(sb, &mnt_flags))
+		return -EPERM;
+
 	mnt_warn_timestamp_expiry(mountpoint, mnt);
 
 	LOCK_MOUNT(mp, mountpoint);

