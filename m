Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29223FE3E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 18:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfKOR0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 12:26:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56074 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727540AbfKOR0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573838767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDfDUKWjQswTNFhzDyZxoooMhF82NHzZ1nCK26LCMSs=;
        b=ZISL1YCcDI1PbZ+0EnIbI3plq33/aV/uMg85slfJclq/nzep/c363XylfHA1dPNvdspw0Y
        vZvchiRF11WwZFm5r4TMrJMnUynB0cABG+OOJqq56MOuqLdPC25UafjR2CIgeO58GkZcS8
        TY4tG5jvYEQKwvj0OmgMkwgqbnCUk2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-sgU4sxUvNO-1_l5eN3at6A-1; Fri, 15 Nov 2019 12:26:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D40C1DC4F;
        Fri, 15 Nov 2019 17:26:02 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29EE26A975;
        Fri, 15 Nov 2019 17:26:02 +0000 (UTC)
Date:   Fri, 15 Nov 2019 12:26:00 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/28] xfs: rework unreferenced inode lookups
Message-ID: <20191115172600.GC55854@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-29-david@fromorbit.com>
 <20191106221846.GE37080@bfoster>
 <20191114221602.GJ4614@dread.disaster.area>
MIME-Version: 1.0
In-Reply-To: <20191114221602.GJ4614@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: sgU4sxUvNO-1_l5eN3at6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 09:16:02AM +1100, Dave Chinner wrote:
> On Wed, Nov 06, 2019 at 05:18:46PM -0500, Brian Foster wrote:
> > On Fri, Nov 01, 2019 at 10:46:18AM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > >=20
> > > Looking up an unreferenced inode in the inode cache is a bit hairy.
> > > We do this for inode invalidation and writeback clustering purposes,
> > > which is all invisible to the VFS. Hence we can't take reference
> > > counts to the inode and so must be very careful how we do it.
> > >=20
> > > There are several different places that all do the lookups and
> > > checks slightly differently. Fundamentally, though, they are all
> > > racy and inode reclaim has to block waiting for the inode lock if it
> > > loses the race. This is not very optimal given all the work we;ve
> > > already done to make reclaim non-blocking.
> > >=20
> > > We can make the reclaim process nonblocking with a couple of simple
> > > changes. If we define the unreferenced lookup process in a way that
> > > will either always grab an inode in a way that reclaim will notice
> > > and skip, or will notice a reclaim has grabbed the inode so it can
> > > skip the inode, then there is no need for reclaim to need to cycle
> > > the inode ILOCK at all.
> > >=20
> > > Selecting an inode for reclaim is already non-blocking, so if the
> > > ILOCK is held the inode will be skipped. If we ensure that reclaim
> > > holds the ILOCK until the inode is freed, then we can do the same
> > > thing in the unreferenced lookup to avoid inodes in reclaim. We can
> > > do this simply by holding the ILOCK until the RCU grace period
> > > expires and the inode freeing callback is run. As all unreferenced
> > > lookups have to hold the rcu_read_lock(), we are guaranteed that
> > > a reclaimed inode will be noticed as the trylock will fail.
> > >=20
> > ...
> > >=20
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  fs/xfs/mrlock.h     |  27 +++++++++
> > >  fs/xfs/xfs_icache.c |  88 +++++++++++++++++++++--------
> > >  fs/xfs/xfs_inode.c  | 131 +++++++++++++++++++++---------------------=
--
> > >  3 files changed, 153 insertions(+), 93 deletions(-)
> > >=20
> > > diff --git a/fs/xfs/mrlock.h b/fs/xfs/mrlock.h
> > > index 79155eec341b..1752a2592bcc 100644
> > > --- a/fs/xfs/mrlock.h
> > > +++ b/fs/xfs/mrlock.h
> > ...
> > > diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> > > index 11bf4768d491..45ee3b5cd873 100644
> > > --- a/fs/xfs/xfs_icache.c
> > > +++ b/fs/xfs/xfs_icache.c
> > > @@ -106,6 +106,7 @@ xfs_inode_free_callback(
> > >  =09=09ip->i_itemp =3D NULL;
> > >  =09}
> > > =20
> > > +=09mrunlock_excl_non_owner(&ip->i_lock);
> > >  =09kmem_zone_free(xfs_inode_zone, ip);
> > >  }
> > > =20
> > > @@ -132,6 +133,7 @@ xfs_inode_free(
> > >  =09 * free state. The ip->i_flags_lock provides the barrier against =
lookup
> > >  =09 * races.
> > >  =09 */
> > > +=09mrupdate_non_owner(&ip->i_lock);
> >=20
> > Can we tie these into the proper locking interface using flags? For
> > example, something like xfs_ilock(ip, XFS_ILOCK_EXCL|XFS_ILOCK_NONOWNER=
)
> > or xfs_ilock(ip, XFS_ILOCK_EXCL_NONOWNER) perhaps?
>=20
> I'd prefer not to make this part of the common locking interface -
> it's a one off special use case, not something we want to progate
> elsewhere into the code.
>=20

What urks me about this is that it obfuscates rather than highlights
that fact because I have no idea what mrtryupdate_non_owner() actually
does without looking it up. We could easily name a flag
XFS_ILOCK_PENDING_RECLAIM or something similarly ridiculous to make it
blindingly obvious it should only be used in a special context.

> Now that I think over it, I probably should have tagged this with
> patch with [RFC]. I think we should just get rid of the mrlock
> wrappers rather than add more, and that would simplify this a lot.
>=20

Yeah, FWIW I've been reviewing this patch as a WIP on top of all of the
nonblocking bits as opposed to being some fundamental part of that work.
That aside, I also agree that cleaning up these wrappers might address
that concern because something like:

=09/* open code ilock because ... */
=09down_write_trylock_non_owner(&ip->i_lock);

... is at least readable code.

>=20
> > >  =09spin_lock(&ip->i_flags_lock);
> > >  =09ip->i_flags =3D XFS_IRECLAIM;
> > >  =09ip->i_ino =3D 0;
> > > @@ -295,11 +297,24 @@ xfs_iget_cache_hit(
> > >  =09=09}
> > > =20
> > >  =09=09/*
> > > -=09=09 * We need to set XFS_IRECLAIM to prevent xfs_reclaim_inode
> > > -=09=09 * from stomping over us while we recycle the inode. Remove it
> > > -=09=09 * from the LRU straight away so we can re-init the VFS inode.
> > > +=09=09 * Before we reinitialise the inode, we need to make sure
> > > +=09=09 * reclaim does not pull it out from underneath us. We already
> > > +=09=09 * hold the i_flags_lock, and because the XFS_IRECLAIM is not
> > > +=09=09 * set we know the inode is still on the LRU. However, the LRU
> > > +=09=09 * code may have just selected this inode to reclaim, so we ne=
ed
> > > +=09=09 * to ensure we hold the i_flags_lock long enough for the
> > > +=09=09 * trylock in xfs_inode_reclaim_isolate() to fail. We do this =
by
> > > +=09=09 * removing the inode from the LRU, which will spin on the LRU
> > > +=09=09 * list locks until reclaim stops walking, at which point we
> > > +=09=09 * know there is no possible race between reclaim isolation an=
d
> > > +=09=09 * this lookup.
> > > +=09=09 *
> >=20
> > Somewhat related to my question about the lru_lock on the earlier patch=
.
>=20
> *nod*
>=20
> The caveat here is that this is the slow path so spinning for a
> while doesn't really matter.
>=20
> > > @@ -1022,19 +1076,7 @@ xfs_dispose_inode(
> > >  =09spin_unlock(&pag->pag_ici_lock);
> > >  =09xfs_perag_put(pag);
> > > =20
> > > -=09/*
> > > -=09 * Here we do an (almost) spurious inode lock in order to coordin=
ate
> > > -=09 * with inode cache radix tree lookups.  This is because the look=
up
> > > -=09 * can reference the inodes in the cache without taking reference=
s.
> > > -=09 *
> > > -=09 * We make that OK here by ensuring that we wait until the inode =
is
> > > -=09 * unlocked after the lookup before we go ahead and free it.
> > > -=09 *
> > > -=09 * XXX: need to check this is still true. Not sure it is.
> > > -=09 */
> > > -=09xfs_ilock(ip, XFS_ILOCK_EXCL);
> > >  =09xfs_qm_dqdetach(ip);
> > > -=09xfs_iunlock(ip, XFS_ILOCK_EXCL);
> >=20
> > Ok, so I'm staring at this a bit more and think I'm missing something.
> > If we put aside the change to hold ilock until the inode is freed, we
> > basically have the following (simplified) flow as the inode goes from
> > isolation to disposal:
> >=20
> > =09ilock=09(isolate)
> > =09iflock
> > =09set XFS_IRECLAIM
> > =09ifunlock (disposal)
> > =09iunlock
> > =09radix delete
> > =09ilock cycle (drain)
> > =09rcu free
> >=20
> > What we're trying to eliminate is the ilock cycle to drain any
> > concurrent unreferenced lookups from accessing the inode once it is
> > freed. The free itself is still RCU protected.
> >=20
> > Looking over at the ifree path, we now have something like this:
> >=20
> > =09rcu_read_lock()
> > =09radix lookup
> > =09check XFS_IRECLAIM
> > =09ilock
> > =09if XFS_ISTALE, skip
> > =09set XFS_ISTALE
> > =09rcu_read_unlock()
> > =09iflock
> > =09/* return locked down inode */
>=20
> You missed a lock.
>=20
> =09rcu_read_lock()
> =09radix lookup
> >>>=09i_flags_lock
> =09check XFS_IRECLAIM
> =09ilock
> =09if XFS_ISTALE, skip
> =09set XFS_ISTALE
> >>>=09i_flags_unlock
> =09rcu_read_unlock()
> =09iflock
>=20
> > Given that we set XFS_IRECLAIM under ilock, would we still need either
> > the ilock cycle or to hold ilock through the RCU free if the ifree side
> > (re)checked XFS_IRECLAIM after it has the ilock (but before it drops th=
e
> > rcu read lock)?
>=20
> We set XFS_IRECLAIM under the i_flags_lock.
>=20
> It is the combination of rcu_read_lock() and i_flags_lock() that
> provides the RCU lookup state barriers - the ILOCK is not part of
> that at all.
>=20
> The key point here is that once we've validated the inode we found
> in the radix tree under the i_flags_lock, we then take the ILOCK,
> thereby serialising the taking of the ILOCK here with the taking of
> the ILOCK in the reclaim isolation code.
>=20
> i.e. all the reclaim state serialisation is actually based around
> holding the i_flags_lock, not the ILOCK.=20
>=20
> Once we have grabbed the ILOCK under the i_flags_lock, we can
> drop the i_flags_lock knowing that reclaim will not be able isolate
> this inode and set XFS_IRECLAIM.
>=20

Hmm, Ok. I knew i_flags_lock was in there when I wrote this up. I
intentionally left it out as a simplification because it wasn't clear to
me that it was a critical part of the lookup. I'll keep this in mind the
next time I walk through this code.

> > ISTM we should either have a non-reclaim inode with
> > ilock protection or a reclaim inode with RCU protection (so we can skip
> > it before it frees), but I could easily be missing something here..
>=20
> Heh. Yeah, it's a complex dance, and it's all based around how
> RCU lookups and the i_flags_lock interact to provide coherent
> detection of freed inodes.
>=20
> I have a nagging feeling that this whole ILOCK-held-to-rcu-free game
> can be avoided. I need to walk myself through the lookup state
> machine again and determine if ordering the XFS_IRECLAIM flag check
> after greabbing the ILOCK is sufficient to prevent ifree/iflush
> lookups from accessing the inode outside the rcu_read_lock()
> context.
>=20

That's pretty much what I was wondering...

> If so, most of this patch will go away....
>=20
> > > +=09 * attached to the buffer so we don't need to do anything more he=
re.
> > >  =09 */
> > > -=09if (ip !=3D free_ip) {
> > > -=09=09if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
> > > -=09=09=09rcu_read_unlock();
> > > -=09=09=09delay(1);
> > > -=09=09=09goto retry;
> > > -=09=09}
> > > -
> > > -=09=09/*
> > > -=09=09 * Check the inode number again in case we're racing with
> > > -=09=09 * freeing in xfs_reclaim_inode().  See the comments in that
> > > -=09=09 * function for more information as to why the initial check i=
s
> > > -=09=09 * not sufficient.
> > > -=09=09 */
> > > -=09=09if (ip->i_ino !=3D inum) {
> > > +=09if (__xfs_iflags_test(ip, XFS_ISTALE)) {
> >=20
> > Is there a correctness reason for why we move the stale check to under
> > ilock (in both iflush/ifree)?
>=20
> It's under the i_flags_lock, and so I moved it up under the lookup
> hold of the i_flags_lock so we don't need to cycle it again.
>=20

Yeah, but in both cases it looks like it moved to under the ilock as
well, which comes after i_flags_lock. IOW, why grab ilock for stale
inodes when we're just going to skip them?

Brian

> > >  =09/*
> > > -=09 * We don't need to attach clean inodes or those only with unlogg=
ed
> > > -=09 * changes (which we throw away, anyway).
> > > +=09 * We don't need to attach clean inodes to the buffer - they are =
marked
> > > +=09 * stale in memory now and will need to be re-initialised by inod=
e
> > > +=09 * allocation before they can be reused.
> > >  =09 */
> > >  =09if (!ip->i_itemp || xfs_inode_clean(ip)) {
> > >  =09=09ASSERT(ip !=3D free_ip);
> > >  =09=09xfs_ifunlock(ip);
> > > -=09=09xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > > +=09=09if (ip !=3D free_ip)
> > > +=09=09=09xfs_iunlock(ip, XFS_ILOCK_EXCL);
> >=20
> > There's an assert against this case just above, though I suppose there'=
s
> > nothing wrong with just keeping it and making the functional code more
> > cautious.
>=20
> *nod*
>=20
> It follows Darrick's lead of making sure that production kernels
> don't do something stupid because of some whacky corruption we
> didn't expect to ever see.
>=20
> Cheers,
>=20
> Dave.
> --=20
> Dave Chinner
> david@fromorbit.com
>=20

