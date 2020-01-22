Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A53144AFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 06:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgAVFAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 00:00:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47756 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgAVFAg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 00:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579669235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEP7wrbjoXwu0qHE8NmNcH/k62ooGTg08bTbEkjKjKU=;
        b=HVkuGLfBc0ooHjJyQRQNUKnTEFRO+7l43sk/iHc4gYnWuzk8DolcZSmUHUEIsk3vNypRWY
        kkybeM4AY8frYNGbByL3d/ebZJgdG0wA59+VpvmU2Y7NIYJFwoSFta0Tv8yPhLtxG9gjZY
        l6d9DDrDsrsycwxuAkVNPrck84N1QGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-jOu98z4JPEOCJ7hQ72Lr7Q-1; Wed, 22 Jan 2020 00:00:28 -0500
X-MC-Unique: jOu98z4JPEOCJ7hQ72Lr7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4433C8010D0;
        Wed, 22 Jan 2020 05:00:27 +0000 (UTC)
Received: from redhat.com (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E6548BE3F;
        Wed, 22 Jan 2020 05:00:25 +0000 (UTC)
Date:   Tue, 21 Jan 2020 20:57:23 -0800
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] Do not pin pages for various direct-io scheme
Message-ID: <20200122045723.GC76712@redhat.com>
References: <20200122023100.75226-1-jglisse@redhat.com>
 <ba250f19-cc51-f1dc-3236-58be1f291db3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ba250f19-cc51-f1dc-3236-58be1f291db3@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 08:54:22PM -0700, Jens Axboe wrote:
> On 1/21/20 7:31 PM, jglisse@redhat.com wrote:
> > From: J=E9r=F4me Glisse <jglisse@redhat.com>
> >=20
> > Direct I/O does pin memory through GUP (get user page) this does
> > block several mm activities like:
> >     - compaction
> >     - numa
> >     - migration
> >     ...
> >=20
> > It is also troublesome if the pinned pages are actualy file back
> > pages that migth go under writeback. In which case the page can
> > not be write protected from direct-io point of view (see various
> > discussion about recent work on GUP [1]). This does happens for
> > instance if the virtual memory address use as buffer for read
> > operation is the outcome of an mmap of a regular file.
> >=20
> >=20
> > With direct-io or aio (asynchronous io) pages are pinned until
> > syscall completion (which depends on many factors: io size,
> > block device speed, ...). For io-uring pages can be pinned an
> > indifinite amount of time.
> >=20
> >=20
> > So i would like to convert direct io code (direct-io, aio and
> > io-uring) to obey mmu notifier and thus allow memory management
> > and writeback to work and behave like any other process memory.
> >=20
> > For direct-io and aio this mostly gives a way to wait on syscall
> > completion. For io-uring this means that buffer might need to be
> > re-validated (ie looking up pages again to get the new set of
> > pages for the buffer). Impact for io-uring is the delay needed
> > to lookup new pages or wait on writeback (if necessary). This
> > would only happens _if_ an invalidation event happens, which it-
> > self should only happen under memory preissure or for NUMA
> > activities.
> >=20
> > They are ways to minimize the impact (for instance by using the
> > mmu notifier type to ignore some invalidation cases).
> >=20
> >=20
> > So i would like to discuss all this during LSF, it is mostly a
> > filesystem discussion with strong tie to mm.
>=20
> I'd be interested in this topic, as it pertains to io_uring. The whole
> point of registered buffers is to avoid mapping overhead, and page
> references. If we add extra overhead per operation for that, well... I'=
m
> assuming the above is strictly for file mapped pages? Or also page
> migration?

File back page and anonymous, the idea is that we have choice on what
to do, ie favor io-uring and make it last resort for mm to mess with a
page that is GUPed or we could favor mm (compaction, NUMA, reclaim,
...). We can also discuss what kind of knobs we want to expose so that
people can decide to choose the tradeof themself (ie from i want low
latency io-uring and i don't care wether mm can not do its business; to
i want mm to never be impeded in its business and i accept the extra
latency burst i might face in io operations).

One of the issue with io-uring AFAICT is that today someone could
potentialy pin pages that are never actualy use by direct io and thus
potential DDOS or mm starve others.

Cheers,
J=E9r=F4me

