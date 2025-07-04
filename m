Return-Path: <linux-fsdevel+bounces-53889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD98AF87A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E199B1C81AE7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 06:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFFF143C69;
	Fri,  4 Jul 2025 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ffK5AO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735221C9F1
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 06:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609261; cv=none; b=J23vlE+prZHwWBBAjPpGxgTIKjSdTegBDiyCNlZt8s61BoWJzFUZjFOblW44d4R9jr7mBQ8/fsxzfPgyW5bnk65P7IMTC0jzDbodlODsD/3i0/cSS7Qzj1YAkMS4YZhZahghESR8x1rOye2fSu8YGYo+XS/oqlCF5+YgC1jIVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609261; c=relaxed/simple;
	bh=6/KDaBp6ZM8MWS9qb0wO08Ku16BqGmytBKM3lNMr5qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rnBBiYyyZuFMUsBTyX38+ats+8BVTyC8gTTUiDUjSXUKSCH4RJceZrYK2+ZSYb86ExpLFz0HncT1aqzxfa7rSP0qKZrHewi5fJQtRuIzKAD08lvqMYKZOG0qicMjRLnuqAejQoiriEzHZPzPGiTgg4Bwd6qCNwqSF53YSC+W8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ffK5AO6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235f6b829cfso5047035ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 23:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751609259; x=1752214059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz+/Rb5/fWdnaWsOelI+A9jPFxhtbRCP90y3FqomvrU=;
        b=4ffK5AO6g6JajBAiHR1LBfKyuiiNpcLzOvei42nDr1LYOryigi0WSc5YqWybLDDF68
         uWyrrzspQoIeAMWZ3i1QNZhQ0ojIwwLgYFGVI3BKOzCgt4UqVLNI2Mj+gvPrJU6CLcrP
         +x7bgv+N+DbpuDwf/W5+VHAttb9TJ5SpoElxjXo1ptt7H4trq2TZ1D/AloH+i6ESbnpg
         95gf/oF9j+GfJPjrPT7ZlApFOHrgLdiv8W/xsxDLVaqJTESk4FwIpBsVCe6vfK+P2vet
         JdL3z4X402t5vP3S5iZOx4syriJLfeMN5J3kdcPAfss1mYXoBXp/Qu4Rh4hXhbrne62l
         CltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751609259; x=1752214059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz+/Rb5/fWdnaWsOelI+A9jPFxhtbRCP90y3FqomvrU=;
        b=pp0J3ana4E6ftadkdrSJAMCfAYkrtxNZ3IhrYv0ztr60M1yAOOeY1hVtoWYeXlLuZ+
         2BAK3vAIWhwXK7dx5Nr206hEVL4WAeJSvBWIlgn5eD1CN3voyf3IMpubj0nRUbcDRhLu
         oL2xBRNvu2ahVUzh9LtWhUpFOygUE5S2wQucXQcf46K8ESHJcMdP/JF9NkR/Bw6ySIVl
         rJnBf4D7Gn/cRL3EX/c+O3qDVKXdrKCNFKhiIgkcOSNVyz+scZWFqVp0grm4vz/i40EN
         24IEyxvTTAaNiGGHL1imDkJIy7Ucox74fhlCvf6R71AEb9/y5AMwDU1sGRWPxnqFUrUU
         T2jA==
X-Forwarded-Encrypted: i=1; AJvYcCX4eYKGvCZi5/7dP4YvmOYLlokijp1NW8p33+uAbtjuqifFoA1NMNUVM5hFyxEXbhSNT59XUJkKlVcsTzfg@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4/zkWMEWBuoTS5w02I7Ppju5SlunjKipTBhB2PHY45JDP/mZ
	8RPOGndHL4MNMBWzMO+7an7cNTAgCUA7n72OUnKvdh2M6GNWY6v1AwmRx2VSA99FWY5e/0fSv6R
	Wxnv93g==
X-Google-Smtp-Source: AGHT+IGb2+UYZlfBpIllsB5zBRnjJDEHHc7eLL5E2NOd532QUxSqIns3SjUtZteR3l3V6p3oyrgM+kKIc4Y=
X-Received: from pjbrs14.prod.google.com ([2002:a17:90b:2b8e:b0:312:187d:382d])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11c3:b0:234:d7b2:2ab4
 with SMTP id d9443c01a7336-23c85de4dfamr22462935ad.17.1751609258994; Thu, 03
 Jul 2025 23:07:38 -0700 (PDT)
Date: Thu,  3 Jul 2025 23:07:22 -0700
In-Reply-To: <20250704060727.724817-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704060727.724817-5-surenb@google.com>
Subject: [PATCH v6 4/8] selftests/proc: test PROCMAP_QUERY ioctl while vma is
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


