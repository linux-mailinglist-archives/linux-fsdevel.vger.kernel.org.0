Return-Path: <linux-fsdevel+bounces-78453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFWHBO8PoGnbfQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:18:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 698291A33FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A37D831368BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFDB39A7E1;
	Thu, 26 Feb 2026 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIYQu4fT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12341399025
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097178; cv=none; b=iNeMXO3ocCZJhZ6Ko7C8Hj0dNGAZN0lCuY5NjyeoyNx4AABsv6d1tkZjEvMhRfb5JZlEQdUsRg2eDxID99TShiHx06FmxP7qASIJNQS3jx4spGvMa0hpHQ2pTYivI6sRyGOqBtQSRloCCSY6PZdfflr8i/GiQoOWC41EAOHxS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097178; c=relaxed/simple;
	bh=Fk0aujHKrLe/HLkvJ8Rd/HfBnxsh4Mhj8SSHdLVoFzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=la5wEuuL7vc5Cvkt7YgT2GOGMXXhDYDaRiOredu919kFvGZiFJ+G2/ejE/VoZJE0obo5waeoqeNjdgb7tz88sLKhNW9SBYxhIBJwwc8gsXLVbUPK+iZVaAoFztFbODXe6zQHsv7WODja71VPBc1PsP55BD+GY5HCp6oS1j9Kuec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIYQu4fT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-824a3509a12so321212b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 01:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772097176; x=1772701976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbVryAdCU4vExrYKabItNuo1mnWUEmhcCqLlFBq490Y=;
        b=eIYQu4fTICSNLNFYscRGGI/HJWUJqc7l31QSbRF6FjKsBJKeun2HbNy9wL3MqcVER5
         WFfe719DQVkfCnGZ2pfq9OBrX1wc8Y0PHHjv8gRRFmTFkThirIFECaP29VLHlsrGTp6D
         z1+5ZdQ3Q1jJ+EQ2HMT2bViFbh8LUZbkMWY+6r6bblX59fDoIv5epeCp8hV+VHWoi67Z
         lrnRTqTZ8k2SWxH3Lg9vHkP8CFVY1KxlSDBgUsYVSii2+99zTR9h/od41wxdH4m1Dxzy
         zMr+RdvliQtNsPQZSp0ihVyTIWPD/sn8qxyGTUj7sTRZVcgwTd0NK2Q7o93QYn2iBauQ
         Z5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772097176; x=1772701976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dbVryAdCU4vExrYKabItNuo1mnWUEmhcCqLlFBq490Y=;
        b=WZEA/zn4nO+2iPoRYHg/QSwt4jAz9mKMRcZraDive7gPUsLpJB8orwkkbEtH7vGRMN
         BjgDTwlc6O+jtXx2AKiU9l5dCnRENICxG75aMT6yZnNGIpDfyR/qjHQgz/6Ow/9B8n+q
         t/VwQ4dkOJ8jP4sMg7F/vyVzrP2jaHPN6DJFOAxweTrIMzXfS4CoxE1HPIrgXR1SP4Qg
         pnIwINdG1+151HMZha+PjgOF6oQuqguAYaeuTlAKDZeyUO+feh7R8hyC2kjV/dM7h09l
         rY/TloMCy4Kp7n656ZhP1St7k7Kn2Oi5IpQZYAZEi3GzoNc+bvoQEVXnrtv5KRe5z0ZQ
         inmw==
X-Forwarded-Encrypted: i=1; AJvYcCWEQBW+NLICdvKVcdJ2JuQVGkJ4OrAZdz427MNzNY5reArOE5m99Vbeg8gavJflTpWE9cskbeCvU6WRrGQX@vger.kernel.org
X-Gm-Message-State: AOJu0YyLby5q46WIhlRi1/bcVWSW0k19nPLL5947Ijv1H58JRVafb5Xv
	7kILQKGF9RIYccpI16fPaWm2WMbCoySQUBkxzJkkuc7XKJX75ruWH5Lg
X-Gm-Gg: ATEYQzyezitrRTU8oENBAHYCiqXYuyL1LHVOFxa5fAiVJIBdXb5/qYa5NWwJfxp2mKD
	xBfq7XDpEweAx4L9Tkjf+ryBKuSQjyXmzjr7eQKDMdprXcr6mUcJj9bpJgrhl70QRhUUSLnRk60
	DYdP/k9Dyd/zLNZEMdx6hta8iozXHk5AhET8I5UbOV5PR9DGEPVjLX0J9jnAZw2dQKdJrdHgWAY
	4bG6PYtHJzU1vuCuz+eNzU/sAim8CDPoWTnKXsG6J6PHixlwxpjv1utsqIGpQuqx4WTUFrBDAv0
	6iy2XYzYJ8I6A7RqWsvMmtgSIDAL9Ws11vwnkVh2aMygM94dW+zqbELz1V8xW3jcQB/T1kS/5/P
	j2LKOUxayw8qXghdopzbLnMIIFXQYSZZNmZKeq/jkBC8DajakEAncegaWdnOoCQS9tGcW41af47
	qGw5GmhjglXkdjspLI4gTwsDqOJ1muiS/aUE4W+ml9YetCrs3lJE8r++VxPw==
X-Received: by 2002:a05:6a21:690:b0:366:1fea:9b54 with SMTP id adf61e73a8af0-395b492983amr1638932637.39.1772097176255;
        Thu, 26 Feb 2026 01:12:56 -0800 (PST)
Received: from localhost.localdomain ([223.185.37.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5e4aafsm1457484a12.4.2026.02.26.01.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:12:55 -0800 (PST)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Subject: [PATCH v4 2/2] hfsplus: validate b-tree node 0 bitmap at mount time
Date: Thu, 26 Feb 2026 14:42:35 +0530
Message-Id: <20260226091235.927749-3-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226091235.927749-1-shardul.b@mpiricsoftware.com>
References: <20260226091235.927749-1-shardul.b@mpiricsoftware.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78453-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,mpiric.us,gmail.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardulsb08@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpiricsoftware.com:mid,mpiricsoftware.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 698291A33FF
X-Rspamd-Action: no action

Syzkaller reported an issue with corrupted HFS+ images where the b-tree
allocation bitmap indicates that the header node (Node 0) is free. Node 0
must always be allocated as it contains the b-tree header record and the
allocation bitmap itself. Violating this invariant leads to allocator
corruption, which can cascade into kernel panics or undefined behavior
when the filesystem attempts to allocate blocks.

Prevent trusting a corrupted allocator state by adding a validation check
during hfs_btree_open(). Using the newly introduced map-access helper,
verify that the MSB of the first bitmap byte (representing Node 0) is
marked as allocated. Additionally, catch any errors if the map record
itself is structurally invalid.

If corruption is detected, print a warning identifying the specific
corrupted tree (Extents, Catalog, or Attributes) and force the
filesystem to mount read-only (SB_RDONLY). This prevents kernel panics
from corrupted images while enabling data recovery by allowing the mount
to proceed in a safe, read-only mode rather than failing completely.

Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1c8ff72d0cd8a50dfeaa
Link: https://lore.kernel.org/all/54dc9336b514fb10547e27c7d6e1b8b967ee2eda.camel@ibm.com/
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 fs/hfsplus/btree.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 22efd6517ef4..e34716cd661b 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -176,9 +176,14 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 	struct hfs_btree *tree;
 	struct hfs_btree_header_rec *head;
 	struct address_space *mapping;
+	struct hfs_bnode *node;
+	const char *tree_name;
+	unsigned int page_idx;
 	struct inode *inode;
 	struct page *page;
 	unsigned int size;
+	u16 bitmap_off, len;
+	u8 *map_page;
 
 	tree = kzalloc_obj(*tree);
 	if (!tree)
@@ -283,6 +288,46 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 
 	kunmap_local(head);
 	put_page(page);
+
+	node = hfs_bnode_find(tree, HFSPLUS_TREE_HEAD);
+	if (IS_ERR(node))
+		goto free_inode;
+
+	switch (id) {
+	case HFSPLUS_EXT_CNID:
+		tree_name = "Extents";
+		break;
+	case HFSPLUS_CAT_CNID:
+		tree_name = "Catalog";
+		break;
+	case HFSPLUS_ATTR_CNID:
+		tree_name = "Attributes";
+		break;
+	default:
+		tree_name = "Unknown";
+		break;
+	}
+
+	map_page = hfs_bmap_get_map_page(node, &bitmap_off, &len, &page_idx);
+
+	if (IS_ERR(map_page)) {
+		pr_warn("(%s): %s Btree (cnid 0x%x) map record invalid/corrupted, forcing read-only.\n",
+				sb->s_id, tree_name, id);
+		pr_warn("Run fsck.hfsplus to repair.\n");
+		sb->s_flags |= SB_RDONLY;
+		hfs_bnode_put(node);
+		return tree;
+	}
+
+	if (!(map_page[bitmap_off] & HFSPLUS_BTREE_NODE0_BIT)) {
+		pr_warn("(%s): %s Btree (cnid 0x%x) bitmap corruption detected, forcing read-only.\n",
+				sb->s_id, tree_name, id);
+		pr_warn("Run fsck.hfsplus to repair.\n");
+		sb->s_flags |= SB_RDONLY;
+	}
+	kunmap_local(map_page);
+	hfs_bnode_put(node);
+
 	return tree;
 
  fail_page:
-- 
2.34.1


