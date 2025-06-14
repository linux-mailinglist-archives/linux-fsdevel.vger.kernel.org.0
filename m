Return-Path: <linux-fsdevel+bounces-51661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D614AD9A5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 08:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7B53BC109
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197161E520D;
	Sat, 14 Jun 2025 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Kluasl6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096731DB34C;
	Sat, 14 Jun 2025 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749882180; cv=none; b=oaiVWkK9fclMZm4HM+a96hF6VIa7YnO3rS+YxPfaWRrY2mb7rjFBFn3ZSJP16greZgDW1FXiYOEeD+3y8S7Ljxen+jf24s4HdmZ7fdCXKv9KNEYIqJVnufwizWsbCUHpzY650o4nUm3QKaj2mRyNs36DiolHxrDZKbVjaeLODAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749882180; c=relaxed/simple;
	bh=Z8lUnvmTnEW0PaZtMJGNzUPZQ9GMcWwHmaWlZ+yrvsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4zRtHWP3Pm2I19+x60a/+V7mUvAn7vM1FDWXNTUrXcDdM86wLBsNykpKx/DoSC/dm5sMjPiBj4ZTNMVW5lubrH55XTiRLBU+jPEYMsd1vSdUUXfLie2HjiGaYjZv2ayoJY0GK18+OE7E+sqzOz1R+PXPrIRFNA0tINWA8/wQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Kluasl6Z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vHwfGgE3DuWX2kUg/6/xwTVkKDufcqSh2iXxXHPgb+I=; b=Kluasl6ZHGhnOutTdyPwyWlE97
	3Nl5zXTtV9rG+MsbXQ1VzbVyKDtDlaPniA3gNpubuOJhuxfabqq5vRAYBP0wMCcNcoju9t+khw892
	a0NwnaGtVBYIu9KID76K9OGIAfsSgFu6J76NJ3Embo86tfc1MmFHJAtZmgl2GTuSMtbd/UzPHcbqF
	y1L1quC+G0c382htVDOUzQK7GnfEg3+zagy9uUmTOfHgtdXcbIxtAmx28NBPTGd2hK3798akL071X
	pZ0q4uOgQwVwyKbFpomNCd0wVgYVTFLat9rcYdBI8hfZMhNLZOfx4iOhn+LYafVm030QU+gQTgUq9
	a2bi5IlQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQKI5-00000002FKw-1g3g;
	Sat, 14 Jun 2025 06:22:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
	ceph-devel@vger.kernel.org
Subject: [PATCH 2/3] prep for ceph_encode_encrypted_fname() fixes
Date: Sat, 14 Jun 2025 07:22:56 +0100
Message-ID: <20250614062257.535594-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614062257.535594-1-viro@zeniv.linux.org.uk>
References: <20250614062051.GC1880847@ZenIV>
 <20250614062257.535594-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

ceph_encode_encrypted_dname() would be better off with plaintext name
already copied into buffer; we'll lift that into the callers on the
next step, which will allow to fix UAF on races with rename; for now
copy it in the very beginning of ceph_encode_encrypted_dname().

That has a pleasant side benefit - we don't need to mess with tmp_buf
anymore (i.e. that's 256 bytes off the stack footprint).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/crypto.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 9c7062245880..2aef56fc6275 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -258,31 +258,28 @@ int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
 {
 	struct ceph_client *cl = ceph_inode_to_client(parent);
 	struct inode *dir = parent;
-	struct qstr iname;
+	char *p = buf;
 	u32 len;
 	int name_len;
 	int elen;
 	int ret;
 	u8 *cryptbuf = NULL;
 
-	iname.name = d_name->name;
-	name_len = d_name->len;
+	memcpy(buf, d_name->name, d_name->len);
+	elen = d_name->len;
+
+	name_len = elen;
 
 	/* Handle the special case of snapshot names that start with '_' */
-	if ((ceph_snap(dir) == CEPH_SNAPDIR) && (name_len > 0) &&
-	    (iname.name[0] == '_')) {
-		dir = parse_longname(parent, iname.name, &name_len);
+	if (ceph_snap(dir) == CEPH_SNAPDIR && *p == '_') {
+		dir = parse_longname(parent, p, &name_len);
 		if (IS_ERR(dir))
 			return PTR_ERR(dir);
-		iname.name++; /* skip initial '_' */
+		p++; /* skip initial '_' */
 	}
-	iname.len = name_len;
 
-	if (!fscrypt_has_encryption_key(dir)) {
-		memcpy(buf, d_name->name, d_name->len);
-		elen = d_name->len;
+	if (!fscrypt_has_encryption_key(dir))
 		goto out;
-	}
 
 	/*
 	 * Convert cleartext d_name to ciphertext. If result is longer than
@@ -290,7 +287,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
 	 *
 	 * See: fscrypt_setup_filename
 	 */
-	if (!fscrypt_fname_encrypted_size(dir, iname.len, NAME_MAX, &len)) {
+	if (!fscrypt_fname_encrypted_size(dir, name_len, NAME_MAX, &len)) {
 		elen = -ENAMETOOLONG;
 		goto out;
 	}
@@ -303,7 +300,9 @@ int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
 		goto out;
 	}
 
-	ret = fscrypt_fname_encrypt(dir, &iname, cryptbuf, len);
+	ret = fscrypt_fname_encrypt(dir,
+				    &(struct qstr)QSTR_INIT(p, name_len),
+				    cryptbuf, len);
 	if (ret) {
 		elen = ret;
 		goto out;
@@ -324,18 +323,13 @@ int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
 	}
 
 	/* base64 encode the encrypted name */
-	elen = ceph_base64_encode(cryptbuf, len, buf);
-	doutc(cl, "base64-encoded ciphertext name = %.*s\n", elen, buf);
+	elen = ceph_base64_encode(cryptbuf, len, p);
+	doutc(cl, "base64-encoded ciphertext name = %.*s\n", elen, p);
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
 	WARN_ON(elen > 240);
-	if ((elen > 0) && (dir != parent)) {
-		char tmp_buf[NAME_MAX];
-
-		elen = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
-				elen, buf, dir->i_ino);
-		memcpy(buf, tmp_buf, elen);
-	}
+	if (dir != parent) // leading _ is already there; append _<inum>
+		elen += 1 + sprintf(p + elen, "_%ld", dir->i_ino);
 
 out:
 	kfree(cryptbuf);
-- 
2.39.5


