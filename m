Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 759161027C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 16:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfKSPMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 10:12:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727836AbfKSPMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574176331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+AbGmVZAsgxtR8p0w2JArVCN5cmZvl+zRYfNpnj3bk=;
        b=VfC4qS/8GwGy4wTmWpQTHHrqy1X1qNuK1NKyhuoRrBvHHgWbO8np/SYjjw9yWCZBY/ZJUf
        Qzn6U7L74S9Wv48o0nsjkBwA0FCdTiC6rt27wCnVLmL+oQdZeTs0ughyRSndRqce9581ll
        uRSajzoUkNv3OmeuIGhjNMbmshR/3Gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-kBsFmQBxMi6_viXdcY9EYQ-1; Tue, 19 Nov 2019 10:12:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 093B5DBC8;
        Tue, 19 Nov 2019 15:12:06 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 69B2046E78;
        Tue, 19 Nov 2019 15:12:05 +0000 (UTC)
Date:   Tue, 19 Nov 2019 10:12:05 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/28] mm: directed shrinker work deferral
Message-ID: <20191119151205.GC10763@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-10-david@fromorbit.com>
 <20191104152525.GA10665@bfoster>
 <20191114204926.GC4614@dread.disaster.area>
 <20191115172140.GA55854@bfoster>
 <20191118004956.GR4614@dread.disaster.area>
MIME-Version: 1.0
In-Reply-To: <20191118004956.GR4614@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: kBsFmQBxMi6_viXdcY9EYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 18, 2019 at 11:49:56AM +1100, Dave Chinner wrote:
> On Fri, Nov 15, 2019 at 12:21:40PM -0500, Brian Foster wrote:
> > On Fri, Nov 15, 2019 at 07:49:26AM +1100, Dave Chinner wrote:
> > > On Mon, Nov 04, 2019 at 10:25:25AM -0500, Brian Foster wrote:
> > > > On Fri, Nov 01, 2019 at 10:45:59AM +1100, Dave Chinner wrote:
> > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > >=20
> > > > > Introduce a mechanism for ->count_objects() to indicate to the
> > > > > shrinker infrastructure that the reclaim context will not allow
> > > > > scanning work to be done and so the work it decides is necessary
> > > > > needs to be deferred.
> > > > >=20
> > > > > This simplifies the code by separating out the accounting of
> > > > > deferred work from the actual doing of the work, and allows bette=
r
> > > > > decisions to be made by the shrinekr control logic on what action=
 it
> > > > > can take.
> > > > >=20
> > > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > > ---
> > > >=20
> > > > My understanding from the previous discussion(s) is that this is no=
t
> > > > tied directly to the gfp mask because that is not the only intended=
 use.
> > > > While it is currently a boolean tied to the the entire shrinker cal=
l,
> > > > the longer term objective is per-object granularity.
> > >=20
> > > Longer term, yes, but right now such things are not possible as the
> > > shrinker needs more context to be able to make sane per-object
> > > decisions. shrinker policy decisions that affect the entire run
> > > scope should be handled by the ->count operation - it's the one that
> > > says whether the scan loop should run or not, and right now GFP_NOFS
> > > for all filesystem shrinkers is a pure boolean policy
> > > implementation.
> > >=20
> > > The next future step is to provide a superblock context with
> > > GFP_NOFS to indicate which filesystem we cannot recurse into. That
> > > is also a shrinker instance wide check, so again it's something that
> > > ->count should be deciding.
> > >=20
> > > i.e. ->count determines what is to be done, ->scan iterates the work
> > > that has to be done until we are done.
> > >=20
> >=20
> > Sure, makes sense in general.
> >=20
> > > > I find the argument reasonable enough, but if the above is true, wh=
y do
> > > > we move these checks from ->scan_objects() to ->count_objects() (in=
 the
> > > > next patch) when per-object decisions will ultimately need to be ma=
de by
> > > > the former?
> > >=20
> > > Because run/no-run policy belongs in one place, and things like
> > > GFP_NOFS do no change across calls to the ->scan loop. i.e. after
> > > the first ->scan call in a loop that calls it hundreds to thousands
> > > of times, the GFP_NOFS run/no-run check is completely redundant.
> > >=20
> >=20
> > What loop is currently called hundreds to thousands of times that this
> > change prevents? AFAICT the current nofs checks in the ->scan calls
> > explicitly terminate the scan loop.
>=20
> Right, but when we are in GFP_KERNEL context, every call to ->scan()
> checks it and says "ok". If we are scanning tens of thousands of
> objects in a scan, and we are using a befault batch size of 128
> objects per scan, then we have hundreds of calls in a single scan
> loop that check the GFP context and say "ok"....
>=20
> > So we're effectively saving a
> > function call by doing this earlier in the count ->call. (Nothing wrong
> > with that, I'm just not following the numbers used in this reasoning..)=
.
>=20
> It's the don't terminate case. :)
>=20

Oh, I see. You're talking about the number of executions of the gfp
check itself. That makes sense, though my understanding is that we'll
ultimately have a similar check anyways if we want per-object
granularity based on the allocation constraints of the current context.
OTOH, the check would still occur only once with an alloc flags field in
the shrinker structure too, FWIW.

> > > Once we introduce a new policy that allows the fs shrinker to do
> > > careful reclaim in GFP_NOFS conditions, we need to do substantial
> > > rework the shrinker scan loop and how it accounts the work that is
> > > done - we now have at least 3 or 4 different return counters
> > > (skipped because locked, skipped because referenced,
> > > reclaimed, deferred reclaim because couldn't lock/recursion) and
> > > the accounting and decisions to be made are a lot more complex.
> > >=20
> >=20
> > Yeah, that's generally what I expected from your previous description.
> >=20
> > > In that case, the ->count function will drop the GFP_NOFS check, but
> > > still do all the other things is needs to do. The GFP_NOFS check
> > > will go deep in the guts of the shrinker scan implementation where
> > > the per-object recursion problem exists. But for most shrinkers,
> > > it's still going to be a global boolean check...
> > >=20
> >=20
> > So once the nofs checks are lifted out of the ->count callback and into
> > the core shrinker, is there still a use case to defer an entire ->count
> > instance from the callback?
>=20
> Not right now. There may be in future, but I don't want to make
> things more complex than they need to be by trying to support
> functionality that isn't used.
>=20

Ok, but do note that the reason I ask is to touch on simply whether it's
worth putting this in the ->scan callback at all. It's not like _not_
doing that is some big complexity adjustment. ;)

> > > If people want to call avoiding repeated, unnecessary evaluation of
> > > the same condition hundreds of times instead of once "unnecessary
> > > churn", then I'll drop it.
> > >=20
> >=20
> > I'm not referring to the functional change as churn. What I was
> > referring to is that we're shuffling around the boilerplate gfp checkin=
g
> > code between the different shrinker callbacks, knowing that it's
> > eventually going to be lifted out, when we could potentially just lift
> > that code up a level now.
>=20
> I don't think that lifting it up will save much code at all, once we
> add all the gfp mask intialisation to all the shrinkers, etc. It's
> just means we can't look at the shrinker implementation and know
> that it can't run in GFP_NOFS context - we have to go look up
> where it is instantiated instead to see if there are gfp context
> constraints.
>=20
> I think it's better where it is, documenting the constraints the
> shrinker implementation runs under in the implementation itself...
>=20

Fair enough.. I don't necessarily agree that this is the best approach,
but the implementation is reasonable enough that I certainly don't
object to it (provided the fragility nits are addressed) and I don't
feel particularly tied to the suggested alternative. At the end of the
day this isn't a lot of code and it's not difficult to change (which it
probably will). I just wanted to make sure the alternative was fairly
considered and to test the reasoning for the approach a bit. I'll
move along from this topic on review of the next version...

Brian

> Cheers,
>=20
> Dave.
> --=20
> Dave Chinner
> david@fromorbit.com
>=20

