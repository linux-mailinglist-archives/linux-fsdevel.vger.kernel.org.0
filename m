Return-Path: <linux-fsdevel+bounces-50689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBC0ACE70B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 01:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732E03A9823
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 23:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1ED26F45F;
	Wed,  4 Jun 2025 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fH0QlMrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDB26E161
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749078743; cv=none; b=s5LaK394xgEm/ZMDjZsL1OwM59NFqJgJ5juPhqV0bTog57HjPDs3Bv1MWrmBeEAiIBEfcnn1aEm7r9n01xol7xLVHruUSUGhu/D3zung2AECIQcaIYHR58Lv1xsPLNsXTKilmxdGnI2Aw9MTM7FRItPdtqWQSiiMDginIQ6NoIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749078743; c=relaxed/simple;
	bh=z2DbDqrG+WdnYT3JLkcesaO7eJDDDgIsulEtXiN3f4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fasJFMYc33duQHdOEJ+mXWy0EcoKPGF6DeESGY69MYo0f/pawMsn7pIS4WTCYpqe4UrkgOQAZOMm38AcPXi7Zc15ZDYcSpDBqWPK1TD+wCFB92uqjBKbTeKnKNnIVtuM9ayuB/bQeKJknaYHjreqV5+m1xLLPdyJg2jc0KY1GPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fH0QlMrf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so224470a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 16:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749078741; x=1749683541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uX7f/oYi039hOEGUuQCFp5nsI+yVset2xzObgJBZfGE=;
        b=fH0QlMrfY7z4zEXkTEZM/gt0jZN0dycj/7CYGSA7dE0czUf6LHwPvyGg7VPbM+zIye
         vdbdZ0jF21enLN+ahuC3MhAnrIA+70UAI0iZjjLF4In7A/Sb2vOnCygZEDgL65Cx0xnV
         ZRPriaUfnJtXeS6e9j8mP3oEofgVOFp2kPnbilqCdR9ZxEcTbAKEIZZw4oCU0O1abQd0
         7UHtz6MV8Fa+m2Q0bKQbXsiCB1BthcYlgZI58hTCt/ipZK+0FgCaZ7fguW52i7gsndyF
         YXZh6TqjSoDRpPa/s2mOxEjCTFZ2XwevEiI/S9aDC3EcMBVdY0nZmkPoCbc2nxrpr0E5
         0A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749078741; x=1749683541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX7f/oYi039hOEGUuQCFp5nsI+yVset2xzObgJBZfGE=;
        b=mbwuQjpAl9b9QlZaymNJ2Asdpv8hhnZeiEQ549lcS9kyVlXqaKlPe9eGayx142sy7C
         dNg1LTAPaG+/gGkNGsGoTSqio2yfc0TvQTxBIv0YHklWSKTK//Emv8Z+qmek3n8ZdgyR
         B7Zrba6iHmVmFH1+VK0fdUUWMdzkSIwec78gFuTX2S8R+EXMwN0pFKZ3ZbIMjfwleEJ5
         Yf8/kNmiBneYyU8y7nal30CVwrVDhkbZSnJ+kX8m60kkmfjH5NPXVbCbTOFsCGmzFUXr
         UF0QWNki3lyZIijqL1+HILcOOzaZNv6G2uLSS6VWUA2fBkDWnkymqpGZm+P7EBXTUA0f
         Z40g==
X-Forwarded-Encrypted: i=1; AJvYcCXaJBe+uowpY+bqnAdeb62nm3GnKNiPGsikR2gLz2WWMt0FIypJGYqVzrxdweg3mGzZs3P7zfIyXqh6d9jH@vger.kernel.org
X-Gm-Message-State: AOJu0YxziLG0baG3S30iE2s02AfDqEEVtA/+naumnFBrFP9zPTXe+Rar
	18mdLit6S7W7M/PRlnIMFqNNEZOxQgeu9KW9FfY/Pckx2UwW+DudmtlL6nqCqa99KIQlLXQf58r
	FWYccpQ==
X-Google-Smtp-Source: AGHT+IEvOm4giMwyQY/nBon3zP7C1/mYlQqoAkTz9AmnFoIjTjGx4SJrzcD+9iyAMTj1D4aadzcKOMv8LOo=
X-Received: from pjbsi6.prod.google.com ([2002:a17:90b:5286:b0:2e0:915d:d594])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:4cc4:b0:313:14b5:2532
 with SMTP id 98e67ed59e1d1-31314b5327fmr3503349a91.34.1749078740989; Wed, 04
 Jun 2025 16:12:20 -0700 (PDT)
Date: Wed,  4 Jun 2025 16:11:49 -0700
In-Reply-To: <20250604231151.799834-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604231151.799834-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.1266.g31b7d2e469-goog
Message-ID: <20250604231151.799834-6-surenb@google.com>
Subject: [PATCH v4 5/7] selftests/proc: add verbose more for tests to
 facilitate debugging
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Add verbose mode to the proc tests to print debugging information.
Usage: proc-pid-vm -v

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 154 +++++++++++++++++++--
 1 file changed, 141 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index b582f40851fb..97017f48cd70 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -73,6 +73,7 @@ static void make_private_tmp(void)
 }
 
 static unsigned long test_duration_sec = 5UL;
+static bool verbose;
 static int page_size;
 static pid_t pid = -1;
 static void ate(void)
@@ -452,6 +453,99 @@ static void stop_vma_modifier(struct vma_modifier_info *mod_info)
 	signal_state(mod_info, SETUP_MODIFY_MAPS);
 }
 
+static void print_first_lines(char *text, int nr)
+{
+	const char *end = text;
+
+	while (nr && (end = strchr(end, '\n')) != NULL) {
+		nr--;
+		end++;
+	}
+
+	if (end) {
+		int offs = end - text;
+
+		text[offs] = '\0';
+		printf(text);
+		text[offs] = '\n';
+		printf("\n");
+	} else {
+		printf(text);
+	}
+}
+
+static void print_last_lines(char *text, int nr)
+{
+	const char *start = text + strlen(text);
+
+	nr++; /* to ignore the last newline */
+	while (nr) {
+		while (start > text && *start != '\n')
+			start--;
+		nr--;
+		start--;
+	}
+	printf(start);
+}
+
+static void print_boundaries(const char *title,
+			     struct page_content *page1,
+			     struct page_content *page2)
+{
+	if (!verbose)
+		return;
+
+	printf("%s", title);
+	/* Print 3 boundary lines from each page */
+	print_last_lines(page1->data, 3);
+	printf("-----------------page boundary-----------------\n");
+	print_first_lines(page2->data, 3);
+}
+
+static bool print_boundaries_on(bool condition, const char *title,
+				struct page_content *page1,
+				struct page_content *page2)
+{
+	if (verbose && condition)
+		print_boundaries(title, page1, page2);
+
+	return condition;
+}
+
+static void report_test_start(const char *name)
+{
+	if (verbose)
+		printf("==== %s ====\n", name);
+}
+
+static struct timespec print_ts;
+
+static void start_test_loop(struct timespec *ts)
+{
+	if (verbose)
+		print_ts.tv_sec = ts->tv_sec;
+}
+
+static void end_test_iteration(struct timespec *ts)
+{
+	if (!verbose)
+		return;
+
+	/* Update every second */
+	if (print_ts.tv_sec == ts->tv_sec)
+		return;
+
+	printf(".");
+	fflush(stdout);
+	print_ts.tv_sec = ts->tv_sec;
+}
+
+static void end_test_loop(void)
+{
+	if (verbose)
+		printf("\n");
+}
+
 static void capture_mod_pattern(int maps_fd,
 				struct vma_modifier_info *mod_info,
 				struct page_content *page1,
@@ -463,18 +557,24 @@ static void capture_mod_pattern(int maps_fd,
 				struct line_content *restored_last_line,
 				struct line_content *restored_first_line)
 {
+	print_boundaries("Before modification", page1, page2);
+
 	signal_state(mod_info, SETUP_MODIFY_MAPS);
 	wait_for_state(mod_info, SETUP_MAPS_MODIFIED);
 
 	/* Copy last line of the first page and first line of the last page */
 	read_boundary_lines(maps_fd, page1, page2, mod_last_line, mod_first_line);
 
+	print_boundaries("After modification", page1, page2);
+
 	signal_state(mod_info, SETUP_RESTORE_MAPS);
 	wait_for_state(mod_info, SETUP_MAPS_RESTORED);
 
 	/* Copy last line of the first page and first line of the last page */
 	read_boundary_lines(maps_fd, page1, page2, restored_last_line, restored_first_line);
 
+	print_boundaries("After restore", page1, page2);
+
 	mod_info->vma_mod_check(mod_last_line, mod_first_line,
 				restored_last_line, restored_first_line);
 
@@ -546,6 +646,7 @@ static void test_maps_tearing_from_split(int maps_fd,
 	mod_info->vma_restore = merge_vma;
 	mod_info->vma_mod_check = check_split_result;
 
+	report_test_start("Tearing from split");
 	capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
 			    &split_last_line, &split_first_line,
 			    &restored_last_line, &restored_first_line);
@@ -558,6 +659,7 @@ static void test_maps_tearing_from_split(int maps_fd,
 	struct timespec start_ts, end_ts;
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	start_test_loop(&start_ts);
 	do {
 		bool last_line_changed;
 		bool first_line_changed;
@@ -577,12 +679,17 @@ static void test_maps_tearing_from_split(int maps_fd,
 			 * In that case new first line will be the same as the
 			 * last restored line.
 			 */
-			assert(!strcmp(new_first_line.text, split_first_line.text) ||
-			       !strcmp(new_first_line.text, restored_last_line.text));
+			assert(!print_boundaries_on(
+					strcmp(new_first_line.text, split_first_line.text) &&
+					strcmp(new_first_line.text, restored_last_line.text),
+					"Split result invalid", page1, page2));
+
 		} else {
 			/* The vmas should be consistent with merge results */
-			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
-			       !strcmp(new_first_line.text, restored_first_line.text));
+			assert(!print_boundaries_on(
+					strcmp(new_last_line.text, restored_last_line.text) ||
+					strcmp(new_first_line.text, restored_first_line.text),
+					"Merge result invalid", page1, page2));
 		}
 		/*
 		 * First and last lines should change in unison. If the last
@@ -607,7 +714,9 @@ static void test_maps_tearing_from_split(int maps_fd,
 			vma_end == split_first_line.end_addr));
 
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+		end_test_iteration(&end_ts);
 	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
+	end_test_loop();
 
 	/* Signal the modifyer thread to stop and wait until it exits */
 	signal_state(mod_info, TEST_DONE);
@@ -654,6 +763,7 @@ static void test_maps_tearing_from_resize(int maps_fd,
 	mod_info->vma_restore = expand_vma;
 	mod_info->vma_mod_check = check_shrink_result;
 
+	report_test_start("Tearing from resize");
 	capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
 			    &shrunk_last_line, &shrunk_first_line,
 			    &restored_last_line, &restored_first_line);
@@ -666,6 +776,7 @@ static void test_maps_tearing_from_resize(int maps_fd,
 	struct timespec start_ts, end_ts;
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	start_test_loop(&start_ts);
 	do {
 		unsigned long vma_start;
 		unsigned long vma_end;
@@ -682,12 +793,16 @@ static void test_maps_tearing_from_resize(int maps_fd,
 			 * again. In that case new first line will be the same
 			 * as the last restored line.
 			 */
-			assert(!strcmp(new_first_line.text, shrunk_first_line.text) ||
-			       !strcmp(new_first_line.text, restored_last_line.text));
+			assert(!print_boundaries_on(
+					strcmp(new_first_line.text, shrunk_first_line.text) &&
+					strcmp(new_first_line.text, restored_last_line.text),
+					"Shrink result invalid", page1, page2));
 		} else {
 			/* The vmas should be consistent with the original/resored state */
-			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
-			       !strcmp(new_first_line.text, restored_first_line.text));
+			assert(!print_boundaries_on(
+					strcmp(new_last_line.text, restored_last_line.text) ||
+					strcmp(new_first_line.text, restored_first_line.text),
+					"Expand result invalid", page1, page2));
 		}
 
 		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
@@ -701,7 +816,9 @@ static void test_maps_tearing_from_resize(int maps_fd,
 			vma_end - vma_start == page_size));
 
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+		end_test_iteration(&end_ts);
 	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
+	end_test_loop();
 
 	/* Signal the modifyer thread to stop and wait until it exits */
 	signal_state(mod_info, TEST_DONE);
@@ -757,6 +874,7 @@ static void test_maps_tearing_from_remap(int maps_fd,
 	mod_info->vma_restore = patch_vma;
 	mod_info->vma_mod_check = check_remap_result;
 
+	report_test_start("Tearing from remap");
 	capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
 			    &remapped_last_line, &remapped_first_line,
 			    &restored_last_line, &restored_first_line);
@@ -769,6 +887,7 @@ static void test_maps_tearing_from_remap(int maps_fd,
 	struct timespec start_ts, end_ts;
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	start_test_loop(&start_ts);
 	do {
 		unsigned long vma_start;
 		unsigned long vma_end;
@@ -785,12 +904,16 @@ static void test_maps_tearing_from_remap(int maps_fd,
 			 * again. In that case new first line will be the same
 			 * as the last restored line.
 			 */
-			assert(!strcmp(new_first_line.text, remapped_first_line.text) ||
-			       !strcmp(new_first_line.text, restored_last_line.text));
+			assert(!print_boundaries_on(
+					strcmp(new_first_line.text, remapped_first_line.text) &&
+					strcmp(new_first_line.text, restored_last_line.text),
+					"Remap result invalid", page1, page2));
 		} else {
 			/* The vmas should be consistent with the original/resored state */
-			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
-			       !strcmp(new_first_line.text, restored_first_line.text));
+			assert(!print_boundaries_on(
+					strcmp(new_last_line.text, restored_last_line.text) ||
+					strcmp(new_first_line.text, restored_first_line.text),
+					"Remap restore result invalid", page1, page2));
 		}
 
 		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
@@ -806,7 +929,9 @@ static void test_maps_tearing_from_remap(int maps_fd,
 			vma_end - vma_start == page_size));
 
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+		end_test_iteration(&end_ts);
 	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
+	end_test_loop();
 
 	/* Signal the modifyer thread to stop and wait until it exits */
 	signal_state(mod_info, TEST_DONE);
@@ -927,6 +1052,7 @@ int usage(void)
 {
 	fprintf(stderr, "Userland /proc/pid/{s}maps test cases\n");
 	fprintf(stderr, "  -d: Duration for time-consuming tests\n");
+	fprintf(stderr, "  -v: Verbose mode\n");
 	fprintf(stderr, "  -h: Help screen\n");
 	exit(-1);
 }
@@ -937,9 +1063,11 @@ int main(int argc, char **argv)
 	int exec_fd;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "d:h")) != -1) {
+	while ((opt = getopt(argc, argv, "d:vh")) != -1) {
 		if (opt == 'd')
 			test_duration_sec = strtoul(optarg, NULL, 0);
+		else if (opt == 'v')
+			verbose = true;
 		else if (opt == 'h')
 			usage();
 	}
-- 
2.49.0.1266.g31b7d2e469-goog


