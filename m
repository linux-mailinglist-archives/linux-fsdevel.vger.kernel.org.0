Return-Path: <linux-fsdevel+bounces-67657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 188D3C45CA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9B4E4F0A53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FDD30103C;
	Mon, 10 Nov 2025 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI6LVB4O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27D30170D
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768603; cv=none; b=tABZ4oMkgremutWqj0GBCcIjbrEeWXcX+XnqHQMKGKcECyh386PjuEoJ5puDgTaFFRiepmAJuUe8nnktQsxy+oSOFT98Xr8YoeJpzJg4scJx57vqknrdPy01hxbLfvmJUNEIgnViO3CpVCy43gTUcaER+6YtRbcIaOpA3eKc/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768603; c=relaxed/simple;
	bh=E4pObGjbO5Pdzkea4D/ehF/Yidsew/tPtBkhIyRPUic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDPI/VjzToZiotaGKEN3QsNf2tlsFcv7XOHh9s0AUcnV4VHYg1k0GUofTp9ud5CrEkGw9ebCwUQruD1NOFEf3NOqLRuK/FR0frElqmKRUGtSLhr9ctIgr5N+t6DwCt/Y6R84VKtBVux05upo7jCoV7VDslflHwT/56SGt2X1Vbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI6LVB4O; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so4795948a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 01:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762768600; x=1763373400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OalheUhAzvO+fY3ksPJYrAH3VrSZlCzAqAQZjc76Aoo=;
        b=jI6LVB4O1PURkNTFHDjkR04JTpwNuO10Oxjmj3qYk3n7t4FfIfps7tyjRdq9vvc8x2
         SNxCH+TTlPHN/OSvB+EG2Tbf/U6zNd3YQ4mcvPusBl3/gGbLvYfuUFsEnus1lu0TcO69
         j7lDZj2l+8JKmXNcFtXEz+zRWZvgKlyYqIh3ZXkybOgkL5DuVySViJPFoAeH79DxbwfH
         rszPKRGzL5rV0WPX5Q9St2qgDdlDjDIZIWCF64nBKrIIWFHr3bciA0hJOcAaoe33E5yA
         pd3mTK1CVQJUmCKq8K+HaEh9JBZtX8Nlml+c2MOHHhj6jrMCk5RHLOCeBbi59bg3UEOz
         T31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768600; x=1763373400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OalheUhAzvO+fY3ksPJYrAH3VrSZlCzAqAQZjc76Aoo=;
        b=ECRumkj7+amagrr4q4M0QAGLusSerM0btSQHGrALJjTiK1Q3yu2aIWULzPkr3V+gbg
         NZZeWxgSpqqdSVvRGP5JaN+rCgrW3iFtB5Dy18IabU8sjoaP/Q8Zi2jxp7saIRi1yuos
         Rhp7n7bc/djGvj+02K0kap4r2zWTgAQgQnHwliMUMEuKiJO2gkZnsgBlgOFHYKQho5Jy
         B6UQHcrBztujHAOtl4R9IgZ0JNK5stoMW8HVqpAuDhxXu640mqWGk+McCVxp4C23x/YX
         Tnlyn+UrDJUM7oCf69v4XfCxee+ceBUrzjfjnvvs/zH4LHImGkL8PETQRrZdyDhqRuZg
         QYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC4LqRBlKqNh/XtAD5RcKvjKSbs95JDiUJvdouJeDoibncqF8bJFmb9bAdzzyfrGbCnLWuxj0jIWCUIZ3H@vger.kernel.org
X-Gm-Message-State: AOJu0YwHsDsdfZ5eJ69VcdGnscVnuIU3AY31XNPfqXsSrWfIwrKIXGjy
	n/p7sePeK3vMZwf/XAGmB0id96KIcNkK/UHR5d2hkfzV9ajzBlxZWLrL
X-Gm-Gg: ASbGncumlWWLC43vohyJM6MpGrUKTaFdli/i8uCEC6HYrb9XAyMrhlmBZPGGX2WzyO2
	NiFZf9xjccuVLfAQHafjGHkn+SjyNTVguUkbsygcgh3eSnGDoQWqYZ3sHJURATLZJIl/TtQN+MY
	TeK1d3nrpY4H9Nj9BofnjuMXeKFoLQ34XTp3pPKaSC5NUW1WafVg/mZE7vRrG5eSUcgQ59EpuP9
	yiCnE6oTtYrfnvI29U9Mk7/NYxKB9FWkxN+Timyur6diXvSObidOXumx2WTPclKiICVXhHiIi6A
	eWKe2lZo8LshXaXLdUzbKwatW+QIJhHgsRge5G4Pd0jSw0bmSqMGKYHK0deCgVz2s/XNAULUrqF
	Gg5OJ9njUCqJJGO/FJg4BCCv1tcqyifm+F1E1TSlkVcKkL/LafYr3crn+5xbvgJFTGc/u4DP3YH
	r4rOwrtUiGRLl+9+1H3n9aGNfxvfbTaUaMlbvpw9BVKYR01diQ7CCdf6M3VKk=
X-Google-Smtp-Source: AGHT+IFNHer3HaDaC/ny8jCZ0wS9HKEBPDeqIF/OoQAp1HIY+fQ5eyS5SL9VCxxmqxgG+VZJ7cxQPA==
X-Received: by 2002:a05:6402:848:b0:63c:3f02:60e7 with SMTP id 4fb4d7f45d1cf-6415a284631mr6384838a12.17.1762768600167;
        Mon, 10 Nov 2025 01:56:40 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6415b69c366sm6648866a12.23.2025.11.10.01.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:56:39 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: move fd_install() slowpath into a dedicated routine and provide commentary
Date: Mon, 10 Nov 2025 10:56:34 +0100
Message-ID: <20251110095634.1433061-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On stock kernel gcc 14 emits avoidable register spillage:
	endbr64
	call   ffffffff81374630 <__fentry__>
	push   %r13
	push   %r12
	push   %rbx
	sub    $0x8,%rsp
	[snip]

Total fast path is 99 bytes.

Moving the slowpath out avoids it and shortens the fast path to 74
bytes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- keep rcu_read_unlock_sched in fd_install

does not alter the fast path

 fs/file.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 28743b742e3c..3f56890068aa 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -641,6 +641,34 @@ void put_unused_fd(unsigned int fd)
 
 EXPORT_SYMBOL(put_unused_fd);
 
+/*
+ * Install a file pointer in the fd array while it is being resized.
+ *
+ * We need to make sure our update to the array does not get lost as the resizing
+ * thread can be copying the content as we modify it.
+ *
+ * We have two ways to do it:
+ * - go off CPU waiting for resize_in_progress to clear
+ * - take the spin lock
+ *
+ * The latter is trivial to implement and saves us from having to might_sleep()
+ * for debugging purposes.
+ *
+ * This is moved out of line from fd_install() to convince gcc to optimize that
+ * routine better.
+ */
+static void noinline fd_install_slowpath(unsigned int fd, struct file *file)
+{
+	struct files_struct *files = current->files;
+	struct fdtable *fdt;
+
+	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
+	VFS_BUG_ON(rcu_access_pointer(fdt->fd[fd]) != NULL);
+	rcu_assign_pointer(fdt->fd[fd], file);
+	spin_unlock(&files->file_lock);
+}
+
 /**
  * fd_install - install a file pointer in the fd array
  * @fd: file descriptor to install the file in
@@ -658,14 +686,9 @@ void fd_install(unsigned int fd, struct file *file)
 		return;
 
 	rcu_read_lock_sched();
-
 	if (unlikely(files->resize_in_progress)) {
 		rcu_read_unlock_sched();
-		spin_lock(&files->file_lock);
-		fdt = files_fdtable(files);
-		VFS_BUG_ON(rcu_access_pointer(fdt->fd[fd]) != NULL);
-		rcu_assign_pointer(fdt->fd[fd], file);
-		spin_unlock(&files->file_lock);
+		fd_install_slowpath(fd, file);
 		return;
 	}
 	/* coupled with smp_wmb() in expand_fdtable() */
-- 
2.48.1


