Return-Path: <linux-fsdevel+bounces-52710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AC4AE5F8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA22B189DEFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B330925E823;
	Tue, 24 Jun 2025 08:36:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02125D8E9;
	Tue, 24 Jun 2025 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754172; cv=none; b=NPn00nxBGMF1p8/6Ow7iFrFJgyotOmCJg7fGUpgwpqThIeXuUlKfGDtqIPK2Rnp5mx91bbHJPQByFQ1uyw01Ce8p6ghmuccjBU7tdgGO36aLjQTtwrTy7KfwriSsa7Ba+T4QK/6ZieisqNFkr3I+EgD/wlRsw+a4ypD9Ep0+PeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754172; c=relaxed/simple;
	bh=Nx9IrRPwmqoCPc33na9M+Lr3g/VXJl7D7gv1DWymz98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bF2FklsQJxHusQWSCjhdnHdDvrFmzf8RLUNKZVrvy/xmxJiBKBSSr/HmONhwfQvf7G4+EPTvHRUI45k54uXAQIX8TGg4r+Lb9fjh2OcgoK1Hl8Mt5/UEaf36d6yJJNmLLDoXyh1RAvS/aQG92b+CHlT8K1kAK9QBFF6aLgPRNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst086.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 24 Jun
 2025 11:35:58 +0300
From: Dmitriy Privalov <d.privalov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Dmitriy Privalov <d.privalov@omp.ru>, Miklos Szeredi <miklos@szeredi.hu>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH v2 5.10/5.15 3/3] fuse: don't increment nlink in link()
Date: Tue, 24 Jun 2025 11:35:12 +0300
Message-ID: <20250624083512.1386802-3-d.privalov@omp.ru>
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
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.22.207.138:7.1.2;inp1wst086.omp.ru:7.1.1
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

commit 97f044f690bac2b094bfb7fb2d177ef946c85880 upstream.

The fuse_iget() call in create_new_entry() already updated the inode with
all the new attributes and incremented the attribute version.

Incrementing the nlink will result in the wrong count.  This wasn't noticed
because the attributes were invalidated right after this.

Updating ctime is still needed for the writeback case when the ctime is not
refreshed.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Dmitriy Privalov <d.privalov@omp.ru>
---
v2: Add 371e8fd02969 and cefd1b83275d to backport

 fs/fuse/dir.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f8b444674c14..08ede7f7d8dc 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -807,9 +807,8 @@ void fuse_flush_time_update(struct inode *inode)
 	mapping_set_error(inode->i_mapping, err);
 }
 
-void fuse_update_ctime(struct inode *inode)
+static void fuse_update_ctime_in_cache(struct inode *inode)
 {
-	fuse_invalidate_attr(inode);
 	if (!IS_NOCMTIME(inode)) {
 		inode->i_ctime = current_time(inode);
 		mark_inode_dirty_sync(inode);
@@ -817,6 +816,12 @@ void fuse_update_ctime(struct inode *inode)
 	}
 }
 
+void fuse_update_ctime(struct inode *inode)
+{
+	fuse_invalidate_attr(inode);
+	fuse_update_ctime_in_cache(inode);
+}
+
 static void fuse_entry_unlinked(struct dentry *entry)
 {
 	struct inode *inode = d_inode(entry);
@@ -987,24 +992,11 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	args.in_args[1].size = newent->d_name.len + 1;
 	args.in_args[1].value = newent->d_name.name;
 	err = create_new_entry(fm, &args, newdir, newent, inode->i_mode);
-	/* Contrary to "normal" filesystems it can happen that link
-	   makes two "logical" inodes point to the same "physical"
-	   inode.  We invalidate the attributes of the old one, so it
-	   will reflect changes in the backing inode (link count,
-	   etc.)
-	*/
-	if (!err) {
-		struct fuse_inode *fi = get_fuse_inode(inode);
-
-		spin_lock(&fi->lock);
-		fi->attr_version = atomic64_inc_return(&fm->fc->attr_version);
-		if (likely(inode->i_nlink < UINT_MAX))
-			inc_nlink(inode);
-		spin_unlock(&fi->lock);
-		fuse_update_ctime(inode);
-	} else if (err == -EINTR) {
+	if (!err)
+		fuse_update_ctime_in_cache(inode);
+	else if (err == -EINTR)
 		fuse_invalidate_attr(inode);
-	}
+
 	return err;
 }
 
-- 
2.34.1


