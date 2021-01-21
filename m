Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2025D2FF186
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 18:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbhAURMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 12:12:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26690 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388342AbhAUREz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611248600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4KgVfQwgH0t00E0jREnBAYvp7Ag6zfsUmeWko7Cl/RY=;
        b=Vcu5ibmUwGEJdXC/y7cOUzhtxH03ez44SvfMgSjtBYbE6LFpKIZwVo0cX2G84FljAw98Ne
        Sv2KtIYqBMj1kkytokpfR64epS2y8HCxE6Mf7sUry17WSoPUNTC88d0qA+aZuR9NlISPFT
        0sZzOc0p6Td5rDCL7xoX6Xnowwv0EcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-0Pnv6BdCNz6Oqh-N316exg-1; Thu, 21 Jan 2021 12:03:16 -0500
X-MC-Unique: 0Pnv6BdCNz6Oqh-N316exg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1E648066FF;
        Thu, 21 Jan 2021 17:03:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCE6960C43;
        Thu, 21 Jan 2021 17:02:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210121164645.GA20964@fieldses.org>
References: <20210121164645.GA20964@fieldses.org> <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk>
To:     bfields@fieldses.org (J. Bruce Fields)
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Takashi Iwai <tiwai@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-afs@lists.infradead.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 00/25] Network fs helper library & fscache kiocb API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1794285.1611248577.1@warthog.procyon.org.uk>
Date:   Thu, 21 Jan 2021 17:02:57 +0000
Message-ID: <1794286.1611248577@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

J. Bruce Fields <bfields@fieldses.org> wrote:

> On Wed, Jan 20, 2021 at 10:21:24PM +0000, David Howells wrote:
> >      Note that this uses SEEK_HOLE/SEEK_DATA to locate the data available
> >      to be read from the cache.  Whilst this is an improvement from the
> >      bmap interface, it still has a problem with regard to a modern
> >      extent-based filesystem inserting or removing bridging blocks of
> >      zeros.
> 
> What are the consequences from the point of view of a user?

The cache can get both false positive and false negative results on checks for
the presence of data because an extent-based filesystem can, at will, insert
or remove blocks of contiguous zeros to make the extents easier to encode
(ie. bridge them or split them).

A false-positive means that you get a block of zeros in the middle of your
file that very probably shouldn't be there (ie. file corruption); a
false-negative means that we go and reload the missing chunk from the server.

The problem exists in cachefiles whether we use bmap or we use
SEEK_HOLE/SEEK_DATA.  The only way round it is to keep track of what data is
present independently of backing filesystem's metadata.

To this end, it shouldn't (mis)behave differently than the code already there
- except that it handles better the case in which the backing filesystem
blocksize != PAGE_SIZE (which may not be relevant on an extent-based
filesystem anyway if it packs parts of different files together in a single
block) because the current implementation only bmaps the first block in a page
and doesn't probe for the rest.

Fixing this requires a much bigger overhaul of cachefiles than this patchset
performs.

Also, it works towards getting rid of this use of bmap, but that's not user
visible.

David

