Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0802247FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 04:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGRCNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 22:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgGRCNI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:13:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080E0C0619D2;
        Fri, 17 Jul 2020 19:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b6Lq/lewhmuN9xzWi3dHd0xI6Cg0i4KUL37C2Kg1dS8=; b=HophwgPLXdiolehFqCeYvePvXL
        mriM58eqE9tYcmpXbUWG10+WG8uvKd6NEuRdIlMGpFhQug0EDt90vDBzTAK9ytr9agSs9T6JwgQJA
        enP39pgqZ1bPQn7D7t+Z8nSKdTfPKa18YImWxT3eb0xI91O9SF+5zZZBXnvstFoLvEqZ8zMu/q09t
        yOMU0piavcn8/bXAmmrPHlQWBzKysq/eq3urOQKYfUxu7NbgW4Kr4unl4jmTiYDQzsWUojYpjD9A6
        3x+xXINHbilI0enTEFRP5+/o4QC9Ee2KAI/TU7zj6Zk7a4fMvWVgOyJJ9H33/odet6gNXxM7nLxWw
        9YOEbGMw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwcLY-0002fS-VR; Sat, 18 Jul 2020 02:13:05 +0000
Date:   Sat, 18 Jul 2020 03:13:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
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
Message-ID: <20200718021304.GS12769@casper.infradead.org>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200718013839.GD2183@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718013839.GD2183@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 06:38:39PM -0700, Eric Biggers wrote:
> On Fri, Jul 17, 2020 at 06:47:50PM +0100, Matthew Wilcox wrote:
> > On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
> > > +If that doesn't apply, you'll have to implement one-time init yourself.
> > > +
> > > +The simplest implementation just uses a mutex and an 'inited' flag.
> > > +This implementation should be used where feasible:
> > 
> > I think some syntactic sugar should make it feasible for normal people
> > to implement the most efficient version of this just like they use locks.
> 
> Note that the cmpxchg version is not necessarily the "most efficient".
> 
> If the one-time initialization is expensive, e.g. if it allocates a lot of
> memory or if takes a long time, it could be better to use the mutex version so
> that at most one task does it.

Sure, but I think those are far less common than just allocating a single
thing.

> > How about something like this ...
> > 
> > once.h:
> > 
> > static struct init_once_pointer {
> > 	void *p;
> > };
> > 
> > static inline void *once_get(struct init_once_pointer *oncep)
> > { ... }
> > 
> > static inline bool once_store(struct init_once_pointer *oncep, void *p)
> > { ... }
> > 
> > --- foo.c ---
> > 
> > struct foo *get_foo(gfp_t gfp)
> > {
> > 	static struct init_once_pointer my_foo;
> > 	struct foo *foop;
> > 
> > 	foop = once_get(&my_foo);
> > 	if (foop)
> > 		return foop;
> > 
> > 	foop = alloc_foo(gfp);
> > 	if (!once_store(&my_foo, foop)) {
> > 		free_foo(foop);
> > 		foop = once_get(&my_foo);
> > 	}
> > 
> > 	return foop;
> > }
> > 
> > Any kernel programmer should be able to handle that pattern.  And no mutex!
> 
> I don't think this version would be worthwhile.  It eliminates type safety due
> to the use of 'void *', and doesn't actually save any lines of code.  Nor does
> it eliminate the need to correctly implement the cmpxchg failure case, which is
> tricky (it must free the object and get the new one) and will be rarely tested.

You're missing the point.  It prevents people from trying to optimise
"can I use READ_ONCE() here, or do I need to use smp_rmb()?"  The type
safety is provided by the get_foo() function.  I suppose somebody could
play some games with _Generic or something, but there's really no need to.
It's like using a list_head and casting to the container_of.

> It also forces all users of the struct to use this helper function to access it.
> That could be considered a good thing, but it's also bad because even with
> one-time init there's still usually some sort of ordering of "initialization"
> vs. "use".  Just taking a random example I'm familiar with, we do one-time init
> of inode::i_crypt_info when we open an encrypted file, so we guarantee it's set
> for all I/O to the file, where we then simply access ->i_crypt_info directly.
> We don't want the code to read like it's initializing ->i_crypt_info in the
> middle of ->writepages(), since that would be wrong.

Right, and I wouldn't use this pattern for that.  You can't get to
writepages without having opened the file, so just initialising the
pointer in open is fine.

> An improvement might be to make once_store() take the free function as a
> parameter so that it would handle the failure case for you:
> 
> struct foo *get_foo(gfp_t gfp)
> {
> 	static struct init_once_pointer my_foo;
> 	struct foo *foop;
>  
>  	foop = once_get(&my_foo);
>  	if (!foop) {
> 		foop = alloc_foo(gfp);
> 		if (foop)
> 			once_store(&my_foo, foop, free_foo);

Need to mark once_store as __must_check to avoid the bug you have here:

			foop = once_store(&my_foo, foop, free_foo);

Maybe we could use a macro for once_store so we could write:

void *once_get(struct init_pointer_once *);
int once_store(struct init_pointer_once *, void *);

#define once_alloc(s, o_alloc, o_free) ({                               \
        void *__p = o_alloc;                                            \
        if (__p) {                                                      \
                if (!once_store(s, __p)) {                              \
                        o_free(__p);                                    \
                        __p = once_get(s);                              \
                }                                                       \
        }                                                               \
        __p;                                                            \
})

---

struct foo *alloc_foo(gfp_t);
void free_foo(struct foo *);

struct foo *get_foo(gfp_t gfp)
{
        static struct init_pointer_once my_foo;
        struct foo *foop;

        foop = once_get(&my_foo);
        if (!foop)
                foop = once_alloc(&my_foo, alloc_foo(gfp), free_foo);
        return foop;
}

That's pretty hard to misuse (I compile-tested it, and it works).
