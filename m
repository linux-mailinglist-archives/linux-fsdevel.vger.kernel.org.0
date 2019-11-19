Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE5B1027CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 16:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfKSPNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 10:13:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20845 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726637AbfKSPNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574176428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=widBx/i0o0g15mXBzX0xlHem4iGp/JqjGpNTCuPpt7c=;
        b=ZhmVab4GB0Ou499NsXs4IclmKXggdLf8ZUpMB8fYZhE+Fb18YeiHanv0CV93thlWcRW/ZJ
        ffAIJ5bBimcywC8Z6iCY/GB7+FkFkPujnKTS+6+g2CPNa4Rcb8qzbS9xnA/D/JGHzRpYAv
        G3ch02TuHouLsZeHT/ltRH/DWY2LSzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-ACVK68odNwylutUVZPDcFw-1; Tue, 19 Nov 2019 10:13:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7449818C35B6;
        Tue, 19 Nov 2019 15:13:44 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7A7150FCB;
        Tue, 19 Nov 2019 15:13:43 +0000 (UTC)
Date:   Tue, 19 Nov 2019 10:13:44 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/28] xfs: rework unreferenced inode lookups
Message-ID: <20191119151344.GD10763@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-29-david@fromorbit.com>
 <20191106221846.GE37080@bfoster>
 <20191114221602.GJ4614@dread.disaster.area>
 <20191115172600.GC55854@bfoster>
 <20191118010047.GS4614@dread.disaster.area>
MIME-Version: 1.0
In-Reply-To: <20191118010047.GS4614@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ACVK68odNwylutUVZPDcFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 18, 2019 at 12:00:47PM +1100, Dave Chinner wrote:
> On Fri, Nov 15, 2019 at 12:26:00PM -0500, Brian Foster wrote:
> > On Fri, Nov 15, 2019 at 09:16:02AM +1100, Dave Chinner wrote:
> > > On Wed, Nov 06, 2019 at 05:18:46PM -0500, Brian Foster wrote:
> > > If so, most of this patch will go away....
> > >=20
> > > > > +=09 * attached to the buffer so we don't need to do anything mor=
e here.
> > > > >  =09 */
> > > > > -=09if (ip !=3D free_ip) {
> > > > > -=09=09if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
> > > > > -=09=09=09rcu_read_unlock();
> > > > > -=09=09=09delay(1);
> > > > > -=09=09=09goto retry;
> > > > > -=09=09}
> > > > > -
> > > > > -=09=09/*
> > > > > -=09=09 * Check the inode number again in case we're racing with
> > > > > -=09=09 * freeing in xfs_reclaim_inode().  See the comments in th=
at
> > > > > -=09=09 * function for more information as to why the initial che=
ck is
> > > > > -=09=09 * not sufficient.
> > > > > -=09=09 */
> > > > > -=09=09if (ip->i_ino !=3D inum) {
> > > > > +=09if (__xfs_iflags_test(ip, XFS_ISTALE)) {
> > > >=20
> > > > Is there a correctness reason for why we move the stale check to un=
der
> > > > ilock (in both iflush/ifree)?
> > >=20
> > > It's under the i_flags_lock, and so I moved it up under the lookup
> > > hold of the i_flags_lock so we don't need to cycle it again.
> > >=20
> >=20
> > Yeah, but in both cases it looks like it moved to under the ilock as
> > well, which comes after i_flags_lock. IOW, why grab ilock for stale
> > inodes when we're just going to skip them?
>=20
> Because I was worrying about serialising against reclaim before
> changing the state of the inode. i.e. if the inode has already been
> isolated by not yet disposed of, we shouldn't touch the inode state
> at all. Serialisation against reclaim in this patch is via the
> ILOCK, hence we need to do that before setting ISTALE....
>=20

Yeah, I think my question still isn't clear... I'm not talking about
setting ISTALE. The code I referenced above is where we test for it and
skip the inode if it is already set. For example, the code referenced
above in xfs_ifree_get_one_inode() currently does the following with
respect to i_flags_lock, ILOCK and XFS_ISTALE:

=09...
=09spin_lock(i_flags_lock)
=09xfs_ilock_nowait(XFS_ILOCK_EXCL)
=09if !XFS_ISTALE
=09=09skip
=09set XFS_ISTALE
=09...

The reclaim isolate code does this, however:

=09spin_trylock(i_flags_lock)
=09if !XFS_ISTALE
=09=09skip
=09xfs_ilock(XFS_ILOCK_EXCL)
=09...=09

So my question is why not do something like the following in the
_get_one_inode() case?

=09...
=09spin_lock(i_flags_lock)
=09if !XFS_ISTALE
=09=09skip
=09xfs_ilock_nowait(XFS_ILOCK_EXCL)
=09set XFS_ISTALE
=09...

IOW, what is the need, if any, to acquire ilock in the iflush/ifree
paths before testing for XFS_ISTALE? Is there some specific intermediate
state I'm missing or is this just unintentional? The reason I ask is
ilock failure triggers that ugly delay(1) and retry thing, so it seems
slightly weird to allow that for a stale inode we're ultimately going to
skip (regardless of whether that would actually ever occur).

Brian

> IOWs, ISTALE is not protected by ILOCK, we just can't modify the
> inode state until after we've gained the ILOCK to protect against
> reclaim....
>=20
> Cheers,
>=20
> Dave.
> --=20
> Dave Chinner
> david@fromorbit.com
>=20

