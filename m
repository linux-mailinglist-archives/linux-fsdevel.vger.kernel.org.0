Return-Path: <linux-fsdevel+bounces-22747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B991BAC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094541F228A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D214E2E3;
	Fri, 28 Jun 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxnF5IEL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55C14F9D5;
	Fri, 28 Jun 2024 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565537; cv=none; b=H2wSWMH/4XgWwCs1Led8Z9U9sLEP3IpObzq3ysv1gqitritx/iQfQS5v0d8iTlul6kEMmp1KDR5qFnf8urXd1CG5en7VOq9FbriLYoG7wO17sR9SM5yL2QwxbRv1+W/VkLOvvZ5e8pIDeJJR1qtnjkRR/nMZSox6xw5WYg41Yho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565537; c=relaxed/simple;
	bh=RhhRTzGzjqJG2IuRKewfcKjpBWjGGob4kNd4UpTBjcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TibJQtwZZmOmbYmFG/H5TYKjnbkqAweH7NHFfYydOp5vB+wjYi2i5/lj1oedJNuX1YdmwB9uArK1hKA47pWpmjU5h2Z2U2+NOA0hajflb1v1wOvx4dCUIXeysC2ZX4o1PTcC9889nidqehjXyI52po8YP1KhjECLLUBbj8dzI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxnF5IEL; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso242476a12.3;
        Fri, 28 Jun 2024 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565535; x=1720170335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+o2QcP3zzShPD5bpWdvqtRKk4SGVf/ncCjWPDHjjaM=;
        b=LxnF5IELEJI/qnkaXz7mYZMz3A1D4qMP46Garx/pteNIn9li8vwwlpoUxbAltKhrsX
         6Zu7PnZj7yjZYWyAEtOZwv/37eYzXSnx2o+IWKQ4Sbw/S6YSIEL7XPIpTINEHZ/E9+MO
         ZuMq6m3XAH3vNB5xKy7IAmK49VM0e3ZvSgw5GG35Lyolf4LZ4cLG+cHOOhrmw1GNfShF
         z9p6Hewa+kPU52WIO88VCDG+4d1Lh9A2lVi5v9+xcj2I4NYSGV2y5CJH+RFAwNkfyyjm
         tK6hQEFJl8s9forSjDNdm0mPt2Y5pwgSLgPchxYsgIHYvfkWBhLGVidfh1+FIHmmYjSU
         PVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565535; x=1720170335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+o2QcP3zzShPD5bpWdvqtRKk4SGVf/ncCjWPDHjjaM=;
        b=r68zthh3X+j4uUhuPqq7MSKYl9A4WyNfMdxdU7Ju08Rk7yQzRKd2kGRs2TsHK5NhOG
         oxMVWF2tK2WzZnQGimsrMJ0uooQNNMCJBe0/MFyWDs1M+xzcjU8AoAEJeL7n85YgWW7X
         jXperA+PKE3q/jZm8vq9SQk/HFAUDlLTxpl+OdxE4fzqFGiFy6OrAucymgtDsxMQEYU4
         WBKZAdv9sfpKNmuLJBOeVgEJwlWLwkg5SoltK3xyHOE6fd6xkR9QhmAtNpDTwKQzfpQU
         lxbaTnrav0F7edBMIJ5y/I4/IEln+VzDdhavSEPnvbmv5NpEFheKBRV9oF7VjG9SOfNk
         bsFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu+4NuKgLboBVzPrQ778gSSLA54E4CfQCBEdptQNgH7qsRcq5ACcxC8diw5yTwxYQSpZ5kP3CJ7WtbpJxPXNg1y9s4wWfibB0gifKtfAt89jeOANb1PFi8pjAgcB9xmYotVX/OObbsKdvKsaJ83Xrv6WOFMfMYpgas6nCJT5M/EyiR1ohIL02AsTkxlveBPsyD8a9Z6irYNZl6HsW278LVuuJZVTXgmiT0T3QVCv8VYpOqIw/6PJ3mOEPKN7azI6HTbgjmDsnBR33P2V4R0fv0tWI9Nl4/OzsEYtdkkNk4sKxzUYqKNdtjPYf3o1ZzBMKkp4BZKA==
X-Gm-Message-State: AOJu0YwYZnHzmt6YYk1QBlqPJ/O7cR8J3WYE164JbusknWdBT5XnV1Sn
	I3cZAGcTXnOKECgVzvIGvz8Yg4lWFsBfI472VvoD0T7YBsBEmIfZmMPBqjXVntU=
X-Google-Smtp-Source: AGHT+IGiL1nE/JPCYxh777n4qtTvEfwnEp1By9NjDz6oRHtLGf4s+XwALk3c6cvWzb1jiZh3cdfwuw==
X-Received: by 2002:a05:6a20:c325:b0:1bd:2267:b45e with SMTP id adf61e73a8af0-1bd2267b4edmr8264153637.50.1719565535182;
        Fri, 28 Jun 2024 02:05:35 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a1dsm10473085ad.68.2024.06.28.02.05.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:05:34 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	laoar.shao@gmail.com
Cc: akpm@linux-foundation.org,
	alexei.starovoitov@gmail.com,
	audit@vger.kernel.org,
	bpf@vger.kernel.org,
	catalin.marinas@arm.com,
	dri-devel@lists.freedesktop.org,
	ebiederm@xmission.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	penguin-kernel@i-love.sakura.ne.jp,
	rostedt@goodmis.org,
	selinux@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Subject: [PATCH v4 02/11] auditsc: Replace memcpy() with __get_task_comm()
Date: Fri, 28 Jun 2024 17:05:08 +0800
Message-Id: <20240628090517.17994-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240628090517.17994-1-laoar.shao@gmail.com>
References: <20240628085750.17367-1-laoar.shao@gmail.com>
 <20240628090517.17994-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using __get_task_comm() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
---
 kernel/auditsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523f..0459a141dc86 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2730,7 +2730,7 @@ void __audit_ptrace(struct task_struct *t)
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
 	security_task_getsecid_obj(t, &context->target_sid);
-	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
+	__get_task_comm(context->target_comm, TASK_COMM_LEN, t);
 }
 
 /**
@@ -2757,7 +2757,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
 		security_task_getsecid_obj(t, &ctx->target_sid);
-		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
+		__get_task_comm(ctx->target_comm, TASK_COMM_LEN, t);
 		return 0;
 	}
 
@@ -2778,7 +2778,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
 	security_task_getsecid_obj(t, &axp->target_sid[axp->pid_count]);
-	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
+	__get_task_comm(axp->target_comm[axp->pid_count], TASK_COMM_LEN, t);
 	axp->pid_count++;
 
 	return 0;
-- 
2.43.5


