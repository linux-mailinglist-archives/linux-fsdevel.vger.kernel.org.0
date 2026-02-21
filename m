Return-Path: <linux-fsdevel+bounces-77846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DMcH+RNmWmmSgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 07:17:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D1116C409
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 07:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB4423039EE3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 06:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBACA33DEEB;
	Sat, 21 Feb 2026 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyKeakrU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA645246BC5
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771654598; cv=none; b=oxrfTmJ3AGX6/Hf+pbAqBn+8HKacCm9qbFZuuOS/tWf4E+FCzm2c4a5aqrXdsS0V7EE2AT2ymAi5CVEQEei7jaWgqedPy1TeT2sori9m5mkTc7QTCHXJxf1pKOo+CG3UnW3IE+aSr21PRVxhfnjWwrQjUnOBqv22oPv4BE+J0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771654598; c=relaxed/simple;
	bh=zz3nRgACO7CZlILtRZG8gYVjvup2nnjgqMlLR37ADkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1a/kSr/GfMdyb7yoX/z81qr8QmdbKY+aBg37ddt/wng/BCK/l8Rke/oRw5gLLwVRUEGqXE4JOMty4O6jtvgj1K/i03Z3UNkCWrd7DLkfoh7OwpZoVyVEqVzA5+DRdRCcg3/9YGcTu/4diGPXnJlRQbxOJFT/jSpOhyul/3EFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyKeakrU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824b5f015bcso2730190b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 22:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771654595; x=1772259395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=evllRjoF6DWKDW2R5ncF1pjzzNOXY0vjOjGXUiBUCTE=;
        b=VyKeakrUwhwhyhqR17CjX12RGTdUTAPL5lb3PtWbkDWI1oL5/9DrN7HP1LB1lEaE8l
         myKCyDlmSc5o63Y3zcFEoYpgBO5rEL+/bguTdgKCWXehfI9mqxEUbMRZBg2WdDVuEoFc
         jSzPRXMbT+M6i2nYtQXwc5EKbqohXoo8V21/mcN8W5OdM6vVHC9j8N+UMKqjzs7JTZgs
         MG2LPwi6BHSlJW73rGA7e4Z3zli4B5ivdAwp+RNiGcOuyOcEI1J4mO7GjOXZNdgza93a
         BVBakD2nHEJLZ0YfwwTH5hYrHDLbo3x4vD4+U3t73fc6nt+YJbs4vrEaBuPQZmcyM/Dj
         Jl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771654595; x=1772259395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evllRjoF6DWKDW2R5ncF1pjzzNOXY0vjOjGXUiBUCTE=;
        b=BN65KOupQfXg5P4dNhyzcXldQb+usgJ+HQPCR1SuMUaapGOx+SgtjIgx3QyPvGdJUc
         4mKZxBK7ERK1FKrxzUzz05xPwsCFwxLz0P6TMuNx9/M3HlDOmdFr7fbEvEyU9UddhpLk
         tMqSKNcELGHeD0hx36kLuCDtmoTBD3eDLhgUa0EihrZOUSWX/zX9c74lGM2CR7omLyhx
         cwI3KLwKvRot9N+kPVNq8pMKVSGHBWeDNiKhsPMXpvB6Kw7+z5+HcCyB0ATr+nKJmcrk
         c59lrO0QnkNUp4hEYplFZZ7XwaTO83vyYotBt/vgIVURBiRCn6xWcFD00a6GqcfoyYxY
         7/Jg==
X-Gm-Message-State: AOJu0YzYtoBSvv4X7It9VhenaoX3Ym+9UVxdFdwGL8cGMst901NkP6NA
	82mjNHkH/BCQajf2jOKVpeJ9HOmVhKFIos9igPo8K+JUBG3/cfflVQag
X-Gm-Gg: AZuq6aIsoq1YXRoFMNcNpe1W6EeCwZsWbTkQtxKBKUY6biqHikhU3xj17PsI6jQ1eff
	QrXdvk6TnOr3Yqy8zAeFEP1QoheLMw+PaZYzg7k359M9Yiakm4lDqbUD7Q2sWsQZtYdKyCZa3Ac
	nB1mNhCDHe/nKMwZ/fTvMPhT4Gp3uxy0oAh0+GZX0SqNKZvIZC+ybLe4Lsrwo4xdKQAi0h5+jVb
	ooAAUedPZSV7pR5l3qewG6fe8zJZbXQZwCjEHxuHf15wunjfY9strFkgghiRChJNH5jzNpLabQ/
	bpC1E3JOsNYaTjmqHsUyjqEYUbjiQhsZFPmqME259AX1NrjgpShLuXm6g8ogoVNJsAJT8ML8l71
	ZayydyVHI2IS/+GGYgZ4GODx9ARBH/Cw74YPwZ/j17wvD+tMXwk4b0TWXKaEXjXuhv5hSjb7T44
	w6QeO1PnDZ/KhMplS8quib215Pl50Y+bRuxn9ovsV+Uj2MuCvWiz1ygnXgIlExOMwbXPMs/FGnG
	GqS7qQ=
X-Received: by 2002:a05:6a00:1d0a:b0:824:4a41:bff9 with SMTP id d2e1a72fcca58-826daa20076mr2280301b3a.51.1771654595186;
        Fri, 20 Feb 2026 22:16:35 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:34fe:bc95:1e18:4676])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8bf9besm1489944b3a.55.2026.02.20.22.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 22:16:34 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	charmitro@posteo.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Subject: [PATCH v5] hfsplus: fix uninit-value by validating catalog record size
Date: Sat, 21 Feb 2026 11:46:26 +0530
Message-ID: <20260221061626.15853-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-77846-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,dubeyko.com:email,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5D1116C409
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

For thread records, check minimum size before reading nodeName.length to
avoid reading uninitialized data at call sites that don't zero-initialize
the entry structure.

Also initialize the tmp variable in hfsplus_find_cat() as defensive
programming to ensure no uninitialized data even if validation is
bypassed.

Reported-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d80abb5b890d39261e72
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Tested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/all/20260120051114.1281285-1-kartikey406@gmail.com/ [v1]
Link: https://lore.kernel.org/all/20260121063109.1830263-1-kartikey406@gmail.com/ [v2]
Link: https://lore.kernel.org/all/20260212014233.2422046-1-kartikey406@gmail.com/ [v3]
Link: https://lore.kernel.org/all/20260214002100.436125-1-kartikey406@gmail.com/T/ [v4]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v5:
- Add minimum size check for thread records before reading nodeName.length
  to avoid reading uninitialized data, as suggested by Charalampos Mitrodimas

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
 fs/hfsplus/bfind.c      | 52 +++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/catalog.c    |  4 ++--
 fs/hfsplus/dir.c        |  2 +-
 fs/hfsplus/hfsplus_fs.h |  9 +++++++
 fs/hfsplus/super.c      |  2 +-
 5 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 336d654861c5..2b9152c3107b 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -287,3 +287,55 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
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
+		if (fd->entrylength < offsetof(struct hfsplus_cat_thread, nodeName) +
+		    offsetof(struct hfsplus_unistr, unicode)) {
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
index ca5f74a140ec..8aeb861969d3 100644
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
index 592d8fbb748c..dcb4357aae3e 100644
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


