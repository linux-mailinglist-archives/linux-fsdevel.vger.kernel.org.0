Return-Path: <linux-fsdevel+bounces-56302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888A4B156D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 02:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1554543270
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 00:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628A31991B2;
	Wed, 30 Jul 2025 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q0MaheOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE1F1885A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753837140; cv=none; b=HbeOPPWb5JDei9QexQHfZsnkOA8CxUxgpNw7b3NMeQXRlyLIi7xBvfLlQN5W5bE3Q+xxvK9mZ+OuR9rfBKsLUx5Vqb+7qxWYbBmeCbp9bYOaVeY6LojU6znKt+4vcAmzy9DaG9aXMsgao8dpACtNKrE0v4IL1lxwC3BKhN6y2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753837140; c=relaxed/simple;
	bh=52dGNsfCzYMNb7XqIBXnTCNHJh+uI7s3tVSTq3e1Zzs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UM72phakmsJopk22oUX12MynuYkD86DKYEr/AmdkFz61qEkYh7zX3KLUQ2RmLJeMHeJuMarGUXTA4X6Gu78k9y+o1GlteaOkSNR8VlQJshlOp67F1lrBXHA9IimhDWp15CN9x9tuUzj07E70849MbaLGKHMkhaJZrB6JCVlPTmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q0MaheOB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132e7266d3so6812043a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 17:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753837138; x=1754441938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jDQwseaUqKXgQMG0PL1emMIiquT/LrlyEZB+aSduFZ4=;
        b=Q0MaheOBcbEG6J8+lt/BqQSuEcsw7jVNhnVHmOLbnMJVHdfxQcISW1u+7F+eJCNhgm
         3aWS7b2hPt0rdLxLVF/imiQdCJsBwvseeJyQzdcM1ScupDFcQPqX7hiCamVpQ3dTYrTo
         faQpQ+7b3M292knHogrqwwV9V4C7NApQWEOH/z2WWPSRm2Ff5pmHTYn/+QFH/3ePL0JZ
         Ofetf0TwdpK8CZBjtrNgIapV9o0W1p+/akoLVBwyQX1fnhgBNXRufiku3/PzfJcHlP2L
         CaWQwj9+mtVxlPIC3CgThVonCl6OA/YMYayOhqqoAJ/BGjoJtsTmOUVvGkfZAJLxb7tg
         8t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753837138; x=1754441938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDQwseaUqKXgQMG0PL1emMIiquT/LrlyEZB+aSduFZ4=;
        b=an4LMwew0+8ygim7O7vZl6MItwA/WCCDEoQP9D1bNxM5HLYxVZqJlYL1X8LTl2jFwc
         JtwKJUNDLbMnY1CmnfqGzHHT5lY4ED8PCYQRS+AkkJZfmETCnEf5BNtHDDBe3bI3rekN
         8asTFIcEDfGVS8PKYy71SPZqkgZ5Yle3XZYuh6QDvEjYQh5YxVqEj7jri8s989ekwrkX
         OsXYN+IiGLolIpcXMc8nQUY5fFhCE1R1sLS8dP0YY/WS86WLf2PoL3+Y5VRt4VF9onBQ
         GqN9LCDuIOUg/66B5c1h1ih28SBPgy+Te+tHyGfFMFT9SzvVaOxjO58aBqPvvHQGuPrG
         Yz5w==
X-Forwarded-Encrypted: i=1; AJvYcCV8M1S4qf2DUZjlro2cQBgW76H+MFLvz+0NyG63/JvOtVzm87O9fuhLj4830WVM7siUtkbuYNbPlEP/4CTx@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAqTPsJagCI6eYAT2VSZb56f2+oHW15TLHPTTWWmr2blgX/az
	MGbLrbOUs/uY5OsSjNxKWgdQuhH1Nq7MZJz6pFJhod/K4BHyB9lWM++cetE617fi21M8oRqrFxi
	unekVQ+tix2BzABN9GcpNn0MBU6Im6B8SE6DouA==
X-Google-Smtp-Source: AGHT+IEGVoBAYELfdRdZ8xP5oRpoU0bK+jZlnzB/TmwUAobgxp21zhLfsqJQJKUf5/TTCLpNwHYxnC3kjLaDYc3GnzINcA==
X-Received: from pjbpm8.prod.google.com ([2002:a17:90b:3c48:b0:31e:a865:8b32])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b83:b0:31c:3872:9411 with SMTP id 98e67ed59e1d1-31f5de63c28mr2092662a91.33.1753837138329;
 Tue, 29 Jul 2025 17:58:58 -0700 (PDT)
Date: Tue, 29 Jul 2025 17:58:08 -0700
In-Reply-To: <20250730005818.2793577-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730005818.2793577-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730005818.2793577-4-isaacmanjarres@google.com>
Subject: [PATCH 5.4.y 3/3] mm: perform the mapping_map_writable() check after call_mmap()
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: aliceryhl@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andy Lutomirski <luto@kernel.org>, 
	Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: Lorenzo Stoakes <lstoakes@gmail.com>

[ Upstream commit 158978945f3173b8c1a88f8c5684a629736a57ac ]

In order for a F_SEAL_WRITE sealed memfd mapping to have an opportunity to
clear VM_MAYWRITE, we must be able to invoke the appropriate
vm_ops->mmap() handler to do so.  We would otherwise fail the
mapping_map_writable() check before we had the opportunity to avoid it.

This patch moves this check after the call_mmap() invocation.  Only memfd
actively denies write access causing a potential failure here (in
memfd_add_seals()), so there should be no impact on non-memfd cases.

This patch makes the userland-visible change that MAP_SHARED, PROT_READ
mappings of an F_SEAL_WRITE sealed memfd mapping will now succeed.

There is a delicate situation with cleanup paths assuming that a writable
mapping must have occurred in circumstances where it may now not have.  In
order to ensure we do not accidentally mark a writable file unwritable by
mistake, we explicitly track whether we have a writable mapping and unmap
only if we do.

[lstoakes@gmail.com: do not set writable_file_mapping in inappropriate case]
  Link: https://lkml.kernel.org/r/c9eb4cc6-7db4-4c2b-838d-43a0b319a4f0@lucifer.local
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217238
Link: https://lkml.kernel.org/r/55e413d20678a1bb4c7cce889062bbb07b0df892.1697116581.git.lstoakes@gmail.com
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
[isaacmanjarres: added error handling to cleanup the work done by the
mmap() callback and removed unused label.]
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 mm/mmap.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index cb712ae731cd..e591a82a26a8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1718,6 +1718,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
+	bool writable_file_mapping = false;
 	int error;
 	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged = 0;
@@ -1785,11 +1786,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			if (error)
 				goto free_vma;
 		}
-		if (is_shared_maywrite(vm_flags)) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto allow_write_and_free_vma;
-		}
 
 		/* ->mmap() can change vma->vm_file, but must guarantee that
 		 * vma_link() below can deny write-access if VM_DENYWRITE is set
@@ -1801,6 +1797,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto unmap_and_free_vma;
 
+		if (vma_is_shared_maywrite(vma)) {
+			error = mapping_map_writable(file->f_mapping);
+			if (error)
+				goto close_and_free_vma;
+
+			writable_file_mapping = true;
+		}
+
 		/* Can addr have changed??
 		 *
 		 * Answer: Yes, several device drivers can do it in their
@@ -1823,7 +1827,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
-		if (is_shared_maywrite(vm_flags))
+		if (writable_file_mapping)
 			mapping_unmap_writable(file->f_mapping);
 		if (vm_flags & VM_DENYWRITE)
 			allow_write_access(file);
@@ -1858,15 +1862,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	return addr;
 
+close_and_free_vma:
+	if (vma->vm_ops && vma->vm_ops->close)
+		vma->vm_ops->close(vma);
 unmap_and_free_vma:
 	vma->vm_file = NULL;
 	fput(file);
 
 	/* Undo any partial mapping done by a device driver. */
 	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	if (is_shared_maywrite(vm_flags))
+	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
-allow_write_and_free_vma:
 	if (vm_flags & VM_DENYWRITE)
 		allow_write_access(file);
 free_vma:
-- 
2.50.1.552.g942d659e1b-goog


