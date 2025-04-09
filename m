Return-Path: <linux-fsdevel+bounces-46131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B86A83054
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 21:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D331467CA9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730031E47C2;
	Wed,  9 Apr 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO0xDmOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6EC1E1C3A;
	Wed,  9 Apr 2025 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226419; cv=none; b=HydtGHbgH37LhRz59JhVbh3dtyKZt48nKHDgdT9cleP/gHk5q982I7yYJ0IZ1hvBnfqyZxSPKppuIUvtYD0TLam+2OvQUG+8KtqUIbls+g2fWloNDgzLTt3exYE2Jhumd22/mGQz5S5ybPmpnyOgyALS653MvTD8djkDx6mnTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226419; c=relaxed/simple;
	bh=8xN2n7MWLEqbA4+N50vXGgWJuLKxlu2w4yX4rMExLVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cbTHG0EoeSq0Sp3oyQggL+xTCjTUsGSwmF+lUsHHWR0XZfU+LgF8rmaIT0USTajBfp2usoM/1eMve7Sbdk1B6pnITxgyxy53zhLEONFlQLRN8CWMrKmR+LEfMB/dQ0qhc4ypsa9Jbqw10HE265/QDAQC2/g9Yjob/poc0V0OzDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO0xDmOk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso2041792a12.0;
        Wed, 09 Apr 2025 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744226416; x=1744831216; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wmy4oykYd8cgmMURzvD8ripLw/xkKtLURu+AdwPbMSU=;
        b=WO0xDmOktdwW8iUGxdxREjT3dPHuzJ7ZXDMJYe1r24C1uGNVMxr73/Su/7QxO25Fhk
         qNuy3zCOEnpIavBh/bYadEmmgv3dMhWeEEH93w2xZLTGsKZdO48s68csxiD07p1/Oa5Y
         zIHlSFsaVFNxZdLYIDCYs4eXmLRh1tlPUOAjMrzIhJr5mHKOD/eBE2biFXxr9kGcQrD5
         diIQndhqhwiV79SLOX68AIFwNSD2JQpkLM02upQlVsKrh0XjNYUUvyKGIMrIji+VXWk4
         Z2iTSWU52ZkItDWutCznkPLTdduwx3vrOMADDEmJJ0nDBI421IelI8ZHwhE0EeKYULVS
         Mmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744226416; x=1744831216;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wmy4oykYd8cgmMURzvD8ripLw/xkKtLURu+AdwPbMSU=;
        b=emwayZAQjqgPtl5AIhnEsxAilqQEqn7aI10DsQ8Xo1JgSaS2gpPvNCrUkssojSN1fc
         /qCVyaBA43yd6W7GiuWrBO51C5J84oG9yAMIW2TaI+y7ec/tVAcsvuD9lfN8VL0TmVLc
         JZWT7ktk13VWu+3LaQ5XdNxog4c8XpEiN+i9AEQDb9SDQpUjn4j4PxAepHwePd3gN99Q
         HS6zlvPB3ZhCDAH/xLXUuiut25Sffd1V1JnuF9w3lsMAOUsBmcLjoYsTKJuBf+0LJZd6
         O1wN/+8ThykNEKYKB0xfpp+inL9tLYVDQrmy6uypn4y+D2JN89ZUWfCwNjZEQ2bWjEWy
         A+GA==
X-Forwarded-Encrypted: i=1; AJvYcCWWAeaqs/oFeQI3ugEZmAV2aJtq7DpbYGq2YjdTaY0QeRd30keeN0XMcl4AaTQFrlkWuOseL8AnOGGG2n2B@vger.kernel.org, AJvYcCX8sx0VpUdO/7r3xL1dIGaTB+9h/evktkRlzKLKIo8oyVanJteOz069i9LFIt9rWy9P9k40XGGclMGlLpmU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuzs7pF3RqCJl8TzZD5/L988jVwXE81gEBjKuLczd8XnklgiEC
	3f2RxD5YLO8b4Om80xSnIE3WoyTNZrjsiv/dAdRQ6W+8e5kPwzjM1iI3
X-Gm-Gg: ASbGncsqi240VA8CmaT0Ueh+O2B9lZwj0c3MQBHahOcfwu4ywMkArbKT103472dKIsq
	1UHIt3m6wptJX/a+3kdTE5rMivc7UQUgxMEBHy4kmMna8xf5AgYNZS8+zBsjc4yVpCFtbi7hIsO
	gLnl5Fpar9eei6SHtm+9gzWBVP2MVahr5OrF412RyE6279ujocidPGDPBEOYLK6jodEUOlaciQR
	neuGlp/3/hjriqGK/KJyZ292KEf3mvpoR7PSCv5+CGv7HRUGM/HL1w15Zpj8GxKUeIzDpd5o76f
	So8tbAtzgrvBnEG5z6oR5aJcoEu2B0I=
X-Google-Smtp-Source: AGHT+IHHNfZjqtq0Cml59h4N/YXTEs4yNP1s67QXu3EH6kY2aE4pJSUNUfngbsVnuK9PqhBl2CkJeQ==
X-Received: by 2002:a17:907:3d0e:b0:ac8:1bb3:894 with SMTP id a640c23a62f3a-acab62765ddmr85721266b.7.1744226415875;
        Wed, 09 Apr 2025 12:20:15 -0700 (PDT)
Received: from p183 ([178.172.146.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be8eddsm136980766b.41.2025.04.09.12.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:20:15 -0700 (PDT)
Date: Wed, 9 Apr 2025 22:20:13 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: allow to mark /proc files permanent outside of fs/proc/
Message-ID: <c58291cd-0775-4c90-8443-ba71897b5cbb@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From 06e2ff406942fef65b9c397a7f44478dd4b61451 Mon Sep 17 00:00:00 2001
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Sat, 5 Apr 2025 14:50:10 +0300
Subject: [PATCH 1/1] proc: allow to mark /proc files permanent outside of
 fs/proc/

From: Mateusz Guzik <mjguzik@gmail.com>

Add proc_make_permanent() function to mark PDE as permanent to speed up
open/read/close (one alloc/free and lock/unlock less).

Enable it for built-in code and for compiled-in modules.
This function becomes nop magically in modular code.

Use it on /proc/filesystems to add a user.

		Note, note, note!

If built-in code creates and deletes PDEs dynamically (not in init
hook), then proc_make_permanent() must not be used.

It is intended for simple code:

	static int __init xxx_module_init(void)
	{
		g_pde = proc_create_single();
		proc_make_permanent(g_pde);
		return 0;
	}
	static void __exit xxx_module_exit(void)
	{
		remove_proc_entry(g_pde);
	}

If module is built-in then exit hook never executed and PDE is
permanent so it is OK to mark it as such.

If module is module then rmmod will yank PDE, but proc_make_permanent()
is nop and core /proc code will do everything right.

[adobriyan@gmail.com: unexport function (usual exporting is a bug)]
[adobriyan@gmail.com: rewrite changelog]

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/filesystems.c        |  4 +++-
 fs/proc/generic.c       | 12 ++++++++++++
 fs/proc/internal.h      |  3 +++
 include/linux/proc_fs.h | 10 ++++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 58b9067b2391..81dcd0ddadb6 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -252,7 +252,9 @@ static int filesystems_proc_show(struct seq_file *m, void *v)
 
 static int __init proc_filesystems_init(void)
 {
-	proc_create_single("filesystems", 0, NULL, filesystems_proc_show);
+	struct proc_dir_entry *pde =
+		proc_create_single("filesystems", 0, NULL, filesystems_proc_show);
+	proc_make_permanent(pde);
 	return 0;
 }
 module_init(proc_filesystems_init);
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index a3e22803cddf..0342600c0172 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -826,3 +826,15 @@ ssize_t proc_simple_write(struct file *f, const char __user *ubuf, size_t size,
 	kfree(buf);
 	return ret == 0 ? size : ret;
 }
+
+/*
+ * Not exported to modules:
+ * modules' /proc files aren't permanent because modules aren't permanent.
+ */
+void impl_proc_make_permanent(struct proc_dir_entry *pde);
+void impl_proc_make_permanent(struct proc_dir_entry *pde)
+{
+	if (pde) {
+		pde_make_permanent(pde);
+	}
+}
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 96122e91c645..885b1cd38020 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -80,8 +80,11 @@ static inline bool pde_is_permanent(const struct proc_dir_entry *pde)
 	return pde->flags & PROC_ENTRY_PERMANENT;
 }
 
+/* This is for builtin code, not even for modules which are compiled in. */
 static inline void pde_make_permanent(struct proc_dir_entry *pde)
 {
+	/* Ensure magic flag does something. */
+	static_assert(PROC_ENTRY_PERMANENT != 0);
 	pde->flags |= PROC_ENTRY_PERMANENT;
 }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index ea62201c74c4..2d59f29b49eb 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -247,4 +247,14 @@ static inline struct pid_namespace *proc_pid_ns(struct super_block *sb)
 
 bool proc_ns_file(const struct file *file);
 
+static inline void proc_make_permanent(struct proc_dir_entry *pde)
+{
+	/* Don't give matches to modules. */
+#if defined CONFIG_PROC_FS && !defined MODULE
+	/* This mess is created by defining "struct proc_dir_entry" elsewhere. */
+	void impl_proc_make_permanent(struct proc_dir_entry *pde);
+	impl_proc_make_permanent(pde);
+#endif
+}
+
 #endif /* _LINUX_PROC_FS_H */
-- 
2.47.0


