Return-Path: <linux-fsdevel+bounces-25014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C98947BB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 15:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C198E1C21BEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2AC15AD9C;
	Mon,  5 Aug 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuIvnML8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1C17C;
	Mon,  5 Aug 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863856; cv=none; b=WafxE4UuW/k5EByncJLKXEiTL4ZDMCWXqSQUF71g3Q0aIj8yBU6aWdpBshYShD64cqsOn2DdNlYHW9x1Ky+yBMO2no4Hhw8qmlfKgB3ku9fOLpIiwzlGa100GTsYBCQw3jsnNgteLIrHnJizltiF6mMcAnKlEw6a6yb10FWNF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863856; c=relaxed/simple;
	bh=rHHe0a5IJ4MGL8gtYD+O3M/Nil4VzAEtTpxl51MNL9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGcnaNQRtAa35Mud8fefcwQZ5h91jQq7Y+khrfDwTkOOGaXR24dcNBFv+I3hFT0wk6ZKEoqaFjzgdgmnYarOowPxSX0VDna5A9uGoAhrAifWtpobr/fyo70dor5pJc5VQ6p1sihXYJ42p23UqwtUP9OhBqsfGplluaERpui9gMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuIvnML8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b7b6a30454so5371349a12.2;
        Mon, 05 Aug 2024 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722863853; x=1723468653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDNSEMAE3S30qdcaG1s1hlYV7GH7sGqMiEO4UvbDEpA=;
        b=GuIvnML8ZHsoH0eSTBF+xxTfVcp99Inl51yikk7ja0bdmlYOFwKT1c1QjC8KfJHvTV
         p+20fMrzPIPUGoF856Pw8tsOsZqPOcThUUOSjQ3zYojIQxKEISFkWvIs3eSHzxaHa9c6
         2oSwByDUhEYOr+51YXyDQlyZQO8tkyHAVLgj/a7BU04KkiOMvpng7K9NmQvB/+PbohhE
         LN3ZpN+aBNNuJWDOtHiSfSHQF9eI1tfcVP6ZvTPtrcSk4khPJvotCNhzjA8UCCA85fWq
         JisddXS2umecsKb6Ozg74F/9TigGXO8ONRvdmpG+tkTC+q3qR0qqfB2bXptqds4o8Gri
         ZL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722863853; x=1723468653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDNSEMAE3S30qdcaG1s1hlYV7GH7sGqMiEO4UvbDEpA=;
        b=FmC6TtnRfuLFElYIbPObXh2RGsCMEU7a7wg6HaQCAw80pwA1zkSMcZFxKp5vZLUTbI
         8cUH1Qunv5c59Y56RA8+DmnjqTmjUtsL35IDy3TibX+pWO2INVVVWAVNtmwfPkfFmDae
         Rl2gTGWrXH1ZxmAruzoeq+Ic5PyVMW7lm8viMDjce9Vg1BfSiVawyQFqweQBU2BjGl0E
         o8w54O12Z0bjcNb70xa6gg09rbf1H6IDWuGkNHR3hiVy5twx82+2Gr9nVnkspiirhO4C
         fZ6EPV9vi3aUeI36kjx3RWWiz1IAArY95Z2nyp1NL+EOlFLJV4Wp87YJNQeH6NikxkKj
         qVsw==
X-Forwarded-Encrypted: i=1; AJvYcCXdMLziCv6wEOmsZDivHtTO74C6gba+7E5ySUaQmD9JNkAg7HXptHbgAG3ETaLJ17503E8Wo+UF1jTEwqmd+EuFnlFPcRHVjZ7UVdTb/vuLYNVyKOptxwz1czt1WGGs2jtzyy21DyxYqqngYw==
X-Gm-Message-State: AOJu0Yy/2YjmDqfJdAQiOCxWgpJMCx97ijHwouVD5VjaKBWJJ8ilAPKc
	Unl2+s+riSSDr1CQS5x4f4ZHhdxfGm5DKVa7cCBhU8ugipQfv1qk
X-Google-Smtp-Source: AGHT+IGM3UFviiotd+JDfgUlzx9hTo0C30VIkxQjouHOKlUGkBx/6M8kqAKzAQIYwJXdATLI1VVQHA==
X-Received: by 2002:a50:e602:0:b0:5a2:763e:b8bf with SMTP id 4fb4d7f45d1cf-5b7f53146d9mr7942354a12.25.1722863853055;
        Mon, 05 Aug 2024 06:17:33 -0700 (PDT)
Received: from f.. (cst-prg-90-207.cust.vodafone.cz. [46.135.90.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b82c210sm4893206a12.62.2024.08.05.06.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 06:17:32 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	wojciech.gladysz@infogain.com,
	ebiederm@xmission.com,
	kees@kernel.org,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] exec: drop a racy path_noexec check
Date: Mon,  5 Aug 2024 15:17:21 +0200
Message-ID: <20240805131721.765484-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805-fehlbesetzung-nilpferd-1ed58783ad4d@brauner>
References: <20240805-fehlbesetzung-nilpferd-1ed58783ad4d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both i_mode and noexec checks wrapped in WARN_ON stem from an artifact
of the previous implementation. They used to legitimately check for the
condition, but that got moved up in two commits:
633fb6ac3980 ("exec: move S_ISREG() check earlier")
0fd338b2d2cd ("exec: move path_noexec() check earlier")

Instead of being removed said checks are WARN_ON'ed instead, which
has some debug value

However, the spurious path_noexec check is racy, resulting in unwarranted
warnings should someone race with setting the noexec flag.

One can note there is more to perm-checking whether execve is allowed
and none of the conditions are guaranteed to still hold after they were
tested for.

Additionally this does not validate whether the code path did any perm
checking to begin with -- it will pass if the inode happens to be
regular.

As such remove the racy check.

The S_ISREG thing is kept for the time being since it does not hurt.

Reword the commentary and do small tidy ups while here.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

On Mon, Aug 05, 2024 at 11:26:19AM +0200, Christian Brauner wrote:
> I think the immediate solution is to limit the scope of the
> WARN_ON_ONCE() to the ->i_mode check.
>

To my reading that path_noexec is still there only for debug, not
because of any security need.

To that end just I propose just whacking it.

 fs/exec.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a126e3d1cacb..2938cbe38343 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -145,13 +145,10 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 		goto out;
 
 	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
+	 * Check do_open_execat() for an explanation.
 	 */
 	error = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
 		goto exit;
 
 	error = -ENOEXEC;
@@ -954,7 +951,6 @@ EXPORT_SYMBOL(transfer_args_to_stack);
 static struct file *do_open_execat(int fd, struct filename *name, int flags)
 {
 	struct file *file;
-	int err;
 	struct open_flags open_exec_flags = {
 		.open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
 		.acc_mode = MAY_EXEC,
@@ -971,24 +967,21 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 
 	file = do_filp_open(fd, name, &open_exec_flags);
 	if (IS_ERR(file))
-		goto out;
+		return file;
 
 	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
+	 * Validate the type.
+	 *
+	 * In the past the regular type check was here. It moved to may_open() in
+	 * 633fb6ac3980 ("exec: move S_ISREG() check earlier"). Since then it is
+	 * an invariant that all non-regular files error out before we get here.
 	 */
-	err = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
-		goto exit;
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode))) {
+		fput(file);
+		return ERR_PTR(-EACCES);
+	}
 
-out:
 	return file;
-
-exit:
-	fput(file);
-	return ERR_PTR(err);
 }
 
 /**
-- 
2.43.0


