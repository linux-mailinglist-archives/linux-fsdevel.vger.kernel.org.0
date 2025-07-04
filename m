Return-Path: <linux-fsdevel+bounces-53888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70387AF87A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B491C80F47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 06:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0409B23BCFF;
	Fri,  4 Jul 2025 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfFUvIBL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831822B8C5
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609260; cv=none; b=SpD2g3UMhHTZ0qq9/eowF7z1hLS1d9RA7OnqvAIt05v3juNVRfP1VMKmgISM4prHj6mQEFqmgKh296pW8CwpmIt50uqqrBITJNUvFfN73jyxU9T+89RFjEJndxo4SYL4LnzS7Y4y285OYfCQH9MqX/uK7jv7yF3Hz6ZMEJlh108=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609260; c=relaxed/simple;
	bh=ZMGFntAQnjjtMoQxDdiUKIBvPxmH73C1FhJ2CMHVp1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KKZGPxlRnuUiL861h5BZ5OOs7AOFYRwCbQQJVdg3UVpL8wC71PAcOyuOj/eHeZ01FMpjH+yHSMQ97XJnokp+GpIq7uPXJxGH81ggMQeq/Tj6Fb0NJ8+quDkH4V6Gx0N2O3wTCj1IQP9UFlel7xNECCD+G5ChEBX1lsILaBfXfzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GfFUvIBL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7377139d8b1so520689b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 23:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751609257; x=1752214057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Li63ssKppcLITl1ITfej/YujyWpoLXNJQdKFDqdnOTk=;
        b=GfFUvIBLQCAo6ht0eCpGERhFqayrzK5V6J3ggaN38JVh8XOrJ2fXUOW3GNUwQqo15B
         naLl71iKAtRimhZCj1X4U3R23gtJ/TdDF8JgBnUk4iwUzs8DQmAYeqdq46ZnAgJXkFI2
         eFL7K96+8leh888chkb0j2DVLNq9ziYbsa9zsJHg5TAIlSos/GJE9HuQBIp7ZrXJWSAI
         js6A5W4zQUVHZJ4pf6h0gPmbdJtdP5hDF94J7VFl0TmIBYQK1QuZRNT6/gP48zKMjwg9
         eWbJr7vRJyd2tF/BsRjpRjR1TY2vKsUmwOXc6APTfn7LfYVqM9czW+RyTCqzC+MLmaT3
         +8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751609257; x=1752214057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Li63ssKppcLITl1ITfej/YujyWpoLXNJQdKFDqdnOTk=;
        b=TnWNQEMc3KWh4/jONt18FLP8uMjoEsHwYrTlS8KRX5FU9VcpQ4N0zDXQVNSqbW9W26
         cBpanTndRwfBoaiRVwmYptAZVxZEMIyjsoirC1LmqyYJIjPPnhKqhU4fG/0NNQV3TBqI
         0k+NcaI50DLRSzhA05o/owmTod3Kh1IPEp5PjkfXUnb66WSgpCC9G6xi9mrSmmyqRJmr
         7bYqV4MOWbxZz0NkZ8lYXOH7hoWLzARLXM/YGw3r5CwKdXzEPBm+zPyVnJtvi+BYhfvs
         xlpgsKrIznPA6MXx9z1GEgmfXuPbfmvaWXKLv7o125z53fdMFsecYDnIKL9YHxztOpXm
         E9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm4jUyB+XVYcTcWqMTFBUXhuoFEepvmVLYvhRbXxMVaC4Vsc75c2IpplsgJcwxZkXXpV1YeUpRoRjSFPsk@vger.kernel.org
X-Gm-Message-State: AOJu0YwB9onk8p0rojmuR/xU/G5khYp1s5IeoMkJj4jqQBY2NFq1g7tq
	pgxxovMHCiLwlqir0XA7YX612TI7S2tbWhF+EFp8040YiBYbq3NkRM8Bh/ca94uLGaBcaUHMUfR
	ObpDIuQ==
X-Google-Smtp-Source: AGHT+IFg2kF2IsphyTUD4Tvtt+9uGgwrJfxzBAwNyZq9idmvq78iXfjYjXpbgDrlsnLunNcFZOzQ5AK3W2w=
X-Received: from pgji5.prod.google.com ([2002:a63:d445:0:b0:b11:3ba:92e4])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e90:b0:222:d817:2f4a
 with SMTP id adf61e73a8af0-22609a8977dmr1043637637.17.1751609256747; Thu, 03
 Jul 2025 23:07:36 -0700 (PDT)
Date: Thu,  3 Jul 2025 23:07:21 -0700
In-Reply-To: <20250704060727.724817-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704060727.724817-4-surenb@google.com>
Subject: [PATCH v6 3/8] selftests/proc: extend /proc/pid/maps tearing test to
 include vma remapping
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

Test that /proc/pid/maps does not report unexpected holes in the address
space when we concurrently remap a part of a vma into the middle of
another vma. This remapping results in the destination vma being split
into three parts and the part in the middle being patched back from,
all done concurrently from under the reader. We should always see either
original vma or the split one with no holes.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-maps-race.c | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 10365b4e68e1..764821ffd63d 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -416,6 +416,95 @@ static void test_maps_tearing_from_resize(int maps_fd,
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
 int usage(void)
 {
 	fprintf(stderr, "Userland /proc/pid/{s}maps race test cases\n");
@@ -527,6 +616,9 @@ int main(int argc, char **argv)
 	test_maps_tearing_from_resize(maps_fd, mod_info, &page1, &page2,
 				      &last_line, &first_line);
 
+	test_maps_tearing_from_remap(maps_fd, mod_info, &page1, &page2,
+				     &last_line, &first_line);
+
 	stop_vma_modifier(mod_info);
 
 	free(page2.data);
-- 
2.50.0.727.gbf7dc18ff4-goog


