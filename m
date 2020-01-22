Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84E9145ADA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 18:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAVRbw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 12:31:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42854 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725883AbgAVRbw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579714311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9luKUaLxFsNSaPPjB3hX0WI9WZ1yf7PFSPyMLj1vi9E=;
        b=YBXLOnO56dyrVbvdQdGK1PLq+9OebYjQ5CGp6ubavutPNXEHFJpMokwowo/Fl/ZJHB4oJ2
        5hPRXaJZ1L78GOcAB+aK3rq3HbWnKzKpeg/YMjo1vGXg0CsF8Dz/MbZt1vKcqFS+MuwY4R
        fNXilJi43vbEa7Y1+TPTs+9VxTIDOhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-CWdoUYaMPrOmVe60celhow-1; Wed, 22 Jan 2020 12:31:47 -0500
X-MC-Unique: CWdoUYaMPrOmVe60celhow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A76F8C2091;
        Wed, 22 Jan 2020 17:31:46 +0000 (UTC)
Received: from redhat.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B7C95C1BB;
        Wed, 22 Jan 2020 17:31:44 +0000 (UTC)
Date:   Wed, 22 Jan 2020 09:28:42 -0800
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michal Hocko <mhocko@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] Do not pin pages for various direct-io scheme
Message-ID: <20200122172842.GC6009@redhat.com>
References: <20200122023100.75226-1-jglisse@redhat.com>
 <ba250f19-cc51-f1dc-3236-58be1f291db3@kernel.dk>
 <20200122045723.GC76712@redhat.com>
 <20200122115926.GW29276@dhcp22.suse.cz>
 <015647b0-360c-c9ac-ac20-405ae0ec4512@kernel.dk>
 <20200122165427.GA6009@redhat.com>
 <66027259-81c3-0bc4-a70b-74069e746058@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <66027259-81c3-0bc4-a70b-74069e746058@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 10:04:44AM -0700, Jens Axboe wrote:
> On 1/22/20 9:54 AM, Jerome Glisse wrote:
> > On Wed, Jan 22, 2020 at 08:12:51AM -0700, Jens Axboe wrote:
> >> On 1/22/20 4:59 AM, Michal Hocko wrote:
> >>> On Tue 21-01-20 20:57:23, Jerome Glisse wrote:
> >>>> We can also discuss what kind of knobs we want to expose so that
> >>>> people can decide to choose the tradeof themself (ie from i want l=
ow
> >>>> latency io-uring and i don't care wether mm can not do its busines=
s; to
> >>>> i want mm to never be impeded in its business and i accept the ext=
ra
> >>>> latency burst i might face in io operations).
> >>>
> >>> I do not think it is a good idea to make this configurable. How can
> >>> people sensibly choose between the two without deep understanding o=
f
> >>> internals?
> >>
> >> Fully agree, we can't just punt this to a knob and call it good, tha=
t's
> >> a typical fallacy of core changes. And there is only one mode for
> >> io_uring, and that's consistent low latency. If this change introduc=
es
> >> weird reclaim, compaction or migration latencies, then that's a
> >> non-starter as far as I'm concerned.
> >>
> >> And what do those two settings even mean? I don't even know, and a u=
ser
> >> sure as hell doesn't either.
> >>
> >> io_uring pins two types of pages - registered buffers, these are use=
d
> >> for actual IO, and the rings themselves. The rings are not used for =
IO,
> >> just used to communicate between the application and the kernel.
> >=20
> > So, do we still want to solve file back pages write back if page in
> > ubuffer are from a file ?
>=20
> That's not currently a concern for io_uring, as it disallows file backe=
d
> pages for the IO buffers that are being registered.
>=20
> > Also we can introduce a flag when registering buffer that allows to
> > register buffer without pining and thus avoid the RLIMIT_MEMLOCK at
> > the cost of possible latency spike. Then user registering the buffer
> > knows what he gets.
>=20
> That may be fine for others users, but I don't think it'll apply
> to io_uring. I can't see anyone selecting that flag, unless you're
> doing something funky where you're registering a substantial amount
> of the system memory for IO buffers. And I don't think that's going
> to be a super valid use case...

Given dataset are getting bigger and bigger i would assume that we
will have people who want to use io-uring with large buffer.

>=20
> > Maybe it would be good to test, it might stay in the noise, then it
> > might be a good thing to do. Also they are strategy to avoid latency
> > spike for instance we can block/force skip mm invalidation if buffer
> > has pending/running io in the ring ie only have buffer invalidation
> > happens when there is no pending/running submission entry.
>=20
> Would that really work? The buffer could very well be idle right when
> you check, but wanting to do IO the instant you decide you can do
> background work on it. Additionally, that would require accounting
> on when the buffers are inflight, which is exactly the kind of
> overhead we're trying to avoid to begin with.
>=20
> > We can also pick what kind of invalidation we allow (compaction,
> > migration, ...) and thus limit the scope and likelyhood of
> > invalidation.
>=20
> I think it'd be useful to try and understand the use case first.
> If we're pinning a small percentage of the system memory, do we
> really care at all? Isn't it completely fine to just ignore?

My main motivation is migration in NUMA system, if the process that
did register buffer get migrated to a different node then it might
actualy end up with bad performance because its io buffer are still
on hold node. I am not sure we want to tell application developer to
constantly monitor which node they are on and to re-register buffer
after process migration to allow for memory migration.

Cheers,
J=E9r=F4me

