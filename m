Return-Path: <linux-fsdevel+bounces-46697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A9DA93E5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 21:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FABB8E0819
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620722D784;
	Fri, 18 Apr 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhMmBD44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6A122CBD0
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745005152; cv=none; b=OGPtWYzbJMKMJ1eErM6ceUL9LS6O7daP40go+yYj0iJye+f+oBYm7MUbV3miCp0/NG3DIqYVzZhqSUFES/65PLU849x9BrUFNpj8pi+K07uFse1PfRLQOk+0yjqY5a6nE7ZphrscOu6cJ0DkNCcyIwXHIZx8V/rz/6M1JV3gIVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745005152; c=relaxed/simple;
	bh=nXfRSQBbPxPIqkBUM8L6jdNDQRYjBxgo/UWi01kPHjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q/ckOFgf9F13Qgjp35rqvJsyCYrxVn1PejgioPanxdPvjdfJmF5lM3sIF09mEQKKu5hq143PpBW0U5chwP4PyS8eCzO4PHyRWUymH7zD8cXkFXj8uSgH5nmM3cGRl5/hpDww32mM1TP1byO0rTbqDK06ZcCQsIgSIo0HyL4k+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhMmBD44; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f4b7211badso3346680a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745005148; x=1745609948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fah+NsxN/y54+O/kcgktmT/v9wOhx4Fx7I9oQhttvIs=;
        b=dhMmBD444BBxttJCaofDoHPY+Ko/BXYEXtQod16YSqhwHp30YcvAb6sBka/EFngGW9
         aciMIMWU46ZKPm6FT8qJKRY0wCW4AN8VVxBTKcWjF+gTvPYrAdfvomZlNNIqntkityPi
         EAU5n8lv6dEfcGvLPlcvIgMAM503KKK6J2q7yK254DQM93C2zDHa8mOY9uGJEC49Y04X
         LjNXJwQYnvPtat8/BOwaAgEF7hhUgAcw9JERxAb2LI9JYa6IQRTtdBLdEvLCkktXn53z
         281esDkd1Dq9XxC3UEKuvsKowrwKS1HmnoaRJg+nt0qF6IDEYON8lwERPoZCDcATiB0F
         s0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745005148; x=1745609948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fah+NsxN/y54+O/kcgktmT/v9wOhx4Fx7I9oQhttvIs=;
        b=hkYRSdrF1qwF+O2KOa2WEKINrL4U/3jiWSWsTFrN/fkSxkesbXIUGhuxX9AMdcxGvY
         oPusoPZWSyLQElr7MX4jm66urVrKR+HnjXBpuw0cRXvJE0KSt83ZTTasqWGxjRyLtKMU
         Mq8zOjzs4Th0zwq+ew591iUrPrStrXLwe8t2lBR+b18tZUHBPx4gL1RtEJe8l0ZnzOye
         RU7aXeAjLMApCHdWEnBDM9nL5srsF7HG+Qp6WTAy5A3vRDVnt24lzeE/yyP+UQGk9JV4
         DjJv8M/sO80mPRLMNpgI5HdMCWvJ74vtWMbMpdDeFMrcsLbmQ92dg5tEJHZsI5yXv1er
         k+jg==
X-Forwarded-Encrypted: i=1; AJvYcCWnsAnz0L2GB6KaH5WdXeOZeSmTBeT/DmvXTCTwC1IxCoh6ZNnEQW+9bDYvLBAMI5JWe1Qz4sjuThXhHivc@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVv1k5SjOp0kxvj8OBwb/YquYoyG9kva4AzyHYZX2pE80Nr3b
	BDspbX2moO5F087iC6unhn0WfodOWcTllFhUXWcassasy7WFwW5r
X-Gm-Gg: ASbGncvxY0IN4E2YoFAr5eBTzEAl8eOUzCTBHxyksAo1im3C/MG5RhBuLt+s95x2Nwz
	5Yj7klMm/VdhVxoRN29+74agvjx28/ZLDT2RceRDGeRc0up244gz0rrSky1ssUSN1RXa5+t60PB
	4n3QIY8VCFuRrxqiqq/wPyZ2gWAL5ZOCQvdZaatFhI7uji1unGzRZvGc212CJYVx7ft4czdo2KY
	rD9l7lipeIu3AKVfLm7P6lPkJyoJL8e4gcUEc1xe+xDJik/ERhSUgMg0TLjf1owJnVQk/w90B98
	SKfqXPfbXVO/8gV8AFbAQmxFK4Zf850yKr39OC/zgpzN3MbM/rLUoBzN85EhjZ1FQgHg/Tu+r50
	9rPkdOjA50SmpSXg5UR+/eoAoxXIzAz1OCYXC4w==
X-Google-Smtp-Source: AGHT+IHOKqEBJb1MJ0aEy77yMaPVINZLAflgHf7cQUaeifRnbY6vR3hKLqGH2qKd4z4Iy9cb3W3hRw==
X-Received: by 2002:a17:907:c16:b0:ac2:9683:ad25 with SMTP id a640c23a62f3a-acb74b8ceb3mr306553066b.34.1745005147579;
        Fri, 18 Apr 2025 12:39:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef4798fsm156084266b.151.2025.04.18.12.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 12:39:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] selftests/fs/mount-notify: test also remove/flush of mntns marks
Date: Fri, 18 Apr 2025 21:39:03 +0200
Message-Id: <20250418193903.2607617-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250418193903.2607617-1-amir73il@gmail.com>
References: <20250418193903.2607617-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regression test for FAN_MARK_MNTFS | FAN_MARK_FLUSH bug.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../mount-notify/mount-notify_test.c          | 57 +++++++++++++++----
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 4a2d5c454fd1..59a71f22fb11 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -48,8 +48,16 @@ static uint64_t get_mnt_id(struct __test_metadata *const _metadata,
 
 static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
 
+static const int mark_cmds[] = {
+	FAN_MARK_ADD,
+	FAN_MARK_REMOVE,
+	FAN_MARK_FLUSH
+};
+
+#define NUM_FAN_FDS ARRAY_SIZE(mark_cmds)
+
 FIXTURE(fanotify) {
-	int fan_fd;
+	int fan_fd[NUM_FAN_FDS];
 	char buf[256];
 	unsigned int rem;
 	void *next;
@@ -61,7 +69,7 @@ FIXTURE(fanotify) {
 
 FIXTURE_SETUP(fanotify)
 {
-	int ret;
+	int i, ret;
 
 	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
 
@@ -89,20 +97,34 @@ FIXTURE_SETUP(fanotify)
 	self->root_id = get_mnt_id(_metadata, "/");
 	ASSERT_NE(self->root_id, 0);
 
-	self->fan_fd = fanotify_init(FAN_REPORT_MNT, 0);
-	ASSERT_GE(self->fan_fd, 0);
-
-	ret = fanotify_mark(self->fan_fd, FAN_MARK_ADD | FAN_MARK_MNTNS,
-			    FAN_MNT_ATTACH | FAN_MNT_DETACH, self->ns_fd, NULL);
-	ASSERT_EQ(ret, 0);
+	for (i = 0; i < NUM_FAN_FDS; i++) {
+		self->fan_fd[i] = fanotify_init(FAN_REPORT_MNT | FAN_NONBLOCK,
+						0);
+		ASSERT_GE(self->fan_fd[i], 0);
+		ret = fanotify_mark(self->fan_fd[i], FAN_MARK_ADD |
+				    FAN_MARK_MNTNS,
+				    FAN_MNT_ATTACH | FAN_MNT_DETACH,
+				    self->ns_fd, NULL);
+		ASSERT_EQ(ret, 0);
+		// On fd[0] we do an extra ADD that changes nothing.
+		// On fd[1]/fd[2] we REMOVE/FLUSH which removes the mark.
+		ret = fanotify_mark(self->fan_fd[i], mark_cmds[i] |
+				    FAN_MARK_MNTNS,
+				    FAN_MNT_ATTACH | FAN_MNT_DETACH,
+				    self->ns_fd, NULL);
+		ASSERT_EQ(ret, 0);
+	}
 
 	self->rem = 0;
 }
 
 FIXTURE_TEARDOWN(fanotify)
 {
+	int i;
+
 	ASSERT_EQ(self->rem, 0);
-	close(self->fan_fd);
+	for (i = 0; i < NUM_FAN_FDS; i++)
+		close(self->fan_fd[i]);
 
 	ASSERT_EQ(fchdir(self->orig_root), 0);
 
@@ -123,8 +145,21 @@ static uint64_t expect_notify(struct __test_metadata *const _metadata,
 	unsigned int thislen;
 
 	if (!self->rem) {
-		ssize_t len = read(self->fan_fd, self->buf, sizeof(self->buf));
-		ASSERT_GT(len, 0);
+		ssize_t len;
+		int i;
+
+		for (i = NUM_FAN_FDS - 1; i >= 0; i--) {
+			len = read(self->fan_fd[i], self->buf,
+				   sizeof(self->buf));
+			if (i > 0) {
+				// Groups 1,2 should get EAGAIN
+				ASSERT_EQ(len, -1);
+				ASSERT_EQ(errno, EAGAIN);
+			} else {
+				// Group 0 should get events
+				ASSERT_GT(len, 0);
+			}
+		}
 
 		self->rem = len;
 		self->next = (void *) self->buf;
-- 
2.34.1


