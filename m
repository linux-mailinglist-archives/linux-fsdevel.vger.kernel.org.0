Return-Path: <linux-fsdevel+bounces-55515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D3AB0B169
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 20:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD0D1890A8F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FFF28AB02;
	Sat, 19 Jul 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4B8tRBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA528A1EA
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949749; cv=none; b=r+JR75zJWCJJbeSEcRdN6iHyiW2iQVg7X/TzDOwSSbbWyhfNw99qZvhUVfWJVnHvtym0VmjMOUkMxBGSQ4g4Oji1wSRZiRDv3mGPJ83gXHEAtSPz5+ds0Y62QzJEjlCBbq6KHXNPFEVJVmkYZNqCMPvszK3Hopc7uad2EuBKg8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949749; c=relaxed/simple;
	bh=tUZ4dqdiz+tH/IQ6l3F06JbQsd9hzO5wedZNYL8/80U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nr92+Fvzd5giNHEl0s7KGbqml8vZAM8suKcCh65fjYxZ3ojTq1vEh/eXGnsMOG86SOZSOfm0739fiZOHRxKONGb3xEeX2KNRkZnmCWt/ub54fqBKTxzlgtgWcHE0KRbsyU6LP0mbInVJDXqmF4BMi9adTt6Z42xrUGP5ze9WcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4B8tRBW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b00e4358a34so2044449a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752949745; x=1753554545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kldXOAzG4so78dmLm2qHj9lFsFg2dD4gGV3mKFtJSPI=;
        b=r4B8tRBWOz6hR5cBJow/uxBimhZEQJ6TUwbsl9nimtIWlvHF/DlHg67lp/U6GjJVMD
         psWzlTLLAq5lBGycOHDlHhyZ+QqBaR7OuTGZZwhKGSC/5aYJ8myEWUM6sG/PQtdm2VGD
         PkQjJXRkO7Ws9vUOq5PiTl6g+rBd9wWJKQRfedI72RVTHqck1G9teYJvmga3PG3lpXsG
         z6o7Ghi0f9OPzjlnQyL2+c4DL5c93L/ZUEqqHNbs/HuSM5NmgRRix6fvcoFbZ74/DhSR
         bzP97ytS7T6xAWbJZhiYiclPQHMV08JBEOchM99ljAh3JBm1N1/HBPm41ppgsT+YcCfF
         WgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752949745; x=1753554545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kldXOAzG4so78dmLm2qHj9lFsFg2dD4gGV3mKFtJSPI=;
        b=mFz2nm9NFy6kY8C9qeHwBq0pQuWmcgdkVJYGvC2JNRpDPN6+tG5RzhE1ebwFo3Kx/q
         q3k9FlqAwaVoS+3ElI9/Ny/yHTCdA+3IIl9wqxdqLewdzmWw1U3m6NJLdbcvkMC6euda
         MJxnefDN1M6bVTJ/T2LV6aQZa6JwkI2U6jUtJczT37v3z5YJmC4QpuXUYiLUZ89FeVcA
         4hwlWBHeiCdNw9N2Tf1DFqaUfkF6Kj3wpXeEmQsZ1arrFDXvRQQshFUanLVhboqlun3I
         6IU7zVh59AbT0JZEoEPRmyuwhWWFzLwIlbIJf5sRFfd8gg6j2lHj4VT+QKtUoPNOerP6
         6Xlg==
X-Forwarded-Encrypted: i=1; AJvYcCXlAgXo0ZmM+FKl0n3c1iK07TY3/cr5DGtd3ioQqZtzHbkwc5gh/ea0Cp+KrjPv8j3y5NMhVR9NiYAS28/E@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmz2ft8hZCcdJeThzx7YXT5oD5rYkiB2vUvv6ZWJh9Mb5yNuN/
	xOY6ejGArsRZU6OgN90qoa1rMqTjooYp/z/yVr+ji0FpHKCAoiZtv+hMBqZDk7BpwDJXWAJtCrJ
	6hWLtVA==
X-Google-Smtp-Source: AGHT+IFAkxSoila/fwaGlvNf2qW0QBDiOSpGMxIR79yLqlqjemU3z0o2eWLkFLAs8M7qaglNQyc8/iazA7g=
X-Received: from pjh16.prod.google.com ([2002:a17:90b:3f90:b0:312:eaf7:aa0d])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8f:b0:234:c86d:4572
 with SMTP id d9443c01a7336-23e2572aaf4mr203386885ad.30.1752949745541; Sat, 19
 Jul 2025 11:29:05 -0700 (PDT)
Date: Sat, 19 Jul 2025 11:28:52 -0700
In-Reply-To: <20250719182854.3166724-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719182854.3166724-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719182854.3166724-5-surenb@google.com>
Subject: [PATCH v8 4/6] selftests/proc: add verbose mode for /proc/pid/maps
 tearing tests
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Add verbose mode to the /proc/pid/maps tearing tests to print debugging
information. VERBOSE environment variable is used to enable it.

Usage example: VERBOSE=1 ./proc-maps-race

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-maps-race.c | 153 ++++++++++++++++--
 1 file changed, 141 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index bc614a2d944a..66773685a047 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -77,6 +77,7 @@ FIXTURE(proc_maps_race)
 	int shared_mem_size;
 	int page_size;
 	int vma_count;
+	bool verbose;
 	int maps_fd;
 	pid_t pid;
 };
@@ -188,12 +189,104 @@ static void stop_vma_modifier(struct vma_modifier_info *mod_info)
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
+static void print_boundaries(const char *title, FIXTURE_DATA(proc_maps_race) *self)
+{
+	if (!self->verbose)
+		return;
+
+	printf("%s", title);
+	/* Print 3 boundary lines from each page */
+	print_last_lines(self->page1.data, 3);
+	printf("-----------------page boundary-----------------\n");
+	print_first_lines(self->page2.data, 3);
+}
+
+static bool print_boundaries_on(bool condition, const char *title,
+				FIXTURE_DATA(proc_maps_race) *self)
+{
+	if (self->verbose && condition)
+		print_boundaries(title, self);
+
+	return condition;
+}
+
+static void report_test_start(const char *name, bool verbose)
+{
+	if (verbose)
+		printf("==== %s ====\n", name);
+}
+
+static struct timespec print_ts;
+
+static void start_test_loop(struct timespec *ts, bool verbose)
+{
+	if (verbose)
+		print_ts.tv_sec = ts->tv_sec;
+}
+
+static void end_test_iteration(struct timespec *ts, bool verbose)
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
+static void end_test_loop(bool verbose)
+{
+	if (verbose)
+		printf("\n");
+}
+
 static bool capture_mod_pattern(FIXTURE_DATA(proc_maps_race) *self,
 				struct line_content *mod_last_line,
 				struct line_content *mod_first_line,
 				struct line_content *restored_last_line,
 				struct line_content *restored_first_line)
 {
+	print_boundaries("Before modification", self);
+
 	signal_state(self->mod_info, SETUP_MODIFY_MAPS);
 	wait_for_state(self->mod_info, SETUP_MAPS_MODIFIED);
 
@@ -201,6 +294,8 @@ static bool capture_mod_pattern(FIXTURE_DATA(proc_maps_race) *self,
 	if (!read_boundary_lines(self, mod_last_line, mod_first_line))
 		return false;
 
+	print_boundaries("After modification", self);
+
 	signal_state(self->mod_info, SETUP_RESTORE_MAPS);
 	wait_for_state(self->mod_info, SETUP_MAPS_RESTORED);
 
@@ -208,6 +303,8 @@ static bool capture_mod_pattern(FIXTURE_DATA(proc_maps_race) *self,
 	if (!read_boundary_lines(self, restored_last_line, restored_first_line))
 		return false;
 
+	print_boundaries("After restore", self);
+
 	if (!self->mod_info->vma_mod_check(mod_last_line, mod_first_line,
 					   restored_last_line, restored_first_line))
 		return false;
@@ -295,6 +392,7 @@ static inline bool check_remap_result(struct line_content *mod_last_line,
 
 FIXTURE_SETUP(proc_maps_race)
 {
+	const char *verbose = getenv("VERBOSE");
 	const char *duration = getenv("DURATION");
 	struct vma_modifier_info *mod_info;
 	pthread_mutexattr_t mutex_attr;
@@ -303,6 +401,7 @@ FIXTURE_SETUP(proc_maps_race)
 	char fname[32];
 
 	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
+	self->verbose = verbose && !strncmp(verbose, "1", 1);
 	duration_sec = duration ? atol(duration) : 0;
 	self->duration_sec = duration_sec ? duration_sec : 5UL;
 
@@ -444,6 +543,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 	mod_info->vma_restore = merge_vma;
 	mod_info->vma_mod_check = check_split_result;
 
+	report_test_start("Tearing from split", self->verbose);
 	ASSERT_TRUE(capture_mod_pattern(self, &split_last_line, &split_first_line,
 					&restored_last_line, &restored_first_line));
 
@@ -455,6 +555,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 	struct timespec start_ts, end_ts;
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	start_test_loop(&start_ts, self->verbose);
 	do {
 		bool last_line_changed;
 		bool first_line_changed;
@@ -472,12 +573,18 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 			 * In that case new first line will be the same as the
 			 * last restored line.
 			 */
-			ASSERT_FALSE(strcmp(new_first_line.text, split_first_line.text) &&
-				     strcmp(new_first_line.text, restored_last_line.text));
+			ASSERT_FALSE(print_boundaries_on(
+					strcmp(new_first_line.text, split_first_line.text) &&
+					strcmp(new_first_line.text, restored_last_line.text),
+					"Split result invalid", self));
 		} else {
 			/* The vmas should be consistent with merge results */
-			ASSERT_FALSE(strcmp(new_last_line.text, restored_last_line.text));
-			ASSERT_FALSE(strcmp(new_first_line.text, restored_first_line.text));
+			ASSERT_FALSE(print_boundaries_on(
+					strcmp(new_last_line.text, restored_last_line.text),
+					"Merge result invalid", self));
+			ASSERT_FALSE(print_boundaries_on(
+					strcmp(new_first_line.text, restored_first_line.text),
+					"Merge result invalid", self));
 		}
 		/*
 		 * First and last lines should change in unison. If the last
@@ -489,7 +596,9 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 		ASSERT_EQ(last_line_changed, first_line_changed);
 
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
+	end_test_loop(self->verbose);
 
 	/* Signal the modifyer thread to stop and wait until it exits */
 	signal_state(mod_info, TEST_DONE);
@@ -513,6 +622,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 	mod_info->vma_restore = expand_vma;
 	mod_info->vma_mod_check = check_shrink_result;
 
+	report_test_start("Tearing from resize", self->verbose);
 	ASSERT_TRUE(capture_mod_pattern(self, &shrunk_last_line, &shrunk_first_line,
 					&restored_last_line, &restored_first_line));
 
@@ -524,6 +634,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 	struct timespec start_ts, end_ts;
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	start_test_loop(&start_ts, self->verbose);
 	do {
 		ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &new_first_line));
 
@@ -537,16 +648,24 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 			 * again. In that case new first line will be the same
 			 * as the last restored line.
 			 */
-			ASSERT_FALSE(strcmp(new_first_line.text, shrunk_first_line.text) &&
-				     strcmp(new_first_line.text, restored_last_line.text));
+			ASSERT_FALSE(print_boundaries_on(
+					strcmp(new_first_line.text, shrunk_first_line.text) &&
+					strcmp(new_first_line.text, restored_last_line.text),
+					"Shrink result invalid", self));
 		} else {
 			/* The vmas should be consistent with the original/resored state */
-			ASSERT_FALSE(strcmp(new_last_line.text, restored_last_line.text));
-			ASSERT_FALSE(strcmp(new_first_line.text, restored_first_line.text));
+			ASSERT_FALSE(print_boundaries_on(
+					strcmp(new_last_line.text, restored_last_line.text),
+					"Expand result invalid", self));
+			ASSERT_FALSE(print_boundaries_on(
+					strcmp(new_first_line.text, restored_first_line.text),
+					"Expand result invalid", self));
 		}
 
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
+	end_test_loop(self->verbose);
 
 	/* Signal the modifyer thread to stop and wait until it exits */
 	signal_state(mod_info, TEST_DONE);
@@ -570,6 +689,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 	mod_info->vma_restore = patch_vma;
 	mod_info->vma_mod_check = check_remap_result;
 
+	report_test_start("Tearing from remap", self->verbose);
 	ASSERT_TRUE(capture_mod_pattern(self, &remapped_last_line, &remapped_first_line,
 					&restored_last_line, &restored_first_line));
 
@@ -581,6 +701,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 	struct timespec start_ts, end_ts;
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	start_test_loop(&start_ts, self->verbose);
 	do {
 		ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &new_first_line));
 
@@ -594,16 +715,24 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 			 * again. In that case new first line will be the same
 			 * as the last restored line.
 			 */
-			ASSERT_FALSE(strcmp(new_first_line.text, remapped_first_line.text) &&
-				     strcmp(new_first_line.text, restored_last_line.text));
+			ASSERT_FALSE(print_boundaries_on(
+					strcmp(new_first_line.text, remapped_first_line.text) &&
+					strcmp(new_first_line.text, restored_last_line.text),
+					"Remap result invalid", self));
 		} else {
 			/* The vmas should be consistent with the original/resored state */
-			ASSERT_FALSE(strcmp(new_last_line.text, restored_last_line.text));
-			ASSERT_FALSE(strcmp(new_first_line.text, restored_first_line.text));
+			ASSERT_FALSE(print_boundaries_on(
+					strcmp(new_last_line.text, restored_last_line.text),
+					"Remap restore result invalid", self));
+			ASSERT_FALSE(print_boundaries_on(
+					strcmp(new_first_line.text, restored_first_line.text),
+					"Remap restore result invalid", self));
 		}
 
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
+	end_test_loop(self->verbose);
 
 	/* Signal the modifyer thread to stop and wait until it exits */
 	signal_state(mod_info, TEST_DONE);
-- 
2.50.0.727.gbf7dc18ff4-goog


