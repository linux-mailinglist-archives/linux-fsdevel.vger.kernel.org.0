Return-Path: <linux-fsdevel+bounces-13162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BCB86C0AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 07:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574A31C21779
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 06:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E046A3FB81;
	Thu, 29 Feb 2024 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NtcxpZTA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ECD2E84E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188226; cv=none; b=A/Nd1aF8H6uK6y/d5Vr25WZXVGuQpGn0mbpavt55u+mueOXEQIQpqf3tnEk2yOZ0V+m0A3LuqzfU8E10c/5MxmP+qNPXGdDJVHnZopd7fGqJAvCnGGDYddZsVWNHhYpQ13FCYSfp088QdnSP+i5YaR+yPiD96zkRNvgS8+OuYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188226; c=relaxed/simple;
	bh=zc++rSEgIte20IU1DSUqtOIngxzlayCbuNTi3VW1T1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeS714HDcIEUoLGYiqUedaXpc161izwroFS0q+aoKSBKQJXIx93N4tx06m8y6y56NEcUoKo3Az88jbdSfCkXETUnLMso6bt12MCW++Si9G6K8mwueBm/2f+JCoRM4hgDzjR9uRpe/il9MC/VBtRjNiOcdu2LIoulj0L+CcUF1H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NtcxpZTA; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709188221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpFw2wfIL1AaDoZCM80wHi/fZPptUoriqJ95nshkpvo=;
	b=NtcxpZTAnVzvPVaLDAdRWtkTVcMxJIKHgoXINNbLjZ20ZZnqs05GnFI6+eauhW0VUV0LKu
	JVAcQ9ltWxFndpYOwQH8QXCzX4sKH/D47gdDIP2njlrCSEhUoHowG9AjyVhyO/ThLURU9L
	B7QxYnFjNXAbpdjWt6wU13CxE1LV4oE=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	david@fromorbit.com,
	mcgrof@kernel.org,
	torvalds@linux-foundation.org,
	hch@lst.de,
	willy@infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 1/2] fs: file_remove_privs_flags()
Date: Thu, 29 Feb 2024 01:30:07 -0500
Message-ID: <20240229063010.68754-2-kent.overstreet@linux.dev>
In-Reply-To: <20240229063010.68754-1-kent.overstreet@linux.dev>
References: <20240229063010.68754-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename and export __file_remove_privs(); for a buffered write path that
doesn't take the inode lock we need to be able to check if the operation
needs to do work first.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
---
 fs/inode.c         | 7 ++++---
 include/linux/fs.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 91048c4c9c9e..b465afdbfcef 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2031,7 +2031,7 @@ static int __remove_privs(struct mnt_idmap *idmap,
 	return notify_change(idmap, dentry, &newattrs, NULL);
 }
 
-static int __file_remove_privs(struct file *file, unsigned int flags)
+int file_remove_privs_flags(struct file *file, unsigned int flags)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = file_inode(file);
@@ -2056,6 +2056,7 @@ static int __file_remove_privs(struct file *file, unsigned int flags)
 		inode_has_no_xattr(inode);
 	return error;
 }
+EXPORT_SYMBOL_GPL(file_remove_privs_flags);
 
 /**
  * file_remove_privs - remove special file privileges (suid, capabilities)
@@ -2068,7 +2069,7 @@ static int __file_remove_privs(struct file *file, unsigned int flags)
  */
 int file_remove_privs(struct file *file)
 {
-	return __file_remove_privs(file, 0);
+	return file_remove_privs_flags(file, 0);
 }
 EXPORT_SYMBOL(file_remove_privs);
 
@@ -2161,7 +2162,7 @@ static int file_modified_flags(struct file *file, int flags)
 	 * Clear the security bits if the process is not being run by root.
 	 * This keeps people from modifying setuid and setgid binaries.
 	 */
-	ret = __file_remove_privs(file, flags);
+	ret = file_remove_privs_flags(file, flags);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1fbc72c5f112..14ea66b62823 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3004,6 +3004,7 @@ extern struct inode *new_inode_pseudo(struct super_block *sb);
 extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int setattr_should_drop_suidgid(struct mnt_idmap *, struct inode *);
+extern int file_remove_privs_flags(struct file *file, unsigned int flags);
 extern int file_remove_privs(struct file *);
 int setattr_should_drop_sgid(struct mnt_idmap *idmap,
 			     const struct inode *inode);
-- 
2.43.0


