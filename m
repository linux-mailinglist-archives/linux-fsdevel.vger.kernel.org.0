Return-Path: <linux-fsdevel+bounces-30470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8891098B8D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 12:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377B2282C62
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB79E1A01B9;
	Tue,  1 Oct 2024 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0U/jHsR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67EC15099B;
	Tue,  1 Oct 2024 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776950; cv=none; b=FEeYi3gcXY4x40LWbqh13nx5z5alUtomgIcFLcaHKjz/8FMtjToQK6X1HRLAHwc+ReF9GZU3RpzMo3jMpkg9aauylMae6sSJSu71UwVe3lAnRjsqCe2J3ldSKTk0fsAYmhvHLCxT3jz0sHRTlVTX60bwii6Xm6Y9Vo2dFDAJ8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776950; c=relaxed/simple;
	bh=ZE+XF1/1NQ0XkNgNQxpngChw8V26A33RUz+IkoejLpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hn+nfoV/88NPMaAzzOixVaM9AmhEUjG3fKRNgdf0NBawXxvEmavw8RIBVa6oOAvqtUEjBFiAxKzohmaZf/U2GOCbLRCAwdYQQSPMBWsYuzjWoJzjLK3ccsGHdY4eGH23oF/gXHHpITdU1ahp4o+Nkbec8m3kclELi2Do63nw2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0U/jHsR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b9b35c7c7so10812345ad.1;
        Tue, 01 Oct 2024 03:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727776948; x=1728381748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7AiVXDQNaCEQCZIzuaPudvTxMDTECJeNuKQJM59klM=;
        b=R0U/jHsRmTa5+6/dXMJC6pn1uysSEncA7CpCbwkbBbFy7DMj1HcNItB05jZYjkC+yK
         d7ECWEub768wGg2JwcJ3qVv4SjRb10RBxqJ97jjTSgvBTPwV8/tAjFjY3qjOmDnHptHd
         Fz19CapGjLF/6ybGQO5jXI2pjL90wTJHnIjDtc2lYY78hD6giIym0I0OTzLY5II7+FFD
         +zrIueYILtMWry4W5y8XfG/sxOlZ8wYOjSnE9bbeaakgWEfcgAT03LdOMYmnsU8lKpWt
         2Qq7ip8ViiJTPX2VVOZNhP8v/WwO5XkH0lqxj79mrjR5J40texOINbkuTW2Ty6TZMtB8
         y+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727776948; x=1728381748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7AiVXDQNaCEQCZIzuaPudvTxMDTECJeNuKQJM59klM=;
        b=bE+RWionhEzM4LSPw9N5EEaAhbrdY7LLWbe9XMlVlgXPASJ7RuXjcWsHIomUIX2SZm
         cWimnijoqiEcogvmH0nNCBKQuPYQfmLOG5hA9C9Bzm3MJsqR5EhbRZ/n9SVzkFZirn01
         1QFfoW7sgp4SQvRtP943XdAAnGSG3hHI0FI3xrMEQdlBjn0TXmxV8aPi+3e2fAm+GvuK
         6T6fqlZYAXWU2sf8btelVeBTT8jh7KrBHctg5rdl/ZXwOgdsnGSTF8ul2Rp3BrfkyEc6
         b3NuXGF7plM7ySc0sgqPSlo1FCdn9GH52AX/+BCYzT/c1kckJePSa03lAGBNGf2WSCBX
         /HEA==
X-Forwarded-Encrypted: i=1; AJvYcCURKBdxw7oNsbAMfnJRH/n7qIQUwGX0WgP9IRoixstB7ZOYDyjUpdlGM/NlGkfPiZRy8sXtGZ8O+dJHPzeS@vger.kernel.org, AJvYcCXL2KSlzRG9GlbmZ/TQeQE7qTs86hic6+dvjk9xC9ZkMbZIiKB/4/XJX+tdaLcge1Yx8npdGwU4rs84LmL3QwfY@vger.kernel.org
X-Gm-Message-State: AOJu0YxO6B3034lekduqhDs7FdAoM1bZTdxAWK9u/vArbxRrIYFsJKxg
	8GCj3cxT9kRJ2eOxVya3W30kxBPlsn/MMIiEmBG56ihgAfQdSzv7M6INeiaq
X-Google-Smtp-Source: AGHT+IGG294ztucO/TfZv6LCV+TnkGPzng11YoQlw/h1wqLGFs6Z6c8cL1xJg0F1dE41+VSuEZB5Fg==
X-Received: by 2002:a17:902:e887:b0:20b:9841:b44d with SMTP id d9443c01a7336-20b9841b6c1mr62242545ad.9.1727776947990;
        Tue, 01 Oct 2024 03:02:27 -0700 (PDT)
Received: from BiscuitBobby.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d5edd1sm66955705ad.57.2024.10.01.03.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:02:27 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: shuah@kernel.org
Cc: amer.shanawany@gmail.com,
	Siddharth Menon <simeddon@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/proc: Add test to check unmapped process
Date: Tue,  1 Oct 2024 15:32:06 +0530
Message-Id: <20241001100206.18554-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce test 'test_proc_pid_mem' to address the issue in the TODO.
Check if VMsize is 0 to determine whether the process has been unmapped.
The child process cannot signal the parent that it has unmapped itself,
as it no longer exists. This includes unmapping the text segment,
preventing the child from proceeding to the next instruction.

Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 v1->v2: Removed redundant parenthesis, fixed other checkpatch warnings.
 Revised commit message based on feedback.
 
 tools/testing/selftests/proc/proc-empty-vm.c | 56 +++++++++++++++++---
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index b3f898aab4ab..bfb7f8823529 100644
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
+		if (errno == ENOENT)
+			/* Process does not exist */
+			return EXIT_SUCCESS;
+
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
+		/* Check for VmSize */
+		if (strncmp(line, "VmSize:", 7) == 0) {
+			if (sscanf(line, "VmSize: %d", &vm_size) == 1)
+				break;
+			perror("Failed to parse VmSize.\n");
+		}
+		line = strtok(NULL, "\n");
+	}
+
+	close(fd);
+
+	/* Check if VmSize is 0 */
+	if (vm_size == 0)
+		return EXIT_SUCCESS;
+
+	return EXIT_FAILURE;
+}
+
 static int test_proc_pid_maps(pid_t pid)
 {
 	char buf[4096];
@@ -500,14 +547,11 @@ int main(void)
 #endif
 		return EXIT_FAILURE;
 	} else {
-		/*
-		 * TODO find reliable way to signal parent that munmap(2) completed.
-		 * Child can't do it directly because it effectively doesn't exist
-		 * anymore. Looking at child's VM files isn't 100% reliable either:
-		 * due to a bug they may not become empty or empty-like.
-		 */
 		sleep(1);
 
+		if (rv == EXIT_SUCCESS)
+			rv = test_proc_pid_mem(pid);
+
 		if (rv == EXIT_SUCCESS) {
 			rv = test_proc_pid_maps(pid);
 		}
-- 
2.39.5


