Return-Path: <linux-fsdevel+bounces-46683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A72EA93C45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D844092063E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A363E222592;
	Fri, 18 Apr 2025 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKG0sC0x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B387221571
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998612; cv=none; b=QMZdB9syf3pREbqUXEk2YISuuy70n0E/mIqVU22s+ucpeuh2tMIBbk7eAMOycOQapcX7DIfQCmcfSHe/WPlPYWjwnxXlZqCnIfpK4Vp3+0qfqU8Jro5PxBWomendEp2T2bTxtcxrpdDKNtYlGSjSW8jqJ6QvPttoOw72yEJmmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998612; c=relaxed/simple;
	bh=TUJL4tusOyal/p5nEXPnA97MvfjXVXmJvXC+NGBZezE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bBbx1rkgDxkHHdZJGqyzWGuR0YduhpUt9Kr+xsN1l3E6l4/lOVCM+9FvGeh+VR9kiiXOUlBi3elhB/pSGfxIgPrzDsUN/oLlqKfyrddUcp8J5R0tfcb0avJN36mV9tQ+H4L+PVTdgyMhFyTA0/MrjvdBqTxt3ZAjSAD2Bgyo2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nKG0sC0x; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b00cd79a5e6so2177956a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744998610; x=1745603410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QDrVpMHVQI58rYUIwLQJvrC+l7tIXNhALhARIzYV3A=;
        b=nKG0sC0xUFO3qXwEEMHDsqp8eX1jDxaf1Ws679PICGPuqIfOAtuxIxNrGoefT/1Mn9
         g7AYKf7FWjUUHU2KO4M5m+ke2RjFO/9HGl2P3xFKiz6DKrrPa4pJ2bU1ErxajH5Au/Fs
         eJpe4sWpUyPECmb46nOz6mhNkRqoAJFzYI5fsuShrTc3ltwZu5Zv3G3o3Yl9D4Tp9Bix
         yqXRuobZ14TiLrtnylB55JKL8Gu44HfE7mZyOuYAr2k0z5eT8iwOwH2lrhv0DUBTieQH
         LizFT1jE8Bk8jVykNcZgO0ps0/6WKdlLlZuMhCX9cr8KaMiPtZgPYXaY2CLEpq9wD3le
         6M/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744998610; x=1745603410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QDrVpMHVQI58rYUIwLQJvrC+l7tIXNhALhARIzYV3A=;
        b=LP+UcOJrllk1gtTPwPbnP86EGrkMel27wgCNpKKqPurVKbf8yDNddTsGjK7Yllz4Nc
         beaNGPRrP5vQaFOVbQRJslj4chH6L6iE86FRJdQLX/8+irpRFh4ofb810xgkUDBMkHfQ
         dRaO+Ijr6+A8/LL7MxTzd3om+5aVOdM9ROK/zsyhszPZWy93dTVPmqOmgSUsyS6QWA9t
         auc0X/C8CDMjDns8Hew5j4FYZCjnDjSJwsu0SyxZshOUym8y/0J9hbh3XOkI4b/QvpA+
         71221VIp3B50UNcT1C64S8h296NIFMUz2OGF+ekKCzCsVx3l0RNv9w9Vw+RJNVTzwjv5
         bjkg==
X-Forwarded-Encrypted: i=1; AJvYcCWw2RMkSOyB0YAOdBGOEGZF7g/kyAxd6VOr8J+R+VNZpNQskS3XyQUcK1Ucw6c3G2GM4HjcipwgdL/d1s6N@vger.kernel.org
X-Gm-Message-State: AOJu0YxaLh12o12Q9hLXjwDzkoHevLXkb8juuJ/EyEiKq8ECAm8l5Ixn
	X9z+996sSTbpEsJXTSGqGBS8D6qoUq96BJmbaKY+dlerv/7xA0eO6+KPjWagbgNe/KmbtsOoZty
	t+Q==
X-Google-Smtp-Source: AGHT+IE7iTtCIpLL5pKA5lwf7kKMbjD35Kmet76OppQlPi+RQQiOVcZRsAZLaU2DHrZErhMdfWGzeuof8yo=
X-Received: from pjqq6.prod.google.com ([2002:a17:90b:5846:b0:2fc:3022:36b8])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ed0:b0:2fe:8c22:48b0
 with SMTP id 98e67ed59e1d1-3087bb6d159mr5887502a91.15.1744998609934; Fri, 18
 Apr 2025 10:50:09 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:49:54 -0700
In-Reply-To: <20250418174959.1431962-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418174959.1431962-4-surenb@google.com>
Subject: [PATCH v3 3/8] selftests/proc: extend /proc/pid/maps tearing test to
 include vma remapping
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Test that /proc/pid/maps does not report unexpected holes in the address
space when we concurrently remap a part of a vma into the middle of
another vma. This remapping results in the destination vma being split
into three parts and the part in the middle being patched back from,
all done concurrently from under the reader. We should always see either
original vma or the split one with no holes.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 39842e4ec45f..1aef2db7e893 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -663,6 +663,95 @@ static void test_maps_tearing_from_resize(int maps_fd,
 	signal_state(mod_info, TEST_DONE);
 }
 
+static inline void remap_vma(const struct vma_modifier_info *mod_info)
+{
+	/*
+	 * Remap the last page of the next vma into the middle of the vma.
+	 * This splits the current vma and the first and middle parts (the
+	 * parts at lower addresses) become the last vma objserved in the
+	 * first page and the first vma observed in the last page.
+	 */
+	assert(mremap(mod_info->next_addr + page_size * 2, page_size,
+		      page_size, MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
+		      mod_info->addr + page_size) != MAP_FAILED);
+}
+
+static inline void patch_vma(const struct vma_modifier_info *mod_info)
+{
+	assert(!mprotect(mod_info->addr + page_size, page_size,
+			 mod_info->prot));
+}
+
+static inline void check_remap_result(struct line_content *mod_last_line,
+				      struct line_content *mod_first_line,
+				      struct line_content *restored_last_line,
+				      struct line_content *restored_first_line)
+{
+	/* Make sure vmas at the boundaries are changing */
+	assert(strcmp(mod_last_line->text, restored_last_line->text) != 0);
+	assert(strcmp(mod_first_line->text, restored_first_line->text) != 0);
+}
+
+static void test_maps_tearing_from_remap(int maps_fd,
+				struct vma_modifier_info *mod_info,
+				struct page_content *page1,
+				struct page_content *page2,
+				struct line_content *last_line,
+				struct line_content *first_line)
+{
+	struct line_content remapped_last_line;
+	struct line_content remapped_first_line;
+	struct line_content restored_last_line;
+	struct line_content restored_first_line;
+
+	wait_for_state(mod_info, SETUP_READY);
+
+	/* re-read the file to avoid using stale data from previous test */
+	read_boundary_lines(maps_fd, page1, page2, last_line, first_line);
+
+	mod_info->vma_modify = remap_vma;
+	mod_info->vma_restore = patch_vma;
+	mod_info->vma_mod_check = check_remap_result;
+
+	capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
+			    &remapped_last_line, &remapped_first_line,
+			    &restored_last_line, &restored_first_line);
+
+	/* Now start concurrent modifications for test_duration_sec */
+	signal_state(mod_info, TEST_READY);
+
+	struct line_content new_last_line;
+	struct line_content new_first_line;
+	struct timespec start_ts, end_ts;
+
+	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
+	do {
+		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
+
+		/* Check if we read vmas after remapping it */
+		if (!strcmp(new_last_line.text, remapped_last_line.text)) {
+			/*
+			 * The vmas should be consistent with remap results,
+			 * however if the vma was concurrently restored, it
+			 * can be reported twice (first as split one, then
+			 * as restored one) because we found it as the next vma
+			 * again. In that case new first line will be the same
+			 * as the last restored line.
+			 */
+			assert(!strcmp(new_first_line.text, remapped_first_line.text) ||
+			       !strcmp(new_first_line.text, restored_last_line.text));
+		} else {
+			/* The vmas should be consistent with the original/resored state */
+			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
+			       !strcmp(new_first_line.text, restored_first_line.text));
+		}
+		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
+	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
+
+	/* Signal the modifyer thread to stop and wait until it exits */
+	signal_state(mod_info, TEST_DONE);
+}
+
 static int test_maps_tearing(void)
 {
 	struct vma_modifier_info *mod_info;
@@ -757,6 +846,9 @@ static int test_maps_tearing(void)
 	test_maps_tearing_from_resize(maps_fd, mod_info, &page1, &page2,
 				      &last_line, &first_line);
 
+	test_maps_tearing_from_remap(maps_fd, mod_info, &page1, &page2,
+				     &last_line, &first_line);
+
 	stop_vma_modifier(mod_info);
 
 	free(page2.data);
-- 
2.49.0.805.g082f7c87e0-goog


