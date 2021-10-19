Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677FC434040
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 23:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhJSVQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 17:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229602AbhJSVQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634678057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eGX3DkPpYpGXRrwMUxctHGFJQDGfHUM6kkQDDtznVBE=;
        b=ChZL+N9rO2bYBGDm1iouMJZ7LknI1j3bV4dk/cDbokocPri+2iyz5abECt0Avjyh+L2l+v
        RLELbaPuTlP95HPQRMOjzi6RTw0faSvrBNoQzP6IwWxZiB05cVtcQm4uNDMaixBmxGfYiy
        mPf5nNX4XZPSIGq3Icpe9Pzb1s5br9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-92i0sIO5MJOtLLx1fbgWHg-1; Tue, 19 Oct 2021 17:14:14 -0400
X-MC-Unique: 92i0sIO5MJOtLLx1fbgWHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5036A80A5C0;
        Tue, 19 Oct 2021 21:14:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BE0162AEE;
        Tue, 19 Oct 2021 21:14:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YW7uN2p8CihCDsln@moria.home.lan>
References: <YW7uN2p8CihCDsln@moria.home.lan> <YUfvK3h8w+MmirDF@casper.infradead.org> <YUo20TzAlqz8Tceg@cmpxchg.org> <YUpC3oV4II+u+lzQ@casper.infradead.org> <YUpKbWDYqRB6eBV+@moria.home.lan> <YUpNLtlbNwdjTko0@moria.home.lan> <YUtHCle/giwHvLN1@cmpxchg.org> <YWpG1xlPbm7Jpf2b@casper.infradead.org> <YW2lKcqwBZGDCz6T@cmpxchg.org> <YW25EDqynlKU14hx@moria.home.lan> <YW3dByBWM0dSRw/X@cmpxchg.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     dhowells@redhat.com, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Splitting struct page into multiple types - Was: re: Folio discussion recap -
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2981361.1634678044.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 19 Oct 2021 22:14:04 +0100
Message-ID: <2981362.1634678044@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kent Overstreet <kent.overstreet@gmail.com> wrote:

> =

>  - page->lru is used by the old .readpages interface for the list of pag=
es we're
>    doing reads to; Matthew converted most filesystems to his new and imp=
roved
>    .readahead which thankfully no longer uses page->lru, but there's sti=
ll a few
>    filesystems that need to be converted - it looks like cifs and erofs,=
 not
>    sure what's going on with fs/cachefiles/. We need help from the maint=
ainers
>    of those filesystems to get that conversion done, this is holding up =
future
>    cleanups.

fscache and cachefiles should be taken care of by my patchset here:

	https://lore.kernel.org/r/163363935000.1980952.15279841414072653108.stgit=
@warthog.procyon.org.uk
	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dfscache-remove-old-io

With that 9p, afs and ceph use netfs lib to handle readpage, readahead and
part of write_begin.

nfs and cifs do their own wrangling of readpages/readahead, but will call =
out
to the cache directly to handle each page individually.  At some point, ci=
fs
will hopefully be converted to use netfs lib.

David

