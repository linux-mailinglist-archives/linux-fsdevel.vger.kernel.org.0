Return-Path: <linux-fsdevel+bounces-72006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4375BCDAE86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 01:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBD68302EF40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 00:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF331EA7DF;
	Wed, 24 Dec 2025 00:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="hQBmVg8c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EE31531C1
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536114; cv=none; b=Jky5SCaZ0QFy1EUTZFMTKmDEY+FJ+zIahCZ03Gu2f88ACwSeXrx13r+j76YFGq/MwgrVgwCFqJHiFakC6G8uCh3e6VD+c4rxVTUQDmkGT9N4mkrcy/1UcOXgn8H3r++vKsB50iyBcULYzyecMfsZonkzf3V5CU7OxASOqc7mxpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536114; c=relaxed/simple;
	bh=15ghOkOP9nAD6Z+TCDRd6+hCeytoScBTLF/zj2lp1Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DXEPV5PZctVODu2tKjcMttIMlnaOknJR7XKa2Rk1jybIJYQw2O64T72S13vJMPCwxe2/77+oEFhu6JATFmOOftF3XN7mQuUVHNB2kWsVdTM6zMgxqt6+b+SAdnrAMTpeDnMI1ssTyV94in3AuHsdd8+WvcEaqlRdnJWtRhcFZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=hQBmVg8c; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-78fccbc683bso27793577b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 16:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1766536111; x=1767140911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0AftqM2IsmIwcFlGMOmxCPWuF0uVMUeZFDpPcYFOmyM=;
        b=hQBmVg8cOAcjilVAAnoForluol4pukR+pEMhSNN957YLcU+heLDX523bL+41V4kQSN
         4t8PifnV6WBx56nuGTewRC0oOY8bGVc8bOohmcQBHC0EjCIm3jUgLBo5AfQa61+/gUb5
         MBzMcNXHE2tkLdp4A6CR/m/l/qVCPUdB0xs20CF4DBoDS+0H7TlkG9jbdxt+IDGEyaQO
         hkZsPKGXsq7K202UHUBf6qX122ySGhClbqtQDETvdy13L6RRuudAAWiUN4PP74s4G0nz
         /ozWtXri1pn0CoWPUvn5HvK4ceWArdDqf1zIi5x8MP6QeHT5JnyyEsad3ainiR4vUHDZ
         09Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536111; x=1767140911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AftqM2IsmIwcFlGMOmxCPWuF0uVMUeZFDpPcYFOmyM=;
        b=WiR+utRaJuUE8X3rqv1uRs3MmFN2d9YmLH70MwaUSZ+WuzB7ZvfkI1PvLHqKIizJcZ
         YAg6UtBmWLcobhhawYabq5munfZqaq06iY8nm11iYg7UkEZHosIhdYzB9ZL/iKdKyaJU
         bLgTUCfO8zXF4rIzyh/2owK+Qqe89H4UhU7y77znVy2/jI1iLhdhTYDqvfGIZoejdkZ4
         Rq1BiXpl1vaVOVQkW6DfzBdGWOC/fIINZWmA51fXTBXeNSJj540o6aOynZAOG1LR/Fzp
         v+ImLNyORvcGEGCYo0G2Hgx7Sjqbc2OaDRO4pcyd0eTE/fuuprVWtJUcE/RKCKaxG09b
         YL/w==
X-Forwarded-Encrypted: i=1; AJvYcCWmHxL8gYbR566645l1HxeoSvijK8epqZ97h2DQOehhpKhHWOJ8eFgdEmwdWBWNSwcbmw4/I/OC6SQv3nnN@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbScV5XMG5tj3XuzaTPx+pYoenvlGd+uNYc9ivXkyMLne5xAF
	dQlJltz8zKYpC6I1itB6oAA4bbJrBANAzqszgwtWMKybWLCxZdb5lRqqspvTwAfn/7dmM0MGc/U
	fsb+8RrpTcax5
X-Gm-Gg: AY/fxX6J8fz6m4O24x1KWrZm9tmuSniuXrtVA8sWYogxE+PiSizMIo/RNgpn0qPOHzK
	TGm5SOyucTH5pwiWomhcmjpVS9YhGHky71xiLUjYqnM47Anau+8blJEoEtVLsm/J1FcjwWxcR4n
	Yz5McC05xpP6XxacwHBAiW21oocc7WU2SCloz8Dc9ViG7RZ0PF9SvRJqEipfJTRdHFRY2hqLXan
	nmtHpT0d/9nJCo29D80KpvcO5I3FXH0MvPTdAVQ1xn7ySvBAhvdrKD2jxcmoTjdjvQTr43iEVGB
	NaBnAR45kp2bjJx57lpX1oOyOAyuLKEt9HMQ7jdBB5SS3QZGHhQdvlj3LHUm735Eggerpu4MiNs
	T9c/nHx8mOgRSKtRcHZ67cVVpEYk2ejdPEy/TBBzf5WyNKfmuyMVUGIm8IquOrIHqvFL9zxP0U0
	xuKScWC4QEdnu70GuZJ2dTRVFX3aXJDN/G/7fwt1T1kXLRa/Dk62o2NxatlGU1Y6sw3tXkiT9NY
	XdpnJeAYzAr
X-Google-Smtp-Source: AGHT+IFncdAmR/J7a740biHSXXoqMDoeeJdT3ijBM6LH6v8Y3ddYemDjylEPAso/MeRvtfBZAg4MSA==
X-Received: by 2002:a05:690c:6f84:b0:78f:984b:4bd2 with SMTP id 00721157ae682-78fb4002b20mr131250087b3.42.1766536110926;
        Tue, 23 Dec 2025 16:28:30 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:d3b4:b334:ddb5:458e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f0670sm59547097b3.26.2025.12.23.16.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:28:30 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix generic/020 xfstests failure
Date: Tue, 23 Dec 2025 16:28:11 -0800
Message-Id: <20251224002810.1137139-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/020 fails to execute
correctly:

FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc4+ #8 SMP PREEMPT_DYNAMIC Thu May 1 16:43:22 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/020 _check_generic_filesystem: filesystem on /dev/loop50 is inconsistent
(see xfstests-dev/results//generic/020.full for details)

    *** add lots of attributes
    *** check
        *** MAX_ATTRS attribute(s)
        +/mnt/test/attribute_12286: Numerical result out of range
        *** -1 attribute(s)
        *** remove lots of attributes
        ...
        (Run 'diff -u /xfstests-dev/tests/generic/020.out /xfstests-dev/results//generic/020.out.bad' to see the entire diff)

The generic/020 creates more than 100 xattrs and gives its
the names user.attribute_<number> (for example, user.attribute_101).
As the next step, listxattr() is called with the goal to check
the correctness of xattrs creation. However, it was issue
in hfsplus_listxattr() logic. This method re-uses
the fd.key->attr.key_name.unicode and strbuf buffers in the loop
without re-initialization. As a result, part of the previous
name could still remain in the buffers. For example,
user.attribute_101 could be processed before user.attribute_54.
The issue resulted in formation the name user.attribute_541
instead of user.attribute_54. This patch adds initialization of
fd.key->attr.key_name.unicode and strbuf buffers before
calling hfs_brec_goto() method that prepare next name in
the buffer.

HFS+ logic supports only inline xattrs. Such extended attributes
can store values not bigger than 3802 bytes [1]. This limitation
requires correction of generic/020 logic. Finally, generic/020
can be executed without any issue:

sudo ./check generic/020
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.19.0-rc1+ #44 SMP PREEMPT_DYNAMIC Mon Dec 22 15:39:00 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/020 31s ...  38s
Ran: generic/020
Passed all 1 tests

[1] https://elixir.bootlin.com/linux/v6.19-rc2/source/include/linux/hfs_common.h#L626

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/attributes.c | 14 +++++++--
 fs/hfsplus/xattr.c      | 70 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index ba26980cc503..74b0ca9c4f17 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -117,8 +117,10 @@ static int hfsplus_attr_build_record(hfsplus_attr_entry *entry, int record_type,
 		entry->inline_data.record_type = cpu_to_be32(record_type);
 		if (size <= HFSPLUS_MAX_INLINE_DATA_SIZE)
 			len = size;
-		else
+		else {
+			hfs_dbg("value size %zu is too big\n", size);
 			return HFSPLUS_INVALID_ATTR_RECORD;
+		}
 		entry->inline_data.length = cpu_to_be16(len);
 		memcpy(entry->inline_data.raw_bytes, value, len);
 		/*
@@ -238,7 +240,11 @@ int hfsplus_create_attr(struct inode *inode,
 					inode->i_ino,
 					value, size);
 	if (entry_size == HFSPLUS_INVALID_ATTR_RECORD) {
-		err = -EINVAL;
+		if (size > HFSPLUS_MAX_INLINE_DATA_SIZE)
+			err = -E2BIG;
+		else
+			err = -EINVAL;
+		hfs_dbg("unable to store value: err %d\n", err);
 		goto failed_create_attr;
 	}
 
@@ -250,8 +256,10 @@ int hfsplus_create_attr(struct inode *inode,
 	}
 
 	err = hfs_brec_insert(&fd, entry_ptr, entry_size);
-	if (err)
+	if (err) {
+		hfs_dbg("unable to store value: err %d\n", err);
 		goto failed_create_attr;
+	}
 
 	hfsplus_mark_inode_dirty(inode, HFSPLUS_I_ATTR_DIRTY);
 
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index da95a9de9a65..504518a41212 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -345,8 +345,10 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 		if (err)
 			goto end_setxattr;
 		err = hfsplus_create_attr(inode, name, value, size);
-		if (err)
+		if (err) {
+			hfs_dbg("unable to store value: err %d\n", err);
 			goto end_setxattr;
+		}
 	} else {
 		if (flags & XATTR_REPLACE) {
 			pr_err("cannot replace xattr\n");
@@ -354,8 +356,10 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 			goto end_setxattr;
 		}
 		err = hfsplus_create_attr(inode, name, value, size);
-		if (err)
+		if (err) {
+			hfs_dbg("unable to store value: err %d\n", err);
 			goto end_setxattr;
+		}
 	}
 
 	cat_entry_type = hfs_bnode_read_u16(cat_fd.bnode, cat_fd.entryoffset);
@@ -392,9 +396,9 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 	return err;
 }
 
-static int name_len(const char *xattr_name, int xattr_name_len)
+static size_t name_len(const char *xattr_name, size_t xattr_name_len)
 {
-	int len = xattr_name_len + 1;
+	size_t len = xattr_name_len + 1;
 
 	if (!is_known_namespace(xattr_name))
 		len += XATTR_MAC_OSX_PREFIX_LEN;
@@ -402,15 +406,22 @@ static int name_len(const char *xattr_name, int xattr_name_len)
 	return len;
 }
 
-static ssize_t copy_name(char *buffer, const char *xattr_name, int name_len)
+static ssize_t copy_name(char *buffer, const char *xattr_name, size_t name_len)
 {
 	ssize_t len;
 
-	if (!is_known_namespace(xattr_name))
+	memset(buffer, 0, name_len);
+
+	if (!is_known_namespace(xattr_name)) {
 		len = scnprintf(buffer, name_len + XATTR_MAC_OSX_PREFIX_LEN,
 				 "%s%s", XATTR_MAC_OSX_PREFIX, xattr_name);
-	else
+	} else {
 		len = strscpy(buffer, xattr_name, name_len + 1);
+		if (len < 0) {
+			pr_err("fail to copy name: err %zd\n", len);
+			len = 0;
+		}
+	}
 
 	/* include NUL-byte in length for non-empty name */
 	if (len >= 0)
@@ -423,16 +434,26 @@ int hfsplus_setxattr(struct inode *inode, const char *name,
 		     const char *prefix, size_t prefixlen)
 {
 	char *xattr_name;
+	size_t xattr_name_len =
+		NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1;
 	int res;
 
-	xattr_name = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1,
-		GFP_KERNEL);
+	hfs_dbg("ino %lu, name %s, prefix %s, prefixlen %zu, "
+		"value %p, size %zu\n",
+		inode->i_ino, name ? name : NULL,
+		prefix ? prefix : NULL, prefixlen,
+		value, size);
+
+	xattr_name = kmalloc(xattr_name_len, GFP_KERNEL);
 	if (!xattr_name)
 		return -ENOMEM;
 	strcpy(xattr_name, prefix);
 	strcpy(xattr_name + prefixlen, name);
 	res = __hfsplus_setxattr(inode, xattr_name, value, size, flags);
 	kfree(xattr_name);
+
+	hfs_dbg("finished: res %d\n", res);
+
 	return res;
 }
 
@@ -579,6 +600,10 @@ ssize_t hfsplus_getxattr(struct inode *inode, const char *name,
 	int res;
 	char *xattr_name;
 
+	hfs_dbg("ino %lu, name %s, prefix %s\n",
+		inode->i_ino, name ? name : NULL,
+		prefix ? prefix : NULL);
+
 	xattr_name = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1,
 			     GFP_KERNEL);
 	if (!xattr_name)
@@ -589,6 +614,9 @@ ssize_t hfsplus_getxattr(struct inode *inode, const char *name,
 
 	res = __hfsplus_getxattr(inode, xattr_name, value, size);
 	kfree(xattr_name);
+
+	hfs_dbg("finished: res %d\n", res);
+
 	return res;
 
 }
@@ -679,8 +707,11 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	struct hfs_find_data fd;
 	struct hfsplus_attr_key attr_key;
 	char *strbuf;
+	size_t strbuf_size;
 	int xattr_name_len;
 
+	hfs_dbg("ino %lu\n", inode->i_ino);
+
 	if ((!S_ISREG(inode->i_mode) &&
 			!S_ISDIR(inode->i_mode)) ||
 				HFSPLUS_IS_RSRC(inode))
@@ -698,8 +729,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		return err;
 	}
 
-	strbuf = kzalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
-			XATTR_MAC_OSX_PREFIX_LEN + 1, GFP_KERNEL);
+	strbuf_size = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
+			XATTR_MAC_OSX_PREFIX_LEN + 1;
+	strbuf = kzalloc(strbuf_size, GFP_KERNEL);
 	if (!strbuf) {
 		res = -ENOMEM;
 		goto out;
@@ -746,6 +778,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 				res += name_len(strbuf, xattr_name_len);
 		} else if (can_list(strbuf)) {
 			if (size < (res + name_len(strbuf, xattr_name_len))) {
+				pr_err("size %zu, res %zd, name_len %zu\n",
+					size, res,
+					name_len(strbuf, xattr_name_len));
 				res = -ERANGE;
 				goto end_listxattr;
 			} else
@@ -753,6 +788,10 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 						strbuf, xattr_name_len);
 		}
 
+		memset(fd.key->attr.key_name.unicode, 0,
+			sizeof(fd.key->attr.key_name.unicode));
+		memset(strbuf, 0, strbuf_size);
+
 		if (hfs_brec_goto(&fd, 1))
 			goto end_listxattr;
 	}
@@ -761,6 +800,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	kfree(strbuf);
 out:
 	hfs_find_exit(&fd);
+
+	hfs_dbg("finished: res %zd\n", res);
+
 	return res;
 }
 
@@ -773,6 +815,9 @@ static int hfsplus_removexattr(struct inode *inode, const char *name)
 	int is_xattr_acl_deleted;
 	int is_all_xattrs_deleted;
 
+	hfs_dbg("ino %lu, name %s\n",
+		inode->i_ino, name ? name : NULL);
+
 	if (!HFSPLUS_SB(inode->i_sb)->attr_tree)
 		return -EOPNOTSUPP;
 
@@ -833,6 +878,9 @@ static int hfsplus_removexattr(struct inode *inode, const char *name)
 
 end_removexattr:
 	hfs_find_exit(&cat_fd);
+
+	hfs_dbg("finished: err %d\n", err);
+
 	return err;
 }
 
-- 
2.43.0


