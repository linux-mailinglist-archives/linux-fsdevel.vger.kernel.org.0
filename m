Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00AAA103A3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 13:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfKTMmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 07:42:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30616 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfKTMma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574253749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjiqMwk1Fsou6tGghqOXQu73ReEj37ZIEa08rkPnnp0=;
        b=ctD55VJ1eJSpvLcbLEzlewDsKWX25SQf1MKvSGNgBpVWU3MHhgLI+RKB07ovLpNXF+aI7O
        5hww88nTe0Dzxmn9p88ozUVfG0KYkegYnQwzJRO5IASgjeqsSNn6Wa4x6HpP7+QtXv0u+j
        chH0qfPJQtlpWRfW+9A7svtCR4HnHuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-nGJD-KGsPyyqy-xPYYGZlA-1; Wed, 20 Nov 2019 07:42:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2EBA1005513;
        Wed, 20 Nov 2019 12:42:24 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4286D67275;
        Wed, 20 Nov 2019 12:42:24 +0000 (UTC)
Date:   Wed, 20 Nov 2019 07:42:24 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/28] xfs: rework unreferenced inode lookups
Message-ID: <20191120124224.GA15542@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-29-david@fromorbit.com>
 <20191106221846.GE37080@bfoster>
 <20191114221602.GJ4614@dread.disaster.area>
 <20191115172600.GC55854@bfoster>
 <20191118010047.GS4614@dread.disaster.area>
 <20191119151344.GD10763@bfoster>
 <20191119211834.GA4614@dread.disaster.area>
MIME-Version: 1.0
In-Reply-To: <20191119211834.GA4614@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: nGJD-KGsPyyqy-xPYYGZlA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 20, 2019 at 08:18:34AM +1100, Dave Chinner wrote:
> On Tue, Nov 19, 2019 at 10:13:44AM -0500, Brian Foster wrote:
> > On Mon, Nov 18, 2019 at 12:00:47PM +1100, Dave Chinner wrote:
> > > On Fri, Nov 15, 2019 at 12:26:00PM -0500, Brian Foster wrote:
> > > > On Fri, Nov 15, 2019 at 09:16:02AM +1100, Dave Chinner wrote:
> > > > > On Wed, Nov 06, 2019 at 05:18:46PM -0500, Brian Foster wrote:
> > > > > If so, most of this patch will go away....
> > > > >=20
> > > > > > > +=09 * attached to the buffer so we don't need to do anything=
 more here.
> > > > > > >  =09 */
> > > > > > > -=09if (ip !=3D free_ip) {
> > > > > > > -=09=09if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
> > > > > > > -=09=09=09rcu_read_unlock();
> > > > > > > -=09=09=09delay(1);
> > > > > > > -=09=09=09goto retry;
> > > > > > > -=09=09}
> > > > > > > -
> > > > > > > -=09=09/*
> > > > > > > -=09=09 * Check the inode number again in case we're racing w=
ith
> > > > > > > -=09=09 * freeing in xfs_reclaim_inode().  See the comments i=
n that
> > > > > > > -=09=09 * function for more information as to why the initial=
 check is
> > > > > > > -=09=09 * not sufficient.
> > > > > > > -=09=09 */
> > > > > > > -=09=09if (ip->i_ino !=3D inum) {
> > > > > > > +=09if (__xfs_iflags_test(ip, XFS_ISTALE)) {
> > > > > >=20
> > > > > > Is there a correctness reason for why we move the stale check t=
o under
> > > > > > ilock (in both iflush/ifree)?
> > > > >=20
> > > > > It's under the i_flags_lock, and so I moved it up under the looku=
p
> > > > > hold of the i_flags_lock so we don't need to cycle it again.
> > > > >=20
> > > >=20
> > > > Yeah, but in both cases it looks like it moved to under the ilock a=
s
> > > > well, which comes after i_flags_lock. IOW, why grab ilock for stale
> > > > inodes when we're just going to skip them?
> > >=20
> > > Because I was worrying about serialising against reclaim before
> > > changing the state of the inode. i.e. if the inode has already been
> > > isolated by not yet disposed of, we shouldn't touch the inode state
> > > at all. Serialisation against reclaim in this patch is via the
> > > ILOCK, hence we need to do that before setting ISTALE....
> > >=20
> >=20
> > Yeah, I think my question still isn't clear... I'm not talking about
> > setting ISTALE. The code I referenced above is where we test for it and
> > skip the inode if it is already set. For example, the code referenced
> > above in xfs_ifree_get_one_inode() currently does the following with
> > respect to i_flags_lock, ILOCK and XFS_ISTALE:
> >=20
> > =09...
> > =09spin_lock(i_flags_lock)
> > =09xfs_ilock_nowait(XFS_ILOCK_EXCL)
> > =09if !XFS_ISTALE
> > =09=09skip
> > =09set XFS_ISTALE
> > =09...
>=20
> There is another place in xfs_ifree_cluster that sets ISTALE without
> the ILOCK held, so the ILOCK is being used here for a different
> purpose...
>=20
> > The reclaim isolate code does this, however:
> >=20
> > =09spin_trylock(i_flags_lock)
> > =09if !XFS_ISTALE
> > =09=09skip
> > =09xfs_ilock(XFS_ILOCK_EXCL)
> > =09...=09
>=20
> Which is fine, because we're not trying to avoid racing with reclaim
> here. :) i.e. all we need is the i_flags lock to check the ISTALE
> flag safely.
>=20
> > So my question is why not do something like the following in the
> > _get_one_inode() case?
> >=20
> > =09...
> > =09spin_lock(i_flags_lock)
> > =09if !XFS_ISTALE
> > =09=09skip
> > =09xfs_ilock_nowait(XFS_ILOCK_EXCL)
> > =09set XFS_ISTALE
> > =09...
>=20
> Because, like I said, I focussed on the lookup racing with reclaim
> first. The above code could be used, but it puts object internal
> state checks before we really know whether the object is safe to
> access and whether we can trust it.
>=20
> I'm just following a basic RCU/lockless lookup principle here:
> don't try to use object state before you've fully validated that the
> object is live and guaranteed that it can be safely referenced.
>=20
> > IOW, what is the need, if any, to acquire ilock in the iflush/ifree
> > paths before testing for XFS_ISTALE? Is there some specific intermediat=
e
> > state I'm missing or is this just unintentional?
>=20
> It's entirely intentional - validate and claim the object we've
> found in the lockless lookup, then run the code that checks/changes
> the object state. Smashing state checks and lockless lookup
> validation together is a nasty landmine to leave behind...
>=20

Ok, so this is intentional, but the purpose is simplification vs.
technically being part of the lookup dance. I'm not sure I see the
advantage given that IMO this trades off one landmine for another, but
I'm not worried that much about it as long as the code is correct.

I guess we'll see how things change after reevaluation of the whole
holding ilock across contexts behavior, but if we do end up with a
similar pattern in the iflush/ifree paths please document that
explicitly in the comments. Otherwise in a patch that swizzles this code
around and explicitly plays games with ilock, the intent of this
particular change is not clear to somebody reading the code IMO. In
fact, I think it might be interesting to see if we could define a couple
helpers (located closer to the reclaim code) to perform an unreferenced
lookup/release of an inode, but that is secondary to nailing down the
fundamental rules.

Brian

> Cheers,
>=20
> Dave.
> --=20
> Dave Chinner
> david@fromorbit.com
>=20

