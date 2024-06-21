Return-Path: <linux-fsdevel+bounces-22047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87E91188D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69181F22A5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FD986AE3;
	Fri, 21 Jun 2024 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpCRnQ1U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92753363;
	Fri, 21 Jun 2024 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937059; cv=none; b=kas8fcv/x/557g/0eZwG6hEIEnMEC+rysFc0lGlNwBM0z2l4ATWanDGCcIqppEU6igl8IFblntl5QcE2GGJATbFoXqePPOxyqj1KqfaXDX2pcFoT7hThKJpi97l+dyWN7SehE73haQ+njS5uc7dn3y5QPof5SgPeGXJcpjbwkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937059; c=relaxed/simple;
	bh=Cmml+druTyvH17AsxZ9+qWd188UAOiUJPJyv4QJyitc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ir7oh+4FrhqZa65nK/ULoWYX38++r/1sIsL4vnepeOswzWAy3BKJVaplCIEThs1AhsK3jn9J8uaSkr8kBEj+RGOMD+UEyrX2pGoN/MDUChfelsgnpaH+VI3cc2yjfRZvjhhxafL1KRStWZ8yBwyUaqgdakT6jg20jacTcTRxVxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpCRnQ1U; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70627716174so1372419b3a.3;
        Thu, 20 Jun 2024 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718937057; x=1719541857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1cpGZH9ekrwOk4ggaybwp6iXeGg5lCIICWIGBwiSB0=;
        b=KpCRnQ1UfSxoG633J8DR9JmR1MeZv8I08Kj97vI5YjNd1PiEYr4nxCt3//uqvZ8gkX
         vu1Uyt8xr9rQaAzrZnyaWxk1N2MrCrHamNHFNCXR8BjxGvPI3gDpOflQjGltnJavqYaq
         AVFZrq5m6yORCGHWG/iPs1M5L6XthMyWwwP6Tp4RBhSjbi1V7FnCPxGm4yXKf32t66oa
         9Fv31mCy3nZpqKMqzGqi+IoVH3klhz3vS+x9TnZQrnVMoO64kOZ6wDYo0mph4wYYOT7T
         EMpqr2VYDHPW9HCkn4ZQ8Z2D2OSJMwX2Gf/loeEMpAwQNnxgDh8Gf7qIpCmk7L7tXX3w
         qi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937057; x=1719541857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1cpGZH9ekrwOk4ggaybwp6iXeGg5lCIICWIGBwiSB0=;
        b=Nj9YsUuVxfs7h8btpZc36/W/bj2gfery45cbXZ6Bur5f5kucVyLwQBGlpgABYoL7Pv
         7cE8aOQOpstjD1pV7PNB0MwOo/Z98CzbKWXUwR185G+yvrGXjfyOinvslfSveqkzs+q+
         iCwm9E3sJAAJVM5x9tDv1Ky0M8IHwYG7Cek2edx0PzirTaQnIUePUep6cXULkTYLSR4T
         TNlNkrniq8NP2smMQ+xv9sIxO5BlvJ1G7qsBbj/yho1rOBfLpqLZEh7VOHXt1ID9TK6D
         rd5Sp9yyV5lcCWRUw+8vvEdtn5uB82hCAMjKdhAFKFK/p/qQaa+0oJyRytt/ojcLz7bb
         SIqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwAO5bkBghE7zSr3TzREMbf4IXyDyeAhuAkahIrXgxfFG96jcRrYbVSLsFMgmEKniAFZJxkY7JLzx7yG+uaQU/nSgFD9kWA821gBvnjDbFQ/Z3MjstYu0HsmPo/Vz1SP9UThgStDf0A5tXN+9iP82WhEte1io877YsfY3D4jz/8CW9t/8UBTH3U3nnxtI4HL1bTkYt12DUO+av+WoBOd+leKdriM+AZnu4Kt+umyKSLFUbSBVc5J9tdo91yEgcSQdI+OLPQLhVuRIaxkzkcLlC+4DnNIAZ/XA7u4J1JJLwX/nItWdprTYdFTsG71hO/TQ1W3GcDQ==
X-Gm-Message-State: AOJu0Yyosj9UDxKssQg7VrdNuuh9szSS2uNTrZxhEPsuLGdeJ60uIw/u
	6ElpRKl8jtwtxL76t+IkcGltu1bi2dxi75xp4h1n6qPna8qCfnh/
X-Google-Smtp-Source: AGHT+IEXObDJFHHEU4ritIMxu9doHb5HpGV/yXlLGQ5OCeoryIQ6hRw+mWkpUWLLJXrRfBg1YmPPYg==
X-Received: by 2002:a05:6a20:9313:b0:1b8:b517:9bf9 with SMTP id adf61e73a8af0-1bcbb574a9cmr6631143637.25.1718937057021;
        Thu, 20 Jun 2024 19:30:57 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511944d2sm332488b3a.70.2024.06.20.19.30.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 19:30:56 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
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
Subject: [PATCH v3 02/11] auditsc: Replace memcpy() with __get_task_comm()
Date: Fri, 21 Jun 2024 10:29:50 +0800
Message-Id: <20240621022959.9124-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240621022959.9124-1-laoar.shao@gmail.com>
References: <20240621022959.9124-1-laoar.shao@gmail.com>
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


