Return-Path: <linux-fsdevel+bounces-72116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97446CDEF4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 20:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7F34301227F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 19:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609AA2989BC;
	Fri, 26 Dec 2025 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOTCoBDe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24501257824
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Dec 2025 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766778924; cv=none; b=r8PiP6Cad+od8d2V9ICdppyoSNoLPwskvNK8W5q8PdgFUsikLypuvqRsLG2cPY0xE3hjznE5zq4T+CDaElIvulxshJ0E/Rkb5GbHn6u1fI9/chUWtxlQ0/7Ha9FzA6bfmHmOFBVyz8oTtWjMQ4Pcpg1beLUsrD/JWzk8qvtzqy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766778924; c=relaxed/simple;
	bh=y0eeyInOH/AIg6NutvYQeOZ0LyR6GWlgPWgYp17PDAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUDxuX1mzPdsZC48i324DQ9SirfmbrwrxXzxY/JATNFtJq0g865DjRRBDJAGKoNLnm4ALvToi//OrR4DpDUSiE9Qh3HG6mH3ntGKRb6oX/9fN4LCpa9SnrVm5svbt4VQIsttOXIgvX68LOPq61o9E0hnVJ+GSDxHD8Uh6RluTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOTCoBDe; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37b95f87d64so60882661fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Dec 2025 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766778921; x=1767383721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ7wyrGQbKhbSZ1qkyBpRXfcM3pVMOETN7OPFmbDZho=;
        b=gOTCoBDeOY9KuiZeHHMXOvSQqfWcKwR037RYssRY0knway2ve5SVRHrm2Pbz6mye/a
         MVMn/7pS4houxbdWVvfJ0KvGXvoSi7e7NxZh3AJ+jsDvUg1wzsuTV5hT+MNFWh5MGXS1
         2UQlzi2S5OTKf8BQ7ayHOpFR9e5aaD0Wz/NzE0i1UEPCIvjS7oHQ8oYb5JJQ49Dzzj4z
         Xg1PvfgaM8LgMYAImlpaZDrK+0g0izwS2rrisg4gS3YSKhvAleEFdUt+q10uyU/5LSAp
         dUWrIIrckpRAjjJrFdR2eVwX88WsHIPzhOO2VMNlEt08eOg8vvjzL2oSugJtJEReIm2R
         aYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766778921; x=1767383721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZ7wyrGQbKhbSZ1qkyBpRXfcM3pVMOETN7OPFmbDZho=;
        b=LR/BUZ5eulsWaJE34idJKFK7sOsoKlZxb/aDiuCeLenU3UYcioDnBnxMhdEhnzIXz+
         lcxidjVYmhsp5HWRW2Dx8YAGe7cOKY7ekT823JyO9SKOBXUT0npXtY82WTnKBkTHUjfo
         u2OsvKhUn63dME/ziR0MTh8yr1xNJ0CBWcD5LIrYiUaMIB3E9cmjEi3bWKudLt7j56Mk
         IfjFCoR9Ww8AcybfXbuqviv3JF5G5gXngHHQOn7Gi9pqmubATJv8nP+5LvlBg6SP5oGJ
         dZq5gjF0+YGfyY3lh4r2ARNjh2a312NcnnFhjrawd7CljfM3ZPMla+TxB8pgi4Iosh0Y
         1stw==
X-Gm-Message-State: AOJu0YwhktOlQtvXG/gZUayOc8x0MxZU3hzDpyD1r+wUqMiwCDQuxLPD
	8JneS3/Sb5PyzyzPPqtyRT1PE0mh2cv6TPNf63abIevpfHgd9vh70nrk1gHC
X-Gm-Gg: AY/fxX5h/6BmTPF10DnATUPbghCphtvNlAlAzZ0gLjDrBlcpngc4n+c7zhjUOUuREYA
	QvBmY0v1J/rNHL8G0sD1wXWTJysdD1hnXXe3DF6gYJ12SKZn/jet/VOPaV2N1pIj1NoGoUv2kU/
	vc/EVglHh3R+GAjiXp4Pe0Uj+rWI4UpEx8l51x1PL5WzM6q8/ZfgY74/U/MbwaRCcEoJJRcQ5T5
	DLo3mYmevbrTWWwEPi0eeICCuy9H0/L6vJm/hzdCfYq5+hhx8o0aV+d0GcDYNZ8tTjdqEaEM/Li
	8oEjY8FDU34f0yJKuwS7WJAibHLNlcDpCZFlxbXNbGeXH8FOFsHRv5gWubKFywCRpw2KggRp0SS
	hAZ+7R9pBiX62YecPTeo3luGn7bRf9933k+sVIiE8qZDvpv5nnxCzEaCFPLktBoVlhOJ7vDqdmJ
	4=
X-Google-Smtp-Source: AGHT+IEgTr4LvCZev/7h3JR1Phz8GPGj4AW1DaTe1GXBLMXWI2FBM/C0duRBVHm4/Nu2XwhXBIPOjQ==
X-Received: by 2002:a05:651c:1506:b0:37b:9101:77e6 with SMTP id 38308e7fff4ca-381215699edmr71348711fa.15.1766778920951;
        Fri, 26 Dec 2025 11:55:20 -0800 (PST)
Received: from p183 ([178.172.146.10])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812251cfffsm63088951fa.19.2025.12.26.11.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 11:55:20 -0800 (PST)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adobriyan@gmail.com
Subject: [PATCH 1/1] proc: test lseek on /proc/net/dev
Date: Fri, 26 Dec 2025 22:55:35 +0300
Message-ID: <20251226195536.468978-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251226195536.468978-1-adobriyan@gmail.com>
References: <20251226195536.468978-1-adobriyan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


