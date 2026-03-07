Return-Path: <linux-fsdevel+bounces-79673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKdVLGl5q2nsdQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 02:03:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1342622935A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 02:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC557307E847
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 01:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9B9283CB5;
	Sat,  7 Mar 2026 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJbJoofG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECE27F01E
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845393; cv=none; b=YnAUj35MmynbIFqixr9v4/EVxwc7hGTis1hOX2oh5Zh35HyIYbWY8SoRhUB+lY1RT2NSzszeOqlVUPxquGlanJ2B85wcs6EiUg0XGy9IbQ+iWEIZ0eadMsWXEwXWYMV7jHtZhackPULs+A/YqsLtou49wN4x4q/I9Mo8V6gQ3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845393; c=relaxed/simple;
	bh=sVAP5pve7jl5mYVI5k3uFxp6T/KP9f0tqepkouvH4us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZsy9QTIkvqJS81TrpRC8i9Okz8mQacFjJjfEu6Wts0BJQ8MhUgujutI0RP2Q4p2Ss6DdeSxgVEaFZeD4vZTSVE+Z2eNr67EyHC3kXfFp1bNsgBahJFL59i4VtrMi/MU630Bufuvvz1bf96IO7iKDWYbsUCWadl0aJjjwwl/jpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJbJoofG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae88e16485so4025715ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 17:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772845391; x=1773450191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YbfXb8mhr1e4aRNzu3RYOQ+PswHK4yHikW3LxX15I+g=;
        b=dJbJoofGCf79KMkeS+HKoU7hrbedwQRJEvluLk2VtBl6gd0f2Y3C3dKdDUlIL/BJvQ
         Xkax3zGbgnl90esPbKzGRNST3wiqYUz/2nnbdjFzmlkzmht2Sbd3yRPJxGhVvo+6R9lq
         oacSuRifdMMPIWHl2QYkmNRuXTKGKJEeGU81gKutGXoFBqP64Rpr8/54hyiYtyVK3V1M
         gZ2zR6yLMkXPfHdTZe5EvZy0qc6QMYYdcjwllvs/bbNwUcWpTsp2FeA62tICYgfS+V76
         PIcYAqTv087D5M5j5wHvAaxrLy7HztEv4nG9w7i12tSTjk4R1NqvL+MSKO3mB9+GJj7S
         GMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772845391; x=1773450191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbfXb8mhr1e4aRNzu3RYOQ+PswHK4yHikW3LxX15I+g=;
        b=nGlMny0f7yw9iv5ycdBY9Pa8UveqMhJJvvgwMNkY99P0SK3rpLhowVQL34UpeW2+sb
         5CGVMHNHmyW4uEz19eujmZqTrJkPHmGU98C8Fup3wdBcgymAGiZViaPtsZRbPJ7TPSVR
         Oo67Yr98nAk+EbNKUb7l8PvxL6+XTanP7PMSwUDYXvAzirchEz/tHhYOEfLDMowfBGlD
         5wtAlSapdZr/kxnhezundN/CiXi+ldnnC0yIGiwisjXe/zdH1Qb9C5n0cUXNXZUxqR4s
         gXLTn2cFwbKQw3Clqs2jYWNeduR/ee/IVv1SM/CYmF8bhKyQ78Aowa8fY7W3wYNk+Plq
         M2IA==
X-Gm-Message-State: AOJu0YyfBg5J0htY4eX6UohQ0pP7f/5iAAJmVLVrIP0RH5iTWp3REH7v
	gQLxKn48vRKc2vI2Jgv3B6rssUs4tw44ZvgffdCJXg86eXbGmNEQ/My1
X-Gm-Gg: ATEYQzx56NbBsb87P1AGS4ioDPlV+8k3mmqpaeTBD51OLJAdsMlmU2TlA7zTw6znzDK
	OvfSIgjwPN4b+RTfUBWU9Euspr4XFN/1Po/fSQ4zDF+3tVwv7sOJlZCWytheEq7vLYBIhBKTo1e
	AbBr7s/PBPHm4xHx+4RkMb2ogPqc9DUoncOcq75o7DbqRnGtv1FlIoJfGIr8RruQY/sKJ7UDl3N
	STde26aWEizpcrBkDQD8ELCzHtEs+gCd7TIUCJnJjK7BWn64vyv+ghJT5r+c6EnHo/5VHwYBXQf
	SK4sSxIPHZKwP3vyfqz+M9Ju3nQ78HMHJWbq7ts7uEUfh7UpISpTODrukmjxBqBre4UyCj1ioou
	uxiGq6Ft/12FcNTAAl6HZh1Ik9nErosDKIL85DO1C7sY+aJWk3q6VtbyZTmlE1FA12lGU/TxEvI
	po9X4bxRpSN94VAWAGS5XDOPZq4Wbi0so5ZjEVsd6hDsi8/aNkZpbiRzYMVdfED4riiV1XnP/Uj
	25+nzU=
X-Received: by 2002:a17:903:b4b:b0:2ae:3a77:a1f4 with SMTP id d9443c01a7336-2ae8247ed08mr38835275ad.24.1772845391315;
        Fri, 06 Mar 2026 17:03:11 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:4191:5f1c:7dc6:bad2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f752bfsm43651665ad.60.2026.03.06.17.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:03:09 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	charmitro@posteo.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Subject: [PATCH v6] hfsplus: fix uninit-value by validating catalog record size
Date: Sat,  7 Mar 2026 06:33:02 +0530
Message-ID: <20260307010302.41547-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1342622935A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79673-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,posteo.net:email,dubeyko.com:email]
X-Rspamd-Action: no action

Syzbot reported a KMSAN uninit-value issue in hfsplus_strcasecmp(). The
root cause is that hfs_brec_read() doesn't validate that the on-disk
record size matches the expected size for the record type being read.

When mounting a corrupted filesystem, hfs_brec_read() may read less data
than expected. For example, when reading a catalog thread record, the
debug output showed:

  HFSPLUS_BREC_READ: rec_len=520, fd->entrylength=26
  HFSPLUS_BREC_READ: WARNING - entrylength (26) < rec_len (520) - PARTIAL READ!

hfs_brec_read() only validates that entrylength is not greater than the
buffer size, but doesn't check if it's less than expected. It successfully
reads 26 bytes into a 520-byte structure and returns success, leaving 494
bytes uninitialized.

This uninitialized data in tmp.thread.nodeName then gets copied by
hfsplus_cat_build_key_uni() and used by hfsplus_strcasecmp(), triggering
the KMSAN warning when the uninitialized bytes are used as array indices
in case_fold().

Fix by introducing hfsplus_brec_read_cat() wrapper that:
1. Calls hfs_brec_read() to read the data
2. Validates the record size based on the type field:
   - Fixed size for folder and file records
   - Variable size for thread records (depends on string length)
3. Returns -EIO if size doesn't match expected

For thread records, check against HFSPLUS_MIN_THREAD_SZ before reading
nodeName.length to avoid reading uninitialized data at call sites that
don't zero-initialize the entry structure.

Also initialize the tmp variable in hfsplus_find_cat() as defensive
programming to ensure no uninitialized data even if validation is
bypassed.

Reported-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d80abb5b890d39261e72
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Tested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Suggested-by: Charalampos Mitrodimas <charmitro@posteo.net>
Link: https://lore.kernel.org/all/20260120051114.1281285-1-kartikey406@gmail.com/ [v1]
Link: https://lore.kernel.org/all/20260121063109.1830263-1-kartikey406@gmail.com/ [v2]
Link: https://lore.kernel.org/all/20260212014233.2422046-1-kartikey406@gmail.com/ [v3]
Link: https://lore.kernel.org/all/20260214002100.436125-1-kartikey406@gmail.com/T/ [v4]
Link: https://lore.kernel.org/all/20260221061626.15853-1-kartikey406@gmail.com/T/ [v5]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v6:
- Use HFSPLUS_MIN_THREAD_SZ constant instead of offsetof() calculation
  for thread record size check, as suggested by Charalampos Mitrodimas

Changes in v5:
- Add minimum size check for thread records before reading nodeName.length
  to avoid reading uninitialized data

Changes in v4:
- Move hfsplus_cat_thread_size() as static inline to header file

Changes in v3:
- Introduced hfsplus_brec_read_cat() wrapper function for catalog-specific
  validation instead of modifying generic hfs_brec_read()
- Added hfsplus_cat_thread_size() helper to calculate variable-size thread
  record sizes
- Use exact size match (!=) instead of minimum size check (<)
- Use sizeof(hfsplus_unichr) instead of hardcoded value 2
- Updated all catalog record read sites to use new wrapper function

Changes in v2:
- Use structure initialization (= {0}) instead of memset()
- Improved commit message to clarify how uninitialized data is used
---
 fs/hfsplus/bfind.c      | 51 +++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/catalog.c    |  4 ++--
 fs/hfsplus/dir.c        |  2 +-
 fs/hfsplus/hfsplus_fs.h |  9 ++++++++
 fs/hfsplus/super.c      |  2 +-
 5 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 336d654861c5..9a55fa6d5294 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -287,3 +287,54 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
 	fd->bnode = bnode;
 	return res;
 }
+
+/**
+ * hfsplus_brec_read_cat - read and validate a catalog record
+ * @fd: find data structure
+ * @entry: pointer to catalog entry to read into
+ *
+ * Reads a catalog record and validates its size matches the expected
+ * size based on the record type.
+ *
+ * Returns 0 on success, or negative error code on failure.
+ */
+int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry)
+{
+	int res;
+	u32 expected_size;
+
+	res = hfs_brec_read(fd, entry, sizeof(hfsplus_cat_entry));
+	if (res)
+		return res;
+
+	/* Validate catalog record size based on type */
+	switch (be16_to_cpu(entry->type)) {
+	case HFSPLUS_FOLDER:
+		expected_size = sizeof(struct hfsplus_cat_folder);
+		break;
+	case HFSPLUS_FILE:
+		expected_size = sizeof(struct hfsplus_cat_file);
+		break;
+	case HFSPLUS_FOLDER_THREAD:
+	case HFSPLUS_FILE_THREAD:
+		/* Ensure we have at least the fixed fields before reading nodeName.length */
+		if (fd->entrylength < HFSPLUS_MIN_THREAD_SZ) {
+			pr_err("thread record too short (got %u)\n", fd->entrylength);
+			return -EIO;
+		}
+		expected_size = hfsplus_cat_thread_size(&entry->thread);
+		break;
+	default:
+		pr_err("unknown catalog record type %d\n",
+		       be16_to_cpu(entry->type));
+		return -EIO;
+	}
+
+	if (fd->entrylength != expected_size) {
+		pr_err("catalog record size mismatch (type %d, got %u, expected %u)\n",
+		       be16_to_cpu(entry->type), fd->entrylength, expected_size);
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 02c1eee4a4b8..6c8380f7208d 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -194,12 +194,12 @@ static int hfsplus_fill_cat_thread(struct super_block *sb,
 int hfsplus_find_cat(struct super_block *sb, u32 cnid,
 		     struct hfs_find_data *fd)
 {
-	hfsplus_cat_entry tmp;
+	hfsplus_cat_entry tmp = {0};
 	int err;
 	u16 type;
 
 	hfsplus_cat_build_key_with_cnid(sb, fd->search_key, cnid);
-	err = hfs_brec_read(fd, &tmp, sizeof(hfsplus_cat_entry));
+	err = hfsplus_brec_read_cat(fd, &tmp);
 	if (err)
 		return err;
 
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index d559bf8625f8..25535592234c 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -49,7 +49,7 @@ static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 	if (unlikely(err < 0))
 		goto fail;
 again:
-	err = hfs_brec_read(&fd, &entry, sizeof(entry));
+	err = hfsplus_brec_read_cat(&fd, &entry);
 	if (err) {
 		if (err == -ENOENT) {
 			hfs_find_exit(&fd);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 5f891b73a646..61d52091dd28 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -509,6 +509,15 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
 		       void **data, blk_opf_t opf);
 int hfsplus_read_wrapper(struct super_block *sb);
 
+static inline u32 hfsplus_cat_thread_size(const struct hfsplus_cat_thread *thread)
+{
+	return offsetof(struct hfsplus_cat_thread, nodeName) +
+	       offsetof(struct hfsplus_unistr, unicode) +
+	       be16_to_cpu(thread->nodeName.length) * sizeof(hfsplus_unichr);
+}
+
+int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry);
+
 /*
  * time helpers: convert between 1904-base and 1970-base timestamps
  *
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 7229a8ae89f9..5ef0f71b1a33 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -571,7 +571,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
 	if (unlikely(err < 0))
 		goto out_put_root;
-	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
+	if (!hfsplus_brec_read_cat(&fd, &entry)) {
 		hfs_find_exit(&fd);
 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
 			err = -EIO;
-- 
2.43.0


