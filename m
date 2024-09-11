Return-Path: <linux-fsdevel+bounces-29105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD3A9755EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 16:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCE31C25FB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845DD1AE86D;
	Wed, 11 Sep 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hxJKefRG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2491AD9FD;
	Wed, 11 Sep 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065947; cv=none; b=b8tUu+1NUw9LOy2tWXthBd8U8JkQwH6DIwWLu9ZbfnN14o+GJguHpq7Ha7oCZ9lyRV7JDcXeIW3cy4u41+u7bCSoCoHq9fsdjBTerHAVay5+kK+pXH5jNRiaRYhEplVeAN3Mw0pM+pMsbrNAX/W/cJ792WYKk/4omGpNlrE3DcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065947; c=relaxed/simple;
	bh=ZTyJ3+L6ldDa1N/KAPphItaNAKDuyEQ7XO8b1Li5eHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXXj8S//w+q6gofAttNoiPTYSMJBvEcC/QP0/auoBvb3ZhM3oFjCPWQTyWcbT+KvpIxngzipQnEWBT9B75MNjyAUE5cAwDOmkmpA9zScjZaU9//eq3C5fkBAz4nugT0aHiqFKwSR+Rbt7PUXj9PQWagXcppesdVzcuijf9GDDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hxJKefRG; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=B86Pw1ckCkywr9gzf5gk+joWfc2NDawEVXulB0pNBG0=; b=hxJKefRG1tjyLL745br9iC9O4A
	jcfqv+LNEBW2FgL9bLdQh841tBi7M1XJNljoL/h+w6JBZ4Qt7AHX2JQ3fILqb1kKkXydBhzZ0f/Zf
	5lQTd/bh6iYANTNNqdkhLdBaM1zx9cBpMHpmQyGAudyPYwWKf8+nLNLqCBhQrnDelY7LcUOoRIzx6
	3CVm4GH7tvWsHOn94OzODUu0C3KhOEYk153KyDh4Nh/wRDk6L28h0fmMeYJaL4Fbpp3iM0xX4PfBy
	gNWVKo1x38q654U/6UwewxkbF/8tDNc93lckRXHV2U0om76pxlBisCcYgv+MdbVwlRUe67gK3SZVA
	HSnuoh7Q==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1soObA-00CTwi-UH; Wed, 11 Sep 2024 16:45:37 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 06/10] libfs: Export generic_ci_ dentry functions
Date: Wed, 11 Sep 2024 11:44:58 -0300
Message-ID: <20240911144502.115260-7-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911144502.115260-1-andrealmeid@igalia.com>
References: <20240911144502.115260-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Export generic_ci_ dentry functions so they can be used by
case-insensitive filesystems that need something more custom than the
default one set by `struct generic_ci_dentry_ops`.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v3:
- New patch
---
 fs/libfs.c         | 8 +++++---
 include/linux/fs.h | 3 +++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 838524314b1b..c09254ecdcdd 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1783,8 +1783,8 @@ bool is_empty_dir_inode(struct inode *inode)
  *
  * Return: 0 if names match, 1 if mismatch, or -ERRNO
  */
-static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
-				const char *str, const struct qstr *name)
+int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+			 const char *str, const struct qstr *name)
 {
 	const struct dentry *parent;
 	const struct inode *dir;
@@ -1827,6 +1827,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 
 	return utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
 }
+EXPORT_SYMBOL(generic_ci_d_compare);
 
 /**
  * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
@@ -1835,7 +1836,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
  *
  * Return: 0 if hash was successful or unchanged, and -EINVAL on error
  */
-static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
+int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 {
 	const struct inode *dir = READ_ONCE(dentry->d_inode);
 	struct super_block *sb = dentry->d_sb;
@@ -1850,6 +1851,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 		return -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL(generic_ci_d_hash);
 
 static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 937142950dfe..4cd86d36c03d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3386,6 +3386,9 @@ extern int generic_ci_match(const struct inode *parent,
 			    const struct qstr *folded_name,
 			    const u8 *de_name, u32 de_name_len);
 bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *name);
+int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
+int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+			 const char *str, const struct qstr *name);
 
 static inline bool sb_has_encoding(const struct super_block *sb)
 {
-- 
2.46.0


