Return-Path: <linux-fsdevel+bounces-8207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED53830F42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 23:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E0D1C21ACE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 22:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF8128DA0;
	Wed, 17 Jan 2024 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ok3Hd9sQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D66B1E886
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531061; cv=none; b=OZj5Y121jt0J0nxW1w2p3S6JW4rowZI2PgsEX1dQRm2grQOt3eD+DHKh8Hs8jofoiUR/3IPdFbrwn7JnxxXJwANmB6mAEzS0Q1FIsP7PTy2MGIWqTdo5MFF6p7cbfOx14ObeRDxTcHG2Cevf2j+7Bed0wKRR5W1mew9CMA1zey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531061; c=relaxed/simple;
	bh=1PCGZ1uJiBtLoi7xA68BT5A/oeoNiduCk3gfJe1K/aI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=IDF05xyBQs+c9/VpnJeELocRz1vBB1kTQJxFfHSf1UT4J89oHQ3Qki3fvb6HVGCxgtXmGImHkrAQz/haUcJ01LG9t4dk+ikkKykGglL1nGqyxHZxJ2YuFvEz5PdULf3vlwNXW1DPMkrtLxtWGXeeWAA2JoAJ2kR9VE/hQK4CEBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ok3Hd9sQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d9a541b720aso16733883276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 14:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705531058; x=1706135858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qtcsSAi8pdfsx6Ojh55+8gPZOJc0hPQeptf8eZpqdHg=;
        b=Ok3Hd9sQ9D7vhb9N5JOxwYsb9vDc0LJN1SJS1xq4O4VOZS2uBDFUwjO/WVsL2aKD/R
         AwiehzjV6X70hTCPJckxsWBKkIMlTL90o9Gs2fo3jI0fFFc2iUwORnwBLsax728nwZLY
         d9Zj3meyfeqduY+yfwzNDJ4EOWxpby+mXhysYENtW3aWaq+bDq7jPD1VjEi0vFjs9M6h
         xf3eB1FTPxav5tzcIC0AcoChW9fYdyw7j63p4HqzrKsf6Pw/Q2HHaFvqzX+WlYt9/ytT
         RxB2oyW9Tuepnbz6r6l4Y9O67lPGJRaOwZqM5rYsulDx9AyC2sLpm5j0vOZX2xM0TN/v
         T2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705531058; x=1706135858;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtcsSAi8pdfsx6Ojh55+8gPZOJc0hPQeptf8eZpqdHg=;
        b=d42lJj+8AlWSzDLmjVWnBqxAeZqZR4/N+h4J4fUgtc0LtU55UsMxmvTEcbOCnXJAxy
         CKqijBU6pkC978J/iFkHQFHW3GzuMbJYCV1Y+kjhnvWC6QEnpAcp5PizcuZ2u9xaaJj5
         b6QgQW3Bw5n+qMQ+Nod7cxsf80Ur5y1Mw0+hDxoQyX8ZWqvd8QVKwMJe9LPQPj8cwfzV
         m1BT4Pn0DjiZb2L6dnzVf8w6RdKXCRD7jeynWJyv0J0/kWxS2P7USifIo8j0IJNMw+YE
         tsMug9EXmZnTfxMPf1DLjcOTZvZSXtiQFyZwmdt3imZm0uctyNARdYaT4YUngAPf9C5y
         rQ3Q==
X-Gm-Message-State: AOJu0YzCakvXTSUiu4+1X3NjBn/lUHpmYnd8vHY8LNirg2I6U3i8lMYY
	1CO0lW+H8BCBFjCpzYHpyFbBW6hhBhCfr/20eIM59j6N
X-Google-Smtp-Source: AGHT+IEHkEc2SNjgZpjAMRGfksbyD0+FFJUxQNmhwyp5v2dGwz3Ua29YR2phjpTtpCOeyHZkxZBYOa5Q8VSwmMY5Jw==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:9c18:2400:c024:5c4e])
 (user=lokeshgidra job=sendgmr) by 2002:a25:81c6:0:b0:dc2:23d8:722d with SMTP
 id n6-20020a2581c6000000b00dc223d8722dmr1380648ybm.13.1705531058526; Wed, 17
 Jan 2024 14:37:38 -0800 (PST)
Date: Wed, 17 Jan 2024 14:37:29 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240117223729.1444522-1-lokeshgidra@google.com>
Subject: [PATCH] userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com
Content-Type: text/plain; charset="UTF-8"

In mfill_atomic_hugetlb(), mmap_changing isn't being checked
again if we drop mmap_lock and reacquire it. When the lock is not held,
mmap_changing could have been incremented. This is also inconsistent
with the behavior in mfill_atomic().

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 mm/userfaultfd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 20e3b0d9cf7e..75fcf1f783bc 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -357,6 +357,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
+					      atomic_t *mmap_changing,
 					      uffd_flags_t flags)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
@@ -472,6 +473,15 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 				goto out;
 			}
 			mmap_read_lock(dst_mm);
+			/*
+			 * If memory mappings are changing because of non-cooperative
+			 * operation (e.g. mremap) running in parallel, bail out and
+			 * request the user to retry later
+			 */
+			if (mmap_changing && atomic_read(mmap_changing)) {
+				err = -EAGAIN;
+				break;
+			}
 
 			dst_vma = NULL;
 			goto retry;
@@ -506,6 +516,7 @@ extern ssize_t mfill_atomic_hugetlb(struct vm_area_struct *dst_vma,
 				    unsigned long dst_start,
 				    unsigned long src_start,
 				    unsigned long len,
+				    atomic_t *mmap_changing,
 				    uffd_flags_t flags);
 #endif /* CONFIG_HUGETLB_PAGE */
 
@@ -622,8 +633,8 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 * If this is a HUGETLB vma, pass off to appropriate routine
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
-		return  mfill_atomic_hugetlb(dst_vma, dst_start,
-					     src_start, len, flags);
+		return  mfill_atomic_hugetlb(dst_vma, dst_start, src_start,
+					     len, mmap_changing, flags);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-- 
2.43.0.429.g432eaa2c6b-goog


