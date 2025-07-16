Return-Path: <linux-fsdevel+bounces-55078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D84B06BEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 05:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE2B175CBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 03:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFDA286412;
	Wed, 16 Jul 2025 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9kRNii3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708227FD6E
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635171; cv=none; b=fr+HcITu6WogVd4QY40RRM3RiHclB9pJT0jcG4DPu2A0mC+9wZVsXzwcLrzM0pHle2n80DL4jMNmCoSefdpXOtFobNQvs9veT6E31EbeJQAoIjkYfCorCOH/3XR0Uc1FrTnS7zWTnG8QP9Aw4eRFsE1eTVJBT0OiMsCxAbZTggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635171; c=relaxed/simple;
	bh=6/KDaBp6ZM8MWS9qb0wO08Ku16BqGmytBKM3lNMr5qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pENZ5K5agCdFHnce3Atnv9fbwG3JY3Zvp6n3oWPcsfkh1a8Udugkx+ATUifxiuffPQFfo2S+x7Y4xAd9REECxMUJVg8KMOvsUWd3oSonQHoDR/MJPngcdrG3aYiL9MurLntr70ptyX5sRxLjvt+Btyk4oRZyz6ydkbs6yP8eYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z9kRNii3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7492da755a1so5156327b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 20:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752635170; x=1753239970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz+/Rb5/fWdnaWsOelI+A9jPFxhtbRCP90y3FqomvrU=;
        b=Z9kRNii3A+ZUDNahoBWqKv+4qYGOeNQI8J4k9oDpX5CmH2fCf7y25S+FYQfHuXcs5q
         IH8XkaQf2+RXR9iNuDDIn2vLfLH93qou3j6PbEoEIG6DXPEm/s9fKCuYWnY7gV90FBEa
         qd4sjvS03ep20euYOCuy5e8m2XK5kfSWbdf1bUWxfkvcsF7n9j1GBKspJMU78GSZS4dx
         Cua5KmaGE2piQlhcK+uSRsemHA6VFsiD6MLbrxgmFgHEuLdqLem9uJfdVybvxuqZW3uv
         +dtGtsQE/gMpT8jDtNfAp3MeRsnKJvxvN0xF23h38Tvv1CJaj6Q7unhAy4dzX4WtuThp
         pVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635170; x=1753239970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz+/Rb5/fWdnaWsOelI+A9jPFxhtbRCP90y3FqomvrU=;
        b=uOY5UGqke4yRIG//FLgpV1wDxt0ik0czu5GsC7vVs6cZNiUhNra4WBg/csIAfaPkf1
         H4ZMAUb3CUA1+Ji7LGefc8GxQFUBnRaOhU7z9GsGtqYMPLEueZ9Lc5PYvUzSJ1rTxGJi
         vqNLMfDRNeTAiSqoQuSTUfS/Y1uKsFjZtONyOY6wP1/GTz0Gr52yiruemIEBXfT3o3HG
         fC1y/R4kBWYhEsY/kbnB+85nWAkU/JclIerENT4xn2ik1O/+Ch6Wzl+Hzd+yVMJHGNoG
         y8I2JuOGhadYZOZ0ir2AM/fYyiuiSFelNuEf9UjYgmtBN45yBnIrpj98CXHTux0R5qIc
         8vLg==
X-Forwarded-Encrypted: i=1; AJvYcCWK0tiJW/6Ha+TS9uglfq6x6Gtnd0FK5iYLiEaXBhE1bjZUsvK9XzU74Yc/ViRc+WyyjWHdV985dqL60fK5@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXc41VLTdfdfB/S+1DpdsNuczHvet2jkzp3IIaQfTUlgRxQEW
	+F1kXZKNhIvdDQF5FZgKTy14vwSGcJP3yKT0NafpiXfO5ufsP8wSaPLQyaj6ow/bHoEx9tdAsYr
	xHEtYVw==
X-Google-Smtp-Source: AGHT+IE5zlLJfJSiKDps9oa63lOpF1CpedYQdGtHutsY8b9qvB6aXOWJRFpftXMF7nK7d9tGDEfQnxjduYc=
X-Received: from pfbjw38.prod.google.com ([2002:a05:6a00:92a6:b0:748:ec4d:30ec])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d1c:b0:220:e5e:5909
 with SMTP id adf61e73a8af0-23813c6df02mr1420419637.20.1752635169133; Tue, 15
 Jul 2025 20:06:09 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:05:53 -0700
In-Reply-To: <20250716030557.1547501-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716030557.1547501-5-surenb@google.com>
Subject: [PATCH v7 4/7] selftests/proc: test PROCMAP_QUERY ioctl while vma is
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

Extend /proc/pid/maps tearing test to verify PROCMAP_QUERY ioctl operation
correctness while the vma is being concurrently modified.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-maps-race.c | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 764821ffd63d..6acdafdac9db 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -30,6 +30,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/fs.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -239,6 +241,21 @@ static void capture_mod_pattern(int maps_fd,
 	assert(strcmp(restored_first_line->text, first_line->text) == 0);
 }
 
+static void query_addr_at(int maps_fd, void *addr,
+			  unsigned long *vma_start, unsigned long *vma_end)
+{
+	struct procmap_query q;
+
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	/* Find the VMA at the split address */
+	q.query_addr = (unsigned long long)addr;
+	q.query_flags = 0;
+	assert(!ioctl(maps_fd, PROCMAP_QUERY, &q));
+	*vma_start = q.vma_start;
+	*vma_end = q.vma_end;
+}
+
 static inline void split_vma(const struct vma_modifier_info *mod_info)
 {
 	assert(mmap(mod_info->addr, page_size, mod_info->prot | PROT_EXEC,
@@ -299,6 +316,8 @@ static void test_maps_tearing_from_split(int maps_fd,
 	do {
 		bool last_line_changed;
 		bool first_line_changed;
+		unsigned long vma_start;
+		unsigned long vma_end;
 
 		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
 
@@ -329,6 +348,19 @@ static void test_maps_tearing_from_split(int maps_fd,
 		first_line_changed = strcmp(new_first_line.text, first_line->text) != 0;
 		assert(last_line_changed == first_line_changed);
 
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		query_addr_at(maps_fd, mod_info->addr + page_size,
+			      &vma_start, &vma_end);
+		/*
+		 * The vma at the split address can be either the same as
+		 * original one (if read before the split) or the same as the
+		 * first line in the second page (if read after the split).
+		 */
+		assert((vma_start == last_line->start_addr &&
+			vma_end == last_line->end_addr) ||
+		       (vma_start == split_first_line.start_addr &&
+			vma_end == split_first_line.end_addr));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
 
@@ -390,6 +422,9 @@ static void test_maps_tearing_from_resize(int maps_fd,
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
 	do {
+		unsigned long vma_start;
+		unsigned long vma_end;
+
 		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
 
 		/* Check if we read vmas after shrinking it */
@@ -409,6 +444,17 @@ static void test_maps_tearing_from_resize(int maps_fd,
 			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
 			       !strcmp(new_first_line.text, restored_first_line.text));
 		}
+
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		query_addr_at(maps_fd, mod_info->addr, &vma_start, &vma_end);
+		/*
+		 * The vma should stay at the same address and have either the
+		 * original size of 3 pages or 1 page if read after shrinking.
+		 */
+		assert(vma_start == last_line->start_addr &&
+		       (vma_end - vma_start == page_size * 3 ||
+			vma_end - vma_start == page_size));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
 
@@ -479,6 +525,9 @@ static void test_maps_tearing_from_remap(int maps_fd,
 
 	clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
 	do {
+		unsigned long vma_start;
+		unsigned long vma_end;
+
 		read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
 
 		/* Check if we read vmas after remapping it */
@@ -498,6 +547,19 @@ static void test_maps_tearing_from_remap(int maps_fd,
 			assert(!strcmp(new_last_line.text, restored_last_line.text) &&
 			       !strcmp(new_first_line.text, restored_first_line.text));
 		}
+
+		/* Check if PROCMAP_QUERY ioclt() finds the right VMA */
+		query_addr_at(maps_fd, mod_info->addr + page_size, &vma_start, &vma_end);
+		/*
+		 * The vma should either stay at the same address and have the
+		 * original size of 3 pages or we should find the remapped vma
+		 * at the remap destination address with size of 1 page.
+		 */
+		assert((vma_start == last_line->start_addr &&
+			vma_end - vma_start == page_size * 3) ||
+		       (vma_start == last_line->start_addr + page_size &&
+			vma_end - vma_start == page_size));
+
 		clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
 	} while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
 
-- 
2.50.0.727.gbf7dc18ff4-goog


