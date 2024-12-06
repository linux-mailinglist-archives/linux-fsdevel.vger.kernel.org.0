Return-Path: <linux-fsdevel+bounces-36586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38FE9E6302
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 02:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF6A282E42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 01:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D298C81AD7;
	Fri,  6 Dec 2024 01:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zi3zpQMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACC677112
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447381; cv=none; b=DgjNvlw68eYInIXLv/m5RR3Ikumw06aC2sDx/wTjjIWkTk3yMrKGw/idYxhxHe6RLJTeeDZre0s3JnLqANldR3KYYl36xKKi4099HCMnyT5x1YZH+T5vJcWEPoEJ/3jAnec5bQk/HbFdrD3TDJuUSAZFa/7s8zC+xy+v2uLJF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447381; c=relaxed/simple;
	bh=+wJvCa+37UP6hvax1esryXtm9v0wblehOQqRU99BJVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lEX5QHfNusEYoumJk6gnEFsDiyjcfWzUbxj4i5MeoSfdzHJFTSzg8LcHEquUqdkMaLEo/fu8AznrCGTP6mNALdizzkM7ZK1DFbCk1eOVzS4VlOLXELEK1Q//OjEkQpj/wUc1p9xkFSARS5TGhiMMIah8sHxKzQhn3UKseY3Eais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zi3zpQMb; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-71d4d517158so1183341a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 17:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733447379; x=1734052179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVe1l78oGg6d6XLgPQZsewnpRSOEBU8Pjn8H7vlg4Dw=;
        b=zi3zpQMbUEqnUqKNLy6GnrqPX2mkt5WfUvc2+ta9ia048z1VXcbdBPlyRoBbNnv2xh
         R/ASlrzllKinPVCUW13JzPRF6FJGtUxrR1nBeodnDQE8UD5Jb+XC2k0a8YEAH/uRrRjP
         wvooMv8lV0q9gKEE3nRokVWky10OvP8Cyvaa5X3mUplVvDf0yMWiT0/EG0NG0dAU4FL5
         ec277nWnIQYLNlLbAcyu6ofutYty8e1uxpp0rHxQfZCGo1z61dokSk7e1P0HFkVNgNIx
         5pclqFlE44Hsd8dun0HfANGBoXPnI4G7XHiEJszaqQxverzEkBPBSf3BN6+dzTm2RPsP
         IUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447379; x=1734052179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVe1l78oGg6d6XLgPQZsewnpRSOEBU8Pjn8H7vlg4Dw=;
        b=nozy0tyRI59G9XckdEsYeIx7+oXC/AUKn8ruMZFi90FMiag6F94r+yUybNbG5qvfHI
         lifR9Z/Rbom8vGVweJ4rAIp8lhsrgl14X8VTrdk9muODnzI9w5H+s8RkZq9PU/zl0lnX
         y0V4IYIRmDq8+LUPvzb7XQXJen8nsFzhSpJHKu6rdwFYPiWJ9Il3rQ9WKEbaJ3c4o1xL
         kP6X3Sqf5DqQA+freffiodlhKSpK0jsGly4UaDv6aXDrzpqhG/H/SAIduMTOe08t2t5M
         vLidcdLQdIXL8hrN0+t9ZinO1PJhSb3uBDikMVKjEQECMV7aaJfictrq3feBvgQSdE2X
         gsvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX73GsTPGDhtNpVqs0ylxsV1cjUreAZltAiZF+xBt9iZnTOcm/Abj1Pohjabvm3oIsiR28UUliQnQdSuuAq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6V0O+ugogUb4N7/Fyo3z9hajM+JeuwPM2IdQjO831VpskWcni
	P1Zv0+sTUSi9yVzMHSIy2MZlNV72F5nhDAutdcQ1NvreKv8n1tamtJi1lolbakK4DnQXumjeG99
	rLy+rABi4urrzxAxGgN7wqQUVUiTefD5B+Q==
X-Google-Smtp-Source: AGHT+IEYpYAtNlzlC2hTmD5R4FH3FX1Gz1pWaXrJ2tHU6HF+bn7elD4ZxjnSK9HqdAVOAhJ2PH3MkkjOxrNoW9K1dfDvHQ==
X-Received: from pgct14.prod.google.com ([2002:a05:6a02:528e:b0:7fd:113b:ea62])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:2710:b0:71d:4624:3f2b with SMTP id 46e09a7af769-71dcf546d9fmr1201933a34.19.1733447378840;
 Thu, 05 Dec 2024 17:09:38 -0800 (PST)
Date: Thu,  5 Dec 2024 17:09:22 -0800
In-Reply-To: <20241206010930.3871336-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206010930.3871336-2-isaacmanjarres@google.com>
Subject: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC to memfd
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

Android currently uses the ashmem driver [1] for creating shared memory
regions between processes. Ashmem buffers can initially be mapped with
PROT_READ, PROT_WRITE, and PROT_EXEC. Processes can then use the
ASHMEM_SET_PROT_MASK ioctl command to restrict--never add--the
permissions that the buffer can be mapped with.

Processes can remove the ability to map ashmem buffers as executable to
ensure that those buffers cannot be exploited to run unintended code.
We are currently trying to replace ashmem with memfd. However, memfd
does not have a provision to permanently remove the ability to map a
buffer as executable. Although, this should be something that can be
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

Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: John Stultz <jstultz@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 include/linux/mm.h         |  5 +++++
 include/uapi/linux/fcntl.h |  1 +
 mm/memfd.c                 |  1 +
 mm/mmap.c                  | 11 +++++++++++
 4 files changed, 18 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4eb8e62d5c67..40c03a491e45 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4096,6 +4096,11 @@ static inline bool is_write_sealed(int seals)
 	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
 }
 
+static inline bool is_exec_sealed(int seals)
+{
+	return seals & F_SEAL_FUTURE_EXEC;
+}
+
 /**
  * is_readonly_sealed - Checks whether write-sealed but mapped read-only,
  *                      in which case writes should be disallowing moving
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
index 35a370d75c9a..77b49995a044 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -184,6 +184,7 @@ unsigned int *memfd_file_seals_ptr(struct file *file)
 }
 
 #define F_ALL_SEALS (F_SEAL_SEAL | \
+		     F_SEAL_FUTURE_EXEC |\
 		     F_SEAL_EXEC | \
 		     F_SEAL_SHRINK | \
 		     F_SEAL_GROW | \
diff --git a/mm/mmap.c b/mm/mmap.c
index b1b2a24ef82e..c7b96b057fda 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -375,6 +375,17 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		if (!file_mmap_ok(file, inode, pgoff, len))
 			return -EOVERFLOW;
 
+		if (is_exec_sealed(seals)) {
+			/* No new executable mappings if the file is exec sealed. */
+			if (prot & PROT_EXEC)
+				return -EACCES;
+			/*
+			 * Prevent an initially non-executable mapping from
+			 * later becoming executable via mprotect().
+			 */
+			vm_flags &= ~VM_MAYEXEC;
+		}
+
 		flags_mask = LEGACY_MAP_MASK;
 		if (file->f_op->fop_flags & FOP_MMAP_SYNC)
 			flags_mask |= MAP_SYNC;
-- 
2.47.0.338.g60cca15819-goog


