Return-Path: <linux-fsdevel+bounces-16467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAE789E204
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818C41C211F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5443156C57;
	Tue,  9 Apr 2024 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xlUx2b7a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877F4131732;
	Tue,  9 Apr 2024 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685507; cv=none; b=XHJKnnBlGkyquKIf+JomrOCLV2sZqRfmJuno0hM9bGcvvl/1v3Lvg7oXB85XF55MGeOwUz4RKXBTBQoS5hf++3a4RLfLgrgWWv8drsMK2cIblO05XocFrUh02NrVRON5dzgz2fmilQCYHtMiO1DduUuqfsfTWDuwXzOKVujGLbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685507; c=relaxed/simple;
	bh=AmtWxCZ4F4bQFddgYnhSmlD9kM0A3FWxzkbEkyZ+Mtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qG1faasW26SyautHN5lhatP/jd0v5ni1tNd6Fj8zmw/JLaq+rw/jFLcZm14EXSGArQaBfUAeTl+/EURsrlX8vY9rzMcEBP1NT+laHuAAafUxSdWOIf14ihXgNqA6/atn6xeu+rKvVUzsZrcV9c8QotbrxVaDsd8CGnEzooWLHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xlUx2b7a; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712685503;
	bh=AmtWxCZ4F4bQFddgYnhSmlD9kM0A3FWxzkbEkyZ+Mtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xlUx2b7afVKUYuFgYA+M7Kva1C+VYO4G61wjMXsU8B1dsaHffICXZA4Di8qELpGFT
	 ifUi6409E73XP2CXtD/bn0DoXbKtuUFLlyieKyepIMIwZoNhR38gu5UGQ2ml7NSXWH
	 m1Dg6MtAnK85Rr//swHhTt6STb6zZq9nvhvr8A+z/uaUA1o5+/bxWx6vBUNGSl5Wu7
	 Gty7IQP9iqOJLocCSscFAfdezDWscn+Es5xKOzDvQCXpz9gbOTHv/Er6kqW5geYXyM
	 hOrY1My8uD+M4qSXW0EyOMC/W38bpKrZbKNYSM1LJ4fMys4dSapOb2HLbzO7BodNWD
	 zS9BjQjJw4cww==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8C66C37820EF;
	Tue,  9 Apr 2024 17:58:22 +0000 (UTC)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel@collabora.com,
	gbiv@google.com,
	ryanbeltran@google.com,
	inglorion@google.com,
	ajordanr@google.com,
	jorgelo@chromium.org,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 2/2] proc: add Kconfigs to restrict /proc/pid/mem access
Date: Tue,  9 Apr 2024 20:57:50 +0300
Message-ID: <20240409175750.206445-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240409175750.206445-1-adrian.ratiu@collabora.com>
References: <20240409175750.206445-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some systems might have difficulty changing their bootloaders
to enable the newly added restrict_proc_mem* params, for e.g.
remote embedded doing OTA updates, so this provides a set of
Kconfigs to set /proc/pid/mem restrictions at build-time.

The boot params take precedence over the Kconfig values. This
can be reversed, but doing it this way I think makes sense.

Another idea is to have a global bool Kconfig which can enable
or disable this mechanism in its entirety, however it does not
seem necessary since all three knobs default to off, the branch
logic overhead is rather minimal and I assume most of systems
will want to restrict at least the use of FOLL_FORCE.

Cc: Guenter Roeck <groeck@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 fs/proc/base.c   | 33 +++++++++++++++++++++++++++++++++
 security/Kconfig | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c733836c42a65..e8ee848fc4a98 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -889,6 +889,17 @@ static int __mem_open_check_access_restriction(struct file *file)
 		    !__mem_open_current_is_ptracer(file))
 			return -EACCES;
 
+#ifdef CONFIG_SECURITY_PROC_MEM_WRITE_RESTRICT
+		/* Deny if writes are unconditionally disabled via Kconfig */
+		if (!strncmp(CONFIG_SECURITY_PROC_MEM_WRITE_RESTRICT, "all", 3))
+			return -EACCES;
+
+		/* Deny if writes are allowed only for ptracers via Kconfig */
+		if (!strncmp(CONFIG_SECURITY_PROC_MEM_WRITE_RESTRICT, "ptracer", 7) &&
+		    !__mem_open_current_is_ptracer(file))
+			return -EACCES;
+#endif
+
 	} else if (file->f_mode & FMODE_READ) {
 		/* Deny if reads are unconditionally disabled via param */
 		if (static_branch_unlikely(&restrict_proc_mem[2]))
@@ -898,6 +909,17 @@ static int __mem_open_check_access_restriction(struct file *file)
 		if (static_branch_unlikely(&restrict_proc_mem[3]) &&
 		    !__mem_open_current_is_ptracer(file))
 			return -EACCES;
+
+#ifdef CONFIG_SECURITY_PROC_MEM_READ_RESTRICT
+		/* Deny if reads are unconditionally disabled via Kconfig */
+		if (!strncmp(CONFIG_SECURITY_PROC_MEM_READ_RESTRICT, "all", 3))
+			return -EACCES;
+
+		/* Deny if reads are allowed only for ptracers via Kconfig */
+		if (!strncmp(CONFIG_SECURITY_PROC_MEM_READ_RESTRICT, "ptracer", 7) &&
+		    !__mem_open_current_is_ptracer(file))
+			return -EACCES;
+#endif
 	}
 
 	return 0;
@@ -930,6 +952,17 @@ static unsigned int __mem_rw_get_foll_force_flag(struct file *file)
 	    !__mem_open_current_is_ptracer(file))
 		return 0;
 
+#ifdef CONFIG_SECURITY_PROC_MEM_FOLL_FORCE_RESTRICT
+	/* Deny if FOLL_FORCE is disabled via Kconfig */
+	if (!strncmp(CONFIG_SECURITY_PROC_MEM_FOLL_FORCE_RESTRICT, "all", 3))
+		return 0;
+
+	/* Deny if FOLL_FORCE is only allowed for ptracers via Kconfig */
+	if (!strncmp(CONFIG_SECURITY_PROC_MEM_FOLL_FORCE_RESTRICT, "ptracer", 7) &&
+	    !__mem_open_current_is_ptracer(file))
+		return 0;
+#endif
+
 	return FOLL_FORCE;
 }
 
diff --git a/security/Kconfig b/security/Kconfig
index 412e76f1575d0..31a588cedec8d 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -19,6 +19,48 @@ config SECURITY_DMESG_RESTRICT
 
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_PROC_MEM_READ_RESTRICT
+	string "Restrict read access to /proc/*/mem files"
+	depends on PROC_FS
+	default "none"
+	help
+	  This option allows specifying a restriction level for read access
+	  to /proc/*/mem files. Can be one of:
+	  - 'all' restricts all access unconditionally.
+	  - 'ptracer' allows access only for ptracer processes.
+
+	  This can also be set at boot with the "restrict_proc_mem_read=" param.
+
+	  If unsure leave empty to continue using basic file permissions.
+
+config SECURITY_PROC_MEM_WRITE_RESTRICT
+	string "Restrict write access to /proc/*/mem files"
+	depends on PROC_FS
+	default "none"
+	help
+	  This option allows specifying a restriction level for write access
+	  to /proc/*/mem files. Can be one of:
+	  - 'all' restricts all access unconditionally.
+	  - 'ptracer' allows access only for ptracer processes.
+
+	  This can also be set at boot with the "restrict_proc_mem_write=" param.
+
+	  If unsure leave empty to continue using basic file permissions.
+
+config SECURITY_PROC_MEM_FOLL_FORCE_RESTRICT
+	string "Restrict use of FOLL_FORCE for /proc/*/mem access"
+	depends on PROC_FS
+	default ""
+	help
+	  This option allows specifying a restriction level for FOLL_FORCE usage
+	  for /proc/*/mem access. Can be one of:
+	  - 'all' restricts all access unconditionally.
+	  - 'ptracer' allows access only for ptracer processes.
+
+	  This can also be set at boot with the "restrict_proc_mem_foll_force=" param.
+
+	  If unsure leave empty to continue using FOLL_FORCE without restriction.
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.30.2


