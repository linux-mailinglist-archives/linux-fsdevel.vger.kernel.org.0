Return-Path: <linux-fsdevel+bounces-24391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487F593EB63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6721F211B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5E27D3E0;
	Mon, 29 Jul 2024 02:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+yXPImA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BDD26AFC;
	Mon, 29 Jul 2024 02:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722220742; cv=none; b=lqW747M5v2SouA7kY44ViLSOFmuv/joubFrnPSOxxXgXgWuey57xU4vKp0vQCnnK7msOrRx7IqfrAWpses1yaugC6e71CTQ+/mtFzExgUnD7i98g+pRw/L1j1T3U+2eje3s7GPB7sfXVP+GtpFWumm16sxwY8gAOUfoQGSpfDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722220742; c=relaxed/simple;
	bh=RhhRTzGzjqJG2IuRKewfcKjpBWjGGob4kNd4UpTBjcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GO0S5a2/hpuQDMcPYSmmgYeDUUIR7lEiSPh9XLi9SMcBYQbWhKNSWKzkfhF5HoZuzB0VFo98v8eBge5cKFX30S5+ad7VFpJrkuaNLf7ZFh+ikfcgiJlmPAs1yqgRd1OuG0XLzsvZsvIZ7x81BauYrG0BfE7yRhYSVzJqEykHKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+yXPImA; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso1625775a91.1;
        Sun, 28 Jul 2024 19:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722220740; x=1722825540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+o2QcP3zzShPD5bpWdvqtRKk4SGVf/ncCjWPDHjjaM=;
        b=D+yXPImAz6FgFP8cyciCw9CmffSqDIq5cEFQ4ss7LnousCvVQ7Nu+5RHuxu++9mjXo
         lnyERIoHDN9MIYO9irTd/RA0dmIlGKbGKbDVyaOv5X8n9kl6Kb7YIMmu1nXHAn8uqz0c
         cGUtiZOx9XvsRj/cl9r5O6ECSBZIHQx6z0cyO8qwHggo956pVdkStvomtd+oWcphYarV
         VSdHRpYZ2ZoBWW9RMSB0O/owVSms8gXrVJBT3QjDLEyTxPBVBloaupW4lGR42Su6ac/n
         JCEWO5aFA1w+unCidG7qh8ttLMRJFGuXyrSb+DOxEbTZhuUSHlzgmoDFhpuerHu/0MoY
         N3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722220740; x=1722825540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+o2QcP3zzShPD5bpWdvqtRKk4SGVf/ncCjWPDHjjaM=;
        b=XHZIe0+kMWrlPgdJ1zuwu4RTrspv2ehAZEockhNmUH0LtRHsT6APJjzYyVItD+6Uas
         B9bVGpdlt3RYFpZrjju3jw056BadT+IhwzzClkp0A7XAbs+BCkJ17HN3Be1/htMocF7x
         v8WQyIAtJ/8/+IYcSC7KvKC1rhR4oT317L34YA4nYINWWcPFgicGIN+dlMhxLuRO473a
         ZrGpxpa8Km6JPfffsyGEEUxgfEGI7IlUAr65WaWS93zj7FgYwVsCxZd2F0hVN3WJO+ja
         Mi3QtL5jt6viBrkevTf/miu6EPpbxD8vmLEjJjxsf6eYruho3n27jjYlGAXBmgAfEZd4
         ldpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnpYIY1Yw0iXfIkkuYcoHDSr+O3b3QpZQN4ukVKKkXKJoQIfzqa7P+S9Kx1xbUiLlMsx9m1K4TJjQkanHI2tdwi/cp09cPpIeSLK+Cah6cyR/qcJu6hbuzDSajW/b1akNUUbUx1alq21T4yYdxGha4baEw0Et4ia59bsDu3FjrhPxLsJsQT8x5yBXJQUQXpocAzQa05e0OwqcYGTQT66gC7aeNyGoRUr3pPWddv5ampdit29Bgp7SLTGGybPafBKAlZxwmLhN77Rj/EVNf9pthhaFfuLMHJpb54ITf7O3oIP2owbHw1mkjjEzvV+5keVb73WK/qA==
X-Gm-Message-State: AOJu0Yyp82MpuOIXYMfraIkpJtw7yUXj7CBE0oHgzJHfmrvRbd0JUm2D
	LyRrANpemKXhyAH6bM2yUvGaCmIWjb+1hpqOa1nEAK3au59hvMxe
X-Google-Smtp-Source: AGHT+IGBArXuQ6UfIKXak7ZIiMIQBzEmqSTo4bq3Ao5W++iZVvXLvRGW5ku9X9sKf2s7GMsSLwtHOA==
X-Received: by 2002:a17:90b:1649:b0:2c9:6f91:fc43 with SMTP id 98e67ed59e1d1-2cf7e1a3e76mr4224751a91.3.1722220739919;
        Sun, 28 Jul 2024 19:38:59 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55a38sm7332247a91.10.2024.07.28.19.38.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 19:38:59 -0700 (PDT)
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
Subject: [PATCH v4 02/11] auditsc: Replace memcpy() with __get_task_comm()
Date: Mon, 29 Jul 2024 10:37:10 +0800
Message-Id: <20240729023719.1933-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240729023719.1933-1-laoar.shao@gmail.com>
References: <20240729023719.1933-1-laoar.shao@gmail.com>
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


