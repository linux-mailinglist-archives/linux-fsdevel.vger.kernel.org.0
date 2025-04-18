Return-Path: <linux-fsdevel+bounces-46670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317CCA93725
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 14:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CC71B60751
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 12:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99AA274FD4;
	Fri, 18 Apr 2025 12:33:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5771A3168;
	Fri, 18 Apr 2025 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979610; cv=none; b=PF87ebJorFV528vg4ez3Lch3rXCHZidST6psTMPHIRlOxRm0o4S5DfZXEsAzuqkfXjYUAVM3WjKXW84MGdoLTAumM1RR34WTm82zxe2MmDfAU5vSUnDfbcr/3OFkEnAYtCiKwqn8yNlPiEhpA34MSRQAK39dXTEk9xVfZnwU36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979610; c=relaxed/simple;
	bh=ooxaU+DbzCFttfn4smQb319QFujd6hNgVD28WSbl9Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To; b=cqC+06zDt9vVzQOzSDCh1ZGweSjDlVmnNAAT+foLJqGa3J6Zca/XLTDpix6+8hy9x73jj2iClq1yp+a1sNgHyEFCTcfFe8BCYQOHdZQ9aa0QZNPOrfHZcg6Nu5jboqz1zCkuEl7BkyR1tql7helkk6/wArpPreTZTrsbnRpzZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [127.0.1.1] (unknown [IPv6:2a01:e0a:3e8:c0d0:6288:2946:7ed8:5612])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id D10D2528C7;
	Fri, 18 Apr 2025 12:33:22 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a01:e0a:3e8:c0d0:6288:2946:7ed8:5612) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[127.0.1.1]
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
Date: Fri, 18 Apr 2025 14:33:15 +0200
Subject: [PATCH] hfs: Ensure enough bytes read in hfs_bnode_read_u16
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20250418-ensure-enough-bytes-inhfs_bnode_read_u16-v1-1-8733ad14d0fe@arnaud-lcm.com>
X-B4-Tracking: v=1; b=H4sIAIpGAmgC/x2NzQrDIBAGXyXsucKa/hD6KqWIiZ9xL1rcGlpC3
 r3S0zCXmZ0UVaB0H3aq2ESl5C72NNCSfF5hJHSnkccrX+xkkLVVdJS2JjN/31AjOUV1cy4BrsI
 H1+zNMJ8n9jEGXkA996qI8vmvHs/j+AHAO670egAAAA==
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 contact@arnaud-lcm.com, skhan@linuxfoundation.org,
 syzbot+5405d1265a66aa313343@syzkaller.appspotmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744979602; l=2705;
 i=contact@arnaud-lcm.com; s=20250405; h=from:subject:message-id;
 bh=ooxaU+DbzCFttfn4smQb319QFujd6hNgVD28WSbl9Rg=;
 b=Cvt67AYmymO8ADl/mjM0OpWa4rc7GrGGBHnPuSfYPTGyTTXjGxeJnmmqL0z3bOZrXYSk1Mu9S
 WqFFuKB2SMbBeG/4lWRRF6a0nFhtEZ/7zWLNl11qN7KrJt6+auxBFo0
X-Developer-Key: i=contact@arnaud-lcm.com; a=ed25519;
 pk=Ct5pwYkf/5qSRyUpocKOdGc2XBlQoMYODwgtlFsDk7o=
X-PPP-Message-ID: <174497960317.11978.13677145634383572213@Plesk>
X-PPP-Vhost: arnaud-lcm.com

In certain scenarios, hfs_bnode_read() may be called with an offset that
lands exactly at the end of a memory page (e.g. offset + page_offset == 4095).
This causes the read to span a page boundary, but hfs_bnode_read() is only
able to read the first byte before reaching the end of the node's page range.

As a result, the local variable `data` in hfs_bnode_read_u16() may be only
partially initialized, triggering a KASAN warning due to the use of
uninitialized stack memory.

Ensure that hfs_bnode_read() fully reads the requested number of bytes, or
handle the case where it cannot to prevent use of partially initialized data.

Reported-by: syzbot+5405d1265a66aa313343@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5405d1265a66aa313343
Tested-by: syzbot+5405d1265a66aa313343@syzkaller.appspotmail.com
Fixes: 8ffd015db85f ("Linux 6.15-rc2")
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
---
 fs/hfs/bnode.c | 9 ++++++---
 fs/hfs/btree.h | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

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

---
base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
change-id: 20250418-ensure-enough-bytes-inhfs_bnode_read_u16-00380affd0ce

Best regards,
-- 
Arnaud Lecomte <contact@arnaud-lcm.com>


