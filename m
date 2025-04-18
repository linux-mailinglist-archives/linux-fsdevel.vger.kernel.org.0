Return-Path: <linux-fsdevel+bounces-46666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FABA935E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 12:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32FBB4672A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 10:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B84B270ECA;
	Fri, 18 Apr 2025 10:15:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4382741AE;
	Fri, 18 Apr 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971313; cv=none; b=uSSB2/OR/UY+wfnOOKo6tWg1M4kA+AQ8tZOeqjaJt09nOB/l9EiE8hgNMyhFhbd79jJewESSpc72lOEqYkgxSjOJLk5gmg7C4tXO/g+SGCOVKB4+RicQKCP+aCrs3NKK2x5HIMtewxPNAmnDtcxSbSPneAhTpgNJhyEmmVvFjTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971313; c=relaxed/simple;
	bh=qWN0NjjRcW9BA2sX0INR3SpjPZCsWlki9/tPSA1YspY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq7xmJP46gR4bLZRbiclIRGNMhbZFl3OlP6T9tiollfJil4TVeaXLHqsR/mJFUtUlWuD+aP/5IHzlZM89/eKQHcyzrA8iR8okkohWmp+VwQ/N2nSfZfWo0gbgqz7Np+XGRY3eQzFvQlpHoLBBEKnWzDCLccXXwe2nqmMx6Oh93o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a01:e0a:3e8:c0d0:6288:2946:7ed8:5612])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 07D882CAC61;
	Fri, 18 Apr 2025 10:09:49 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a01:e0a:3e8:c0d0:6288:2946:7ed8:5612) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: syzbot+5405d1265a66aa313343@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: syz test
Date: Fri, 18 Apr 2025 12:09:43 +0200
Message-ID: <20250418100943.108533-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <680205df.050a0220.297747.0004.GAE@google.com>
References: <680205df.050a0220.297747.0004.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <174497098935.10837.3585531367737464735@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 6add6ebfef89..e8d7431ce178 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -15,7 +15,7 @@
 
 #include "btree.h"
 
-void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
+int hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 {
 	struct page *page;
 	int pagenum;
@@ -37,13 +37,16 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 		pagenum++;
 		off = 0; /* page offset only applies to the first page */
 	}
+
+	return bytes_to_read;
 }
 
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
 {
-	__be16 data;
+	__be16 data = 0;
 	// optimize later...
-	hfs_bnode_read(node, &data, off, 2);
+	if(hfs_bnode_read(node, &data, off, 2) < sizeof(u16))
+		return 0;
 	return be16_to_cpu(data);
 }
 
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 0e6baee93245..54f310c52643 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -94,7 +94,7 @@ extern struct hfs_bnode * hfs_bmap_alloc(struct hfs_btree *);
 extern void hfs_bmap_free(struct hfs_bnode *node);
 
 /* bnode.c */
-extern void hfs_bnode_read(struct hfs_bnode *, void *, int, int);
+extern int hfs_bnode_read(struct hfs_bnode *, void *, int, int);
 extern u16 hfs_bnode_read_u16(struct hfs_bnode *, int);
 extern u8 hfs_bnode_read_u8(struct hfs_bnode *, int);
 extern void hfs_bnode_read_key(struct hfs_bnode *, void *, int);
-- 


