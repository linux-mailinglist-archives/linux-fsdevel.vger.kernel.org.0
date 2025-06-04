Return-Path: <linux-fsdevel+bounces-50687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49512ACE707
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 01:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C1F7AA061
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 23:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237DC26D4DF;
	Wed,  4 Jun 2025 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KyTVKZTG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D126B2DA
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749078731; cv=none; b=HgWBwbEWnxr0Y3D1xwczDYmxGyd+Zm6Byj7bL/0cgJ85YYuTUKgOOjL+rbOmj+qHRST1wb/DcR0KUgy12nNII4u/l45idj2GhFw0FQE67Kf0hCHg9NNq/fwGJRbs2lLF9/LRH5pTyrmucO+soFPlg6Dl90K/9ck/AT7FMXv38+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749078731; c=relaxed/simple;
	bh=dk2sns38K9LKA14HdtKMJQ+uodX6+JxmbyhDMndAf5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PQLC+RytDr1VzSHhs2MHncqzPhn96MCVo/JlUi/5RHxfXlcAMfUVW4A3UKWpn4quBoPx2Nk26Q3QDCNX3nknt3YJGxNbZRaLKkCTrwMHEMPKUQSp92jf/RFUrRFp3EpOmmsgelUnVvu16iFhQKIlxxM9MnYMlFbz5C5zoNriwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KyTVKZTG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-234f1acc707so2418265ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 16:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749078729; x=1749683529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0FA9HEfGx7V1U+x/ZxWl25F47mbSYtvHNegG6DkQ3X0=;
        b=KyTVKZTGM6FtpAntKggCjCsGe8xnCJy9WHZ4F6ycuoLqPtzicxivz2VaHigHy0iumj
         qudidAQSbyTL3DwyJapdllMtvsPiVZI5oKmGrFvrHbrp7AB1XG8lJoRqlo7gB8W4au5+
         5Yg3izRnpIJUnZdr5XVpzGDqDjAWEyYZ7M5YiZXxuSotktWSxubAnvfkWEk+u4e5CA+/
         SSWNWf5eAByuSv2P3SinHpWIxil7v/OHARxmVja3mi3omFKxwvtlgt/MHBCGn6pPN4VB
         WC4zLCt4TGIP5hJ4lBPLm349pKxOUA8pAPZqciPQsi8Yl7cQ7jqTbe8OLG4cQT2Xe8Xy
         yqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749078729; x=1749683529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FA9HEfGx7V1U+x/ZxWl25F47mbSYtvHNegG6DkQ3X0=;
        b=vXl6xxf6cKgrCgt6DbLHhfWZ+d1QoCPVZhWv5hjEkLc9EvLJeTlkzVNQClX63Hn8qB
         tKa6W/qKTaN62hmXr6Y2WEB1Qqi1Ht2Rnc97wMsBVqiwN9BLN/DnkJjWwugNPoE60JEz
         ihQO7pH77Y5t+zgqGay2IRFl2vRnJokh1d6JVx6MLqb2yCi8Lo3D+ZLr/PEMs1xfMQYk
         lHGJeowgAFyTrjw2XvXCW1IPo8CPY34qUWw44JB9tgcPfDw9M2gtbZlq7/NjLFa6OCA4
         q71XwcmSoGOIcrrhMlOHp/zqkyUwVeK4LSJhv9LstD6f6C0dF/ioYWDs2jhtAewAaxXQ
         XATQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP+U1fP488aXTNOgwIZyNMmBttbntRAOWkTEGDGtwGk3vmsQKo2N38UZzbCGuszTyms0/W1bvOclfa2VeS@vger.kernel.org
X-Gm-Message-State: AOJu0YwpQraWxTXBVeVy8g4Wqv4RYg9YMoTNQ4+C0dK0NzicrjCxwYEt
	D5o+A2f9i2rtZo5VKghBfRHpVcj09GFl9/7uPLIYlQUz0goK9GX+BCCQ2yhWDKE1c3TuAW1Q4Ej
	boZ4cGw==
X-Google-Smtp-Source: AGHT+IHKTW0FyMFXnbv+r0+NsbH4HZxFH9qcykRJPxlisC0t/nE0casNv64qhrGUdh0QFtZ3/VwVrTXk6rU=
X-Received: from plmt12.prod.google.com ([2002:a17:903:3d4c:b0:234:593c:eb5])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b45:b0:234:c5c1:9b63
 with SMTP id d9443c01a7336-235e1124bcemr58010975ad.18.1749078729438; Wed, 04
 Jun 2025 16:12:09 -0700 (PDT)
Date: Wed,  4 Jun 2025 16:11:47 -0700
In-Reply-To: <20250604231151.799834-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604231151.799834-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.1266.g31b7d2e469-goog
Message-ID: <20250604231151.799834-4-surenb@google.com>
Subject: [PATCH v4 3/7] selftests/proc: extend /proc/pid/maps tearing test to
 include vma remapping
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
2.49.0.1266.g31b7d2e469-goog


