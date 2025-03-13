Return-Path: <linux-fsdevel+bounces-43901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80639A5F714
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 14:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3977919C1839
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D2E267B62;
	Thu, 13 Mar 2025 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFXDZy9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7734D2E3366;
	Thu, 13 Mar 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874257; cv=none; b=N+FgOgdnTsSJdN0VatuLGPzMxJ1fW86aE43b54wuBv/5u0Ax8viLmdGfbfAR6xb++tcmPH6qkFgkvtPciAEusONTXVt/FwimR7NKfkmKL/ltZzmLqnAyBa4qzDr6huaV7eBNl5sqmq9k8Z1kbe8bL1BF+EwVbVcF6M//pD4rjLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874257; c=relaxed/simple;
	bh=DLhdMLDCZ73yAePjjb/7mUh8NxxMFNMkE9CVvGT2MkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMvJGkYy0AJUH2+LTk7SGccXKnr9FLZO0M5Lg7d9YqU1y0WfzIceUsY1/qAm+FC5M3CVfPPg9v5pbvEI2zU600B4BkWqHBlMT2ggQEJvF9Xi3bjFM7dAGfpSiy1iPRaGTh9o2D8FyRhB6XSeM6cEs6AsMI+d3MS3Xn+OjRiPRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFXDZy9U; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso1218269a12.2;
        Thu, 13 Mar 2025 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741874254; x=1742479054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3C6MvGOiTRxWRu0SbR4M4R9huU60gsGYQ5fIHw+vGNM=;
        b=kFXDZy9U6kIfwz5uBqv771ya78rJKthaQ6hGux7/mSrLdt7fWN1k+nb2tqly1gZHA3
         i9ozyNbuZuM0CyQxLLLAZRgBupYE5za+oxsSIt0Ovyxy99BuGs+gmVWJ68Yhn7JLAI5Z
         KelyoqbMy43sPh4zNRVVkqpT2+peVaCtXgIGw4BV6ixX26pwQV59KzVMn7SOLAMJBHgn
         vdmonjYJBJtMM4Nzkz7cjejRuUcNYmu8NdW0PDp/KGzpua1gPtXHcGzKdkdGE5QPJVwB
         vtCNMXDeApeaSbBczM34mZ8P/d4ca8PrbgdR3AfsYXYEu0ryWsyxYfHfnlPsbQFWXeuE
         lvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741874254; x=1742479054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3C6MvGOiTRxWRu0SbR4M4R9huU60gsGYQ5fIHw+vGNM=;
        b=AAuXUWytcSM8lpVhEswSuu6UR8x/aROgwVBj/N/bep1SLD4y3TvQwFW66CpcAfz6gc
         myAfh9oJIgPTR9b6TZ5ViMV69rZwlXFxVw9jeffD0SAU+tebQBMpf923Q/aOVPSxgWhL
         vm/M9yCHImmV0PwF+7UF6bfQywQLzeti9rZHtrYlXDpLKo0pJ2n7+xrMkNpGmLr/lfAv
         qe4EZidBOQ2jrQ78RyrEM6TCy8EP8Li9b1TlnAphhCuFZ9+R+ydOF23A/9hICGEIIoAD
         LYpJ1tD8PVvC1pFIHwu5Ia9oJSkfg43e2X/L+42fpxhf63v0JivP0dl8htVkKHZRXI4Q
         e1rg==
X-Forwarded-Encrypted: i=1; AJvYcCUTX1/dRsg1pdErBnzWb1W/4xDZtUxvgfhXPwUt8qGJUmPB4inqTPgUoqHw3yBikSHBNMP7/NoWIGOIx2Xi@vger.kernel.org, AJvYcCXODw4eg0+PCR7ZvTzhExviDOvWGneSO8HClidrqLpYF+qeNzQp0XMKH2RSWLcZx79YxHvU0GX8YRRHLZHu@vger.kernel.org
X-Gm-Message-State: AOJu0YxP90CYFUllSna7PZ3gLaE87+Pd+OON3AWfxsoa2DVoMcpGak1q
	Vga4wt4EcB6FtIGHfW49AR/L2SWxhhhcDAu6fCqfv5oX8aX/rHBR
X-Gm-Gg: ASbGncv06D75L6+jz4BgIBgAc8Jdal3ktoCewM2/fEaR6NQ7XgWMt6TgKlVQdMdRZpv
	lSG1afbbUPUyfGUjMiFIoSHMs/hwui0O9yxO0asQ+YUJP69uUrIrTrSRmGrs8/L/oiHV5S6kyk7
	uXGH0uhYXNYH1WfC3ZBLEiXNxJHpuHtHzAoAkRvBXUb1u7+nV6sHLrtgnACTNRMWG+jKXGW7YL3
	PWzMMHY75ULQ30fDpbHjRG2clMDTEBuIOOlmp9tNBljwqAkcKqUKCy4XrF4FVFlzg4v2A8sxUIS
	JyASQBsjYleJRqSdDN0YR4T8SwAsC7Sbfg6Bi2sa3Dg5loBfMv08MgnWwg3cNTM=
X-Google-Smtp-Source: AGHT+IFTSYm/DNS4AaQAvsgnUraYtTjUiIkJZHr41UqEt7kAOX90x8URH7OuDcPRdqHQyVA59ibtvg==
X-Received: by 2002:a05:6402:42c2:b0:5dc:7374:261d with SMTP id 4fb4d7f45d1cf-5e5e22a3716mr51358629a12.7.1741874253310;
        Thu, 13 Mar 2025 06:57:33 -0700 (PDT)
Received: from f.. (cst-prg-90-242.cust.vodafone.cz. [46.135.90.242])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816974900sm753210a12.25.2025.03.13.06.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:57:32 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: consistently deref the files table with rcu_dereference_raw()
Date: Thu, 13 Mar 2025 14:57:25 +0100
Message-ID: <20250313135725.1320914-1-mjguzik@gmail.com>
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

While here redo the comment in dup_fd -- it only covered a race against
files showing up, still assuming fd_install() takes the lock.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2: s/rcu_access_pointer/rcu_dererence_raw/

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
index 6c159ede55f1..58ff50094525 100644
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
+		struct file *f = rcu_dereference_raw(*old_fds++);
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
+	file = rcu_dereference_raw(fdt->fd[fd]);
 	if (file) {
 		rcu_assign_pointer(fdt->fd[fd], NULL);
 		__put_unused_fd(files, fd);
@@ -1252,7 +1260,7 @@ __releases(&files->file_lock)
 	 */
 	fdt = files_fdtable(files);
 	fd = array_index_nospec(fd, fdt->max_fds);
-	tofree = fdt->fd[fd];
+	tofree = rcu_dereference_raw(fdt->fd[fd]);
 	if (!tofree && fd_is_open(fd, fdt))
 		goto Ebusy;
 	get_file(file);
-- 
2.43.0


