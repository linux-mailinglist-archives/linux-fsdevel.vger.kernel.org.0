Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D0E144B00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 06:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgAVFDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 00:03:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27964 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgAVFDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 00:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579669401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vmnf6QnPcWOKp/vAu1y0VXuL8Dng+G59Afl5nsQ53+s=;
        b=aQKNX5xmSAojxdNjLl/aaiqzMuICWFELjOi3Jmoem+VTsVVhT7H11DwQmdxMT0uniNq6yt
        F3EfTX9IsmcqwrQYwVq77egw5chRWcwa0nuqD5NWBHkeqcOHYRqDfAMXv8iq5GRZEWXCBi
        GtaOkwb2CBsbmhN/xCWa0bo5pIO0zHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-x7OtU8-3PFK2tODIShfu0g-1; Wed, 22 Jan 2020 00:03:17 -0500
X-MC-Unique: x7OtU8-3PFK2tODIShfu0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5888DB20;
        Wed, 22 Jan 2020 05:03:15 +0000 (UTC)
Received: from redhat.com (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4E2228989;
        Wed, 22 Jan 2020 05:03:13 +0000 (UTC)
Date:   Tue, 21 Jan 2020 21:00:12 -0800
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] Do not pin pages for various direct-io scheme
Message-ID: <20200122050012.GD76712@redhat.com>
References: <20200122023100.75226-1-jglisse@redhat.com>
 <CAA9_cmfDKan60EnXCptAu9U6XgQgr5-MKfrENDNOSZYmQY9iRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAA9_cmfDKan60EnXCptAu9U6XgQgr5-MKfrENDNOSZYmQY9iRA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 08:19:54PM -0800, Dan Williams wrote:
> On Tue, Jan 21, 2020 at 6:34 PM <jglisse@redhat.com> wrote:
> >
> > From: J=E9r=F4me Glisse <jglisse@redhat.com>
> >
> > Direct I/O does pin memory through GUP (get user page) this does
> > block several mm activities like:
> >     - compaction
> >     - numa
> >     - migration
> >     ...
> >
> > It is also troublesome if the pinned pages are actualy file back
> > pages that migth go under writeback. In which case the page can
> > not be write protected from direct-io point of view (see various
> > discussion about recent work on GUP [1]). This does happens for
> > instance if the virtual memory address use as buffer for read
> > operation is the outcome of an mmap of a regular file.
> >
> >
> > With direct-io or aio (asynchronous io) pages are pinned until
> > syscall completion (which depends on many factors: io size,
> > block device speed, ...). For io-uring pages can be pinned an
> > indifinite amount of time.
> >
> >
> > So i would like to convert direct io code (direct-io, aio and
> > io-uring) to obey mmu notifier and thus allow memory management
> > and writeback to work and behave like any other process memory.
> >
> > For direct-io and aio this mostly gives a way to wait on syscall
> > completion. For io-uring this means that buffer might need to be
> > re-validated (ie looking up pages again to get the new set of
> > pages for the buffer). Impact for io-uring is the delay needed
> > to lookup new pages or wait on writeback (if necessary). This
> > would only happens _if_ an invalidation event happens, which it-
> > self should only happen under memory preissure or for NUMA
> > activities.
>=20
> This seems to assume that memory pressure and NUMA migration are rare
> events. Some of the proposed hierarchical memory management schemes
> [1] might impact that assumption.
>=20
> [1]: http://lore.kernel.org/r/20191101075727.26683-1-ying.huang@intel.c=
om/
>=20

Yes, it is true that it will likely becomes more and more an issues.
We are facing a tough choice here as pining block NUMA or any kind of
migration and thus might impede performance while invalidating an io-
uring buffer will also cause a small latency burst. I do not think we
can make everyone happy but at very least we should avoid pining and
provide knobs to let user decide what they care more about (ie io with-
out burst or better NUMA locality).

Cheers,
J=E9r=F4me

