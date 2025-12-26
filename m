Return-Path: <linux-fsdevel+bounces-72115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C424CDEF4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 20:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41A23300C0DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 19:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7E028727F;
	Fri, 26 Dec 2025 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkNY0ZuB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA16262A6
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Dec 2025 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766778924; cv=none; b=Fcup5KjPkyuzSPkRfIEEmv5n06Tetgz7mzmJpwyh2zJSrVjLpAzzM2/C44gdxGHp3alORGHuTJ9Y9QTTPpo06usrD0vTVMRclmPI9V8uXlelxbBTwOvQ1eojMZFjbE2SpexfHT4YWq7J3nMWqCHdZx/cXKJXuzmLhTVKzEzNt9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766778924; c=relaxed/simple;
	bh=ZU38XeCif5tuTS4ZfH+Q2ZiO58tegHG1exLCpKCd/xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDQfJ7UQjhuoTRy+16FbiQM0+sLExAb8cCPnwzTs7Bf31yd5TgBwG489+PFiT2S31ZUB+u8zX2JyDWO1doDvrwloVwYmI954t0JM1qNEqrmb+uT3ulx0OHzF4lEApsNYWtbkpNi9v4SJd0rdMu+4H60ZRjSBvwpNPv/pHb3og/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkNY0ZuB; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37b8aa5adf9so46950811fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Dec 2025 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766778921; x=1767383721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=abY0cIdNyzl9Nj5XC0+CbTQ9OYK/WyLhHUpR5rFZc10=;
        b=LkNY0ZuBYTJvHiT1YUB4KORNIELTjRfPi6a4PokpyGky4EP+tGt0oM/Ccf51ykOOQm
         InjQAa/a/Xf3pSwOh1l+XU7CM9Cl0j5bQnScOEBl2O2DyU8tQXehp8nCbP4n90DmnO/F
         uH3JnMZwCULOdT6Agd2tF3wbJQWcj3wLGvmD1yj8EUVl3DwxeYim7ES1GBjg1t+HhEvg
         xzRO4lFxXtLekPC9iPYyGxLVu7kgoa3phJvLTdGqfiZe+hXZUTfEezZVAUtOtmXO3C67
         gRmuSh6AT0CstCJVIMmlUrG0w2ejwtXBRSBNaMvjT0DCEqDYDfh/0Igycp03mnHvoEOH
         6PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766778921; x=1767383721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abY0cIdNyzl9Nj5XC0+CbTQ9OYK/WyLhHUpR5rFZc10=;
        b=T637f9y/kb4sSvao14JAwM5C49HgvT5/KfwdeNNrsG1ArqOYovP1AP3e/XGulJFZko
         z41BotkgtJzn++ks9jydu1tY0vGgYjAceWqEAet6mmHlSZ5oyY638vMRmj1p9+LHdtRj
         N1rF13Dhck/0ITcsuPNwKVOCwn4a5uo1NXWyZNfY3jmUFudxiPehmmh6DZfJ7gxooUf9
         Uz5hdB/urRYGcFl0voy2OYUlD6alBGlLxf4tyMWrpJLNsVbg+ZE4EMQO8gFBr69Lmxv7
         5KoKo3J0kMNFrRU6CHcOWjOzMCaHD+b6nt9xAh72hKr3OWbAQHG0mxQdYjSUKJg1c3VV
         fFwA==
X-Gm-Message-State: AOJu0Yxl2w/J9aGtum6AZycH+psMzUY/DEMxdfBaqpI8oUc353ou1Y5w
	3k6omTxoP0+hk9o1SNVNQ6cAR3k+NYqEh0q3WTQfF0SOX7use3Tks+XrMVJq
X-Gm-Gg: AY/fxX6B4epR2UX9/KLiwrhx9/k5Ei71RDzSiHTovs5BCuYuFz08fi7QMduNHAMbQLp
	EZW4wAQdUSN3BhKoV2fqi6xeeorerRCSpVZoECIC/faYTzhFruXovsNcgFVak0d12ub7Y640T5n
	TsqW/UR/7r1Jxg09j9ueogQDwu6cqxn+3HQF1An+VR5gfdGEUDf1AFG6g7GtbcvW3TvdNlu9t/N
	rzUM15wEeMLiZ41cUZM8u+yeHjdf7H9ru3zpDQVd2bf9ExL6a2YFs/6IT87dwh50Yy/WCK0vktd
	dtMH2avA7ssKOZk3dlMif6pHu2qs/wPxa/DmmnCln1sE1W2+RLsC0w+Sd2KSbypa7TVV0zeg5XN
	1tLTrWQClH6Zok9IiVDJ3wh4FSHzCU+0Yv55iKOCwdOc/Bs1tTAzmlAAZFOfSlfnWJS7mD555Rk
	g=
X-Google-Smtp-Source: AGHT+IEgTBrzEnLoIDcx36Pq8trTGMNrecg+gdjousrbTD8YDCWYG4mpTBcwCRWM0B6SwbCDWGAQkg==
X-Received: by 2002:a05:651c:1506:b0:37b:9101:77e6 with SMTP id 38308e7fff4ca-381215699edmr71348641fa.15.1766778920347;
        Fri, 26 Dec 2025 11:55:20 -0800 (PST)
Received: from p183 ([178.172.146.10])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812251cfffsm63088951fa.19.2025.12.26.11.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 11:55:19 -0800 (PST)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adobriyan@gmail.com
Subject: [PATCH 1/2] proc: add tgid_iter.pid_ns member
Date: Fri, 26 Dec 2025 22:55:34 +0300
Message-ID: <20251226195536.468978-1-adobriyan@gmail.com>
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


