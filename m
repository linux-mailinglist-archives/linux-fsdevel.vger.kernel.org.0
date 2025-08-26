Return-Path: <linux-fsdevel+bounces-59250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DF4B36E4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987B28E361C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8988035E4DA;
	Tue, 26 Aug 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Yeu5pdjD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5B835AADE
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222878; cv=none; b=hvkXkdUawLWvqjhaa4xfw7T5G7iMVEOUZolUe+Fl7C6wbD68c4a1EfCrqgtixPWNS7M9bCHKKtHr+GLnicOD0H3qNcc09cA+Qx2PcECvT7Z6ykyHgW1Xb6HhULYT2mdp0RAsiq0wVclZEVk48srYgDhC/DlyFfKnwr0L0LvqXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222878; c=relaxed/simple;
	bh=vkTzvz/W4398BCzhJaUNVJSxSUNoVuE4vBSu4sXgDQw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDLavNCl5L9C0Clg7oDO5jcJRfxsZWpJCPFuukWkI0b2yKTL8377F6zTmwTPEVOnRMmpIuMDl6OciOIAes180svC8j8pyPwTydMWL1zPIH0wvISuOjFD+4EZvgCgiqD2wIR3x+G+PzSqAx7V7Q0dEYZbaKKyN/d4yQ/PIamxiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Yeu5pdjD; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d603a269cso43795607b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222873; x=1756827673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJd+d9fGr0UltZkVFy/kO4XbRfY+EPSOK7xeYoY5Vpg=;
        b=Yeu5pdjDdDX9sHhysQ1uSJhmFzwnWWdYneDhpIHE6blybPIZRfQTXo5SU3l+pDSYDB
         deev64xwgAsUwrfusk/Zhyi88tS8CvC0eAemJJNGynrVRUzRZnyUK+H3Is976l4hzDy2
         B4FpvkWLxJ7cc8uLr6oMdazKVSMRfuoyoq45lfRQF3BoUfyZVbWoB+MUL/jNPvEsuwxL
         4/xRSLy1/8DRgS1U+F3nudj0vZYXb9V4bezeMEYQUF5ZVlwjC4450Au6Dl0LZdt/Jrwn
         sSvN33peHmP8XfwmWo2XvohOJNo6UhDGzqg5Zqy/WbFCdbDyde1CvOkEv5BAjol+m6nX
         +ffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222873; x=1756827673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJd+d9fGr0UltZkVFy/kO4XbRfY+EPSOK7xeYoY5Vpg=;
        b=dQ8DsYs6314eR4WNlx+BPt+upNb6PqF7W4O6pNZUvt6cNuPmyLyhE0dtOT3KMq120w
         7M9XriqSqcXrg8FMdrWnkRv1DgSLj1JB/UJuhcpjU49zPZ7NPgXGOiFA7Nhp74nY29w9
         jSVaumVey0+iq6x3pTJpcP7rXE8N6/2cW0arrbvbOt5s89Ai9C4kgkVCOiq+0BZncn0A
         PDUSTagdDJ9remXcxIEo93l/loJeQ2gZ12oKcByeKrZ7G/qjSSLx1c3q+Xh9B2Qd7XfG
         nbwCQO1NejRJS3ksSNLMA1w5A2yWAREDxd49iLTWqccZ5lQLoyOj9089SMazhQqAht7T
         s6yA==
X-Gm-Message-State: AOJu0Yww6oxIn1GWT9Sv1dwW8gZbcnnQ0GxWrSjkj+V655MZtEwotgKF
	iPfyF4hKDnlZfOezChPfynBfa+WwJgfjpfY4fmJqOE5s0ExIbtOWUrESrW82BGoBZIc8yCfuRng
	dhoEZ
X-Gm-Gg: ASbGncsSog2IivlfD2b/KhshhujEp3aP8BF+1vkTPIoAEEphM7sLSHxA21foStv75wu
	5nCGXZYSRcfqlqgLpy6XSqOFKYLNfMvT51nnIA9Ik3HvsivET9Esq2qQmRtyk8OrzKvcL+RsFs+
	QEJZL+vbV86TnfvxY9BPUbk1bJ0ClWgOw0Dh7SFMg34mNW2C+1EP1rw5LJjxxQOHkIJw49gsUEJ
	uMox4jo5VAZgX40dr72BndLldi6D3zlq/eGpra8GUkmOwMTomWxb54ys6ahlcAUHm6zFHOl/i33
	ntKIiodP1E2aWPyheS4qHc5D86YHgFWXQC4Pybm8jmAT6TT5fEbg5+Vgmjo7Ac5tg5CnhWKfBAC
	MFQ9pHSC+ICc5CzGIJfKOYyf6MCXLYD2rZWHDlt4BnOT0SE+tu6e/3TD1v3Hp6vn17AVvCQ==
X-Google-Smtp-Source: AGHT+IHactrTikZ7jBRDCL1JZgH1mVdSWJ6FyyCGF3S7ZcAICNXpADGqeqy8Nq82lRQHu7tbjtoUGQ==
X-Received: by 2002:a05:690c:6109:b0:71f:b944:1028 with SMTP id 00721157ae682-71fdc537dafmr188258197b3.49.1756222873272;
        Tue, 26 Aug 2025 08:41:13 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7213f47d0b0sm157887b3.72.2025.08.26.08.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 17/54] fs: remove the inode from the LRU list on unlink/rmdir
Date: Tue, 26 Aug 2025 11:39:17 -0400
Message-ID: <3552943716349efa4ff107bb590ac6b980183735.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can end up with an inode on the LRU list or the cached list, then at
some point in the future go to unlink that inode and then still have an
elevated i_count reference for that inode because it is on one of these
lists.

The more common case is the cached list. We open a file, write to it,
truncate some of it which triggers the inode_add_lru code in the
pagecache, adding it to the cached LRU.  Then we unlink this inode, and
it exists until writeback or reclaim kicks in and removes the inode.

To handle this case, delete the inode from the LRU list when it is
unlinked, so we have the best case scenario for immediately freeing the
inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/namei.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 138a693c2346..e56dcb5747e4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4438,6 +4438,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		     struct dentry *dentry)
 {
+	struct inode *inode = dentry->d_inode;
 	int error = may_delete(idmap, dir, dentry, 1);
 
 	if (error)
@@ -4447,11 +4448,11 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		return -EPERM;
 
 	dget(dentry);
-	inode_lock(dentry->d_inode);
+	inode_lock(inode);
 
 	error = -EBUSY;
 	if (is_local_mountpoint(dentry) ||
-	    (dentry->d_inode->i_flags & S_KERNEL_FILE))
+	    (inode->i_flags & S_KERNEL_FILE))
 		goto out;
 
 	error = security_inode_rmdir(dir, dentry);
@@ -4463,12 +4464,21 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 
 	shrink_dcache_parent(dentry);
-	dentry->d_inode->i_flags |= S_DEAD;
+	inode->i_flags |= S_DEAD;
 	dont_mount(dentry);
 	detach_mounts(dentry);
 
 out:
-	inode_unlock(dentry->d_inode);
+	/*
+	 * The inode may be on the LRU list, so delete it from the LRU at this
+	 * point in order to make sure that the inode is freed as soon as
+	 * possible.
+	 */
+	spin_lock(&inode->i_lock);
+	inode_lru_list_del(inode);
+	spin_unlock(&inode->i_lock);
+
+	inode_unlock(inode);
 	dput(dentry);
 	if (!error)
 		d_delete_notify(dir, dentry);
@@ -4653,8 +4663,18 @@ int do_unlinkat(int dfd, struct filename *name)
 		dput(dentry);
 	}
 	inode_unlock(path.dentry->d_inode);
-	if (inode)
+	if (inode) {
+		/*
+		 * The LRU may be holding a reference, remove the inode from the
+		 * LRU here before dropping our hopefully final reference on the
+		 * inode.
+		 */
+		spin_lock(&inode->i_lock);
+		inode_lru_list_del(inode);
+		spin_unlock(&inode->i_lock);
+
 		iput(inode);	/* truncate the inode here */
+	}
 	inode = NULL;
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
-- 
2.49.0


