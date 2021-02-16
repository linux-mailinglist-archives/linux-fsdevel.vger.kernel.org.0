Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856A731CA41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 12:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBPL5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 06:57:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230283AbhBPL5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613476548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3PmMMoMDLKUpdyWA+t3gfR/qM+zxf83cCXtDD4CspmY=;
        b=AEORSeucQbCUNGLrR9M9fiIDvpjiHpM8JTELatLkdYqR9ZvVzQ0lCA2soIhqYJxNAVOOFQ
        ZYCsDDx649Z51Jiz861wfSbqlEM2sqlnU706cicxoBF7kaymZdpmAlmVP7oyXmw0CVqpXv
        pLAnsJbeyzKKf9cSVnzJpgigu8vYTiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-fzPbbtGgPwedki1-150nhQ-1; Tue, 16 Feb 2021 06:55:44 -0500
X-MC-Unique: fzPbbtGgPwedki1-150nhQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75567801965;
        Tue, 16 Feb 2021 11:55:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1466410016FA;
        Tue, 16 Feb 2021 11:55:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210216102614.GA27555@lst.de>
References: <20210216102614.GA27555@lst.de> <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <161340390150.1303470.509630287091953754.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/33] vfs: Export rw_verify_area() for use by cachefiles
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1429649.1613476535.1@warthog.procyon.org.uk>
Date:   Tue, 16 Feb 2021 11:55:35 +0000
Message-ID: <1429650.1613476535@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> > Export rw_verify_area() for so that cachefiles can use it before issuing
> > call_read_iter() and call_write_iter() to effect async DIO operations
> > against the cache.  This is analogous to aio_read() and aio_write().
> 
> I don't think this is the right thing to do.  Instead of calling
> into ->read_iter / ->write_iter directly this should be using helpers.
> 
> What prevents you from using vfs_iocb_iter_read and
> vfs_iocb_iter_write which seem the right level of abstraction for this?

I don't think they existed when I wrote this code.  Should aio use that too,
btw?  I modelled my code on aio_read() and aio_write().

But I can certainly switch to using vfs_iocb_iter_read/write, though the
trivial checks are redundant.  The fsnotify call, I guess I'm missing though
(and is that missing in aio_read/write() also?).

David

