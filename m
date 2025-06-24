Return-Path: <linux-fsdevel+bounces-52708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C8EAE5F8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EED164888
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1904D25C812;
	Tue, 24 Jun 2025 08:36:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87025BEE4;
	Tue, 24 Jun 2025 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754165; cv=none; b=ldbg9SRsPiCHn7/GdM6askD1YAUIOd2scucDGaFTLnlga4pbUeJzYEocs/O/iZ6rL83HptU7E8lstkAPxFoXNvfS1nIFraJ9KBGeZa9iv3ujB4O9BOh3ac+tuy4SWnePhzhMP+xzZBq0y4qJyOlNWQs3JISouTiYAY5wv9zdF2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754165; c=relaxed/simple;
	bh=AsKoLMZ/WvJhIazGIaFnedNRQspryth34tPxyNZTGZE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yyhw836D4pTsrCLw7fMi+n3vVRTXeINi+V6AHlk+rMp/zhRMEly2a1sShiC1NODno0dlCyrsQz739Pr3zILDwg0OQfIV3j9IOZqMYxhPmopmhLaMogpfKhdFO431ysuFbm44Iy7TcaXGY8G5Wo9EaQszUMH1VOZGeDgLsSLxyW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst086.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 24 Jun
 2025 11:35:37 +0300
From: Dmitriy Privalov <d.privalov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Dmitriy Privalov <d.privalov@omp.ru>, Miklos Szeredi <miklos@szeredi.hu>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH v2 5.10/5.15 1/3] fuse: move fuse_invalidate_attr() into fuse_update_ctime()
Date: Tue, 24 Jun 2025 11:35:10 +0300
Message-ID: <20250624083512.1386802-1-d.privalov@omp.ru>
X-Mailer: git-send-email 2.34.1
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

commit 371e8fd02969383204b1f6023451125dbc20dfbd upstream.

Logically it belongs there since attributes are invalidated due to the
updated ctime.  This is a cleanup and should not change behavior.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Dmitriy Privalov <d.privalov@omp.ru>
---
v2: Add 371e8fd02969 and cefd1b83275d to backport

 fs/fuse/dir.c   |  9 ++-------
 fs/fuse/xattr.c | 10 ++++------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4488a53a192d..38c3bc68d080 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -809,6 +809,7 @@ void fuse_flush_time_update(struct inode *inode)
 
 void fuse_update_ctime(struct inode *inode)
 {
+	fuse_invalidate_attr(inode);
 	if (!IS_NOCMTIME(inode)) {
 		inode->i_ctime = current_time(inode);
 		mark_inode_dirty_sync(inode);
@@ -846,7 +847,6 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 		if (inode->i_nlink > 0)
 			drop_nlink(inode);
 		spin_unlock(&fi->lock);
-		fuse_invalidate_attr(inode);
 		fuse_dir_changed(dir);
 		fuse_invalidate_entry_cache(entry);
 		fuse_update_ctime(inode);
@@ -903,13 +903,10 @@ static int fuse_rename_common(struct inode *olddir, struct dentry *oldent,
 	err = fuse_simple_request(fm, &args);
 	if (!err) {
 		/* ctime changes */
-		fuse_invalidate_attr(d_inode(oldent));
 		fuse_update_ctime(d_inode(oldent));
 
-		if (flags & RENAME_EXCHANGE) {
-			fuse_invalidate_attr(d_inode(newent));
+		if (flags & RENAME_EXCHANGE)
 			fuse_update_ctime(d_inode(newent));
-		}
 
 		fuse_dir_changed(olddir);
 		if (olddir != newdir)
@@ -917,7 +914,6 @@ static int fuse_rename_common(struct inode *olddir, struct dentry *oldent,
 
 		/* newent will end up negative */
 		if (!(flags & RENAME_EXCHANGE) && d_really_is_positive(newent)) {
-			fuse_invalidate_attr(d_inode(newent));
 			fuse_invalidate_entry_cache(newent);
 			fuse_update_ctime(d_inode(newent));
 		}
@@ -1000,7 +996,6 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 		if (likely(inode->i_nlink < UINT_MAX))
 			inc_nlink(inode);
 		spin_unlock(&fi->lock);
-		fuse_invalidate_attr(inode);
 		fuse_update_ctime(inode);
 	} else if (err == -EINTR) {
 		fuse_invalidate_attr(inode);
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 314e460ce679..27d7ea5e4176 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -39,10 +39,9 @@ int fuse_setxattr(struct inode *inode, const char *name, const void *value,
 		fm->fc->no_setxattr = 1;
 		err = -EOPNOTSUPP;
 	}
-	if (!err) {
-		fuse_invalidate_attr(inode);
+	if (!err)
 		fuse_update_ctime(inode);
-	}
+
 	return err;
 }
 
@@ -170,10 +169,9 @@ int fuse_removexattr(struct inode *inode, const char *name)
 		fm->fc->no_removexattr = 1;
 		err = -EOPNOTSUPP;
 	}
-	if (!err) {
-		fuse_invalidate_attr(inode);
+	if (!err)
 		fuse_update_ctime(inode);
-	}
+
 	return err;
 }
 
-- 
2.34.1


