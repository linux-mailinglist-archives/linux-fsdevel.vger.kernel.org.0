Return-Path: <linux-fsdevel+bounces-72785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FFBD045D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F69F329E1A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F19376BF1;
	Thu,  8 Jan 2026 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jATdcr4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD060368268
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858341; cv=none; b=KLHS+V0WHghMoguUWxXauiH1DWh8mFb1NQRgYvWNsZGu0SZJYzYXMCUIzF503/ItcP7G09UwuKKieoUT7nd9LBGyqLdElgsbb16cnwthr1uvP0B9uHDEPOlZDZMGU7RKYzEVCpz1xNNjzO0ZvtwkY/f2O6UnkH5D6XKkKN6lFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858341; c=relaxed/simple;
	bh=gMGuT6wpY3KH0qZCDvYc1iI0nMcmWwwOLl2QVVoaGtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ek25wMEpI9UScMkwA+c0Dex6C+k5fL3lmXo+216j+9vbgjHRUFjphsIVB9+cSg3J4hnmnYGiBS+6NpiRrONPGONeiFUIwKPYKK44d1wzDapYxrtgVGSRkckzYQXRdQDSf+Me3DEQTH5FsjvJHGX0GrBo8wyifE0Ql5v9AvoeY6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jATdcr4p; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8427c74ef3so444662966b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 23:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767858325; x=1768463125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=StWXzjpXasA9DQnd17llnrn/T9P7sI+jQ/zm5/N+GEc=;
        b=jATdcr4peSZgubir+/F+WnNdHnaouOhqQM5h7YNy+sB+BM7Vy5HXdKORTye09CSLIN
         z5VO3tJNvQQdGw56kbddhWb0/cSZcJDwPHjirxxgvwZ6wq1hqyeASkJmJA3Rzb8kBj2i
         To/B3tkxZpmE2tgFnFHIxOdk8S17/gB1UXj5+EoKV49fGy2LbSe1SzYXOnzbI9vqsrwz
         3YnSQlwad8ZV7NPvZ/1nHgJbUt9byq1Xwg69SycWP9UwT/M4KOlz6bzI3bT4LNx9Zl//
         Zir5KtizzR7xpIPs0sIcekf48dVQUyl/nzGvyGLtyteBZ8hawXIHMIj+WR/4dvTxLdXW
         MFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767858325; x=1768463125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StWXzjpXasA9DQnd17llnrn/T9P7sI+jQ/zm5/N+GEc=;
        b=Jgp8QIhZCy/RajI24JNrFD0pCsdstmQfotCZRFcrwRCQX+hYt3kkiDnihLWcC0rCKJ
         f9W6WuafMdJ1WB2zyL9BQfvUPe5wmVBCaccGxhKMdGtztXHo22WJt8yyINDyhZeMibAY
         /+lRnJDxsQpNMmMPYJtSwxJ3ox6+ZydwU1TC6ixVytzAPJHkg8Y9aEqVucpraiusmgto
         u7MLfwfbpZ2jQ/9WHaeON4bib1MsJY9+1pLMcnTQZapirXQujQ/mcKco9SIWoUg7frzs
         rvmSVFpDbUi+vvJem3af5FIfUKFZXjpfCIhp39Njwyyvr6aL1bgd6hJXP4WHUh/vyQdN
         WKnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIoraMStMiVQGRqB4BKqxux28FsmSnhGKeAQ8oZavmeWsdHVNWlXQs1+aEabCLXv71EzJYelikSgcmPrqA@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEx0+Z4FYi3lorKmK+PnPwc9SFHWbbNmnA/xb8f5Ih7OfVpt8
	RBBwxnY1vqVSGczzozTH8ctVOFOdA3eAwJHAU+I2Zl2ub7BPRHsawLNx5brltM5n
X-Gm-Gg: AY/fxX5tH3hCj5xfqFfs8VwBCqeJ0zDRFMTriM1QABKmas0INhR2kkKWNiN0/4hZH7+
	aRj1GsrOARZVAUs53UciEYFNvFrWtcSQyLiL8K71BexNmAHir8NfO9ElXv9Ntyi7cCeuxAONbWZ
	z0JzTeWQpkf83WaA8wXIFZzXtS5UEb7zRg6F5OlBu8leNAIArxO/c9vtppboE05wGjnKpnArvah
	VmqaaZx6hUfn+ok5ybXpu/gGjcReowVWsrKYHcOaUFdDWIz7vR/5wPHAlt7Y52jvdb4wJuGTB9c
	atgRPU2v4QnSm5q6hsLmgMMl5FYNXndbBRwARsnNJdmzzAUFr1Ydw0RODWZl+BR5TfgYFbxxpFQ
	tucGVvyt1cRtokuU8GuV1sZJ8FwtPDkxu5WfLgSndhWVgcXFUvfRqjn0gExmXtZcE8OqRSbCshY
	vseY7i3zyZe7jMDZ7bs1NK4jxpHQFqjnucEcGmCT2BT80d4RKatiGSqqQ3XeqWPnmGWw9iRCUgi
	647brdFv0UaaoBe
X-Google-Smtp-Source: AGHT+IERS1xFkAq/nYuP+1oDkyH0YrhXJdeACbE7g2N++vJ6d4MHCQnRiyuC8Adedrr53/iadevUdA==
X-Received: by 2002:a17:907:3e13:b0:b79:c460:39a4 with SMTP id a640c23a62f3a-b84453acb55mr507527266b.56.1767858324712;
        Wed, 07 Jan 2026 23:45:24 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-69e4-e864-578d-bdb1.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:69e4:e864:578d:bdb1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a22ff58sm732503866b.6.2026.01.07.23.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 23:45:24 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH v2] readdir: require opt-in for d_type flags
Date: Thu,  8 Jan 2026 08:45:22 +0100
Message-ID: <20260108074522.3400998-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c31f91c6af96 ("fuse: don't allow signals to interrupt getdents
copying") introduced the use of high bits in d_type as flags. However,
overlayfs was not adapted to handle this change.

In ovl_cache_entry_new(), the code checks if d_type == DT_CHR to
determine if an entry might be a whiteout. When fuse is used as the
lower layer and sets high bits in d_type, this comparison fails,
causing whiteout files to not be recognized properly and resulting in
incorrect overlayfs behavior.

Fix this by requiring callers of iterate_dir() to opt-in for getting
flag bits in d_type outside of S_DT_MASK.

Fixes: c31f91c6af96 ("fuse: don't allow signals to interrupt getdents copying")
Link: https://lore.kernel.org/all/20260107034551.439-1-luochunsheng@ustc.edu/
Link: https://github.com/containerd/stargz-snapshotter/issues/2214
Reported-by: Chunsheng Luo <luochunsheng@ustc.edu>
Reviewed-by: Chunsheng Luo <luochunsheng@ustc.edu>
Tested-by: Chunsheng Luo <luochunsheng@ustc.edu>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

"Not pretty, but fine." [0]
This is what you had to say on the Fixes commit ;)
Maybe this will be finer...

I was considering whether or not a mention in porting.rst is due.

My conclusion was that the regressing commit might have needed to
mention a change of vfs API, but this fix brings the vfs API back to
conform to pre v6.16 semantics, so no porting instructions apply.

Thanks,
Amir.

Chages sinse v1:
- Rename s/dt_flag_mask/dt_flags_mask/
- Add Test/Reviewd-by

[0] https://lore.kernel.org/linux-fsdevel/20250515-antlitz-aufzwingen-cdba155ce864@brauner/

 fs/readdir.c       | 3 +++
 include/linux/fs.h | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 7764b86389788..73707b6816e9a 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -316,6 +316,7 @@ SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	struct getdents_callback buf = {
 		.ctx.actor = filldir,
 		.ctx.count = count,
+		.ctx.dt_flags_mask = FILLDIR_FLAG_NOINTR,
 		.current_dir = dirent
 	};
 	int error;
@@ -400,6 +401,7 @@ SYSCALL_DEFINE3(getdents64, unsigned int, fd,
 	struct getdents_callback64 buf = {
 		.ctx.actor = filldir64,
 		.ctx.count = count,
+		.ctx.dt_flags_mask = FILLDIR_FLAG_NOINTR,
 		.current_dir = dirent
 	};
 	int error;
@@ -569,6 +571,7 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	struct compat_getdents_callback buf = {
 		.ctx.actor = compat_filldir,
 		.ctx.count = count,
+		.ctx.dt_flags_mask = FILLDIR_FLAG_NOINTR,
 		.current_dir = dirent,
 	};
 	int error;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5c9cf28c4dcf..a01621fa636a6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1855,6 +1855,8 @@ struct dir_context {
 	 * INT_MAX  unlimited
 	 */
 	int count;
+	/* @actor supports these flags in d_type high bits */
+	unsigned int dt_flags_mask;
 };
 
 /* If OR-ed with d_type, pending signals are not checked */
@@ -3524,7 +3526,9 @@ static inline bool dir_emit(struct dir_context *ctx,
 			    const char *name, int namelen,
 			    u64 ino, unsigned type)
 {
-	return ctx->actor(ctx, name, namelen, ctx->pos, ino, type);
+	unsigned int dt_mask = S_DT_MASK | ctx->dt_flags_mask;
+
+	return ctx->actor(ctx, name, namelen, ctx->pos, ino, type & dt_mask);
 }
 static inline bool dir_emit_dot(struct file *file, struct dir_context *ctx)
 {
-- 
2.52.0


