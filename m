Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2425F145A8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 18:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgAVRFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 12:05:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25254 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbgAVRFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579712733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oe4t0QNMK4mSJlWW/e/SjvjgPQxAt3dHe+iY7Ns6joI=;
        b=QeBnOl9FFT8X5oltMpG2vFd1LI5tPq7yHcYAcQX+ZeueUi3z7fplVx3jHXJYctSD7RPDFe
        2UD3Sb56Me2YN4biYjuEBT6rJ9xo8vieBBgNNZCeiKA286muPIDoIZDLdUGPoMlRFiGt8q
        yymYXk9ew9mfje8I6aDWDcEJn1bk254=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-LQ1In6XsOFqesLEw3syA_w-1; Wed, 22 Jan 2020 12:05:30 -0500
X-MC-Unique: LQ1In6XsOFqesLEw3syA_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59F7B18B5F95;
        Wed, 22 Jan 2020 17:05:29 +0000 (UTC)
Received: from redhat.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 525198574F;
        Wed, 22 Jan 2020 17:05:26 +0000 (UTC)
Date:   Wed, 22 Jan 2020 09:02:25 -0800
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lsf-pc@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Do not pin pages for various
 direct-io scheme
Message-ID: <20200122170225.GB6009@redhat.com>
References: <20200122023100.75226-1-jglisse@redhat.com>
 <CAA9_cmfDKan60EnXCptAu9U6XgQgr5-MKfrENDNOSZYmQY9iRA@mail.gmail.com>
 <20200122050012.GD76712@redhat.com>
 <CAPcyv4hF-bagqZk-n_2QyvG5zE=5uSWJnbkDsfY3FYHT0+F6FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAPcyv4hF-bagqZk-n_2QyvG5zE=5uSWJnbkDsfY3FYHT0+F6FQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 07:56:50AM -0800, Dan Williams wrote:
> On Tue, Jan 21, 2020 at 9:04 PM Jerome Glisse <jglisse@redhat.com> wrot=
e:
> >
> > On Tue, Jan 21, 2020 at 08:19:54PM -0800, Dan Williams wrote:
> > > On Tue, Jan 21, 2020 at 6:34 PM <jglisse@redhat.com> wrote:
> > > >
> > > > From: J=E9r=F4me Glisse <jglisse@redhat.com>
> > > >
> > > > Direct I/O does pin memory through GUP (get user page) this does
> > > > block several mm activities like:
> > > >     - compaction
> > > >     - numa
> > > >     - migration
> > > >     ...
> > > >
> > > > It is also troublesome if the pinned pages are actualy file back
> > > > pages that migth go under writeback. In which case the page can
> > > > not be write protected from direct-io point of view (see various
> > > > discussion about recent work on GUP [1]). This does happens for
> > > > instance if the virtual memory address use as buffer for read
> > > > operation is the outcome of an mmap of a regular file.
> > > >
> > > >
> > > > With direct-io or aio (asynchronous io) pages are pinned until
> > > > syscall completion (which depends on many factors: io size,
> > > > block device speed, ...). For io-uring pages can be pinned an
> > > > indifinite amount of time.
> > > >
> > > >
> > > > So i would like to convert direct io code (direct-io, aio and
> > > > io-uring) to obey mmu notifier and thus allow memory management
> > > > and writeback to work and behave like any other process memory.
> > > >
> > > > For direct-io and aio this mostly gives a way to wait on syscall
> > > > completion. For io-uring this means that buffer might need to be
> > > > re-validated (ie looking up pages again to get the new set of
> > > > pages for the buffer). Impact for io-uring is the delay needed
> > > > to lookup new pages or wait on writeback (if necessary). This
> > > > would only happens _if_ an invalidation event happens, which it-
> > > > self should only happen under memory preissure or for NUMA
> > > > activities.
> > >
> > > This seems to assume that memory pressure and NUMA migration are ra=
re
> > > events. Some of the proposed hierarchical memory management schemes
> > > [1] might impact that assumption.
> > >
> > > [1]: http://lore.kernel.org/r/20191101075727.26683-1-ying.huang@int=
el.com/
> > >
> >
> > Yes, it is true that it will likely becomes more and more an issues.
> > We are facing a tough choice here as pining block NUMA or any kind of
> > migration and thus might impede performance while invalidating an io-
> > uring buffer will also cause a small latency burst. I do not think we
> > can make everyone happy but at very least we should avoid pining and
> > provide knobs to let user decide what they care more about (ie io wit=
h-
> > out burst or better NUMA locality).
>=20
> It's a question of tradeoffs and this proposal seems to have already
> decided that the question should be answered in favor a GPU/SVM
> centric view of the world without presenting the alternative.
> Direct-I/O colliding with GPU operations might also be solved by
> always triggering a migration, and applications that care would avoid
> colliding operations that slow down their GPU workload. A slow compat
> fallback that applications can programmatically avoid is more flexible
> than an upfront knob.

To make it clear i do not care about direct I/O colliding with anything
GPU or otherwise, anything like that is up to the application programmer.

My sole interest is with page pinning that block compaction and migration=
.
The former imped the kernel capability to materialize huge page, the
latter can impact performance badly including for the direct i/o user.
For instance if the process using io-uring get migrated to different node
after registering its buffer then it will keep using memory from a
different node which in the end might be much worse then the one time
extra latency spike the migration incur.

Cheers,
J=E9r=F4me

