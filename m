Return-Path: <linux-fsdevel+bounces-12371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F6785EAA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E174B276B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD851350CD;
	Wed, 21 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE5GYKrN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA1129A8D;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550706; cv=none; b=hlK3VS9pe3vS8yvfj6p1JgKAw1i++EvxUKM9r2uLCFfTawzXh1aUUYaxcEPaZtN8NDRjnFibz2GGFQ2bXtodeT4ciDAqwiKcCqdT+e/ffwwnZxNaGirOogw/ACLF/zusf48N+svsZwe6IbRVA9tEvFvTxfnVK/EudO6j+r1yjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550706; c=relaxed/simple;
	bh=pUWNt9mRsWKZJ1yXibvTabhp6NyYRplMYf4ol2PV1qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=myVhcc/Iz1ClZYr66H2sFLie8UTmCTDeYLHO1hr/dkFtGfOEcZS/XNdx+mdZrgR70f8Lrk8tG+fa9H9PIwC0fHG3aafF0Ju/vNWwx/GV9M9nfBIgOpp6TlJ/0Vua29DjZbxlKQ4m0WwL+As7HkdlNUY4K33S/feof2s/W/SHS40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE5GYKrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88E21C3278A;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550706;
	bh=pUWNt9mRsWKZJ1yXibvTabhp6NyYRplMYf4ol2PV1qs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OE5GYKrNXbhCRoyzeq1Uxwh+7AvoyiVU4RFHWWAkBoyH2PSfR8louMEYypCkFSBHp
	 /QK88SLmFCXh8vrQRwW+V2vYmQew9jhciIYuZIwtD6xTZjSIyY1SE3xc655mOeYw1K
	 fw6eKTosn8jH4AMfW10Lsbdwxj/xat0kDSqrBjrzfKG+wqDiStz/Dt/Wvp0ddA9006
	 TWwXHU7e+0tqwxbmUtQi3P2onMllhLHQvTIIMzq1bttKhrawupE4GXNXfGp+rOVXV9
	 kheVg+z1IPObzaqroVcFaD9glXefaelF990s79FRkFSxhQabeAsHZZj5NNSuc2QG4P
	 QLQVMHn9/W5BA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D09C5478C;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:43 -0600
Subject: [PATCH v2 12/25] selinux: add hooks for fscaps operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-12-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=pUWNt9mRsWKZJ1yXibvTabhp6NyYRplMYf4ol2PV1qs=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1mojvJhyZw9emud3TEu0eTTg0?=
 =?utf-8?q?ZvRpxQbx/wYTlv3_1foWLWqJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqIwAKCRBTA5mu5fQxyUwiB/_94Hwww+Nvwr2i0mm92V1m/muLDxNZ3ichSg?=
 =?utf-8?q?SbVTXRmFnGLWiqqjMZl3IjV8bIU9kY0uE4x7zfEpBpX_rTcdD3t9JeMPtm8WcBoFc?=
 =?utf-8?q?lqIlyRYkgBIkPLFiY2Vb+GmlW/HPp0p7gXrkdXLnqRb2JLOEGjY3ReRrm_gx2B15b?=
 =?utf-8?q?lpH1tEHAitlNwTMg6Wlt+MkUqvPIXsiYP4hseEFG3GRmrmtLK8VDfPFmy0HO4Mkay?=
 =?utf-8?q?GhMzDS_piT9CYjbYEIlnSpJFWwC7agQMDtzoUNqlU4zRIOSjOTGd+/O8lHnI0mqol?=
 =?utf-8?q?xe+jhCS0DXiQ3StnEUTj?= AJXJqyr0z/OYbUCf//HFYSGghhbxur
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Add hooks for set/get/remove fscaps operations which perform the same
checks as the xattr hooks would have done for XATTR_NAME_CAPS.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 security/selinux/hooks.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a6bf90ace84c..da129a387b34 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3367,6 +3367,29 @@ static int selinux_inode_removexattr(struct mnt_idmap *idmap,
 	return -EACCES;
 }
 
+static int selinux_inode_set_fscaps(struct mnt_idmap *idmap,
+				    struct dentry *dentry,
+				    const struct vfs_caps *caps, int flags)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+}
+
+static int selinux_inode_get_fscaps(struct mnt_idmap *idmap,
+				    struct dentry *dentry)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
+}
+
+static int selinux_inode_remove_fscaps(struct mnt_idmap *idmap,
+				       struct dentry *dentry)
+{
+	int rc = cap_inode_removexattr(idmap, dentry, XATTR_NAME_CAPS);
+	if (rc)
+		return rc;
+
+	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+}
+
 static int selinux_path_notify(const struct path *path, u64 mask,
 						unsigned int obj_type)
 {
@@ -7165,6 +7188,9 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_set_acl, selinux_inode_set_acl),
 	LSM_HOOK_INIT(inode_get_acl, selinux_inode_get_acl),
 	LSM_HOOK_INIT(inode_remove_acl, selinux_inode_remove_acl),
+	LSM_HOOK_INIT(inode_set_fscaps, selinux_inode_set_fscaps),
+	LSM_HOOK_INIT(inode_get_fscaps, selinux_inode_get_fscaps),
+	LSM_HOOK_INIT(inode_remove_fscaps, selinux_inode_remove_fscaps),
 	LSM_HOOK_INIT(inode_getsecurity, selinux_inode_getsecurity),
 	LSM_HOOK_INIT(inode_setsecurity, selinux_inode_setsecurity),
 	LSM_HOOK_INIT(inode_listsecurity, selinux_inode_listsecurity),

-- 
2.43.0


