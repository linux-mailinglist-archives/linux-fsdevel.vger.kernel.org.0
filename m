Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377517941D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242504AbjIFRH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjIFRH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:07:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52F313E;
        Wed,  6 Sep 2023 10:07:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7ECC433C8;
        Wed,  6 Sep 2023 17:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694020045;
        bh=ZxQkFTwDYKxzh9YCfck5Vjc6iuQ1cgWZBvGEsAL/bDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=enVW8UqEXJToj43GdFwEXyHRhQrkgMZq4vCj7yKYyXixdh80TgZyFIrxHLjkL5IGb
         VpKQnNom1y4JM1Zn/h/22TRB0m3coCwW8QLb9HcZv7pMaQ7OVqytWjem/0yNw2Jw5l
         MQ+PdvchQMadY9phxCJ8bZ+VXJlk1WV4jhzHZD2ysCZ6cUXkWKSr8ZFFyrUmoHWPS4
         yoPoqlOZcpmf4FiFESMncVMZnK7AO0p9bKXFB46fFXaEX+/ZUn0hADM5ckrPK12Us6
         mghukN8lN+X0fuDabbryarXoSA3bNAHGFieuwuB62GPrPd+nDxUF3nWi0jTnc1vZbA
         WYOrQqdxmcXnA==
Date:   Wed, 6 Sep 2023 10:07:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add inode lockdep assertions
Message-ID: <20230906170724.GI28202@frogsfrogsfrogs>
References: <20230831151414.2714750-1-mjguzik@gmail.com>
 <ZPiYp+t6JTUscc81@casper.infradead.org>
 <b0434328-01f9-dc5c-fe25-4a249130a81d@fastmail.fm>
 <20230906152948.GE28160@frogsfrogsfrogs>
 <ZPiiDj1T3lGp2w2c@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPiiDj1T3lGp2w2c@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:00:14PM +0100, Matthew Wilcox wrote:
> On Wed, Sep 06, 2023 at 08:29:48AM -0700, Darrick J. Wong wrote:
> > Or hoist the XFS mrlock, because it actually /does/ know if the rwsem is
> > held in shared or exclusive mode.
> 
> ... or to put it another way, if we had rwsem_is_write_locked(),
> we could get rid of mrlock?
> 
> diff --git a/fs/xfs/mrlock.h b/fs/xfs/mrlock.h
> index 79155eec341b..5530f03aaed1 100644
> --- a/fs/xfs/mrlock.h
> +++ b/fs/xfs/mrlock.h
> @@ -10,18 +10,10 @@
>  
>  typedef struct {
>  	struct rw_semaphore	mr_lock;
> -#if defined(DEBUG) || defined(XFS_WARN)
> -	int			mr_writer;
> -#endif
>  } mrlock_t;
>  
> -#if defined(DEBUG) || defined(XFS_WARN)
> -#define mrinit(mrp, name)	\
> -	do { (mrp)->mr_writer = 0; init_rwsem(&(mrp)->mr_lock); } while (0)
> -#else
>  #define mrinit(mrp, name)	\
>  	do { init_rwsem(&(mrp)->mr_lock); } while (0)
> -#endif
>  
>  #define mrlock_init(mrp, t,n,s)	mrinit(mrp, n)
>  #define mrfree(mrp)		do { } while (0)
> @@ -34,9 +26,6 @@ static inline void mraccess_nested(mrlock_t *mrp, int subclass)
>  static inline void mrupdate_nested(mrlock_t *mrp, int subclass)
>  {
>  	down_write_nested(&mrp->mr_lock, subclass);
> -#if defined(DEBUG) || defined(XFS_WARN)
> -	mrp->mr_writer = 1;
> -#endif
>  }
>  
>  static inline int mrtryaccess(mrlock_t *mrp)
> @@ -48,17 +37,11 @@ static inline int mrtryupdate(mrlock_t *mrp)
>  {
>  	if (!down_write_trylock(&mrp->mr_lock))
>  		return 0;
> -#if defined(DEBUG) || defined(XFS_WARN)
> -	mrp->mr_writer = 1;
> -#endif
>  	return 1;
>  }
>  
>  static inline void mrunlock_excl(mrlock_t *mrp)
>  {
> -#if defined(DEBUG) || defined(XFS_WARN)
> -	mrp->mr_writer = 0;
> -#endif
>  	up_write(&mrp->mr_lock);
>  }
>  
> @@ -69,9 +52,6 @@ static inline void mrunlock_shared(mrlock_t *mrp)
>  
>  static inline void mrdemote(mrlock_t *mrp)
>  {
> -#if defined(DEBUG) || defined(XFS_WARN)
> -	mrp->mr_writer = 0;
> -#endif
>  	downgrade_write(&mrp->mr_lock);
>  }
>  
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 9e62cc500140..b99c3bd78c5e 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -361,7 +361,7 @@ xfs_isilocked(
>  {
>  	if (lock_flags & (XFS_ILOCK_EXCL|XFS_ILOCK_SHARED)) {
>  		if (!(lock_flags & XFS_ILOCK_SHARED))
> -			return !!ip->i_lock.mr_writer;
> +			return rwsem_is_write_locked(&ip->i_lock.mr_lock);

You'd be better off converting this to:

	return __xfs_rwsem_islocked(&ip->i_lock.mr_lock,
				(lock_flags & XFS_ILOCK_SHARED));

And then fixing __xfs_rwsem_islocked to do:

static inline bool
__xfs_rwsem_islocked(
	struct rw_semaphore	*rwsem,
	bool			shared)
{
	if (!debug_locks) {
		if (!shared)
			return rwsem_is_write_locked(rwsem);
		return rwsem_is_locked(rwsem);
	}

	...
}

(and then getting rid of mrlock_t.h entirely)

>  		return rwsem_is_locked(&ip->i_lock.mr_lock);
>  	}
>  
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index e05e167dbd16..277b8c96bbf9 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -69,7 +69,7 @@ static inline void mmap_assert_locked(struct mm_struct *mm)
>  static inline void mmap_assert_write_locked(struct mm_struct *mm)
>  {
>  	lockdep_assert_held_write(&mm->mmap_lock);
> -	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> +	VM_BUG_ON_MM(!rwsem_is_write_locked(&mm->mmap_lock), mm);
>  }
>  
>  #ifdef CONFIG_PER_VMA_LOCK
> diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
> index 1d264dd08625..3c25b14edc05 100644
> --- a/include/linux/rwbase_rt.h
> +++ b/include/linux/rwbase_rt.h
> @@ -31,6 +31,11 @@ static __always_inline bool rw_base_is_locked(struct rwbase_rt *rwb)
>  	return atomic_read(&rwb->readers) != READER_BIAS;
>  }
>  
> +static __always_inline bool rw_base_is_write_locked(struct rwbase_rt *rwb)
> +{
> +	return atomic_read(&rwb->readers) == WRITER_BIAS;
> +}
> +
>  static __always_inline bool rw_base_is_contended(struct rwbase_rt *rwb)
>  {
>  	return atomic_read(&rwb->readers) > 0;
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index 1dd530ce8b45..241a12c6019e 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -72,6 +72,11 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
>  	return atomic_long_read(&sem->count) != 0;
>  }
>  
> +static inline int rwsem_is_write_locked(struct rw_semaphore *sem)
> +{
> +	return atomic_long_read(&sem->count) & 1;


atomic_long_read(&sem->count) & RWSEM_WRITER_LOCKED ?

In one of the past "replace mrlock_t" threads I complained about
hardcoding this value instead of using the symbol.  I saw it go by,
neglected to copy the url, and ten minutes later I can't find it. :(

--D

> +}
> +
>  #define RWSEM_UNLOCKED_VALUE		0L
>  #define __RWSEM_COUNT_INIT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
>  
> @@ -157,6 +162,11 @@ static __always_inline int rwsem_is_locked(struct rw_semaphore *sem)
>  	return rw_base_is_locked(&sem->rwbase);
>  }
>  
> +static __always_inline int rwsem_is_write_locked(struct rw_semaphore *sem)
> +{
> +	return rw_base_is_write_locked(&sem->rwbase);
> +}
> +
>  static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
>  {
>  	return rw_base_is_contended(&sem->rwbase);
