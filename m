Return-Path: <linux-fsdevel+bounces-25616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF9294E4E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10941C213F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A492A136331;
	Mon, 12 Aug 2024 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHxHfKGs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850281E;
	Mon, 12 Aug 2024 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429847; cv=none; b=quDl86AjjQ3KWhjQ99COqgxly3wQQkR4jXtn7QgRjID81DwDw3xyUZXXDYJdPRksvA4rnDj7u/oX38tRS4gBnAiCnDAMahUqcKD0HIshTWC3h6PsAV3vaBjO1JCFZt3ltW6UGTLz3WNjNFIrQqIk09GGGLIgPlokeCHHmJH6b2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429847; c=relaxed/simple;
	bh=beNIuHvBIJLxfeAFVvySA+VczT+Dl/c43xINcvFR894=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fDRsu2v3uMVxrXqLtpwHxD6rl0IvO/kE89ocvRNOi44NpYFRpwbp7ZyJb8HB+/J6UC7tyipl3Qnb519VHv7ZmIB6cinKL99u4XxKzrY64bd1X2b5Y3KBb+wWCWHdTzf63IbJnNH7SblLW4AKwJ+h6vmc3tcdsHTsneV5RxykPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHxHfKGs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fdd6d81812so38567615ad.1;
        Sun, 11 Aug 2024 19:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723429845; x=1724034645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoIFivrPmimQFCGo/41HPdx35H3kdQIF/qhwBf2evw8=;
        b=kHxHfKGsr5kw8CkMMAIS0yrNCH4FcFnfgVvbmaRhPHjW0Sum2C1gLawMMuGOQ890sn
         NK/qBkPSoCK15aWGfzJPZ39V/isK9BQEkEPu6Op1OyLx8iQzFPw+bH+Hy5FWkMt5uiNy
         pqw0/WOp62qCgMrmgmJlLtlE26d41tbtMmhCzAML7cO4ChHuUozzMLHE7WQxFq7Wn14O
         ZcAiaEJcJcDEX7JN9K+wUpii5gmKUeexV0/nsezZy6k6A1tAmAPO6STeLSowxZh6yq3r
         sqykaBSpsUJS3veuOXDy0bFY4ZdhlxM1mB1VOUzOOIAMZW/SpM9oaoK3qv+zP+141Y9R
         5Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723429845; x=1724034645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoIFivrPmimQFCGo/41HPdx35H3kdQIF/qhwBf2evw8=;
        b=AaLImuWhftyrSDVZ0Alnrj0RqwvGDvXaf5UBx4uuFKjGqFdn/sJDIlMAxAaeqGrMal
         Nmyodk7PdZJtMhUewacHTCZ0fQXH8+SkQe3ZNyuXSC+jXeEvKehvjYFux6/Wlqku+LrP
         OYS6q57wajXWLW+CqZ8qB6fqmwxTapvRREG2vFoUEId5jKtmsE5vAod7JOt5FqYqZjEx
         RWN4/axJ/zUs/nSvwmTuBkUxCJ0BBOaiAiobpfESlbkBs+pDmx+V6Od9ZiHIYCK9MUFZ
         UyARWEW6FAgwGF2szjA7KDtT1pKX5JfodKxBD/4wv+g73YasantgpQCUSY3pDtmMb+Yj
         v7eg==
X-Forwarded-Encrypted: i=1; AJvYcCUshc3eLOVUtCnYNIDzJWg1YzMKre0IUxIyUQCzVRP8Pqw6yZMGOlwUD8RpQsGh7V+zproej16qQMCg1aAlSOrAHDb4/kPnpqjm3OaiiwK51HaZsGSINWCPtDcWCYiFov/pRqNa8zx9AdFyXS31oz8o9dxNVHnaJ+DWgRAwMzef4HgQY6xIxCUgQVcqb3MST/nXx8B8nesxCFi7QWTciNodumnfhdPMlmpzevM7OEu4SjUATbSN9BMOYLY6Uj/K2AiZW0RzbqfSTuefwkerplk7WipONaGiNnSF2hfYru+bKfTRCqrKHrhpN519CalZD9wyGaP3YA==
X-Gm-Message-State: AOJu0Yx7AMkay3EvFzUcXXf4yVtqDhNPpctBoh8HoCUnRgGqLzZPlXyh
	KiOrmOp7MhI9bu913iyb+4q6faCDmVJbIqv2dYMSHcbIVpdrr44S
X-Google-Smtp-Source: AGHT+IHsiTPfsy98RJjC8wpBNmaXvnlNH5fflWZLUy6tj95HlXDW+LhDZRUML9DQTQa1nKZJvXQLvQ==
X-Received: by 2002:a17:902:db05:b0:1fd:a0e9:910 with SMTP id d9443c01a7336-200ae5e811amr99536005ad.62.1723429844807;
        Sun, 11 Aug 2024 19:30:44 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fed69sm27884765ad.188.2024.08.11.19.30.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2024 19:30:44 -0700 (PDT)
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
Subject: [PATCH v6 2/9] auditsc: Replace memcpy() with strscpy()
Date: Mon, 12 Aug 2024 10:29:26 +0800
Message-Id: <20240812022933.69850-3-laoar.shao@gmail.com>
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
index 6f0d6fb6523f..7cbcf3327409 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2730,7 +2730,7 @@ void __audit_ptrace(struct task_struct *t)
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
 	security_task_getsecid_obj(t, &context->target_sid);
-	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
+	strscpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
 /**
@@ -2757,7 +2757,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
 		security_task_getsecid_obj(t, &ctx->target_sid);
-		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
+		strscpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
 
@@ -2778,7 +2778,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
 	security_task_getsecid_obj(t, &axp->target_sid[axp->pid_count]);
-	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
+	strscpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
 	return 0;
-- 
2.43.5


