Return-Path: <linux-fsdevel+bounces-27494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05556961C8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385451C21E41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D5813D896;
	Wed, 28 Aug 2024 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKdypNtB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7A1CF93;
	Wed, 28 Aug 2024 03:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814234; cv=none; b=lDeg4aNbdOfIizRNHiQSJYsDcwdzPEqnMdpjsOAg7i2bBAs6c5SObdouNsBEDQ5dOSNvTFKkoIeeJEl+IMtzE6fODa0eMJU2x547rMATlNnme2tURnh/Lh/D4L68TXVhU7+AuuW8Fd6EwzLH4nfQ0XZaYbSX5Bfkcxzn3F1ZkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814234; c=relaxed/simple;
	bh=mCSSieTexVEhRe5gQHXuwUO8PEAZIQurKnIO9AahPJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFPxhG+6n3aM8ymu/1zC2BWcdAD4UClbiGghD7jI0ibwT8q0WjO3MZrNlbI7FRjS8mu1rdXPQpmCZw8ddrtIxQXHKnIcm2uNtJew6xchi+9drDegn9VgMhFuBdSe8+Yd1CAChcwclWyGHSiMvMjEtmUHjOrbtJ26VC1qnBM5YGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKdypNtB; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cd830e0711so132434a12.0;
        Tue, 27 Aug 2024 20:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724814233; x=1725419033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RcIZVYUDMrvydSLTObUn9UWjAdkDM4CrmA64YTz3G4=;
        b=lKdypNtBDAb/oJWibZGDg3JpUnUybpL1fzsasVytYsYlV9UJTgr3IHL0Ooo8QEjvHE
         9sWZ00SjwbwhKsfL+x+UOPwJ9muD0zwMMqWpkbUcJ/UWz6yHbSBmdtaZ7wxruIAsy1+l
         V/ypnyDvK9InJIFq3JKvIV62JNvPLgN9yRn/LElFGoHtA4noBFM/B3oEPfgf/XWs/KMe
         mCQ+Z/Qb4WJdwc2lCk+ImV7+1rX1Qc4dm/GXS4KIFVGbQVTkewf9LpbOcLwERUqY08wC
         1dhMYOWqNXvUYRvSVyjDhELc0lo+6qZJHSroNvfSKYYE1FGOvhsjcCW/KxD7kzfxm3AN
         wpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724814233; x=1725419033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RcIZVYUDMrvydSLTObUn9UWjAdkDM4CrmA64YTz3G4=;
        b=AFeL15nrbTCa0w+GgIueWytSc1RVbnG1IbQJwu4muoZ+8MWBrnVdJU5F8hA45DG+tU
         iaSj9O/hqWQtkVVgTFeOnj41bLCjMvLny5y6YBfrmTLv029mm64QkGQH18DihhY0nDJn
         7V6u8HDxH91Vxg5HnvYF7P+o53/T1Ne+qwX9937KKElcjhiWUDyBcwAeOxJNbuJHZ10u
         7HOUtQkdP4beP7dndI2argQeFfAPtgpo34B0SLFNz6ov8Y34XlL67gybauuQE+SR+4af
         SOk5SLUr4Wf+zSCmIVdnSoReAQwqzJL4p5DIutr/y3NY2CaffCpaYF4gLqLXjtoUHf+5
         d7/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPePrRIBVWC1cDu052nR0yiIAbq4TWyS0SwLmeM7ThvDoUBL4f9NFTt6/2fo2X2AcSSWBgYdFSPm5SjYpaIl/ZPPgHrhox@vger.kernel.org, AJvYcCUPy/AsNYDjJcvq6qN1M69dfWSeAPNP1ph/L/4lXVc+5P2XjbSVst1ZfjF/wmw1Fs65gnYXsg==@vger.kernel.org, AJvYcCUiGQi4MZ1IhEB4clMG8lwDQpD6zHPPh5ilfeZE1Tc/WSbBFGWoZPZqmd2Z/pjnipPqyLac@vger.kernel.org, AJvYcCV8G648I8++ADIYukKhB/I4VYxC2dwb1JNOHHIVtOGX1FQDptQjRWBn9fPivd/JyHuQMarzVCuzhg==@vger.kernel.org, AJvYcCWHhGz3Q5BKNA/7Y5SgxRlM2vWNPOedKkmUz4TuWvU6GJxBxPKhZO8Byp/bM/+QK5/07+ofuCpY@vger.kernel.org, AJvYcCWisK/QZQQ1YOWshMnrEsVF0wOPsXyaBOvVXJKlfqjahadK1TikAn4PAPSUutMz6xXveGOWOp4ZVFY8ZtvWo8FnDmFD@vger.kernel.org, AJvYcCWsqvjnFwmn2vPJXU/cHFEYCCc9OziAi3fgeA3KulSsd9Qak5MTElg1roetJDTRptgaawN9hpM1ZfRUuHKVqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89dhPPBaui6oVubZtUR8rxgBoqVUMG4g/7co/YIU7NozG8H0L
	Lba4Mt0kGYdyUEFcP0VQhNLtNNiyr+M4sMIOUrVuebj6h+AHvWv1
X-Google-Smtp-Source: AGHT+IGFzzoi8lpwMf6Iv4C1DEmxZSABK+5V2UtAilXgBtIiNQOvP4ALnfkUbY0O1vyUXWVYARLCDw==
X-Received: by 2002:a17:90b:d83:b0:2d4:91c:8882 with SMTP id 98e67ed59e1d1-2d843c839efmr1207327a91.11.1724814232595;
        Tue, 27 Aug 2024 20:03:52 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445db8f6sm317977a91.1.2024.08.27.20.03.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:03:51 -0700 (PDT)
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
	Eric Paris <eparis@redhat.com>
Subject: [PATCH v8 2/8] auditsc: Replace memcpy() with strscpy()
Date: Wed, 28 Aug 2024 11:03:15 +0800
Message-Id: <20240828030321.20688-3-laoar.shao@gmail.com>
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

Using strscpy() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
---
 kernel/auditsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523f..e4ef5e57dde9 100644
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


