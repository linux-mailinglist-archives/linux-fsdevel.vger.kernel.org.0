Return-Path: <linux-fsdevel+bounces-21585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278ED9061DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 04:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DF11C20F6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7775812C466;
	Thu, 13 Jun 2024 02:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdDP/JRF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D088D33F6;
	Thu, 13 Jun 2024 02:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245880; cv=none; b=sNk5CrkVsnIzOedG8Espcq+9Jyflgez7IfvqeT5WiQgTYPNMyJj4zZKoPb57PALAT8K3e3lw53tI+5CLO+/8vMp/g8x89wHTwxKU9VY2buvSJjffsorRE9+JMBxWkhziOeIEXE9R2z+os1oK8iibRIyN9f4sgHoyPH9N9LHNIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245880; c=relaxed/simple;
	bh=Cmml+druTyvH17AsxZ9+qWd188UAOiUJPJyv4QJyitc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTiKd0ZoFZ4Fh6mhaSoSt8I0ANii98wzWml4VQ5fWZkc7w2iCu/LuIM+e69J9YzalNuiPB7eeUACybb0YeudhtDEPzq/yFqV1O3CDIfOgQ13FaRvmUAO0BRPSJgRQ33aY9Zb96H4PDahRKLMVnXveLTx+/TyiE8XVVgcSHtFGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdDP/JRF; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-656d8b346d2so407824a12.2;
        Wed, 12 Jun 2024 19:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245878; x=1718850678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1cpGZH9ekrwOk4ggaybwp6iXeGg5lCIICWIGBwiSB0=;
        b=MdDP/JRFpl815MlY0tyr04PRA5obt0cLuQWjzK4ZCcohuQ7snAyM6wgwoP4r5TK0A5
         fzFSSza+CKVvmmVg49/5oqChEqHqqU5D5ZHOOVKRvQbEwhoxTMGRn88JAg7vaiXplvG3
         /VkI+uA5kx46aJ7RsU8oQE5wSc9Mc1eP8DgzsYHLejm4YUYoyDys5YouWEt+N243bsq8
         3Oh1/3vx8y7h8GvATkDsSM7LJ7N+oRbs+e6+tKS1Mahdho1pGFg/F/T+d7BbFF1z6gtx
         LN4fmu0VGYrQtsEm4GxoRxAgtfXNSpYFkBmj5bAT7SUAqVTPFX1n8wR+IlEpdKaaGN45
         lb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245878; x=1718850678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1cpGZH9ekrwOk4ggaybwp6iXeGg5lCIICWIGBwiSB0=;
        b=OdV5gqIayTT9VMk+ftX2RcnNTfsl5G3OaqISws+jnEdw8MrUacra6kPAvJ/tsRFmHJ
         rpNXrOJgjxE40e15F+1PFxD28L0GpRq4ID2ft5va6f8YlmQaZtygxr8RxQdOeQ5JV51h
         YZd77wCFoZlXSUl5DBjPTE7bMmwwDg+zogRAZ9cZGzdGc6MaJLqSjVcPlZLsy7siPFX/
         9yPEFRdThQ6ScmEssQ1NJJkp/r5tgByG1a2O4QS3LocxGCeT1q9GErIbKdZ8MdrOCWYk
         SlqmSTFpPaHtA7LBz8CqhsNirkZ4aVlBQCwiR8dSx+oCLtrtWflFCCeZYeuTpCXD3ks8
         jD3g==
X-Forwarded-Encrypted: i=1; AJvYcCX0Z0que3KmCO753r/vbaxmQ3BRcUR/X3s7mavN8Zm1sn3El8/ubKe2yLb6CooLrmJbA/l+LynUlaJG6/PZ8qHUJaH1P5iyk1446wJ9ns3gOJ1Svb0lC1Ja6MJI4u/nEYEBvqYpjvKpBrJleVjMkiD2PXSBwXgHqQtqDLJYyUyJ9KwgfCQJX1VHWnoWmowRHEi/NbUHjBbSuSg2CRkF+wb2/N2KHoOuCkfm1b22XQ14TC6JGAlwcooIjeZQMGNgbZDbV0EkrM1pR34vmN0J8cpY3nJ+8Twy3TfH9+4BC9FjFCpRLahAm1TjjUMQMPteXgJTsdDl8g==
X-Gm-Message-State: AOJu0YznmyK2jyIWcdJ290Df02s4EEPtYsW8U1oZVmxyEC/xgnpmlOxn
	9/CmXIje6oPVVngVMaE8jhQ5KtQxSE4r91iVFLCeQN8IuF7mwg22
X-Google-Smtp-Source: AGHT+IHxE49dVlqeBIraoeODhxKMszGj4KYKBCDFAoiQKvyi2cHrcHMBy4aCqKmXdfgNqTCtDPqmtg==
X-Received: by 2002:a05:6a20:3948:b0:1af:8fa8:3126 with SMTP id adf61e73a8af0-1b8a9b773c5mr4249289637.6.1718245878051;
        Wed, 12 Jun 2024 19:31:18 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d159sm1755695ad.289.2024.06.12.19.31.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 19:31:17 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
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
Subject: [PATCH v2 02/10] auditsc: Replace memcpy() with __get_task_comm()
Date: Thu, 13 Jun 2024 10:30:36 +0800
Message-Id: <20240613023044.45873-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240613023044.45873-1-laoar.shao@gmail.com>
References: <20240613023044.45873-1-laoar.shao@gmail.com>
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
2.39.1


