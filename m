Return-Path: <linux-fsdevel+bounces-12386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DEE85EACD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B188F1F233DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6CC14AD11;
	Wed, 21 Feb 2024 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKRsQRoc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9F12F5B3;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550707; cv=none; b=hCfJhxaFG5Tfcfr1kq1ZVLI8znJ1I9RlfwmnwyVIz+ZRmCTNFWiI/2xDU11RPmDK2QRUXgwW3tOBIPeeZE0mlR5bvBgQJWHXyA8ZOeUs2vOZWNJocxJKESkoF3bFoIhlLWRSaPGjvi4OfpQfXsi8sDbWafWpjGGuY4okn47xoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550707; c=relaxed/simple;
	bh=zvbUblF/TCnxaSxVn34c8qD/M35GRlC4hQ2KeRAG42o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pwPR5pnB80Y05/NSyV+T8CCBnRtFql7ZOv/ahG5Q9dq4JW8KOI24P7/Ef0uyEd3DXWUIxFiseOg7K7F7Iy2QWu6bbxszunBI3zOazP4WDlafHkzXNx9iQbBsA92GWNvisEuQunS2R5v/n1uuDlR96uAqJkoY9iL48humC5nlxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKRsQRoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68AF3C4160D;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550707;
	bh=zvbUblF/TCnxaSxVn34c8qD/M35GRlC4hQ2KeRAG42o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SKRsQRocESZKds2vMmzDujSVC0SaK+TPB9iVo2XR4q47+NE6qs231rq9rzz933lJ5
	 oPVzUdevmGiNU9XRdwvvFnMaFD1ajdUz3cg/gsMYIk9Y4aVeS3vFCAjku65uyfG3Do
	 su9OTtRzMfobX+5JdtwaJjMHr4k49WoRZY4SgkF52OWD63ZsSUUvHJwPlsmICJ0ahH
	 8fBe0zR8kwd0wtnJ+mqSGj9Nl2YRaen+lV7gGxd0aD7DA6IXBiQK4WRRkOw5QmwAUc
	 jcxuZZAtzdHfaz3fHsCRfBb4H0Im2TZYioWp185DZbzBfKIhCVqwcm/1bwCa6TUEtB
	 ePUEa8FJldjMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EA3C5478C;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:55 -0600
Subject: [PATCH v2 24/25] commoncap: use vfs fscaps interfaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2792; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=zvbUblF/TCnxaSxVn34c8qD/M35GRlC4hQ2KeRAG42o=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1motMsHmTPRzonCbUf17MUmkA?=
 =?utf-8?q?trgRQQP52t1limF_xnRCVamJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqLQAKCRBTA5mu5fQxySjhB/_9/xvaR6j6ROnXfKTxmKnKxnszhmNMXT1obo?=
 =?utf-8?q?WqLVttCDoIEShnCN3jNsyIpALo6DQpAxED7nadYlW2F_vDcaQlOVAqpLDZExtPdSn?=
 =?utf-8?q?IAd61AuZiTbo96dmmNv46xSZbKz4YFtYStNCCynSuEuJ6T5hDfXI8ZC7l_D++5+5X?=
 =?utf-8?q?5lQSz00p/UyCKeSsMVATo8TLtwEQ0z6Z+55owxbqadtCXLzeeT9jYnv43ixJny2K5?=
 =?utf-8?q?DFwAT/_ONWSTYt66Dh/JR/D5nJ8mlOrqPvXlnOYpONu68LvMfAd5c3IWAYp3NeQYi?=
 =?utf-8?q?6GFXjBbQuE0sXInhC7rb?= xFOguuTz0t3YgEiStWMwzbqX0R1zY8
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Use the vfs interfaces for fetching file capabilities for killpriv
checks and from get_vfs_caps_from_disk(). While there, update the
kerneldoc for get_vfs_caps_from_disk() to explain how it is different
from vfs_get_fscaps_nosec().

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 security/commoncap.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index a0ff7e6092e0..751bb26a06a6 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
  */
 int cap_inode_need_killpriv(struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct vfs_caps caps;
 	int error;
 
-	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
-	return error > 0;
+	/* Use nop_mnt_idmap for no mapping here as mapping is unimportant */
+	error = vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry, &caps);
+	return error == 0;
 }
 
 /**
@@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
 {
 	int error;
 
-	error = __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS);
+	error = vfs_remove_fscaps_nosec(idmap, dentry);
 	if (error == -EOPNOTSUPP)
 		error = 0;
 	return error;
@@ -719,6 +720,10 @@ ssize_t vfs_caps_to_user_xattr(struct mnt_idmap *idmap,
  * @cpu_caps:	vfs capabilities
  *
  * Extract the on-exec-apply capability sets for an executable file.
+ * For version 3 capabilities xattrs, returns the capabilities only if
+ * they are applicable to current_user_ns() (i.e. that the rootid
+ * corresponds to an ID which maps to ID 0 in current_user_ns() or an
+ * ancestor), and returns -ENODATA otherwise.
  *
  * If the inode has been found through an idmapped mount the idmap of
  * the vfsmount must be passed through @idmap. This function will then
@@ -731,25 +736,16 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   struct vfs_caps *cpu_caps)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	int size, ret;
-	struct vfs_ns_cap_data data, *nscaps = &data;
+	int ret;
 
 	if (!inode)
 		return -ENODATA;
 
-	size = __vfs_getxattr((struct dentry *)dentry, inode,
-			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
-	if (size == -ENODATA || size == -EOPNOTSUPP)
+	ret = vfs_get_fscaps_nosec(idmap, (struct dentry *)dentry, cpu_caps);
+	if (ret == -EOPNOTSUPP || ret == -EOVERFLOW)
 		/* no data, that's ok */
-		return -ENODATA;
+		ret = -ENODATA;
 
-	if (size < 0)
-		return size;
-
-	ret = vfs_caps_from_xattr(idmap, inode->i_sb->s_user_ns,
-				  cpu_caps, nscaps, size);
-	if (ret == -EOVERFLOW)
-		return -ENODATA;
 	if (ret)
 		return ret;
 

-- 
2.43.0


