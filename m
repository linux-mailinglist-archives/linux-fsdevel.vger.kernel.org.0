Return-Path: <linux-fsdevel+bounces-22048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEDF911894
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED7AB2157D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9A8127B57;
	Fri, 21 Jun 2024 02:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGV1dpDf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CAA84A5B;
	Fri, 21 Jun 2024 02:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937072; cv=none; b=lah41e5lRwtNG7buqlPf65K1dpJ8orS0gxc+jdNUyl3tGUnJNS+RmXOGu7pNzNYn54k7/nH0xrV2iY/Aq08ZMnvXGAdknHLLeFenC90djxmuBmkqP5FidmiXFT4pp83sxtVyBQpxmlhHqHvaA0yy2W6NskziKjD2VXmWKjgVh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937072; c=relaxed/simple;
	bh=yr+SpMmeHSi+vcjVeTr/i3O/gnrB5nRciCU2m0INHKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkjweaBf21e5tRiwyjB06Z1L+Ci2tzefWFhLvZjFdpL2sdjqINk6xeX1garc7jOSy5V9N7/mDZudM5/GEE3nMEY3T1YE9exWXGu09qEEdYap1hvCVIAACRBYRNuAzojMobgEgnklpDW+vtaxbySVoYHi6+wzhMuB/Uq7dno7+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGV1dpDf; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f8d0a00a35so1453616a34.2;
        Thu, 20 Jun 2024 19:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718937069; x=1719541869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQwUpm7TadSQyuNlGOfh8JWtJNghSVDBcHtu3NLgdvg=;
        b=lGV1dpDf35Wne9DtyCr6Pu9VNJAQSDGz/+jf//5oYLY+Kxjz3ug6f5Pzsd7xmYomkJ
         ywCXaRydIYPBaVW3pkOInsR9Ugynyr8xsa5SFHToHm4GwOUXn7b8u048yO2vCKGe+hfK
         VG57diXoHD2Diyz6iznEyYb7nbvnSbRuXeKK5J8qs8f+594w7c9Uz7aTxYNT7fDoaimu
         sVvB/RNQk5KL2BoPDpcDTQps9hODVZYfNmjoFpCgCY0bj1wOluM0JaVssikachrL5ME7
         5UMlfyIQqmHWrdQgDr7oTykgo5qhf3a6ckf98GhdhtoyCYSw5fbF4FK4U5mIPvowcTBo
         EDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937069; x=1719541869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQwUpm7TadSQyuNlGOfh8JWtJNghSVDBcHtu3NLgdvg=;
        b=r5d91Loms4kvZzmW2FWNx/NT8BXIghnsEq7Moc3oXTG+JUzGMx970oQ0xfsHJ7F9FX
         cUEg5bl3XQWutSYxYEbVUGx0Eohbju5VUAaY+MSRw34smykpZAy7NzSabCCP4vWHBzHW
         MMbmnLB8CuEE0zwOEqEbqSb7CARUzHU8rjkwn5GbreCKRYRheIIQAIYj81luo5+Hkyy8
         Dn5oZ96S7P5vtEAkpG7cXDB7rTiQlDWsMWqVGFs3GQvVbvgekDSQL8mLKPD34wsKkcQN
         V7QECxvbu8B2SGv/FU8ynxN7iOg8VTpXZtMOkLkbtB60BaWs/zyw53zdgMvcxtey1vOV
         NIyw==
X-Forwarded-Encrypted: i=1; AJvYcCW6TM+bTmRx3cMcTyoIC3wXIza0qxESaOlnRJhineoFtOGsU9ZP+e/DIF3mo54s0hrtrawEmdgwCkziVMmcuiE/llIdmbp5w7CQZeVHw234e1vZu78Sgg3d9Qxbe/LNCKgpHN+16WR02Yakq9W7dadyyzGXY0gGVzk9LmPmO3Gf4Z5bjt09FKfT5txyv/k+reI5SCEs1tc2sPVm/MQ3cvOT3mFuZjX0SRFPOQAQvaejnL1PkZ81c9xLuKqKxWEyM0dllyPEiK0mW37tJ0T/7UZJ2BXYXVAZ3BWddYHBxneP21yWvmETtQrdPgX+RBruGhamn9KnPg==
X-Gm-Message-State: AOJu0YwofpxlR2nj2fKDqdBfUPtK4UdxCJoCCQ4b4GA0HcLzvOUOty90
	ETQB2kywnkKBaMmazPpaUT9nyT1ZvekO15iie9AppbQ4nUERd/2h
X-Google-Smtp-Source: AGHT+IF9RQI6I8fwWnu/VEcjE+HIUegV9PWFNk6TPRJqj9VSP13v0pKuFsE10NjsKk43i459GXxRWg==
X-Received: by 2002:a05:6870:b52c:b0:254:7a82:cb3f with SMTP id 586e51a60fabf-25c94a2368bmr7837289fac.25.1718937069341;
        Thu, 20 Jun 2024 19:31:09 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511944d2sm332488b3a.70.2024.06.20.19.30.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 19:31:08 -0700 (PDT)
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
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v3 03/11] security: Replace memcpy() with __get_task_comm()
Date: Fri, 21 Jun 2024 10:29:51 +0800
Message-Id: <20240621022959.9124-4-laoar.shao@gmail.com>
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

Quoted from Linus [0]:

  selinux never wanted a lock, and never wanted any kind of *consistent*
  result, it just wanted a *stable* result.

Using __get_task_comm() to read the task comm ensures that the name is
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
index 849e832719e2..a922e4339dd5 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -207,7 +207,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
 
 	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
-	audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
+	audit_log_untrustedstring(ab, __get_task_comm(comm, sizeof(comm), current));
 
 	switch (a->type) {
 	case LSM_AUDIT_DATA_NONE:
@@ -302,7 +302,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 				char comm[sizeof(tsk->comm)];
 				audit_log_format(ab, " opid=%d ocomm=", pid);
 				audit_log_untrustedstring(ab,
-				    memcpy(comm, tsk->comm, sizeof(comm)));
+				    __get_task_comm(comm, sizeof(comm), tsk));
 			}
 		}
 		break;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index e172f182b65c..a8a2ec742576 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -708,7 +708,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	if (new_value) {
 		char comm[sizeof(current->comm)];
 
-		memcpy(comm, current->comm, sizeof(comm));
+		__get_task_comm(comm, sizeof(comm), current);
 		pr_err("SELinux: %s (%d) set checkreqprot to 1. This is no longer supported.\n",
 		       comm, current->pid);
 	}
-- 
2.39.1


