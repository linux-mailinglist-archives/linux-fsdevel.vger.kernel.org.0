Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA2033EEE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 11:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhCQKyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 06:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230159AbhCQKxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615978430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrP2lfrrdq12nJd/eCkP5MvOV60FCODOOLwLlbcHJdc=;
        b=BXgd9mFEKFsNVzraqleu/LAUXDgwd35VgXYK4Qxm1rLofSc1fFY+MZJI5Gh/ev2gh2Nyle
        /o/8ma8oVffjRKKn1ERgWjpjQVp9GECc9g1w40p1woBs+3u8aZavh4D6s+Hgd1o4k+agti
        qaay9OMm2uk6gWgK7WsosFr/gvsjb90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-YK1MK1d2OtGgyArc0_7DAQ-1; Wed, 17 Mar 2021 06:53:49 -0400
X-MC-Unique: YK1MK1d2OtGgyArc0_7DAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B60C84BA43;
        Wed, 17 Mar 2021 10:53:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-138.rdu2.redhat.com [10.10.113.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D8CE6C32F;
        Wed, 17 Mar 2021 10:53:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <31382.1615971849@warthog.procyon.org.uk>
References: <31382.1615971849@warthog.procyon.org.uk> <CAHk-=whWoJhGeMn85LOh9FX-5d2-Upzmv1m2ZmYxvD31TKpUTA@mail.gmail.com> <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk> <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk> <20210316190707.GD3420@casper.infradead.org> <CAHk-=wjSGsRj7xwhSMQ6dAQiz53xA39pOG+XA_WeTgwBBu4uqg@mail.gmail.com> <887b9eb7-2764-3659-d0bf-6a034a031618@toxicpanda.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/28] mm: Add an unlock function for PG_private_2/PG_fscache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38367.1615978421.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 17 Mar 2021 10:53:41 +0000
Message-ID: <38368.1615978421@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

>  (1) For the old fscache code that I'm trying to phase out, it does not =
take a
>      ref when PG_fscache is taken (probably incorrectly), relying instea=
d on
>      releasepage, etc. getting called to strip the PG_fscache bit.  PG_f=
scache
>      is held for the lifetime of the page, indicating that fscache knows=
 about
>      it and might access it at any time (to write to the cache in the
>      background for example or to move pages around in the cache).
> =

>      Here PG_fscache should not prevent page eviction or migration and i=
t's
>      analogous to PG_private.
> =

>      That said, the old fscache code keeps its own radix trees of pages =
that
>      are undergoing write to the cache, so to allow a page to be evicted=
,
>      releasepage and co. have to consult those
>      (__fscache_maybe_release_page()).

Note that, ideally, we'll be able to remove the old fscache I/O code in th=
e
next merge window or the one after.

David

