Return-Path: <linux-fsdevel+bounces-41769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D612EA36C0B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 05:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A1F3B2089
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 04:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB32617BEC6;
	Sat, 15 Feb 2025 04:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rkaH3DJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006E144304;
	Sat, 15 Feb 2025 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739594838; cv=none; b=oBIMq/C+Pk5SXUjF4FsKmvvR2p+QGh8+hbeUpRclD72V/fAkIaQwGD3iRRVIrl5FlM3o9gw5VNqQiHgF55s5OImeVq41XN5uxrbFI51uz+5iiLqiWQx+HeK+k2M+jrCtfm5y/bW6rzbz1pVGTAVlE+WsPayfSvUfDT/VZOPajdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739594838; c=relaxed/simple;
	bh=HFqKMva8+Z+bMpx2Ehe1I/vJjzTyoTvypqoctgVwino=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVjXxr/8K6HGcKPYTePQcf+Q+fpGoyjMWX0kurjy4mJOX0Lhqabk0kmwpByh1kMYqr9oGA5aLTVzW1iki63HaUMsvuQ18Kc2yxrJNm8EQnhXameWjqCaEjqXqTgPi5yQ+WJR2uPxq2YwA6FA9KtJBScsJBGxcim/X6UH2HPufn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rkaH3DJl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qH8AFVKjadvyuAUj4NQY6J7bP8Eo1qPBjmKrP3eLRoU=; b=rkaH3DJlExOjwsh9UgqmpruW2C
	eduU4xOmtThnNMeKP+ub3tbmOiHiN6/RJO7aqUad0ShFAsKoEsufl0q6qWFkW5DE8BeIvGDBvWaj4
	OpfIJ77ACDnD+jcO6oUv4ZMSXKzP/ybK+ufcRpW12d239JcIJnSlNjV4+An5YSMpMvWKgw//wJRs5
	v0G/zDFU9s008MnRIQkV14bNOnPGyqG2b5uIfl9a9zjzXBNy+kcmYg7bUnyNxwQTYC5lBmB6dwo8w
	G2RtwQD9ifAFpIeIOlQQ3L9fHY75Q4dQc7dufcXnzYKAiISdhLw2gq3wX1Ao3upWJMLczemJZhXPp
	k7zzIOig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tjA5C-0000000ETpV-08oW;
	Sat, 15 Feb 2025 04:47:14 +0000
Date: Sat, 15 Feb 2025 04:47:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Luis Henriques <luis@igalia.com>
Cc: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/2] prep for ceph_encode_encrypted_fname() fixes
Message-ID: <20250215044714.GA3451131@ZenIV>
References: <20250214024756.GY1977892@ZenIV>
 <20250214032820.GZ1977892@ZenIV>
 <bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
 <87frkg7bqh.fsf@igalia.com>
 <20250215044616.GF1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215044616.GF1977892@ZenIV>
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
index 3b3c4d8d401e..09346b91215a 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -265,31 +265,28 @@ int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
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
@@ -297,7 +294,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
 	 *
 	 * See: fscrypt_setup_filename
 	 */
-	if (!fscrypt_fname_encrypted_size(dir, iname.len, NAME_MAX, &len)) {
+	if (!fscrypt_fname_encrypted_size(dir, name_len, NAME_MAX, &len)) {
 		elen = -ENAMETOOLONG;
 		goto out;
 	}
@@ -310,7 +307,9 @@ int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
 		goto out;
 	}
 
-	ret = fscrypt_fname_encrypt(dir, &iname, cryptbuf, len);
+	ret = fscrypt_fname_encrypt(dir,
+				    &(struct qstr)QSTR_INIT(p, name_len),
+				    cryptbuf, len);
 	if (ret) {
 		elen = ret;
 		goto out;
@@ -331,18 +330,13 @@ int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
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


