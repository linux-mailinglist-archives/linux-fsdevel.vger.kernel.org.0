Return-Path: <linux-fsdevel+bounces-26162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EC9955508
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA071C2140C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 02:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD3978C89;
	Sat, 17 Aug 2024 02:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiVluZD2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D42E567;
	Sat, 17 Aug 2024 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723863429; cv=none; b=L9UPFkpRbVNAQQhusyLKrbAMiDY11H+VhmUs1IoEvsLd4LE9kB6loou7O3rcq/dvmR+gLUz+Gjt97NqmgIh4rddpSaLj3JKWWx/i9V+8V/bm8XuXUbRXDEllyYFDkuFAXsB6pqfOklWFGaCFHo17QYDLZsoJMMKv0ZIdbgbmYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723863429; c=relaxed/simple;
	bh=mCSSieTexVEhRe5gQHXuwUO8PEAZIQurKnIO9AahPJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=an2ACEoHsKaPTkHNWmi1FcCbqx0VrubXT6cDz7nW/3fM+yuTs3NizNBSudBEqlZYlcqJZFrmPNPDs4NSMWRqXZWelMzbLB0r6pCDqj70SqizxO+DmpjjVCox9TEFjSGHdJcMvb5h2W5NB+ml8IWkAs0xCQ7ATrbQLivt5bkp2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiVluZD2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-202146e9538so7972355ad.3;
        Fri, 16 Aug 2024 19:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723863427; x=1724468227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RcIZVYUDMrvydSLTObUn9UWjAdkDM4CrmA64YTz3G4=;
        b=NiVluZD2wfkXWa74ZVvrmAG9UL3/foobku03KrbIyjhPqcBmbtKvU7oZyoJuZnpZYp
         vbdJtbyv3s36g0OlTjmxyJ1kaxm+Nku26+eeCoK/+/lN3SgEqdmqB7IlxcLUzVrU5IfT
         GhG3wwl+7F4/QHUvUfya2CYN775yZDPF0/ieMZnlBfF+MeE4qAt7hb+okxAo6J7AMZHm
         ODAdMQGfxPSHtgKLi+Vx6tmTaXz8ZUeDgPQmK0TOdqUwNC5t7ppAb1/1XnqIEXJz4bB+
         t2XvzhoBXuNgJ2vdyHKOm3yRCaRbP2zXjJMZDTOxAD3brmdP62N3uKBDLImJ+K3m0V/o
         Tibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723863427; x=1724468227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RcIZVYUDMrvydSLTObUn9UWjAdkDM4CrmA64YTz3G4=;
        b=WxBQIPuC2+d7Wsb7yvJDmep1oE3pP34LEwEt5vccf753WcF0cnpvSM8EJ4JgY7/t2A
         1KehQEyE/f71nGOL30DvQyOhBa0FCmM5BRWZ3e1yGzQjQLwotelnsCWN+nM4UmyFblJO
         nnKzSWRXEGk7+gMyv0HJGJv7q7mLQZAj1wAa5t2YpDMhz5M4FXN8oyKnCEbn9kVkmqxB
         W0Ccto8VIDD4AjSdlj0+0RF/zQWJetIf5cT8pzpoO/M6T0wF+8A6e+zwNYTOMdF1joQm
         /I/LeF7I8nZc+ZkO/C9adAvrqq4+uJcjoqQiBKgCSwwP+Wi7xLm+j42BXauj+ubPXcA/
         UosQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2sANLTH++xIcXuzlCLDGrW0++GNCR+2qwhIAw5kVfoe4LL5vxuv6m0crPHf8X+arQTUb+aWenhtO0sAJFJyaOK86HCJIRYZ6mn8/GGOrB634147aOujH1Kyym7kPIFegcvVOw8P+4g6OJFjAc391JWGwos4nU98gt7q6AT99Dd6CNIhGpIlPS2VlNvMxN8iIv31eANLWbgQhNhd9ZeudhTqctTck3e8O+teEih6PNqefvLISVuPBkBGdaARZdIIy9zNQ2L8FfUVn0wyGlEYgw6+2zSwisqoHsCuV032HemJylMKOiBo2+a62X3OrUM65WsdsJBg==
X-Gm-Message-State: AOJu0YytxG170YciNncvJOGn+b+lSavEsXdljtUmv+xkfpseiax66ZfB
	yw5VfIpnimZkkNeVDeJ2NoJlhfXOfQWts5B4FJy/n3Xq9rFFZKAW
X-Google-Smtp-Source: AGHT+IGloZlxC12N+ArnDbFHNJc7Yrc4w00KFUrCatU21ag0p56SeEdkfwKvEveNvVnkzBGuU5AKpQ==
X-Received: by 2002:a17:903:32c9:b0:202:bc3:3e6e with SMTP id d9443c01a7336-2020bc33fc8mr44372525ad.33.1723863427201;
        Fri, 16 Aug 2024 19:57:07 -0700 (PDT)
Received: from localhost.localdomain ([183.193.177.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm31801785ad.94.2024.08.16.19.56.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 19:57:06 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
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
	Eric Paris <eparis@redhat.com>
Subject: [PATCH v7 2/8] auditsc: Replace memcpy() with strscpy()
Date: Sat, 17 Aug 2024 10:56:18 +0800
Message-Id: <20240817025624.13157-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240817025624.13157-1-laoar.shao@gmail.com>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using strscpy() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
---
 kernel/auditsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523f..e4ef5e57dde9 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2730,7 +2730,7 @@ void __audit_ptrace(struct task_struct *t)
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
 	security_task_getsecid_obj(t, &context->target_sid);
-	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
+	strscpy(context->target_comm, t->comm);
 }
 
 /**
@@ -2757,7 +2757,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
 		security_task_getsecid_obj(t, &ctx->target_sid);
-		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
+		strscpy(ctx->target_comm, t->comm);
 		return 0;
 	}
 
@@ -2778,7 +2778,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
 	security_task_getsecid_obj(t, &axp->target_sid[axp->pid_count]);
-	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
+	strscpy(axp->target_comm[axp->pid_count], t->comm);
 	axp->pid_count++;
 
 	return 0;
-- 
2.43.5


