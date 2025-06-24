Return-Path: <linux-fsdevel+bounces-52802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B104AAE6FAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 21:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0EA7AA808
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 19:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B182E8889;
	Tue, 24 Jun 2025 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tk6JcZJL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4AE2E92B1
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793649; cv=none; b=sbsYIH+7FSGABgUYfAMjG1ZymnbVfmh4BNWBxna3Dr5FjhC3IGz7yCt9S7U2PUiowajkeU5cHEDyzisxW4zFUY89/vs/osjJXukys14toe6JbPp0mDX0Y7JgpkyH84CYI/2BwBY4OjBkoFXudjS3WRg+FePtXM867omhWE5VTLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793649; c=relaxed/simple;
	bh=6N56cO+mEI93aCD929OWXgdVDQmRt6u/f2iRrSkiXBY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D++Y9hSBEfZb6nDc8kqjvhRlhL0tcqQSBpNU5N0RQe2ppNvjddJgZD2ohDYh/VytF97z14IdMPiSaOsxbctp+nA9w+Kckx3n2PGnwdcmFD5f1wrXJvXul0fALjzPmiwZDsxY0lzRDE7ZSY3Lzu03J0BXIOv0mGFY+HcShF/caBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tk6JcZJL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748f13ef248so4366775b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750793647; x=1751398447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UC2aFr+2hBpo4c8OQj6ulNMqnFjS9I9wfu23t0p6gWo=;
        b=tk6JcZJLly3FgBTmdsemuIUDIl7dxcOpbtvOW6o0b+rh/CpFrYJXAwCvXoFhntDkVV
         74ALfeTpNGYWI1BLqtaD9nRF/9nohrsD89N0AgRpBiShYoFZeDkPuXU+kEC7ynAcNKIz
         D78BjZ2j53bgsOBVB9gRuj9LAHW1/gUaNkf+Yo2Q1EyRNfYL2Fc5swKiFlnUjazcWGi1
         /aBke/UaLrt/KaODq9OnUjEmdt38MiahV403+BJbSqO4cuQbgBXxrakwpaWxiAPToRvK
         2VanKTly/kRzdvWjdcsCSER9C07YUac6DJsCpQU1wl1QweDO5MGkqfdPNMfU8g6yX6KL
         nzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750793647; x=1751398447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UC2aFr+2hBpo4c8OQj6ulNMqnFjS9I9wfu23t0p6gWo=;
        b=MhExLMsbhcArhMlNtZGXdoT7Mnjnbhez69Z+a6N8HsnhhkP1RccphniAomugaijBE3
         d5vygESabA94WsG4uRw9/msbKAeej4QtmX/P6N7OMNvx2oGcUvmEq8mqUzI5Tk5hTx1e
         vYrKDTJsKDla1snJak+j4z7dz/sRI908NmJLMNC3jaVuxyd+w1F+NV2eLGGrXn+oQnbu
         t353UQHwtgB/W1Xzaiq7TvVUEBXvV5Fat2eRcKcuzSgl6C75Lx92mH63yxuZEofx4uJG
         bJpKyQEnQWpTPGot2jEUfD2QUZI4AfS6pYzsRyKw24deANvp5CHkY89DgpvVQ2UJB/kE
         IpVA==
X-Forwarded-Encrypted: i=1; AJvYcCVV8Y01NQO7EjOVZUDsCYf53sy8BU9TH5QYrN14xyQm0r3LkqQ6EtMIXj+eRveRjnr0WzpHzEDf0Bl7nJGb@vger.kernel.org
X-Gm-Message-State: AOJu0YxDxSXAdxrv8AsqvOvl5mYtWWF2lZNchW+YlKxEsnIZUOLAOlqx
	WFQE3FYxn218iagzeB7JuX06gPLNGpM4LbW3gaaCw0U9ApE7OwfDBCIzJru8c+HnEjMBikeAtQL
	wP+Lw/w==
X-Google-Smtp-Source: AGHT+IGXFGZq1eG2J9AB8OK4tRQIFjL7wLANvEFPeXTMgxcyIvcd791KpwM8NoFdIHzomkbPKUWUDTzIDUk=
X-Received: from pfwy15.prod.google.com ([2002:a05:6a00:1c8f:b0:739:8cd6:c16c])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:124f:b0:746:1e35:3307
 with SMTP id d2e1a72fcca58-74ad44fa9e5mr508606b3a.14.1750793646830; Tue, 24
 Jun 2025 12:34:06 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:33:54 -0700
In-Reply-To: <20250624193359.3865351-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624193359.3865351-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250624193359.3865351-3-surenb@google.com>
Subject: [PATCH v5 2/7] selftests/proc: extend /proc/pid/maps tearing test to
 include vma resizing
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
2.50.0.714.g196bf9f422-goog


