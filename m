Return-Path: <linux-fsdevel+bounces-26163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B047495550F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC01B22D3E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 02:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D39E8120D;
	Sat, 17 Aug 2024 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0aneAIQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94925634;
	Sat, 17 Aug 2024 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723863438; cv=none; b=hok367P0unbkJ0Vw7+iAJP9yfXlIOJcEO54RnGluI19UAE4heOL+0nZLiz3NtpXpe0xXKZYCRCfkfCfrtFR+4M1+j/jXHTq7rXEELZhBoZ5DxoJgI0Ix1T53bmQzA0x+paWNTGifmn0Y3bqfu482aZbuw2abbq8p470j7+nHk0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723863438; c=relaxed/simple;
	bh=ABhttoS6oXw2j+hmHjcdgyTovB2nFehBatzjdciJ3nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQYumgHdJW5iSr1z/kFBkHpKb9ybCn5drTpYb+T7CGk829d+guNeJXgBQ1er1oiEl/JivxMY5/rAx571P6tbObzr6PNKz2VwariAl4PgKcHt/YosZ+/+CYFFl84z3//572RVlGG7gKswPaOKCtFNZI2k6+yggAv9br6KWSmwpQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0aneAIQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-202089e57d8so7763085ad.0;
        Fri, 16 Aug 2024 19:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723863437; x=1724468237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIIMsSPqVp5AusgTbRbdrgF3qEr8ccJBENe3BbQ0UBw=;
        b=g0aneAIQoQXpLova8lZvawQ7YfE9HYtr7yt3BCNeX+5ae+hPmrF0YCbKJDSrWdbeog
         uCIpHaArqv4Fv+q1by1ZMhcsIkESfljgKg4VNp9K/ENrIXxBdaJEZj7v1/qqjlDJSzbP
         vcmwx7MX8FHdy/rKooS9ZkUpNjrhC2+rsD1vks8uUVs7WRum5X0SBjkxIltB/gI31WzC
         hJFJoDq2xWX2RCBwvYWOJ4UDIQxnsvsdT7prpUwdPlSsNJBqXkeIWYqV/EQMvNckozh9
         ewG0uJnonlOPjvA8ZT7Wv7ZoMDIX+19yygDEZhV1h/o0A6ThnSUgVicqSuV60mLW1US8
         hNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723863437; x=1724468237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIIMsSPqVp5AusgTbRbdrgF3qEr8ccJBENe3BbQ0UBw=;
        b=ZILEuiX6N26NTTL9LUF1fkkaCo287bGM1qAeGxpBW6d2Vd/z7KEWG1hBM5hFr42wKD
         2H2mxb9Cbd3sgigk1L9VsiPii6HMGXoNM1qfrhDvzWyPZ1xJRZw1ftnUR8/2u3Bh+UH0
         uFZ0OtSbA+/5AafFIJ4xxlhkinJ1JN3MAFJtdml0eAb+uxWF2Il4ZzGmQizuzMgXOCSd
         yYyLzFekXgqf1YSwLXUz5SJ3CT4rcGsIh1bzR0b3yZ0Jilxm8qW+45jD3drcAqtqIzmV
         mHEDXDcAIsHlb8RR+Z8zM88sH3Tsa7hKdeiWH8Nxd24gvu+TwfQpiKk9mWTcQnppqz17
         Ptng==
X-Forwarded-Encrypted: i=1; AJvYcCU6OBIQqAugEqlL/ck7bqP332b+qSu+1SMIDYcx66Sfn1KBxgIxyouEMj1jZT8YxBuGx/3QXb7PbnRO8p9MUHU1+x3agw2zLDucCMMzBy+HO1yLBozUxe2L/pxoqjT5ir2NX9NkoPAiVNsiqkKQB9HEXTdQPnrueymsEkPquZMwmMpwNTMg0HCSFogjnYgeijlTe76t3iFxpcU4t1cctXodgINTdi9BPfbbecCb3EmNDB4bJi3/CUYiUBzVD6u28BkFiBeSSLraZemoeUuCCW8hatOVc5MDIjVD98S6FyxrukZMFpKe2yjXkGuxPD0oo30qwj9HNg==
X-Gm-Message-State: AOJu0YytfD9JOCfyHpCI9qelQf7QRTNekUpiGmJzcFDZl9byP37VlPvr
	gyZ/oKH4ghjT2d1qLy2pTV0bOKrMCUJS8YQmXtDSZjn4TvDb0Cwai9tyNR3XdSg=
X-Google-Smtp-Source: AGHT+IEzug8bsagNMxwK7nm29ecXIwIfZ9FH+TLEi6IcVkbHtwlg4mlyU3SBLgFEVqycM3+Rn/pQ8Q==
X-Received: by 2002:a17:903:2303:b0:1fb:9b91:d7d9 with SMTP id d9443c01a7336-202062963e7mr80764935ad.26.1723863436587;
        Fri, 16 Aug 2024 19:57:16 -0700 (PDT)
Received: from localhost.localdomain ([183.193.177.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm31801785ad.94.2024.08.16.19.57.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 19:57:16 -0700 (PDT)
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
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v7 3/8] security: Replace memcpy() with get_task_comm()
Date: Sat, 17 Aug 2024 10:56:19 +0800
Message-Id: <20240817025624.13157-4-laoar.shao@gmail.com>
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

Quoted from Linus [0]:

  selinux never wanted a lock, and never wanted any kind of *consistent*
  result, it just wanted a *stable* result.

Using get_task_comm() to read the task comm ensures that the name is
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
index 849e832719e2..9a8352972086 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -207,7 +207,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
 
 	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
-	audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
+	audit_log_untrustedstring(ab, get_task_comm(comm, current));
 
 	switch (a->type) {
 	case LSM_AUDIT_DATA_NONE:
@@ -302,7 +302,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 				char comm[sizeof(tsk->comm)];
 				audit_log_format(ab, " opid=%d ocomm=", pid);
 				audit_log_untrustedstring(ab,
-				    memcpy(comm, tsk->comm, sizeof(comm)));
+				    get_task_comm(comm, tsk));
 			}
 		}
 		break;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index e172f182b65c..c9b05be27ddb 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -708,7 +708,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	if (new_value) {
 		char comm[sizeof(current->comm)];
 
-		memcpy(comm, current->comm, sizeof(comm));
+		strscpy(comm, current->comm);
 		pr_err("SELinux: %s (%d) set checkreqprot to 1. This is no longer supported.\n",
 		       comm, current->pid);
 	}
-- 
2.43.5


