Return-Path: <linux-fsdevel+bounces-25617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3341994E4EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E003A28203F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223AA136E3F;
	Mon, 12 Aug 2024 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+PHNP0C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9B81E;
	Mon, 12 Aug 2024 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429854; cv=none; b=me4XwwYI7u7iqtkHjAG1Sl/Qr3r0neue1MKuo5FhzMUbP2ikOegqggOKxtRqZCLYy0ec+VJ5e+GL7iCMrWEXJPiAsf5p17rIF40QwOSkvH3qLrrX+v9Thj9JJP8H1XAxKERv4LgTjw5s1rBf8945UvLzoPpGsF3HyJ/IjG10nR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429854; c=relaxed/simple;
	bh=rwrleKkI2X7xkAWyZx450l1EJ8jX7PhBhqgve4NEBXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a7okdaSXtEknVLGmb0ZYGpDEeOmSrPw9nweuSM2NQ/HFnOmXhh64x1htJjywMsmucYfLBNuOKepjofMn7jX2uF2TGL4LmpsG95NoQBiO2Q/U1VBUd7gWuj+hvmYWKwUfjfwlTRglgj11AfREgetfDB0zzOSOsViDeRs4/PJm5m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+PHNP0C; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd9e70b592so28944085ad.3;
        Sun, 11 Aug 2024 19:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723429852; x=1724034652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Po06JAJWHpcwq2qZykUbq7VkC01v3704cEIBIqD0N8=;
        b=j+PHNP0CPKK5LdgpBFwuQ9QDc+WZtYBMA/El+MsUI4t3tJhwtPGJRGCPwWm4Bc3IKb
         OvugZwIOPWGPj+iQClMkyhDfaEek25twphoD/egC2wk17EmSIzcbg5XAPWKf8xoWhqfV
         f5KHnHNWY1F9ZZSALwb9MFOO9NsBEJp4DbrLsbaIIgAFiPYeOUy7BGAg5uLMllZLwPfB
         tfscKMWIseNJvaEVTBjBIyAVnQ5pelDJS8csZojSbHlYki2hh5drduetklwx/LZl1OvM
         EKGD6qqHJkv2cBNwCnPm5O6GDtJGgkesui3kroTxbwPZu6mzATRtMeYZJ9xzGFWQj+jd
         5Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723429852; x=1724034652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Po06JAJWHpcwq2qZykUbq7VkC01v3704cEIBIqD0N8=;
        b=wrlILDBoVp+Cxv4Jay8CZRxMBa1zIrUzAkblyCe2jtYISHNGVbg6EpYh/9aKc3N7EW
         A0OhlIGcu8Xp8OYw8gjFr79B8rwSKcQpbMNdgee13nY53rLh8uoK4F9cmWWZ5VY/3Lqu
         YZwDaC6+l7LQDDXyxZOKFENQZFpEBE9HAKwASPlc8fMuQ5psCvZiNxy7aWUTk8rVcn5l
         nHWjJv9W/QMvbMWXvX6ZXXiyRNK6fWx9eKzDMjclO7NrasL9XvFeHdQe71TWYOWpbAjY
         7EMjP682F5Xf7n5LE7vxqaq1BWzLBmLAkiXOvf6WwtgmZ9idKy4mG7WYJM4gs0WP1vHU
         sESQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhDOhoEzi/OR2KOk+Hy2FX1unLFEgTQdgcuJGORfcsIe6z9wR7vVIWn0WqGYFwKFH5WH8RrOVR2xTUbRZ5ygxqcmDolq9vuPYnc6cJFfrAk5dU9rxoIFr0go8y5HEwUCXBgq5+OMyGnR8vXfotSOsVhevY42U0RcYEDlHnNRUap45zgbYfFe79IJIjMabWlGUqJ8B4NSgF+nXF4rL0+Dv/qPfsM1nY1UU+MA4NTeZpgzeKO/AdqMMaha9B3kEywzTnMrC7b9dat2bM3DfyN7ulLbnJz7fnJ+4WKGH0jTlk2z6kq2fTfq9lDEFx/XZdFVCtJ5LJsg==
X-Gm-Message-State: AOJu0Yzfz20sv7U6HKNW/Ie7KdeLt54pIhQWmaLkehQAvqlQjXPK2Kyl
	3yfTVNIp328S3nv0ASu6LgYc15LZDP2GGPaAucT23gq9SGcw33BB
X-Google-Smtp-Source: AGHT+IE1xZMlHs3Cuw2myWpVVx1UE/beU7sYLAE8S60uxm8E0L6tTVwuNzgTetxBMMEWFVehNVy1XQ==
X-Received: by 2002:a17:902:d2c8:b0:1fd:8eaf:eaa0 with SMTP id d9443c01a7336-200ae550a83mr99817585ad.38.1723429852169;
        Sun, 11 Aug 2024 19:30:52 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fed69sm27884765ad.188.2024.08.11.19.30.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2024 19:30:51 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v6 3/9] security: Replace memcpy() with get_task_comm()
Date: Mon, 12 Aug 2024 10:29:27 +0800
Message-Id: <20240812022933.69850-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240812022933.69850-1-laoar.shao@gmail.com>
References: <20240812022933.69850-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Quoted from Linus [0]:

  selinux never wanted a lock, and never wanted any kind of *consistent*
  result, it just wanted a *stable* result.

Using get_task_comm() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
LINK: https://lore.kernel.org/all/CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com/ [0]
Acked-by: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/lsm_audit.c         | 4 ++--
 security/selinux/selinuxfs.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 849e832719e2..9a8352972086 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -207,7 +207,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
 
 	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
-	audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
+	audit_log_untrustedstring(ab, get_task_comm(comm, current));
 
 	switch (a->type) {
 	case LSM_AUDIT_DATA_NONE:
@@ -302,7 +302,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 				char comm[sizeof(tsk->comm)];
 				audit_log_format(ab, " opid=%d ocomm=", pid);
 				audit_log_untrustedstring(ab,
-				    memcpy(comm, tsk->comm, sizeof(comm)));
+				    get_task_comm(comm, tsk));
 			}
 		}
 		break;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index e172f182b65c..57e014ff3076 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -708,7 +708,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	if (new_value) {
 		char comm[sizeof(current->comm)];
 
-		memcpy(comm, current->comm, sizeof(comm));
+		strscpy(comm, current->comm, sizeof(comm));
 		pr_err("SELinux: %s (%d) set checkreqprot to 1. This is no longer supported.\n",
 		       comm, current->pid);
 	}
-- 
2.43.5


