Return-Path: <linux-fsdevel+bounces-44857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD22AA6D479
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 07:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900CB1687C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 06:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576E42063C1;
	Mon, 24 Mar 2025 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BN51GcXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F83205AA9
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742799217; cv=none; b=e00CQmvoCwvYIus7X8apLpbc1vlEHfAbgWz06I6CRINZ5EMAsBSrjh0u+imgLvXg+WCVTPXO00j9bMi2hIfYBiv9oSqgs+l/rQFOPnaFpF4zVJ24zcLDIESHfOxnnhJ6xbSpts4PTEcdRTUBGKcP3ZFjkxyBDoEXlGLAh9Kpff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742799217; c=relaxed/simple;
	bh=a/655ARJD96yOrrJq8qv2chSeO2igeF+EpgPoB34Lko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IbKqRAAr/cnzgPI4oBb1gcMgK+YmolLheeYbDeHgmlLMHdWcIbykj1aHdO6YH/QY65GVLwoNk1+6AiY62OM/ZOLdQwfbt47mAQS6Kjo14C9s06NU5WkjKgfc4bdCcAEd59PI6jCw0FZ8+on/Lv14t+B1S/pk6Qt3WgWxln3twuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BN51GcXY; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-85dad46e9ddso338942239f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742799214; x=1743404014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffy3DLCEfKN3in8d5zlc7vx3iwgfrqHuCXTxXTm84ts=;
        b=BN51GcXYon69e0DC3wmCG7WMntjOUTb3SBB+Gr7psZ5Oic05Ub9A9VnlMIxiQg4OVo
         sSY0y99d38pDT6F/BgOq0k0Udql1nVxT5qHpxlHlaQp2NsOtgK8L3JaEcF7TTszUaDt6
         yP99+3LZjCg9G4p1e96aAxYOLxcuqz69LRCD1x8uvrmPZyzkz7Zw0G40PTfaZ0V1QxFi
         uXYyjgnQKtrP5OFOuXEtXczjFPIa70OcCf5nCarrYczJulzXcQyMmdknixeTutMEWAob
         F8GOkto/ckriWp8A2xVKwRUZD+8BqJfqK4K+gU7GuIsWDJwy+ealOAWjyEtaIZYeB8sI
         V6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742799214; x=1743404014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffy3DLCEfKN3in8d5zlc7vx3iwgfrqHuCXTxXTm84ts=;
        b=GKrHfOQaSmo7zIzrD6nX3oaOhwtCFNW1c93xqTIbjZDHB5BIulqmkhcmszHYy1kSzy
         jVFkIxm3FAdqLV8s2wZky07LeCd2kBHpyt2g//8uaJ/F40mKLSMn8bkCOq0Ce71JEYFG
         KFte6O4vj0L2L8fZpqn1Qo2dcVdEBVSmzL09mh6BXUHG6XICbVZ9wSdDSLFj0ugF+WVn
         Qf5zT4fr2uPLulKw2ZEk+hjT+RSVaMBEBcyHYE2lcFC7iuAHkpcMSnOuTkGBcDjtMpob
         /aw/3u9nNAy/UwvkT8DyEPpgb3x/yYsXf2Ixj3kfjJyOmTItvMt2vmHq8gFO9ro3AMnW
         uk6g==
X-Forwarded-Encrypted: i=1; AJvYcCVyAxExAprbz00W0DcHRx3dweVvFiofMZp/Dk+qSeT+W3eK00lzQJ5teoe8O0dTFhWSglf4UcO1G981V6MF@vger.kernel.org
X-Gm-Message-State: AOJu0YyIW1GLdzmnjrRt9BWSySoX81t0i56i+r6ylGRhxS2vGJ9Z0wHM
	h7JUYeXXw435+HBw0zy0GRRU61bdQRvezDZa2B5QwQHdZwn/ffNnGdkGvtqlqSUoc2WEDN1PmWs
	n6A==
X-Google-Smtp-Source: AGHT+IFwtFlPb7SBpjbVuF+q5bn8QiiRzWt4tMIZGVuP7apCHzJYW7HGlUxBgl+wR+Dv2VtTkkVMvH9ZZQw=
X-Received: from iobbw19.prod.google.com ([2002:a05:6602:3993:b0:85b:40c7:ce65])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a6b:7b07:0:b0:85b:5511:e47f
 with SMTP id ca18e2360f4ac-85e1ef9251emr1427245839f.3.1742799214336; Sun, 23
 Mar 2025 23:53:34 -0700 (PDT)
Date: Mon, 24 Mar 2025 06:53:28 +0000
In-Reply-To: <20250324065328.107678-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324065328.107678-1-avagin@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324065328.107678-4-avagin@google.com>
Subject: [PATCH 3/3] selftests/mm: add PAGEMAP_SCAN guard region test
From: Andrei Vagin <avagin@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	criu@lists.linux.dev, Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Andrei Vagin <avagin@gmail.com>

Add a selftest to verify the PAGEMAP_SCAN ioctl correctly reports guard
regions using the newly introduced PAGE_IS_GUARD flag.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/mm/guard-regions.c | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 0c7183e8b661..c99f3da8bfb7 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -8,6 +8,7 @@
 #include <fcntl.h>
 #include <linux/limits.h>
 #include <linux/userfaultfd.h>
+#include <linux/fs.h>
 #include <setjmp.h>
 #include <signal.h>
 #include <stdbool.h>
@@ -2079,4 +2080,60 @@ TEST_F(guard_regions, pagemap)
 	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
 }
 
+/*
+ * Assert that PAGEMAP_SCAN correctly reports guard region ranges.
+ */
+TEST_F(guard_regions, pagemap_scan)
+{
+	const unsigned long page_size = self->page_size;
+	struct page_region pm_regs[10];
+	struct pm_scan_arg pm_scan_args = {
+		.size = sizeof(struct pm_scan_arg),
+		.category_anyof_mask = PAGE_IS_GUARD,
+		.return_mask = PAGE_IS_GUARD,
+		.vec = (long)&pm_regs,
+		.vec_len = ARRAY_SIZE(pm_regs),
+	};
+	int proc_fd, i;
+	char *ptr;
+
+	proc_fd = open("/proc/self/pagemap", O_RDONLY);
+	ASSERT_NE(proc_fd, -1);
+
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	pm_scan_args.start = (long)ptr;
+	pm_scan_args.end = (long)ptr + 10 * page_size;
+	ASSERT_EQ(ioctl(proc_fd, PAGEMAP_SCAN, &pm_scan_args), 0);
+	ASSERT_EQ(pm_scan_args.walk_end, (long)ptr + 10 * page_size);
+
+	/* Install a guard region in every other page. */
+	for (i = 0; i < 10; i += 2) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(syscall(__NR_madvise, ptr_p, page_size, MADV_GUARD_INSTALL), 0);
+	}
+
+	/*
+	 * Assert ioctl() returns the count of located regions, where each
+	 * region spans every other page within the range of 10 pages.
+	 */
+	ASSERT_EQ(ioctl(proc_fd, PAGEMAP_SCAN, &pm_scan_args), 5);
+	ASSERT_EQ(pm_scan_args.walk_end, (long)ptr + 10 * page_size);
+
+	/* Re-read from pagemap, and assert guard regions are detected. */
+	for (i = 0; i < 5; i++) {
+		long ptr_p = (long)&ptr[2 * i * page_size];
+
+		ASSERT_EQ(pm_regs[i].start, ptr_p);
+		ASSERT_EQ(pm_regs[i].end, ptr_p + page_size);
+		ASSERT_EQ(pm_regs[i].categories, PAGE_IS_GUARD);
+	}
+
+	ASSERT_EQ(close(proc_fd), 0);
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.49.0.395.g12beb8f557-goog


