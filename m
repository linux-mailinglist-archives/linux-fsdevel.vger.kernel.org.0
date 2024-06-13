Return-Path: <linux-fsdevel+bounces-21584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 971AA9061D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 04:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14AC41F2268C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD912126F1D;
	Thu, 13 Jun 2024 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfL/V1a7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D433F6;
	Thu, 13 Jun 2024 02:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245873; cv=none; b=gc5nI8SZI5WCRtaKKlZg44/qyylH+oqCs1+2tRiqcRtTnBq/I3bl4A9Oa03K3AW6mcQmYsP7v9Y4raht5ReSErzLzMr+5jGtdU255iE26Q/mDdq+kHOnQ418hauvuEQKwVfR+RHV1Gh51inFkCzwwQeiCJcX1/F5jSd7MCQ8cgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245873; c=relaxed/simple;
	bh=LX61AqcJNexywhWKUem5c5kFXTCQtXdiKlDqbpWt6oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JvVToUi70jUYDTOGJuBd6ysTsdrKlDAf08UdTfKPFAU2/fsEdlrBYNKCtT4WMwdD4XyhZad5/pgahhpgyefZTf6hKKKqTu5oeUQst7Dd40kKSs/aXJgPpWgM514WCxgcmPrgCo8EuE8ihpXGIrmd/cfD5XFG1nwkFdSLgL4eZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfL/V1a7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4a0050b9aso4925655ad.2;
        Wed, 12 Jun 2024 19:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245871; x=1718850671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt6Zo0BQwE9mYz3Q0zCJOWUGA/XKEFxfC7Idotg6GZ4=;
        b=DfL/V1a7sg9OmRK/rfdaZT6ApIcuzUdgSVe7aFbOCuwUjFroAKL15fJ5Pf3HhlU4iE
         yfa9dgL5WuLdHUgrGn6BnfiSddT/GHxAZJPxtyFpv33vfVzyDe0XsP5M2VmAjrjjA0IT
         36c/GrsXlD5aArP7hQ4j/22nyKIKZBNVz6bJd/VxI73saBIjc8JtZLjQClqQhrzvP8M9
         tgV7c+mn3BUfc6Vp3muQZkIEGlrWWPHIn/d1YEwOM+4OcDVwaaw0362cDmNAArf0cd3H
         q0jqhQvtVPQn5WSGIRfjvNbCvjIG8CZoW96diMgJFuFCAHtraWKhJLE5NCiVk+YE3Yvo
         RpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245871; x=1718850671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zt6Zo0BQwE9mYz3Q0zCJOWUGA/XKEFxfC7Idotg6GZ4=;
        b=YIuX0GtCKQjMnJI+0n32vOmvtkJ91VujrDhNlnRFybl/UCQjQ67f3/U10H2NZ1Y3uZ
         4KyrD4tdD0NqsTq3m4iPDVgqjE8aNLqgqBTuz8DXHt6hRZo/aKJUMS5uq3/63eBZ+ASV
         Tr7PjfkMjmZHvekJTuFoCOaO3dpAsePbVaC2VLBTmTYyT83cP28bBOydt2hlwsc8Ypv8
         sk84gZmwrtV77DYIntVC255Mqc5z9Go4mMjw6zOy8gcQ0RxtNrUk/JpaUL+Gyq4Rc+8X
         sPbCLs6PVxLmjBpTGkXwT5HtGlWSctmmmShx7E/0p7XC6TOoyL6b3Yqpt/iXffiF+zsn
         3IvA==
X-Forwarded-Encrypted: i=1; AJvYcCXKtglx9LHY+w6U/mNzIeT3qmIMrVvSzwprlE5E5+8p9/ax920mziZHkh9uJVMd7Qwd2Xfo9kmNaFX/YlD8IDrJ3+Ccl+7Z3gFfqwpfmeDQmZkUlL83CMJJQZs+wFS64RgRdM6+3JEu6IbmnkkAUtuFhq5R1nysMjhOMvoKUGKXyDEdCbuQxeCCoFDbQWz6tBRIE1aC9XmnbZ5vl55iIs+89K1ttwBaz/MFWeQuD3Y8v104ivJCshWfLQdY+Tn4926sPUd516K7Fkn0COmmLljJ3ZlrKxs8xZo0pBdwnseurk6AyERFjQA8dtkJn78m2FyLSEEXBw==
X-Gm-Message-State: AOJu0Yxu6xT+mfXekcJIm3o3xJ+81vVAhOh7BdwEk33o5+PYMpyc6oVz
	at3FGkIZrpS6mGJNwtNXqMwNMYq/ithrxnPs+eQGNwVdaqxxZ36Z
X-Google-Smtp-Source: AGHT+IGepHvi+lKqMo1GYaife0L6fUJVRPiktMyHkXeHwR+7tr6qOJAeLHRN5Lin69VRxAqus5DeJQ==
X-Received: by 2002:a17:902:ecc1:b0:1f6:6ef0:dae4 with SMTP id d9443c01a7336-1f83b5f3fffmr43616545ad.32.1718245871101;
        Wed, 12 Jun 2024 19:31:11 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d159sm1755695ad.289.2024.06.12.19.31.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 19:31:10 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Matus Jokay <matus.jokay@stuba.sk>
Subject: [PATCH v2 01/10] fs/exec: Drop task_lock() inside __get_task_comm()
Date: Thu, 13 Jun 2024 10:30:35 +0800
Message-Id: <20240613023044.45873-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240613023044.45873-1-laoar.shao@gmail.com>
References: <20240613023044.45873-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Quoted from Linus [0]:

  Since user space can randomly change their names anyway, using locking
  was always wrong for readers (for writers it probably does make sense
  to have some lock - although practically speaking nobody cares there
  either, but at least for a writer some kind of race could have
  long-term mixed results

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com [0]
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matus Jokay <matus.jokay@stuba.sk>
---
 fs/exec.c             | 10 ++++++++--
 include/linux/sched.h |  4 ++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 40073142288f..fa6b61c79df8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1238,12 +1238,18 @@ static int unshare_sighand(struct task_struct *me)
 	return 0;
 }
 
+/*
+ * User space can randomly change their names anyway, so locking for readers
+ * doesn't make sense. For writers, locking is probably necessary, as a race
+ * condition could lead to long-term mixed results.
+ * The strscpy_pad() in __set_task_comm() can ensure that the task comm is
+ * always NUL-terminated. Therefore the race condition between reader and writer
+ * is not an issue.
+ */
 char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
 {
-	task_lock(tsk);
 	/* Always NUL terminated and zero-padded */
 	strscpy_pad(buf, tsk->comm, buf_size);
-	task_unlock(tsk);
 	return buf;
 }
 EXPORT_SYMBOL_GPL(__get_task_comm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..95888d1da49e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1086,9 +1086,9 @@ struct task_struct {
 	/*
 	 * executable name, excluding path.
 	 *
-	 * - normally initialized setup_new_exec()
+	 * - normally initialized begin_new_exec()
 	 * - access it with [gs]et_task_comm()
-	 * - lock it with task_lock()
+	 * - lock it with task_lock() for writing
 	 */
 	char				comm[TASK_COMM_LEN];
 
-- 
2.39.1


