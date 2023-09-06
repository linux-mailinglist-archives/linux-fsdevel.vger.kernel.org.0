Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925DC7940EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 18:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242776AbjIFQAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjIFQAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:00:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A448C10C7;
        Wed,  6 Sep 2023 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wULmRmq8zqsq9QEw4gO9ALx+r5MDTJv63sKLK0NPRpk=; b=G0ylW018z0hwlQi2l7u2D2Uzuz
        e/C5ssu8iJkwq2lGOaChawgSNxRF5uk8LwcNvY/a9PM0GRHWtOdk1wmC3bwB0rjVroLLT+iifMZhH
        +CTLGlkVE7IY6A20JDx/8XIp3VBnouC/2EzNxtkfyJEVNEf5J9JZtC5C9q+ocph6tdD3SoFym7enb
        H1A9AIfqcVtR5dSU5R0jyNWJTUh3bh9wvIATQpmRQbEHHPPq70JvfrmZrTzwGtPi0fRvS8SC0hfa0
        noWlguU5/LKezX+NdIxavKwmupSli5WGPFcJIkTUIP3vTEs7/Irveh6sB721Mu7utTqvrW+ZjpAVx
        QYax3zMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qduww-003djT-KZ; Wed, 06 Sep 2023 16:00:14 +0000
Date:   Wed, 6 Sep 2023 17:00:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add inode lockdep assertions
Message-ID: <ZPiiDj1T3lGp2w2c@casper.infradead.org>
References: <20230831151414.2714750-1-mjguzik@gmail.com>
 <ZPiYp+t6JTUscc81@casper.infradead.org>
 <b0434328-01f9-dc5c-fe25-4a249130a81d@fastmail.fm>
 <20230906152948.GE28160@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906152948.GE28160@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 08:29:48AM -0700, Darrick J. Wong wrote:
> Or hoist the XFS mrlock, because it actually /does/ know if the rwsem is
> held in shared or exclusive mode.

... or to put it another way, if we had rwsem_is_write_locked(),
we could get rid of mrlock?

diff --git a/fs/xfs/mrlock.h b/fs/xfs/mrlock.h
index 79155eec341b..5530f03aaed1 100644
--- a/fs/xfs/mrlock.h
+++ b/fs/xfs/mrlock.h
@@ -10,18 +10,10 @@
 
 typedef struct {
 	struct rw_semaphore	mr_lock;
-#if defined(DEBUG) || defined(XFS_WARN)
-	int			mr_writer;
-#endif
 } mrlock_t;
 
-#if defined(DEBUG) || defined(XFS_WARN)
-#define mrinit(mrp, name)	\
-	do { (mrp)->mr_writer = 0; init_rwsem(&(mrp)->mr_lock); } while (0)
-#else
 #define mrinit(mrp, name)	\
 	do { init_rwsem(&(mrp)->mr_lock); } while (0)
-#endif
 
 #define mrlock_init(mrp, t,n,s)	mrinit(mrp, n)
 #define mrfree(mrp)		do { } while (0)
@@ -34,9 +26,6 @@ static inline void mraccess_nested(mrlock_t *mrp, int subclass)
 static inline void mrupdate_nested(mrlock_t *mrp, int subclass)
 {
 	down_write_nested(&mrp->mr_lock, subclass);
-#if defined(DEBUG) || defined(XFS_WARN)
-	mrp->mr_writer = 1;
-#endif
 }
 
 static inline int mrtryaccess(mrlock_t *mrp)
@@ -48,17 +37,11 @@ static inline int mrtryupdate(mrlock_t *mrp)
 {
 	if (!down_write_trylock(&mrp->mr_lock))
 		return 0;
-#if defined(DEBUG) || defined(XFS_WARN)
-	mrp->mr_writer = 1;
-#endif
 	return 1;
 }
 
 static inline void mrunlock_excl(mrlock_t *mrp)
 {
-#if defined(DEBUG) || defined(XFS_WARN)
-	mrp->mr_writer = 0;
-#endif
 	up_write(&mrp->mr_lock);
 }
 
@@ -69,9 +52,6 @@ static inline void mrunlock_shared(mrlock_t *mrp)
 
 static inline void mrdemote(mrlock_t *mrp)
 {
-#if defined(DEBUG) || defined(XFS_WARN)
-	mrp->mr_writer = 0;
-#endif
 	downgrade_write(&mrp->mr_lock);
 }
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 9e62cc500140..b99c3bd78c5e 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -361,7 +361,7 @@ xfs_isilocked(
 {
 	if (lock_flags & (XFS_ILOCK_EXCL|XFS_ILOCK_SHARED)) {
 		if (!(lock_flags & XFS_ILOCK_SHARED))
-			return !!ip->i_lock.mr_writer;
+			return rwsem_is_write_locked(&ip->i_lock.mr_lock);
 		return rwsem_is_locked(&ip->i_lock.mr_lock);
 	}
 
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index e05e167dbd16..277b8c96bbf9 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -69,7 +69,7 @@ static inline void mmap_assert_locked(struct mm_struct *mm)
 static inline void mmap_assert_write_locked(struct mm_struct *mm)
 {
 	lockdep_assert_held_write(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+	VM_BUG_ON_MM(!rwsem_is_write_locked(&mm->mmap_lock), mm);
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
index 1d264dd08625..3c25b14edc05 100644
--- a/include/linux/rwbase_rt.h
+++ b/include/linux/rwbase_rt.h
@@ -31,6 +31,11 @@ static __always_inline bool rw_base_is_locked(struct rwbase_rt *rwb)
 	return atomic_read(&rwb->readers) != READER_BIAS;
 }
 
+static __always_inline bool rw_base_is_write_locked(struct rwbase_rt *rwb)
+{
+	return atomic_read(&rwb->readers) == WRITER_BIAS;
+}
+
 static __always_inline bool rw_base_is_contended(struct rwbase_rt *rwb)
 {
 	return atomic_read(&rwb->readers) > 0;
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 1dd530ce8b45..241a12c6019e 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -72,6 +72,11 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 	return atomic_long_read(&sem->count) != 0;
 }
 
+static inline int rwsem_is_write_locked(struct rw_semaphore *sem)
+{
+	return atomic_long_read(&sem->count) & 1;
+}
+
 #define RWSEM_UNLOCKED_VALUE		0L
 #define __RWSEM_COUNT_INIT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
 
@@ -157,6 +162,11 @@ static __always_inline int rwsem_is_locked(struct rw_semaphore *sem)
 	return rw_base_is_locked(&sem->rwbase);
 }
 
+static __always_inline int rwsem_is_write_locked(struct rw_semaphore *sem)
+{
+	return rw_base_is_write_locked(&sem->rwbase);
+}
+
 static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
 {
 	return rw_base_is_contended(&sem->rwbase);
