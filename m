Return-Path: <linux-fsdevel+bounces-24390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC2F93EB5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB4A281520
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0835A7D07F;
	Mon, 29 Jul 2024 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRCflNfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58261E49E;
	Mon, 29 Jul 2024 02:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722220719; cv=none; b=eErRh4DQMOtiTdOcHnp4bxXe3Q07u7fCeofbnAt/igXXt9RcBdbK6GZNLWE56vVtlkso5SQwjcxv3Z0fdqwgZtxcSCpXj601V2Z92UYX8PZtT7lM6MKad8iX+o0wvBfiHhVOFTW1buHb60nU87SpRNXJJhB0y3xV1rr8VgveAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722220719; c=relaxed/simple;
	bh=YDO2GJm6IOYrfxyYfmn9qJYNq9J5YDMBpKRsJS71FYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ubRzkqe5LpRzab1oFQnBYp0fKQEgKoK7lenkvix69k4QBL2bA43GJZAZSO7l69W2C84UliIyF/JhmOon9j384I6WCiO1wFOfQKet8hZVACXKTu5/NA+/kZDNpHRoEncAypJNHFyKff8aFE5qqoOTUMUcPDLpKsaQcF/eYhviWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRCflNfk; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cd5e3c27c5so1623243a91.3;
        Sun, 28 Jul 2024 19:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722220717; x=1722825517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dYktotwfBu6Roz80A5YCXaIPxsklnKpN0JVw9YLBJ4=;
        b=WRCflNfkcYNOTj1DA/suc+jZZ7vpMtHf2osVZVs/XOhVbriI+DOWo3c9a4jO+rh9dy
         SJJWYmCzEP3uZFshum2p5YlQxjXCpWsVf9mmPWbRTW2trymDtz0IqkkiTkVNjeoeYIt4
         9bZiWscqrOrwzMHKGe0Cd0WFgy4gy8rGyq7/3GTyCs1VHWwBkAnR581uMwCZwkMFrL80
         /ppw42pHvuplPVnpfi4mBaZTp0qUPsXAr/iC9ehLRzHeuaIpJye+gZWR9bsLfjaSK9e4
         SR7C5KgYvNG2qAmPFKk3Oz5+IEzmZzZUVPMwGklTlLO4whitJhSdCClQnvPFPlJf2W42
         AyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722220717; x=1722825517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dYktotwfBu6Roz80A5YCXaIPxsklnKpN0JVw9YLBJ4=;
        b=ifpUBplsLkTdun5MXQzA4gN7LetPM+5II6NzWGG/C2CFAVVPtB3UPrjHYzWl2SnNdC
         B/WIIrJUvFnGYCqOjHL0fIWYwTN/6CIGWhzTtlXQ5G95xdq0UvQ8XV40RrYlf0iz8aKE
         /1SQuLWGetJMkg5lmU4CdBGfvd+N5bcUv9ROpIqy2s2Ril31UZkwxmvna0TQb2YJsu5n
         VgWlgnM9K6Rj3NUrtDXxEUgtL63LoT2zXrzzmIhEUatjFyaicHbqm/96DtFg+mpMkDth
         cdZovjiHJIJp1S/6gJpD648zlM83XAx2VRFLmMpCNbSMRAxuw9lan5U3qS+3iu6Rb02s
         pIXg==
X-Forwarded-Encrypted: i=1; AJvYcCX3IV7Yc6A51Vy1VsuK6PawnOx51ePaauJh1kzuQh7yymJqDwTKYu571AAK/wnYwvmE0Oy7K7SDBUfQMXdZFd8IXvbzcrUZ8qJpHCE/013/FJedEej8e1zhmwDxMiUBjjKl1bbbJ0TyLH1WBQ7vMl9/dAK71bkgi5QFtq7+/uVCsYyoUDek9/Rb17yHEYIOfWrFkNaZXwQuCGI9isBvlaVYjePi5QqtiKHFYPgfSP2vuAuS1OC3XsPr32hBT0T0O9dRNjH6BJBEsinJFc4rkDfpZUU2YYYqyqt6CiYFuUXicU1lyPidyV0RxT6n5N7t7vONcD9FPQ==
X-Gm-Message-State: AOJu0YzvHvLmQDC+BBfjTpzDa0lrzlK+/rUBZ2qCSQ/IxVhEpMQ6Cmoi
	N/amvhN9KcHenFps5EcXOUR+emFeXuiEgU0G3osodaxhxNG8Geb0
X-Google-Smtp-Source: AGHT+IEUvSCxvTt2iFtiQZnOEMmTj53JiCANDbCPnBaNHXCCebMev5gTq4Ke5agmpYOP2sLQoQ29tA==
X-Received: by 2002:a17:90b:3793:b0:2c9:5c7c:815d with SMTP id 98e67ed59e1d1-2cf7e2275d2mr4251165a91.22.1722220716985;
        Sun, 28 Jul 2024 19:38:36 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55a38sm7332247a91.10.2024.07.28.19.38.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 19:38:36 -0700 (PDT)
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Matus Jokay <matus.jokay@stuba.sk>
Subject: [PATCH v4 01/11] fs/exec: Drop task_lock() inside __get_task_comm()
Date: Mon, 29 Jul 2024 10:37:09 +0800
Message-Id: <20240729023719.1933-2-laoar.shao@gmail.com>
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
2.43.5


