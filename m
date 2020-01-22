Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92533145A67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 17:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAVQ5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 11:57:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20516 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgAVQ5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579712258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCuK9gG+XzyBqAKZyvtcNiJmI9iChL+W/5OmSfkPvfQ=;
        b=UJ/xYUyuL7HV+7uAN47JlFZh2jV6lu7xO4WN37ODW/BVPLB55dkzhiT9yE4rMRS7WyVhk+
        GFibRE0wydD1ZFsu2udqmDeSCq82lr1f3SDKUQ9/YXeOfdHdZdbNbf8rksz9G4+jQ/QYn5
        jGwpMS6hXZYI6kC930nD6lGhNteQBl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-OsP4GJsXNx-3zmg_d1TIBg-1; Wed, 22 Jan 2020 11:57:32 -0500
X-MC-Unique: OsP4GJsXNx-3zmg_d1TIBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45AB71088381;
        Wed, 22 Jan 2020 16:57:31 +0000 (UTC)
Received: from redhat.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38D5D8BE31;
        Wed, 22 Jan 2020 16:57:28 +0000 (UTC)
Date:   Wed, 22 Jan 2020 08:54:27 -0800
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michal Hocko <mhocko@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] Do not pin pages for various direct-io scheme
Message-ID: <20200122165427.GA6009@redhat.com>
References: <20200122023100.75226-1-jglisse@redhat.com>
 <ba250f19-cc51-f1dc-3236-58be1f291db3@kernel.dk>
 <20200122045723.GC76712@redhat.com>
 <20200122115926.GW29276@dhcp22.suse.cz>
 <015647b0-360c-c9ac-ac20-405ae0ec4512@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <015647b0-360c-c9ac-ac20-405ae0ec4512@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 08:12:51AM -0700, Jens Axboe wrote:
> On 1/22/20 4:59 AM, Michal Hocko wrote:
> > On Tue 21-01-20 20:57:23, Jerome Glisse wrote:
> >> We can also discuss what kind of knobs we want to expose so that
> >> people can decide to choose the tradeof themself (ie from i want low
> >> latency io-uring and i don't care wether mm can not do its business;=
 to
> >> i want mm to never be impeded in its business and i accept the extra
> >> latency burst i might face in io operations).
> >=20
> > I do not think it is a good idea to make this configurable. How can
> > people sensibly choose between the two without deep understanding of
> > internals?
>=20
> Fully agree, we can't just punt this to a knob and call it good, that's
> a typical fallacy of core changes. And there is only one mode for
> io_uring, and that's consistent low latency. If this change introduces
> weird reclaim, compaction or migration latencies, then that's a
> non-starter as far as I'm concerned.
>=20
> And what do those two settings even mean? I don't even know, and a user
> sure as hell doesn't either.
>=20
> io_uring pins two types of pages - registered buffers, these are used
> for actual IO, and the rings themselves. The rings are not used for IO,
> just used to communicate between the application and the kernel.

So, do we still want to solve file back pages write back if page in
ubuffer are from a file ?

Also we can introduce a flag when registering buffer that allows to
register buffer without pining and thus avoid the RLIMIT_MEMLOCK at
the cost of possible latency spike. Then user registering the buffer
knows what he gets.

Maybe it would be good to test, it might stay in the noise, then it
might be a good thing to do. Also they are strategy to avoid latency
spike for instance we can block/force skip mm invalidation if buffer
has pending/running io in the ring ie only have buffer invalidation
happens when there is no pending/running submission entry.

We can also pick what kind of invalidation we allow (compaction,
migration, ...) and thus limit the scope and likelyhood of
invalidation.

Cheers,
J=E9r=F4me

