Return-Path: <linux-fsdevel+bounces-14928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7B2881A5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 01:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FA5282F1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 00:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B83417CD;
	Thu, 21 Mar 2024 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYhXo7Ut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D363C
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710979862; cv=none; b=W6nihO9Sv3X8TQmYS51EkA0j9MOh9jYuNVioXQShWcLG1xQ8OZtReQbL4qu5oAoLjslFqVfppdAqYjup8R3+c5T+VkKnp86KqVI8cH2aYy1Xm5YFNmNyKkIt1uxTyAdgvuV6e+HdLXpT0FZ27+2TzwvNOlvNvTLOyiHn/YaNfBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710979862; c=relaxed/simple;
	bh=qLFMjKBHWBbdNmXG9Gp9YCIsExWfJWYt/CixfHOVoOs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CSpAitCAMbtSN+424t7Ny1iZTvmG8Wx8uk5qyHtWPEg2ZH1MUQQdZYkas30d214oTqT0ojJcxzzlfy89o7gaEjMPAQuOqTWCmq/zFZGy+UIswr+ALVDdmE3jclGROa1onvnEdmeUO8r6OQueC7VsQg2k/+FXquU55u+MLgDQEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYhXo7Ut; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dce775fa8adso668541276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 17:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710979860; x=1711584660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Y/++eaKr1uF0F/QMSpfiG9X2bG1rR6plkUxL7VYSLI=;
        b=oYhXo7Ute7KFBr2Zi8bcJfQXt3gOUz/tvphMtlqgbKK/qHZyfRJsGnTJHPf0TZeyDv
         ZB+FMnuKMe02AZn/9zhFb7hfQvP2lyL/o0VvwxAaOyPrKGI1IjJxNgVmnOnAEeARndNL
         sOoNbKkEOyJFaLn0JWemQXn3doQj/G8ejtqGpz0cE6CGQ00u5j1w/51WfxiIdVAOp4VC
         VUZWnrAtTYvCIEeg5PtV+xdrRhFVfMHcpo5qMGlWG98Us1mAk1xFGtacVT8ewtzzXv+p
         Qld+FPV+uSpGCR8t6uVBt3MNo07i+St0XZvUNKHEvdiwT8tBGTIWt37r8kD16UmRiGTh
         q41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710979860; x=1711584660;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Y/++eaKr1uF0F/QMSpfiG9X2bG1rR6plkUxL7VYSLI=;
        b=pdZHngqgLbmE0XFmei3eSQo7dst8dRnNuSM5NlbfSTVNgpS7jgUOzFdtUg4xavk5fq
         JLl0MPrcpas7DB0qWJD80MLECY2uwZlBG508IMlVoFZr74Qoo4jDXWDKdig6yYaIeDZb
         iqeJslBEs/w7MTYrCsvWM1nq3A6tbI7CvB8zk3mdHHWTlhUmWbVjylTK6auS27xSA8gq
         NULGOY3h4euXtoJcNZXHCnQvjynK/DJLG8VIIjEf2gGST0kBD+QefK3To9ciOuj1UP5L
         G8WAr1+pehkT7Qtg9kFiPxJyoYbwn/BH0tThAV8/MuxZ6ry+CDknQL1jfeIL+TshZ5id
         EGrA==
X-Gm-Message-State: AOJu0YwcfTRY/UHQZ9ROHtfDu7RXfOpdFioH5uPOpDYANxZJ4r132I7/
	AoWGa8MoxxPupQUqJAgLLTkV/43rGrL4cjrDv+ey13rFERdob4+eWSgiiytOkr5UFK5H7Q75dGn
	C+hNhQvrHJVyvTSqkzJ/xBA==
X-Google-Smtp-Source: AGHT+IGf505ZVazw6jjUV6V9zvF2/vHvzzK6R5KLbh0GdIFxY2g4V4MVPW/wlAhrkwOVCVplbt5u8DMwwFADJQzvxg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1b91:b0:dcc:6065:2b3d with
 SMTP id ei17-20020a0569021b9100b00dcc60652b3dmr4933165ybb.8.1710979860466;
 Wed, 20 Mar 2024 17:11:00 -0700 (PDT)
Date: Thu, 21 Mar 2024 00:10:59 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABN7+2UC/x3MQQqDMBBA0avIrB2IUaz0KiLSJjN2wMaQCVIR7
 94gf/U2/wSlJKTwrE5ItIvKFgqaugL3eYWFUHwxWGM701qDmlNw8UBWfEvgb55p5Zl9FIcOB1v q/aNvGwPlEROx/O7/OF3XHyjMQ/hvAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710979859; l=1970;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=qLFMjKBHWBbdNmXG9Gp9YCIsExWfJWYt/CixfHOVoOs=; b=Y9r+dN0unQvQHHcwvbxTa+ghrDkz84FfNC4ehnh5o5e+cMt0sywA8r4Lzk0cBi+LdcSfrlgRj
 +FLMm+BPNOZBHvfDKNPhK/wDxJMzw04FfOepyTH+/VSwi9grFbpRaRm
X-Mailer: b4 0.12.3
Message-ID: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v1-1-fdde26c8989e@google.com>
Subject: [PATCH] binfmt: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

In every other location psinfo->pr_fname is used, it's with strscpy_pad.
It's clear that this field needs to be NUL-terminated and potentially
NUL-padded as well.
binfmt_elf.c +1545:
|	char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
|	{
|		task_lock(tsk);
|		/* Always NUL terminated and zero-padded */
|		strscpy_pad(buf, tsk->comm, buf_size);
|		task_unlock(tsk);
|		return buf;
|	}

Note that this patch relies on the _new_ 2-argument versions of
strscpy() and strscpy_pad() introduced in Commit e6584c3964f2f ("string:
Allow 2-argument strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/binfmt_elf_fdpic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 1920ed69279b..0365f14f18fc 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1359,7 +1359,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	SET_UID(psinfo->pr_uid, from_kuid_munged(cred->user_ns, cred->uid));
 	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
 	rcu_read_unlock();
-	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
+	strscpy_pad(psinfo->pr_fname, p->comm);
 
 	return 0;
 }

---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240320-strncpy-fs-binfmt_elf_fdpic-c-828286d76310

Best regards,
--
Justin Stitt <justinstitt@google.com>


