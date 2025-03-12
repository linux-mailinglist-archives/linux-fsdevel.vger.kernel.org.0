Return-Path: <linux-fsdevel+bounces-43822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF83AA5E1A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 17:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC741895721
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500401D5166;
	Wed, 12 Mar 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9UkDeD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2601422DD;
	Wed, 12 Mar 2025 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796395; cv=none; b=uGncCX1ZknEPAncT+HYXsjOhYQsYNCXL+PmfK1DbLifh/mQvuBhwlAPq3P1PtvyOI2Vumi1p5I+hZ0rgzCr1hihg4Hx3F+Ac1AMSnmD0iLy656QmSbKlA+ixRBKHFOlOu/ZR0Nfy+4k7CAisnpriAb/xCKzfgBKhtk9YtGp0pGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796395; c=relaxed/simple;
	bh=z0h4bJv4OLrSIfo7hzNobmJg2YYyIPG/NIJvTizpqr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIhgkc2dhCFuJgleQvYOZf7V0AWKwltkZ8RujgBoQwACkvV6zsCfJk2jjPVTn0wqjp5hE1u/0YfiSu/yuJFavzkq2Nx2I/THb0sJ0p9o8RiF5xaMXm2oxtJ/GPRAwDUhnoXQnBpZHwQTLRyNWwqGtAQhFdT1LDuVn53i4jVo+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9UkDeD0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso9180388a12.0;
        Wed, 12 Mar 2025 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741796392; x=1742401192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7e7a+31makUjfzi5n5Z3jqV/sxRoCpNQ+KeKCVOFNMs=;
        b=c9UkDeD09qbIEdP9zeJag6RUW//JdLHCj46kJTWxQZGtKR72qYSRtR8ei81PNbS2Wa
         g/DlegJ3zbzKpob2BZqlzrCu446/Ns4Q54sIqjE+13ygS8bhDciB5js4J6jST/2nic/w
         FmKJqLW/WO4sPuFcydV/cIxmdLhN5EgbsAEeOe9CIS6gtz1gf3q2qcMDCw71ptCcWvm1
         32kPKXoin3g8z2V/ncWA4YoqVKMmTTkVNUtONlyBt+Q0yH13AS4PIgueIRkUd8gBEIhO
         f1Rmz7NI8aQkemE5p+/n9bvNlz3Pb66NoYrgRrJE8Xjtf5qxr0ZuJPFC712nfqmox8Dt
         XN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741796392; x=1742401192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7e7a+31makUjfzi5n5Z3jqV/sxRoCpNQ+KeKCVOFNMs=;
        b=giAhMnCsjZJ/x45QU1uBeeWOKbxftMo9ROaLoOV4UonNc/GX9gamCkFOUhWonFaXlj
         A757ksPK6uE5CbMVrDU71sA7t/kHDffGVGK/dr6I+cdNMGsfNq7TGiEhdXoDilUVaQdO
         obV3puvRKcH4ELaqNKw81iv/fxwg9YkbtwpJBwnTFkt04UWaCd8yr8Ky2GivGNELApbU
         R3svikiDTJPW4CKyu3QEQSxtH2AeU6L3LXOeteFS3o2rpyyRcabmIR4EOsgrNEGDQsfH
         JMsqQ+69x6fD89r/MyuqLbC1Z9vECU/o2DAXYGuoIHZ7wpV/PDcAyn+lKDH2OYBzxgOs
         XFhA==
X-Forwarded-Encrypted: i=1; AJvYcCVS9s1mbZ/z41I1ZuM3E4oCUe36kL/1FKTdpenexe85q3ox7eSMJti8BYiOkRHbwSarht5QJh/9f3ZEyh1x@vger.kernel.org, AJvYcCVmGtk3LTJisC05jvh216Zo+K+WDn88Iu9Jg5dZLSf78rAxMM+X4Go2KjYYH9/SA2besDSl09C+hlPS0e/J@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMZn6BzDHPtf9n2H1hvojSt6oEsI8yj3ptjKgGtLamw514OCm
	45bn8wjGlDXz15oiyr7i8wcUqWMht6BCyBUAI55FnMcguQIuPVJ6
X-Gm-Gg: ASbGnctKATw0y3Bf1aiBRJQVAnpkkymLvVvF9l7DXb0ptpU1PWJPnE/m3dRdF/91I+i
	kTicop1Q7oHvh4WFaqJLXG1ZB7N6lVQZayntOTIiN4TBoiZGcQtd+6mOEw4M/XS+iJlhn21UzS0
	mcRiHJMjA9IlW5O06lVOmXtf+9zdQetHh5nVeIzf5z+L+jGHGr92psNX32qxJQBGjHpFhILdI4a
	n3cLmB5HhaMjwlaxg23iuxl40atew31TSRE9VzdnSGA1/ZeDX1muOVeix1xwCBlKiPjqRM3fR7d
	UI3+zzuNTveIIvJzN4uIJFFg0MB/TNg0AA7XcE19AS61UZdGa9q6rZTh14gq/6k=
X-Google-Smtp-Source: AGHT+IFKy5OXoJ5dXd/qpzp1wal99wSis1iq5eu87px+/PGcCyRUc78mV1coxRuZwnAz0P6bQeV4oQ==
X-Received: by 2002:a17:907:1b0a:b0:ac2:4bf1:44bc with SMTP id a640c23a62f3a-ac252fa0593mr3402163566b.41.1741796392050;
        Wed, 12 Mar 2025 09:19:52 -0700 (PDT)
Received: from f.. (cst-prg-86-144.cust.vodafone.cz. [46.135.86.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2395174c8sm1081722366b.85.2025.03.12.09.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 09:19:50 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: use debug-only asserts around fd allocation and install
Date: Wed, 12 Mar 2025 17:19:41 +0100
Message-ID: <20250312161941.1261615-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This also restores the check which got removed in 52732bb9abc9ee5b
("fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()")
for performance reasons -- they no longer apply with a debug-only
variant.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I have about 0 opinion whether this should be BUG or WARN, the code was
already inconsistent on this front. If you want the latter, I'll have 0
complaints if you just sed it and commit as yours.

This reminded me to sort out that litmus test for smp_rmb, hopefully
soon(tm) as it is now nagging me.

 fs/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 6c159ede55f1..09460ec74ef8 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -582,6 +582,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 
 	__set_open_fd(fd, fdt, flags & O_CLOEXEC);
 	error = fd;
+	VFS_BUG_ON(rcu_access_pointer(fdt->fd[fd]) != NULL);
 
 out:
 	spin_unlock(&files->file_lock);
@@ -647,7 +648,7 @@ void fd_install(unsigned int fd, struct file *file)
 		rcu_read_unlock_sched();
 		spin_lock(&files->file_lock);
 		fdt = files_fdtable(files);
-		WARN_ON(fdt->fd[fd] != NULL);
+		VFS_BUG_ON(fdt->fd[fd] != NULL);
 		rcu_assign_pointer(fdt->fd[fd], file);
 		spin_unlock(&files->file_lock);
 		return;
@@ -655,7 +656,7 @@ void fd_install(unsigned int fd, struct file *file)
 	/* coupled with smp_wmb() in expand_fdtable() */
 	smp_rmb();
 	fdt = rcu_dereference_sched(files->fdt);
-	BUG_ON(fdt->fd[fd] != NULL);
+	VFS_BUG_ON(fdt->fd[fd] != NULL);
 	rcu_assign_pointer(fdt->fd[fd], file);
 	rcu_read_unlock_sched();
 }
-- 
2.43.0


