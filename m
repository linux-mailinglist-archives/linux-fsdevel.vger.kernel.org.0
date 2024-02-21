Return-Path: <linux-fsdevel+bounces-12367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2FB85EA9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF01B27586
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB1E1339A2;
	Wed, 21 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjwxMbdv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B73128394;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550706; cv=none; b=Q4q8JKsmPlno6NaoZkrWCcxn1MSitML1Zes745M4k/I2ohzcWTulvSU+Ae+Mw0yovjndjFXDEdggd18tE4VAj/cUGRAn8456kYzcRhRjlkVcPkHjUY62s597aHe7nzqfEJsqXrcTFCk1oS4lyZU6o0JKhn5UIFLbCbSa2633Vt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550706; c=relaxed/simple;
	bh=YMHnxXBEI/P1sDB6/aXu4KjyTt4t2HZBNesMC/3zNhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DlgR4cYhTE+BjJubSU8YMlbKueXkTuvxL+OqT/ys4zNA0pIowotpo+9642R0bMYVXdkyWmc+ZAxPY+vcKKPdvXujaFJ4CCF+NwxSPBShVo+uTLFoE/e2OJpcSJA0GsKCu5cuDIJluZ0yuBnTXm2fQytvQN2y3kq4um1ZCpLAOWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjwxMbdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA736C43142;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550705;
	bh=YMHnxXBEI/P1sDB6/aXu4KjyTt4t2HZBNesMC/3zNhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XjwxMbdvpIklZ8ZuHRgo1ZSr3vrHNwetBmLgeLQE2/bMuolrgZlbTjx8oPW9vwdgi
	 cLmH0Q2OwPUDxt0zRKR/wdErY+SE0avhim9OvOhNSVr8N1OkjwZFA6YgwD7LElt12Z
	 5QNuTTmceyB+2/4GW5sZzuzVlJlGSF0xbhruokYGvZYf3iQkr62QmX/uw+8a2XmCVh
	 9/box8wK3rfkiM0mxilfKZuDCdkYKM/vEn/t/JdMKq8sjN/J8TDYURff8m0KjUKgIL
	 bCu4g1Nv7T5UvRVIbNvsSLgkeF351qz1KsZphPgu4QwgHP+oJvwcSYHFqphnW0jBXy
	 pEYIHqTPQLAAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73FCC5478C;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:36 -0600
Subject: [PATCH v2 05/25] capability: use vfsuid_t for vfs_caps rootids
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-5-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=YMHnxXBEI/P1sDB6/aXu4KjyTt4t2HZBNesMC/3zNhs=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1moc9PlzOKO/Kyx+lBa/M3xom?=
 =?utf-8?q?Z3GPJVZxjtiE7L2_DuW0zcKJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqHAAKCRBTA5mu5fQxyWfCB/_43YTrTvfhVuOT0q1B/D6FhejPBxQNkO/BnY?=
 =?utf-8?q?Q3ZrnKJbTbp44bZUF5mGs5jcP2xDdmAjW4CEnAhSy9M_pSzcb+7UKv6auwA0B0Y6B?=
 =?utf-8?q?d0Rabx/8z/3pnoUYWlLrgXWJluVZbFhrZmEhI0nSpdP/a3wwqdkBRl7xn_ATu5t0u?=
 =?utf-8?q?CHGnbdr9CRQvE2DGGQiB0rHgAD6mxoWAPQpW+fKMiBNbPOwu7YKPvaynD5JTZ6Evl?=
 =?utf-8?q?TiSlrf_whTtvzTnkpe2dGqZVxeEsNQ35AkJQgMEAYwSro7u4f2w9R/b5hO7M8WOg8?=
 =?utf-8?q?/KkOoZBzahTBqYE+QJg2?= KzNOWFT6FYRXRuHJ01Uf7V739eWk+C
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

The rootid is a kuid_t, but it contains an id which maped into a mount
idmapping, so it is really a vfsuid. This is confusing and creates
potential for misuse of the value, so change it to vfsuid_t.

Acked-by: Paul Moore <paul@paul-moore.com>
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
index 7cda247dc7e9..a0b5c9740759 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -711,7 +711,7 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 	cpu_caps->permitted.val &= CAP_VALID_MASK;
 	cpu_caps->inheritable.val &= CAP_VALID_MASK;
 
-	cpu_caps->rootid = vfsuid_into_kuid(rootvfsuid);
+	cpu_caps->rootid = rootvfsuid;
 
 	return 0;
 }

-- 
2.43.0


