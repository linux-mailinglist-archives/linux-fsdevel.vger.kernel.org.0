Return-Path: <linux-fsdevel+bounces-24941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C67AB946D37
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 09:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516381F21B27
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D563A1D530;
	Sun,  4 Aug 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RV+J9X7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981B7494;
	Sun,  4 Aug 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758257; cv=none; b=sm3Zj4C7usVeFcr4qSuFOpG2IArqz/oDMgZU2LU6pU6SwFozk6oLHzaIwMebrsfJ3Xxbask64KXnR3NgF1ZqdzJhwmXJbCgZrjOQTC2EBfSdBEHRbElmpo0JhfnRCYgMgoddPTtW/cQdE9oDo3C9UkBXe6E2SE1FwTVqK30mhqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758257; c=relaxed/simple;
	bh=ZPrSWf5Fyf0qgLTyn3oUYou6AjnEnhTzFL6+lxfWdWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Frzxo1TzmZIH3/PTgb4IrByZPmfdPOx5Pu3qfCIpLbYlkvL00CNp6Lxh3Nc721wkulADrvTIPlghlx5oCzdsjzI0RJOK8Ql0G/AvskKbupgr42W/bm60udQosRmdwQjPRct4p5Xw6+Ho5F4SGza8jjugBYqsaK9Dv3wKN3SNhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RV+J9X7v; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd66cddd4dso87078435ad.2;
        Sun, 04 Aug 2024 00:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722758255; x=1723363055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0KTkwxi3yTBFtdP01Ghiv9wnj3oEVaVdo6Xnw/VoxQ=;
        b=RV+J9X7vBPEd+fQ5Ex2nFDefUNS8iYx63VsWN3gH8Oqt6RzAGVRrlZvdt1Yw5EIakT
         h0lc/7/+Jp9q/3cBkzoQz5+rKX7YkAWxHKHbdkA9FLO5vkjjh/3Je4ViuOPYDZpvZLak
         NrywU1e+DUzYZxXJrec1oEzIKfhXGEUYjXiODGiA14A4YTnV0wwYQ6JtXTDZtf59Zdg3
         jqzd/aRazC2cOsCt/xB2L10tWlB2WcATdVmGaTY07W8Hwa2+D6KUBRlV74+TIJyUqunC
         Pb5OZWToVWYG5VFbpI2mXrbH1u/duxwvhnWgh0MLT8164q1n3gJzDoeIBQ4KoWoXDfqr
         s8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722758255; x=1723363055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0KTkwxi3yTBFtdP01Ghiv9wnj3oEVaVdo6Xnw/VoxQ=;
        b=fcxhwLQUDb8sX34uc8btGqFvAahGNXQouPSDuwZPL+qq5NmqyfgeMcFypfFg/woBVJ
         WC6Z/yOUrOaIB/aMIWpGGsXn7ubIZQqpVKs1ptwrihx61PEog7F1sbIvyjxRPvUr+GoP
         0O8+lUDHiFg7rptdqO36TTWld/syc9gy2OFafyaRPMgE5YpF5/9nzhfMGt1a9+/jtyzP
         UMIDAyDR+ukTwgvq3lQVxog8DMm8JLP2J4eYFJvZ3vm/bXFQ3rpqAeyGUjPBdeN2ky/N
         j3BwqHcRQWr8Sv5iv8dS5Wd3yFDxdAJUhTWCByP1FOZKIOdG1QfwCw7gmEwLosiX45z7
         LrJA==
X-Forwarded-Encrypted: i=1; AJvYcCUaHd6s5TK5j98B9zicHmPyqz4sDM2onJSp0zhnPxFBl/eYY22orWJ26oYO/OCarR2SslHElRVCYVirUJK4+CmiuocmHNx2kUVJ9GQVYjQtVKMSuc4kMwJr+bX35vUFyBZm1JapkPZK2Z3DZwwBXHKeAQzByrjrZyZR212aDXyRKHR+vvTsbAYqinhfMUNqZUoTqRuUwAvgS987pzwesU1vLe/AnO1j2/y048/L5cgv/nPylgQPX01lNONRgg8cRpt6+Mq6+4kahT9ikyUdRCmQU6j8bCDJnNWtjBgT2iV4Fi5BTQuKZdnZ5yA9paZDNOYYc7XIUA==
X-Gm-Message-State: AOJu0YwPTFle83T/VUaWDxXDRinwqhz4+xzeWkKplIuisUBmCvhiLdOn
	AtCK6u+fQx8OA/qzw83R7j+47/ntd2ehKkeLvpmj5F8MrGEmn6Ud
X-Google-Smtp-Source: AGHT+IH6wosRQHFK1XrZrMQ/1/OazY5atARBRVgGVQBt8cXkjOG1KelkDNxLA3xQ6gKV/rMpiZ54sg==
X-Received: by 2002:a17:902:aa42:b0:1fd:96e1:7ffe with SMTP id d9443c01a7336-1ff57456f1cmr80659485ad.55.1722758254963;
        Sun, 04 Aug 2024 00:57:34 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178248sm46387605ad.202.2024.08.04.00.57.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2024 00:57:34 -0700 (PDT)
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
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v5 3/9] security: Replace memcpy() with __get_task_comm()
Date: Sun,  4 Aug 2024 15:56:13 +0800
Message-Id: <20240804075619.20804-4-laoar.shao@gmail.com>
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
2.34.1


