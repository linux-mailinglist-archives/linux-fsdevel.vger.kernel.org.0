Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DF9105409
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 15:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKUOM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 09:12:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60862 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726719AbfKUOMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574345544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDwJ/jJ372BrVR0P0VcF5vd7qMAwSsydtsAUBf3ZVoA=;
        b=VrWSc8k28eCOgWWWs+58Mf3i4ZaHJRPTCgRm9jOCur/VBZrMEGmNi1LFa2FvJB78WJDl4/
        DnTwweEGKr62w4k6Q+ALo4nAKNuHzAGhAcVqD4CRZkP4pvMghb3/NTjPgEFlMogcJ1SXQl
        tt7klSeG0dJ4g58Cp0BuzFn7L9WaP38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-d5XFD52QP8eoROOPRCjHSQ-1; Thu, 21 Nov 2019 09:12:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B26518B9FC2;
        Thu, 21 Nov 2019 14:12:18 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E6D2537B8;
        Thu, 21 Nov 2019 14:12:09 +0000 (UTC)
Date:   Thu, 21 Nov 2019 09:12:07 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191121141207.GA18443@pauld.bos.csb>
References: <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
 <20191121041218.GK24548@ming.t460p>
MIME-Version: 1.0
In-Reply-To: <20191121041218.GK24548@ming.t460p>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: d5XFD52QP8eoROOPRCjHSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 12:12:18PM +0800 Ming Lei wrote:
> On Wed, Nov 20, 2019 at 05:03:13PM -0500, Phil Auld wrote:
> > Hi Peter,
> >=20
> > On Wed, Nov 20, 2019 at 08:16:36PM +0100 Peter Zijlstra wrote:
> > > On Tue, Nov 19, 2019 at 07:40:54AM +1100, Dave Chinner wrote:
> > > > On Mon, Nov 18, 2019 at 10:21:21AM +0100, Peter Zijlstra wrote:
> > >=20
> > > > > We typically only fall back to the active balancer when there is
> > > > > (persistent) imbalance and we fail to migrate anything else (of
> > > > > substance).
> > > > >=20
> > > > > The tuning mentioned has the effect of less frequent scheduling, =
IOW,
> > > > > leaving (short) tasks on the runqueue longer. This obviously mean=
s the
> > > > > load-balancer will have a bigger chance of seeing them.
> > > > >=20
> > > > > Now; it's been a while since I looked at the workqueue code but o=
ne
> > > > > possible explanation would be if the kworker that picks up the wo=
rk item
> > > > > is pinned. That would make it runnable but not migratable, the ex=
act
> > > > > situation in which we'll end up shooting the current task with ac=
tive
> > > > > balance.
> > > >=20
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
> When the current CPU isn't busy enough, there is still cost for completin=
g
> request remotely.
>=20
> Or could we change queue_work() in the following way?
>=20
>  * We try to queue the work to the CPU on which it was submitted, but if =
the
>  * CPU dies or is saturated enough it can be processed by another CPU.
>=20
> Can we decide in a simple or efficient way if the current CPU is saturate=
d
> enough?
>=20

The scheduler doesn't know if the queued_work submitter is going to go to s=
leep.
That's why I was singling out AIO. My understanding of it is that you submi=
t the IO
and then keep going. So in that case it might be better to pick a node-loca=
l nearby
cpu instead. But this is a user of work queue issue not a scheduler issue.=
=20

Interestingly in our fio case the 4k one does not sleep and we get the acti=
ve balance
case where it moves the actually running thread.  The 512 byte case seems t=
o be=20
sleeping since the migrations are all at wakeup time I believe.=20

Cheers,
Phil


> Thanks,
> Ming

--=20

