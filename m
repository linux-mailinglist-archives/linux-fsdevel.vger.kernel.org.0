Return-Path: <linux-fsdevel+bounces-22746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D7991BABA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CA11C211F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD1714F114;
	Fri, 28 Jun 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aemOUw9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA914388B;
	Fri, 28 Jun 2024 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565531; cv=none; b=ROhelnBm1HolS3LTdc0nOjg1J2z3FBkuFPncqBQy+wEFVuC0tgNqI0GqbTg4p72Vdv3bsJR4xvkuhUNGAw4KYEqChyszUdxO9kUnN+EBBe6iqWdtmYGwAJyhO2I7bi30X3nrO0HtmUi1KuFtq9XeXWv86mAQBiQBXc8LO25XEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565531; c=relaxed/simple;
	bh=YDO2GJm6IOYrfxyYfmn9qJYNq9J5YDMBpKRsJS71FYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afBivkFsdnybjUJkdKKC9SMJ+x+GfQ8OftuM7JnB+0AY2iRDGDR6plnDIb5ywgfpoYA56rgjai/bCmsfaSfXpE1XaZ3319XMF4DgX7MbghihwL02UoGMCWC9VTwqyLxXnJRxgxUuA1HBdchDROJjVr8O4CZFUqnEd//uyNaudl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aemOUw9l; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f9ffd24262so2091235ad.0;
        Fri, 28 Jun 2024 02:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565529; x=1720170329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dYktotwfBu6Roz80A5YCXaIPxsklnKpN0JVw9YLBJ4=;
        b=aemOUw9lzghK2nAEzwinfvhLc+6EJuE+gNfslNNSRfMNAty9dSETrgZSlUk6fDMvHq
         KIZ15tFFFJryKvCSkJh56XILlBaNqMiYK70730FLbIKbBGzzFLIq5r1hMGZn9iiiRY+6
         H9zn6AAS/CaOHNKDaa6i9C15ANu5RVJukw8GmBOOKyd7r7r5S5X/WfzqA4vCckIL60i4
         7XrBxTLVLs1aFVmyPYAQPDfA1ACBeT4I4B45DskYFpiseSEetHuVmblQpn/uVnI0W7mS
         3tTcsdvAMdAQ/OFTtbiMWnfNA33ipypqLcwwp7PNj2Z53NZuCsEQPtvUGQqQRtn/M1X5
         ihjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565529; x=1720170329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dYktotwfBu6Roz80A5YCXaIPxsklnKpN0JVw9YLBJ4=;
        b=eTwoS5k1k6yDFH/1fShi0qN3R8UdlIHP4VqUlxSHCxQLjFzcKEVeTZ4R6H/tesNGlV
         76Z46RMVecMUvrCzf5eV2RB5Fupa4/qJbNx5C1HjfrUFeP97H0EUAJ2Qe/GRVZULbU68
         AjR/JAWQ/63jh0DnCQq/Y0NMcJOUqTspW9t0E+p94qRsOhOtRgBJ2WpZ1q+EHO2GHCH3
         eib9MvxmWU/3ffDQs/7iTfFqz9+iZwo/KneECszINP6RDRGPnGb903rXmfcWAOUAYhkR
         hRAQCon/etp82+/qT+6t2x4Qfo48Gp72b2STj1Y3M+Lx5s78sQ1sf6MJCVhmjlojXnoL
         Qldw==
X-Forwarded-Encrypted: i=1; AJvYcCXjR8//uT6kbiqVdp7iex6gLgkpztKYQztdAIdNuvZGf6jPASv1ZLsg127okx6I1ztl/Ab7k0OWR6mYkRffCzp4zP34tEeq9y/lHarX3Ll07fY0EI0bThKs4PMbh9BjQV+SHGoMGWqRcAnumBg+xHYgTrDa8gN/VX+61G0tfNukMzu/qbz/aODBgR3NtvXsuH8C7tdxI+RlfA6DapuY6yGybN48UaQYOcH4Jj2imq1QNpeoNiQumG2tizJE8dhC3vO+E7L6Cr0zwSwNevtzzBd9Sk7O/axmTLHfVYS2deWEV6YKCRrv+PFVK7kM5nVJ8AIw51iLXg==
X-Gm-Message-State: AOJu0YxSTyC4U4okg/Wz9TJVF3NjNjtLtN5VISoPJf1E2jaUTSVqWShE
	R21Sk6oQ801d46QRzYzwx624zb6IIgpeXJCRrzG5Bqy+wzS4I56YpnL/emQvyEc=
X-Google-Smtp-Source: AGHT+IHq12/wr4f/48x7wfiSbegh8HPUA/2boo4oAyw8ihJMGtAi4AloztlVccxiTIt0WgGf0DVrww==
X-Received: by 2002:a17:902:eccf:b0:1fa:3f05:20b2 with SMTP id d9443c01a7336-1fa3f05244emr164534885ad.65.1719565528645;
        Fri, 28 Jun 2024 02:05:28 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a1dsm10473085ad.68.2024.06.28.02.05.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:05:27 -0700 (PDT)
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Matus Jokay <matus.jokay@stuba.sk>
Subject: [PATCH v4 01/11] fs/exec: Drop task_lock() inside __get_task_comm()
Date: Fri, 28 Jun 2024 17:05:07 +0800
Message-Id: <20240628090517.17994-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240628085750.17367-1-laoar.shao@gmail.com>
References: <20240628085750.17367-1-laoar.shao@gmail.com>
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


