Return-Path: <linux-fsdevel+bounces-46086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47231A8266D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3439F178E4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D45263F4C;
	Wed,  9 Apr 2025 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bG028Wew"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C60245024
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206066; cv=none; b=nmOsdk1XsrI4xlcc9ugEyGGxYu7M3QvSY6pa1nM7e9ShAHyUddTHp1N7QaLsDiCtfqwSdfvNaQevPA1kVhD541O8Up5H9n4VSNpySbxrLgFjHvTXNtyaDmhwQvo4dAI2Wa7ICkvG8qL6ATs29NCf19JayLztdgcIv3iIa3GKOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206066; c=relaxed/simple;
	bh=uMvf7J0yA0zoR+hLE+IY57ndO65Ys2suG5b3TYxY7MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Whkx7jLQEBB6Wphi/nxMQ4WtODzAqttoLrrYD3AzMF2BX52iEB7DQ7ucXV3Nll4MdZkT9Q1Q3ZsMVO0sruYMV0LRIEaeYmwDXIhHWKJKplSf433ekXg4cwEcyP4YGTxdiAZFFjATgnRqA7dwGIRf5eEv9yZnEvqc0ZcEZG8q5ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bG028Wew; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d445a722b9so33834785ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744206062; x=1744810862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXFsFKc6RLbz870fPz68WCkkTLZUZDUmKqEm4G95Sm8=;
        b=bG028WewEYMgdxx5e5GWYmKSjBOkr+TAVNUTqXDYY79nADAEcdbV/jNyr6fCo6yw3q
         XK5BUjhRu7tEp1NToTAWUYiBvjghjL10Yo2qiR4w106frdBXCxC5EmCnAR85YRSJn7Oj
         dk9snHfEq9Hb61n97rg2yjBudONREjtAXiCfdiJgIqD3R3yP7oXVrO+YJs4bPueahqiX
         46nJSqdV4cGJL9atC4wD7L5NZrImfFo68OvYR8DHu0A/joSMYw5Tgn7vbILgQswPUCyw
         U9KatCa7RMoEwvbTCoO2N+hZw+e9k9tgmG7u5LYknWX/eOrfRk2FyrKQY08Hw8tkh5Cz
         Qmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744206062; x=1744810862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXFsFKc6RLbz870fPz68WCkkTLZUZDUmKqEm4G95Sm8=;
        b=HBDXQn4JxnUmNU60JMc5LsYqXk4Z5IzddJXJExz2WTmEK62PG4ZffZr3Ed14JUQ2Y0
         D/Gpc1oo+hEAUs/WpdOHNBKeS64c1BwRswyXBU3HCF7mllhhDF5pHiY1V1pYmc3jExGR
         SfuKQhcUVpiJQnli+ocpABj0Vg8qTDWhLLT5LNxiuFMz4/+Mx1lHtYtksOEuINd7B8KI
         rZ6N5B2f/t5PNX6NpohD5S7l75OTy7oSI7BdGMGPka+XWAJll1XmXXQRsPwyq12AqtVP
         TtFQYJKNKqxfXytWnAU3eSk9ehk7rdMwR8XJ1tYVXOgGy5UnYVOpHQ1bWil5jeNvGRFz
         0bjw==
X-Forwarded-Encrypted: i=1; AJvYcCX2ZAgShG9GU0UsKDzgvVKY/VD/uuRWGw/nhdL/GyiG5vxAIXjW678KsyIP98EWsACcT48atkM17yd3NHSj@vger.kernel.org
X-Gm-Message-State: AOJu0YyCoiyE+9JpPwH2MmxZeAJ8a5pkDwJ20QbrGPyzPE46+woOSeIX
	uvKSFsVSAWZqV8dzpBPbnwtppKtmO+TV7M9SrTvfb71xdUk+rEZJGL+AN6A7vx49oNeBa8tjlSA
	W
X-Gm-Gg: ASbGnctkCn6XTTBFnruvCeEfZ+ynosZaKoGoFXTvkbodcoCBUEET3t8ckGeEZdUCeLL
	eVxInGKSaivJVk9vdqQoAhP6IIiW64jw3BczW/6Mou++HpZq4SgkQ22B/NZzGn374+wMsa85OTz
	LJPW+ZG3onRK6/mzyRq0x9p+ItBkpRF/wg7C3OtHYKcnfAP0+RJQ9h3uU9bO4qyKWqjjBfw7qX2
	8nTFid9hL2EJYZ5JZO9SaYqq8ca7sKsl2re0v0AxxvOtnwoTuMaM2r5EXDI+tFIWmQ1KUFcSRbp
	W3ETkL4amKDHxa5+LjZR5w3ZBR7tRGjdwqOBQEWDoPFF
X-Google-Smtp-Source: AGHT+IGJOKrUGTPRqWp38V120QN16hyhDxK5MbK9+bzXZMD1BHY+Kn7YwvCC+ACxPMhmP7gQlFpW8g==
X-Received: by 2002:a05:6e02:1a6a:b0:3d6:d3f7:8826 with SMTP id e9e14a558f8ab-3d7bda45167mr22384555ab.20.1744206061378;
        Wed, 09 Apr 2025 06:41:01 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2eaeesm242546173.126.2025.04.09.06.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:41:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] fs: gate final fput task_work on PF_NO_TASKWORK
Date: Wed,  9 Apr 2025 07:35:19 -0600
Message-ID: <20250409134057.198671-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409134057.198671-1-axboe@kernel.dk>
References: <20250409134057.198671-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fput currently gates whether or not a task can run task_work on the
PF_KTHREAD flag, which excludes kernel threads as they don't usually run
task_work as they never exit to userspace. This punts the final fput
done from a kthread to a delayed work item instead of using task_work.

It's perfectly viable to have the final fput done by the kthread itself,
as long as it will actually run the task_work. Add a PF_NO_TASKWORK flag
which is set by default by a kernel thread, and gate the task_work fput
on that instead. This enables a kernel thread to clear this flag
temporarily while putting files, as long as it runs its task_work
manually.

This enables users like io_uring to ensure that when the final fput of a
file is done as part of ring teardown to run the local task_work and
hence know that all files have been properly put, without needing to
resort to workqueue flushing tricks which can deadlock.

No functional changes in this patch.

Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/file_table.c       | 2 +-
 include/linux/sched.h | 2 +-
 kernel/fork.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index c04ed94cdc4b..e3c3dd1b820d 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -521,7 +521,7 @@ static void __fput_deferred(struct file *file)
 		return;
 	}
 
-	if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
+	if (likely(!in_interrupt() && !(task->flags & PF_NO_TASKWORK))) {
 		init_task_work(&file->f_task_work, ____fput);
 		if (!task_work_add(task, &file->f_task_work, TWA_RESUME))
 			return;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f96ac1982893..349c993fc32b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1736,7 +1736,7 @@ extern struct pid *cad_pid;
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
-#define PF__HOLE__00800000	0x00800000
+#define PF_NO_TASKWORK		0x00800000	/* task doesn't run task_work */
 #define PF__HOLE__01000000	0x01000000
 #define PF__HOLE__02000000	0x02000000
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
diff --git a/kernel/fork.c b/kernel/fork.c
index c4b26cd8998b..8dd0b8a5348d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2261,7 +2261,7 @@ __latent_entropy struct task_struct *copy_process(
 		goto fork_out;
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
-		p->flags |= PF_KTHREAD;
+		p->flags |= PF_KTHREAD | PF_NO_TASKWORK;
 	if (args->user_worker) {
 		/*
 		 * Mark us a user worker, and block any signal that isn't
-- 
2.49.0


