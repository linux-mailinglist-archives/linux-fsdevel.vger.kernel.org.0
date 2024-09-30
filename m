Return-Path: <linux-fsdevel+bounces-30387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CF098A983
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 18:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C09D286C63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69438195FD1;
	Mon, 30 Sep 2024 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzvPkONX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DAC13F43A;
	Mon, 30 Sep 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712684; cv=none; b=NbfEDUBzIraBn3kiMNaffDNvsaoP/uavAqKJmP4iXpCTpVXDdTaB2+WK73Zt7tAPQRygA7jn5JM8ec11e4hP6ui0ISBIh+gqFW5ULveXBbn1D+f4Y4+w9K15ffsXbIEecn5ucgM1w36ATS7epIUZzaThlVhcbW9wKx2caxMXROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712684; c=relaxed/simple;
	bh=8+OVRreonuvkTKuC1HI/6B9AZ4oAZdT2gdk7ln9ZFH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Re5YPwltbzYPGffB7yOI5d5E3aZgo1J9PcFW9dKCpx7ckjWZ57rRqqC6NdAVIu0DnRwL218Zf8s+QDx05vYd6b7t21oASSOXieolTqDOgIN4FaB4BpQ1OVBHLfGzNoaSGVUcxPr5sruk5kqR9TuL/ZxxCPX/dSDP8844+DsQylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzvPkONX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-719b17b2da1so3279501b3a.0;
        Mon, 30 Sep 2024 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727712683; x=1728317483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQkiXIQ41ha4J31LRfSNYWTwIsS7OY5TSI8WxyVPd4g=;
        b=FzvPkONX2y2Y6pVFPxO7Ygl+eZnUyjv0v5da/5CnBLDyugHPpLwC7RHPw4goW7PfMG
         cVS/T3+9ijeGC++Ss5PfIV51RveMJyWmgUxiS0LF6rKQ5mROCHTd1zJKUv4mrmj7Z06/
         UPAcJ4Ns/y70Hpe/W4FLTlJArFJnWvan4rLVg9tSKA4P2yKO+YNRGsjJ9h8eUPnDTrHb
         Q8a7rzCRU80iHquEPMz8bksTjC7ZrYWel5D2Zr7zqAX2SwimUASEcynqcBwJ/nPYase3
         eEgeSIlwzkhMGcqbGbXziuLdbj/bGl4D/PGXs69R1G16jK9JJBUPQEKISDi90+ZlyOnc
         bo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727712683; x=1728317483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQkiXIQ41ha4J31LRfSNYWTwIsS7OY5TSI8WxyVPd4g=;
        b=mgCRggPDFXmMWan030L9Xdp6wg7m4Idl2HweNfaJ4+4ECPfIVM+L1cTDvtq6m0hs2N
         GYQ+69R3rOoWslPBirATW/ZyP5rVyYFG4jCNfvAzvYgTmoqwmIVoEwEDX+83E06xMBPv
         zsSE/OTN1e1aBHImBzrdQojVL/gVi+Mn/5uncMSOKSJEsyc6vWqMTnzFrWKxXlwOJonG
         4/e2K5qRpRt3DeJLIYAZ5n0f51oWMC0G2XV391zhm1oocDB/P25pHlNETAS0NjjvcLzq
         Btn6Wrw+NL18A5DRDV/7ukGSBbyVYn+8/Q76odBI74fduhy0w2yXvjw6YTWdoYElfoWo
         bZiw==
X-Forwarded-Encrypted: i=1; AJvYcCWakLa2ps2IKSsu2V0hK/HiREDqcC4uiUiML81p1LGjqbTIZ0oszleW8v0j3laqHf8KdEF8v9akF8iTHZ6JuVdz@vger.kernel.org, AJvYcCWi3+oSvdb8Azxw9SrksGS5hhceQC2a+b1P/OgvXnKI9sQsa1hY7Zsew3lzxzYt9v4l6/ItGpaQ+IBEgMGC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7QnRXB0LyKMdZlqClqfbo3t6+xsPwRauVLCdX5dD6E/mil9O5
	PQ+P3AUQtdVJDe+Z00XJq1qOi3eA4Bs2Di4S38v6fKeK1NR1QQ/TfFbpZDWa
X-Google-Smtp-Source: AGHT+IGIwxLKZ+cI5cm1TUV4imjcKpJhPVbagYMdCkjtn2z/EBBOGdT3Nt4W5u0X/0fmFKiKy0UpmQ==
X-Received: by 2002:a05:6a21:2fc7:b0:1cf:2853:bc6c with SMTP id adf61e73a8af0-1d4fa7b4ea2mr17646935637.33.1727712682556;
        Mon, 30 Sep 2024 09:11:22 -0700 (PDT)
Received: from BiscuitBobby.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264986eesm6395184b3a.38.2024.09.30.09.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:11:22 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: shuah@kernel.org
Cc: Siddharth Menon <simeddon@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/proc/proc-empty-vm.c: Test for unmapped process
Date: Mon, 30 Sep 2024 21:39:56 +0530
Message-Id: <20240930160955.28502-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if VMsize is 0 to determine whether the process has been unmapped.
The child process cannot signal the parent that it has unmapped itself,
as it no longer exists. This includes unmapping the text segment,
preventing the child from proceeding to the next instruction.

Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 50 ++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index b3f898aab4ab..8ee000b0ddd7 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -213,6 +213,53 @@ static void vsyscall(void)
 }
 #endif
 
+static int test_proc_pid_mem(pid_t pid)
+{
+	char buf[4096];
+	char *line;
+	int vm_size = -1;
+
+	snprintf(buf, sizeof(buf), "/proc/%d/status", pid);
+	int fd = open(buf, O_RDONLY);
+
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			// Process does not exist
+			return EXIT_SUCCESS;
+		}
+	perror("open /proc/[pid]/status");
+	return EXIT_FAILURE;
+	}
+
+	ssize_t rv = read(fd, buf, sizeof(buf) - 1);
+
+	if (rv == -1) {
+		perror("read");
+		close(fd);
+		return EXIT_FAILURE;
+	}
+	buf[rv] = '\0';
+
+	line = strtok(buf, "\n");
+	while (line != NULL) {
+		// Check for VmSize
+		if (strncmp(line, "VmSize:", 7) == 0) {
+			sscanf(line, "VmSize: %d", &vm_size);
+			break;
+		}
+		line = strtok(NULL, "\n");
+	}
+
+	close(fd);
+
+	// Check if VmSize is 0
+	if (vm_size == 0) {
+		return EXIT_SUCCESS;
+	}
+
+	return EXIT_FAILURE;
+}
+
 static int test_proc_pid_maps(pid_t pid)
 {
 	char buf[4096];
@@ -508,6 +555,9 @@ int main(void)
 		 */
 		sleep(1);
 
+		if (rv == EXIT_SUCCESS) {
+			rv = test_proc_pid_mem(pid);
+		}
 		if (rv == EXIT_SUCCESS) {
 			rv = test_proc_pid_maps(pid);
 		}
-- 
2.39.5


