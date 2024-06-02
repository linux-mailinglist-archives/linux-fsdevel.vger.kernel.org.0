Return-Path: <linux-fsdevel+bounces-20722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0103A8D7323
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 04:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B185228210E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 02:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D578749C;
	Sun,  2 Jun 2024 02:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3zLOiTs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AE33207;
	Sun,  2 Jun 2024 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717295927; cv=none; b=GMsP0AlRPMZiwIgrHlbbm50z09XjHuAn5vQfXS/4B9J46+dVYwH/MOFEnLi/wJJ1hQLO0+YqB/PoWO/vhorqFBy4BPyU3WF9/C48z4SZkDUFnhIHRQUAIw0Q2KPEQU3Z/V4WsPeWST3unZu44BqdWM1cJisgOjSs2LFANPviymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717295927; c=relaxed/simple;
	bh=BKOmOHopmzAxUYtSgNtlju0xV38CETbRh7m8PHKcY1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PbiRgEClESwfhu+J63riqej2I7HAjykOgpy2Oj6DpyfnbAcvxlEzMcyG3r//gOKJ9LaJwwPslqm/tsDpJD6Ad7ZyuayA2Zp1LCMT+C2cI1S2MCTq3xqTB0LdjKiWvQaei6irEyMiaQbGT0Lfjk9gzzFW666rx/doNTsZstrR0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3zLOiTs; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6bfd4b88608so2460944a12.1;
        Sat, 01 Jun 2024 19:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717295925; x=1717900725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwXgac49vNiqQKiAaPBrbZsSURsGJANu7JDjc/AUCv8=;
        b=H3zLOiTs98x+2/cfYGhcidlyOj01Vx9POSenI6XLg7JU0gXvdmVGkayixnrA26tXQS
         MozY8kMDdY3kM9VwJR/9sIWDQM+nCNgVL1mUChAyDg+mSj+KCiAK0qq8sNsAdsnvnrst
         CpEgWk/TKOEFMlXgozX4kYQ0BCpK1Ntbxz7sD3Eo+EtZ5S/ttOSUpATSSU/uHr/RuWVg
         hBLxN1bBQDQeiHe9Gq+UDz2DgvJ6SHxZ+TKNn5tLOXsC5xJLL4jUdThuloz8cGcY30za
         n3RThRxExJ2TPqWYUCPb8IJ7197EynTVzUS2lLePTB6qy0egTFPHQO/ItV0oct3D1uWp
         ehCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717295925; x=1717900725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwXgac49vNiqQKiAaPBrbZsSURsGJANu7JDjc/AUCv8=;
        b=e0DF0wau9ehTfB8Myy+xnjXwAZIfaZPXtXZnciwcJYXJ6AxpvB4HmhMQJc9tuVPzvh
         JAtfiaUlhi520kBXvlbjyfzGgOzzMTfwyEYcleF8Aq4rmCgiuAZC6/g7NsbYMjpsyPDO
         UGXdduD//jtMyA0jmhM2j/O9oUQcR/HRWS6CmF8roDlJPOLuVb+EoxY7V5Nz9XCtypqc
         sfekE5tK3/5Ws7Ma6lCaeS2xhRQB8BDQIwUj9KYnB1j7oTet8mKjs16giDBOrvrsMGbc
         4Fm14MMB7Afojx5wiRu1XpvhICCh93cBVN+VpttIIf2ne1hLBL0WpBkCbywRpwrG0qsU
         +O/g==
X-Forwarded-Encrypted: i=1; AJvYcCV3lYd+wo8pSqQy4dYbj+rWJF8spBg81D9ZZCOlIqF647Zcw6d+0Xla6YoufnwcMZduz9vpNBtPkrLyXPOUw65Nw0WoG8vbu6b1XuQiZevDw1jeFIt6yINrfDp4AADTaG/8GqOZgZYLvvp3Xbveh4psuMCDlHJPEULBpzXlGA7IanhQ+obymkZXkURrstd8VnVmFgL5maVrAmysHw09Wm9kPrRs9bviqy9q7nlhIeIpgF2KnKhjNa+kva+jrrK+AfDVURRVMSqlTYd4dO9FA5YJ63Oh/JIS13RrLTtJHQ==
X-Gm-Message-State: AOJu0YzKWVMw+RglxPO9966QgjUxiz1G80xJWK938GI7/w4wA66tUGhM
	qCv/JCyTsiaTqE8ccM9MCqgcJQdpBvDnXkeE0S02b3u83fGZZqCl4D2IJyu2
X-Google-Smtp-Source: AGHT+IGxdz166Qj5hr7gPenbJxzI2r9mPKQqOG9IRmdP4Ad2EqUcAIvbF35C52RxuyHIZjzO8B2P0g==
X-Received: by 2002:a17:902:7842:b0:1e6:7700:1698 with SMTP id d9443c01a7336-1f63706bba8mr56224725ad.35.1717295924813;
        Sat, 01 Jun 2024 19:38:44 -0700 (PDT)
Received: from localhost.localdomain ([39.144.45.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ea21csm39379575ad.202.2024.06.01.19.38.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2024 19:38:44 -0700 (PDT)
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
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 4/6] security: Replace memcpy() with __get_task_comm()
Date: Sun,  2 Jun 2024 10:37:52 +0800
Message-Id: <20240602023754.25443-5-laoar.shao@gmail.com>
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

Quoted from Linus [0]:

  selinux never wanted a lock, and never wanted any kind of *consistent*
  result, it just wanted a *stable* result.

Using __get_task_comm() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
LINK: https://lore.kernel.org/all/CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com/ [0]
Cc: Paul Moore <paul@paul-moore.com>
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


