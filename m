Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65553105449
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 15:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKUOVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 09:21:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44465 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726858AbfKUOVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574346111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVraE8b3QU2la9dCpFpQy7WueZ49onoOqEPjcrKNVmw=;
        b=E18bbnSaVpf6rPnHVZ2m4/ZRkYN5VLcTEnb63VYzxEgmHSHCPObqbD+l86i2PB5HECDxTx
        8kyy+QC0OuTUeUXPNJMkYva7C7OrmuINCfcabLgzvDWBZ+ATJr2DYT5+sR5+hBR0/jRGy4
        P7fCWfDxPvO/jIBA6rPvaxPQ4lwl/Tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-P5I-E9HINPSIa9NDAMN7WA-1; Thu, 21 Nov 2019 09:21:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADE14801E7E;
        Thu, 21 Nov 2019 14:21:46 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F82C194B2;
        Thu, 21 Nov 2019 14:21:38 +0000 (UTC)
Date:   Thu, 21 Nov 2019 09:21:36 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191121142136.GB18443@pauld.bos.csb>
References: <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
 <20191121132937.GW4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20191121132937.GW4114@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: P5I-E9HINPSIa9NDAMN7WA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 02:29:37PM +0100 Peter Zijlstra wrote:
> On Wed, Nov 20, 2019 at 05:03:13PM -0500, Phil Auld wrote:
> > On Wed, Nov 20, 2019 at 08:16:36PM +0100 Peter Zijlstra wrote:
> > > On Tue, Nov 19, 2019 at 07:40:54AM +1100, Dave Chinner wrote:
>=20
> > > > Yes, that's precisely the problem - work is queued, by default, on =
a
> > > > specific CPU and it will wait for a kworker that is pinned to that
> > >=20
> > > I'm thinking the problem is that it doesn't wait. If it went and wait=
ed
> > > for it, active balance wouldn't be needed, that only works on active
> > > tasks.
> >=20
> > Since this is AIO I wonder if it should queue_work on a nearby cpu by=
=20
> > default instead of unbound. =20
>=20
> The thing seems to be that 'unbound' is in fact 'bound'. Maybe we should
> fix that. If the load-balancer were allowed to move the kworker around
> when it didn't get time to run, that would probably be a better
> solution.
>=20

Yeah, I'm not convinced this is actually a scheduler issue.


> Picking another 'bound' cpu by random might create the same sort of
> problems in more complicated scenarios.
>=20
> TJ, ISTR there used to be actually unbound kworkers, what happened to
> those? or am I misremembering things.
>=20
> > > Lastly,
> > > one other thing to try is -next. Vincent reworked the load-balancer
> > > quite a bit.
> > >=20
> >=20
> > I've tried it with the lb patch series. I get basically the same result=
s.
> > With the high granularity settings I get 3700 migrations for the 30=20
> > second run at 4k. Of those about 3200 are active balance on stock 5.4-r=
c7.
> > With the lb patches it's 3500 and 3000, a slight drop.=20
>=20
> Thanks for testing that. I didn't expect miracles, but it is good to
> verify.
>=20
> > Using the default granularity settings 50 and 22 for stock and 250 and =
25.
> > So a few more total migrations with the lb patches but about the same a=
ctive.
>=20
> Right, so the granularity thing interacts with the load-balance period.
> By pushing it up, as some people appear to do, makes it so that what
> might be a temporal imablance is perceived as a persitent imbalance.
>=20
> Tying the load-balance period to the gramularity is something we could
> consider, but then I'm sure, we'll get other people complaining the
> doesn't balance quick enough anymore.
>=20

Thanks. These are old tuned settings that have been carried along. They may
not be right for newer kernels anyway.=20


--=20

