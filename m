Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D40F36018D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 07:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhDOFXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 01:23:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229503AbhDOFXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:23:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13F53rqY017029;
        Thu, 15 Apr 2021 01:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=0vL+SibpJZmJKZgwclAmBc+Aze2bFJYtbWw6ho9z928=;
 b=maU88t2K+SGqVa80jXuCdBcZQDBL5Hza8Sof/crQZkKCVuJBUUP4LuCJxYyc1yo0uZ9O
 oXc3EfTJOUpVv8IKSYHUPi+CxLFMEAL6eoVN964vYNJbFhMzML3fREI+ZYX1eONZlWKK
 p2ErVjoBHGkoPln6jil61EVFcQnCCkkSdXJqazU/qbDYUtADJTx/ZHS1PhbtghT/kiiN
 bUGyAR2Rzptpggx28iCekJu+qMzK+O2Mhn9l7WBVAdzLsH+cPI2Y0OW9MN/YAB9tUeIj
 TmjM3zGkPF8fqheakQ963l3mm/nj9w9bD8UfiWCdUoekmMbnsDX/ZQ8uK7oJl2ni7Dqn ZA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37x46xeuf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 01:23:08 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13F5MmXC008898;
        Thu, 15 Apr 2021 05:23:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 37u3n8unq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 05:23:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13F5N4V534603470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 05:23:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F3EEA405B;
        Thu, 15 Apr 2021 05:23:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8A66A4054;
        Thu, 15 Apr 2021 05:23:02 +0000 (GMT)
Received: from in.ibm.com (unknown [9.77.201.251])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 15 Apr 2021 05:23:02 +0000 (GMT)
Date:   Thu, 15 Apr 2021 10:53:00 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <20210415052300.GA1662898@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20210405054848.GA1077931@in.ibm.com>
 <20210406222807.GD1990290@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406222807.GD1990290@dread.disaster.area>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sQ40t9LBvydUq8wKOEBfTpBqMTdpwFQs
X-Proofpoint-ORIG-GUID: sQ40t9LBvydUq8wKOEBfTpBqMTdpwFQs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_02:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150034
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 08:28:07AM +1000, Dave Chinner wrote:
> 
> Another approach may be to identify filesystem types that do not
> need memcg awareness and feed that into alloc_super() to set/clear
> the SHRINKER_MEMCG_AWARE flag. This could be based on fstype - most
> virtual filesystems that expose system information do not really
> need full memcg awareness because they are generally only visible to
> a single memcg instance...

Would something like below be appropriate?

From f314083ad69fde2a420a1b74febd6d3f7a25085f Mon Sep 17 00:00:00 2001
From: Bharata B Rao <bharata@linux.ibm.com>
Date: Wed, 14 Apr 2021 11:21:24 +0530
Subject: [PATCH 1/1] fs: Let filesystems opt out of memcg awareness

All filesystem mounts by default are memcg aware and end hence
end up creating shrinker list_lrus for all the memcgs. Due to
the way the memcg_nr_cache_ids grow and the list_lru heads are
allocated for all memcgs, huge amount of memory gets consumed
by kmalloc-32 slab cache when running thousands of containers.

Improve this situation by allowing filesystems to opt out
of memcg awareness. In this patch, tmpfs, proc and ramfs
opt out of memcg awareness. This leads to considerable memory
savings when running 10k containers.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 fs/proc/root.c             |  1 +
 fs/ramfs/inode.c           |  1 +
 fs/super.c                 | 27 +++++++++++++++++++--------
 include/linux/fs_context.h |  2 ++
 mm/shmem.c                 |  1 +
 5 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index c7e3b1350ef8..7856bc2ca9f4 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -257,6 +257,7 @@ static int proc_init_fs_context(struct fs_context *fc)
 	fc->user_ns = get_user_ns(ctx->pid_ns->user_ns);
 	fc->fs_private = ctx;
 	fc->ops = &proc_fs_context_ops;
+	fc->memcg_optout = true;
 	return 0;
 }
 
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 9ebd17d7befb..576a88bb7407 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -278,6 +278,7 @@ int ramfs_init_fs_context(struct fs_context *fc)
 	fsi->mount_opts.mode = RAMFS_DEFAULT_MODE;
 	fc->s_fs_info = fsi;
 	fc->ops = &ramfs_context_ops;
+	fc->memcg_optout = true;
 	return 0;
 }
 
diff --git a/fs/super.c b/fs/super.c
index 8c1baca35c16..59aa22c678e6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -198,7 +198,8 @@ static void destroy_unused_super(struct super_block *s)
  *	returns a pointer new superblock or %NULL if allocation had failed.
  */
 static struct super_block *alloc_super(struct file_system_type *type, int flags,
-				       struct user_namespace *user_ns)
+				       struct user_namespace *user_ns,
+				       bool memcg_optout)
 {
 	struct super_block *s = kzalloc(sizeof(struct super_block),  GFP_USER);
 	static const struct super_operations default_op;
@@ -266,13 +267,22 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.scan_objects = super_cache_scan;
 	s->s_shrink.count_objects = super_cache_count;
 	s->s_shrink.batch = 1024;
-	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
+	s->s_shrink.flags = SHRINKER_NUMA_AWARE;
+	if (!memcg_optout)
+		s->s_shrink.flags |= SHRINKER_MEMCG_AWARE;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
-	if (list_lru_init_memcg(&s->s_dentry_lru, &s->s_shrink))
-		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru, &s->s_shrink))
-		goto fail;
+	if (memcg_optout) {
+		if (list_lru_init(&s->s_dentry_lru))
+			goto fail;
+		if (list_lru_init(&s->s_inode_lru))
+			goto fail;
+	} else {
+		if (list_lru_init_memcg(&s->s_dentry_lru, &s->s_shrink))
+			goto fail;
+		if (list_lru_init_memcg(&s->s_inode_lru, &s->s_shrink))
+			goto fail;
+	}
 	return s;
 
 fail:
@@ -527,7 +537,8 @@ struct super_block *sget_fc(struct fs_context *fc,
 	}
 	if (!s) {
 		spin_unlock(&sb_lock);
-		s = alloc_super(fc->fs_type, fc->sb_flags, user_ns);
+		s = alloc_super(fc->fs_type, fc->sb_flags, user_ns,
+				fc->memcg_optout);
 		if (!s)
 			return ERR_PTR(-ENOMEM);
 		goto retry;
@@ -610,7 +621,7 @@ struct super_block *sget(struct file_system_type *type,
 	}
 	if (!s) {
 		spin_unlock(&sb_lock);
-		s = alloc_super(type, (flags & ~SB_SUBMOUNT), user_ns);
+		s = alloc_super(type, (flags & ~SB_SUBMOUNT), user_ns, false);
 		if (!s)
 			return ERR_PTR(-ENOMEM);
 		goto retry;
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 37e1e8f7f08d..73388c0b6950 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -110,6 +110,8 @@ struct fs_context {
 	bool			need_free:1;	/* Need to call ops->free() */
 	bool			global:1;	/* Goes into &init_user_ns */
 	bool			oldapi:1;	/* Coming from mount(2) */
+	bool			memcg_optout:1;	/* Opt out from per-memcg
+						   lru handling */
 };
 
 struct fs_context_operations {
diff --git a/mm/shmem.c b/mm/shmem.c
index b2db4ed0fbc7..0c9b2af52825 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3915,6 +3915,7 @@ int shmem_init_fs_context(struct fs_context *fc)
 
 	fc->fs_private = ctx;
 	fc->ops = &shmem_fs_context_ops;
+	fc->memcg_optout = true;
 	return 0;
 }
 
-- 
2.26.2

