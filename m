Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74591FEAF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2019 07:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfKPGbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Nov 2019 01:31:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57457 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725776AbfKPGbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Nov 2019 01:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573885893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=URLGBy0jbWCpZ5Oji1iU0vanCkzWQRPQdGmQYj3K+G0=;
        b=HdYDGqRXAPSA4WTYlJSAyEWrr/x9LdYB36zjNhzOCpVGv7PEuOLfl/BcLVQ962FvKQdi6L
        Mqj4ZIWPMwYgEZowhLNCisI3W+S0CtAMDSTauvEg7UMPNoKrx/wJLqJAr9rUImxZjBf1NU
        zkPo3wXDGO9mAb4eN25RDpSLU9dLeK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-oMPLbFuQNrWyZmNUOJNcOA-1; Sat, 16 Nov 2019 01:31:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B82011005500;
        Sat, 16 Nov 2019 06:31:29 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AF54608D8;
        Sat, 16 Nov 2019 06:31:12 +0000 (UTC)
Date:   Sat, 16 Nov 2019 14:31:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191116063106.GA18194@ming.t460p>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
MIME-Version: 1.0
In-Reply-To: <20191115234005.GO4614@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: oMPLbFuQNrWyZmNUOJNcOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 16, 2019 at 10:40:05AM +1100, Dave Chinner wrote:
> On Fri, Nov 15, 2019 at 03:08:43PM +0800, Ming Lei wrote:
> > On Fri, Nov 15, 2019 at 03:56:34PM +1100, Dave Chinner wrote:
> > > On Fri, Nov 15, 2019 at 09:08:24AM +0800, Ming Lei wrote:
> > I can reproduce the issue with 4k block size on another RH system, and
> > the login info of that system has been shared to you in RH BZ.
> >=20
> > 1)
> > sysctl kernel.sched_min_granularity_ns=3D10000000
> > sysctl kernel.sched_wakeup_granularity_ns=3D15000000
>=20
> So, these settings definitely influence behaviour.
>=20
> If these are set to kernel defaults (4ms and 3ms each):
>=20
> sysctl kernel.sched_min_granularity_ns=3D4000000
> sysctl kernel.sched_wakeup_granularity_ns=3D3000000
>=20
> The migration problem largely goes away - the fio task migration
> event count goes from ~2,000 a run down to 200/run.
>=20
> That indicates that the migration trigger is likely load/timing
> based. The analysis below is based on the 10/15ms numbers above,
> because it makes it so much easier to reproduce.

On another machine, './xfs_complete 512' may be migrated 11~12K/sec,
which don't need to change the above two kernel sched defaults, however
the fio io thread only takes 40% CPU.=20

'./xfs_complete 4k' on this machine, the fio IO CPU utilization is >=3D 98%=
.


Thanks,
Ming

