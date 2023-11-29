Return-Path: <linux-fsdevel+bounces-4263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D597FE36C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3367BB20EE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFC547A54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co0OX5ej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3115661688;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C45EEC433CA;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701294657;
	bh=pshpKEfVriw6XfSjr2t+lrLZ+CyfWDF9L4xfhlBHrcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=co0OX5ejSAjxdjCRGV053V24U5RgKX2l/Io7Vacy5dpOOz9UAwVIxRY1Pwi9qrSlO
	 CUYKbNPcHTDCvKK8U1OMeLu9xt27bRtI9bLmGQ0GSjSX3CHoUVVho6/Lw4tNx1uELb
	 JpZN+Fzg4axO3P5GFGGBXiBFhjM9o8rSxaSd6U8kJChzHLapD8trde+hTp+POUSeZX
	 wUozMWHsXZFrZA/d5IuJaNirfQnsXY6138dKZvAlo0gNyODwmNAlD6sz3HVDu4UwYc
	 X92xKVmx6eZa58uxzSUCBQtq1LNL9PeMvCjwR27WqpIOrGQz+NP0uiVzRB7RdLnUR4
	 WXzv8VJsDIPPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE91BC46CA3;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 29 Nov 2023 15:50:22 -0600
Subject: [PATCH 04/16] capability: use vfsuid_t for vfs_caps rootids
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-4-da5a26058a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2769; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=pshpKEfVriw6XfSjr2t+lrLZ+CyfWDF9L4xfhlBHrcs=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7I1iMJZHgv5KLLN6DNVYz1Vf?=
 =?utf-8?q?vJSI5vw8+yI5Cgd_aAZEAPOJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyNQAKCRBTA5mu5fQxyQDFB/_9RqEyCcUph8c316tvppHNjQ/llSAMODIXsN?=
 =?utf-8?q?mSqJwy2aZcJXvBbUuIv4/NOLvqxn+j55KG7FdjvArP6_c28uf+EKMJh7cJKxKtKEy?=
 =?utf-8?q?zRdd4va3XJnkesTaNAJHo9zcx5lvZkMOBm6ZCiA29WXKAxqzadC/Vy+98_ztZZA0m?=
 =?utf-8?q?1c90VhmCi+uMTrJTwT6jdc1a43GfX/jcKBtSS/HL2EyRZdayOURPL8gQVezzv60r8?=
 =?utf-8?q?766ssp_4TLrCTABo8230NrJ7xA4Kg7tvAs7mtrvnBv2Q08sS71+xjhIXoYLYqGtmT?=
 =?utf-8?q?+k0Q0p8nB9TlHk06W9aH?= 6B7k5FVQmj3qXUOjyE3FbILXAuBOru
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

The rootid is a kuid_t, but it contains an id which maped into a mount
idmapping, so it is really a vfsuid. This is confusing and creates
potential for misuse of the value, so change it to vfsuid_t.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 include/linux/capability.h | 3 ++-
 kernel/auditsc.c           | 5 +++--
 security/commoncap.c       | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index c24477e660fc..eb46d346bbbc 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -16,6 +16,7 @@
 #include <uapi/linux/capability.h>
 #include <linux/uidgid.h>
 #include <linux/bits.h>
+#include <linux/vfsid.h>
 
 #define _KERNEL_CAPABILITY_VERSION _LINUX_CAPABILITY_VERSION_3
 
@@ -26,7 +27,7 @@ typedef struct { u64 val; } kernel_cap_t;
 /* same as vfs_ns_cap_data but in cpu endian and always filled completely */
 struct vfs_caps {
 	__u32 magic_etc;
-	kuid_t rootid;
+	vfsuid_t rootid;
 	kernel_cap_t permitted;
 	kernel_cap_t inheritable;
 };
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 783d0bf69ca5..65691450b080 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -65,6 +65,7 @@
 #include <uapi/linux/netfilter/nf_tables.h>
 #include <uapi/linux/openat2.h> // struct open_how
 #include <uapi/linux/fanotify.h>
+#include <linux/mnt_idmapping.h>
 
 #include "audit.h"
 
@@ -2260,7 +2261,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 	name->fcap.permitted = caps.permitted;
 	name->fcap.inheritable = caps.inheritable;
 	name->fcap.fE = !!(caps.magic_etc & VFS_CAP_FLAGS_EFFECTIVE);
-	name->fcap.rootid = caps.rootid;
+	name->fcap.rootid = AS_KUIDT(caps.rootid);
 	name->fcap_ver = (caps.magic_etc & VFS_CAP_REVISION_MASK) >>
 				VFS_CAP_REVISION_SHIFT;
 
@@ -2816,7 +2817,7 @@ int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
 	ax->fcap.permitted = vcaps.permitted;
 	ax->fcap.inheritable = vcaps.inheritable;
 	ax->fcap.fE = !!(vcaps.magic_etc & VFS_CAP_FLAGS_EFFECTIVE);
-	ax->fcap.rootid = vcaps.rootid;
+	ax->fcap.rootid = AS_KUIDT(vcaps.rootid);
 	ax->fcap_ver = (vcaps.magic_etc & VFS_CAP_REVISION_MASK) >> VFS_CAP_REVISION_SHIFT;
 
 	ax->old_pcap.permitted   = old->cap_permitted;
diff --git a/security/commoncap.c b/security/commoncap.c
index cf130d81b8b4..3d045d377e5e 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -710,7 +710,7 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 	cpu_caps->permitted.val &= CAP_VALID_MASK;
 	cpu_caps->inheritable.val &= CAP_VALID_MASK;
 
-	cpu_caps->rootid = vfsuid_into_kuid(rootvfsuid);
+	cpu_caps->rootid = rootvfsuid;
 
 	return 0;
 }

-- 
2.43.0


