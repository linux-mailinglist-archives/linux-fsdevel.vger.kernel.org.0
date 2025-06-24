Return-Path: <linux-fsdevel+bounces-52709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEDFAE5F89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6535F189EAA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37AF25BF04;
	Tue, 24 Jun 2025 08:36:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F387725D533;
	Tue, 24 Jun 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754169; cv=none; b=LH528jYdjUMYOsmyW7F/U5MJbGHN5PJ8EStOQvFGbJJaQ7YUUfIW5e3GFXjbnMRk0JfH7fjBkVMzOjrxNjsNd+/gPLr57im38Wo6Blk2xxQtU4U1Ne+1sX9xQOlgkfJHBEF4zbECEFL2bItKXEKp1OKgUQL1cJwRWRcutwBg//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754169; c=relaxed/simple;
	bh=lI/PzXGE5RPQLgIblmgMb0JMWh9X+ANEixjylYaPuqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRXz7wpSa/zRwVz14DxIFBykONfsepsjgrd2xEnSPc5ooPShagBLrbu/Jxuivl7WJSLfBGm1oIfpQWkCCvUtGAzzHY+xJPxkQqgmcd+Nhgos0yQ4qTBVgCyGBpILaCwO+ld16hMXa8EyBvvjbvOxD3nzUxWxzQuRkRSEUEVkin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst086.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 24 Jun
 2025 11:35:48 +0300
From: Dmitriy Privalov <d.privalov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Dmitriy Privalov <d.privalov@omp.ru>, Miklos Szeredi <miklos@szeredi.hu>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH v2 5.10/5.15 2/3] fuse: decrement nlink on overwriting rename
Date: Tue, 24 Jun 2025 11:35:11 +0300
Message-ID: <20250624083512.1386802-2-d.privalov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624083512.1386802-1-d.privalov@omp.ru>
References: <20250624083512.1386802-1-d.privalov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 06/24/2025 08:21:21
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194289 [Jun 24 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: d.privalov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 62 0.3.62
 e2af3448995f5f8a7fe71abf21bb23519d0f38c3
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;inp1wst086.omp.ru:7.1.1;81.22.207.138:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/24/2025 08:23:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/24/2025 7:08:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: Miklos Szeredi <mszeredi@redhat.com>

commit cefd1b83275d4c587bdeb2fe7aed07908642f875 upstream.

Rename didn't decrement/clear nlink on overwritten target inode.

Create a common helper fuse_entry_unlinked() that handles this for unlink,
rmdir and rename.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Dmitriy Privalov <d.privalov@omp.ru>
---
v2: Add 371e8fd02969 and cefd1b83275d to backport

 fs/fuse/dir.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 38c3bc68d080..f8b444674c14 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -817,6 +817,29 @@ void fuse_update_ctime(struct inode *inode)
 	}
 }
 
+static void fuse_entry_unlinked(struct dentry *entry)
+{
+	struct inode *inode = d_inode(entry);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	spin_lock(&fi->lock);
+	fi->attr_version = atomic64_inc_return(&fc->attr_version);
+	/*
+	 * If i_nlink == 0 then unlink doesn't make sense, yet this can
+	 * happen if userspace filesystem is careless.  It would be
+	 * difficult to enforce correct nlink usage so just ignore this
+	 * condition here
+	 */
+	if (S_ISDIR(inode->i_mode))
+		clear_nlink(inode);
+	else if (inode->i_nlink > 0)
+		drop_nlink(inode);
+	spin_unlock(&fi->lock);
+	fuse_invalidate_entry_cache(entry);
+	fuse_update_ctime(inode);
+}
+
 static int fuse_unlink(struct inode *dir, struct dentry *entry)
 {
 	int err;
@@ -833,23 +856,8 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 	args.in_args[0].value = entry->d_name.name;
 	err = fuse_simple_request(fm, &args);
 	if (!err) {
-		struct inode *inode = d_inode(entry);
-		struct fuse_inode *fi = get_fuse_inode(inode);
-
-		spin_lock(&fi->lock);
-		fi->attr_version = atomic64_inc_return(&fm->fc->attr_version);
-		/*
-		 * If i_nlink == 0 then unlink doesn't make sense, yet this can
-		 * happen if userspace filesystem is careless.  It would be
-		 * difficult to enforce correct nlink usage so just ignore this
-		 * condition here
-		 */
-		if (inode->i_nlink > 0)
-			drop_nlink(inode);
-		spin_unlock(&fi->lock);
 		fuse_dir_changed(dir);
-		fuse_invalidate_entry_cache(entry);
-		fuse_update_ctime(inode);
+		fuse_entry_unlinked(entry);
 	} else if (err == -EINTR)
 		fuse_invalidate_entry(entry);
 	return err;
@@ -871,9 +879,8 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	args.in_args[0].value = entry->d_name.name;
 	err = fuse_simple_request(fm, &args);
 	if (!err) {
-		clear_nlink(d_inode(entry));
 		fuse_dir_changed(dir);
-		fuse_invalidate_entry_cache(entry);
+		fuse_entry_unlinked(entry);
 	} else if (err == -EINTR)
 		fuse_invalidate_entry(entry);
 	return err;
@@ -913,10 +920,8 @@ static int fuse_rename_common(struct inode *olddir, struct dentry *oldent,
 			fuse_dir_changed(newdir);
 
 		/* newent will end up negative */
-		if (!(flags & RENAME_EXCHANGE) && d_really_is_positive(newent)) {
-			fuse_invalidate_entry_cache(newent);
-			fuse_update_ctime(d_inode(newent));
-		}
+		if (!(flags & RENAME_EXCHANGE) && d_really_is_positive(newent))
+			fuse_entry_unlinked(newent);
 	} else if (err == -EINTR) {
 		/* If request was interrupted, DEITY only knows if the
 		   rename actually took place.  If the invalidation
-- 
2.34.1


