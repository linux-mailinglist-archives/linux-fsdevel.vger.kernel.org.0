Return-Path: <linux-fsdevel+bounces-19329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DAB8C3331
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 20:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5411C20BEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 18:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992031CAAE;
	Sat, 11 May 2024 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MXAynJBX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCFF1C6A1
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715452139; cv=none; b=dlQiR+CZOqqeq4ZGMlaInkZFNQqCJZiyd2Ru22PileBwYIF159+y+ytBldUAUWA/VI5SUZgAhirhzO5xF2G2Ys9LrUg7Ro6uhfJJ/E64CuwdrkdTuKftnpacDjKzlz+UKxYjYhqmR/I54iBCOk+pKbQB7/GGA+0tl8qRUQWP7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715452139; c=relaxed/simple;
	bh=eibUAkxq9Kt47etAreK1wtQN+pHMRG6FwGI3Py3WZNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3YJUnx6IAvn+8c3oLlJCcgZbeAWSPJOHddcoEBobCHuOPw6xwzgEtB8MtraLum/0/U1lC5Dwu8/zAPO/i9DXZuikH2TCaG6LzpUtvMKxdaFfMgby6DRWLTIWyy4mP5GsNcAfihtSp/VKtNpOeXiGeTnbvF/pBwSslTFJKvbkAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MXAynJBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EA1C2BBFC;
	Sat, 11 May 2024 18:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715452138;
	bh=eibUAkxq9Kt47etAreK1wtQN+pHMRG6FwGI3Py3WZNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MXAynJBXh0BtAHfYKRa+ZEV2ACC/UuVzdNPgV4Nkax7f1agQxQSzGzEC9sSU+Kk8/
	 Hkmh75LXvq9kdHh6YDlMf0yGaLZ4w6vXRqH8p0yQItIdsWdGFKxZRSdG/XEPTNMYL1
	 nabVMuSk4kOLlUKbuX8tMuTXlqYvx/0+nkJSJWO0=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	laoar.shao@gmail.com,
	linux-fsdevel@vger.kernel.org,
	longman@redhat.com,
	viro@zeniv.linux.org.uk,
	walters@verbum.org,
	wangkai86@huawei.com,
	willy@infradead.org
Subject: [PATCH] vfs: move dentry shrinking outside the inode lock in 'rmdir()'
Date: Sat, 11 May 2024 11:26:26 -0700
Message-ID: <20240511182625.6717-2-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.44.0.330.g4d18c88175
In-Reply-To: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yafang Shao reports that he has seen loads that generate billions of
negative dentries in a directory, which then when the directory is
removed causes excessive latencies for other users because the dentry
shrinking is done under the directory inode lock.

There seems to be no actual reason for holding the inode lock any more
by the time we get rid of the now uninteresting negative dentries, and
it's an effect of just code layout (the shared error path).

Reorganize the code trivially to just have a separate success path,
which simplifies the code (since 'd_delete_notify()' is only called in
the success path anyway) and makes it trivial to just move the dentry
shrinking outside the inode lock.

Reported-by: Yafang Shao <laoar.shao@gmail.com>
Link: https://lore.kernel.org/all/20240511022729.35144-1-laoar.shao@gmail.com/
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Waiman Long <longman@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Ok, this is the same patch, just with a commit message.  And I actually
am running a kernel with that patch, so it compiles and boots.

Very limited testing: I created a directory with ten million negative
dentries, and then did a "rmdir" in one terminal window while doing a
"ls" inside that directory in another to kind of reproduce (on a smaller
scale) what Yafang was reporting. 

The "ls" was not affected at all.  But honestly, this was *ONE* single
trivial test, so it's almost completely worthless. 

 fs/namei.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 28e62238346e..474b1ee3266d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4217,16 +4217,19 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto out;
 
-	shrink_dcache_parent(dentry);
 	dentry->d_inode->i_flags |= S_DEAD;
 	dont_mount(dentry);
 	detach_mounts(dentry);
+	inode_unlock(dentry->d_inode);
+
+	shrink_dcache_parent(dentry);
+	dput(dentry);
+	d_delete_notify(dir, dentry);
+	return 0;
 
 out:
 	inode_unlock(dentry->d_inode);
 	dput(dentry);
-	if (!error)
-		d_delete_notify(dir, dentry);
 	return error;
 }
 EXPORT_SYMBOL(vfs_rmdir);
-- 
2.44.0.330.g4d18c88175


