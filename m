Return-Path: <linux-fsdevel+bounces-4270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2497FE347
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809DD1C20445
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E192C47A58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB53PCzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544661FBC;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41392C2BCFE;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701294658;
	bh=fGkhj5/NF9UPawvhqYtWeLh70xVuDREL8YeiOyAcAQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IB53PCzW++dHYvwKAxy9kOqiyPyUek3biP1aF4qO+xxCiRDBxWIsvoQgfusBoAUhC
	 yPGQL94ljCFqKIBx4pBRDlJDGJJC8pzejcgg7fwE7cYMmyR5VIO6kgDA8G0tKWFDaE
	 bbFuPFjpreoMnn5mME0Y8Tuqs20jJ+Hd35oXKkVxID942x3Q4rW2JEJbO7adRrm0Ls
	 cGcoDHR3+4Zo/1+djNBX8tcKchb8aotvtqjnkt3ZYxbRVbtRpmndCnwzlAsXB7pY99
	 MZytrt3cW9mz5QqWcWmbRIJeZo89PVPFo/z8rRENvBWkvZteNZ/dyBKmFDFXxqH8Ov
	 6EW1MI9msi4YQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32624C4167B;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 29 Nov 2023 15:50:34 -0600
Subject: [PATCH 16/16] vfs: return -EOPNOTSUPP for fscaps from vfs_*xattr()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-16-da5a26058a5b@kernel.org>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=fGkhj5/NF9UPawvhqYtWeLh70xVuDREL8YeiOyAcAQA=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7I+wlKgt++JWupSZaBp9QGfd?=
 =?utf-8?q?Bkmz7IEI8ioxj4s_f1+aQbyJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyPgAKCRBTA5mu5fQxyTvfB/_9YWexz1iQXD9/hl9qna/DWzl4zGo/SAzZV9?=
 =?utf-8?q?yU+WAg1lMJqq4GFg0sAtqm2p8er4jQP8TEmJ1gfT+Rp_OwnKnhV4uu4HWyEr7dNuR?=
 =?utf-8?q?ZPmxzAryHGI1rMeQqZmBuQ6oItUJeIE00YEKRTgMVm18qFcraMmUQVYcD_o8vPfg2?=
 =?utf-8?q?zw4i4XaDyCATxBE4yxIWmTjTHvJxdui3jxNCN1DDq9wMrXGKX2OZsyeCDw9VhgdNL?=
 =?utf-8?q?6EYyF2_xIHyfPKGASENkIpB05s2Aq3zudSepjo7YMWyfxSC3ghhvdqjksN1MMdM8J?=
 =?utf-8?q?Ff8oAsfPKxEyobr3TadT?= DOjWk90F22+U7CvJPhBxhcP09S5qxG
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
index 372644b15457..4b779779ad8c 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -540,6 +540,9 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	const void  *orig_value = value;
 	int error;
 
+	if (!strcmp(name, XATTR_NAME_CAPS))
+		return -EOPNOTSUPP;
+
 retry_deleg:
 	inode_lock(inode);
 	error = __vfs_setxattr_locked(idmap, dentry, name, value, size,
@@ -655,6 +658,9 @@ vfs_getxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = dentry->d_inode;
 	int error;
 
+	if (!strcmp(name, XATTR_NAME_CAPS))
+		return -EOPNOTSUPP;
+
 	error = xattr_permission(idmap, inode, name, MAY_READ);
 	if (error)
 		return error;
@@ -794,6 +800,9 @@ vfs_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *delegated_inode = NULL;
 	int error;
 
+	if (!strcmp(name, XATTR_NAME_CAPS))
+		return -EOPNOTSUPP;
+
 retry_deleg:
 	inode_lock(inode);
 	error = __vfs_removexattr_locked(idmap, dentry,

-- 
2.43.0


