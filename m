Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9EE3D14FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhGUQjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 12:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbhGUQjv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626888027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BIt0Yb9H5DHJEMvOYSUbKkxcwoKM/Ncp4O7tCakc/1Q=;
        b=eXyLgZrSPve50INxI3GJEvydet7VfEqLZPm7S1AIsNpq2WLQ7lu0V25UdMMjQTmjNFH0VG
        C/7cxK4HNxa4mM0JIQ326fMU4OPhrh+U/zKFBQ4Xar4i+cvhyS7oFBXbGeXgSkwWFtsiks
        5lWvUmM5YOQ/bkonkZkUbgIYMvqVNPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-GhHEOI8XMz2fV-_JkEc7ng-1; Wed, 21 Jul 2021 13:20:25 -0400
X-MC-Unique: GhHEOI8XMz2fV-_JkEc7ng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FF0C192CC46;
        Wed, 21 Jul 2021 17:20:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7BD35D9DD;
        Wed, 21 Jul 2021 17:20:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <0555748529d483fb9b69eceb56bf9ebc1efceaf1.camel@redhat.com>
References: <0555748529d483fb9b69eceb56bf9ebc1efceaf1.camel@redhat.com> <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk> <162687509306.276387.7579641363406546284.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/12] netfs: Add an iov_iter to the read subreq for the network fs/cache to use
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <289703.1626888014.1@warthog.procyon.org.uk>
Date:   Wed, 21 Jul 2021 18:20:14 +0100
Message-ID: <289704.1626888014@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> > -	iov_iter_xarray(&iter, WRITE, &subreq->rreq->mapping->i_pages,
> > +	iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
> 
> What's up with the WRITE -> READ change here? Was that a preexisting
> bug?

Actually, yes - I need to split that out and send it to Linus.

David

