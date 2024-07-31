Return-Path: <linux-fsdevel+bounces-24691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB689431E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 16:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A692C2871D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A14A1B150A;
	Wed, 31 Jul 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHAZMaM/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585341E487
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435613; cv=none; b=bgSbe/xA6FEcVg75TPXxYmDBjk5Vx0a6DNEnU4VvwTVfsnEzRqEnbPpkKqpTYlk6BrUyjfELhZKQdPuxj+a0wStGMF4XirIQe9kTYss7RLIGWlevD6N5tlrAkViTLa51jsGQqMHIn95uBpF0SyaBDoOPehg1a79kObKjdxvJspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435613; c=relaxed/simple;
	bh=umV/3wAO7tQw18Xoft0QYP/gnHE80Mq8jo7NHcA5zGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUnay4+Bh534LHZWZvqpBmgPhUaHDu36IiLSzNkb2BP1ecW9Y+B79RrNxnsnZRWmOgQVHy9Et/CJ0IZh8wivmAwfDTw0DT+aH0lwcckfwyoo+bMudK1kA+SYehpvOk07lslddV7R2llRLXmge5IE2OshKzoXWozsmpw8eY19lfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHAZMaM/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722435611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2OX9pHIYPCYciT54Hwf95cCUxzek0vThGczntvqQatQ=;
	b=NHAZMaM/VGDLWaUr/QMhc+gdAtYj7D9VtQitFu4o28f32es7XUL9VRomvj9NvdKchfscy+
	wcF7f2WrbFu9yVPTw1q1BCWF3MMMgtP31h+Z2RRlGwBTgGYSvDVVnPAGR/KsXp35Q93dsG
	bfh+BDpBNg8Gh88HZQ8CVpucaMaf3bg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-1ubZouPnO7KGbLcP0s3P_g-1; Wed,
 31 Jul 2024 10:20:08 -0400
X-MC-Unique: 1ubZouPnO7KGbLcP0s3P_g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF2D91955D50;
	Wed, 31 Jul 2024 14:20:05 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.228])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B863019560AE;
	Wed, 31 Jul 2024 14:20:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v1] mm/hugetlb: remove hugetlb_follow_page_mask() leftover
Date: Wed, 31 Jul 2024 16:20:00 +0200
Message-ID: <20240731142000.625044-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

We removed hugetlb_follow_page_mask() in commit 9cb28da54643 ("mm/gup:
handle hugetlb in the generic follow_page_mask code") but forgot to
cleanup some leftovers.

While at it, simplify the hugetlb comment, it's overly detailed and
rather confusing. Stating that we may end up in there during coredumping
is sufficient to explain the PF_DUMPCORE usage.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/userfaultfd.c        | 11 ++---------
 include/linux/hugetlb.h |  3 ---
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index b3ed7207df7e..68cdd89c97a3 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -371,15 +371,8 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	unsigned int blocking_state;
 
 	/*
-	 * We don't do userfault handling for the final child pid update.
-	 *
-	 * We also don't do userfault handling during
-	 * coredumping. hugetlbfs has the special
-	 * hugetlb_follow_page_mask() to skip missing pages in the
-	 * FOLL_DUMP case, anon memory also checks for FOLL_DUMP with
-	 * the no_page_table() helper in follow_page_mask(), but the
-	 * shmem_vm_ops->fault method is invoked even during
-	 * coredumping and it ends up here.
+	 * We don't do userfault handling for the final child pid update
+	 * and when coredumping (faults triggered by get_dump_page()).
 	 */
 	if (current->flags & (PF_EXITING|PF_DUMPCORE))
 		goto out;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index fa5cc81e61a3..3e4b03de815d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -127,9 +127,6 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			     unsigned long len);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
 			    struct vm_area_struct *, struct vm_area_struct *);
-struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
-				      unsigned long address, unsigned int flags,
-				      unsigned int *page_mask);
 void unmap_hugepage_range(struct vm_area_struct *,
 			  unsigned long, unsigned long, struct page *,
 			  zap_flags_t);
-- 
2.45.2


