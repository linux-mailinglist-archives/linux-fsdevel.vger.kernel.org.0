Return-Path: <linux-fsdevel+bounces-32505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BB49A6FD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 18:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA36A288E1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793541F9403;
	Mon, 21 Oct 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sGul22ii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9071F8931;
	Mon, 21 Oct 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528684; cv=none; b=pGtwjOZOVqIppeucNJlVVgNeqik/kOAESjsCu8zyqe6OFDsqFhb7tyWepaKRmbDZ/rMoQwvt9lmAXxf0L00hje7h4YJWVbXxqWfDRYkwH7Eyna9oAgtFwSv7X2Xubjngl5aZk2Wttc5hupYx7OLsi74ETBJ/KJxZ94KsYX4aM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528684; c=relaxed/simple;
	bh=KfvpFCTWV0Mo9RdZWb1cD9B77MMzfROifE/8+5IKjcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tGm/ooz6jaeKS71rCxD23uAiI+HvPZLQl0d+zBjn5GpX4kfcukBrmlOAGf/pMYJXT4VZBon5C90ElfnTjqyOYyp+YLOa93QQaMeQq2FlBH5kgwwp1W/oc6L47j8EvUtmwtrnjaQQcAwXCBaxt0qkMQadmfarHeLZhZqXrUHcyMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sGul22ii; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8aBA/4S2L2Ycc2qCfgyFM1A0m9yiA602YgSs0LOAPsQ=; b=sGul22iiToBRcAg432HG8WKaK8
	OOM4ct/fDT+3GzvG1GOYF5ejXlXvNfkh4FeOox+qpLIxl65ivUMmTP1EOuWqrLhYiiaQ9sv4mm9DX
	Wmd79Eh8hZFhzmA/+cDNcyXmLChy0jNGbj0HFTFjnZGvDHv9KcLLXhTR0MzwV6y/UJjVxx+Dzw2u8
	uSKQKJIA1LGoWjDcBM9qn1bbnVYSvCu3vL9EHzcAPQIpxeVxIglUDA/RZ34N9Zf0o9aJ8fORLBc20
	EsXY7TqCHU1k9o0cOzOY5fRyWtUECSdCDaMrNdRktVOqDka7A8aSadtRtsgtKyUHyAJkewJkCTYTJ
	kDXn3ujA==;
Received: from [191.204.195.205] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t2vPs-00DECf-NR; Mon, 21 Oct 2024 18:38:00 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Mon, 21 Oct 2024 13:37:21 -0300
Subject: [PATCH v8 5/9] libfs: Export generic_ci_ dentry functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241021-tonyk-tmpfs-v8-5-f443d5814194@igalia.com>
References: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
In-Reply-To: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 Gabriel Krisman Bertazi <gabriel@krisman.be>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Export generic_ci_ dentry functions so they can be used by
case-insensitive filesystems that need something more custom than the
default one set by `struct generic_ci_dentry_ops`.

Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v4:
- Guard func signatures inside IS_ENABLED(CONFIG_UNICODE)
Changes from v3:
- New patch
---
 fs/libfs.c         | 8 +++++---
 include/linux/fs.h | 4 ++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 46966fd8bcf9f042e85d0b66134e59fbef83abfd..7b290404c5f9901010ada2f921a214dbc94eb5fa 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1791,8 +1791,8 @@ bool is_empty_dir_inode(struct inode *inode)
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
@@ -1835,6 +1835,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 
 	return utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
 }
+EXPORT_SYMBOL(generic_ci_d_compare);
 
 /**
  * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
@@ -1843,7 +1844,7 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
  *
  * Return: 0 if hash was successful or unchanged, and -EINVAL on error
  */
-static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
+int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 {
 	const struct inode *dir = READ_ONCE(dentry->d_inode);
 	struct super_block *sb = dentry->d_sb;
@@ -1858,6 +1859,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 		return -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL(generic_ci_d_hash);
 
 static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 403ee5d54c60a0a97e2eba9ef80d8fb4bbd2288f..b277369672a140eba13dce7fa7b0883359c643f8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3458,6 +3458,10 @@ extern int generic_ci_match(const struct inode *parent,
 			    const u8 *de_name, u32 de_name_len);
 
 #if IS_ENABLED(CONFIG_UNICODE)
+int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
+int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+			 const char *str, const struct qstr *name);
+
 /**
  * generic_ci_validate_strict_name - Check if a given name is suitable
  * for a directory

-- 
2.47.0


