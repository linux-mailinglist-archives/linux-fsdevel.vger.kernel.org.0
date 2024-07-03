Return-Path: <linux-fsdevel+bounces-23027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5B6925FE7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F0D1F22116
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE09B1741C9;
	Wed,  3 Jul 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NASVm//7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759945945
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008753; cv=none; b=Q07syOjxH3htfd/A+KRuIJbaxmxJpUjeIrr53wA7hvNetGb0NA5Fjy+RQQKVHYqzcjDA1AFLIIZ/7gtJ0RWmkPyWHHsjonR+xSppQWmAgvC5VFtt70qM3xkMSgVMZ9QTgI4bYce709U3yWufzt49bcb5CnfF5w4T6/D6HLwRAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008753; c=relaxed/simple;
	bh=DZgnaIy7cUxQwKs/5V2hku3rIdh3sr6S7CyXb8832Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p/tu/gCqwlMqnBM2zd1ZeR4Ej3ANNc2wQpgHuEd2T2WCUsm5TWBt4wl0PyDv3Z8qWxe7Gi3hibkdB0q+0Jtv0mGkSZwaImPNXmnp4dkv7IiVdjaueED9n0OG5oeJuJ4VSpigKhQvsbSIPZuHTZEyLJvo4uIjv+t9wgLxGbWN8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NASVm//7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720008750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=91bCK4xrEip3tl/cnDdHUNhb4cs6T1c27ja4DKvTcm0=;
	b=NASVm//7GMg0nEYAWiyzqlJoreOO624vnO939C7PEwmCRf5U3sQdSa6r6WGv86cQ+4uoIr
	97Ty5ym4OETV+f4sq5rERS//XUmu0+2v7Ff3CAiOU7TKwRQmdAcRwzX0V7S6gxLYtPXCQx
	RWiIht8EVkUgdqzP0/cTquxnxgSlgRQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-Ayrdo2HRNPy38TPo3mXgXA-1; Wed,
 03 Jul 2024 08:12:27 -0400
X-MC-Unique: Ayrdo2HRNPy38TPo3mXgXA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83F921955BC7;
	Wed,  3 Jul 2024 12:12:26 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.117])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 098C2195607C;
	Wed,  3 Jul 2024 12:12:24 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Ian Kent <ikent@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] vfs: don't mod negative dentry count when on shrinker list
Date: Wed,  3 Jul 2024 08:13:01 -0400
Message-ID: <20240703121301.247680-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

Fixes: af0c9af1b3f6 ("fs/dcache: Track & report number of negative dentries")
Signed-off-by: Brian Foster <bfoster@redhat.com>
Acked-by: Ian Kent <ikent@redhat.com>
---

Hi Christian,

I see you already picked up v1. Josef had asked for some comment updates
so I'm posting v2 with that, but TBH I'm not sure how useful this all is
once one groks the flags. I have no strong opinion on it. I also added a
Fixes: tag for the patch that added the counter.

In short, feel free to grab this one, ignore this and stick with v1, or
maybe just pull in the Fixes: tag if you agree with it. Thanks.

Brian

v2:
- Update comments (Josef).
- Add Fixes: tag, cc Waiman.
v1: https://lore.kernel.org/linux-fsdevel/20240702170757.232130-1-bfoster@redhat.com/

 fs/dcache.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 407095188f83..66515fbc9dd7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -355,7 +355,11 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 	flags &= ~DCACHE_ENTRY_TYPE;
 	WRITE_ONCE(dentry->d_flags, flags);
 	dentry->d_inode = NULL;
-	if (flags & DCACHE_LRU_LIST)
+	/*
+	 * The negative counter only tracks dentries on the LRU. Don't inc if
+	 * d_lru is on another list.
+	 */
+	if ((flags & (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
 		this_cpu_inc(nr_dentry_negative);
 }
 
@@ -1844,9 +1848,11 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 
 	spin_lock(&dentry->d_lock);
 	/*
-	 * Decrement negative dentry count if it was in the LRU list.
+	 * The negative counter only tracks dentries on the LRU. Don't dec if
+	 * d_lru is on another list.
 	 */
-	if (dentry->d_flags & DCACHE_LRU_LIST)
+	if ((dentry->d_flags &
+	     (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
 		this_cpu_dec(nr_dentry_negative);
 	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
 	raw_write_seqcount_begin(&dentry->d_seq);
-- 
2.45.0


