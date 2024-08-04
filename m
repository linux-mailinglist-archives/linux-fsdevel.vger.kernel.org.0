Return-Path: <linux-fsdevel+bounces-24943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F35EE946D43
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 09:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E791F21EF4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC1A1F95A;
	Sun,  4 Aug 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehA1WynY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69BCEAC6;
	Sun,  4 Aug 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758285; cv=none; b=lyL+G+xipIn5hRi+pZQkeS9U0x0JM3Ix+u7Dk0jNZwnvGOYr1DYounSp1Cl/zOx78g09cZKqha86mSIpHcgmtSpNrfUt103+fMegvHXWy+HcFU2z4Y3/2rFTUMq2GB1hl8sjt38d/2OYHsX3K2YQ1nSqjdOFhPkRNmj18FD8G80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758285; c=relaxed/simple;
	bh=3Y0PjEqG6S3Uvz9FkBUvWOex8hIkmnI1AqczpSovQ98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GYcbtmGaLgMEfY85yuRkNFkkcWTi8YbHd2DSS1kGAGSSH7SApNZqiFOF++pPNHpm09/Alfb39XuTu/7lUKCVtQEkYpaFI84ihAKQviyhaH8QxyMcz4iDIa9xiLDzdDmUPRKusH6Kv8KxJDIMKiF3DzCx4Oeyy2poJBJWuZF3hhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehA1WynY; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db23a60850so5266164b6e.0;
        Sun, 04 Aug 2024 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722758283; x=1723363083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVkI7ws3sH8SytGBGHon98LlMkqoO/ooAo5HpqnjZFY=;
        b=ehA1WynYJNijz9rguNRGQul9+hEqRcKwGkUBi7G+SlH6Gxf1XY1ZMdc5ta0Mhe5eMo
         BoAFrcWqMcWJ0KxuMTP9VCeiQtgJ5SZSk219p/nVUD6ZAl5Qheud2bnNUupkFHukwmM+
         tH/o6YLURm0/XJobTCp+epqf3nd/th/ExECHwsewel3Tp5Mchy14q1jaJOE57iVqJhe6
         Aio7G62gdjjHRTwEsRtZg59DfC5tMQAThaiD4VbkUuAkWqr+nnw3MVMfHDFEs2mFosve
         mGRI1vaL31pzmZbq+s6Wevu2gWi5l4M7f1ZnCmom9UiCUP3lY67SeoOuBEd1lkoWLhaf
         UzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722758283; x=1723363083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVkI7ws3sH8SytGBGHon98LlMkqoO/ooAo5HpqnjZFY=;
        b=IxNMJa5ESY0k+MNEUvOEc8pW9oakpmA5EnGCUVlIfKHSAVoza+bOS33fH3VUknALuS
         MwwDnL3lA2kMUNeWblAmt1XG+/IItfXxCbrMimiD+8u+YoD80hB026aG4Ll4DYvWjNQH
         jfg5QZHGSFj/XO5sqOSdkZDQs1mFPFJ3cM2ff70esmAqsh/5zSVYAE0byKwYHMgfoYeV
         24NCY+fSHTKcH0kUlgG7ww6XxyCgfSV3BNn+BRndacfdjoun1VUaEv3yJpBK/+ejD72k
         lqBXz+rzoUTnIjUIzV5Rjn3ub4mq6aFslfHVr2p0gj1q++u27w5IljHwQCiYTMc5VQsC
         zJaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc2fvKDIMR4SQoIbSPRfC4Zx7iqUxPTfnKcM/3h9yXw6/gfzBhdiKkAuoEMpvtn0cLtACSw+2ocS4ttVXgvBnlEb04UM7FVjjXLDUHQIe8WRqAmHvpUz780le4sGJFJlUQ82srwKnjJn/Zzd4wPVZRZeYKANgSJ2vzWOuLLhYp0Y783N4Uk0mX76NRp13I/iAs+6VIq5EH8l5f6+Q082w9GKBRXArRyfLAR5IZi6ZSmOf/KqYG35jwM21BmLCbdcCFxoV/+hdxC8Lq9Dzogmt3bYpAyGNtYG7sin5K2n64NANXF1m5xnjRt2PldHKnuTQn2vALOA==
X-Gm-Message-State: AOJu0YxkeOkQx/IiDkOtKfu9G1Q6ljUSS1RJ08Eas/F5HCGxTA5vUSR1
	EJNO2zXLVt6TfDesF3aqcvODeMSqJ8hnwRMCkwvquMlrxklf0nR0
X-Google-Smtp-Source: AGHT+IGvj96nN6G8dNTQwO1gCnAi0LCFIOOEmeeyoUDneJo+nlGiP3jzVP2As4CYicNVTrPVKHFDvw==
X-Received: by 2002:a05:6808:16ac:b0:3da:e587:3e1d with SMTP id 5614622812f47-3db557fc2cfmr11867023b6e.4.1722758282670;
        Sun, 04 Aug 2024 00:58:02 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178248sm46387605ad.202.2024.08.04.00.57.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2024 00:58:02 -0700 (PDT)
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 5/9] mm/util: Fix possible race condition in kstrdup()
Date: Sun,  4 Aug 2024 15:56:15 +0800
Message-Id: <20240804075619.20804-6-laoar.shao@gmail.com>
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

In kstrdup(), it is critical to ensure that the dest string is always
NUL-terminated. However, potential race condidtion can occur between a
writer and a reader.

Consider the following scenario involving task->comm:

    reader                    writer

  len = strlen(s) + 1;
                             strlcpy(tsk->comm, buf, sizeof(tsk->comm));
  memcpy(buf, s, len);

In this case, there is a race condition between the reader and the
writer. The reader calculate the length of the string `s` based on the
old value of task->comm. However, during the memcpy(), the string `s`
might be updated by the writer to a new value of task->comm.

If the new task->comm is larger than the old one, the `buf` might not be
NUL-terminated. This can lead to undefined behavior and potential
security vulnerabilities.

Let's fix it by explicitly adding a NUL-terminator.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/util.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 678c647b778f..912d64ede234 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -62,8 +62,14 @@ char *kstrdup(const char *s, gfp_t gfp)
 
 	len = strlen(s) + 1;
 	buf = kmalloc_track_caller(len, gfp);
-	if (buf)
+	if (buf) {
 		memcpy(buf, s, len);
+		/* During memcpy(), the string might be updated to a new value,
+		 * which could be longer than the string when strlen() is
+		 * called. Therefore, we need to add a null termimator.
+		 */
+		buf[len - 1] = '\0';
+	}
 	return buf;
 }
 EXPORT_SYMBOL(kstrdup);
-- 
2.34.1


