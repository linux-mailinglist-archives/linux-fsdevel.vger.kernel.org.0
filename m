Return-Path: <linux-fsdevel+bounces-20721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDDA8D7320
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 04:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EE728203D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 02:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5627EAD49;
	Sun,  2 Jun 2024 02:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpIKMHHX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B44C8C;
	Sun,  2 Jun 2024 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717295917; cv=none; b=VqqMy0a4C5akdZKxP6+6+yPf/QhOtwQrNYHmLG47JuCujb5uGXqZiYwwl3R3aLHu+scIMpVs29uO4IsplmbPHnC5DHivyS3L6PSVwJ11FEpaIAuowXWEqIjXQml9wbsahnsxkXWQ6AGa3aAu6WVNMVKCCD+l0WDyF576rqI+W3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717295917; c=relaxed/simple;
	bh=3RtLwIqj8y9FKL3we3+yUHHdPufkZZtSuz+OWtIZu5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u/mWrgSQuB6yK8FEiGWX6QJiErkuMHHn08yDN/OMwisfFwzk/VBIGNaDBFsLhOhzZ7aj3Uv/+LP6Ma8WyQSePWV7K1N2xDKhmWV2/E1t2FoMeC5oxixjBeowVV+jR99XD/sF9bYOp+JgQRnKmM3UosT08e4pd5mbvyd12m7W8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpIKMHHX; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c9d747be82so459127a12.3;
        Sat, 01 Jun 2024 19:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717295916; x=1717900716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86BLVNhH4ic1Ff0npcvsPGdGMp4TM/B2Y17eUoaRoKo=;
        b=IpIKMHHXlk40M6HM7zVnEYf1vdIIJ0TDmjod7p+CQKUlfrtE/2t9tF10UynNhKuE60
         BchTP+I+NfC2DODCxZf5Z06TBKHJ3bjJoiU2AJL7ZqZNWVBS37iwfO0HWB39tfG1Hv5b
         CQt1het7uaMps0gAGAm0V+ULmhn0MAXBb/NKgIkDamfmdw7wontDyZ98Q2WCoBCQM98e
         j55/fEJaV9oaqrqsOmyRrGeYx/wTyMfoXkRNiff+oancz4ENQTcrAOpBLjo41pLUFYex
         t9HSsdBDgHPsPOFcsvsw6W6a61zp0IMlCo/mBSwlZU04Tk6e12mUgQhgoAKbHn0lKvs1
         zFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717295916; x=1717900716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86BLVNhH4ic1Ff0npcvsPGdGMp4TM/B2Y17eUoaRoKo=;
        b=jb7FUV9KPKzA2j8vkqeFMD1oDUeMeiabPIUzHwXoSOZYjv0EM/g7TFcT6gy6k8s+gb
         jWKYjp7UF/Y64hya/zONw4pjj9074p4WqDV3obxveOqPcz6axNP5dFS3Q3BqTHfpjwUl
         0mjBtT1Ya0vQbPOhHkNNUBeKNP2KBPcUp95y4i+LcRXDe39OGBT+lg+1y5D5rIOLIzFB
         kNstN1FcYZ3iE1OXs2CRigGIYpr6dZNDfg4h2E7m60e+RH8Tr6R1PGRCiSHoPYRgIa+3
         DJVrjqB1e5m0vhWvqk9+2s9hSvyeQCzE5KhI6Dj2Nf/ZIOwa8MGjoCHBHdMristkDPMp
         clTA==
X-Forwarded-Encrypted: i=1; AJvYcCUIypwU72By1fR2oe9bjITC4GTD2/QGZ+C8Zi8mtS0hvAJQcCWFSx86Az3874N2R81k4JtOl2qWtRsVOhPPy7DFgWkESZx/HuYXNQQZvBLocbBsgeQMgVYgj8mv2ZFwjT9ZGrqKH5dtowm/bOSKS3FJjgyPfwunWZlL21g0I25d/53f23+jhjLXAaci1JUB1g85uyqoIs6mAYULTiY8SyWxWizEca4GQT9/UgH50Z/Wu6Yf6pV1jLQ4lgPo3ODbT9lc1cmDDWgWUXFdT442h6USXAvi88mGZdgMLdatxg==
X-Gm-Message-State: AOJu0Yz+Z1MzGn0gkSyVTAGjKOGz5pIchTtI+x3nSJiA4GqfE9ixSe7n
	+87ivFb8HQC3WQbAq/yHYnvSn386kmyl7+pyrJRLByu32IaJSW/b
X-Google-Smtp-Source: AGHT+IGNFv/boPhAUu2B0W3t33lg4GlGND9qco4AaBPr3IkdnpkGlhsaTOMWXxep7jl0e5AswLTzAA==
X-Received: by 2002:a17:902:c946:b0:1f6:6946:ef72 with SMTP id d9443c01a7336-1f66946f176mr13505155ad.36.1717295915514;
        Sat, 01 Jun 2024 19:38:35 -0700 (PDT)
Received: from localhost.localdomain ([39.144.45.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ea21csm39379575ad.202.2024.06.01.19.38.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2024 19:38:35 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Subject: [PATCH 3/6] auditsc: Replace memcpy() with __get_task_comm()
Date: Sun,  2 Jun 2024 10:37:51 +0800
Message-Id: <20240602023754.25443-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240602023754.25443-1-laoar.shao@gmail.com>
References: <20240602023754.25443-1-laoar.shao@gmail.com>
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
Cc: Paul Moore <paul@paul-moore.com>
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


