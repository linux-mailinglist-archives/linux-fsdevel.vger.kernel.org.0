Return-Path: <linux-fsdevel+bounces-75994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBHhNwUMfmlAVAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 15:04:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF4AC2282
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 15:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 782113003837
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBAD352C2A;
	Sat, 31 Jan 2026 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Twf2s1Mc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBB1C5D5E
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769868287; cv=none; b=XvZmasE+HpF0jps0SYwXnJuQpZeqdIDoENd+W5eEWoMDSfgKcxb3rxSRQVd2dc+3QSpZzbw3U1sMcN4MPzh6Hh096k1KExy/WmQVQaiPUegmvlNVMIBoTMT0apvxy/iPlqSVVFosou3Tj7vcQHeeHp9ub3L9q3DyQSkhJuQ8vBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769868287; c=relaxed/simple;
	bh=mwBp7x4hVmaNNrPtxczG3bkd4QIaoO+QTTP3OUZ8WoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RIBzGuoqtrtHfJTmyEJislbF7snc6k1MQuTcv/EXMZENMPWkTOcy1YjniIGgMzV+1yRdvkN+lAyYP52UFtCjDJXWe8xyTmx2SHvweapyynclvlkwLd9l8c/7te/TChd9+wA/x3X0Jb7hdbL3v4yLPWIEAsE+KgsbWcDmgMOGCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Twf2s1Mc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso1809770b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 06:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769868286; x=1770473086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+uFfXX98rrE6cCUxtqdP0wdsRpFU7nQkUtzyDsPgvw=;
        b=Twf2s1McOXt5UdZ4j7bETMyAFu+cmIXxm4DOxxczhNN0rFKEdtIVlEUNjvbiz6RY++
         6XCFBUBGWCtHrWCN6tzOrj22BEYHQO0yC+IaqXgFYtYE3mOQWo3UTgoDJcv8o2eW83Db
         mW128FmK9O0JlUtfOHn9tish1fnfgb2f5SH0VClEsRKWwKdW8v5iJgUqxpy/fyG8K4Pn
         E4F7wjpfuQHCb537IZLrIJs4kql+a+lyBxv3fBQbfx06yMxNc/CfnqKPJ8YxUV3SiCnK
         0gz0VR9lEhg3EwmKQxyI+1NKoOd9r+M3xkltfNZSbKSpu6c9sG1O095ILkCsaC3CDXmX
         QskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769868286; x=1770473086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+uFfXX98rrE6cCUxtqdP0wdsRpFU7nQkUtzyDsPgvw=;
        b=bBfk60By3a7K+Q8oFbY/3eukfnRiFbEQGzIDBPyNfcvXf96h5ciVYqhXvadVLvMLI9
         RI0qLUCnCUcqt1hkvqrjA2fDgGKO5dX3EmGPiK1kiZ10CNrLtOAk61NAZOynqDYL7TIJ
         lD7ZC76AqDp8Y3sp7IlhZQpBzTyOKpXSQWzvNvqpZLHarDOGwiR6Sxa4lSXGfkR6B81Q
         0qAUyIBvfH3/N60Zxkww5zwCUwHYU3iTAcn5dQ6vNirjfCU7YcujwB2ioruCacZVcU0k
         Z8//lcM+PfMJyz5DGE/WJsFSG00fZi/dbpjuBwpsFfWO5iRQ43xGm4oSvFGWj6lFxfJZ
         eXzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5mI1R7MpfzlDbwkWR1s5W71Fkvf05B4evXnJ2ksV07KieYsjtrzOuBeEUR9wOyToCGk8/SZIF3oK50Zoa@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIZgeej/vna+weN/UYNQnNx3603rzSudALWKMSNviogvfkiCu
	1fDeEcnJRqNHni9HGTPz0tlaq4QUNRyrJQVtwfXS+0iUmma8YsHTjwsYz25WnpVG
X-Gm-Gg: AZuq6aJ6SQhsUVu4TbkFct0/RVJ18eUnJMZ4oX5a9j+glzVCYXHKwBwXoxcIc7VkzNq
	DAr4SvemHyR/N50iFY8QLTx3MQEdJiNChcakK9NpYanBXq3S881WWnnCmc1S3CbYye6nx+bP4ZQ
	J0nrw2oO6jUw4G/UBBX71P4x24ohEhzyMvh+EBvY1rpfX+KTzGVZon3lEfmnM21krSMKv3aCaIX
	JxlwwcUVvyEu7Oyv5G0Q29OWzJ/ohaadql3ZeAD/q0rONgoRCQ2D+Mde/mWkMuM5wLCmmYRVTYQ
	UMPmremIdNrh3f60NjBNDLZNbVHHfi4/xGZG76XPzumfpTjYErBah/Vp61IhHjjICZUNO1xETz3
	cpx7bwQ7eEBuqcpxxP/uUanl4kiDQPSkt8CzoWVx8+HuW6mCPNahbpSXyQNfLRcrcZwrgDLr1U+
	vUenHEdQMRvP6oPZEghOvMaHRIAEKpfA+IUjtbp4E=
X-Received: by 2002:a05:6a00:1392:b0:81f:4a36:1c7c with SMTP id d2e1a72fcca58-823ab67551cmr5939571b3a.23.1769868285687;
        Sat, 31 Jan 2026 06:04:45 -0800 (PST)
Received: from Shardul.tailddf38c.ts.net ([223.185.36.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1f45dsm10021792b3a.5.2026.01.31.06.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 06:04:45 -0800 (PST)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Subject: [PATCH v3] hfsplus: validate btree bitmap during mount and handle corruption gracefully
Date: Sat, 31 Jan 2026 19:34:38 +0530
Message-Id: <20260131140438.2296273-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75994-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,gmail.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardulsb08@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 7EF4AC2282
X-Rspamd-Action: no action

Add bitmap validation during HFS+ btree open to detect corruption where
node 0 (header node) is not marked allocated.

Syzkaller reported issues with corrupted HFS+ images where the btree
allocation bitmap indicates that the header node is free. Node 0 must
always be allocated as it contains the btree header record and the
allocation bitmap itself. Violating this invariant can lead to kernel
panics or undefined behavior when the filesystem attempts to allocate
blocks or manipulate the btree.

The validation checks the node allocation bitmap in the btree header
node (record #2) and verifies that bit 7 (MSB) of the first byte is
set.

Implementation details:
- Perform validation inside hfs_btree_open() to allow identifying the
  specific tree (Extents, Catalog, or Attributes) involved.
- Use hfs_bnode_find() and hfs_brec_lenoff() to safely access the
  bitmap record using existing infrastructure, ensuring correct handling
  of multi-page nodes and endianness.
- If corruption is detected, print a warning identifying the specific
  btree and force the filesystem to mount read-only (SB_RDONLY).

This prevents kernel panics from corrupted syzkaller-generated images
while enabling data recovery by allowing the mount to proceed in
read-only mode rather than failing completely.

Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1c8ff72d0cd8a50dfeaa
Link: https://lore.kernel.org/all/b78c1e380a17186b73bc8641b139eca56a8de964.camel@ibm.com/
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
v3:
  - Moved validation logic inline into hfs_btree_open() to allow
    reporting the specific corrupted tree ID.
  - Replaced custom offset calculations with existing hfs_bnode_find()
    and hfs_brec_lenoff() infrastructure to handle node sizes and
    page boundaries correctly.
  - Removed temporary 'btree_bitmap_corrupted' superblock flag; setup
    SB_RDONLY directly upon detection.
  - Moved logging to hfs_btree_open() to include the specific tree ID in
    the warning message
  - Used explicit bitwise check (&) instead of test_bit() to ensure
    portability. test_bit() bit-numbering is architecture-dependent
    (e.g., bit 0 vs bit 7 can swap meanings on BE vs LE), whereas
    masking 0x80 consistently targets the MSB required by the HFS+
    on-disk format.
v2:
  - Fix compiler warning about comparing u16 bitmap_off with PAGE_SIZE which
can exceed u16 maximum on some architectures
  - Cast bitmap_off to unsigned int for the PAGE_SIZE comparison to avoid
tautological constant-out-of-range comparison warning.
  - Link: https://lore.kernel.org/oe-kbuild-all/202601251011.kJUhBF3P-lkp@intel.com/

 fs/hfsplus/btree.c         | 27 +++++++++++++++++++++++++++
 include/linux/hfs_common.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 229f25dc7c49..ae81608ba3cf 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -135,9 +135,12 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 	struct hfs_btree *tree;
 	struct hfs_btree_header_rec *head;
 	struct address_space *mapping;
+	struct hfs_bnode *node;
+	u16 len, bitmap_off;
 	struct inode *inode;
 	struct page *page;
 	unsigned int size;
+	u8 bitmap_byte;
 
 	tree = kzalloc(sizeof(*tree), GFP_KERNEL);
 	if (!tree)
@@ -242,6 +245,30 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 
 	kunmap_local(head);
 	put_page(page);
+
+	/*
+	 * Validate bitmap: node 0 (header node) must be marked allocated.
+	 */
+
+	node = hfs_bnode_find(tree, 0);
+	if (IS_ERR(node))
+		goto free_inode;
+
+	len = hfs_brec_lenoff(node,
+			HFSPLUS_BTREE_HDR_MAP_REC, &bitmap_off);
+
+	if (len != 0 && bitmap_off >= sizeof(struct hfs_bnode_desc)) {
+		hfs_bnode_read(node, &bitmap_byte, bitmap_off, 1);
+		if (!(bitmap_byte & HFSPLUS_BTREE_NODE0_BIT)) {
+			pr_warn("(%s): Btree 0x%x bitmap corruption detected, forcing read-only.\n",
+					sb->s_id, id);
+			pr_warn("Run fsck.hfsplus to repair.\n");
+			sb->s_flags |= SB_RDONLY;
+		}
+	}
+
+	hfs_bnode_put(node);
+
 	return tree;
 
  fail_page:
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index dadb5e0aa8a3..8d21d476cb57 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -510,7 +510,9 @@ struct hfs_btree_header_rec {
 #define HFSPLUS_NODE_MXSZ			32768
 #define HFSPLUS_ATTR_TREE_NODE_SIZE		8192
 #define HFSPLUS_BTREE_HDR_NODE_RECS_COUNT	3
+#define HFSPLUS_BTREE_HDR_MAP_REC		2	/* Map (bitmap) record in header node */
 #define HFSPLUS_BTREE_HDR_USER_BYTES		128
+#define HFSPLUS_BTREE_NODE0_BIT		0x80
 
 /* btree key type */
 #define HFSPLUS_KEY_CASEFOLDING		0xCF	/* case-insensitive */
-- 
2.34.1


