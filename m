Return-Path: <linux-fsdevel+bounces-23498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A993B92D59C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D925D1C2358E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D6194156;
	Wed, 10 Jul 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eQkzNVQi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3E194A66
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627193; cv=none; b=BirY//anw+k5q9qq0EIKZKE0akqtrRfjJOaxzy3Kqfl6RGlCraOfo7Os7G0XluUXlWZ1f/E18sdMlt71prE0CYJuV7SUHRtGTAfxAKHYQIDRMZZ8mq6GBgy9X0BcsQihuAbpFGprhbxiWMSeZjPljrgEKK3clzUwumJdYrrRACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627193; c=relaxed/simple;
	bh=bIJ59Q4C+RZ4+f+Ky1h8dFOf5LIJv1oyoHIs6aHvns4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNfAzrxlt179FXZBfpaWtvVIBMfaSnbJC7Zsgq85WqQaE9QjrD4i2Jou03VZNG7DPQ6Lpjh7Tmg+eem8XphL/vl8TfnBXRmyWW0tlOtbEm/FUqz80vtljhA4zom7fF3okuyLbaGlxYdEJgsiMa1VCCfOQ3bhs7er/PCvAaSXt9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eQkzNVQi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BvhFm88QHu07JEI7BlrmNTQ9jUnrWSMTnHSYhmtwjQ8=; b=eQkzNVQioOBPOvZZqRQ3f478fd
	2ZvHTiYCcQDyPF/Y5Yuis0Z3BhuQkgYIfPbhv9UKpYb2mwaDt9fZNBMU3rKSW2DydRHoj3uZKcn8c
	EtpFwHOBdvhtH1t7i1qWvZh7jBfI6HhFtAewv50+Bx7WDbKlSnbtXiqT6g7lnMyygMQj0WTD01E+Z
	4gIFc9VC2iHwt19yi44HyU1lVGKdWeGvbM9ZZ4DdE4GyhnoRzpuZQ/SSGbuBgrVMz37XFRbQx/Qcx
	iJoKHa2Kcx3ukT4hzfZv6onzpmwaA+NyHRx9cY2j0GyFk35eRo6rgMA3ouSV20gyHMWLbGDLenqVx
	SVPl7q/g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRZjR-00000009TEJ-083f;
	Wed, 10 Jul 2024 15:59:49 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/6] qnx6: Convert qnx6_find_entry() to qnx6_find_ino()
Date: Wed, 10 Jul 2024 16:59:40 +0100
Message-ID: <20240710155946.2257293-3-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710155946.2257293-1-willy@infradead.org>
References: <20240710155946.2257293-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's hard to return a directory entry from qnx6_find_entry()
because it might be a long dir_entry with a different format.
So stick with the convention of returning an inode number,
but rename it to qnx6_find_ino() to reflect what it actually does,
and move the call to qnx6_put_page() inside the function which
lets us get rid of the res_page parameter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/qnx6/dir.c   | 7 ++-----
 fs/qnx6/namei.c | 4 +---
 fs/qnx6/qnx6.h  | 3 +--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/qnx6/dir.c b/fs/qnx6/dir.c
index bc7f20dda579..daf9a335ba22 100644
--- a/fs/qnx6/dir.c
+++ b/fs/qnx6/dir.c
@@ -213,8 +213,7 @@ static unsigned qnx6_match(struct super_block *s, int len, const char *name,
 }
 
 
-unsigned qnx6_find_entry(int len, struct inode *dir, const char *name,
-			 struct page **res_page)
+unsigned qnx6_find_ino(int len, struct inode *dir, const char *name)
 {
 	struct super_block *s = dir->i_sb;
 	struct qnx6_inode_info *ei = QNX6_I(dir);
@@ -225,8 +224,6 @@ unsigned qnx6_find_entry(int len, struct inode *dir, const char *name,
 	struct qnx6_dir_entry *de;
 	struct qnx6_long_dir_entry *lde;
 
-	*res_page = NULL;
-
 	if (npages == 0)
 		return 0;
 	start = ei->i_dir_start_lookup;
@@ -267,8 +264,8 @@ unsigned qnx6_find_entry(int len, struct inode *dir, const char *name,
 	return 0;
 
 found:
-	*res_page = &folio->page;
 	ei->i_dir_start_lookup = n;
+	qnx6_put_page(&folio->page);
 	return ino;
 }
 
diff --git a/fs/qnx6/namei.c b/fs/qnx6/namei.c
index e2e98e653b8d..0f0755a9ecb5 100644
--- a/fs/qnx6/namei.c
+++ b/fs/qnx6/namei.c
@@ -17,7 +17,6 @@ struct dentry *qnx6_lookup(struct inode *dir, struct dentry *dentry,
 				unsigned int flags)
 {
 	unsigned ino;
-	struct page *page;
 	struct inode *foundinode = NULL;
 	const char *name = dentry->d_name.name;
 	int len = dentry->d_name.len;
@@ -25,10 +24,9 @@ struct dentry *qnx6_lookup(struct inode *dir, struct dentry *dentry,
 	if (len > QNX6_LONG_NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	ino = qnx6_find_entry(len, dir, name, &page);
+	ino = qnx6_find_ino(len, dir, name);
 	if (ino) {
 		foundinode = qnx6_iget(dir->i_sb, ino);
-		qnx6_put_page(page);
 		if (IS_ERR(foundinode))
 			pr_debug("lookup->iget ->  error %ld\n",
 				 PTR_ERR(foundinode));
diff --git a/fs/qnx6/qnx6.h b/fs/qnx6/qnx6.h
index 34a6b126a3a9..43da5f91c3ff 100644
--- a/fs/qnx6/qnx6.h
+++ b/fs/qnx6/qnx6.h
@@ -132,5 +132,4 @@ static inline void qnx6_put_page(struct page *page)
 	put_page(page);
 }
 
-extern unsigned qnx6_find_entry(int len, struct inode *dir, const char *name,
-				struct page **res_page);
+unsigned qnx6_find_ino(int len, struct inode *dir, const char *name);
-- 
2.43.0


