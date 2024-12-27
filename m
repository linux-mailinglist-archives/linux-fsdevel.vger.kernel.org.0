Return-Path: <linux-fsdevel+bounces-38154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407A99FCF87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 02:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA283A0486
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 01:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8571135944;
	Fri, 27 Dec 2024 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/o187Iu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5A3597A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735264344; cv=none; b=aD4rdhToDD0Ucu1xbcMoSPy7CvDh4lkK31iaXwAmenguVIrahKIurUevtSOJO8ISMg8P4jKxKwRkJHEnJzmjmeKDu/cN8SA3yYdLF4afpE+K7yPmDTuWeI575rkvteH9y6VWjkr8lYX36lbEfTxxJjQvkteiBzrg9oDbaUPCBEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735264344; c=relaxed/simple;
	bh=4DBEFnoWxm6wOsHhIgJEisd7g7YgHjqynQfwaJjdS5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QFI/5mkojXEjGuYVhsxjkx32SX51SpVuzeYHbZI4nGHHjlpeL5Ms9+dX2v8XcIqsBkIZT9V1XSKIbawScJyw8cA/eM04sMUhooYOm3aRzOGgfWuq8X/vx+m5Zn477Acu/N6h36ntwa0y8aKK2Lb8uQHvrSBGFzmRMMTJo4lSIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o/o187Iu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21648ddd461so110352205ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 17:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735264341; x=1735869141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DO6BLM5CMOo/wBOU4R18TkGC6gkh5CUUEjeVIIwslA=;
        b=o/o187Iu1ToUUq4Cm+3BwHS/jGEQlNRsv3eZh3ng5BAPovHS4HwCfcQ0CoAAbe1/eb
         FAEXj1MvhwgArIBGLvJUrQNKGUVXcStny9CnXXmAHH3jDba4V2k+lMFOBI6cP7KsGaZi
         nHVvHFZ7l6z5ukeFU8nFeg2YPzglwO8frhvBzPfH3mVQGrGBLZrQLbmJj2ty/HCoA0n6
         aFkvDi5ub0x6jY41i7pGctA06xW/KtRCjWEWYPqanxYQZB+35/sAay4zNPrFrKropeeV
         dFEMtr8VNyr8JQpCtqcY91yLFgKOgFBSsZEic27M9fUmPvfRCJv1isJUZahJ8MfY/Bpp
         xhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735264341; x=1735869141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DO6BLM5CMOo/wBOU4R18TkGC6gkh5CUUEjeVIIwslA=;
        b=HSNKkXRrK0plyBdpKh4w4yWdJYzTIvse6/gbRWMxv++6yLRrkYZIBYiCSIZn59btfL
         pWBcVg8CnCNTHbvT668Tdm3wvXSWAcTBpzpbRoyt+2SzSnGe4tceBTdF5OeE6uZbLcSA
         opg5fj+5y6kkXhfQTV5qlndZbt8LaP/JuIkMcJXsmzcPZT5yjKka+J7eVgTIwtXKHs9G
         QldWSalZLShXCix7d12DG+5GOVgKulxia3m1wBqmOUGbRtxbs8JNgxd4/Cp46TPcEGfd
         3MWEnqehMPCxJW8XRF4VHvobdtvb0ges+gu2I7000Oyt8Fvc/G63oqH4rcwpFv/DNOEm
         bM5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkfFCckQLOnSb3DLpZdnujO7aDJO2FUnVOwn6kRqldD1cs4qTRb/A7sjFhlV2M8xI+TCVGYHbP2HQVaPGE@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYi+4stDjY60DknQligWkbwddcyUKURsmnECKSn7ZSiE2b9Vh
	QWomnxa/S1DVm/hIE4WlKnYDdAR2E5sl05d4lxmv6Q3iSy3uwWb7KZeWzBxEgxfWjoRyD1RsCuj
	DuP2RM8nbDVaS8smaw+XkbQdHYG5vja6pVw==
X-Google-Smtp-Source: AGHT+IH4sl3E4JdQ3Zzj9j9rlWOFgu6cDoaF1zsaqwb/U//n/TSWDC0MOEarXx8wBC5QemWNASyhP4U5bzLV21KlRPbd6w==
X-Received: from pfbbx13.prod.google.com ([2002:a05:6a00:428d:b0:725:a760:4c72])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:680b:b0:1e1:a0b6:9872 with SMTP id adf61e73a8af0-1e5e045a333mr37386543637.11.1735264341098;
 Thu, 26 Dec 2024 17:52:21 -0800 (PST)
Date: Thu, 26 Dec 2024 17:52:00 -0800
In-Reply-To: <20241227015205.1375680-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241227015205.1375680-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241227015205.1375680-3-isaacmanjarres@google.com>
Subject: [RFC PATCH v2 2/2] selftests/memfd: Add tests for F_SEAL_FUTURE_EXEC
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: surenb@google.com, kaleshsingh@google.com, jstultz@google.com, 
	aliceryhl@google.com, jeffxu@google.com, kees@kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add tests to ensure that F_SEAL_FUTURE_EXEC behaves as expected.

Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index c0c53451a16d..abc213a5ce99 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -31,6 +31,7 @@
 #define STACK_SIZE 65536
 
 #define F_SEAL_EXEC	0x0020
+#define F_SEAL_FUTURE_EXEC	0x0040
 
 #define F_WX_SEALS (F_SEAL_SHRINK | \
 		    F_SEAL_GROW | \
@@ -318,6 +319,37 @@ static void *mfd_assert_mmap_private(int fd)
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
@@ -998,6 +1030,52 @@ static void test_seal_future_write(void)
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
@@ -1639,6 +1717,7 @@ int main(int argc, char **argv)
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
+	test_seal_future_exec_mapping();
 
 	if (pid_ns_supported()) {
 		test_sysctl_simple();
-- 
2.47.1.613.gc27f4b7a9f-goog


