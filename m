Return-Path: <linux-fsdevel+bounces-72119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F90CDEF66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 21:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D425D300D176
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3102765D7;
	Fri, 26 Dec 2025 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3YJkyL5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A5821FF30
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Dec 2025 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766779387; cv=none; b=UST4QHQhas+COEbr9/MGX438inDfjW3+ssM9v8JLUuMyNAZ0nHFYIMWwUHt0+mgPyckeUOX6iA6LDpU3yg8/f+GNVngsoL71dI33qHbqN2BbCBfWa7R3lyFxijxc9RdGhkcRGhfm8uUK+t/d2tFPGYm6YuRuc4GKoa7A6d32zQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766779387; c=relaxed/simple;
	bh=ZU38XeCif5tuTS4ZfH+Q2ZiO58tegHG1exLCpKCd/xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E5HO7MAAnm6E4ShDvcUVNsb4p+GiOtLJLippLgrBFBcmZ9Pm+ZPgmVHAV87CyZKD5RNmOGUlNGJnuUh5ix5YuROzCAc6N3l54C87U7/Thv8EUZ145A/3axoPL0qs4RO6dcaO6YeFxHvhXYb7kWugpRUGciZ+wZMqy69OYcxRX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3YJkyL5; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5957c929a5eso10761087e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Dec 2025 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766779383; x=1767384183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=abY0cIdNyzl9Nj5XC0+CbTQ9OYK/WyLhHUpR5rFZc10=;
        b=S3YJkyL5WcZLPk7r1EJZfxNqFnA0qgtzyFZmDun4+itawnYWY85UUXL0f++lFHrYAd
         f7JYxPUKphljMMPZKuGHQwxgUq7RcmXc670y1NGxVaif+QPjNSaLuLuzx3xVt9JlTajI
         uMtq5AXyH+FtrXwf3DusKgg8XVQNhcUgViyFJkEAWnowPjRWHGCu0CuvbVE5JzRjowRD
         zSWe0PAjPPpcFq3a/cwVHReVWD1IWset9PEAz4iq79YUdtscj5ocUss+rbJQyPOCA9iz
         pMEZDOptZYdDEx2e7N8RIvryHhYwcdgPMpGeHPH1Ppsq+cilLCkPVmNsBBAa8k+O2wmj
         NSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766779383; x=1767384183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abY0cIdNyzl9Nj5XC0+CbTQ9OYK/WyLhHUpR5rFZc10=;
        b=ZJui6ve2iCPZYhj9CvQBfYR5V9/jFNqhNJ8HeoflbuY70/S8ipcqHfrtPgbCniWiJp
         erJXmD/P1NPV2i0lvJqO6oqz/Gcp4kaNtR6yV+/0cnEGHzslmLvuN0ecqCO7cde5We8j
         YwWAQV1cFs0yhiciTWppl+SuKs4F5j/neXAbWVZeh6SOKGKPTg26nwNRC3lbs6DyqCUK
         ul8NglY4/u8s59C7tUyzfsBv27JOnUTNNvNDvABjb3MiN0b5uYLDiyybD/lWOof6QwTF
         PCllVe18zCB2oSuMLumyNPMTHMnpTKnYvM1hGQESD+JGYhtySK09InyOIBMlKuPMSrHS
         zHUg==
X-Gm-Message-State: AOJu0Yy+wqk0ZFvO2LFETN9mUPgBf1SgjF4KYrtQQ8AIUBdK7PKreI/1
	Qt3lvGNIrpixzwgQ3RNzdP1j4qytTIOHrYpz5kvj5GXGfvJt5A29yiY=
X-Gm-Gg: AY/fxX5weGXvUN++whK7S9S7BspTg6NjqQECKZQaR5NN/dJqYePBLD022BD501WzAba
	PvVM8zJF/yCa/x8/k32Vs3/l3FcOl/PQWy8WCaf8SjBme/H3AAwC1VvpeTRRkhiKSi32n1FTWwY
	sHf8l3hl53o+DnmJ1dzfCi6z+JNRVpFkgmKUguqWsGShD1bgGzjZSOl95LIX6DVR+5QlEDrKHim
	Xi9eMLxAvJZJtXwfFAaGQN04CIr66+E467tbcs6SLvd6EdbcGepVPgV36ieKpbawjZwZ1Ws7o0S
	fy72X7Hjw+EoFHWjgv/JoMevEmgHue92y8T8pjfpf/aJfsq4d3y++eVskiQlZMT8IUJFxTczWeW
	uU81pSU6EusRkqVrn1klKZtI7cgcFouz88ioMPxbHj3DeCydV9+0VNgCz0LG2nTk3hdJQm/mFxy
	Y=
X-Google-Smtp-Source: AGHT+IE1tTn2p10oHObcJC0IG69ts/8vecpqRuNgNxyB/Vlp2j/6jVeN2q20NFtdGj5ceCbKCDRKYQ==
X-Received: by 2002:a05:6512:12c8:b0:598:faf6:1009 with SMTP id 2adb3069b0e04-59a17d681ebmr7191231e87.53.1766779382852;
        Fri, 26 Dec 2025 12:03:02 -0800 (PST)
Received: from p183 ([178.172.146.10])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185dd7c8sm6705593e87.26.2025.12.26.12.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 12:03:02 -0800 (PST)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adobriyan@gmail.com
Subject: [PATCH v2 1/2] proc: add tgid_iter.pid_ns member
Date: Fri, 26 Dec 2025 23:03:21 +0300
Message-ID: <20251226200322.469738-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

next_tgid() accept pid namespace as an argument, but it is never changes
during readdir (which would be unthinkable thing to do anyway).

Move it inside iterator type and hide from using directly.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/base.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4eec684baca9..7c1089226a47 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3540,8 +3540,10 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 struct tgid_iter {
 	unsigned int tgid;
 	struct task_struct *task;
+	struct pid_namespace *pid_ns;
 };
-static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter iter)
+
+static struct tgid_iter next_tgid(struct tgid_iter iter)
 {
 	struct pid *pid;
 
@@ -3550,9 +3552,9 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
 	rcu_read_lock();
 retry:
 	iter.task = NULL;
-	pid = find_ge_pid(iter.tgid, ns);
+	pid = find_ge_pid(iter.tgid, iter.pid_ns);
 	if (pid) {
-		iter.tgid = pid_nr_ns(pid, ns);
+		iter.tgid = pid_nr_ns(pid, iter.pid_ns);
 		iter.task = pid_task(pid, PIDTYPE_TGID);
 		if (!iter.task) {
 			iter.tgid += 1;
@@ -3571,7 +3573,7 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct tgid_iter iter;
 	struct proc_fs_info *fs_info = proc_sb_info(file_inode(file)->i_sb);
-	struct pid_namespace *ns = proc_pid_ns(file_inode(file)->i_sb);
+	struct pid_namespace *pid_ns = proc_pid_ns(file_inode(file)->i_sb);
 	loff_t pos = ctx->pos;
 
 	if (pos >= PID_MAX_LIMIT + TGID_OFFSET)
@@ -3589,9 +3591,10 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 	}
 	iter.tgid = pos - TGID_OFFSET;
 	iter.task = NULL;
-	for (iter = next_tgid(ns, iter);
+	iter.pid_ns = pid_ns;
+	for (iter = next_tgid(iter);
 	     iter.task;
-	     iter.tgid += 1, iter = next_tgid(ns, iter)) {
+	     iter.tgid += 1, iter = next_tgid(iter)) {
 		char name[10 + 1];
 		unsigned int len;
 
-- 
2.51.2


