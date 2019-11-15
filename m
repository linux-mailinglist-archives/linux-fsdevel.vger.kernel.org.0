Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C089BFE3D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 18:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfKORVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 12:21:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59430 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727543AbfKORVt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573838507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DdDOR7FDv/WmPIQVIDx5aIjH2GXLxNyZ+4tY7JcKXZk=;
        b=AVbJwHsGPpFvP9PaaOYFtmU1MEKx3mTMtLcIBwsJZSZTJzM6VFLkA33jAOr/yX+SZRdQna
        UWzo19dDlJiqfGEj1oL75ZGDSQpXfEf77jWlS9Qp6KUvGhHlK5XXvY/Xtw7X/OzPExTLvC
        bW1iOnNPPjkOEinTwF9lRAI3C3gHgzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-6d3nc2CFO3-lAzhrQJMhbw-1; Fri, 15 Nov 2019 12:21:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6785F8048F3;
        Fri, 15 Nov 2019 17:21:43 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8D1668432;
        Fri, 15 Nov 2019 17:21:42 +0000 (UTC)
Date:   Fri, 15 Nov 2019 12:21:40 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/28] mm: directed shrinker work deferral
Message-ID: <20191115172140.GA55854@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-10-david@fromorbit.com>
 <20191104152525.GA10665@bfoster>
 <20191114204926.GC4614@dread.disaster.area>
MIME-Version: 1.0
In-Reply-To: <20191114204926.GC4614@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 6d3nc2CFO3-lAzhrQJMhbw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 07:49:26AM +1100, Dave Chinner wrote:
> On Mon, Nov 04, 2019 at 10:25:25AM -0500, Brian Foster wrote:
> > On Fri, Nov 01, 2019 at 10:45:59AM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > >=20
> > > Introduce a mechanism for ->count_objects() to indicate to the
> > > shrinker infrastructure that the reclaim context will not allow
> > > scanning work to be done and so the work it decides is necessary
> > > needs to be deferred.
> > >=20
> > > This simplifies the code by separating out the accounting of
> > > deferred work from the actual doing of the work, and allows better
> > > decisions to be made by the shrinekr control logic on what action it
> > > can take.
> > >=20
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> >=20
> > My understanding from the previous discussion(s) is that this is not
> > tied directly to the gfp mask because that is not the only intended use=
.
> > While it is currently a boolean tied to the the entire shrinker call,
> > the longer term objective is per-object granularity.
>=20
> Longer term, yes, but right now such things are not possible as the
> shrinker needs more context to be able to make sane per-object
> decisions. shrinker policy decisions that affect the entire run
> scope should be handled by the ->count operation - it's the one that
> says whether the scan loop should run or not, and right now GFP_NOFS
> for all filesystem shrinkers is a pure boolean policy
> implementation.
>=20
> The next future step is to provide a superblock context with
> GFP_NOFS to indicate which filesystem we cannot recurse into. That
> is also a shrinker instance wide check, so again it's something that
> ->count should be deciding.
>=20
> i.e. ->count determines what is to be done, ->scan iterates the work
> that has to be done until we are done.
>=20

Sure, makes sense in general.

> > I find the argument reasonable enough, but if the above is true, why do
> > we move these checks from ->scan_objects() to ->count_objects() (in the
> > next patch) when per-object decisions will ultimately need to be made b=
y
> > the former?
>=20
> Because run/no-run policy belongs in one place, and things like
> GFP_NOFS do no change across calls to the ->scan loop. i.e. after
> the first ->scan call in a loop that calls it hundreds to thousands
> of times, the GFP_NOFS run/no-run check is completely redundant.
>=20

What loop is currently called hundreds to thousands of times that this
change prevents? AFAICT the current nofs checks in the ->scan calls
explicitly terminate the scan loop. So we're effectively saving a
function call by doing this earlier in the count ->call. (Nothing wrong
with that, I'm just not following the numbers used in this reasoning..).

> Once we introduce a new policy that allows the fs shrinker to do
> careful reclaim in GFP_NOFS conditions, we need to do substantial
> rework the shrinker scan loop and how it accounts the work that is
> done - we now have at least 3 or 4 different return counters
> (skipped because locked, skipped because referenced,
> reclaimed, deferred reclaim because couldn't lock/recursion) and
> the accounting and decisions to be made are a lot more complex.
>=20

Yeah, that's generally what I expected from your previous description.

> In that case, the ->count function will drop the GFP_NOFS check, but
> still do all the other things is needs to do. The GFP_NOFS check
> will go deep in the guts of the shrinker scan implementation where
> the per-object recursion problem exists. But for most shrinkers,
> it's still going to be a global boolean check...
>=20

So once the nofs checks are lifted out of the ->count callback and into
the core shrinker, is there still a use case to defer an entire ->count
instance from the callback?

> > That seems like unnecessary churn and inconsistent with the
> > argument against just temporarily doing something like what Christoph
> > suggested in the previous version, particularly since IIRC the only use
> > in this series was for gfp mask purposes.
>=20
> If people want to call avoiding repeated, unnecessary evaluation of
> the same condition hundreds of times instead of once "unnecessary
> churn", then I'll drop it.
>=20

I'm not referring to the functional change as churn. What I was
referring to is that we're shuffling around the boilerplate gfp checking
code between the different shrinker callbacks, knowing that it's
eventually going to be lifted out, when we could potentially just lift
that code up a level now.

Brian

> > >  include/linux/shrinker.h | 7 +++++++
> > >  mm/vmscan.c              | 8 ++++++++
> > >  2 files changed, 15 insertions(+)
> > >=20
> > > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > > index 0f80123650e2..3405c39ab92c 100644
> > > --- a/include/linux/shrinker.h
> > > +++ b/include/linux/shrinker.h
> > > @@ -31,6 +31,13 @@ struct shrink_control {
> > > =20
> > >  =09/* current memcg being shrunk (for memcg aware shrinkers) */
> > >  =09struct mem_cgroup *memcg;
> > > +
> > > +=09/*
> > > +=09 * set by ->count_objects if reclaim context prevents reclaim fro=
m
> > > +=09 * occurring. This allows the shrinker to immediately defer all t=
he
> > > +=09 * work and not even attempt to scan the cache.
> > > +=09 */
> > > +=09bool defer_work;
> > >  };
> > > =20
> > >  #define SHRINK_STOP (~0UL)
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index ee4eecc7e1c2..a215d71d9d4b 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -536,6 +536,13 @@ static unsigned long do_shrink_slab(struct shrin=
k_control *shrinkctl,
> > >  =09trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
> > >  =09=09=09=09   freeable, delta, total_scan, priority);
> > > =20
> > > +=09/*
> > > +=09 * If the shrinker can't run (e.g. due to gfp_mask constraints), =
then
> > > +=09 * defer the work to a context that can scan the cache.
> > > +=09 */
> > > +=09if (shrinkctl->defer_work)
> > > +=09=09goto done;
> > > +
> >=20
> > I still find the fact that this per-shrinker invocation field is never
> > reset unnecessarily fragile, and I don't see any good reason not to
> > reset it prior to the shrinker callback that potentially sets it.
>=20
> I missed that when updating. I'll reset it in the next version.
>=20
> -Dave.
> --=20
> Dave Chinner
> david@fromorbit.com
>=20

