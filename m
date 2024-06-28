Return-Path: <linux-fsdevel+bounces-22748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6067591BAC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17701F22DEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AD81514DD;
	Fri, 28 Jun 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFo3oWPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7013FD9C;
	Fri, 28 Jun 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565544; cv=none; b=ewNaPDOkRNgp0yLp2xxDU+vPtbXWU7Iqcc5NRAkjA6N9YWwZrB3Q5HLPoGb0poR5/hHX6vZCTjrSWeqX2z8MS9OnhT6zvW9QWFbaeYX+Qk3s9Makcl7YDB84HY+4vmT4He8OGyt05zaa2tfikeRfi8lK3SFYMPC0PPwnaJKAW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565544; c=relaxed/simple;
	bh=FkchoV1pKKhU4iF2H0UnfhLXdjU/OqthurkRTQdk9Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ovaLBlf+luMeuMPAJbRKWmhZ1R99I2NjwvkOJhz5sTOspsomCN9asxijuTJ9qCU/vVfmvEUO6vuW4D1YWndbTTotg+QNABrIlcwUEYvXDkhD5xAJkUBxTc2vO7nm2f3B91C3/YhYvKD0+7L7759UMXwASTybofFxp7DfgMWB9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFo3oWPk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6fabe9da3so2232635ad.0;
        Fri, 28 Jun 2024 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565542; x=1720170342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+uQG4RKAtUTljj+c6PuEzvl8DtV0722F0vMFtL07WU=;
        b=fFo3oWPkGNgcH9wn9coWFJSsc7w/nPhxAi1rlFcGhBUXvUOLycYhHYE3ymiQHjjGW9
         XlBrZ1YvwwJ1g+A7MT38DWS43HWHrDlDEezq4jBMxXobGVbUNKtjE536G5yeo3YACIk9
         LgLqHwncd8rHI1OxGZriU64/27596tu+X1jWEWWAW0lcJl1CjFwhh3J7QcFbU1KniKn8
         P5u8aTRH1xPr/kIU6mIoHAO9S+XDSlTpcEBlg/zNWTbJnjQGInODkdeJVOLMAB8PzD5t
         I3F4LnISxZf9bX4/THK44n/COlP1/X4XpeTN1oyN+6HkGC0sXqmOqbmcv7IG34Qeyu4S
         aotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565542; x=1720170342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+uQG4RKAtUTljj+c6PuEzvl8DtV0722F0vMFtL07WU=;
        b=RQj0clfgzD/HQaI8h3EQbIL6GSP2tokr2A04eft/5ZuWHsfhciRnxTEpJf4U8tjzml
         ixUs6J9fzOGc3KLcr8VR/JAbsWITkctOKs8/1j10a5bzdFI6W6VpHs3Tb3yWXs7c54bY
         ijDLqIqXJ3sAVzJ4AAjuDRlN/xoJ1HUBstf2uT0aAwwDSOXP5PqFONLY/5kj/HzYRSGN
         FVdehhtwneTiRgD6fWzvBSAdl22gpPA4yxaX1lD5rryzqMwFTOZWnECaZH/FSbUUFLNW
         pd9jBFd+sZ+PLtxVTZDLy/lurJnV0r4dR+CWm1vZF+UhpDUMRafnzWKJYROBWFSYxcSq
         1r0g==
X-Forwarded-Encrypted: i=1; AJvYcCWXotgOz4FNmN18RRhK9JTBhhjFrVcCgZuZAEEIVTZknSrAkHhZj26gNH6SfS9isN3jIIik5GfntMr3hjE/4fbDfkD5L6Vd06vVt9tP8BPjMUbrCrtvpHyJhdo0UAlmI93NCgKs5l1C55gDVXrbdh31uvGK8xk3Cmj9sGw2r4J9DYJ97IVUVnk5HhNkFxyBvcshzpeazr2e8Ls115U3ySq/1jzIizrYhg36vk7rbITje7+lG7psZzI0VzZ2rWNdeEPLkT0FH9NgHy6jlwL/sZezlftxOmQm5bl9l/qD9zzsxF+R4OzKeLvNXcmRasQefM+FjkGF0w==
X-Gm-Message-State: AOJu0Yza4QsNV8brvp3Bd3Y3m3EZMLEAotovwThzksLdH3swkDaf2iQZ
	UCzzbOwr8ny0gtsyIf4HfWIm+TCqpbkvElXMEUKgsCxQomIFBSno
X-Google-Smtp-Source: AGHT+IEiCe46L4L+6u8pFkskIn0tSNW3yZf9XlVCW3W2rC8VIHwBiWsCsriXmS70kmQMnPpYjn9ORg==
X-Received: by 2002:a17:902:a3cd:b0:1fa:a34e:8819 with SMTP id d9443c01a7336-1faa34e8cb9mr39730485ad.60.1719565541990;
        Fri, 28 Jun 2024 02:05:41 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a1dsm10473085ad.68.2024.06.28.02.05.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:05:41 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	laoar.shao@gmail.com
Cc: akpm@linux-foundation.org,
	alexei.starovoitov@gmail.com,
	audit@vger.kernel.org,
	bpf@vger.kernel.org,
	catalin.marinas@arm.com,
	dri-devel@lists.freedesktop.org,
	ebiederm@xmission.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	penguin-kernel@i-love.sakura.ne.jp,
	rostedt@goodmis.org,
	selinux@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v4 03/11] security: Replace memcpy() with __get_task_comm()
Date: Fri, 28 Jun 2024 17:05:09 +0800
Message-Id: <20240628090517.17994-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240628090517.17994-1-laoar.shao@gmail.com>
References: <20240628085750.17367-1-laoar.shao@gmail.com>
 <20240628090517.17994-1-laoar.shao@gmail.com>
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


