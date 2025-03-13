Return-Path: <linux-fsdevel+bounces-43895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00322A5F498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 13:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59683BBEFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4229267735;
	Thu, 13 Mar 2025 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Thytij6K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA8267732;
	Thu, 13 Mar 2025 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869134; cv=none; b=EjRtmLk9YjHDQtFp2S1hAXLBOtO8BftCtxvBx5H3xhhWA01rKGf8uE/RhV7Gd8IEkuEPqB9IFoL9H1KduBO7No5rul9eNVOakm5TS/ydkyXq/z83FxR7wJiybrQ24CUWJZBCRh67K7a7SzsIhx5jD4YztxghATH34ZZZVWyxEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869134; c=relaxed/simple;
	bh=DFcGV4dDf3WrDVpX2Hz1fzaUVJp9RjoslPNIEWS7xgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XkATDtQr/kmU6TJbRXCGMj/zxKUBpeYuA2SR6FrX65Rc01+D3A5m9FcfNOYLrru89/oZXHqWqmMSwsCONMtUXlJjesKYGYtHwB8olM6JRM0df9+4SrwGBfLvc61iagoJaBQan3HGE8xrSRGcP+gCLIp58a+ZGj/SIRD3nIced+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Thytij6K; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abbd96bef64so159344566b.3;
        Thu, 13 Mar 2025 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741869129; x=1742473929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ypGjCzC8WcsF3XlDEM9BvDah3xbE47+gOREZ4fcYUI4=;
        b=Thytij6KjuRzDrPgwzYcdsakQVNCpuE61ploZnRfQZpzY4f4nFeLvBgfD3l+cg0CTH
         ZZ7mEtB3QeK3/sBF3scSb8oR281KDdArfqBQJ8CEYV/02XKZ73IRjvCNfU5QpMLbujxR
         8aoXPvO2FKw380rnsyQUQ23npb89TkJGXIMs9uvcWTZf/Gffz3yd9ZsQ3vkP1VfMzJLi
         OyhL3hqvluUPtQ8NJqCedtOFtyEyKR5iSrpQFJX0EvZbe91/uYdxCURTIqP+PNuEzu5z
         Um2Dv5+AtZ0oM3eYrNYkDM6/annsPSGXSdodq+rjtmqwtQxDGI4x7Vqx6YjoIx0xRLJ4
         4NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741869129; x=1742473929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypGjCzC8WcsF3XlDEM9BvDah3xbE47+gOREZ4fcYUI4=;
        b=V9Fzy4lNuIPQ5DfLx0Fz5jmv1dIgVvrCNsQw/K09PYYPLcFaAIRQQ54BwP4twkr5Oj
         3ha3s0aUTgZb0BvrQl47UED+iTxpCn5rOXewacIsg3Pu/mV77c4WigF/Jamt4/Atb6Qh
         QTzOL+rNj6fbM9/lSFpxWqS2WrftHgVkFpnusvxNxFegCPN2aCfYmAX9zjLdTFr4dwCM
         Du4se1zfxcoHOlBP+0GwFiR/4kg2aMJfHKYaRpHFQqN8xbHzjbpxUOhtEErdr1GuUrhr
         Rkktx3AEH3zqiGRZ+nMNbW8CWQGC0oM7CEvoD2sioprG87Jt/69UY92ueu/pBBpEPUP9
         pp2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtz8TrA70+nrOSBFH4V3Qlq4umcct3MhMeavC1bVsxv7Y7FoYpI+3m2nljClr+LeUsANZjTfRHnmugjiO2@vger.kernel.org, AJvYcCXdj0I7b3z88FzxJEFHRhmW1juG255Plcv/Vf4Jeugfr9/Q/Tf6nFKccjncbOV6J+Dgxi7nbR3x2Y6/J6Vb@vger.kernel.org
X-Gm-Message-State: AOJu0Yztk4vsnsPmKBJhz5ZI3WICxkEIZX2kwjsbJ/CI4BYSyhoy4DsK
	rids5pk26THnwbwqCAQ9WMzPfc6htobEa9WAyktJsD25c+YTWyCU
X-Gm-Gg: ASbGnctXgz+SVA9RuAF8qwaU4t1R9YUIQWoUH0DMPg/YDvFpoT83b0VbQvphf/9wR5K
	TnN1mEsBNqsJiA4vcCNVBCjzg1iIrvIR2nP0pEh0//W8nvE4nQZy7UIvPp4DfWV/MNrOe6ed5vq
	q6vC+2XwjgZLxETrSApONm/EJzEAde9EfbSnrvDDN3z/6zmnDdFS9osCNzt0vDuyl3dzH4dY3wM
	luQ+GDMLxNGQtXT6pUBASPZ1NtsQuHZUyLnqnHcdSxIJODwmdW/DTwctLMUiVqql0lwPMjYNP8C
	GhlljAYDDu1Hd4J0s6h1rVR1j3LksIU8dgMQ+1iXR8QlGOiyHJ4WPngRifqXVkA=
X-Google-Smtp-Source: AGHT+IF2k9qUbXH0a2fxBc+vT0RN2wfIag+tbV+drGxaCwIRCJb6dO5efBpFU1UksM/1X5KhhLPKuQ==
X-Received: by 2002:a17:906:cecb:b0:ac2:8118:27e7 with SMTP id a640c23a62f3a-ac2811831a3mr2440897266b.50.1741869128433;
        Thu, 13 Mar 2025 05:32:08 -0700 (PDT)
Received: from f.. (cst-prg-90-242.cust.vodafone.cz. [46.135.90.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efaf4sm76490166b.61.2025.03.13.05.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:32:07 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: consistently deref the files table with rcu_access_pointer()
Date: Thu, 13 Mar 2025 13:31:59 +0100
Message-ID: <20250313123159.1315079-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... except when the table is known to be only used by one thread.

A file pointer can get installed at any moment despite the ->file_lock
being held since the following:
8a81252b774b53e6 ("fs/file.c: don't acquire files->file_lock in fd_install()")

Accesses subject to such a race can in principle suffer load tearing.

While here redo the comment in dup_fd() as it only covered a race against
files showing up, still assuming fd_install() takes the lock.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I confirmed the possiblity of the problem with this:
https://lwn.net/Articles/793253/#Load%20Tearing

Granted, the article being 6 years old might mean some magic was added
by now to prevent this particular problem.

While technically this classifies as a bugfix, given that nothing blew
up and this is more of a "just in case" change, I don't think this
warrants any backports. Thus I'm not adding a Fixes: tag to prevent this
from being picked by autosel.

 fs/file.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 6c159ede55f1..52010ecb27b8 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -423,17 +423,25 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	old_fds = old_fdt->fd;
 	new_fds = new_fdt->fd;
 
+	/*
+	 * We may be racing against fd allocation from other threads using this
+	 * files_struct, despite holding ->file_lock.
+	 *
+	 * alloc_fd() might have already claimed a slot, while fd_install()
+	 * did not populate it yet. Note the latter operates locklessly, so
+	 * the file can show up as we are walking the array below.
+	 *
+	 * At the same time we know no files will disappear as all other
+	 * operations take the lock.
+	 *
+	 * Instead of trying to placate userspace racing with itself, we
+	 * ref the file if we see it and mark the fd slot as unused otherwise.
+	 */
 	for (i = open_files; i != 0; i--) {
-		struct file *f = *old_fds++;
+		struct file *f = rcu_access_pointer(*old_fds++);
 		if (f) {
 			get_file(f);
 		} else {
-			/*
-			 * The fd may be claimed in the fd bitmap but not yet
-			 * instantiated in the files array if a sibling thread
-			 * is partway through open().  So make sure that this
-			 * fd is available to the new process.
-			 */
 			__clear_open_fd(open_files - i, new_fdt);
 		}
 		rcu_assign_pointer(*new_fds++, f);
@@ -684,7 +692,7 @@ struct file *file_close_fd_locked(struct files_struct *files, unsigned fd)
 		return NULL;
 
 	fd = array_index_nospec(fd, fdt->max_fds);
-	file = fdt->fd[fd];
+	file = rcu_access_pointer(fdt->fd[fd]);
 	if (file) {
 		rcu_assign_pointer(fdt->fd[fd], NULL);
 		__put_unused_fd(files, fd);
@@ -1252,7 +1260,7 @@ __releases(&files->file_lock)
 	 */
 	fdt = files_fdtable(files);
 	fd = array_index_nospec(fd, fdt->max_fds);
-	tofree = fdt->fd[fd];
+	tofree = rcu_access_pointer(fdt->fd[fd]);
 	if (!tofree && fd_is_open(fd, fdt))
 		goto Ebusy;
 	get_file(file);
-- 
2.43.0


