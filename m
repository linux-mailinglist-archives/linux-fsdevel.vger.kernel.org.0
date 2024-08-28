Return-Path: <linux-fsdevel+bounces-27495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ABC961C94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A938B2119F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFB71411DE;
	Wed, 28 Aug 2024 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tko/Fbck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3C3AC2B;
	Wed, 28 Aug 2024 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814242; cv=none; b=kP1ZKtN+qwpiCB+cGgC1Wgo0hFRHhI9Pj/Wc4ui9AbEfvfj3xS7AR1HtPftT7PhIWEhxG3f1XZjl3kFw1o7bhzO2pdtkZXHXHK6vDLTiPTNOCtdSnH9JbkyKijcvG+VyvzfBshYOyckYEU1TdrazphSimlk3o6LlSkfxQatfLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814242; c=relaxed/simple;
	bh=ABhttoS6oXw2j+hmHjcdgyTovB2nFehBatzjdciJ3nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INhLyBAuWMmNhR8Qv6CDlQngzhtqlqhAXTWrPAaS7LiPtGg0svKtQyUTao0FrVtcHmlhReCNA8YwepelPkYdEV5pTVRB7qDRExhaqa67yJlHPoAWdpH3th30kMbZyHn+pGPoNIAyiKa5y+pVvFLVvGrDr3ZCuHrHcc6XNT04Ne0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tko/Fbck; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6bce380eb96so3435379a12.0;
        Tue, 27 Aug 2024 20:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724814240; x=1725419040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIIMsSPqVp5AusgTbRbdrgF3qEr8ccJBENe3BbQ0UBw=;
        b=Tko/Fbck1Eb42MU9iHY8WN5DxJwkwvSYihJQoYgbWCy5WgELU+TdmQPGrduKpmJDCU
         /qw7z4vgBAGiBdm/RR9QWCqhgHGQhI6tK36qEzZW4BW4bVlBii3VaPoGqkM/tsqp317J
         W6WmtXvNIYlA4dh2p5u1tf5F0vVTDwAD06SHPKIpDvNtXJnMXzQT0GCtBfaZjYwDb3ZE
         mQ1O6/K9044FNXKvOTfaPqfbnK2MK1pCV5vg2Mc3C85XhBCffaxFXRC9E0ddbt6qIROd
         Dtx1ceaEzEYCq3cM5FhWKoIg3HafGGuaJ5K26SMX8ud1hcFtEZoxtLFVl7fakXMLyJ4d
         SrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724814240; x=1725419040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIIMsSPqVp5AusgTbRbdrgF3qEr8ccJBENe3BbQ0UBw=;
        b=Z2Mw9oXG+PfnbzkY5qGQx4K5Zv6xxrQZkxJ55L/AiKjjzKy/5UCuTJmS/UgDsISR1k
         CMlqoqPUPS/jeFxJhe9EJV3LWeG+QQiBHLft99DAgtoFFm5qfrHEiH7vhK5krFcKKQeZ
         8NAP5UWD7jHK00K2xemTdGbX8xgGFbRLKE01wm0L/4uOTbyTYPXrDYottV9EpVOkfZ0Z
         zv79yWZMeZTFANB+ZTi0OJa8SkPvakQkEoHdDu7DnavXZFcuvp7FyoqQrwcnfdPMuANe
         YRZAGMtYT5hH4tFp0zem4AdVdu+AOZLJ4xtcQ2fjoACkG7Fcofq85QidzOq6LbePwpo1
         qJLw==
X-Forwarded-Encrypted: i=1; AJvYcCULeLsR+ZYi6MDnNdFPOGH6UU0kd57wUz2RwqEmFC7UXxnSYCZJrSennvB4wTsbAtP2Ackx30lM/eepsGKA9JHpgTkW@vger.kernel.org, AJvYcCVMwehzf9YqJdFQzXqV2WxqPS2EVqPUfAh7GOAriVVnUwR6s/pX4ASMo4P1u9LJn83Dmpui0tjsOc+0E2jQAg==@vger.kernel.org, AJvYcCVftzj3tyVz8viDNjx7jWU7NzXIDFHuKEmdidAmPKYWcMq+FXjTBPx+kYOC68Iz8+AhNHe7/9vCiIaeC3cer4spNsPIJyND@vger.kernel.org, AJvYcCVv10XsoXGdmjgFirUGrqO0Eyt+435PfByBMlW1/kFplXkJky1+BIt2kOxbOT4kzhR6MDw7pA==@vger.kernel.org, AJvYcCWVwWxgmhFd/+YhZ7m4KZwc6GBiPlpBsbSzGEANSzDeBoBvlko8K63jQ2U48MkTJTOwHc9a@vger.kernel.org, AJvYcCXAf5R9dkPQdNPYnVrhF6xiIs0H2j0Um2nkvorC3J1VEDaQgHxRJ9EFDJKGG3sl+ZBnj4gogwaA@vger.kernel.org, AJvYcCXBUtDdc6BjFDa56G2kNW7SZp3uszBgm/pr3FqyfFTn4qq/cub8igJdf7IPa5zCd18TujZonuIWsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGmCc60h6fjiq1xJecjN1i5cpYOrn+KYfOBVN4UYEbG4LyOD5
	DH3GFQboyfTy9dpoH8t88zsLY2x8cqR6DSERM8vXvQV+vKZTX0/J
X-Google-Smtp-Source: AGHT+IFERm607QheW54BofDpcXniBv+8JM5KHrTSMUx7woXR1463qkdvSKbT6nvldL/lDZfqmA0dvg==
X-Received: by 2002:a05:6a20:43a5:b0:1c4:c7ae:ecea with SMTP id adf61e73a8af0-1ccd286f499mr543329637.11.1724814239886;
        Tue, 27 Aug 2024 20:03:59 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445db8f6sm317977a91.1.2024.08.27.20.03.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:03:59 -0700 (PDT)
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
Subject: [PATCH v8 3/8] security: Replace memcpy() with get_task_comm()
Date: Wed, 28 Aug 2024 11:03:16 +0800
Message-Id: <20240828030321.20688-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240828030321.20688-1-laoar.shao@gmail.com>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
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


