Return-Path: <linux-fsdevel+bounces-44545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6210FA6A412
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8553BD064
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8748224887;
	Thu, 20 Mar 2025 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTQTcCj6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B402080D9;
	Thu, 20 Mar 2025 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467776; cv=none; b=eWcABilXqDU41V+PcupTCsXAbq5rtEzhi52u3Oo8Hesh9QYHV7z0WkAONhXh77UcTz0DN+l9bL/l7OW1OclFNQkvXPJ9Cm7MkvSh5XRYe04gGrybpFInQUnj6tb0F/VdBQtKiWOmL4rMpmIv04jFwbJPY8E82zd/ODrtpDuFU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467776; c=relaxed/simple;
	bh=ak0bH5VBArM9dgqVdz1GZ80nURKTsbHuii2hrbIquTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VIovS3XQm2PuwJdK7O8I9w7CW6VM3h0v8WCw12SWw/Gv02L6tm4y5FfnBjV/pltCymzj7aRKWMa1LZF4LmRKlBuTIwOFA8/ceBoZ6aZ0yaDKm3i0qFB5RKOP5EFFcfHZvHf4MkrpJX3pewUkPk8d44GO6gKE6l1dGqkbUJMjIuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTQTcCj6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3996af42857so1130033f8f.0;
        Thu, 20 Mar 2025 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742467772; x=1743072572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk4+4I5tIyCXCGc4MllrQDDfIeW6/YEI8kHwE9WZjQQ=;
        b=VTQTcCj63usj610/ICNFe2N6QX3VbfEowjXq2/ecxY2ONaPNiQVw9wQYd5fS0XMfIJ
         B9WLy8aM7bG1Yq/x+xi7yUBy1V5XyO2msTAFA+S9OI9yCztUGlTCx+iRdxbCbzOyaLLB
         UEsDULZaKlSGMddla3EGDdxaDhJTut6ndezMpFEyIuuqK2GrixbVimfC44fErwqBNpuc
         Au8d+8TGEJCsWKE4arZC6I6Gssxsio1Dx+qwGfrCJ+PcMF120Zs+yjYVXIbHP1PsuzWh
         VsNLCbfHV6pesPVVC3IxgHxmCFITMTylSPKygPL2FNEpVdufFKKdigzCRRiA174TSi84
         hxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742467772; x=1743072572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jk4+4I5tIyCXCGc4MllrQDDfIeW6/YEI8kHwE9WZjQQ=;
        b=a4GDLAzXIivGYyuAWnilr4Bl/ZVqrqM6glbATIeunVMIXcPm2egIdh37fcBBEt5CxE
         /iz3O/0+YqlKLDZeRhSnqOY6YGG7iRgc0DLyKMejqVHMsxw+lf0yatnI1bOf+vR3Rroi
         /25FvirhpqvR6rdPv4DOrvOuEhwYcUeneXsQCsUeY9lKZCjte1sMgWngKti6QKihXhpl
         yvw1yXKfE7RSTkddjUc9tLKKexZC0Xo7WWjPmeJcULo6cq15fYXg70+JDeKmdxZ9+LfN
         IVUujzxx06i044l4gXWzgLkdMEAzXydVtUB0ijekYxHPgI0BDddWqMgwgNqIrn2lBkoW
         iHoA==
X-Forwarded-Encrypted: i=1; AJvYcCUrc+hhktdx5Pq8OdRl9Fu5t0BeBiPqcaJS32aZvbFPo9jbek8tz6j2U1DMYXS6iP/DzHgWM25a6+wwUFat@vger.kernel.org, AJvYcCUtO7IabyptUrQ8m7KSJ8Hw6Pt/ZWFZB7aF9IOccXo6Au06ZrZesq4I9MIVbmie1gkiLTucN9hU0+4AKuS8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9haN6KADpo2namdYomlDv8+bWQcfmXOH2qT5cDQL1nVD751P/
	+HajCcu7fIwH3Dic5y48vaasf74WNPMHwK7OopMuIelU311Yx+LU
X-Gm-Gg: ASbGncvlPYgfYls31pf6HUvr8LaTJtCCiYG4kOnw/S2BZVuAN9a/kbAfrBUcb3huQ0n
	WtNZSxyEHVu++kPdH7CB8Snbc3bZ7B4lJ4rtoR5QNVotUw2Zwo7+gsOoY4yakZ5NMY6IPAk3Gld
	aEFbFCZCPsSG6LNy2Fvyua69BKEKO/mfs9rjBEvOrzvzx5rXynrvYDWC+P4nfKeXHA+SWbN2fT3
	4LUP5Cx0fbgsJFURsmYSeNfddoBLXYamIb/HQLvwiHCMCNo3iuvduA7yzjGt/mt7Cm9ybTe33rx
	nErNUNYoXUnhDJZYN6W5JAR9VZCEycvGKeA+OuPYvBI2gcwC86Kh1Lc+9UcvntU=
X-Google-Smtp-Source: AGHT+IH7IHYglIPsFR5Yz4XMi3toi73MU18BBRwjfxKR5Wa+qwGqEc6tfXIeU39WaV8+kUF1ZqZsfA==
X-Received: by 2002:adf:e846:0:b0:390:f0ff:2c10 with SMTP id ffacd0b85a97d-39979586da2mr2129503f8f.19.1742467772197;
        Thu, 20 Mar 2025 03:49:32 -0700 (PDT)
Received: from f.. (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997e3eb672sm249387f8f.95.2025.03.20.03.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 03:49:31 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: sort out stale commentary about races between fd alloc and dup2()
Date: Thu, 20 Mar 2025 11:49:22 +0100
Message-ID: <20250320104922.1925198-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace may be trying to dup2() over a fd which is allocated but not
yet populated.

Commentary about it is split in 2 parts (and both warrant changes):

1. in dup2()

It claims the issue is only relevant for shared descriptor tables which
is of no concern for POSIX (but then is POSIX of concern to anyone
today?), which I presume predates standarized threading.

The comment also mentions the following systems:
- OpenBSD installing a larval file -- they moved away from it, file is
installed late and EBUSY is returned on conflict
- FreeBSD returning EBADF -- reworked to install the file early like
OpenBSD used to do
- NetBSD "deadlocks in amusing ways" -- their solution looks
Solaris-inspired (not a compliment) and I would not be particularly
surprised if it indeed deadlocked, in amusing ways or otherwise

I don't believe mentioning any of these adds anything and the statement
about the issue not being POSIX-relevant is outdated.

dup2 description in POSIX still does not mention the problem.

2. above fd_install()

<quote>
> We need to detect this and fput() the struct file we are about to
> overwrite in this case.
>
> It should never happen - if we allow dup2() do it, _really_ bad things
> will follow.
</quote>

I have difficulty parsing it. The first sentence would suggest
fd_install() tries to detect and recover from the race (it does not),
the next one claims the race needs to be dealt with (it is, by dup2()).

Given that fd_install() does not suffer the burden, this patch removes
the above and instead expands on the race in dup2() commentary.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This contains the new commentary from:
https://lore.kernel.org/linux-fsdevel/20250320102637.1924183-1-mjguzik@gmail.com/T/#u

and obsoletes this guy hanging out in -next:
ommit ec052fae814d467d6aa7e591b4b24531b87e65ec
Author: Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu Dec 5 16:47:43 2024 +0100

    fs: sort out a stale comment about races between fd alloc and dup2

as in it needs to be dropped.

apologies for the churn :)

I think it will be best long term if this is one commit.

 fs/file.c | 52 ++++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index d0ecc3e59f2f..dc3f7e120e3e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -626,22 +626,14 @@ void put_unused_fd(unsigned int fd)
 
 EXPORT_SYMBOL(put_unused_fd);
 
-/*
- * Install a file pointer in the fd array.
- *
- * The VFS is full of places where we drop the files lock between
- * setting the open_fds bitmap and installing the file in the file
- * array.  At any such point, we are vulnerable to a dup2() race
- * installing a file in the array before us.  We need to detect this and
- * fput() the struct file we are about to overwrite in this case.
- *
- * It should never happen - if we allow dup2() do it, _really_ bad things
- * will follow.
+/**
+ * fd_install - install a file pointer in the fd array
+ * @fd: file descriptor to install the file in
+ * @file: the file to install
  *
  * This consumes the "file" refcount, so callers should treat it
  * as if they had called fput(file).
  */
-
 void fd_install(unsigned int fd, struct file *file)
 {
 	struct files_struct *files = current->files;
@@ -1259,18 +1251,30 @@ __releases(&files->file_lock)
 	struct fdtable *fdt;
 
 	/*
-	 * We need to detect attempts to do dup2() over allocated but still
-	 * not finished descriptor.  NB: OpenBSD avoids that at the price of
-	 * extra work in their equivalent of fget() - they insert struct
-	 * file immediately after grabbing descriptor, mark it larval if
-	 * more work (e.g. actual opening) is needed and make sure that
-	 * fget() treats larval files as absent.  Potentially interesting,
-	 * but while extra work in fget() is trivial, locking implications
-	 * and amount of surgery on open()-related paths in VFS are not.
-	 * FreeBSD fails with -EBADF in the same situation, NetBSD "solution"
-	 * deadlocks in rather amusing ways, AFAICS.  All of that is out of
-	 * scope of POSIX or SUS, since neither considers shared descriptor
-	 * tables and this condition does not arise without those.
+	 * dup2() is expected to close the file installed in the target fd slot
+	 * (if any). However, userspace hand-picking a fd may be racing against
+	 * its own threads which happened to allocate it in open() et al but did
+	 * not populate it yet.
+	 *
+	 * Broadly speaking we may be racing against the following:
+	 * fd = get_unused_fd_flags();     // fd slot reserved, ->fd[fd] == NULL
+	 * file = hard_work_goes_here();
+	 * fd_install(fd, file);           // only now ->fd[fd] == file
+	 *
+	 * It is an invariant that a successfully allocated fd has a NULL entry
+	 * in the array until the matching fd_install().
+	 *
+	 * If we fit the window, we have the fd to populate, yet no target file
+	 * to close. Trying to ignore it and install our new file would violate
+	 * the invariant and make fd_install() overwrite our file.
+	 *
+	 * Things can be done(tm) to handle this. However, the issue does not
+	 * concern legitimate programs and we only need to make sure the kernel
+	 * does not trip over it.
+	 *
+	 * The simplest way out is to return an error if we find ourselves here.
+	 *
+	 * POSIX is silent on the issue, we return -EBUSY.
 	 */
 	fdt = files_fdtable(files);
 	fd = array_index_nospec(fd, fdt->max_fds);
-- 
2.43.0


