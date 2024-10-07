Return-Path: <linux-fsdevel+bounces-31199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB6992FD8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085CD1C2321E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334D81D61A3;
	Mon,  7 Oct 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bA8Y7tfd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383971D45E0;
	Mon,  7 Oct 2024 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312598; cv=none; b=XNgIIZL2uoc1Smgwtx9YCZym9hqDnb7iHOrdmqqgmsrqwOkoh1RhvacdJifnHGt38yp2Yc0e/rZfUocQsn7HoanvD82lDERvYjjz7EvfK3DxZNf9+JRdEq9Hhm24dm26WOCxXdndzjbkzOc1C1iajByhsvhuHfR5GOoSBw6oFn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312598; c=relaxed/simple;
	bh=t9WhBzpj3y3CJ8rlJO5jv9hSArYMQate1NnQ3e0C/oY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fPfx+eOY/HdvokDGxj5u/9sY0zRrd228qxbclbKZsSQBQxZ86KeFtq50eIJ29x+YFyP6AL8w+8u4/7qrnCKV8yB9yH0eTZxSjFuSLvyr7Rz+W/wVTiadUxxEutj3hv71KEf1s4O76QkZMABoTcVRRzbTti79bwbJVXqsmPLHEN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bA8Y7tfd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71dfccba177so1136022b3a.0;
        Mon, 07 Oct 2024 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728312596; x=1728917396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ED8sTWekie9637+cHBCmQFpLStnm64j/0llImVgOxU=;
        b=bA8Y7tfdPirlVKHrNdcCeQnVOw9nz6iMWNHsLrDEuuMZ7L76jfoBSsZHLRqD7NuzSJ
         E1OLKwCEjGcJhwR+hrP3yzhwjuswzp9NmgiaTbfcjz/aY41KAZaX/UAclMte31qkJUbu
         JjyX/YCfJGEZfY9w8Q9LcQMBhkDNx8uzTJBjuxbt/SxHSznopEyz5ElKRlLmnojW/r1+
         munJMNU8pvgVEe9MBNcRxooPnc+NSTDU8gUPfp3zKQTzzCYJQFI3J/I+Oc5QnzD7gK0c
         r1JWonebEsqQHTd/QaY0ugBW84YJ+eMlQ3Hc4mUuvOC52M53NNMWWgBGo+uScy/oH8VU
         RagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728312596; x=1728917396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ED8sTWekie9637+cHBCmQFpLStnm64j/0llImVgOxU=;
        b=hXrNJv48v8jAIq09+tWuNkWcW1H+g9LK/wnxHZSrCVzQMX5npsvN9yk+9sn2NWpik9
         A5bcQ43qVtPzamBhXXPMBdlW/VQ2gPwm0TjZMHSAmfimK0D03PtunpGifuPo2MTSaX46
         a9yw13bpSNl1lDFESrZFDuWs7Nh/WPeL79bl+69W1nXklobcGi8qoTeNFXYE6uSlA68y
         90y0icO4XPHya0CpYLeHwDMBTJM9HNtClERWeqEXRVLOhM7ncdpP46XoQebMEWkEeACf
         iKsmWAfiD91ICL21m1ztRZ7KKraj4NmHsee7sUC2/PXN4IVAIGDP8LamWg5BdtGmOEH6
         NmNA==
X-Forwarded-Encrypted: i=1; AJvYcCU86TkYgcmqLcjl/R+0XP/A0d0JE5jPpL/CILO2z9u7KIGeiUvo0wBbLgTB3NRYMmTeYV+Jbl6yvA==@vger.kernel.org, AJvYcCUxXefIf7yFoslmrrd/rnZyZ8HXSOnWol9wS5lsJidP4M/TG9Dg1HWvlWKyhOmHNq4ux5Q0@vger.kernel.org, AJvYcCVBPsuCWBOs2EfwDhupOxZIMubYXEzVHBTM6koaOi+i9NREROtJzREnDaezjN+/anUZrd9CR2RcVYN11IVuIZyqfKWjk3ZN@vger.kernel.org, AJvYcCVdIzPyQLfae2wSNa+WNhu8bJ0n8QNMPn1Qdn/feOHlnFECM+dblKKumfdZDzA/wLNFvX0i1WQsvfgK7tK8rA==@vger.kernel.org, AJvYcCWYJH4+UrWregNJ3mjZycRIch3uzp+EYIfeEl+bSt6Da6TNq9txQslhTDj8cIsrFH6Du7zXmw==@vger.kernel.org, AJvYcCWlx5DSeoGHNG4q1Pw6ncXtyuLKj2wEIJP5nlS4gFQB/FpBtlP/Y717Rv+KQETarubCdNQP8FtU@vger.kernel.org, AJvYcCXzGSgw23kAIBkk/imeP+QmFGf2ghSym5k8Ofh1YyZwUQw8+AJvXTFR0qx9CQh1JDDn4YO7+DOQt65BZEksPznX5Gc5@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTqqZEoWZ7hBh7aq5mgOFmlIhKdCNYd6erIyRscROU1kMx1yf
	zHXAH5zq5nhbOEiNRRh6j+jWaRNdfHN8E38QJaCTfXEoa8EurMpa
X-Google-Smtp-Source: AGHT+IFSfr8aGR6hntBNP4HQUskHiw0vm/RzkrWx6VpNUZENgDQ4iLauIOQbi4o7xjraSFHRBCGRjw==
X-Received: by 2002:a05:6a00:2316:b0:71e:1ad:a4a2 with SMTP id d2e1a72fcca58-71e01adb733mr6378569b3a.13.1728312596499;
        Mon, 07 Oct 2024 07:49:56 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7cf82sm4466432b3a.200.2024.10.07.07.49.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:49:56 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	keescook@chromium.org,
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
	Eric Paris <eparis@redhat.com>
Subject: [PATCH v9 2/7] auditsc: Replace memcpy() with strscpy()
Date: Mon,  7 Oct 2024 22:49:06 +0800
Message-Id: <20241007144911.27693-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241007144911.27693-1-laoar.shao@gmail.com>
References: <20241007144911.27693-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using strscpy() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Cc: Eric Paris <eparis@redhat.com>
---
 kernel/auditsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index cd57053b4a69..7adc67d5aafb 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2730,7 +2730,7 @@ void __audit_ptrace(struct task_struct *t)
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
 	security_task_getsecid_obj(t, &context->target_sid);
-	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
+	strscpy(context->target_comm, t->comm);
 }
 
 /**
@@ -2757,7 +2757,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
 		security_task_getsecid_obj(t, &ctx->target_sid);
-		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
+		strscpy(ctx->target_comm, t->comm);
 		return 0;
 	}
 
@@ -2778,7 +2778,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
 	security_task_getsecid_obj(t, &axp->target_sid[axp->pid_count]);
-	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
+	strscpy(axp->target_comm[axp->pid_count], t->comm);
 	axp->pid_count++;
 
 	return 0;
-- 
2.43.5


