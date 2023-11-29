Return-Path: <linux-fsdevel+bounces-4276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CB37FE34D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF56F2821FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A937C47A55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQIMu9V0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA393B1BE;
	Wed, 29 Nov 2023 21:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCC2EC433CC;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701294658;
	bh=TIgQ5CbkliqAVMldXf5Py2rYlW1ruP/xbtTpoJwKMY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fQIMu9V0oT8xUK0GL+HsYCv1d6LOK+fR4jAaYG8Do89RGP+xAS7dBjCHFKKlCb+9C
	 lezD6IPNQGoRz+LXbUElA8DxWqLKijC0oA3S4flAeQAILZVmC4E+4i6aR4tPWvP8Yd
	 199/qQn8/qv0DO4UKHiGYgs8YDavd/NKnQCC+Y5Gn4Va2T44He7/pvBvafz38/2Lca
	 tV7UWIJ0J87nZiWdQyi5ofbpPMxWL9VL6Q3cYoxQYbUUPtnCOUgJUA6MfrTtuU2p9Z
	 6rQlVXJe5XKOJHHk4sx4wYcgzIilxUqryDHbNXdas4D+z9VYj3B1gMvu/MMGV72ue/
	 0E41N/P3bGGeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D51C10DC2;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 29 Nov 2023 15:50:21 -0600
Subject: [PATCH 03/16] capability: rename cpu_vfs_cap_data to vfs_caps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-3-da5a26058a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3448; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=TIgQ5CbkliqAVMldXf5Py2rYlW1ruP/xbtTpoJwKMY8=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7I0nwuW1xpac3xkFjSxN46Ko?=
 =?utf-8?q?GJvViTQQr5z+iz5_Wk9fgqyJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyNAAKCRBTA5mu5fQxyaNwB/_9pyZQEBnedvrvYiYrFWuw3BEQLrhwzPeP+j?=
 =?utf-8?q?XU2KRZgr6vrzRbFlDtNuNLFIBATPoVujyOCLkUK7H+f_88lE3d/IbtjndsgxfUqO4?=
 =?utf-8?q?TK/qiimK2hWIqmPKh2moxUobyRKRFeZqZyjXt3tN73mRM6/6ip9yTWhXi_w9Tagm/?=
 =?utf-8?q?A2MzQBmlYG/S003GXBPgisL/bWyg0XaQMqt6pSFNEzG6a/OmHE+fIxUWKIQmNvfVn?=
 =?utf-8?q?XfwqH3_4xF2MKBcZI5Mi3fIVSJlEUD/7vjTTKelJa9ZqUYbjF+AL28JxwDjvHdvF0?=
 =?utf-8?q?VE5Rdweg/uJpBt9jyE1v?= 0o/JdYEKaL3Qh3x94fc5HOxAJ3GcBV
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

vfs_caps is a more generic name which is better suited to the broader
use this struct will see in subsequent commits.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 include/linux/capability.h | 4 ++--
 kernel/auditsc.c           | 4 ++--
 security/commoncap.c       | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 0c356a517991..c24477e660fc 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -24,7 +24,7 @@ extern int file_caps_enabled;
 typedef struct { u64 val; } kernel_cap_t;
 
 /* same as vfs_ns_cap_data but in cpu endian and always filled completely */
-struct cpu_vfs_cap_data {
+struct vfs_caps {
 	__u32 magic_etc;
 	kuid_t rootid;
 	kernel_cap_t permitted;
@@ -211,7 +211,7 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 /* audit system wants to get cap info from files as well */
 int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   const struct dentry *dentry,
-			   struct cpu_vfs_cap_data *cpu_caps);
+			   struct vfs_caps *cpu_caps);
 
 int cap_convert_nscap(struct mnt_idmap *idmap, struct dentry *dentry,
 		      const void **ivalue, size_t size);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523f..783d0bf69ca5 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2247,7 +2247,7 @@ void __audit_getname(struct filename *name)
 static inline int audit_copy_fcaps(struct audit_names *name,
 				   const struct dentry *dentry)
 {
-	struct cpu_vfs_cap_data caps;
+	struct vfs_caps caps;
 	int rc;
 
 	if (!dentry)
@@ -2800,7 +2800,7 @@ int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
 {
 	struct audit_aux_data_bprm_fcaps *ax;
 	struct audit_context *context = audit_context();
-	struct cpu_vfs_cap_data vcaps;
+	struct vfs_caps vcaps;
 
 	ax = kmalloc(sizeof(*ax), GFP_KERNEL);
 	if (!ax)
diff --git a/security/commoncap.c b/security/commoncap.c
index 8e8c630ce204..cf130d81b8b4 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -583,7 +583,7 @@ int cap_convert_nscap(struct mnt_idmap *idmap, struct dentry *dentry,
  * Calculate the new process capability sets from the capability sets attached
  * to a file.
  */
-static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
+static inline int bprm_caps_from_vfs_caps(struct vfs_caps *caps,
 					  struct linux_binprm *bprm,
 					  bool *effective,
 					  bool *has_fcap)
@@ -634,7 +634,7 @@ static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
  */
 int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   const struct dentry *dentry,
-			   struct cpu_vfs_cap_data *cpu_caps)
+			   struct vfs_caps *cpu_caps)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	__u32 magic_etc;
@@ -645,7 +645,7 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 	vfsuid_t rootvfsuid;
 	struct user_namespace *fs_ns;
 
-	memset(cpu_caps, 0, sizeof(struct cpu_vfs_cap_data));
+	memset(cpu_caps, 0, sizeof(struct vfs_caps));
 
 	if (!inode)
 		return -ENODATA;
@@ -724,7 +724,7 @@ static int get_file_caps(struct linux_binprm *bprm, const struct file *file,
 			 bool *effective, bool *has_fcap)
 {
 	int rc = 0;
-	struct cpu_vfs_cap_data vcaps;
+	struct vfs_caps vcaps;
 
 	cap_clear(bprm->cred->cap_permitted);
 

-- 
2.43.0


