Return-Path: <linux-fsdevel+bounces-24939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0984946D2B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 09:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BD228182B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38E31CD29;
	Sun,  4 Aug 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkGHDiOH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1DB18028;
	Sun,  4 Aug 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758226; cv=none; b=PYssLBwGW8tAVKH4SMMus6vvd2grQwa1yGlVl+99+ecSP/n2sRuiQaXJAnbPUuWgyA05y9ywktG5/OWGRi1Wq1jl+oItdc+99F9DNhRdu0ySlCtOT1Sl9d0wyWr/5X0gmtAlRZXvodiwMArtXjK51ZM3h3+deoCRsHfoTnMEu/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758226; c=relaxed/simple;
	bh=l2UdoLGIj5dmNTe7kniywtU84ZIetJS7/k5zo/1TUMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OTrScLG7pOe0d5Pe/fiIvhBH+pm0nRdGZ0ZA3yNZmUF+Pu+slB9tmALEVB0kvWYtlBK6Q6xmAOHMI3hvlSTiLWhaemNIJHwOPO3FkjKhPC7xm0hJ+d284Q07FTiHKt8zkCeeJ7Spe1yrFq1KONog0mmKVGMImPoL4Oc2lLgDYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkGHDiOH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ff1cd07f56so73160825ad.2;
        Sun, 04 Aug 2024 00:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722758224; x=1723363024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hHqe/dVMoVlxAlcEkx88W0WqBv09P0jej1HBEqhafw=;
        b=jkGHDiOHSxN246QcT1JU0j/fHblrWltNi4s0DwB333JXU4H76s5kXIyEmc0tA6XXsm
         LsYi+uzuk0KhtXIIfCeB3aBsijXjgSC5JGhBY3i6UUT6dSu4rIXgty1+3i9DB9MpjAop
         gd7b9G4jbRTdFurLedHEpp66f/SHacENp41UjI6IItjDkoHWztRZ90DCBuLXK5jIeu6x
         SFjGwtn9JHWXSq/TKI3EmWG+LO7LRMnF5JH3yhMQpa4YnOM+4X1rC+e8lqSyEHrK08xz
         FecxHOJCvXnAajBtDFJ1zptiG1yHFLvoaqrVDDWkaPgdWmCHI/eICHieaGda3nZQLYHk
         XOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722758224; x=1723363024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hHqe/dVMoVlxAlcEkx88W0WqBv09P0jej1HBEqhafw=;
        b=hV48ReGT3MBsRuLjf9Jl1WUv7mJduGSfy2vsBBQl9Hkt5EOYwTwnrXb9gPMGey58Dl
         U4LDSte5v0mUo2LxaRJJEBDwRYO043WviAF5U0Ksj3V49uKxZVrejbTYgN8Ir9SyAKbd
         QurkYW24mblZkNxgM0HZIMJKqF+Y1aJbQRq/nM5gcTDGVmmuKqLzNwtnF4RMIexHdRmK
         PrKN5tRi8e17rGjUs/hPb8OpD+9522N925DfhPdk+lxx+WD3TGKtt+3Q1uQ2KHvcL4Wq
         alzX2j/IBYr5BGJV5fh63wXwDICGBegyjtfdvl3BPoLyuupQT4zy6NO8RtY55T1foZbd
         CLMg==
X-Forwarded-Encrypted: i=1; AJvYcCVpZ6unoZDgzyywlJ4Lda6U/ZlftPY/1PR57Vr2HqrO6kIOAMnAdKXTamVTxhgfToygNkz/ewb7yMYEeiFjmTe3ei2BKLrwCPHoC5thIuDeDgGsYknSJpSdXCNS46hdXhXftvMtZ51sw59BVIyhRjyH94fWS9EJ7IZ89dDdJWHGuXAxpPXSMLQQt0mXa580lXrfPGeYoe2tpS2hIlGpBAPK/WuBFrx2ix2dw+lPMvnWojj8JSWtPYR1AJO9LH1dPqwxBb1lVE9qmA3TjKPfoXJsuHT2MHsljsNNug+/zBCXxeMwusPG4tUK4WOUcuJCrAedM8L7lw==
X-Gm-Message-State: AOJu0Yx1tRUFV0stFpILkENcZqTpmppsKz3HuSKbmCW81ozlfc6FFlie
	KKVdpYWtvkc3FJlrrc5QXWxQzXqd3EoURDeExJ2Uy0R+eJBGIa1j
X-Google-Smtp-Source: AGHT+IGGd4NHuT97uC6xOQQvHv4GaxRo9+Vf+VhHCShMz8IgX/0qP5KyCL4xcS6MgRK6pPd/R/ObqA==
X-Received: by 2002:a17:902:f685:b0:1fc:719c:5f0 with SMTP id d9443c01a7336-1ff573e75a3mr134700565ad.49.1722758224055;
        Sun, 04 Aug 2024 00:57:04 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178248sm46387605ad.202.2024.08.04.00.56.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2024 00:57:03 -0700 (PDT)
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
Subject: [PATCH v5 1/9] fs/exec: Drop task_lock() inside __get_task_comm()
Date: Sun,  4 Aug 2024 15:56:11 +0800
Message-Id: <20240804075619.20804-2-laoar.shao@gmail.com>
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
index e55efc761947..6a0ff2e3631f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1195,12 +1195,18 @@ static int unshare_sighand(struct task_struct *me)
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
index f8d150343d42..71002f0fc085 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1096,9 +1096,9 @@ struct task_struct {
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
2.34.1


