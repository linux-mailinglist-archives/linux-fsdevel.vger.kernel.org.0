Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7B028E3F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 18:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgJNQFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 12:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729391AbgJNQFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602691522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=auAyP+fVKBxRH1I46TJ6M6ABd1PyYGefPcWLaA/lgsA=;
        b=W8/csl2ybCeASmhEMxLhSU3NZ6pficG1ufx/4VaYyuh7BxNVuBNP9z3zByyLecHXdwfIU1
        78e5WlmZVeXMumoFOFBVEQzffTO4F0s22cvp611b1+MlyBrJWYFavxfLaXbO+upyncdiV0
        tmVu7FRjvdiaEc9U4kgdVfjnAQlkNv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-SklELPrJNNqPO3nTE7p1yg-1; Wed, 14 Oct 2020 12:05:15 -0400
X-MC-Unique: SklELPrJNNqPO3nTE7p1yg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D639A6414B;
        Wed, 14 Oct 2020 16:05:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C06D60C0F;
        Wed, 14 Oct 2020 16:05:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201014153836.GM20115@casper.infradead.org>
References: <20201014153836.GM20115@casper.infradead.org> <20201014134909.GL20115@casper.infradead.org> <B60A55DB-6AB7-48BF-8F11-68FF6FF46C4E@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Chris Mason <clm@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: PagePrivate handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <668210.1602691511.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 14 Oct 2020 17:05:11 +0100
Message-ID: <668211.1602691511@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> It's not great, but with David wanting to change how PageFsCache is used=
,
> it may be unavoidable (I'm not sure if he's discussed that with you yet)
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/co=
mmit/?h=3Dfscache-iter&id=3D6f10fd7766ed6d87c3f696bb7931281557b389f5 shows=
 part of it
> -- essentially he wants to make PagePrivate2 mean that I/O is currently
> ongoing to an fscache, and so truncate needs to wait on it being finishe=
d.

->invalidatepage() and ->releasepage() had to wait anyway.

PG_fscache used to mean that the cache might have some knowledge of the pa=
ge
and it might have I/O in progress on it - entirely as and when the cache f=
elt
like doing it.

Now it just means that there's write I/O in progress on it at the netfs's
behest (though it might be issued by a cache helper).  The main part of th=
e
cache doesn't know about the page and doesn't care about the page flag, it
just sees an iov_iter.

In a sense, it's now a second PG_writeback flag.  A page can be being writ=
ten
to two locations at the same time (the server and the cache).  Each write =
is
independent, though they may be started from the same place, and one of th=
e
writes may be being handled by another filesystem entirely (the cache may =
have
started a DIO write to ext4, for example).

It's not needed for reading, since the PG_locked flag entirely suffices fo=
r
that.  The read helper doesn't do parallel reads from the server and the c=
ache
to the same chunk of pagecache.

Willy has asked that I either make PG_writeback cover both cases or that
PG_fscache can only be set if PG_writeback is also set.  However, both of
these require extra state to be attached to page->private to be able to
coordinate this as there may be (as mentioned above) two parallel writes f=
rom
the same data that may finish at different times.

David

