Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30159112CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 14:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfLDNux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 08:50:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22849 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727792AbfLDNuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575467452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VA9lOoBJgqCxzPUvXrp+l1oPS8XjH4P1e6jO6rnjjg8=;
        b=OJ7sCRzpAFHmkmjvScZK+ZWJJayWKCrEtho6ALh87721wwgjnz93ZSucLusj5PU/zu65xb
        EUCUbCg4gGZNkTGXbtaive6QysHfLVQSN2jy9eARPF37aozuoW5+jy9CyxCjHRnaGehoq/
        UN/SeTipLbR6nVPB0fX20jIj4n9stdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-sTXKKfdVOFaPo2t4eAi-uw-1; Wed, 04 Dec 2019 08:50:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2144D91206;
        Wed,  4 Dec 2019 13:50:47 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C826E19C68;
        Wed,  4 Dec 2019 13:50:32 +0000 (UTC)
Date:   Wed, 4 Dec 2019 21:50:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Phil Auld <pauld@redhat.com>, Dave Chinner <david@fromorbit.com>,
        Hillf Danton <hdanton@sina.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Rong Chen <rong.a.chen@intel.com>, Tejun Heo <tj@kernel.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191204135014.GA21449@ming.t460p>
References: <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191128094003.752-1-hdanton@sina.com>
 <CAKfTPtA23ErKGCEJVmg6vk-QoufkiUM3NbXd31mZmKnuwbTkFw@mail.gmail.com>
 <20191202024625.GD24512@ming.t460p>
 <20191202040256.GE2695@dread.disaster.area>
 <CAKfTPtD8Q97qJ_+hdCXQRt=gy7k96XrhnFmGYP1G88YSFW0vNA@mail.gmail.com>
 <20191202212210.GA32767@lorien.usersys.redhat.com>
 <CAKfTPtC7uycC3b2ngOFUqOh9-Fcz7h-151aaYJbLJFXrNq-gkw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKfTPtC7uycC3b2ngOFUqOh9-Fcz7h-151aaYJbLJFXrNq-gkw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: sTXKKfdVOFaPo2t4eAi-uw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:45:38AM +0100, Vincent Guittot wrote:
> On Mon, 2 Dec 2019 at 22:22, Phil Auld <pauld@redhat.com> wrote:
> >
> > Hi Vincent,
> >
> > On Mon, Dec 02, 2019 at 02:45:42PM +0100 Vincent Guittot wrote:
> > > On Mon, 2 Dec 2019 at 05:02, Dave Chinner <david@fromorbit.com> wrote=
:
> >
> > ...
> >
> > > > So, we can fiddle with workqueues, but it doesn't address the
> > > > underlying issue that the scheduler appears to be migrating
> > > > non-bound tasks off a busy CPU too easily....
> > >
> > > The root cause of the problem is that the sched_wakeup_granularity_ns
> > > is in the same range or higher than load balance period. As Peter
> > > explained, This make the kworker waiting for the CPU for several load
> > > period and a transient unbalanced state becomes a stable one that the
> > > scheduler to fix. With default value, the scheduler doesn't try to
> > > migrate any task.
> >
> > There are actually two issues here.   With the high wakeup granularity
> > we get the user task actively migrated. This causes the significant
> > performance hit Ming was showing. With the fast wakeup_granularity
> > (or smaller IOs - 512 instead of 4k) we get, instead, the user task
> > migrated at wakeup to a new CPU for every IO completion.
>=20
> Ok, I haven't noticed that this one was a problem too. Do we have perf
> regression ?

Follows the test result on one server(Dell, R630: Haswell-E):

kernel.sched_wakeup_granularity_ns =3D 4000000
kernel.sched_min_granularity_ns =3D 3000000

---------------------------------------
test              =09=09        | IOPS
---------------------------------------
./xfs_complete 512      =09    | 7.8K=20
---------------------------------------
taskset -c 8 ./xfs_complete 512 | 9.8K=20
---------------------------------------

Thanks,
Ming

