Return-Path: <linux-fsdevel+bounces-70745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE00CA5C41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 01:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D791307A972
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 00:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BD820458A;
	Fri,  5 Dec 2025 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gv9lFCd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A74158857
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764896329; cv=none; b=uu6MB4wWZxe3NtyjtA5RHQXnt2c0SnWcsD8rkLauThdxqHKcg2L+2bqpHPDa5ig3pA4bOwf9scQmgpir4U6mV/6UtEocXdCI94uzJV6ige9TKcUCjgRtdolO4ZzB61FUQDlGyA4Qonpowc3jy+RDaEOrJEMiWsmjXoEi74Yi7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764896329; c=relaxed/simple;
	bh=nyHWTFoGvASer3toat4ImRw6FmdnkyEWU7Xu2iHxdEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DXQmVRvGf91D8LzU+9gTmZQTIuhcb2ujNRlBpYpaq2hRQzXG7juVGRWo1Cgt/cW+dKtbVDM1naK0ZfOyE2xMW53kPSQL90ms+ASsRpowU3ITrjKdVmwCmlVcCqvihdKOlW8u+C8gtwCGjqWG04s9W3cE3DHYM+yEqJRNl+zpHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gv9lFCd+; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-3e890e6be00so2717597fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 16:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764896326; x=1765501126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1Ka/G7ByT2+kY8UIiF65zUCvkc5PFIL+KWxYDYgrVo=;
        b=gv9lFCd+GtEiz92KLbQSnh8G42/pYerV62qYQ9N3AshItE6xE21WY9HEQtg0lNLuEs
         z5B8ny+6MwviPpmtRUTHe1qJttrrqi0FiBRzFo9Khs3emOxfGTm85vwVWdi8uJ7Ha9BN
         /GGzc955p/cz4XRYEvn4eA2YU8biHNDYYOgBaJxzGHY0XrGmMcoek5RLcxZqktsDRPeH
         xB6ZCfpscjkWUKZDXf97b6OSVQPwgo/g3gNet2eLmwfDVFo7IuaMsSv1FZoHxw8oQgWt
         ExoTTY9W7y5sCi5Tnata6GDm41gkKLzlgbKE+QVdsH8kVB5jdckuBkmLOaqzDl/TPTUu
         On7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764896326; x=1765501126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1Ka/G7ByT2+kY8UIiF65zUCvkc5PFIL+KWxYDYgrVo=;
        b=FykcVMoEed67NiE4X+1Lx2xCBLkylyqwzdjDGs8Xc7U7PEuR9K/RpoilXYmsJGrOfk
         580XL0sb1nrwCumtnX1c19mPktbiuQaNvnFq9KQFxalrVS4tw2KfNljG9siNKDLwk3xA
         z62i+sJrjyTpq82wO7/7QbGEKkPUMnvt2wRaQogr098OkBQD897C6oH/j7L9BfE2YHSH
         WB+KOcRWIo+tqvqZ1LNOkU2IdPGqjjmZ9CqYRmZAMxwy2/gPKexTYGOxafWn/qbs6zfA
         i2Q4436RCY7VPjZ14ZeefZDwhGERX3jawu9dU4BXVAUv1xSirqo6iGvooPxDNapNaqAq
         NgZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/ZGTv03jZL0hytjDoTL/X2JrhaKP7So9wRkjdMdeXkrTYuCWYMB/zv0cfjkpgoSjbSyd0hcQaUGQG7MEp@vger.kernel.org
X-Gm-Message-State: AOJu0YwQFOuv/LQvAvd8GIzj/IjEhegpM6sTXyfxOu+GibrbgGXRV1CD
	vNoFy2M4oVKdWsrG34Vw+8tn4kmZ6Ce7NrZtUnVsF/NVteP49f6DF3Ak5JpGkIEyuntALaFTuSd
	3XED4Tg==
X-Google-Smtp-Source: AGHT+IEwsKSsZMSp6xx5UIj2r6LD+T7cD7UXVYxQ9IkaQIcbU4lDaPVqZhMj+NwIGSDCYm3tG6SS17DBIEk=
X-Received: from oacnz12.prod.google.com ([2002:a05:6871:758c:b0:3e7:db6c:48b])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:888f:b0:3e8:8e57:a7a1
 with SMTP id 586e51a60fabf-3f5067dfc56mr2969051fac.52.1764896326246; Thu, 04
 Dec 2025 16:58:46 -0800 (PST)
Date: Fri,  5 Dec 2025 00:58:29 +0000
In-Reply-To: <20251205005841.3942668-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251205005841.3942668-1-avagin@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251205005841.3942668-2-avagin@google.com>
Subject: [PATCH 1/3] cgroup, binfmt_elf: Add hwcap masks to the misc controller
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, criu@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an interface to the misc cgroup controller that allows masking out
hardware capabilities (AT_HWCAP) reported to user-space processes. This
provides a mechanism to restrict the features a containerized
application can see.

The new "misc.mask" cgroup file allows users to specify masks for
AT_HWCAP, AT_HWCAP2, AT_HWCAP3, and AT_HWCAP4.

The output of "misc.mask" is extended to display the effective mask,
which is a combination of the masks from the current cgroup and all its
ancestors.

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 fs/binfmt_elf.c             |  24 +++++--
 include/linux/misc_cgroup.h |  25 +++++++
 kernel/cgroup/misc.c        | 126 ++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 3eb734c192e9..59137784e81d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -47,6 +47,7 @@
 #include <linux/dax.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/rseq.h>
+#include <linux/misc_cgroup.h>
 #include <asm/param.h>
 #include <asm/page.h>
 
@@ -182,6 +183,21 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	int ei_index;
 	const struct cred *cred = current_cred();
 	struct vm_area_struct *vma;
+	struct misc_cg *misc_cg;
+	u64 hwcap_mask[4] = {0, 0, 0, 0};
+
+	misc_cg = get_current_misc_cg();
+	misc_cg_get_mask(MISC_CG_MASK_HWCAP, misc_cg, &hwcap_mask[0]);
+#ifdef ELF_HWCAP2
+	misc_cg_get_mask(MISC_CG_MASK_HWCAP2, misc_cg, &hwcap_mask[1]);
+#endif
+#ifdef ELF_HWCAP3
+	misc_cg_get_mask(MISC_CG_MASK_HWCAP3, misc_cg, &hwcap_mask[2]);
+#endif
+#ifdef ELF_HWCAP4
+	misc_cg_get_mask(MISC_CG_MASK_HWCAP4, misc_cg, &hwcap_mask[3]);
+#endif
+	put_misc_cg(misc_cg);
 
 	/*
 	 * In some cases (e.g. Hyper-Threading), we want to avoid L1
@@ -246,7 +262,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	 */
 	ARCH_DLINFO;
 #endif
-	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
+	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP & ~hwcap_mask[0]);
 	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
 	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
 	NEW_AUX_ENT(AT_PHDR, phdr_addr);
@@ -264,13 +280,13 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	NEW_AUX_ENT(AT_SECURE, bprm->secureexec);
 	NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
 #ifdef ELF_HWCAP2
-	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
+	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2 & ~hwcap_mask[1]);
 #endif
 #ifdef ELF_HWCAP3
-	NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3);
+	NEW_AUX_ENT(AT_HWCAP3, ELF_HWCAP3 & ~hwcap_mask[2]);
 #endif
 #ifdef ELF_HWCAP4
-	NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4);
+	NEW_AUX_ENT(AT_HWCAP4, ELF_HWCAP4 & ~hwcap_mask[3]);
 #endif
 	NEW_AUX_ENT(AT_EXECFN, bprm->exec);
 	if (k_platform) {
diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 0cb36a3ffc47..cff830c238fb 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -8,6 +8,8 @@
 #ifndef _MISC_CGROUP_H_
 #define _MISC_CGROUP_H_
 
+#include <linux/elf.h>
+
 /**
  * enum misc_res_type - Types of misc cgroup entries supported by the host.
  */
@@ -26,6 +28,20 @@ enum misc_res_type {
 	MISC_CG_RES_TYPES
 };
 
+enum misc_mask_type {
+	MISC_CG_MASK_HWCAP,
+#ifdef ELF_HWCAP2
+	MISC_CG_MASK_HWCAP2,
+#endif
+#ifdef ELF_HWCAP3
+	MISC_CG_MASK_HWCAP3,
+#endif
+#ifdef ELF_HWCAP4
+	MISC_CG_MASK_HWCAP4,
+#endif
+	MISC_CG_MASK_TYPES
+};
+
 struct misc_cg;
 
 #ifdef CONFIG_CGROUP_MISC
@@ -62,12 +78,15 @@ struct misc_cg {
 	struct cgroup_file events_local_file;
 
 	struct misc_res res[MISC_CG_RES_TYPES];
+	u64 mask[MISC_CG_MASK_TYPES];
 };
 
 int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
 void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
 
+int misc_cg_get_mask(enum misc_mask_type type, struct misc_cg *cg, u64 *pmask);
+
 /**
  * css_misc() - Get misc cgroup from the css.
  * @css: cgroup subsys state object.
@@ -134,5 +153,11 @@ static inline void put_misc_cg(struct misc_cg *cg)
 {
 }
 
+static inline int misc_cg_get_mask(enum misc_mask_type type, struct misc_cg *cg, u64 *pmask)
+{
+	*pmask = 0;
+	return 0;
+}
+
 #endif /* CONFIG_CGROUP_MISC */
 #endif /* _MISC_CGROUP_H_ */
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 6a01d91ea4cb..d1386d86060f 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -30,6 +30,19 @@ static const char *const misc_res_name[] = {
 #endif
 };
 
+static const char *const misc_mask_name[] = {
+	"AT_HWCAP",
+#ifdef ELF_HWCAP2
+	"AT_HWCAP2",
+#endif
+#ifdef ELF_HWCAP3
+	"AT_HWCAP3",
+#endif
+#ifdef ELF_HWCAP4
+	"AT_HWCAP4",
+#endif
+};
+
 /* Root misc cgroup */
 static struct misc_cg root_cg;
 
@@ -71,6 +84,11 @@ static inline bool valid_type(enum misc_res_type type)
 	return type >= 0 && type < MISC_CG_RES_TYPES;
 }
 
+static inline bool valid_mask_type(enum misc_mask_type type)
+{
+	return type >= 0 && type < MISC_CG_MASK_TYPES;
+}
+
 /**
  * misc_cg_set_capacity() - Set the capacity of the misc cgroup res.
  * @type: Type of the misc res.
@@ -391,6 +409,109 @@ static int misc_events_local_show(struct seq_file *sf, void *v)
 	return __misc_events_show(sf, true);
 }
 
+/**
+ * misc_cg_get_mask() - Get the mask of the specified type.
+ * @type: The misc mask type.
+ * @cg: The misc cgroup.
+ * @pmask: Pointer to the resulting mask.
+ *
+ * This function calculates the effective mask for a given cgroup by walking up
+ * the hierarchy and ORing the masks from all parent cgroupfs. The final result
+ * is stored in the location pointed to by @pmask.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -EINVAL if @type is invalid.
+ */
+int misc_cg_get_mask(enum misc_mask_type type, struct misc_cg *cg, u64 *pmask)
+{
+	struct misc_cg *i;
+	u64 mask = 0;
+
+	if (!(valid_mask_type(type)))
+		return -EINVAL;
+
+	for (i = cg; i; i = parent_misc(i))
+		mask |= READ_ONCE(i->mask[type]);
+
+	*pmask = mask;
+	return 0;
+}
+
+/**
+ * misc_cg_mask_show() - Show the misc cgroup masks.
+ * @sf: Interface file
+ * @v: Arguments passed
+ *
+ * Context: Any context.
+ * Return: 0 to denote successful print.
+ */
+static int misc_cg_mask_show(struct seq_file *sf, void *v)
+{
+	struct misc_cg *cg = css_misc(seq_css(sf));
+	int i;
+
+	for (i = 0; i < MISC_CG_MASK_TYPES; i++) {
+		u64 rval, val = READ_ONCE(cg->mask[i]);
+
+		misc_cg_get_mask(i, cg, &rval);
+		seq_printf(sf, "%s\t%#016llx\t%#016llx\n", misc_mask_name[i], val, rval);
+	}
+
+	return 0;
+}
+
+/**
+ * misc_cg_mask_write() - Update the mask of the specified type.
+ * @of: Handler for the file.
+ * @buf: The buffer containing the user's input.
+ * @nbytes: The number of bytes in @buf.
+ * @off: The offset in the file.
+ *
+ * This function parses a user-provided string to update a mask.
+ * The expected format is "<mask_name> <value>", for example:
+ *
+ * echo "AT_HWCAP 0xf00" > misc.mask
+ *
+ * Context: Process context.
+ * Return: The number of bytes processed on success, or a negative error code
+ * on failure.
+ */
+static ssize_t misc_cg_mask_write(struct kernfs_open_file *of, char *buf,
+				 size_t nbytes, loff_t off)
+{
+	struct misc_cg *cg;
+	u64 max;
+	int ret = 0, i;
+	enum misc_mask_type type = MISC_CG_MASK_TYPES;
+	char *token;
+
+	buf = strstrip(buf);
+	token = strsep(&buf, " ");
+
+	if (!token || !buf)
+		return -EINVAL;
+
+	for (i = 0; i < MISC_CG_MASK_TYPES; i++) {
+		if (!strcmp(misc_mask_name[i], token)) {
+			type = i;
+			break;
+		}
+	}
+
+	if (type == MISC_CG_MASK_TYPES)
+		return -EINVAL;
+
+	ret = kstrtou64(buf, 0, &max);
+	if (ret)
+		return ret;
+
+	cg = css_misc(of_css(of));
+
+	WRITE_ONCE(cg->mask[type], max);
+
+	return nbytes;
+}
+
 /* Misc cgroup interface files */
 static struct cftype misc_cg_files[] = {
 	{
@@ -424,6 +545,11 @@ static struct cftype misc_cg_files[] = {
 		.file_offset = offsetof(struct misc_cg, events_local_file),
 		.seq_show = misc_events_local_show,
 	},
+	{
+		.name = "mask",
+		.write = misc_cg_mask_write,
+		.seq_show = misc_cg_mask_show,
+	},
 	{}
 };
 
-- 
2.52.0.223.gf5cc29aaa4-goog


