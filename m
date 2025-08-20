Return-Path: <linux-fsdevel+bounces-58409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB2FB2E728
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 23:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35C7164A9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 21:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4790F2D9ED8;
	Wed, 20 Aug 2025 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="e5nJFTrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic313-20.consmr.mail.gq1.yahoo.com (sonic313-20.consmr.mail.gq1.yahoo.com [98.137.65.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92142D6608
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723964; cv=none; b=LkwjN5UxlUxYWDjVq7onIbzOWDhLWVM/7hZYgVaaulVGakc5uZh6WnHMf3mNlFxx9/EfKnitHq2vVzYcFo+Jyp6DVGl/WHtSWPWT21FgSXk9OAfBPl7Fv98dOpF7FQmxamtTUWL2JOqXf2vigXEYdkOhveI9rUsVmdPeUTB6GOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723964; c=relaxed/simple;
	bh=gwR2FTEW5Fl+CistKipt66N88Og5m+2NbbVMb3I7buA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=GPOZQMab/dUPTZZPKawPeJVMdd5wpHvweN8JvB94HawZA1w7kqpvX+vYFMH9BV6CEPxGjm6w7b/ET4jLCsKcooK/QcszXHhRHTYQ/NcmfN4++hmnFxuCp+QklslKiiNAwLxySJHHO8oLlgvN7J4UijdqPUrJr6hu3o50i5QvzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=e5nJFTrq; arc=none smtp.client-ip=98.137.65.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755723956; bh=3Fkp55TcdyCCGAxGMXGItyF3dgrGUPFEBcgRKkVdDgE=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=e5nJFTrq0gOpohJfDomXIVqIMHufGRQdXpS1iKyQAHxjdz+Xzty8dWNpylwCGfADZ48DqRxWQt/8M9E0d93Owu8N2iXx1guWA6BTMTPg6AmAopyLO6swEXHMKXfPzkxvEUUMbMR19PVIkQ8AsanZKEcx5VM4yXVPYEyoPoFJT3wdYJef+Unx42CeUxSVcc1sQo2N3xmDuhqvcFCWylopBqnUqN72LiPfKT0VFzvg+768eAbCksoyDcMo7rm2AgJVbtYJROJqAp7IGNh0uKYZxI/9EBl7IWTcDEybE1fP2sriYYHr1NIylLLTRt1Lu6U+d/2yHXIZEW9oZUIX/oPggA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755723956; bh=zO42oGt0FDjKiPBvswVA7gKfFkHQBgXEoRuloYDQOiA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Qeiks5yt7q8+1vLkedtx5oL7LAglSgoNl4mVaAf1GP9tRn9YWr58BssJtTSN2XEmNAatckfv9bamOEBrr3ZpaeB2n46ynpP6LjL+UKXQCYotygaje1t/gpO7Xe+hfjdqRGWPKn2dFl2o/SIokSj29h24y4s7yu3SIl9MOI44w0oqfVW1rS6O9YGm9Haq4Swk1BMjMSvJL+8bmrZRHz3RduJmVzosvZiT8QRgIYzYIUmLczeY9KW2BAwOtAwARm5JSpIipuju6Wwaq+WI0C6Q/9hk6Q52stLSI/b1YZ3ggtryhZcLltR3Gs4GhRv7Ubf7OLvIOowH7RZY8drPG7HhsQ==
X-YMail-OSG: THNFN20VM1kvTbz64hEFQa_JFTAARrN17H7gNVQ02lWpZs5UHhiTWyig9hysVHT
 i6iYLefYj0TDYgVPETvxMXj0mgzIZXJfGegpsKfQBU4rlbU68rftAP9bSbbgpCZDH_8EehqjbSxD
 8lDiEEyjslG0_rsSQl2yXwyp5aTVeaYhEaqanO8tWLHe5SZV5omxd9f0iQ3XOyw5ffSdhXpW01a_
 MmV6dIdWXHpUUaQiYJGkQoo6NFDLLhcwIua7MEjkIcgavZ48VWRl5CYJpUAanlExXDDNGiWB3Pi4
 ygkhM3ln3PJhobbtaw0sDcqDm_jTO4yJ0w9v20BX0naEs0OZdGAOBSFNopgT1RnQtrw7OhavIsEw
 EMBMHA.MKuyljgXx7VVTckO8F3OwALLIQP6mPJ4rDYOTKAZHCjS0SBgLCcf6kh8sRX9nfGsQtZqm
 dHHkom0tv1ImMQ4trC_kin8F8MHn7nds1oOYU7PI6uFbpnUquZOTrRc6x7r2k5qQLJ1Y5mvpj9iV
 JmjZqCxw5Z5coTtwUNDTVHVnKCDXQuC9s_igof9aLACtbaQ5v0584AkD4FzvI.6Ha5aHVkV1aUAR
 i4GDT8QKRaiaY4ucFmkWThCAMMPDfrsvP2iEWq7c7CYTZDlmDnhxq.5xFVvKfmMLI8Zgi4qyUjlB
 JcG4qBg7etYIR5PMveumH.DaJeDPBlxLcbVXzOQN2MaLr7Z3R_Dsdzohf2Al9bs95sFmRh9xrbDc
 iOJ5KyWapsG7mla5eU5yVEQcQEQS6_Fwii4xmUQ6ojZ4XKvFc4kysRMXjTK_Wg41xXMW80FvxfRr
 hYEzGu3Pb8MFpmTUvpgzgEJ4HAV9OR6EztNUGkqFAxcQcA.XJfqhDsm00u8rNX.3Q27_8Mv.SRYJ
 KJAWAJJ4I9COpDM_uesWQFfZ9zAJIqb9y60oRNcXtwsTQQ5Es7NLZjK6Wr3HZKOJ68Z_n7apBcle
 jz79mQsoE24rZS9rWc3SpbyT4U03UB1Hfvyh3cvVYXDRFI.I4LCKu73SEjM5HPk2X_GLZVlyXZpa
 EX3AYCU3NfV0VRHRetPjXPgUmG1vtSuTJWzsVEr3fepzZ1e9m2ho7rzZac9CToBOmp5XXd2OXsuX
 xpb3Id2ZmNpaBVDMmqZwS8dt3zajUtQXsWsUESwAGm2py.FIQUkwWZfLqDFZK.j.rJCuA8dpc08u
 GcZN2sYr.fAWS8hDfbQAtFR7WnsZXcRDkIPCg8r8WpaepGBYgSJFhWz7PJ49S89hRsiDe37wdMnr
 hNEzkfmPjrofiANXuUAPM6Wl86VLLlDLHdQC0szVGdaoqYrRrBoykLFBTkqM2Pm6qBQxvGjs.M3y
 .ufYvEdBGKsYB3klNKPoZ6pp8m9p8xfnmZbrXYIW_s5bbh5ZkWFFUoursZCx2eHF7OMommMBqrCy
 rRz5uPbpH9eZl1w9_NPGvOtJXdP7DgoE66AdrcWNjKtRQrX__M3.uBv.xFMnazcuC6MNLZ7Iz2es
 0i2ILPlaWPviNEmrTmGubiAOB_7Rg63yA6VvqcBD9u7NWFDIE7BN7JyJeLGOpRsllrhe.t5GGPH6
 j61H4FuGYlfvwuDk5GylQ5GZRAafdLimlMrtc985TZrkZan6gf5tT0oig83R8TVlKNkTVDtuMnps
 LYWnQJ_A.U8btsjvK5S0P1iT5pgcTUbLCpi91_Y3Yeir640DQe7qruHSKA6D.H_SURm2Q9IrP.NJ
 2ebZz1C5LN2DLd7B32urtPzexxIBTr_11Cn57fMeT3GtjbQMjUbeXocGiaZOOdWmdG8ZygdTzsif
 e7NoDE2BcZFTqTIpivlBTNM4TG3q3phcYNTxzS8xvH.jaabLj63ulPeMRQzEMrPdpbFm9JRK4d1z
 kYUQQ5Dc_Bz6vy2vVnv.vNB8VmD7.Eux3OGvCqGCbDvrOo19Kb0oBQQGxEuqn_quGzF750fOBfBQ
 kw4RU3Nhi2zUawREx8niq2PW5Yy4QvqGVoTF45dLmG_f3R3sFXv.Y2.o_rIE2OILMZKl9TSDE_Fw
 bm5e.QSDMJLSYfNkQqgaA9TNjQUlh6v29rB8zhisDjhTRmlAAIjboX8B5BZK_o9QtE5cvUnPgWWe
 yY6iUBkqNEh5tJzm0mJ7QUEQ3p4TRYvxljQ45rFsvyLEs6kfX_H7NFHCiUDAvoJkXa7Ik9icr5V2
 WrwSauFSAPTRoeQsxMcSNoVLpXuXUhi3.rAvjtNAFw4riKcIOCWUYQQPvEe8w1gpMap36Cb16Rdb
 A8dGROgQVbhvF_e7lm4lyGTkjtWaLk6a44dgOzMNEuUTxTw_8_3OtgTaemHdtdCNSb5nB4vlEl4k
 mnd23KhPPgmke_VOT
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: a6242ee9-af46-49d0-b7d0-387b522a8096
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Wed, 20 Aug 2025 21:05:56 +0000
Received: by hermes--production-bf1-689c4795f-ct644 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 61dac405d5ece461a95959028efdd9e8;
          Wed, 20 Aug 2025 20:55:47 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: shuah@kernel.org
Cc: akpm@linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	surenb@google.com,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH] selftests/proc: Fix spelling in comments and improve error message
Date: Wed, 20 Aug 2025 21:55:13 +0100
Message-ID: <20250820205513.103548-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250820205513.103548-1-adelodunolaoluwa.ref@yahoo.com>

This patch corrects minor spelling mistake and adjusts comment style,
such as capitalizing the first letter for consistency.
In addition, "error: failed to find available memory address for mapping\n"
message replaces a not-quite-suitable one:"error: mmap doesn't like you\n".

No functional changes are introduced

Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
 tools/testing/selftests/proc/fd-001-lookup.c  |  4 ++--
 tools/testing/selftests/proc/proc-maps-race.c | 22 +++++++++----------
 .../selftests/proc/proc-self-map-files-002.c  |  2 +-
 tools/testing/selftests/proc/read.c           |  2 +-
 tools/testing/selftests/proc/setns-dcache.c   |  2 +-
 tools/testing/selftests/proc/setns-sysvipc.c  |  2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/proc/fd-001-lookup.c b/tools/testing/selftests/proc/fd-001-lookup.c
index 60d7948e7124..2f5949593ad4 100644
--- a/tools/testing/selftests/proc/fd-001-lookup.c
+++ b/tools/testing/selftests/proc/fd-001-lookup.c
@@ -60,7 +60,7 @@ static void test_lookup(unsigned int fd)
 	snprintf(buf, sizeof(buf), "/proc/self/fd/%u", fd);
 	test_lookup_pass(buf);
 
-	/* leading junk */
+	/* Leading junk */
 	for (c = 1; c <= 255; c++) {
 		if (c == '/')
 			continue;
@@ -68,7 +68,7 @@ static void test_lookup(unsigned int fd)
 		test_lookup_fail(buf);
 	}
 
-	/* trailing junk */
+	/* Trailing junk */
 	for (c = 1; c <= 255; c++) {
 		if (c == '/')
 			continue;
diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 94bba4553130..2e730b70b171 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -138,10 +138,10 @@ static void copy_last_line(struct page_content *page, char *last_line)
 {
 	/* Get the last line in the first page */
 	const char *end = page->data + page->size - 1;
-	/* skip last newline */
+	/* Skip last newline */
 	const char *pos = end - 1;
 
-	/* search previous newline */
+	/* Search previous newline */
 	while (pos[-1] != '\n')
 		pos--;
 	strncpy(last_line, pos, end - pos);
@@ -412,7 +412,7 @@ FIXTURE_SETUP(proc_maps_race)
 	self->vma_count = self->page_size / 32 + 1;
 	self->shared_mem_size = sizeof(struct vma_modifier_info) + self->vma_count * sizeof(void *);
 
-	/* map shared memory for communication with the child process */
+	/* Map shared memory for communication with the child process */
 	self->mod_info = (struct vma_modifier_info *)mmap(NULL, self->shared_mem_size,
 				PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 	ASSERT_NE(self->mod_info, MAP_FAILED);
@@ -439,7 +439,7 @@ FIXTURE_SETUP(proc_maps_race)
 			mod_info->child_mapped_addr[i] = mmap(NULL, self->page_size * 3, prot,
 					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 			ASSERT_NE(mod_info->child_mapped_addr[i], MAP_FAILED);
-			/* change protection in adjacent maps to prevent merging */
+			/* Change protection in adjacent maps to prevent merging */
 			prot ^= PROT_WRITE;
 		}
 		signal_state(mod_info, CHILD_READY);
@@ -536,7 +536,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 
 	wait_for_state(mod_info, SETUP_READY);
 
-	/* re-read the file to avoid using stale data from previous test */
+	/* Re-read the file to avoid using stale data from previous test */
 	ASSERT_TRUE(read_boundary_lines(self, &self->last_line, &self->first_line));
 
 	mod_info->vma_modify = split_vma;
@@ -600,7 +600,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
 	end_test_loop(self->verbose);
 
-	/* Signal the modifyer thread to stop and wait until it exits */
+	/* Signal the modifier thread to stop and wait until it exits */
 	signal_state(mod_info, TEST_DONE);
 }
 
@@ -615,7 +615,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 
 	wait_for_state(mod_info, SETUP_READY);
 
-	/* re-read the file to avoid using stale data from previous test */
+	/* Re-read the file to avoid using stale data from previous test */
 	ASSERT_TRUE(read_boundary_lines(self, &self->last_line, &self->first_line));
 
 	mod_info->vma_modify = shrink_vma;
@@ -653,7 +653,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 					strcmp(new_first_line.text, restored_last_line.text),
 					"Shrink result invalid", self));
 		} else {
-			/* The vmas should be consistent with the original/resored state */
+			/* The vmas should be consistent with the original/restored state */
 			ASSERT_FALSE(print_boundaries_on(
 					strcmp(new_last_line.text, restored_last_line.text),
 					"Expand result invalid", self));
@@ -667,7 +667,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
 	end_test_loop(self->verbose);
 
-	/* Signal the modifyer thread to stop and wait until it exits */
+	/* Signal the modifier thread to stop and wait until it exits */
 	signal_state(mod_info, TEST_DONE);
 }
 
@@ -682,7 +682,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 
 	wait_for_state(mod_info, SETUP_READY);
 
-	/* re-read the file to avoid using stale data from previous test */
+	/* Re-read the file to avoid using stale data from previous test */
 	ASSERT_TRUE(read_boundary_lines(self, &self->last_line, &self->first_line));
 
 	mod_info->vma_modify = remap_vma;
@@ -734,7 +734,7 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
 	end_test_loop(self->verbose);
 
-	/* Signal the modifyer thread to stop and wait until it exits */
+	/* Signal the modifier thread to stop and wait until it exits */
 	signal_state(mod_info, TEST_DONE);
 }
 
diff --git a/tools/testing/selftests/proc/proc-self-map-files-002.c b/tools/testing/selftests/proc/proc-self-map-files-002.c
index e6aa00a183bc..ac05b0b127cd 100644
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -67,7 +67,7 @@ int main(void)
 			break;
 	}
 	if (va == va_max) {
-		fprintf(stderr, "error: mmap doesn't like you\n");
+		fprintf(stderr, "error: failed to find available memory address for mapping\n");
 		return 1;
 	}
 
diff --git a/tools/testing/selftests/proc/read.c b/tools/testing/selftests/proc/read.c
index 35ee78dff144..84f6f2e01150 100644
--- a/tools/testing/selftests/proc/read.c
+++ b/tools/testing/selftests/proc/read.c
@@ -41,7 +41,7 @@ static void f_reg(DIR *d, const char *filename)
 	int fd;
 	ssize_t rv;
 
-	/* read from /proc/kmsg can block */
+	/* Read from /proc/kmsg can block */
 	fd = openat(dirfd(d), filename, O_RDONLY|O_NONBLOCK);
 	if (fd == -1)
 		return;
diff --git a/tools/testing/selftests/proc/setns-dcache.c b/tools/testing/selftests/proc/setns-dcache.c
index 60ab197a73fc..70389832dd22 100644
--- a/tools/testing/selftests/proc/setns-dcache.c
+++ b/tools/testing/selftests/proc/setns-dcache.c
@@ -50,7 +50,7 @@ int main(void)
 
 	atexit(f);
 
-	/* Check for priviledges and syscall availability straight away. */
+	/* Check for privileges and syscall availability straight away. */
 	if (unshare(CLONE_NEWNET) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
 			return 4;
diff --git a/tools/testing/selftests/proc/setns-sysvipc.c b/tools/testing/selftests/proc/setns-sysvipc.c
index 903890c5e587..d03aa4838f0f 100644
--- a/tools/testing/selftests/proc/setns-sysvipc.c
+++ b/tools/testing/selftests/proc/setns-sysvipc.c
@@ -49,7 +49,7 @@ int main(void)
 
 	atexit(f);
 
-	/* Check for priviledges and syscall availability straight away. */
+	/* Check for privileges and syscall availability straight away. */
 	if (unshare(CLONE_NEWIPC) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
 			return 4;
-- 
2.43.0


