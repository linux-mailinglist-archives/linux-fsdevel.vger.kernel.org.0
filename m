Return-Path: <linux-fsdevel+bounces-76985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDP4F1YpjWmbzgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 02:13:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA34D128DD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 02:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34E993023048
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 01:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C861E98EF;
	Thu, 12 Feb 2026 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLQFkb2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0CC1E5B88
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858757; cv=none; b=oW+CTsiVdIlBHsaW7fqIqzJzRO8EpvOaNV2TrjBsWcnyIBHiNmQZlfUlj74xq3kkZsVdrXbKveTEaz14RxralDHH9VFgzVIT1QwtwxygXFHTRWbMVLeUmFvi0JRbGsVMsGSr+lM2nG7OJBI/dF7boH4PrzD+Bq2i64Us3W7Ts0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858757; c=relaxed/simple;
	bh=b3k9g+bB9Wus+Vab7BvAAK+pJN41giLc2h4bKR1axJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZyCilD09buw6h8GmCXO/mLSXj00qlpUDB5hvu7TkFj3nbr5sE1riBkK0rAt58h6RASbB3J0SaF1SH0wCq32yIN6pKF2ZVUsKiAiMWot5YPn7QUKBFrncfb7zLRU87d8IdmaspnwGpMGU2PHC/qm4V3GE6C9xa3y8fJZ3710h+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLQFkb2v; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aaed195901so19777805ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 17:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770858756; x=1771463556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e450Uwa5Agt/WB2SYXKqjVmWpbonMJQ6E2jkPWqLxM8=;
        b=WLQFkb2vNCSGemwvqgQunGdSAavLEbd9nl3Om/adW7b+eHX/FWOiwgV29tQB3wW3xq
         SokeUngAS7cDL8H2rNO+EUVDImmCMgCAsGCxUdtR9McJEyhnHMiATe4rbvPeSppHld4l
         qkeOBqfQuQtISJsz0lmrZdOJ37mWIrufS8ncUfAKklZJlgiW6rsjFtb8nZzgk4A/dkXd
         Efus+oPj2vbMNdDBbQ1KxGMNwPu1RJRuhidZnjfYGOyIXIxjE+DsmORRxB5W1J522AIN
         j5PboAvPsRgWXDg/9g29IWiGz3kbn8dA7ppdDWgui5b/bW3JZGkXBazM4WIdia/af45W
         3V7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770858756; x=1771463556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e450Uwa5Agt/WB2SYXKqjVmWpbonMJQ6E2jkPWqLxM8=;
        b=biF5IwYvISJycMddm7QXNc9w2POWSD6qjlTdgC1DTvKFk2OT15AhpR4f/ZrQpE1krh
         S9G1OCqQJbj9tOyDtqkWTE3WzsCCXKB9KvycuQZAAfmzU1DkP4MbsgsK8rYdndueR4wR
         qq4jtm4ocfSDZZbc3aRkzPgm+KAg2nDfl7C+eJL0Lj/HoqV4AtzQ4cmKUxLrYvijXa9n
         oeXMWBEQVmplcjTQNAMm1MkRrknasQ1PAfyfp3NjNk2/bcCSEcHBje1fYcj8Cfue+Dnb
         6Hb6hQ9368HUxLJP8/RYofjx4/L3wcb5lR+Ub0GERJ6htCTGTKXrb4BAtIVtjqLTGmrm
         BV5g==
X-Gm-Message-State: AOJu0Yz7IvV7l+SdTNhKi97hOrewV9sdpAfw9wHtR1j4//lRmm/xQ2vP
	GCW6BRdW5wj8UUknWTqFcKo3ckdCbGMfwk0jGIOPpdVMTzI57Yz+0TKi
X-Gm-Gg: AZuq6aIZWXQV9grPMUpfAJdlIlo3GrfNdByotIzr27g4h8mMrsbdj2siDtJvrJMNeh/
	gc7iYHRSyme4VFqMi2PuuuK1iv6xyDOYQUQeb6QWF+HLvlRDfYHSNSrnfNmercn7bWprtVwc+4z
	hDi68bXz/ZviRbF2cSrQU0GHlebD8uUGz3lP/uqdfJyr+yz9i4jJhGsGuSw4C4C6CE6lYwkCTWx
	Vk9v4SYwcG/criuryRYa+F+jTrNPOiAiKk4BZa2totiaUz4fUJAN6H0LNjiR4KFHkPiORG1/v1D
	NhzPyvRnGFdvHF8A+jqKuE66NtNiLyDfFuTc69JntIZRcptW+vOPwHMXoGVc8MIxmhtsmieN/eh
	O+gIEXEbcIjkCycr6TzLJECCg8PQmyF1kJpfghYpAjuKI39NMMeM5J3DDs38jYbq5Fizxum+piJ
	N11/sbzVk0J01NG9uMvZI4qOdfZx2pV5Wn7eXcNKOyNoJ8WMyC1suXTjkoN6M8CVgZr5XjBxX1k
	Vxe
X-Received: by 2002:a17:903:b84:b0:2a7:c8db:488a with SMTP id d9443c01a7336-2ab3987a8afmr9704685ad.7.1770858755832;
        Wed, 11 Feb 2026 17:12:35 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:e19:3f46:5cc:70f0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab298700a7sm32001845ad.27.2026.02.11.17.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 17:12:35 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Subject: [PATCH v3] hfsplus: fix uninit-value by validating catalog record size
Date: Thu, 12 Feb 2026 06:42:27 +0530
Message-ID: <20260212011227.65197-1-kartikey406@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76985-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: CA34D128DD7
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

Also initialize the tmp variable in hfsplus_find_cat() as defensive
programming to ensure no uninitialized data even if validation is
bypassed.

Reported-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d80abb5b890d39261e72
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/20260120051114.1281285-1-kartikey406@gmail.com/T/ [v1]
Link: https://lore.kernel.org/all/20260121063109.1830263-1-kartikey406@gmail.com/T/ [v2]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v3:
- Introduced hfsplus_brec_read_cat() wrapper function for catalog-specific
  validation instead of modifying generic hfs_brec_read()
- Added hfsplus_cat_thread_size() helper to calculate variable-size thread
  record sizes
- Use exact size match (!=) instead of minimum size check (<)
- Use sizeof(hfsplus_unichr) instead of hardcoded value 2
- Updated all catalog record read sites to use new wrapper function
- Addressed review feedback from Viacheslav Dubeyko

Changes in v2:
- Use structure initialization (= {0}) instead of memset()
- Improved commit message to clarify how uninitialized data is used
---
 fs/hfsplus/bfind.c      | 59 +++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/catalog.c    |  4 +--
 fs/hfsplus/dir.c        |  2 +-
 fs/hfsplus/hfsplus_fs.h |  3 +++
 fs/hfsplus/super.c      |  2 +-
 5 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 9b89dce00ee9..fe75f3f2c17a 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -297,3 +297,62 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
 	fd->bnode = bnode;
 	return res;
 }
+
+/**
+ * hfsplus_cat_thread_size - calculate expected size of a catalog thread record
+ * @thread: pointer to the thread record
+ *
+ * Returns the expected size based on the string length
+ */
+u32 hfsplus_cat_thread_size(const struct hfsplus_cat_thread *thread)
+{
+	return offsetof(struct hfsplus_cat_thread, nodeName) +
+	       offsetof(struct hfsplus_unistr, unicode) +
+	       be16_to_cpu(thread->nodeName.length) * sizeof(hfsplus_unichr);
+}
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
index cadf0b5f9342..d86e2f7b289c 100644
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
index 45fe3a12ecba..5efb5d176cd9 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -506,6 +506,9 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
 		       void **data, blk_opf_t opf);
 int hfsplus_read_wrapper(struct super_block *sb);
 
+u32 hfsplus_cat_thread_size(const struct hfsplus_cat_thread *thread);
+int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry);
+
 /*
  * time helpers: convert between 1904-base and 1970-base timestamps
  *
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index aaffa9e060a0..e59611a664ef 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -567,7 +567,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
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


