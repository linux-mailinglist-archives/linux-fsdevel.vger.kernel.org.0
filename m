Return-Path: <linux-fsdevel+bounces-38352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB34A001CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 00:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A540F3A3202
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 23:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A411BEF6F;
	Thu,  2 Jan 2025 23:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afrt3Pj+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C64C1BEF60
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 23:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860785; cv=none; b=tHwCwm8P+wC3Izq7ldusbj+V5qGHuFlC63hsfU52nh0zPu97tzUHKeJuUIAI02duLPUiyDy0/7nrVptohkZ0fViC2AixZH0+YnM99uXlXv/uX6142stKkkQunT0Px3F5C/WiJbfAa5eqgcns/tLOuanqwoASiEEk8Z7E3y6i5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860785; c=relaxed/simple;
	bh=M2C2mYblq5WwfPR3JTQ7zjObWujAbnG0RbSo75nAPyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uIGkgbebD5Ezs7XVcRP5Aa6WWsyIxINDbeOg6TzoylmdDtJ8a9B3HnA1Ge3kdJx1qn0nZR0co/3lge3msvryZuad59MjF31E2GN0HSuwdBBtEgZHe/Cl8FMp0rmkhdLREZkdV5Xo7v0AYe81suczGGls6TgCL7EHq3ZUr5xPf90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afrt3Pj+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so16415027a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2025 15:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735860783; x=1736465583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6yaTDfkaNJVYvN9IEtl+N1Z6cSe/++H2abnIIHWux0=;
        b=afrt3Pj+qMvwiduV+CMhNRkpJveCRqWYEhRflesnOfLAjG3/W1OBxR0FSxTEpJD5J4
         HqiSv3TSU6TSv/LB871LyRR08+GWVoKAHlcC61HVtYjAZQ6bUVv8bNhe/7DxCmF3lkyH
         Ilkg9oG8L4llk+B9Jb/ONhR6MTxjGIuyGO3tXz3J3uxEwpIFSsXZAx2NeGLsh9VXYQ3t
         HCvF1Fsz1FUSpBqeLa9Rvn5J7RQ9P48FffIGfA5jF2NBh6Zn7Jplmc6R+9+eMe9Yj26g
         VZTTGGSPnaqGuhabcxsLzEcjTil88+J1VqAtNEnb1OQ54JJOzoh9tzinsFlJm96kZhX0
         W+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735860783; x=1736465583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6yaTDfkaNJVYvN9IEtl+N1Z6cSe/++H2abnIIHWux0=;
        b=fKdFu7wEMsT78tfeA+gZC0ynP6W7tp85HdaG+sTN3I+K2cSFQoAVcOufQZhICwmhSU
         jjYsEbH7oxuWE9vPw1bcbfoYhRTA69gjzgq6fAmklkq5umUlqIRSeYixL/muRxq+sQEM
         SEI7LXdS0MTB1nI/R4AWg6t2DoGGYHivwSdHWVs41c3FEFP8A+0MkPpPbUTzxpthEorE
         CZv8fDGuyYQ44MYMeIEmTR8JQm4WKFBNZZxZIsSiPKv9Masd6GEueXte4ngsaXSc8M6b
         7dSiuuHmZd2YMqAx12T6oz5EQimrbFBJPj+pT4geV0Me9KEzbBFfk822sPNOmyCbqay8
         NoOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8nFp8qn/SLkxFeLCxSSv9OfSxiY39M6qsD292vLatGxpgyeBC4pmQPg+6fAVoTPNrxX+OKs5rHmskie9K@vger.kernel.org
X-Gm-Message-State: AOJu0YxBryP0GOsPdtZEWj9Vu9jBiySpPeizcpJtcOBuzpeqOyoAEPgz
	F4Wr44mLvx8x8/u1w46Hn/fxkgGGes6zSxQOfN6S4rBFHG5JPMc6sHwND9ri8W68Z4fMN40flqT
	LBlYriW91qB1eNqv9bYen+Z05aAcPiYYqjQ==
X-Google-Smtp-Source: AGHT+IEHpT1wneDx2QefehHIafdQKlpZShR73+0EcuaPDdyhvMMTjby5J8JbVEp815hnmiWSln6qPCmr4ccXbyU/1PWS/A==
X-Received: from pfbbw10.prod.google.com ([2002:a05:6a00:408a:b0:725:e84a:dd51])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:92a4:b0:728:e1f9:b680 with SMTP id d2e1a72fcca58-72abdd7ac89mr65635875b3a.6.1735860782779;
 Thu, 02 Jan 2025 15:33:02 -0800 (PST)
Date: Thu,  2 Jan 2025 15:32:50 -0800
In-Reply-To: <20250102233255.1180524-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250102233255.1180524-2-isaacmanjarres@google.com>
Subject: [RFC PATCH RESEND v2 1/2] mm/memfd: Add support for
 F_SEAL_FUTURE_EXEC to memfd
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: surenb@google.com, kaleshsingh@google.com, jstultz@google.com, 
	aliceryhl@google.com, jeffxu@google.com, kees@kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Android currently uses the ashmem driver [1] for creating shared memory
regions between processes. Ashmem buffers can initially be mapped with
PROT_READ, PROT_WRITE, and PROT_EXEC. Processes can then use the
ASHMEM_SET_PROT_MASK ioctl command to restrict--never add--the
permissions that the buffer can be mapped with.

Processes can remove the ability to map ashmem buffers as executable to
ensure that those buffers cannot be exploited to run unintended code.

For instance, suppose process A allocates a memfd that is meant to be
read and written by itself and another process, call it B.

Process A shares the buffer with process B, but process B injects code
into the buffer, and compromises process A, such that it makes A map
the buffer with PROT_EXEC. This provides an opportunity for process A
to run the code that process B injected into the buffer.

If process A had the ability to seal the buffer against future
executable mappings before sharing the buffer with process B, this
attack would not be possible.

Android is currently trying to replace ashmem with memfd. However, memfd
does not have a provision to permanently remove the ability to map a
buffer as executable, and leaves itself open to the type of attack
described earlier. However, this should be something that can be
achieved via a new file seal.

There are known usecases (e.g. CursorWindow [2]) where a process
maps a buffer with read/write permissions before restricting the buffer
to being mapped as read-only for future mappings.

The resulting VMA from the writable mapping has VM_MAYEXEC set, meaning
that mprotect() can change the mapping to be executable. Therefore,
implementing the seal similar to F_SEAL_WRITE would not be appropriate,
since it would not work with the CursorWindow usecase. This is because
the CursorWindow process restricts the mapping permissions to read-only
after the writable mapping is created. So, adding a file seal for
executable mappings that operates like F_SEAL_WRITE would fail.

Therefore, add support for F_SEAL_FUTURE_EXEC, which is handled
similarly to F_SEAL_FUTURE_WRITE. This ensures that CursorWindow can
continue to create a writable mapping initially, and then restrict the
permissions on the buffer to be mappable as read-only by using both
F_SEAL_FUTURE_WRITE and F_SEAL_FUTURE_EXEC. After the seal is
applied, any calls to mmap() with PROT_EXEC will fail.

[1] https://cs.android.com/android/kernel/superproject/+/common-android-mainline:common/drivers/staging/android/ashmem.c
[2] https://developer.android.com/reference/android/database/CursorWindow

Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 include/uapi/linux/fcntl.h |  1 +
 mm/memfd.c                 | 39 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 6e6907e63bfc..ef066e524777 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -49,6 +49,7 @@
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
 #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
 #define F_SEAL_EXEC	0x0020  /* prevent chmod modifying exec bits */
+#define F_SEAL_FUTURE_EXEC	0x0040 /* prevent future executable mappings */
 /* (1U << 31) is reserved for signed error codes */
 
 /*
diff --git a/mm/memfd.c b/mm/memfd.c
index 5f5a23c9051d..cfd62454df5e 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -184,6 +184,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
 }
 
 #define F_ALL_SEALS (F_SEAL_SEAL | \
+		     F_SEAL_FUTURE_EXEC |\
 		     F_SEAL_EXEC | \
 		     F_SEAL_SHRINK | \
 		     F_SEAL_GROW | \
@@ -357,14 +358,50 @@ static int check_write_seal(unsigned long *vm_flags_ptr)
 	return 0;
 }
 
+static inline bool is_exec_sealed(unsigned int seals)
+{
+	return seals & F_SEAL_FUTURE_EXEC;
+}
+
+static int check_exec_seal(unsigned long *vm_flags_ptr)
+{
+	unsigned long vm_flags = *vm_flags_ptr;
+	unsigned long mask = vm_flags & (VM_SHARED | VM_EXEC);
+
+	/* Executability is not a concern for private mappings. */
+	if (!(mask & VM_SHARED))
+		return 0;
+
+	/*
+	 * New PROT_EXEC and MAP_SHARED mmaps are not allowed when exec seal
+	 * is active.
+	 */
+	if (mask & VM_EXEC)
+		return -EPERM;
+
+	/*
+	 * Prevent mprotect() from making an exec-sealed mapping executable in
+	 * the future.
+	 */
+	*vm_flags_ptr &= ~VM_MAYEXEC;
+
+	return 0;
+}
+
 int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr)
 {
 	int err = 0;
 	unsigned int *seals_ptr = memfd_file_seals_ptr(file);
 	unsigned int seals = seals_ptr ? *seals_ptr : 0;
 
-	if (is_write_sealed(seals))
+	if (is_write_sealed(seals)) {
 		err = check_write_seal(vm_flags_ptr);
+		if (err)
+			return err;
+	}
+
+	if (is_exec_sealed(seals))
+		err = check_exec_seal(vm_flags_ptr);
 
 	return err;
 }
-- 
2.47.1.613.gc27f4b7a9f-goog


