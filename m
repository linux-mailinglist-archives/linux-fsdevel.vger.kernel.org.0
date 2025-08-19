Return-Path: <linux-fsdevel+bounces-58336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED909B2CC01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 20:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0966522FEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 18:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B91E31AF1F;
	Tue, 19 Aug 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKdFI2Zv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78730F544
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628140; cv=none; b=Lv131JtsZqKckspMd/6L7afFZsaBbOt2KD5ap7KzAy+hfx2jNth8G59MJIac7olrQTrsf/RBxNiVfR/w9Lfm7NfjRMNIcer+C+o7XMN+jYoR95Br16MQuFsUpS4/WAMT77kT8D7iJEmglZvtTv5FPePZ7J+0XxOXc9Jcgc27u7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628140; c=relaxed/simple;
	bh=kk8ZSjqH9S2LHcN0Lry+FBRFtiGBmlhL72XCnLUmyKs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HwCg6JqeHqMGKszsv+8QG5q5l064hFCG2zbwJWEOzadpw208WIJdNemfYgyNHd6vAyhleLmJN0pvnB3BYonvoqSso8eANLjZt9iiZ8qSdOKZ9Y4+N3SDFpI7zBneZrSmHhYLuZqGnJtOucnR7N/t2RNC8+ARdDXQDMcVsehXd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKdFI2Zv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7af30a5so943606866b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755628136; x=1756232936; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1REv6wkwkWvJsKi6/IEAux2yc+B85lDNBOjsADT4/Ow=;
        b=SKdFI2ZvgROrj1IPhGI+IFjW1GgBoNMcSE/X8a47rHIWSsVdzbWbkogoUQwnGsgGD9
         1CSYl0WbVq4sPlZhZSbXAL8KHMfSsLXZUbAa8jCMfJmg70uNtNnnWh5FRS1x1TYmGEeL
         tlCzwuA0KK07kj47mbCPW5DQDxcyIlje0KQ+DIrKjzORQUb2MuBHNZmJb7FMPJC8gwyv
         EsQOBQk3EHsir1Vi0U4DlEUmTmyJecS+qMGl4YwsXjsxdkvQkad6HD7bM0p5Vaqj5bn1
         4ncYvnPUTcQZRh0MzGfzcxmJrJK8SBWBqZ2IloP/aR9n4IT2ZfycXnN3CLBIdk5EpxuO
         +FEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628136; x=1756232936;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1REv6wkwkWvJsKi6/IEAux2yc+B85lDNBOjsADT4/Ow=;
        b=E1Lr++rCl+Cj8PbtVWr6STOCbm9MIqXeRmrAkUEUt3efATIG0f1D20dvw0TKeM4mCK
         +Z+fXn2YVxJdRK9BFDO8aeVXKW8aRJA8nRwyuws1KS8xdQL+fk7ejPve9nhErUqadzvZ
         QClCHF2Gqo2ASXOzURjfmhkOKOmpNYEZzvryJkPBfCM5ek37HWqxuoudx7AfvLtWJuu0
         rEzqyOlXKhVP/xhtZIClADjhMJpv+yaiBEVkuDFJXgRoOLYvcD/pWe955JcJ/T30MlWm
         WKwhH1Xi1WrTRBLIfM+WirjalIVoCVg+blatvk3ezQyPHYq1QPjAhSuhuUUOWZQGksEq
         XuGQ==
X-Gm-Message-State: AOJu0Yx/f/snP4DdqxIXJmbKcdDNY/0f9K9z3SSbpGuRQcVOIIONe+Nb
	PCZ1OuO/7D9LOvsp/e1RbotvMA/JBwU1vqhGROtOXf/f3vOFDlj/OmJ6g5O7
X-Gm-Gg: ASbGnct6N7zf+XoM6MnCjdV2+jq4G0md89K+Wb88taFUbxcawT43aFqCe7UU5C15v0O
	RFrgbyeG75uP8ZxAHDycAz1S1CYSuaFdpEbaR8JYzZjWEtOeThJNhHATJ20ymX13arL6ZWmZoBt
	xx1G6HiyI/769/Miea/822YPI7wSg5DTBtBktE3LpW6zj+M+ba0Lq2soqR88ce02xjyTUE1OUaX
	ztozId+Wb/V3ozswyg4mYjDoUWuwg3YW/FRs0JH65C6A5zm+NkCPOl0ou4DingNy/KyiQrLeX4P
	ItYJoUYY5py8cO9CzjGynjD4r0fg448t5Hq2Ea0F89YfP65+AEKIAxEIHCtPAwHPHsLrYfHL8Y/
	aRSsmwIfPcFEbpLZ33m73
X-Google-Smtp-Source: AGHT+IGQWK1SHpqvuQiFaiOrstHBPUaMXUTc5hdZUyH8IcVZT7nAYuKsADYF8FXm8mXq/d/pxj4KRQ==
X-Received: by 2002:a17:907:1c84:b0:ae9:b800:2283 with SMTP id a640c23a62f3a-afddcbae4admr333189066b.15.1755628136190;
        Tue, 19 Aug 2025 11:28:56 -0700 (PDT)
Received: from p183 ([46.53.253.120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded478d69sm26678766b.73.2025.08.19.11.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:28:55 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:29:16 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: test lseek on /proc/net/dev
Message-ID: <aKTCfMuRXOpjBXxI@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From 0991340050b201c6fcbe623b9869ef3a96c133c9 Mon Sep 17 00:00:00 2001
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 19 Aug 2025 21:19:17 +0300
Subject: [PATCH 1/1] proc: test lseek on /proc/net/dev

This line in tools/testing/selftests/proc/read.c was added to catch
oopses, not to verify lseek correctness:

        (void)lseek(fd, 0, SEEK_SET);

Oh, well. Prevent more embarassement with simple test.
---
 tools/testing/selftests/proc/.gitignore       |  1 +
 tools/testing/selftests/proc/Makefile         |  1 +
 .../selftests/proc/proc-net-dev-lseek.c       | 68 +++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/proc/proc-net-dev-lseek.c

diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index 19bb333e2485..243f4537a670 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -7,6 +7,7 @@
 /proc-loadavg-001
 /proc-maps-race
 /proc-multiple-procfs
+/proc-net-dev-lseek
 /proc-empty-vm
 /proc-pid-vm
 /proc-self-map-files-001
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index 50aba102201a..2a9547630115 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -10,6 +10,7 @@ TEST_GEN_PROGS += fd-003-kthread
 TEST_GEN_PROGS += proc-2-is-kthread
 TEST_GEN_PROGS += proc-loadavg-001
 TEST_GEN_PROGS += proc-maps-race
+TEST_GEN_PROGS += proc-net-dev-lseek
 TEST_GEN_PROGS += proc-empty-vm
 TEST_GEN_PROGS += proc-pid-vm
 TEST_GEN_PROGS += proc-self-map-files-001
diff --git a/tools/testing/selftests/proc/proc-net-dev-lseek.c b/tools/testing/selftests/proc/proc-net-dev-lseek.c
new file mode 100644
index 000000000000..742a3e804451
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-net-dev-lseek.c
@@ -0,0 +1,68 @@
+/*
+ * Copyright (c) 2025 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+#undef _GNU_SOURCE
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+#include <sched.h>
+/*
+ * Test that lseek("/proc/net/dev/", 0, SEEK_SET)
+ * a) works,
+ * b) does what you think it does.
+ */
+int main(void)
+{
+	/* /proc/net/dev output is deterministic in fresh netns only. */
+	if (unshare(CLONE_NEWNET) == -1) {
+		if (errno == ENOSYS || errno == EPERM) {
+			return 4;
+		}
+		return 1;
+	}
+
+	const int fd = open("/proc/net/dev", O_RDONLY);
+	assert(fd >= 0);
+
+	char buf1[4096];
+	const ssize_t rv1 = read(fd, buf1, sizeof(buf1));
+	/*
+	 * Not "<=", this file can't be empty:
+	 * there is header, "lo" interface with some zeroes.
+	 */
+	assert(0 < rv1);
+	assert(rv1 <= sizeof(buf1));
+
+	/* Believe it or not, this line broke one day. */
+	assert(lseek(fd, 0, SEEK_SET) == 0);
+
+	char buf2[4096];
+	const ssize_t rv2 = read(fd, buf2, sizeof(buf2));
+	/* Not "<=", see above. */
+	assert(0 < rv2);
+	assert(rv2 <= sizeof(buf2));
+
+	/* Test that lseek rewinds to the beginning of the file. */
+	assert(rv1 == rv2);
+	assert(memcmp(buf1, buf2, rv1) == 0);
+
+	/* Contents of the file is not validated: this test is about lseek(). */
+
+	return 0;
+}
-- 
2.49.1


