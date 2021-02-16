Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C3C31CA2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 12:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhBPLwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 06:52:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230283AbhBPLuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613476119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=coH4C7xdrmgBE3/XsHGmHJNC7rb47IS/kJchI+NLx3A=;
        b=PZu8BxFFewks0etlybQeiktQl+i6Xz/jRF/+xQTJ7TjNDaEArVTpxtScVkmwoRkNdlkzHQ
        6aVfHudJJ986oTWKbTmeSN4HUFUhPAaWFVTnt2Br6njEN/AnRnbnTiLUDwwr96iUltiG4k
        TaolSFXKZWu2V5aKBlhS7XeZ5f0yl70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-jKcmJhrLMwullgSDWVKkPg-1; Tue, 16 Feb 2021 06:48:35 -0500
X-MC-Unique: jKcmJhrLMwullgSDWVKkPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B44BE801977;
        Tue, 16 Feb 2021 11:48:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDB605C1B4;
        Tue, 16 Feb 2021 11:48:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210216103215.GB27714@lst.de>
References: <20210216103215.GB27714@lst.de> <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <161340389201.1303470.14353807284546854878.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/33] mm: Implement readahead_control pageset expansion
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1429174.1613476104.1@warthog.procyon.org.uk>
Date:   Tue, 16 Feb 2021 11:48:24 +0000
Message-ID: <1429175.1613476104@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Feb 15, 2021 at 03:44:52PM +0000, David Howells wrote:
> > Provide a function, readahead_expand(), that expands the set of pages
> > specified by a readahead_control object to encompass a revised area with a
> > proposed size and length.
> ...
> So looking at linux-next this seems to have a user, but that user is
> dead wood given that nothing implements ->expand_readahead.

Interesting question.  Code on my fscache-iter branch does implement this, but
I was asked to split the patchset up, so that's not in this subset.

> Looking at the code structure I think netfs_readahead and
> netfs_rreq_expand is a complete mess and needs to be turned upside
> down, that is instead of calling back from netfs_readahead to the
> calling file system, split it into a few helpers called by the
> caller.
> 
> But even after this can't we just expose the cache granule boundary
> to the VM so that the read-ahead request gets setup correctly from
> the very beginning?

You need to argue this one with Willy.  In my opinion, the VM should ask the
filesystem and the expansion be done before ->readahead() is called.  Willy
disagrees, however.

David

