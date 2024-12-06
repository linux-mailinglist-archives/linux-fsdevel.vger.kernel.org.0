Return-Path: <linux-fsdevel+bounces-36587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036179E6305
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 02:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72011883612
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 01:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4E12EBE7;
	Fri,  6 Dec 2024 01:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opUyGa9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCA13C906
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447385; cv=none; b=rxhPCVLTNkpetZICOMcLzivIevzGfiz83HoRWTXUpulJnd0L43rk1bzVyFS/oIyqWr361D4f3B/FpdPCDGtLaTlRzZOoOnOIBi99UI/ftZiGk01MOeVvMFnF4dpKsur5p1ezaXdOQWyLb0Hb70zD6LLV9PpwTmDD82OVX9IwCxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447385; c=relaxed/simple;
	bh=J3nKYrj9AmggMWJ3J7t0rcXTlVHBgBWJCCL07vPZGIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KxhfBJnxWWzs+3hbDVDOBO1tZjBeneFcwLdNpSCHUkDmKMGXVkaxjAqOjhOkZN5GiExRHZoHSyKfqj9bb1JeMqCERW4V6mxlmg5/jlpg4jP0RQB+BFJ7TSvVRmf3nEVlCB6oxsfIBzlnhLiU9bFj3tal+q3/OXiDITu1JiWSnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opUyGa9U; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7259a7fd145so1121210b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 17:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733447383; x=1734052183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0EsM99SG3hihzaaNKgE6hFc9Vf2sd6rRNj6I2ZBeAU=;
        b=opUyGa9UNFLUEhngwCweZI5C4PC14gOHkRBuKX68/v3MRNnm8t/zRGL/Q2mYBxmy1w
         fAmCXwjqlRZHC+Qgfp/7NMUp8RxMXygRE7Od95zxFYGEkq47WIpe9+wenmFzeETO1S8Z
         L6i/Eus+XZPsgH6dpeU4N6AYZQpw75ZJpsTzFY6b5lHvEFZYjHm/WRs42WSQakmLNLtM
         h6fW51VpG25/wWwTvMIhRcVzjN6lgmpgcGI+wq09SRMLufqF9PcebW9Q2F0etGsarFd5
         5YImShfcxTp6X89ef9ZFym81aRa6IQFmjC8dDwjRdqr7xZZQxwd7SkbkoPXHEO5lycfW
         oCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447383; x=1734052183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0EsM99SG3hihzaaNKgE6hFc9Vf2sd6rRNj6I2ZBeAU=;
        b=AyQQRzs/SJQ3jFT85Ec0SFsVtz7luwfHrzahw1YOXPcX/unvLmjFx0vKFGKq2BFfbW
         ab+ot7GpfhhLbfpQm5HsiR2d/YVFWJtvtXYE0Ri6BlGXjQXqp+EV4vCPnShaw5GxBvKK
         fM3o5w6S8NzBTbIS2iEZwGRyFK4LJwzKZBgUrED3zHxRZwp50p43PIvcC7OqEgVpdg6t
         cAkB+ZannL3eqZ1kclP5WfelPhUrr1J1B//OF4+NrKQvMWj52AOxZfQjb1OWqSet/JgD
         lQFe0wb2dQDimhm2d1XFepglpxryAsrIBOOX/ItRTjpcdi/M90Ie0TYtBNDqxmYBzb7r
         mUDA==
X-Forwarded-Encrypted: i=1; AJvYcCXey5psq8776VARiBX3XCLePV0Sf6VUOjrqxoPNfXFJRlz4FZkE0wSYhBI4K9Gx8Ttvkvx8M1O5iGZjvAdm@vger.kernel.org
X-Gm-Message-State: AOJu0YxPBsIYoMLUiWesnLZbveG4k69hLHYYqimLgE87i3LUH8/YSdFS
	odizKgfY5hnr+M90QAxW/prJPHOgMMWAwTCC1UL9a63BtvIMguJJPaAVCOi3RtGqlraMHK/XBwd
	LEAikl5ZwoyTFKYz7BU0N0MrV6Q1I9AofIA==
X-Google-Smtp-Source: AGHT+IE+lZFMJ73v6jAW7BqzJ/0k/ho2hBMCiLFRGaWMMqnKpTaEahh/l5AmKSSMZElIcLOMWDH9HUGgB92p8rghNCEnXw==
X-Received: from pfbca23.prod.google.com ([2002:a05:6a00:4197:b0:725:20c8:96dc])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:140d:b0:720:9a03:b6dc with SMTP id d2e1a72fcca58-725b81f2d4cmr2040786b3a.18.1733447383706;
 Thu, 05 Dec 2024 17:09:43 -0800 (PST)
Date: Thu,  5 Dec 2024 17:09:23 -0800
In-Reply-To: <20241206010930.3871336-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206010930.3871336-3-isaacmanjarres@google.com>
Subject: [RFC PATCH v1 2/2] selftests/memfd: Add tests for F_SEAL_FUTURE_EXEC
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

Add tests to ensure that F_SEAL_FUTURE_EXEC behaves as expected.

Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: John Stultz <jstultz@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 46027c889e74..12c82af406b3 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -30,6 +30,7 @@
 #define STACK_SIZE 65536
 
 #define F_SEAL_EXEC	0x0020
+#define F_SEAL_FUTURE_EXEC	0x0040
 
 #define F_WX_SEALS (F_SEAL_SHRINK | \
 		    F_SEAL_GROW | \
@@ -317,6 +318,37 @@ static void *mfd_assert_mmap_private(int fd)
 	return p;
 }
 
+static void *mfd_fail_mmap_exec(int fd)
+{
+	void *p;
+
+	p = mmap(NULL,
+		 mfd_def_size,
+		 PROT_EXEC,
+		 MAP_SHARED,
+		 fd,
+		 0);
+	if (p != MAP_FAILED) {
+		printf("mmap() didn't fail as expected\n");
+		abort();
+	}
+
+	return p;
+}
+
+static void mfd_fail_mprotect_exec(void *p)
+{
+	int ret;
+
+	ret = mprotect(p,
+		       mfd_def_size,
+		       PROT_EXEC);
+	if (!ret) {
+		printf("mprotect didn't fail as expected\n");
+		abort();
+	}
+}
+
 static int mfd_assert_open(int fd, int flags, mode_t mode)
 {
 	char buf[512];
@@ -997,6 +1029,52 @@ static void test_seal_future_write(void)
 	close(fd);
 }
 
+/*
+ * Test SEAL_FUTURE_EXEC_MAPPING
+ * Test whether SEAL_FUTURE_EXEC_MAPPING actually prevents executable mappings.
+ */
+static void test_seal_future_exec_mapping(void)
+{
+	int fd;
+	void *p;
+
+
+	printf("%s SEAL-FUTURE-EXEC-MAPPING\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_future_exec_mapping",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	/*
+	 * PROT_READ | PROT_WRITE mappings create VMAs with VM_MAYEXEC set.
+	 * However, F_SEAL_FUTURE_EXEC applies to subsequent mappings,
+	 * so it should still succeed even if this mapping is active when the
+	 * seal is applied.
+	 */
+	p = mfd_assert_mmap_shared(fd);
+
+	mfd_assert_has_seals(fd, 0);
+
+	mfd_assert_add_seals(fd, F_SEAL_FUTURE_EXEC);
+	mfd_assert_has_seals(fd, F_SEAL_FUTURE_EXEC);
+
+	mfd_fail_mmap_exec(fd);
+
+	munmap(p, mfd_def_size);
+
+	/* Ensure that new mappings without PROT_EXEC work. */
+	p = mfd_assert_mmap_shared(fd);
+
+	/*
+	 * Ensure that mappings created after the seal was applied cannot be
+	 * made executable via mprotect().
+	 */
+	mfd_fail_mprotect_exec(p);
+
+	munmap(p, mfd_def_size);
+	close(fd);
+}
+
 static void test_seal_write_map_read_shared(void)
 {
 	int fd;
@@ -1633,6 +1711,7 @@ int main(int argc, char **argv)
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
+	test_seal_future_exec_mapping();
 
 	test_sysctl_simple();
 	test_sysctl_nested();
-- 
2.47.0.338.g60cca15819-goog


