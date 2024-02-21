Return-Path: <linux-fsdevel+bounces-12387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 551A385EACC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC8D285C57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C66214AD0F;
	Wed, 21 Feb 2024 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRSh2cwD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8A12FB30;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550707; cv=none; b=HboMgOmEtxyZzmQz11Tm7Lk3fo3OuwWTst9YoQPvjuqUbl1ovYXElMcqjWaFejy/0pUv0+5EApHPNM48ZUjBws14w5Mls7QdQs3v/XNUMXQmTaIxGc78Ld+sgw+BnS6RtN90fkGEZGsu8xD07qaLbi5Hh459XOZ1lbiqf02K6EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550707; c=relaxed/simple;
	bh=JkAYnCkvvJdZGpxH4b0zbmLDehUJl7XVpS/k3t/jU9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6PhMTWwGgklOkwQJCKeHQcxiEedR+0GdGaerzK943HYZmQ6J6MP9aSW6RMmqCzXfH368n/FRkpQR74HO///+emAlOr5AjC0QoPvhUaIIAGoXFbMyW8xa6r9K35irZhu4cSmN9dLwNLs2+09gAkxMh3LThm1I+Q9UK3D6C8Qp7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRSh2cwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73227C41679;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550707;
	bh=JkAYnCkvvJdZGpxH4b0zbmLDehUJl7XVpS/k3t/jU9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BRSh2cwDivQmO5cvnVkqxeC7Nu/3tUOtiCSGbP9nzwTtRBOai53XjC60y7iBHWVCL
	 Dx94tHN+ntUevMHXYVUbAS96T3OzjNnBeM8g6bT+w0cgsa+m/9GIMoWSOpL3L109Dy
	 p/jRXZVKK3Qjitov8q4GUy+frcJTU6YE5Ie3LnK3jmqZAXOJeDLPo4jOozcggPjlcT
	 bz3P6FSFwLZzaSt/6n//M6/PaXd4R8vES39SkmRstrtljgGBEWOAKbkiv5Bhk6T9n2
	 Pw+aGyaiA2KT1m8IKWHDlgRepdSTF3fyENURSQ5hgUUZSI7XfpBd46oydQjBI3KyjM
	 z/g84a8N8kCRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6283CC48BEB;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:56 -0600
Subject: [PATCH v2 25/25] vfs: return -EOPNOTSUPP for fscaps from
 vfs_*xattr()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-25-3039364623bd@kernel.org>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
In-Reply-To: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Seth Forshee <sforshee@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=JkAYnCkvvJdZGpxH4b0zbmLDehUJl7XVpS/k3t/jU9U=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1mouT6WPJX7a66eMZi03rVY0Q?=
 =?utf-8?q?ujcBq9Oshkq0LfM_Tuo4JCOJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqLgAKCRBTA5mu5fQxyYCgB/_945jyUfmMhsxGudorl5vI3QR/Ixu+abEbAK?=
 =?utf-8?q?QoQWFIgQCflgI7lEzlE8Gpqk4PF6fP+Z4ZfP0ipIhZW_Hvcg61i4lw3bmENsZEOVv?=
 =?utf-8?q?ExwPI4miDqPaQYM5MgS72JjInytlPLdJ5J9YHHPBvYMhUlUJvF4NzVBC1_9E242eb?=
 =?utf-8?q?zj+LwCGygOgJWhED2lY/Hb6uyrRFm1Cz7HpnhwU6iLvmwzI2zV1OW2VbkuTMnKBAY?=
 =?utf-8?q?o6R6P4_c+pauDINbyl1S9IwKjV1/Nmp3njKa6CF4FcIE+hdhnDFMdvpB7KmRK/3vS?=
 =?utf-8?q?9yDqlhgFpDIuqkf8wNp7?= kOXGHoNmPjZ5soY0mZi+wE1d1xksOV
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Now that the new vfs-level interfaces are fully supported and all code
has been converted to use them, stop permitting use of the top-level vfs
xattr interfaces for capabilities xattrs. Unlike with ACLs we still need
to be able to work with fscaps xattrs using lower-level interfaces in a
handful of places, so only use of the top-level xattr interfaces is
restricted.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 fs/xattr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 30eff6bc4f6d..2b8214c9534f 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -534,6 +534,9 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	const void  *orig_value = value;
 	int error;
 
+	if (WARN_ON_ONCE(is_fscaps_xattr(name)))
+		return -EOPNOTSUPP;
+
 retry_deleg:
 	inode_lock(inode);
 	error = __vfs_setxattr_locked(idmap, dentry, name, value, size,
@@ -649,6 +652,9 @@ vfs_getxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = dentry->d_inode;
 	int error;
 
+	if (WARN_ON_ONCE(is_fscaps_xattr(name)))
+		return -EOPNOTSUPP;
+
 	error = xattr_permission(idmap, inode, name, MAY_READ);
 	if (error)
 		return error;
@@ -788,6 +794,9 @@ vfs_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *delegated_inode = NULL;
 	int error;
 
+	if (WARN_ON_ONCE(is_fscaps_xattr(name)))
+		return -EOPNOTSUPP;
+
 retry_deleg:
 	inode_lock(inode);
 	error = __vfs_removexattr_locked(idmap, dentry,

-- 
2.43.0


