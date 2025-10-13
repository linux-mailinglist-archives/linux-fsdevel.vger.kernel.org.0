Return-Path: <linux-fsdevel+bounces-64057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3CEBD6CD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 01:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD9354F6AD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 23:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C922FBE18;
	Mon, 13 Oct 2025 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3gexvSH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA302EB865
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399749; cv=none; b=Q8noOGW6r9a5J2IZztgdxg2O3OKywKi174HZLy8U3DLxyA+yB9VLvQdL0u04L7K1isCkBiYheOJKk2S/eiDAaSad4/n5at8ccDlP2T5Dr7B/BfKnqh2y9Rkss8kCFtVKkpCzI8JHwFti7iUEBgOd6SAotw5t19J3gSVE2dTelN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399749; c=relaxed/simple;
	bh=0KofPGztAMLkltCxO7fjuLxhuRnd3teI5IR2S/OXdYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hcwS2mRiSCcckX4WpqRP9lY6h8ZzmhYeMaEQRalrUvspzT1O+gU4vPAW5+Xizh0VtR/Sybjpx0vdKRyeb0LgHM1AKWpHW1kNBjWCHEQdjPVxRsumwxhijlF0qUPAhpY8uLz+O22iNs1soMBKpHfMvjkxrZMJyW9cc4EMSIDnVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3gexvSH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso13837726a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 16:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760399747; x=1761004547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rWZlQ2orhu2ToWW4Y9B+YoDEtQfRAkGMApIJKpfngA=;
        b=B3gexvSHWHlkT5QHf/fVwbBNTLhC/Q8xF1Ahv1cLtVIHNxfoqQ6csojLGxTIenitAt
         UnZ0Oy6uFyeSMoBqmKJ08UZR887eA2cIYLgzdGMiF9Y7XRw2h5KXq1dB8z9ALJPD3m4z
         xUrIgb5zX+ysMl9p0TTIOQ9QfkyYYEkS0e+09nd3yfr17xMU60MEpduqMQI6fExfC5k8
         NyloM+x428m2xPU793OO/hBqA6WjwVfRX0kX5a3LzEDZ7LK91EDDXgnb9MN0g4eantlU
         HenWpHv445LJQuo36I9T0StjUQqRIb9oYSS0Xe+nwIV/medyLiakqemj172ciLXoJs3t
         QYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399747; x=1761004547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rWZlQ2orhu2ToWW4Y9B+YoDEtQfRAkGMApIJKpfngA=;
        b=f5SMJOdkeQgACE0L1SBKja2c0WtSXZ9tKcaCqFPBAfpSwAiSUt82x2E0hrfNfVr+dJ
         NriPmWtMvBLPv0l2Rn8o4gYKOOICck23xfrCoNH3O7o7JqT08em0ZfXDMTBSBye6+an2
         C840Zep9LCD9KiPTxrBMmyntYLUjdhUz9MNZnKvzfEuxcxqNMMXsE9h+QSwz7YBhGHfV
         mF9wtyB/rwKEIH9zQNy2YZfHBNhonEUmL9V2nr+dybtrwexOUFlox+fCmBLl9w2y4pzn
         CDdMhvpAzUQxASQ93rK5HR0lfO90i0+ZvB7yws6gBdF6PJEiIRSbp2NJASIcyNuM6l0B
         3Scg==
X-Forwarded-Encrypted: i=1; AJvYcCUlR4zS6gMxB/wQMPVLFIYHKxYNiJi3jp19MvgjzHMQwbR651p+UeHmwHk8rkXI3jTlmWGsEe5k+TAKgQcA@vger.kernel.org
X-Gm-Message-State: AOJu0YwsqAdA020aJnajwFhc3zX3d7fdH9iwEZqmk6NLA20Azk4Y3LHx
	Mselmm7YzK68UxIlR/PeALZAqnasHL0gmNxwrHQC46FcMRmH6GLDDZ7MVp3fLYeF0xcrqt73XIB
	lRYEm81q4U4KRuMIvY/3U6fUPdg==
X-Google-Smtp-Source: AGHT+IGScETQx55bga4w6kvGfG7E35WD9DziDa+ZAZXqWYfQigIxpcLfBDKsXWxtq04osZKOoTiH4wackQ/kqzmTPQ==
X-Received: from pjtf24.prod.google.com ([2002:a17:90a:c298:b0:339:ee20:f620])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b11:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-33b51149231mr34380315a91.7.1760399746893;
 Mon, 13 Oct 2025 16:55:46 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:51:52 -0700
In-Reply-To: <20251013235259.589015-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013235259.589015-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Message-ID: <20251013235259.589015-2-kaleshsingh@google.com>
Subject: [PATCH v3 1/5] mm: fix off-by-one error in VMA count limit checks
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org, 
	SeongJae Park <sj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The VMA count limit check in do_mmap() and do_brk_flags() uses a
strict inequality (>), which allows a process's VMA count to exceed
the configured sysctl_max_map_count limit by one.

A process with mm->map_count == sysctl_max_map_count will incorrectly
pass this check and then exceed the limit upon allocation of a new VMA
when its map_count is incremented.

Other VMA allocation paths, such as split_vma(), already use the
correct, inclusive (>=) comparison.

Fix this bug by changing the comparison to be inclusive in do_mmap()
and do_brk_flags(), bringing them in line with the correct behavior
of other allocation paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v3:
 - Collect Reviewed-by and Acked-by tags.

Changes in v2:
 - Fix mmap check, per Pedro

 mm/mmap.c | 2 +-
 mm/vma.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 644f02071a41..da2cbdc0f87b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		return -EOVERFLOW;
 
 	/* Too many mappings? */
-	if (mm->map_count > sysctl_max_map_count)
+	if (mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
 	/*
diff --git a/mm/vma.c b/mm/vma.c
index a2e1ae954662..fba68f13e628 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2797,7 +2797,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	if (mm->map_count > sysctl_max_map_count)
+	if (mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
-- 
2.51.0.760.g7b8bcc2412-goog


