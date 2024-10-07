Return-Path: <linux-fsdevel+bounces-31200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A004992FE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D221F22232
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3488E1D86FB;
	Mon,  7 Oct 2024 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsAqLCUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B901D416B;
	Mon,  7 Oct 2024 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312612; cv=none; b=S3g0Q8lL85z6qn/S5adNZzQeUbkw14fe48CrSifhEmav0sGpOWklCWb7x6aKX9RgSJeUsySg2kJENB/dH6n3OzXVtrfD9nLV64IxlQF2+5CiynUUtCoQQFwvkdA5dX2crqJsaXYG9UrQLsWqOrg6gvUGCJ2gluVDW5gFQ8O0UzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312612; c=relaxed/simple;
	bh=ABhttoS6oXw2j+hmHjcdgyTovB2nFehBatzjdciJ3nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DfEKtkFOeBSo3+iUi0hmrSUBxL+HvDcEabbJ8aGf8lUR4+yYhTTUFX3Sc8w/3AL23XAu7Uz/AsyMgPos95sCKI7nOHUBaGCeei4U6jAzqTGjh/6zTvIEFahQUGmvRFJLDDlFmgE3nO7IG40EIEtCTaee6LrihoHXn/cOwLQ8kfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsAqLCUJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7c1324be8easo3993383a12.1;
        Mon, 07 Oct 2024 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728312610; x=1728917410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIIMsSPqVp5AusgTbRbdrgF3qEr8ccJBENe3BbQ0UBw=;
        b=YsAqLCUJNB0+8zHwcXeK0Y/hsPEhokIF6a+zjLuaOSj0POs9HPco39Qqyt+l4Ib3cr
         CALIfUwRrmeSxTJxzpSzc7bSje3ZSZrpJQjFEJSHSVciK7q653ERsyi8zBJnKgY3cuzJ
         S8OBt1iXcBHe3SyFM7i2lj+hD1GH37h3i1tZzEcMyepaoP/ZGByWCdc9N32AdXHThIZj
         kmPYo27+9RoZ6Q1RRVMpBAQG+GGccywlJqY1qSq8dBub1OL+yyrKMlCnQ2HBl+sAK8JG
         2AdUYUjZtg7/Glni5539xEueO3GNciL6EaGeoLk4/IqM2ZbpioDOBtIZDd50Jz99ZssZ
         oYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728312610; x=1728917410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIIMsSPqVp5AusgTbRbdrgF3qEr8ccJBENe3BbQ0UBw=;
        b=l1GSSSIFdBo2uhjCHaWkNEDOeLkd/iDgDap52o2Q4UhqQANfedeYVryIFcTIE+Oa1T
         vABtuD9eOq7bPJgvz6jWowdqvWolQHf4YRy7hEoauEDxf77fXminoklJg8QwJuW/mxaQ
         DFdCy3Z5ZzI+8b/u7Z6hVWxuAY46lVvVFD7hx2ygGp0mby7Kkcm2fff4upXTWHdf4i/4
         01IleleIalj1p7uYb71jGba8tC/LpZwMr0eCxb1YH6u5Ggo9EN34Zlc0JBU0gK3s9Sbz
         +hAmbGDdy6WahrDWd/344VfnqoP0S9HGH/JYPkGOYWKUXNVdrsE+00Iwp+BZmPRenJHA
         0bDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbqIfrLaFXnMtslCc8OEAIx+YDAaNnG+xDe0+hT9+JJp44LFe5XNhBfc20VqMGkqrttszRYWto@vger.kernel.org, AJvYcCUm4afV1S3HnXotvQxLTzQJihV4gpVBSqreZNLhEHFcLZIJ6Mt7Nwb9AE7s4If0jvEW2Zw4WBv1Ml+g4w+pvQ==@vger.kernel.org, AJvYcCVZmNUeD58kxZqrbJGr9hC9j4RCx5p31HHS3jVheEWdNk8swgU8yL3H3K4ZwZzBHmUw2MPdiA==@vger.kernel.org, AJvYcCWId/ql8tgjp82Hpfzk84x4PtuJapU6T7j0coF57Z6DcJxpfHDg92RVo6LBUQLVAOCCcQ6l5J51mtgx4NhZh2KeToTf@vger.kernel.org, AJvYcCWRLMIElpnt9CZukVlI8w+VDQOSXKPT6g65feEFgvtzBdlUT0H5Pw9ixu5+pSoyALeq2eIAmGQMn6Dv7WJPBH/5VO/+3dv9@vger.kernel.org, AJvYcCXIqx9jAYQKUSBfT8eClrTUWrluMfL76IFPTpRVcJntUSwB5yHlDVAogqdKcwb3VAOPqsCR@vger.kernel.org, AJvYcCXYt8QsrtnCuqB8AMjdxlDtElzxTZMSHj7DkUNAe9Rf0PFViVTjyF7USEvgCvQ0Am9A39gsSeKitg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK99sFou/N6cOz7cSa/ZaiTXSPGYRwKNSOod3OvMu2K1glzXzI
	3XCwBfPVOQgge2ZLCYGP3N1Ey9HNjWBoViibKvjOE7+kUQzy3FNiNjPFJWCQ8Vs=
X-Google-Smtp-Source: AGHT+IH1T8Z0gS8IM4ef+l7Ymhr8kCvYXDO1WRSDOYONvg5988rUz94lZcz2t9FfyyE+YN0pNKr/oQ==
X-Received: by 2002:a05:6a21:9204:b0:1d4:fafb:845d with SMTP id adf61e73a8af0-1d6e02b14a1mr18448839637.2.1728312610165;
        Mon, 07 Oct 2024 07:50:10 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7cf82sm4466432b3a.200.2024.10.07.07.49.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:50:09 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	keescook@chromium.org,
	alx@kernel.org,
	justinstitt@google.com,
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
Subject: [PATCH v9 3/7] security: Replace memcpy() with get_task_comm()
Date: Mon,  7 Oct 2024 22:49:07 +0800
Message-Id: <20241007144911.27693-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241007144911.27693-1-laoar.shao@gmail.com>
References: <20241007144911.27693-1-laoar.shao@gmail.com>
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
index e172f182b65c..c9b05be27ddb 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -708,7 +708,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	if (new_value) {
 		char comm[sizeof(current->comm)];
 
-		memcpy(comm, current->comm, sizeof(comm));
+		strscpy(comm, current->comm);
 		pr_err("SELinux: %s (%d) set checkreqprot to 1. This is no longer supported.\n",
 		       comm, current->pid);
 	}
-- 
2.43.5


