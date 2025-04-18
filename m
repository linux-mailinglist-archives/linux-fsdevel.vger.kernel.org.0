Return-Path: <linux-fsdevel+bounces-46682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB5FA93C43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D82AA7B1C9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9F0221726;
	Fri, 18 Apr 2025 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yG31AAK9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A2221D3CA
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998610; cv=none; b=iWAcYGqeuaCrpWb84Pq4UYqlNEFBucSDLRXgMIysb5zanO0oLOWRrumcDjKaRKds8dPtsoDASxrbWG00uHVrP+EAR4MznwTgkcrplNqt45xmA73IaCM5dK9nIph0RYRyBM2mPdsq7voBIfMc+vhptuxQLatokR8tQJdLZYGHPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998610; c=relaxed/simple;
	bh=xrrLN9Fn238jRuFI24Vz65P8O0LQj4xBEOmBNdG0wOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jTVJk9/CREPV6Y0/MUrDrKJC6u/CvpmF5Ybx4lfSpaCi3c7B90o+Z/KDpN2eBxz9qfhiP+4q1iWxuIP7HgPL3ZXlsjIpSiqEYHPDUmDbl0abAcM1L4jAnKPZuht0W5PnqIXjG+k8slfBg8yCqKkUo1/TgChKxV93OePN2Zlfed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yG31AAK9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3085f5855c4so1853706a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744998608; x=1745603408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NX95Q4Cv9wzSD/gXCZRQ7iUBrYCRAWvVBL1zZlzjT0w=;
        b=yG31AAK9k6Rdbreim3y4gDSAGuYVWVQgjafeYykx6b+1iGTAph8VruRvrYWn+dSshB
         bVz+iB6kb67kosGpJFnaK/192jCS3f7L6ckDtp6A33vsBSUoppgOR6lKeMEgMd8nvyVV
         sPSGUMpGRH7DawY3iGkVF5k28/82iv4EPAe/FO9NWTM315uHlF8Aw69KHNX363f4GYnv
         5y3m7+LRUUXTqXrhQ531acDFF3PEMiRx6NdWF+crMpsQgIMPlSNXeLrRgsCopZrLhtTN
         DOPeJn01Gbjf9IzFh2n5+FXj6+O6ayVXMsvNSlliivJHG78u7p04M3UZExFmsTodX8TY
         d7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744998608; x=1745603408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NX95Q4Cv9wzSD/gXCZRQ7iUBrYCRAWvVBL1zZlzjT0w=;
        b=wweLv1mvwpxmX3ohccD0fnq0R1oSNp4Injms32ToR8I3t15V6J4KJOATEeHUrVHyJU
         SKcMu9Bcl3WBS614XDCyyJDBUZ+CSjDO3lNCGQRM6qAvFscDJx4wxsIgis+fAxh8l9w7
         F6cVd3KfIG8HSd8MGzFqnubri1bhlBliU2iizlcR+DrJU2LNDud/r7HPLpdPxIZn/p2D
         FKhmhyAHRH7rJp7x2NMXg8aYeemxe5RaXQpjdUdUKT1VE9QCXWzKCXj3JahnX2suGU8O
         auSOTpyL0px35udruZNWzBqp+GHHFtV3RW6XXTDuVcSD1XqfYWJJkeu3nhLwtqgqAJAF
         dakg==
X-Forwarded-Encrypted: i=1; AJvYcCWNTEAdk4Mic9PJ6Whwet/SkbwbLmIwncwO9fTLqZ9G4ASau5uKvmxImDeToABoy7Y1SnwYS1aAO7f7lMLS@vger.kernel.org
X-Gm-Message-State: AOJu0YyyUSXey2XZY1r48uPqG5MFm+G/svoxmjnxcRGFnShHwdeE7Wdw
	RxSJ92cfSBxkVoA8LB4XJ0zNkUbjYpn1OVdLGOVhgWXkzicMa4q2wdRlmlLOA/cqz8u/Dnqr7Vm
	abw==
X-Google-Smtp-Source: AGHT+IFpXjxxv3q6WygkdxKZ0NcMoXnZ0n+s0fsiF2xjhvVMd0DnZR58HYYN8GWJayn2FJMme4MlbLuDSV4=
X-Received: from pjyp13.prod.google.com ([2002:a17:90a:e70d:b0:2fc:2ee0:d38a])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5404:b0:305:2d68:8d39
 with SMTP id 98e67ed59e1d1-3087bb571a2mr6196148a91.12.1744998607909; Fri, 18
 Apr 2025 10:50:07 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:49:53 -0700
In-Reply-To: <20250418174959.1431962-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418174959.1431962-3-surenb@google.com>
Subject: [PATCH v3 2/8] selftests/proc: extend /proc/pid/maps tearing test to
 include vma resizing
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
space when a vma at the edge of the page is being concurrently remapped.
This remapping results in the vma shrinking and expanding from  under the
reader. We should always see either shrunk or expanded (original) version
of the vma.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 6e3f06376a1f..39842e4ec45f 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -583,6 +583,86 @@ static void test_maps_tearing_from_split(int maps_fd,
 	signal_state(mod_info, TEST_DONE);
 }
 
+static inline void shrink_vma(const struct vma_modifier_info *mod_info)
+{
+	assert(mremap(mod_info->addr, page_size * 3, page_size, 0) != MAP_FAILED);
+}
+
+static inline void expand_vma(const struct vma_modifier_info *mod_info)
+{
+	assert(mremap(mod_info->addr, page_size, page_size * 3, 0) != MAP_FAILED);
+}
+
+static inline void check_shrink_result(struct line_content *mod_last_line,
+				       struct line_content *mod_first_line,
+				       struct line_content *restored_last_line,
+				       struct line_content *restored_first_line)
+{
+	/* Make sure only the last vma of the first page is changing */
+	assert(strcmp(mod_last_line->text, restored_last_line->text) != 0);
+	assert(strcmp(mod_first_line->text, restored_first_line->text) == 0);
+}
+
+static void test_maps_tearing_from_resize(int maps_fd,
+					  struct vma_modifier_info *mod_info,
+					  struct page_content *page1,
+					  struct page_content *page2,
+					  struct line_content *last_line,
+					  struct line_content *first_line)
+{
+	struct line_content shrunk_last_line;
+	struct line_content shrunk_first_line;
+	struct line_content restored_last_line;
+	struct line_content restored_first_line;
+
+	wait_for_state(mod_info, SETUP_READY);
+
+	/* re-read the file to avoid using stale data from previous test */
+	read_boundary_lines(maps_fd, page1, page2, last_line, first_line);
+
+	mod_info->vma_modify = shrink_vma;
+	mod_info->vma_restore = expand_vma;
+	mod_info->vma_mod_check = check_shrink_result;
+
+	capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
+			    &shrunk_last_line, &shrunk_first_line,
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
+		/* Check if we read vmas after shrinking it */
+		if (!strcmp(new_last_line.text, shrunk_last_line.text)) {
+			/*
+			 * The vmas should be consistent with shrunk results,
+			 * however if the vma was concurrently restored, it
+			 * can be reported twice (first as shrunk one, then
+			 * as restored one) because we found it as the next vma
+			 * again. In that case new first line will be the same
+			 * as the last restored line.
+			 */
+			assert(!strcmp(new_first_line.text, shrunk_first_line.text) ||
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
@@ -674,6 +754,9 @@ static int test_maps_tearing(void)
 	test_maps_tearing_from_split(maps_fd, mod_info, &page1, &page2,
 				     &last_line, &first_line);
 
+	test_maps_tearing_from_resize(maps_fd, mod_info, &page1, &page2,
+				      &last_line, &first_line);
+
 	stop_vma_modifier(mod_info);
 
 	free(page2.data);
-- 
2.49.0.805.g082f7c87e0-goog


