Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E13224900
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 07:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgGRF2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jul 2020 01:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgGRF2V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jul 2020 01:28:21 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DBD32076D;
        Sat, 18 Jul 2020 05:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595050100;
        bh=Ds3fuyOV55VNCggBZsBZ6Gtip6GmnLGthOi3hrq38W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWy3ORf3Uh0I5j4NnggS2AkgRZ4tyA7THNkwY5CZRK514dWiYuDFMI0ipdOgeJxZK
         +4Kh1jgQ2nTDtCz28+NHzSIz+PsqmVkWOQseo2CTg8tX3NO7mcfPDVsgeAn+/4gmVD
         thAlpqsttQFdXCujMVxetrk4+AGR9d6ZKYKm4AgI=
Date:   Fri, 17 Jul 2020 22:28:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200718052818.GF2183@sol.localdomain>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200718013839.GD2183@sol.localdomain>
 <20200718021304.GS12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718021304.GS12769@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 18, 2020 at 03:13:04AM +0100, Matthew Wilcox wrote:
> On Fri, Jul 17, 2020 at 06:38:39PM -0700, Eric Biggers wrote:
> > On Fri, Jul 17, 2020 at 06:47:50PM +0100, Matthew Wilcox wrote:
> > > On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
> > > > +If that doesn't apply, you'll have to implement one-time init yourself.
> > > > +
> > > > +The simplest implementation just uses a mutex and an 'inited' flag.
> > > > +This implementation should be used where feasible:
> > > 
> > > I think some syntactic sugar should make it feasible for normal people
> > > to implement the most efficient version of this just like they use locks.
> > 
> > Note that the cmpxchg version is not necessarily the "most efficient".
> > 
> > If the one-time initialization is expensive, e.g. if it allocates a lot of
> > memory or if takes a long time, it could be better to use the mutex version so
> > that at most one task does it.
> 
> Sure, but I think those are far less common than just allocating a single
> thing.
> 
> > > How about something like this ...
> > > 
> > > once.h:
> > > 
> > > static struct init_once_pointer {
> > > 	void *p;
> > > };
> > > 
> > > static inline void *once_get(struct init_once_pointer *oncep)
> > > { ... }
> > > 
> > > static inline bool once_store(struct init_once_pointer *oncep, void *p)
> > > { ... }
> > > 
> > > --- foo.c ---
> > > 
> > > struct foo *get_foo(gfp_t gfp)
> > > {
> > > 	static struct init_once_pointer my_foo;
> > > 	struct foo *foop;
> > > 
> > > 	foop = once_get(&my_foo);
> > > 	if (foop)
> > > 		return foop;
> > > 
> > > 	foop = alloc_foo(gfp);
> > > 	if (!once_store(&my_foo, foop)) {
> > > 		free_foo(foop);
> > > 		foop = once_get(&my_foo);
> > > 	}
> > > 
> > > 	return foop;
> > > }
> > > 
> > > Any kernel programmer should be able to handle that pattern.  And no mutex!
> > 
> > I don't think this version would be worthwhile.  It eliminates type safety due
> > to the use of 'void *', and doesn't actually save any lines of code.  Nor does
> > it eliminate the need to correctly implement the cmpxchg failure case, which is
> > tricky (it must free the object and get the new one) and will be rarely tested.
> 
> You're missing the point.  It prevents people from trying to optimise
> "can I use READ_ONCE() here, or do I need to use smp_rmb()?"  The type
> safety is provided by the get_foo() function.  I suppose somebody could
> play some games with _Generic or something, but there's really no need to.
> It's like using a list_head and casting to the container_of.
> 
> > It also forces all users of the struct to use this helper function to access it.
> > That could be considered a good thing, but it's also bad because even with
> > one-time init there's still usually some sort of ordering of "initialization"
> > vs. "use".  Just taking a random example I'm familiar with, we do one-time init
> > of inode::i_crypt_info when we open an encrypted file, so we guarantee it's set
> > for all I/O to the file, where we then simply access ->i_crypt_info directly.
> > We don't want the code to read like it's initializing ->i_crypt_info in the
> > middle of ->writepages(), since that would be wrong.
> 
> Right, and I wouldn't use this pattern for that.  You can't get to
> writepages without having opened the file, so just initialising the
> pointer in open is fine.
> 
> > An improvement might be to make once_store() take the free function as a
> > parameter so that it would handle the failure case for you:
> > 
> > struct foo *get_foo(gfp_t gfp)
> > {
> > 	static struct init_once_pointer my_foo;
> > 	struct foo *foop;
> >  
> >  	foop = once_get(&my_foo);
> >  	if (!foop) {
> > 		foop = alloc_foo(gfp);
> > 		if (foop)
> > 			once_store(&my_foo, foop, free_foo);
> 
> Need to mark once_store as __must_check to avoid the bug you have here:
> 
> 			foop = once_store(&my_foo, foop, free_foo);
> 
> Maybe we could use a macro for once_store so we could write:
> 
> void *once_get(struct init_pointer_once *);
> int once_store(struct init_pointer_once *, void *);
> 
> #define once_alloc(s, o_alloc, o_free) ({                               \
>         void *__p = o_alloc;                                            \
>         if (__p) {                                                      \
>                 if (!once_store(s, __p)) {                              \
>                         o_free(__p);                                    \
>                         __p = once_get(s);                              \
>                 }                                                       \
>         }                                                               \
>         __p;                                                            \
> })
> 
> ---
> 
> struct foo *alloc_foo(gfp_t);
> void free_foo(struct foo *);
> 
> struct foo *get_foo(gfp_t gfp)
> {
>         static struct init_pointer_once my_foo;
>         struct foo *foop;
> 
>         foop = once_get(&my_foo);
>         if (!foop)
>                 foop = once_alloc(&my_foo, alloc_foo(gfp), free_foo);
>         return foop;
> }
> 
> That's pretty hard to misuse (I compile-tested it, and it works).

I'm still not sure this is the best API.

It's very much designed around the cmpxchg solution, which is clever and is more
efficient in some cases.  But it's not really a good default.

The cmpxchg solution isn't simply a different implementation of one-time-init,
but rather it changes the *behavior* so that the allocation/initialization can
happen multiple times concurrently.  So it's not really "once" anymore.

I think most people would find this unexpected, especially if they're used to
one-time-init in programming languages that support it natively (e.g., C++
static local variables, to use a random example...).

Concurrent attempts at the initialization can cause problems if it involves
allocating a lot of memory or other kernel resources, does CPU-intensive work,
calls out to user-mode helpers, calls non-thread-safe code, tries to register
things with duplicate names, etc.

It also means the user has provide a free() function, even in cases like static
data in non-modular code where free() would otherwise not be needed.

And since the concurrent allocation (and free()) case is unlikely to get tested,
users may not notice problems until too late.

Using 'struct init_once_pointer' is nice to prevent use of the pointer without
either initializing it or executing a memory barrier.  But most of the time
that's not what people want.  Usually code is structured such that the
initialization happens at one point, and then later accesses just want the plain
pointer.  And almost everyone will need to free() the struct at some point,
which again should just be a plain access.

So if we want any new macros to be usable as widely as possible, I think they'll
need to use use plain pointers.

It would also be nice to have the APIs/macros for the different cases (single
strucct, multiple structs, static data) be consistent and work similarly.

What do people think about the following instead?  (Not proofread / tested yet,
so please comment on the high-level approach, not minor mistakes :-) )

#define DO_ONCE_ATOMIC()
	/* renamed from current DO_ONCE() */

/**
 * DO_ONCE_BLOCKING() - call a function exactly once
 * @once_func: the function to call exactly once
 * @...: additional arguments to pass to @once_func (optional)
 *
 * Return: 0 on success (done or already done), or an error returned by
 *	   @once_func.
 */
#define DO_ONCE_BLOCKING(once_func, ...)				\
({									\
	static DEFINE_MUTEX(mutex);					\
 	static bool done;						\
 	int err = 0;							\
									\
	if (!smp_load_acquire(&done)) {					\
		mutex_lock(&mutex);					\
		if (!done) {						\
			err = once_func(__VA_ARGS__);			\
			if (!err)					\
				smp_store_release(&done, true);		\
		}							\
		mutex_unlock(&mutex);					\
	}								\
 	err;								\
})

/**
 * INIT_ONCE() - do one-time initialization
 * @done: pointer to a 'bool' flag that tracks whether initialization has been
 *	  done yet or not.  Must be false by default.
 * @mutex: pointer to a mutex to use to synchronize executions of @init_func
 * @init_func: the one-time initialization function
 * @...: additional arguments to pass to @init_func (optional)
 *
 * This is a more general version of DO_ONCE_BLOCKING() which supports
 * non-static data by allowing the user to specify their own 'done' flag and
 * mutex.
 *
 * Return: 0 on success (done or already done), or a negative errno value
 *	   returned by @init_func.
 */
#define INIT_ONCE(done, mutex, init_func, ...)				\
({									\
 	int err = 0;							\
									\
	if (!smp_load_acquire(done)) {					\
		mutex_lock(mutex);					\
		if (!*(done)) {						\
			err = init_func(__VA_ARGS__);			\
			if (!err)					\
				smp_store_release((done), true);	\
		}							\
		mutex_unlock(mutex);					\
	}								\
 	err;								\
})

/**
 * INIT_ONCE_PTR() - do one-time allocation of a data structure
 * @ptr: pointer to the data structure's pointer. Must be NULL by default.
 * @mutex: pointer to a mutex to use to synchronize executions of @alloc_func
 * @alloc_func: the allocation function
 * @...: additional arguments to pass to @alloc_func (optional)
 *
 * Like INIT_ONCE(), but eliminates the need for the 'done' flag by assuming a
 * single pointer is being initialized.
 *
 * Return: 0 on success (done or already done), or an error from @alloc_func.
 *         If @alloc_func returns an ERR_PTR(), PTR_ERR() will be returned.
 *         If @alloc_func returns NULL, -ENOMEM will be returned.
 */
#define INIT_ONCE_PTR(ptr, mutex, alloc_func, ...)			\
({									\
	int err = 0;							\
									\
	if (!smp_load_acquire(ptr)) {					\
		mutex_lock(mutex);					\
		if (!*(ptr)) {						\
			typeof (*(ptr)) p = alloc_func(__VA_ARGS__);	\
									\
			if (!IS_ERR_OR_NULL(p))				\
				smp_store_release((ptr), p);		\
			else						\
 				err = p ? PTR_ERR(p) : -ENOMEM;		\
		}							\
		mutex_unlock(mutex);					\
	}								\
 	err;								\
})


In the fs/direct-io.c case we'd use:

int sb_init_dio_done_wq(struct super_block *sb)
{
	static DEFINE_MUTEX(sb_init_dio_done_mutex);

	return INIT_ONCE_PTR(&sb->s_dio_done_wq, &sb_init_dio_done_mutex,
			     alloc_workqueue,
			     "dio/%s", WQ_MEM_RECLAIM, 0, sb->s_id);
}

The only part I really don't like is the way arguments are passed to the
alloc_func.  We could also make it work like the following, though it would
break the usual rules since it looks like the function call is always executed,
but it's not:

	return INIT_ONCE_PTR(&sb->s_dio_done_wq, &sb_init_dio_done_mutex,
			     alloc_workqueue("dio/%s", WQ_MEM_RECLAIM, 0,
					     sb->s_id));

And for static data, here are a couple quick examples of how I'd use
DO_ONCE_BLOCKING() in fs/crypto/:

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 9e82a8856aba..2661849c0a53 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -37,7 +37,6 @@ MODULE_PARM_DESC(num_prealloc_crypto_pages,
 static mempool_t *fscrypt_bounce_page_pool = NULL;
 
 static struct workqueue_struct *fscrypt_read_workqueue;
-static DEFINE_MUTEX(fscrypt_init_mutex);
 
 struct kmem_cache *fscrypt_info_cachep;
 
@@ -304,6 +303,15 @@ int fscrypt_decrypt_block_inplace(const struct inode *inode, struct page *page,
 }
 EXPORT_SYMBOL(fscrypt_decrypt_block_inplace);
 
+static int fscrypt_do_initialize(void)
+{
+	fscrypt_bounce_page_pool =
+		mempool_create_page_pool(num_prealloc_crypto_pages, 0);
+	if (!fscrypt_bounce_page_pool)
+		return -ENOMEM;
+	return 0;
+}
+
 /**
  * fscrypt_initialize() - allocate major buffers for fs encryption.
  * @cop_flags:  fscrypt operations flags
@@ -315,26 +323,11 @@ EXPORT_SYMBOL(fscrypt_decrypt_block_inplace);
  */
 int fscrypt_initialize(unsigned int cop_flags)
 {
-	int err = 0;
-
 	/* No need to allocate a bounce page pool if this FS won't use it. */
 	if (cop_flags & FS_CFLG_OWN_PAGES)
 		return 0;
 
-	mutex_lock(&fscrypt_init_mutex);
-	if (fscrypt_bounce_page_pool)
-		goto out_unlock;
-
-	err = -ENOMEM;
-	fscrypt_bounce_page_pool =
-		mempool_create_page_pool(num_prealloc_crypto_pages, 0);
-	if (!fscrypt_bounce_page_pool)
-		goto out_unlock;
-
-	err = 0;
-out_unlock:
-	mutex_unlock(&fscrypt_init_mutex);
-	return err;
+	return DO_ONCE_BLOCKING(fscrypt_do_initialize);
 }
 
 void fscrypt_msg(const struct inode *inode, const char *level,
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index d828e3df898b..2744a3daceb8 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -63,28 +63,22 @@ struct fscrypt_nokey_name {
 
 static struct crypto_shash *sha256_hash_tfm;
 
-static int fscrypt_do_sha256(const u8 *data, unsigned int data_len, u8 *result)
+static int fscrypt_init_sha256(void)
 {
-	struct crypto_shash *tfm = READ_ONCE(sha256_hash_tfm);
+	sha256_hash_tfm = crypto_alloc_shash("sha256", 0, 0);
+	return PTR_ERR_OR_ZERO(sha256_hash_tfm);
+}
 
-	if (unlikely(!tfm)) {
-		struct crypto_shash *prev_tfm;
+static int fscrypt_do_sha256(const u8 *data, unsigned int data_len, u8 *result)
+{
+	int err = DO_ONCE_BLOCKING(fscrypt_init_sha256);
 
-		tfm = crypto_alloc_shash("sha256", 0, 0);
-		if (IS_ERR(tfm)) {
-			fscrypt_err(NULL,
-				    "Error allocating SHA-256 transform: %ld",
-				    PTR_ERR(tfm));
-			return PTR_ERR(tfm);
-		}
-		prev_tfm = cmpxchg(&sha256_hash_tfm, NULL, tfm);
-		if (prev_tfm) {
-			crypto_free_shash(tfm);
-			tfm = prev_tfm;
-		}
+	if (err) {
+		fscrypt_err(NULL, "Error allocating SHA-256 transform: %d",
+			    err);
+		return err;
 	}
-
-	return crypto_shash_tfm_digest(tfm, data, data_len, result);
+	return crypto_shash_tfm_digest(sha256_hash_tfm, data, data_len, result);
 }
