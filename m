Return-Path: <linux-fsdevel+bounces-22965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C148924433
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 19:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DDA1F21DD4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A181BE23D;
	Tue,  2 Jul 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7OwGm9I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E101BE235
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940048; cv=none; b=OytYRDEdHnnRs6/wqC99DS/NxGu6RIml69rSMibQXTHQeYiKau121Pfc0xS9b5ypFB+uiRPS7Erh369T3uwnJXDNICS7lb+Zp4fluW6dTpNYJgAR2qQwXQVar1yBDZIdxg+2ECQW8sC+Gt2J0ZC58hw+IfOx038nqJBwh057sac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940048; c=relaxed/simple;
	bh=N4gDA5S7lJAbOfeUMimoJ9SkSKSwizRZZeNxzmNAWmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JLfxAkd2M5BgvcpujL09BV+loffAgWzYcxmFu1XfnZwhqOLu684p5DHB9GnSQbpASWsshTmN8fnGvZCfe+9qdvDHvFW/Rd4amszM8s24em5cNxc7Ewu0ue/9f47pmuqpwH32/0zl8chGI6i5zisI14cFdfj/XU7SOa2NkikbMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7OwGm9I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719940045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W2w6d6BZT5CE4wYHUMrSEJ6v69CXoZLQTv1iZaggPa0=;
	b=N7OwGm9IU68xVs+aIizPrTONhZKLGgP9dvAewILaGd2PIoVHX3XqaLyq8qpaDcS/2Ypbje
	zLoWddnT0vxEqY34pYus5gJ/dBakS25+dBaNHxDc9yRFz22DrFDxJ8FDIlAeIEPyyoaToS
	xZXjV0VNkhsRhlJKEjlW1bUJ/pHG62s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-583Dd_QzOzioYo83tSd_Pg-1; Tue,
 02 Jul 2024 13:07:22 -0400
X-MC-Unique: 583Dd_QzOzioYo83tSd_Pg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AFA71955DA1
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 17:07:21 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 695A819560AA;
	Tue,  2 Jul 2024 17:07:20 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Ian Kent <ikent@redhat.com>
Subject: [PATCH] vfs: don't mod negative dentry count when on shrinker list
Date: Tue,  2 Jul 2024 13:07:57 -0400
Message-ID: <20240702170757.232130-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The nr_dentry_negative counter is intended to only account negative
dentries that are present on the superblock LRU. Therefore, the LRU
add, remove and isolate helpers modify the counter based on whether
the dentry is negative, but the shrinker list related helpers do not
modify the counter, and the paths that change a dentry between
positive and negative only do so if DCACHE_LRU_LIST is set.

The problem with this is that a dentry on a shrinker list still has
DCACHE_LRU_LIST set to indicate ->d_lru is in use. The additional
DCACHE_SHRINK_LIST flag denotes whether the dentry is on LRU or a
shrink related list. Therefore if a relevant operation (i.e. unlink)
occurs while a dentry is present on a shrinker list, and the
associated codepath only checks for DCACHE_LRU_LIST, then it is
technically possible to modify the negative dentry count for a
dentry that is off the LRU. Since the shrinker list related helpers
do not modify the negative dentry count (because non-LRU dentries
should not be included in the count) when the dentry is ultimately
removed from the shrinker list, this can cause the negative dentry
count to become permanently inaccurate.

This problem can be reproduced via a heavy file create/unlink vs.
drop_caches workload. On an 80xcpu system, I start 80 tasks each
running a 1k file create/delete loop, and one task spinning on
drop_caches. After 10 minutes or so of runtime, the idle/clean cache
negative dentry count increases from somewhere in the range of 5-10
entries to several hundred (and increasingly grows beyond
nr_dentry_unused).

Tweak the logic in the paths that turn a dentry negative or positive
to filter out the case where the dentry is present on a shrink
related list. This allows the above workload to maintain an accurate
negative dentry count.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/dcache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 407095188f83..5305b95b3030 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -355,7 +355,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 	flags &= ~DCACHE_ENTRY_TYPE;
 	WRITE_ONCE(dentry->d_flags, flags);
 	dentry->d_inode = NULL;
-	if (flags & DCACHE_LRU_LIST)
+	if ((flags & (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
 		this_cpu_inc(nr_dentry_negative);
 }
 
@@ -1846,7 +1846,8 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 	/*
 	 * Decrement negative dentry count if it was in the LRU list.
 	 */
-	if (dentry->d_flags & DCACHE_LRU_LIST)
+	if ((dentry->d_flags &
+	     (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
 		this_cpu_dec(nr_dentry_negative);
 	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
 	raw_write_seqcount_begin(&dentry->d_seq);
-- 
2.45.0


