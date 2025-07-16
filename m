Return-Path: <linux-fsdevel+bounces-55076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356BAB06BEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 05:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666C54E6061
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 03:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D3827A445;
	Wed, 16 Jul 2025 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V0dnLROl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630BC278E60
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635166; cv=none; b=Orm7Ttc+1v9N8GzXk2RLdz0rTbnI7FxVDTRTv7oo39UpeHKqNhSN/P2IGqD6Ro4qm4fs79BD0mYp6ZzCjk5Iz2fHsdKbDFpwDY98RARn25FF9q3BEde3msvPzzu+0tXMU4HoMxDYXb074N9Vl4xznUoI+qbt7okznU3XY3EQ/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635166; c=relaxed/simple;
	bh=ulewSdFhhtT6XYUvitzcBD75LHyogn8pm3lfZUrI9VI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ht9JoCBlq6WSxBbGm99V69z/QCfpJoCJyiQRLE8uf1bKPDguiYtvatPS0MABK7lljC9KPiAuoh56wbXKbeumECsrXtVuoTGI8PnUzuugum2mESBsB9MOcq2wiqn2LIlaJz5fMpGKx6Ai3IXV5YvkLCESFCpP+dMm8f9AVK4L36Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V0dnLROl; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74b537e8d05so5282523b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 20:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752635165; x=1753239965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OwmJhXkBZ0rkJP8ZDJsJXdxfIUoApnDNh42agcrLiOc=;
        b=V0dnLROlkVW0y8NdwsHaDCXGaMfByNPj+qyzbFf3f/hJ7wzDRX8wtUqJ2gfxQqK3QY
         H3LEtdB5aHfFR+TXXbUpI+VYyZmduSx5xOY5cxraVsJIjS5oYPKVBmM8u14kF6R6aRHo
         To4vlHaVbANfdrgitBmYxT8QExlrczbPTwK2bgMEK4rHVCEg9297+XpnzDXP6GlJTCHW
         7Up5HwH6m4qpjxLgsPYuoR7a83bTlpmg7q2ZL7EHsjl0jtfIU1sY/lKApoKBLFWzHrmF
         N3/CVFU6YDgijeb5GF4/p+nHe6MMqqPtqnSxb68Mi54vxPoZ/kiG2rhqVs09IKME/C/f
         gmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635165; x=1753239965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwmJhXkBZ0rkJP8ZDJsJXdxfIUoApnDNh42agcrLiOc=;
        b=Yu6C5EbIj6sWOlZZMo68szCncXM8gU3UwVoARPRpJbMyNLo9noIhkdUMYVPE89sP/a
         /b4lytWC/t5SCEsety//rIeGLW09oKXi2fUobSRCN9mZAWycEEYn7gN91yG4rRJCxLja
         RPEcKeIETJOTDVkTu07HcJgAyCnMLOAukxZ1kO1rfeFPMXMnv4BQIGWkEdwRh96MTxZH
         /AoLQDNBItvNEvJbHJhwHJyLoFnhAww04CElOhEpbgFD3Rt+gSyuwy+eVf8mIFbhgibb
         qaRaV5/oz6x7K76160uVwWzgLkfMwMReTZwQ1KidJtZCZ25hNC7geiu0C/ZwpJ2Y/xxq
         uvog==
X-Forwarded-Encrypted: i=1; AJvYcCWV6IeqgSjql8DjXOKipjetRoiOybPmqAjFU76RV4v9VuDaFLydPWak+mC8MM0S5Zji1lQtNbYiONZyVv7F@vger.kernel.org
X-Gm-Message-State: AOJu0YzXaTRCtbx/orqekiB7R7eKP79PXYg70ZX9hK/1yEHDhNzwGuC9
	jYyUuyl80MkszrVXEnARqKg5NyoZt8HehE842CrmjKWVYOwtVbn8OBfAxGw0urNnYyUcWs0lb90
	x2IS3yA==
X-Google-Smtp-Source: AGHT+IGzJv3h9zkM0+zyuvpyi7dydp51mDl7cBy864qKJxNT3Tnay4b8zYqfF0oK2BvdPup3ers/Chkr8aM=
X-Received: from pgkg9.prod.google.com ([2002:a63:fa49:0:b0:b2f:9d37:5753])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:160f:b0:21f:751a:dd41
 with SMTP id adf61e73a8af0-237d896b159mr2950162637.40.1752635164680; Tue, 15
 Jul 2025 20:06:04 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:05:51 -0700
In-Reply-To: <20250716030557.1547501-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716030557.1547501-3-surenb@google.com>
Subject: [PATCH v7 2/7] selftests/proc: extend /proc/pid/maps tearing test to
 include vma resizing
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
space when a vma at the edge of the page is being concurrently remapped.
This remapping results in the vma shrinking and expanding from  under the
reader. We should always see either shrunk or expanded (original) version
of the vma.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/proc/proc-maps-race.c | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 523afd83d34f..10365b4e68e1 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -336,6 +336,86 @@ static void test_maps_tearing_from_split(int maps_fd,
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
 int usage(void)
 {
 	fprintf(stderr, "Userland /proc/pid/{s}maps race test cases\n");
@@ -444,6 +524,9 @@ int main(int argc, char **argv)
 	test_maps_tearing_from_split(maps_fd, mod_info, &page1, &page2,
 				     &last_line, &first_line);
 
+	test_maps_tearing_from_resize(maps_fd, mod_info, &page1, &page2,
+				      &last_line, &first_line);
+
 	stop_vma_modifier(mod_info);
 
 	free(page2.data);
-- 
2.50.0.727.gbf7dc18ff4-goog


