Return-Path: <linux-fsdevel+bounces-9946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C46DD8465BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 03:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E11F26796
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 02:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F05B67C;
	Fri,  2 Feb 2024 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0snY1EF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54344BA24
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840465; cv=none; b=nH/wC7guuMudMzDOMkUFHfJDU0c1mDfFONCsHJNRHfomSrdE1c7VI5MGF5iqpNSlDGBCRIAFCWHSqulUS9gCkfTLf2qsRJtPk64OvM7B12xZeYfNbX4ZC9Ni2DuHpol7J9PZjrFdwbGaZBR3CLFHvVDPqoNcp8dI9OdOZUP4PqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840465; c=relaxed/simple;
	bh=EQIwbZHsGuMlZyQ+7R9MpEihML0bmDWknH+HvCa+3QI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZxR1oykFBYugm6NUTCWoiiPIDXX0lcRfZWaGyDG79ma6bsqP5ocbuXdg//WFjGIQiRp/MNiUQGOdKUBt6mpeoPW8iOoSXknWJcBRCEriHRAUwNOs5mk1enVmFx9y6KYPubuSwfEi3/JEHrDuVHqDqJjP59GZnjxDFKiHntymtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0snY1EF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706840462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/AFNq394fKdD6rutt1qh+bLin+C/DGw45kLcKx0YqTM=;
	b=Y0snY1EFrVIIZtWusiS6DVRH33NwRD2bCxPn3CaL1q1oHyQjqAHr1s12c3CmpX0ONhww+M
	f+Y00dUhTs2l+u5zm9h10xyG/jKhbTAvqE85kpsX5J2bBw+VqGNKDxDcF/rQYQSyjsQeOR
	mOoC0/oThI2etkHZJUg+wY2O3KezYFk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-aBo1uFCGPYOOyb7-_Gf_gw-1; Thu,
 01 Feb 2024 21:20:58 -0500
X-MC-Unique: aBo1uFCGPYOOyb7-_Gf_gw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 975C729AC00A;
	Fri,  2 Feb 2024 02:20:57 +0000 (UTC)
Received: from localhost (unknown [10.72.116.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ABCD01121306;
	Fri,  2 Feb 2024 02:20:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Rafael Aquini <raquini@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH] mm/madvise: set ra_pages as device max request size during ADV_POPULATE_READ
Date: Fri,  2 Feb 2024 10:20:29 +0800
Message-ID: <20240202022029.1903629-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

madvise(MADV_POPULATE_READ) tries to populate all page tables in the
specific range, so it is usually sequential IO if VMA is backed by
file.

Set ra_pages as device max request size for the involved readahead in
the ADV_POPULATE_READ, this way reduces latency of madvise(MADV_POPULATE_READ)
to 1/10 when running madvise(MADV_POPULATE_READ) over one 1GB file with
usual(default) 128KB of read_ahead_kb.

Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Don Dutile <ddutile@redhat.com>
Cc: Rafael Aquini <raquini@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 mm/madvise.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 912155a94ed5..db5452c8abdd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -900,6 +900,37 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 		return -EINVAL;
 }
 
+static void madvise_restore_ra_win(struct file **file, unsigned int ra_pages)
+{
+	if (*file) {
+		struct file *f = *file;
+
+		f->f_ra.ra_pages = ra_pages;
+		fput(f);
+		*file = NULL;
+	}
+}
+
+static struct file *madvise_override_ra_win(struct file *f,
+		unsigned long start, unsigned long end,
+		unsigned int *old_ra_pages)
+{
+	unsigned int io_pages;
+
+	if (!f || !f->f_mapping || !f->f_mapping->host)
+		return NULL;
+
+	io_pages = inode_to_bdi(f->f_mapping->host)->io_pages;
+	if (((end - start) >> PAGE_SHIFT) < io_pages)
+		return NULL;
+
+	f = get_file(f);
+	*old_ra_pages = f->f_ra.ra_pages;
+	f->f_ra.ra_pages = io_pages;
+
+	return f;
+}
+
 static long madvise_populate(struct vm_area_struct *vma,
 			     struct vm_area_struct **prev,
 			     unsigned long start, unsigned long end,
@@ -908,9 +939,21 @@ static long madvise_populate(struct vm_area_struct *vma,
 	const bool write = behavior == MADV_POPULATE_WRITE;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long tmp_end;
+	unsigned int ra_pages;
+	struct file *file;
 	int locked = 1;
 	long pages;
 
+	/*
+	 * In case of file backing mapping, increase readahead window
+	 * for reducing the whole populate latency, and restore it
+	 * after the populate is done
+	 */
+	if (behavior == MADV_POPULATE_READ)
+		file = madvise_override_ra_win(vma->vm_file, start, end,
+				&ra_pages);
+	else
+		file = NULL;
 	*prev = vma;
 
 	while (start < end) {
@@ -920,8 +963,10 @@ static long madvise_populate(struct vm_area_struct *vma,
 		 */
 		if (!vma || start >= vma->vm_end) {
 			vma = vma_lookup(mm, start);
-			if (!vma)
+			if (!vma) {
+				madvise_restore_ra_win(&file, ra_pages);
 				return -ENOMEM;
+			}
 		}
 
 		tmp_end = min_t(unsigned long, end, vma->vm_end);
@@ -935,6 +980,9 @@ static long madvise_populate(struct vm_area_struct *vma,
 			vma = NULL;
 		}
 		if (pages < 0) {
+			/* restore ra pages back in case of any failure */
+			madvise_restore_ra_win(&file, ra_pages);
+
 			switch (pages) {
 			case -EINTR:
 				return -EINTR;
@@ -954,6 +1002,8 @@ static long madvise_populate(struct vm_area_struct *vma,
 		}
 		start += pages * PAGE_SIZE;
 	}
+
+	madvise_restore_ra_win(&file, ra_pages);
 	return 0;
 }
 
-- 
2.41.0


