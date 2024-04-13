Return-Path: <linux-fsdevel+bounces-16847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CAA8A3A28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 03:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D382839F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 01:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722C10962;
	Sat, 13 Apr 2024 01:40:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAD2101CA
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712972456; cv=none; b=n5g8n4Y4LjxvRgso86cTMwDvLzf4+ytVvmGxiYNyguMJSWStQMzV0C7+H5K5E0o7J4Z7S2n6WGHGrmKwjs4teAMaQhve8iAMgFceg+fwDmkUr5o7SQsvrNEUFlPbrXtFbHbbICUA4eH/9F7CHuHqxDxRP05+YZPtd128QA3Yrd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712972456; c=relaxed/simple;
	bh=bz0+oPtGBjfMkgGoL8I+HbISwkkff7vifr/1n+scTpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jAfgfjku+rsYI4lsDr+yW5Ha5KD5l+fArg8ivea15BLZrRR13smqH2XTaMtK1S0PH3TZAnDcOahBlmg5qFaHd6IBXEk6A+GEZpuQH21vHqeYRBF9coD7SbMGNXAI0ltbSNfiSuaZzW2l0HizOCtXTzRT/uIdUI8NjZ+mcJGEaMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.22])
	by sina.com (172.16.235.25) with ESMTP
	id 6619E29500006D13; Sat, 13 Apr 2024 09:40:40 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7155934210732
X-SMAIL-UIID: AA27BBA74A44434FB6E7EDF800AF513A-20240413-094040-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
Date: Sat, 13 Apr 2024 09:40:33 +0800
Message-Id: <20240413014033.1722-1-hdanton@sina.com>
In-Reply-To: <00000000000042c9190615cdb315@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 01:11:20 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    6ebf211bb11d Add linux-next specific files for 20240410
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1621af9d180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  6ebf211bb11d

--- x/fs/notify/fsnotify.c
+++ y/fs/notify/fsnotify.c
@@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
 	wait_var_event(fsnotify_sb_watched_objects(sb),
 		       !atomic_long_read(fsnotify_sb_watched_objects(sb)));
 	WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONTENT));
-	WARN_ON(fsnotify_sb_has_priority_watchers(sb,
-						  FSNOTIFY_PRIO_PRE_CONTENT));
+	WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_PRE_CONTENT));
+	synchronize_srcu(&fsnotify_mark_srcu);
 	kfree(sbinfo);
 }
 
@@ -499,7 +499,7 @@ int fsnotify(__u32 mask, const void *dat
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct super_block *sb = fsnotify_data_sb(data, data_type);
-	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
+	struct fsnotify_sb_info *sbinfo;
 	struct fsnotify_iter_info iter_info = {};
 	struct mount *mnt = NULL;
 	struct inode *inode2 = NULL;
@@ -529,6 +529,8 @@ int fsnotify(__u32 mask, const void *dat
 		inode2_type = FSNOTIFY_ITER_TYPE_PARENT;
 	}
 
+	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
+	sbinfo = fsnotify_sb_info(sb);
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
 	 * be expensive.  It protects walking the *_fsnotify_marks lists.
@@ -539,8 +541,10 @@ int fsnotify(__u32 mask, const void *dat
 	if ((!sbinfo || !sbinfo->sb_marks) &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
 	    (!inode || !inode->i_fsnotify_marks) &&
-	    (!inode2 || !inode2->i_fsnotify_marks))
-		return 0;
+	    (!inode2 || !inode2->i_fsnotify_marks)) {
+		ret = 0;
+		goto out;
+	}
 
 	marks_mask = sb->s_fsnotify_mask;
 	if (mnt)
@@ -558,10 +562,10 @@ int fsnotify(__u32 mask, const void *dat
 	 * Otherwise, return if none of the marks care about this type of event.
 	 */
 	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
-	if (!(test_mask & marks_mask))
-		return 0;
-
-	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
+	if (!(test_mask & marks_mask)) {
+		ret = 0;
+		goto out;
+	}
 
 	if (sbinfo) {
 		iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =
--

