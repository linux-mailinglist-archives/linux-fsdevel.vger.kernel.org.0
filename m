Return-Path: <linux-fsdevel+bounces-21586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56369061DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 04:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F3C282672
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4EE12CD9D;
	Thu, 13 Jun 2024 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myJU15c2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D884A3C;
	Thu, 13 Jun 2024 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245887; cv=none; b=nAhl8Yt8S/IaeTyj+xBKh+ctbhf9hG20A3KRiTxoMYbdAwhvMH2KbtY5xauZP6zhGsxMM3/4XGF7VHrGST2vsvE3TMcCNFQjMSO3J6VrHadjdiyhmwgXRAmcSO8TM3Nft9YBdmqVb5C5Fyh2fq9KQnDJgXl3o+DGdQXc5Fo8NRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245887; c=relaxed/simple;
	bh=yr+SpMmeHSi+vcjVeTr/i3O/gnrB5nRciCU2m0INHKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGv3DsgOCMy7yGcvBTipngmGNmMdD6/Ta1RZgMpt2cX2/s1UNVlIIWdp/jefkPOSCXj9DSHXi93iGbvSsQZZxGVb5aquG5srKwmMidowKRhgREUc1agOS+bb+6v3x3+k3FAxtKFg29nOLqD3o6RUS2vPntHb5a5mLC0byfmMonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myJU15c2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f717b3f2d8so11864825ad.1;
        Wed, 12 Jun 2024 19:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245886; x=1718850686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQwUpm7TadSQyuNlGOfh8JWtJNghSVDBcHtu3NLgdvg=;
        b=myJU15c2UsGWlCiRmJxSo0cShxKx8Bg7I2NvrTuLfaB7SpJSsJyjT+rQNRTKnJAEjO
         /QjtFEAKN1HFFQ7ERINlTzqVc3HkfRO5FEmNEJR/F+Xx7saY7b1MeyEvBE+IzrHU9qok
         S9gFvRZwo88xAyrRqzSBS2kddl1jUlo81hhC0ahIQyKyGqHYcyPKnJs3w03yL2J9Cv7k
         d3O0NbN9FJVHU2K1VlI472qzqfywnyXiPpsZi+i82RoTIakEFYkJTTpkpFkOIe/Ux5I8
         852E5d/mY9QsZ5YocEQTBCdmOhetbnAiJ3PTCVi3AvWDE+yuJPtdUuZHhjGeMHIz8hOl
         YOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245886; x=1718850686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQwUpm7TadSQyuNlGOfh8JWtJNghSVDBcHtu3NLgdvg=;
        b=LQk6ifHIac/RRjC6QamsKvHLoeOHeaWKgu7sfPJeAOL2KFymoutCLyp3bEImBRohWi
         uWJku7qZ5XOCfFdrt15LvUzMFtvHYJ9nnZr64eldG2mJZQXjt4dURyT+5uMm42WRnfhe
         Rx838wj5hnk9Dfrh4HBCCURwN3GriXkEwhNuz7u0otzOQmPS4/ReScqrGHb8EYM6lXN/
         qvZSWdgXslzyPi58tKXjLrtmOf/dl6GUizVkQ9D68MBGeI1qK3SIXMOvHz8iOlJqkNOi
         zAtZOvAdI7QnsOQ4c7vd9zBy3W1j9ES/wvRclbg8+YKM2gwKWXxt2oZN+6GJeq/DzxmZ
         1LHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHkki9oTMGxtVZEYysNTF0ZJhiHvK096h0WNoU1RikSV+ABu5bsROEMQgjesafIAuTnOCYxDMlS7MdBX+Ix6RaU/oi+/QeGTzkB8712u4aUh7kt7Wyzwe3X6T4xqaHMjhCfl/o+V2mUEkP4uRxe1vel0G1VgznF7rI8d1CZ74ses5c/yIr2mwwCI6YJY4i3jeg1qcGmNHNTWdFQGUP+PT87Ve5/ZPIGTsp9MmDWv+PcXl3yZjsP61nd+An4A/tBVjT6x380IGRHfwyld4YfXt1Vpd1qKZ+20F/RcV/1d+aD2GGjcHJ8sDdnaS41dNzpxsy8l5S9A==
X-Gm-Message-State: AOJu0YywAIV6qyOXu/AyiP/4bu/EnoQJxt2SkmGaP5GzUX7hhkaNsWtA
	O4pwquCbiGAcPiaiYytDYl700LVHM4+/pyyJgEEvAQlMpb1SRaDf
X-Google-Smtp-Source: AGHT+IGMO7B1LQEga8czanZyIFvbKD26XnoiSA9hTxuO951zhYSmXnFwAhLQKN8VIXez5ya7Dmvfhw==
X-Received: by 2002:a17:903:40d2:b0:1f6:ed6d:7890 with SMTP id d9443c01a7336-1f84e2cc0b3mr21158875ad.16.1718245885659;
        Wed, 12 Jun 2024 19:31:25 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d159sm1755695ad.289.2024.06.12.19.31.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 19:31:25 -0700 (PDT)
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
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2 03/10] security: Replace memcpy() with __get_task_comm()
Date: Thu, 13 Jun 2024 10:30:37 +0800
Message-Id: <20240613023044.45873-4-laoar.shao@gmail.com>
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


