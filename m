Return-Path: <linux-fsdevel+bounces-44537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D30A6A39A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B033B58B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F15224240;
	Thu, 20 Mar 2025 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fftmflob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76622257E;
	Thu, 20 Mar 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466413; cv=none; b=IEIk7bH4bdP0dvypYp1t7suBFXb3l+hhfhvqZM8umd4QA0wysUi7RAuqM9x8SLp4783G314VGB6z8Z/Gv4scjPZ3ZfuFmT2oDEv2SdnQJpS7m8FbXDEcUDBUoWD9LYRmlC4XbAcQDFni3MwoeslMOW8itxeBEJonm/fb4k7kwQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466413; c=relaxed/simple;
	bh=73L4QBgZ4jztQ2zh5cGBFktxWTlIrzq9SkbAh4q8vTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZ+caQ3KSLpb5WRGsQzs8+LAr2gSx3v3Cnmbklt2Av3Zip4dE1yArh7nN0z6m9A0+hTgWCH9zmYxc9MMqnRSi4CCvbkvztL8S7gm92L+pq3AOfleoSkxfYKk6wd3lkECxt3hatVtOPTuTw2/O8YMIJTzM06EI1t6Xey222C9/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fftmflob; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d0618746bso3738485e9.2;
        Thu, 20 Mar 2025 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742466409; x=1743071209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HawgxxVZ0VP8h2ZK240Xc42v4xINhqqYB2/a1ZVpyOw=;
        b=fftmflobxg8zJXVTO9Qpz6sauv6ASQ2I0JCdWfSVsH8K5wAQ8zOdhny8PJNPrnTIhe
         fInq4obLLsaX1zBw4R1ZWzgXf44LirSsdkDSmWegT5tPWRFv9VMUPtc6cvmzmv9A/e7s
         tzPL+oO4FiI7gPjtbaoq5KaseqiLqD6juog8+84BDQnHMgBnSbCFomsORtx1TnvKszSD
         /Q+ttLQhjPI/nWBmpJfdb08+nD1eIFMdZBuc1bVRbgaCl3vPbYmV1oBUBApDc1Ze6JeV
         8s6ipUVyFA2+gRdobD73BJlkPbzKg2VjEvpKKS2UQD6u5mXdz0IzE1/TqYOhJif59Da1
         HyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466409; x=1743071209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HawgxxVZ0VP8h2ZK240Xc42v4xINhqqYB2/a1ZVpyOw=;
        b=wzq+/4kiWFjLgg7XL+NUik2j9LXRRuBR3Nvyo4uuNdJ9QAHSVD7t8wJMn1M9CoS/Uw
         4hnxo+lQYLb6aod1zsBDXQn/IHoiJAbEobiCKvN30fPT2kVuL7Xm5o3mlUM0A2XSu+69
         hdjg3YcCyW6uMTsP2PH9AGH/pP/UpNO3zEtIIesn5HY6/vyZOXdIVe9+bBPuirpc4Lv3
         rPOgSxN/P7SrQ6bP8rDj42XZqKcA1JyPxjYEdkKf393aLPAgMSt/6hTfTnTm5cibrthF
         NsI1WbiVBtCp3CjHUJXIncnpgtNj/vnOCle+fxhr24yCsZjX49EWNeg8eQJqWpeUCS/3
         D1ng==
X-Forwarded-Encrypted: i=1; AJvYcCV/BlmzfnNiSUcfwN6/n431XHPFb9TyD6Dars8pcFalxUPhlD6TvGDfVYgkA0RPZDif4ixAn9JuIQFpffMA@vger.kernel.org, AJvYcCV7qL57SYwmpqIBHY1WtpeKD9DrtZrbt/lxGksuRSSG2Ida1OOn0vujJdhKELP5404jhfc8QgQAFA7nvGWH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+kEqdLodUzbR3hitSzg/KcjxlyTZA9dQpkx6f4q1XIFny7WQX
	cNbGeWUfC0TDFuj4cUNJIml1XIsS9/Knoz0EjN4I9HbmMoA7LCM0I2ci/kxp
X-Gm-Gg: ASbGncuPs4Ac7oRdCZ9pNVXN5Agu3u+uSB5Tv55qCrAjd4QhtoWR9qgWFA+IFr++Tqp
	f7eo+bgTk83K+6Coc6l9RSumJsRYcJL2nOXTPEvUrhwbtw3++4AE62sbqf1nzK3F85lM0Ai9NS7
	oTVBZt53mR5e59Zs0o4M0tzEHzEbsU7qWBO4G6sPMWEAujk1ml+2u4IBQuDa+GK/2fwlkS8+B3m
	AcVHaxX+/Kjtx0Uy24hftukvThmj42okNml8q3IpAXP5+5D+E751gHmcnVgZ1fUgJf7dtI6ij8S
	kCdxFYU+ljxM4bGj6uOigWzaWcyg3Xf2vDWTVuP9H3sfm7FSQYel39DbMY3IEc8=
X-Google-Smtp-Source: AGHT+IER7SuPJjUH4lCqbM3lr3kLMorlti4mSw5CTuqTLrDqbZrUCdAJITZOqS3QHiYfvHUKS8WCRA==
X-Received: by 2002:a05:600c:1f83:b0:43c:ef13:7e5e with SMTP id 5b1f17b1804b1-43d4383d55bmr49947075e9.26.1742466409117;
        Thu, 20 Mar 2025 03:26:49 -0700 (PDT)
Received: from f.. (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed786sm43752145e9.38.2025.03.20.03.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 03:26:48 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: sort out fd allocation vs dup2 race commentary, take 2
Date: Thu, 20 Mar 2025 11:26:37 +0100
Message-ID: <20250320102637.1924183-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fd_install() has a questionable comment above it.

While it correctly points out a possible race against dup2(), it states:
> We need to detect this and fput() the struct file we are about to
> overwrite in this case.
>
> It should never happen - if we allow dup2() do it, _really_ bad things
> will follow.

I have difficulty parsing the above. The first sentence would suggest
fd_install() tries to detect and recover from the race (it does not),
the next one claims the race needs to be dealt with (it is, by dup2()).

Given that fd_install() does not suffer the burden, this patch removes
the above and instead expands on the race in dup2() commentary instead.

While here tidy up the docs around fd_install().

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I have this commit in -next (*not* in master):

commit ec052fae814d467d6aa7e591b4b24531b87e65ec
Author: Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu Dec 5 16:47:43 2024 +0100

    fs: sort out a stale comment about races between fd alloc and dup2

It may make sense to combine these two into one. If you want it that way
I'll submit a combined v2.

 fs/file.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 0e919bed6058..dc3f7e120e3e 100644
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
@@ -1259,8 +1251,28 @@ __releases(&files->file_lock)
 	struct fdtable *fdt;
 
 	/*
-	 * We need to detect attempts to do dup2() over allocated but still
-	 * not finished descriptor.
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
 	 *
 	 * POSIX is silent on the issue, we return -EBUSY.
 	 */
-- 
2.43.0


