Return-Path: <linux-fsdevel+bounces-57820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18410B25920
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 03:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F5D1C223CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 01:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC85A19C569;
	Thu, 14 Aug 2025 01:31:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DCB2FF642;
	Thu, 14 Aug 2025 01:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755135084; cv=none; b=CkgsjCe8HXROK/HC7U3QoYXcgz3oamTN7ycxif48+ZcT053AKNSO+T3j8o88b39ePOEO3SALVhucBH4afVbNPG33bk62/UDCFYqkYw/7FG+kJgydGV0z+xes2WgO2cpPBf4bVMnhF9t3n8LtCJAjRr8yAWYX46t1z6hG2FihNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755135084; c=relaxed/simple;
	bh=vsEfHr0smoZYxGwAudHUrsDK736/zS7X+6MQwm+RZ1E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=iF4cpx11qJS/YVxLjNeo4fPdCYQ5vB+1OXqeOY40VaAGRla5pZfGAAXm/NWZfMGxCqsfmlcwSlt87LRJ/d4+tJ/wwGO88tWL8kWPUWRZvdiurunT36Vy0pzbnHiE442coNKQX9XwSIbMP/ClOqLk3Onqn0Gq+fSgRCtP6Eyli5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1umMoE-005hAB-I4;
	Thu, 14 Aug 2025 01:31:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Steve French" <sfrench@samba.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Carlos Maiolino" <cem@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 netfs@lists.linux.dev, ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 09/11] VFS: use global wait-queue table for d_alloc_parallel()
In-reply-to: <20250813064431.GF222315@ZenIV>
References: <>, <20250813064431.GF222315@ZenIV>
Date: Thu, 14 Aug 2025 11:31:15 +1000
Message-id: <175513507565.2234665.11138440093783281571@noble.neil.brown.name>

On Wed, 13 Aug 2025, Al Viro wrote:
> On Tue, Aug 12, 2025 at 12:25:12PM +1000, NeilBrown wrote:
>=20
> > +** mandatory**
> > +
> > +d_alloc_parallel() no longer requires a waitqueue_head.  It uses one
> > +from an internal table when needed.
>=20
> Misleading, IMO - that sounds like "giving it a wq is optional, it will
> pick one if needed" when reality is "calling conventions have changed,
> no more passing it a waitqueue at all".

I'll rephrase it.

>=20
> > +#define	PAR_LOOKUP_WQ_BITS	8
> > +#define PAR_LOOKUP_WQS (1 << PAR_LOOKUP_WQ_BITS)
> > +static wait_queue_head_t par_wait_table[PAR_LOOKUP_WQS] __cacheline_alig=
ned;
>=20
> I wonder how hot these cachelines will be...

Are you questioning the __cacheline_aligned??  I confess I just copied
the annotation on bit_wait_table.

My guess is that concurrent attempts to add the same name to the dcache
are rare, so these wait_queue_heads will be rarely used.

>=20
> > +static int __init par_wait_init(void)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < PAR_LOOKUP_WQS; i++)
> > +		init_waitqueue_head(&par_wait_table[i]);
> > +	return 0;
> > +}
> > +fs_initcall(par_wait_init);
>=20
> Let's not open _that_ can of worms; just call it from dcache_init().
>=20
> > +static inline void d_wake_waiters(struct wait_queue_head *d_wait,
> > +				  struct dentry *dentry)
> > +{
> > +	/* ->d_wait is only set if some thread is actually waiting.
> > +	 * If we find it is NULL - the common case - then there was no
> > +	 * contention and there are no waiters to be woken.
> > +	 */
> > +	if (d_wait)
> > +		__wake_up(d_wait, TASK_NORMAL, 0, dentry);
>=20
> Might be worth a note re "this is wake_up_all(), except that key is dentry
> rather than NULL" - or a helper in wait.h to that effect, for that matter.
> I see several other places where we have the same thing (do_notify_pidfd(),
> nfs4_callback_notify_lock(), etc.), so...
>=20
>=20

As there are no exclusive waiters, any wakeup is a wake_up_all so I
think that emphasising the "all" adds no value.  So I could equally have
used "1" instead of "0", but I chose "0" as the number was irrelevant.

Having a "wake_up_key()" which does=20
   __wake_up(wq, TASK_NORMAL, 1, key)
would be nice.

> > +		struct wait_queue_head *wq;
> > +		if (!dentry->d_wait)
> > +			dentry->d_wait =3D &par_wait_table[hash_ptr(dentry,
> > +								  PAR_LOOKUP_WQ_BITS)];
> > +		wq =3D dentry->d_wait;
>=20
> Yecchhh...  Cosmetic change: take
> 	&par_wait_table[hash_ptr(dentry, PAR_LOOKUP_WQ_BITS)];
> into an inlined helper, please.
>=20
> BTW, while we are at it - one change I have for that function is
> (in the current form)
> static bool d_wait_lookup(struct dentry *dentry,
> 			  struct dentry *parent,
> 			  const struct qstr *name)
> {
> 	bool valid =3D true;
> 	spin_lock(&dentry->d_lock);
>         if (d_in_lookup(dentry)) {
> 		DECLARE_WAITQUEUE(wait, current);
> 		add_wait_queue(dentry->d_wait, &wait);
> 		do {  =20
> 			set_current_state(TASK_UNINTERRUPTIBLE);
> 			spin_unlock(&dentry->d_lock);
> 			schedule();
> 			spin_lock(&dentry->d_lock);
> 		} while (d_in_lookup(dentry));
> 	}
> 	/*
> 	 * it's not in-lookup anymore; in principle the caller should repeat
> 	 * everything from dcache lookup, but it's likely to be what
> 	 * d_lookup() would've found anyway.  If so, they can use it as-is.
> 	 */
> 	if (unlikely(dentry->d_name.hash !=3D name->hash ||
> 		     dentry->d_parent !=3D parent ||
> 		     d_unhashed(dentry) ||
> 		     !d_same_name(dentry, parent, name)))
> 		valid =3D false;
> 	spin_unlock(&dentry->d_lock);
> 	return valid;
> }
>=20
> with
> 	if (unlikely(d_wait_lookup(dentry, parent, name))) {
>                 dput(dentry);
> 		goto retry;
> 	}
> 	dput(new);
> 	return dentry;
> in the caller (d_alloc_parallel()).  Caller easier to follow and fewer func=
tions
> that are not neutral wrt ->d_lock...  I'm not suggesting to fold that with
> yours - just a heads-up on needing to coordinate.

I see the value in that, but it does mean the function is doing more
than just waiting, and it might make my life a bit harder....

One of the steps toward per-dentry locking involves finding a new
solution to excluding all other accesses when rmdir() is happening.  An
exclusive lock on the directory will no longer be sufficient.

So I set a flag which says "rmdir processing has started" and cause
d_alloc_parallel() (and dentry_lock) to wait for that flag to clear.
A new rmdir_lock() needs to wait for all current DCACHE_PAR_LOOKUP
dentries to complete the lookup and my code currently uses
d_wait_lookup().  The extra test you've added at the end wouldn't be
harmful exactly but would be unnecessary.
Maybe we could have d_wait_lookup_and_check() for your version and
d_wait_lookup() for me?

>=20
> Anyway, modulo fs_initcall() thing it's all cosmetical; I certainly like
> the simplified callers, if nothing else.
>=20
> That's another patch I'd like to see pulled in front of the queue.
>=20

Thanks.

NeilBrown

