Return-Path: <linux-fsdevel+bounces-56451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90761B178C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C14147B850D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 21:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6C4270568;
	Thu, 31 Jul 2025 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utQNirCL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4826E6F5
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999232; cv=none; b=bOft1jc3/Owuu8oZdQIH+cvHxC/shkMMDNx6Qg2iYf88Mp8RLEnxwQEbKqOjmGKjvcSlaGeyz0h6v8t2mV3gPPevUkIaVH/D7CJguNnv8L5bS6imWTKsdg0ZQL91ynaRUiPute1D89Mctj6Yn2qcr/nFK/ePKNdEAVh/NUvyvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999232; c=relaxed/simple;
	bh=RiwVOvQ4OfV3fqsRV0AGydJn3cbs7Xep9L0oRhd2Iiw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CfQKBz1XFz6Dzti9vE1UcLk/s2rwFe+lCwdTfZ+eDX+WFINfjRntVxCmiLUn+kdjf68g5f7JkYQfXwpCt2eB4e5oraC21otSiz9gcptF1+TugQ3UhIkqbUa3CIJLnMhWKDITLdfaLEC43rq/QbhCNypD9WurDUnortpzgxtMR1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utQNirCL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bd757bbccso210091b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 15:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753999230; x=1754604030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNceOmOhkQd57dKgoJb1yry2qV9WAY49fIuYrPBvXdU=;
        b=utQNirCLj+F/sj4naPsDZOQ//8AqkeSYqLz5A4W9AIQxsQDI4Edr3t0Ef8CVDnzLl/
         C2A/tjXyNK2LShMFivb5BJ2g/GTV6XvXs4XoWsDyJJqgeMVA6GGJbMGR2HDgIgA/YvE/
         uvFkE99hg5ZCgeG0wSA2gNYRGM9sgHThbSC5sz8k1t9hpC9dR85fubKqTPP2AQAZFfYO
         LS5nUBssJMMNSwv7XbLwjhoMOoWdbDyjSyQH5BR6XPf2IHKvd+Mq2Z5FnCYyD24WA4E6
         yjvgiAtUYCd70OieAxYv0g5DaF/tP0BrIpVi9SO5ykBRYx0tNU4cOe11G1SIOaDHA9Qf
         mOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999230; x=1754604030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNceOmOhkQd57dKgoJb1yry2qV9WAY49fIuYrPBvXdU=;
        b=QkXEk+6IpkPVJouqxVjSouI4hrA2GlkhT2DWTNHP8n67FLtxs3y0K+ppHTKgnoDwal
         RUFhEfONRaHQImw6ve5+KDleo8WhQTxXvup/LiMGOVGV1VVyRsB0DP5nxB5YzQTM/an5
         Uo5qIdnoLZhVne6+zK4H0h5YLJQeKU5tnQT8jX1h3DRgZfy+VDuiEl570bXl/SkaJNiZ
         Gg20Ijt+3D0MzCTvSoKkIN1CC1FlgznOomd4veuZW9HHG/ropVs6TcyDRsghyOA65f8E
         S7KIw1mFw3AiUAUZ7QdlAJA8RHsRyYuzOx5YZXM/erbDZQ3RKlwlDSVPM9UyT/av2jik
         re3A==
X-Forwarded-Encrypted: i=1; AJvYcCVDyk2TixBLGjghJ9aZdm0xBxDAZwN9M/8tvWInI7jMukK0XnzVD9qxVpiChbqwuiJ+pUFuVnnhIUhHICE2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeixuwd7c/YagFFEr/J7xS61Bc+f5VkYYiGwwHd13ifQGYzrZt
	S1xE8aa8O2HLjhe7TrTe/EpLXj8ZhD/ZiCkzWih/k1is20893SM2E/tkmrTaK1YLUhpe/G8zDpg
	arDmp8A==
X-Google-Smtp-Source: AGHT+IGN+xdEoqijDkNOjG0dwcR0a2XHO8rj8Ew1U8h+s/FjiVf73gnDDd7MDhE7O1ZnTaPwtmwN5GGXu0o=
X-Received: from pjbof4.prod.google.com ([2002:a17:90b:39c4:b0:312:1e70:e233])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca2:b0:215:d28e:8dc2
 with SMTP id adf61e73a8af0-23dc0e84b91mr17365554637.31.1753999229680; Thu, 31
 Jul 2025 15:00:29 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:00:22 -0700
In-Reply-To: <20250731220024.702621-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731220024.702621-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731220024.702621-2-surenb@google.com>
Subject: [PATCH 1/3] selftests/proc: test PROCMAP_QUERY ioctl while vma is
 concurrently modified
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

Extend /proc/pid/maps tearing tests to verify PROCMAP_QUERY ioctl operation
correctness while the vma is being concurrently modified.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-maps-race.c | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 66773685a047..d40854a07ec1 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -32,6 +32,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/fs.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -317,6 +319,25 @@ static bool capture_mod_pattern(FIXTURE_DATA(proc_maps_race) *self,
 	       strcmp(restored_first_line->text, self->first_line.text) == 0;
 }
 
+static bool query_addr_at(int maps_fd, void *addr,
+			  unsigned long *vma_start, unsigned long *vma_end)
+{
+	struct procmap_query q;
+
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	/* Find the VMA at the split address */
+	q.query_addr = (unsigned long long)addr;
+	q.query_flags = 0;
+	if (ioctl(maps_fd, PROCMAP_QUERY, &q))
+		return false;
+
+	*vma_start = q.vma_start;
+	*vma_end = q.vma_end;
+
+	return true;
+}
+
 static inline bool split_vma(FIXTURE_DATA(proc_maps_race) *self)
 {
 	return mmap(self->mod_info->addr, self->page_size, self->mod_info->prot | PROT_EXEC,
@@ -559,6 +580,8 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 	do {
 		bool last_line_changed;
 		bool first_line_changed;
+		unsigned long vma_start;
+		unsigned long vma_end;
 
 		ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &new_first_line));
 
@@ -595,6 +618,19 @@ TEST_F(proc_maps_race, test_maps_tearing_from_split)
 		first_line_changed = strcmp(new_first_line.text, self->first_line.text) != 0;
 		ASSERT_EQ(last_line_changed, first_line_changed);
 
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
+					  &vma_start, &vma_end));
+		/*
+		 * The vma at the split address can be either the same as
+		 * original one (if read before the split) or the same as the
+		 * first line in the second page (if read after the split).
+		 */
+		ASSERT_TRUE((vma_start == self->last_line.start_addr &&
+			     vma_end == self->last_line.end_addr) ||
+			    (vma_start == split_first_line.start_addr &&
+			     vma_end == split_first_line.end_addr));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
@@ -636,6 +672,9 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
 	start_test_loop(&start_ts, self->verbose);
 	do {
+		unsigned long vma_start;
+		unsigned long vma_end;
+
 		ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &new_first_line));
 
 		/* Check if we read vmas after shrinking it */
@@ -662,6 +701,16 @@ TEST_F(proc_maps_race, test_maps_tearing_from_resize)
 					"Expand result invalid", self));
 		}
 
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr, &vma_start, &vma_end));
+		/*
+		 * The vma should stay at the same address and have either the
+		 * original size of 3 pages or 1 page if read after shrinking.
+		 */
+		ASSERT_TRUE(vma_start == self->last_line.start_addr &&
+			    (vma_end - vma_start == self->page_size * 3 ||
+			     vma_end - vma_start == self->page_size));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
@@ -703,6 +752,9 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
 	start_test_loop(&start_ts, self->verbose);
 	do {
+		unsigned long vma_start;
+		unsigned long vma_end;
+
 		ASSERT_TRUE(read_boundary_lines(self, &new_last_line, &new_first_line));
 
 		/* Check if we read vmas after remapping it */
@@ -729,6 +781,19 @@ TEST_F(proc_maps_race, test_maps_tearing_from_remap)
 					"Remap restore result invalid", self));
 		}
 
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		ASSERT_TRUE(query_addr_at(self->maps_fd, mod_info->addr + self->page_size,
+					  &vma_start, &vma_end));
+		/*
+		 * The vma should either stay at the same address and have the
+		 * original size of 3 pages or we should find the remapped vma
+		 * at the remap destination address with size of 1 page.
+		 */
+		ASSERT_TRUE((vma_start == self->last_line.start_addr &&
+			     vma_end - vma_start == self->page_size * 3) ||
+			    (vma_start == self->last_line.start_addr + self->page_size &&
+			     vma_end - vma_start == self->page_size));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 		end_test_iteration(&end_ts, self->verbose);
 	} while (end_ts.tv_sec - start_ts.tv_sec < self->duration_sec);
-- 
2.50.1.565.gc32cd1483b-goog


