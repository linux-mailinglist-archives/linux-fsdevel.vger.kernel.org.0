Return-Path: <linux-fsdevel+bounces-24940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523F2946D31
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 09:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E427B21424
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F16E1CA80;
	Sun,  4 Aug 2024 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM4U4PXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4FF1802E;
	Sun,  4 Aug 2024 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758241; cv=none; b=hJQVKp1zz0Mwnocw/YFO7zIjeC1qkGYbMtNInrF8ywsxyROdm0uwOmvTAK/PuRMBEOF80S49YtbYRmTMTHQJJ2ZrD/RLD9839kMeSe3x55KdLXSGek1nlHX57HwjRm+b4nZl3MCNBxoIYnqE7Fg7V1/zGS8/IEVfetLQTUBDS7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758241; c=relaxed/simple;
	bh=KgD8kzUFQH20/ogg55cBkA7wSimlRwiEK/4c/nXr6a4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nu7zV1LCOzDpfw7ocfIgMfpiTTmFYAHMj9J2WzISp+Em6v3IsbdMXRx7jQYi/ETOyAfWS9CQuoQKuU2dFzp4QK1JUV/svY4vtMcJ0IdwhY3awBPiAFTVWtIa0OL0dSYU1zzuGoecWfM8+Vzz1M6jJZxJasruOHeETlrC5suuFIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM4U4PXH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc5296e214so78016965ad.0;
        Sun, 04 Aug 2024 00:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722758239; x=1723363039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9th/bKhMjvRAjGGVHBeVqs/CIYRU9eynsJIFdR021yc=;
        b=FM4U4PXH7PL32XuRlwSun1Nv/jeGKkrflWGxCdxAYNzOHBu1B1qZ5uu3+byZWE4Ccq
         Nbk7xd1P/ykqK4RoLGHdeOdQzmXHvx6nE55GevMtsuj9K+ub+Y8GdQrSLReDHwWvRF4y
         k4XooTADn8cGOdxyNtistP9YTYG2DeHmKXwrzPHbEPZheUkxCf725yQjkl31OnpXBaHM
         bIP88Dkzro8tMh3eOJ5g7qbskHX0z6veLYTQ8aDHr79L8WmpvoW82o5x7yfhzv+4XntU
         aZh9HAEpnIYMeAHo9jRVie44ln8o3XagJ98+46jpSYeY0cUIZj3tmHkdxV+BrbGZDgaJ
         I7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722758239; x=1723363039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9th/bKhMjvRAjGGVHBeVqs/CIYRU9eynsJIFdR021yc=;
        b=tXHPTTuVQXpIdB8yMc256YMz7EoNb6oG5ViaHRNuLlON1obfwWBh95XYSCWYjAPrrG
         eLBMLpFIMryqr+tAXLzcccgxw5Fa+kNKaVQLn3ZNCllgF98YZ8T5LaXYZJ35qoHCumdc
         7CQGmFTkeUNCPyfVkm0v+0LkccLP1Wzpv9sret8RIhdbl7ljmD7uWJ5YvV14w7PSMgM6
         pEG074lbRbrTTSgZNmWWsI67f5QwgSWQbDhM3KyxtUWU/Od4E6FJLcKIcXVSbsm9NSu4
         Qr2lCrNW747ytvwjQGS80a53RzQ8B/JkSMvei55bzwHVO+5ULUJ1tCSFBADxF933g4yG
         i5tg==
X-Forwarded-Encrypted: i=1; AJvYcCU5fMf6H/YlOWL7VZK+0NzhEBiEXFB3LaTUwI++OhXD7ylv34mcWRIThPbtLFCWgNQLjBJ0ujWzDaS86ATgZi3BswSWVOpat/dFCNDOevneilkzRlwaly4BvGPM58oX4NlvnTmmcslcRrOAYos/K6bFOGCUuh6gpPA1NPc8lTQhYPm4hM+i29NMMCFBxPnSmXH8j00xTtqXLFABKmOG9PQUZIHxhTbJTNdCg0+MdeZMhx1/QcZdePMQVr+dEqJ7mdWsiSRo0U9HRhU4/q8bVW1VYGsRPNWuGxDcHdBNHGl+tkXCDlqMpGAI7t3DT+weim2TkUNY2A==
X-Gm-Message-State: AOJu0Yw5eiddQmjwMUHhsUu9o7fLu09gxj9uZzh9I5mD4iSkdf1DzZET
	xTT4+3NbgO/Yc4eTA2VQnRborvz2+oOLoXThT+5nGXzx78nS33NM
X-Google-Smtp-Source: AGHT+IFtTPhQAQmKp5sRT0b26x8NVcEvgcuc+FRvXvXgBRo6DjcIq8upCUyDVHbaNG1PlsqP6YWdLQ==
X-Received: by 2002:a17:902:cecb:b0:1fc:5ed5:ff56 with SMTP id d9443c01a7336-1ff574a1977mr137301625ad.61.1722758239497;
        Sun, 04 Aug 2024 00:57:19 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178248sm46387605ad.202.2024.08.04.00.57.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2024 00:57:19 -0700 (PDT)
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
	Eric Paris <eparis@redhat.com>
Subject: [PATCH v5 2/9] auditsc: Replace memcpy() with __get_task_comm()
Date: Sun,  4 Aug 2024 15:56:12 +0800
Message-Id: <20240804075619.20804-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240804075619.20804-1-laoar.shao@gmail.com>
References: <20240804075619.20804-1-laoar.shao@gmail.com>
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
2.34.1


