Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83840FE3D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 18:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfKORXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 12:23:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23936 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727590AbfKORXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573838589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06kWqtx/26ngJrjOCfJyg6Cce2N2bE9JwILxSi+bOAI=;
        b=gsOlK5F4ZYM3jqsry1S84abcxsIMy4ejIk2RAwysVOvQMHEOd5uHV0QQvTcnMuO1y7FNDT
        jBoskBg7CGvklCzRDTYqEpd1clSUfQqkeJyzm0tTTRxudkN04XZErkIKWecGxbopkK3vb1
        DTkjN+g5bG7UyZQHKQKWa3mTQU9g2CA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-R4y48ZzWOkGEjZwVb4saJQ-1; Fri, 15 Nov 2019 12:23:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1D171083E80;
        Fri, 15 Nov 2019 17:23:03 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DC0828DDE;
        Fri, 15 Nov 2019 17:23:02 +0000 (UTC)
Date:   Fri, 15 Nov 2019 12:23:01 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/28] shrinker: defer work only to kswapd
Message-ID: <20191115172301.GB55854@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-13-david@fromorbit.com>
 <20191104152954.GC10665@bfoster>
 <20191114211150.GE4614@dread.disaster.area>
MIME-Version: 1.0
In-Reply-To: <20191114211150.GE4614@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: R4y48ZzWOkGEjZwVb4saJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 08:11:50AM +1100, Dave Chinner wrote:
> On Mon, Nov 04, 2019 at 10:29:54AM -0500, Brian Foster wrote:
> > On Fri, Nov 01, 2019 at 10:46:02AM +1100, Dave Chinner wrote:
> > > @@ -601,10 +605,10 @@ static unsigned long do_shrink_slab(struct shri=
nk_control *shrinkctl,
> > >  =09 * scanning at high prio and therefore should try to reclaim as m=
uch as
> > >  =09 * possible.
> > >  =09 */
> > > -=09while (total_scan >=3D batch_size ||
> > > -=09       total_scan >=3D freeable_objects) {
> > > +=09while (scan_count >=3D batch_size ||
> > > +=09       scan_count >=3D freeable_objects) {
> > >  =09=09unsigned long ret;
> > > -=09=09unsigned long nr_to_scan =3D min(batch_size, total_scan);
> > > +=09=09unsigned long nr_to_scan =3D min_t(long, batch_size, scan_coun=
t);
> > > =20
> > >  =09=09shrinkctl->nr_to_scan =3D nr_to_scan;
> > >  =09=09shrinkctl->nr_scanned =3D nr_to_scan;
> > > @@ -614,29 +618,29 @@ static unsigned long do_shrink_slab(struct shri=
nk_control *shrinkctl,
> > >  =09=09freed +=3D ret;
> > > =20
> > >  =09=09count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
> > > -=09=09total_scan -=3D shrinkctl->nr_scanned;
> > > -=09=09scanned +=3D shrinkctl->nr_scanned;
> > > +=09=09scan_count -=3D shrinkctl->nr_scanned;
> > > +=09=09scanned_objects +=3D shrinkctl->nr_scanned;
> > > =20
> > >  =09=09cond_resched();
> > >  =09}
> > > -
> > >  done:
> > > -=09if (next_deferred >=3D scanned)
> > > -=09=09next_deferred -=3D scanned;
> > > +=09if (deferred_count)
> > > +=09=09next_deferred =3D deferred_count - scanned_objects;
> > >  =09else
> > > -=09=09next_deferred =3D 0;
> > > +=09=09next_deferred =3D scan_count;
> >=20
> > Hmm.. so if there was no deferred count on this cycle, we set
> > next_deferred to whatever is left from scan_count and add that back int=
o
> > the shrinker struct below. If there was a pending deferred count on thi=
s
> > cycle, we subtract what we scanned from that and add that value back.
> > But what happens to the remaining scan_count in the latter case? Is it
> > lost, or am I missing something?
>=20
> if deferred_count is not zero, then it is kswapd that is running. It
> does the deferred work, and if it doesn't make progress then adding
> it's scan count to the deferred work doesn't matter. That's because
> it will come back with an increased priority in a short while and
> try to scan more of the deferred count plus it's larger scan count.
>=20

Ok, so perhaps there is no functional reason to defer remaining scan
count from a context (i.e. kswapd) that attempts to process deferred
work...

> IOWs, if we defer kswapd unused scan count, we effectively increase
> the pressure as the priority goes up, potentially making the
> deferred count increase out of control. i.e. kswapd can make
> progress and free items, but the result is that it increased the
> deferred scan count rather than reducing it. This leads to excessive
> reclaim of the slab caches and kswapd can trash the caches long
> after the memory pressure has gone away...
>=20

... yet if kswapd runs without pre-existing deferred work, that's
precisely what it does. next_deferred is set to remaining scan_count and
that is added back to the shrinker struct. So should kswapd generally
defer work or not? If the answer is sometimes, then please add a comment
to the next_deferred assignment to explain when/why.

> > For example, suppose we start this cycle with a large scan_count and
> > ->scan_objects() returned SHRINK_STOP before doing much work. In that
> > scenario, it looks like whether ->nr_deferred is 0 or not is the only
> > thing that determines whether we defer the entire remaining scan_count
> > or just what is left from the previous ->nr_deferred. The existing code
> > appears to consistently factor in what is left from the current scan
> > with the previous deferred count. Hm?
>=20
> If kswapd doesn't have any deferred work, then it's largely no
> different in behaviour to direct reclaim. If it has no deferred
> work, then the shrinker is not getting stopped early in direct
> reclaim, so it's unlikely that kswapd is going to get stopped early,
> either....
>=20

Then perhaps the logic could be simplified to explicitly not defer from
kswapd..?

Brian

> Cheers,
>=20
> Dave.
> --=20
> Dave Chinner
> david@fromorbit.com
>=20

