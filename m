Return-Path: <linux-fsdevel+bounces-12363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABF585EA41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02111F24E3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22EA12AADF;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqKvgODs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051B685927;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550706; cv=none; b=ksBBUscTtNeHVRKTQ33gs+xmRpnyL0aORIEHsxnRrWU4OmLZ7peDs1c1VTCQI5ZALVKjYui9bdOvmU2460SRa/HOpKLe1HfJCnjeJP5egAQfCAXhEftNil5lrtaT9kkpSyLBst7Kvw9ZKlH7bf/fNsTu80TO+qMWDYS7hKc7hzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550706; c=relaxed/simple;
	bh=POA0PrUTN0FKS/Ur9K0S38PgsRMyq3Vpis2kmg0j4iE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RTJk0VYZUCc1fi2aZSS62mVxQdaFSBKjnvXCglN2MzO1zz0M+NL/83MsZV6jtskgoHdIzvoum19G5kDMMhbauWVdVyX/6HBBZ29ym9453svLME0EdK56POTiLVJ7XDtv+eD+3/0PMkajYbHKrNnSq6DNbu5sUDhcF/X4HMnoIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqKvgODs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A553EC43390;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550705;
	bh=POA0PrUTN0FKS/Ur9K0S38PgsRMyq3Vpis2kmg0j4iE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qqKvgODsKJnsTaYg73BSok+1W6QS0nZeWSmY/OoFMRN/Yo2iKo6D60IXChaqGt0wq
	 jQmnQX6sifPQ9jgl5rOuzwWgepvyOLtBnNKJOoPbWl9J63yZGl80o8XheQ9C00pTs7
	 r8NYLFy7jIuV8FkFcwy9/0jl0+wDbHf7JZoGdUXnwaNl2KDP0QhfJYgQhSenOfNqwS
	 gtqUCdl2HpfLiDCqBXUtodU9lzsHmM/fu1J11vvZJ+8X9ZsF/UEp7XI7TiArFRD5kc
	 /0OyZ9SGhM5UYp9qfKqB0zy3LoY1c4UuL8ne4EpevTlFG68XePgGCMiIibWi9MH+Au
	 P1gK6wgVgmP5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D7CC5478B;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:32 -0600
Subject: [PATCH v2 01/25] mnt_idmapping: split out core vfs[ug]id_t
 definitions into vfsid.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-1-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5431; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=POA0PrUTN0FKS/Ur9K0S38PgsRMyq3Vpis2kmg0j4iE=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1moYRgftQvnaAhwOC79xM2UkR?=
 =?utf-8?q?CSDp2SfLboi/uca_yap7limJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqGAAKCRBTA5mu5fQxydMWCA_CHRl2ahpZ1XKaT9DAva+dTXDWZTZpLPKpm7?=
 =?utf-8?q?33cX3EuV3oihFi32EJQ+Hbq/1ldRB2eErVaDK91yBAd_VYE7/nJsEKc/ba9Ky35Ow?=
 =?utf-8?q?IschvNvH9KXD5jqpQpkd+kPdAd1T/X46nbVnBjZ0aWzPPeZmct0OAi+wG_Y2Y5ALq?=
 =?utf-8?q?TlJpHmtT8g2DFxWNYq8K08IvK+3vID7WhxzDmcUTeLKxMWiIqPrybnPekmiscIc5D?=
 =?utf-8?q?oUrMxz_Hn2Em05Yu8OId/6I1Kz9rtmzWSYPJqM6lFPekAY3jtogoHVIU9dmN9HkZE?=
 =?utf-8?q?WzCTpB8PPDUCjuGqD5J5?= +VK4khbwbHHVfmKGEE64anWErIPwII
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

The rootid member of cpu_vfs_cap_data is a kuid_t, but it should be a
vfsuid_t as the id stored there is mapped into the mount idmapping. It's
currently impossible to use vfsuid_t within cred.h though as it is
defined in mnt_idmapping.h, which uses definitions from cred.h.

Split out the core vfsid type definitions into a separate file which can
be included from cred.h.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 MAINTAINERS                   |  1 +
 include/linux/mnt_idmapping.h | 66 +-------------------------------------
 include/linux/vfsid.h         | 74 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 65 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73d898383e51..6286d78a759a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8210,6 +8210,7 @@ S:	Maintained
 F:	Documentation/filesystems/idmappings.rst
 F:	fs/mnt_idmapping.c
 F:	include/linux/mnt_idmapping.*
+F:	include/linux/vfsid.h
 F:	tools/testing/selftests/mount_setattr/
 
 FILESYSTEMS [IOMAP]
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index cd4d5c8781f5..f463b9e1e258 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/uidgid.h>
+#include <linux/vfsid.h>
 
 struct mnt_idmap;
 struct user_namespace;
@@ -11,61 +12,6 @@ struct user_namespace;
 extern struct mnt_idmap nop_mnt_idmap;
 extern struct user_namespace init_user_ns;
 
-typedef struct {
-	uid_t val;
-} vfsuid_t;
-
-typedef struct {
-	gid_t val;
-} vfsgid_t;
-
-static_assert(sizeof(vfsuid_t) == sizeof(kuid_t));
-static_assert(sizeof(vfsgid_t) == sizeof(kgid_t));
-static_assert(offsetof(vfsuid_t, val) == offsetof(kuid_t, val));
-static_assert(offsetof(vfsgid_t, val) == offsetof(kgid_t, val));
-
-#ifdef CONFIG_MULTIUSER
-static inline uid_t __vfsuid_val(vfsuid_t uid)
-{
-	return uid.val;
-}
-
-static inline gid_t __vfsgid_val(vfsgid_t gid)
-{
-	return gid.val;
-}
-#else
-static inline uid_t __vfsuid_val(vfsuid_t uid)
-{
-	return 0;
-}
-
-static inline gid_t __vfsgid_val(vfsgid_t gid)
-{
-	return 0;
-}
-#endif
-
-static inline bool vfsuid_valid(vfsuid_t uid)
-{
-	return __vfsuid_val(uid) != (uid_t)-1;
-}
-
-static inline bool vfsgid_valid(vfsgid_t gid)
-{
-	return __vfsgid_val(gid) != (gid_t)-1;
-}
-
-static inline bool vfsuid_eq(vfsuid_t left, vfsuid_t right)
-{
-	return vfsuid_valid(left) && __vfsuid_val(left) == __vfsuid_val(right);
-}
-
-static inline bool vfsgid_eq(vfsgid_t left, vfsgid_t right)
-{
-	return vfsgid_valid(left) && __vfsgid_val(left) == __vfsgid_val(right);
-}
-
 /**
  * vfsuid_eq_kuid - check whether kuid and vfsuid have the same value
  * @vfsuid: the vfsuid to compare
@@ -96,16 +42,6 @@ static inline bool vfsgid_eq_kgid(vfsgid_t vfsgid, kgid_t kgid)
 	return vfsgid_valid(vfsgid) && __vfsgid_val(vfsgid) == __kgid_val(kgid);
 }
 
-/*
- * vfs{g,u}ids are created from k{g,u}ids.
- * We don't allow them to be created from regular {u,g}id.
- */
-#define VFSUIDT_INIT(val) (vfsuid_t){ __kuid_val(val) }
-#define VFSGIDT_INIT(val) (vfsgid_t){ __kgid_val(val) }
-
-#define INVALID_VFSUID VFSUIDT_INIT(INVALID_UID)
-#define INVALID_VFSGID VFSGIDT_INIT(INVALID_GID)
-
 /*
  * Allow a vfs{g,u}id to be used as a k{g,u}id where we want to compare
  * whether the mapped value is identical to value of a k{g,u}id.
diff --git a/include/linux/vfsid.h b/include/linux/vfsid.h
new file mode 100644
index 000000000000..90262944b042
--- /dev/null
+++ b/include/linux/vfsid.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MNT_VFSID_H
+#define _LINUX_MNT_VFSID_H
+
+#include <linux/types.h>
+#include <linux/uidgid.h>
+#include <linux/build_bug.h>
+
+typedef struct {
+	uid_t val;
+} vfsuid_t;
+
+typedef struct {
+	gid_t val;
+} vfsgid_t;
+
+static_assert(sizeof(vfsuid_t) == sizeof(kuid_t));
+static_assert(sizeof(vfsgid_t) == sizeof(kgid_t));
+static_assert(offsetof(vfsuid_t, val) == offsetof(kuid_t, val));
+static_assert(offsetof(vfsgid_t, val) == offsetof(kgid_t, val));
+
+#ifdef CONFIG_MULTIUSER
+static inline uid_t __vfsuid_val(vfsuid_t uid)
+{
+	return uid.val;
+}
+
+static inline gid_t __vfsgid_val(vfsgid_t gid)
+{
+	return gid.val;
+}
+#else
+static inline uid_t __vfsuid_val(vfsuid_t uid)
+{
+	return 0;
+}
+
+static inline gid_t __vfsgid_val(vfsgid_t gid)
+{
+	return 0;
+}
+#endif
+
+static inline bool vfsuid_valid(vfsuid_t uid)
+{
+	return __vfsuid_val(uid) != (uid_t)-1;
+}
+
+static inline bool vfsgid_valid(vfsgid_t gid)
+{
+	return __vfsgid_val(gid) != (gid_t)-1;
+}
+
+static inline bool vfsuid_eq(vfsuid_t left, vfsuid_t right)
+{
+	return vfsuid_valid(left) && __vfsuid_val(left) == __vfsuid_val(right);
+}
+
+static inline bool vfsgid_eq(vfsgid_t left, vfsgid_t right)
+{
+	return vfsgid_valid(left) && __vfsgid_val(left) == __vfsgid_val(right);
+}
+
+/*
+ * vfs{g,u}ids are created from k{g,u}ids.
+ * We don't allow them to be created from regular {u,g}id.
+ */
+#define VFSUIDT_INIT(val) (vfsuid_t){ __kuid_val(val) }
+#define VFSGIDT_INIT(val) (vfsgid_t){ __kgid_val(val) }
+
+#define INVALID_VFSUID VFSUIDT_INIT(INVALID_UID)
+#define INVALID_VFSGID VFSGIDT_INIT(INVALID_GID)
+
+#endif /* _LINUX_MNT_VFSID_H */

-- 
2.43.0


