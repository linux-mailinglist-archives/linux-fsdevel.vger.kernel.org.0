Return-Path: <linux-fsdevel+bounces-24392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3806893EB6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10431F22091
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3517B7D3F5;
	Mon, 29 Jul 2024 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kse7s0Gg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259012B9D2;
	Mon, 29 Jul 2024 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722220770; cv=none; b=eurUIL+TPpriNhPR9Q8bOTuElNh+9gIxHZxdY0+dCNYYFNmpdtXUUkte1wb5q6uSOX0NMpwjV2FdeayjTcGuQhy2r5g4Y5uIElcM33bBbmbrn0Yv4evIFB7MQq8X3jG6dUpu0iDQTxkm26aHDsKdas53K+Tj6uZvo116mMQNjHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722220770; c=relaxed/simple;
	bh=FkchoV1pKKhU4iF2H0UnfhLXdjU/OqthurkRTQdk9Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdryAjac/PWLdlRJZVcJf+HRpbdp3P7zOJNOTxXJXS0CDojIFC2H087iGl4wrqS1xVrb2mz/oQKGel0Kdg/GfD8D0Tzo1QIAHh88zlPwst0HxTOfMOZEsh+V68qhA7Ovmwuo0VRvILp3AxN5FL02PnQrokFyP4nPQKpnlKvVfkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kse7s0Gg; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ab34117cc2so1939264a12.0;
        Sun, 28 Jul 2024 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722220768; x=1722825568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+uQG4RKAtUTljj+c6PuEzvl8DtV0722F0vMFtL07WU=;
        b=Kse7s0GgEvoQ7ccetpRrag0zVGEBmFBFpU7mxl0kN3ksYuxyVgcdRYJ2sCxxlkBWqc
         nbHxE1R/J2kKKBaV3/7T09UJ6pQOa1o+uO+DcbteLGMhtTourRrgn5yxvR6ZD0I08e4w
         AZRO3eSff+kaWROg74gG3VHIgnpK3tG1XPdthT8DuwEVJCJz4DWfotOU6OB15njGC2Pt
         tS0C5DwPOfcj4S1TUppWC8CeMgY4Qj0I6JuEuabb5PZ7qQX4k2hkYi2eaVL5paVTj7eS
         sx+LiFq95KDVhg5OZVpYC0nFkN2p0/L9Q7ReCAHasmrADQlJkzT815vkD6c9fomOSbaI
         Fd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722220768; x=1722825568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+uQG4RKAtUTljj+c6PuEzvl8DtV0722F0vMFtL07WU=;
        b=IUXv2nT9naYweN99MZsQmQ11bwlmQ97xBqccil+15S7fvhfh2j8nf73gNxrRFAo1UA
         zRYedJIsIceKLnSCAHeOcOD0Sf2/Ltq8e0r1BhBKoGEXDP5Ts6nK59LvVLUO4M4H/HZm
         eKH5f0ZnCWaq7QrgXNkzM3VuSKMLbyrNoZAaeqCreQdGmqn0MIFxh8IjOV4ma8k+KphH
         Scx8BWAoYpJovpyw6W9VBo2K9a9/wYP92vSCPjxPsBvv6V4K3oQ77ubRreoZVSk1ZfY9
         I2jgNWFqaIe7vv30VemmDfRDQW34dh6lo1ttJ4rXJ42C1TkP5jBENSAtxQ6T3OO3GHLL
         wURQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoe8XVy6XWyeLhnCibo3FX+kr8ZS4/TFK4KXAdqeKjE1vYpwrTFoUt6WY+E7rGY5HhGsfR6WThGimn1nOuL26JaUlmimXHqQgfwyYW6zR8WNJfHefyApu/gifrmEc/c3ITPaq2yh4obzBBJLmHhDadGyQ1N9uEbZGkhkGPGoW1MwbOcFeavpajqXh8OrxL1T2xaoiOqjP3B5brRfLTUex1Qu8141ux61b0JbEMBo+wjkHnfK47Mo50B8bX2tP3P58omtapLhclD8fHqBBQJeiXIQXTupRfinfH1tJgNWhfQoSvlXT2gL+V69bHsfSoKIbCqhnNaA==
X-Gm-Message-State: AOJu0Yx7up9qsWSbHVTJXjGL3eG7RlsAokxeCtUouaRVCqyHSGuastIq
	cGNTIoG8Dth0u9HAKzMzXB0diCI2Dc4JnKkCzOrgm5lL2EPTBqBO
X-Google-Smtp-Source: AGHT+IGDDVacAHzuqJf1zY2UQsKDkDe/fVaez1tdPtuFhqBPLEHRkdQpCzionBNRtCrdgKFvX6YkKg==
X-Received: by 2002:a05:6a20:d50a:b0:1c4:8bba:76e9 with SMTP id adf61e73a8af0-1c4a153afecmr8452767637.53.1722220768309;
        Sun, 28 Jul 2024 19:39:28 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55a38sm7332247a91.10.2024.07.28.19.39.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 19:39:27 -0700 (PDT)
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
Subject: [PATCH v4 03/11] security: Replace memcpy() with __get_task_comm()
Date: Mon, 29 Jul 2024 10:37:11 +0800
Message-Id: <20240729023719.1933-4-laoar.shao@gmail.com>
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
2.43.5


