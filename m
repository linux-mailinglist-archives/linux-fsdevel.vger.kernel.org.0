Return-Path: <linux-fsdevel+bounces-77193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL7KDgXAj2lKTQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 01:21:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9379813A244
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 01:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09A0A3046EA9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 00:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811111DE885;
	Sat, 14 Feb 2026 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg8ptU+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC4944F
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771028470; cv=none; b=QrYMaU4Oc4k4DHgMmtt5qmJWbM4bkvpVcfVl24/6c7eYyzcJ3G2PjGhCMwMud1yB+5yP89xT+rga2v5gSe9SzhkWCopBX4vkI+0eLFadELz59tunvIfMfCCHQTde4JuHrFD1CW1CWKVU5u7tvGUv2acWQeOqhAGbAdW69ElVo4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771028470; c=relaxed/simple;
	bh=D/YVepfgYii6qyyBIbfxram3tBNT+IdUmevLkyoV5xE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxkqnk/ebPY0YSnMH7M7e8ImpLA5W+6aQnHL8YKUXAerH0Yy3ya9DYNVRgfh8jKP8iGjH9WN89aEvZBSep0kw2DL6qZ28vtAWXeS3aWklW6H9cXuedo9NpQY/3U3xQnfPMtyeBhFWaf4mUY9UugbVywe4hIAbF4LTLkc4ycr/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg8ptU+m; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-824c9da9928so587076b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 16:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771028467; x=1771633267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yP///Lg/wvpY4O1JL+tfaO/XX+i+pY6F/SFRRuJOIU=;
        b=kg8ptU+mZSo9bPPJPzBkMz9J/l92LneK0aB58/rR2q//xZc/0lbX4RAbSaH5Z7FSFR
         v5RNcE+CW7vbbyKtrFU9laI2/vL3F5tQHRAbHUUfJrGKyAlb8Oxw6ZCLgPKx9Cidta21
         hHx/IDE1mMeqWjkh4VSNGFux+uc0OsL3nabfTzSQQMOlWh6gtlzDuRav3kv+nubniDdn
         D9aJtpChjdF8qAMS0hmzkc2Mh+eZAtbwohEDi0kLKWJ08UfvKU+TeM1sTXMK2xy7WOKS
         tpigsjy6xOcrKB5bRkW96zQrJ67j+UsQnxzdW/iQgWrVzrJFyeOB5z+mk+jn1JEvPRFE
         uUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771028467; x=1771633267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yP///Lg/wvpY4O1JL+tfaO/XX+i+pY6F/SFRRuJOIU=;
        b=lYyg01iKZFGMpz0QgOlUfG15bKPT0nILUQKSW+F7oLvS7u9RxNYD1TZb066WxOZotd
         Ld1co9FjxwCXnX/2PIbdwEcYtojNqXCbxIyUShSVpVt9Psi7IPGH87FKeEg4n4Mh+57m
         icdTFYFrdIDnua1qM0WzlITSYhOMApOoBYYQgRFcui4GDUyz8L77pqzG7i5ig5fWt21l
         YZ1hw+9qIUdAVgDw9yECNgMaEjYEAdGljTQPLP8R0CMnf3wFiUyBxx67u0B66p3hKInd
         VW9wrHbd06xBZw2XGOsW4Y5iqQZPbkhsodMuXwukKPrT1ryT43QJ13ULDj/KCLenPW5V
         8pRg==
X-Gm-Message-State: AOJu0YzxhnHXstXOwnrzH3Shv8saOyVbFtCoWMngYKkQ89DMIl3pYpky
	JNGay9bKzgTgXE0T3msp/r3fNy+WOwcqgmr3bufHGKvRBiqBpyBb0CLP7KwonQ==
X-Gm-Gg: AZuq6aKKjxQ5eksr0+/uN0R2k6mOq3ZHf2b8T/mFk+Mrw66V48VPgQKl9Kl/9xfZmqH
	IcffmK/iwduoYk3DbNxVBjRahKi2jHDeV7M+n4KUD3UmPhEV1pnp245Dxzh6LBD1R0IPVprAlRx
	mqzQNub3ehKXvSiYMCMfTPWGrhNeMXS/rhb/xHfR5ky/odeLdaGqeuoznla/AiNrV2Gjx+DzqHV
	IGeDnf+8vHdlUw8UhRZoRXUPQIWPoUUrp5isBy9cF1hShcX9k+dZ2B8H4kZhA5I0lbWH80n+shy
	BVcFX6FqssRna7sgl7/wBke8TlhIKar6+NBXZMzrq3sg9GRRsbcN/X4rBhGfEKf2VkwkayWxHap
	s4s63YGLgRj3w/b8t6bbsmTIYaaS0NgwuBn4PK9qhB7Ibj12NxJ1D1gbxms39vumkW8ZlpRTeBp
	j15LZSauhuvIZE53mCmpWdCUTMOXNxJ3rZfjooj9WPm7w/MENkYXdgcUfCHKmp4ZuxiJVa/8/ph
	o52pHBXC9pZ04GY
X-Received: by 2002:a05:6a00:4f8f:b0:81f:46ba:1817 with SMTP id d2e1a72fcca58-824c964a386mr3440393b3a.66.1771028466970;
        Fri, 13 Feb 2026 16:21:06 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:1ca3:229:a9f4:8c87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a3e150sm4008462b3a.15.2026.02.13.16.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 16:21:06 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Subject: [PATCH v4] hfsplus: fix uninit-value by validating catalog record size
Date: Sat, 14 Feb 2026 05:51:00 +0530
Message-ID: <20260214002100.436125-1-kartikey406@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77193-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 9379813A244
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
Link: https://lore.kernel.org/all/20260120051114.1281285-1-kartikey406@gmail.com/ [v1]
Link: https://lore.kernel.org/all/20260121063109.1830263-1-kartikey406@gmail.com/ [v2]
Link: https://lore.kernel.org/all/20260212014233.2422046-1-kartikey406@gmail.com/ [v3]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v4:
- Move hfsplus_cat_thread_size() as static inline to header file as
  suggested by Viacheslav Dubeyko

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
 fs/hfsplus/bfind.c      | 46 +++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/catalog.c    |  4 ++--
 fs/hfsplus/dir.c        |  2 +-
 fs/hfsplus/hfsplus_fs.h |  9 ++++++++
 fs/hfsplus/super.c      |  2 +-
 5 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 9b89dce00ee9..4c5fd21585ef 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -297,3 +297,49 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
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
index 45fe3a12ecba..e811d33861af 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -506,6 +506,15 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
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


