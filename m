Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C83C3D56C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 11:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhGZJEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 05:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232617AbhGZJET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627292688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kBC7/7n7ieIR+PQocFWGsdEhjsiqMRhY14cESzBGes0=;
        b=Wbg1ZZ/nBVA5QPydlyjv+cODt5GnjnN6p4kgEeGgESCTM3tpidvwr/oROn5GPcccnY6Urm
        W/bP/eyk0ilHQ2u27baIttOq/8jNCESFgc/lVSgzgcmq8eo+Mj3vqS0sZYAkNXqU2I3NEd
        PmghVWglsw5HuK1qaCK0Jxg70ACE3iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-brLp6B6MMoKsBE9RNfYfwA-1; Mon, 26 Jul 2021 05:44:47 -0400
X-MC-Unique: brLp6B6MMoKsBE9RNfYfwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A966F8799EF;
        Mon, 26 Jul 2021 09:44:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.16.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61BB85C1D1;
        Mon, 26 Jul 2021 09:44:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <35ecb577315f486f1636b2316c2051ad004f6f7b.camel@redhat.com>
References: <35ecb577315f486f1636b2316c2051ad004f6f7b.camel@redhat.com> <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk> <162687508008.276387.6418924257569297305.stgit@warthog.procyon.org.uk>
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
Subject: Re: [RFC PATCH 01/12] afs: Sort out symlink reading
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <812199.1627292675.1@warthog.procyon.org.uk>
Date:   Mon, 26 Jul 2021 10:44:35 +0100
Message-ID: <812200.1627292675@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@redhat.com> wrote:

> > -static int afs_symlink_readpage(struct page *page)
> > +static int afs_symlink_readpage(struct file *file, struct page *page)
> >  {
> >  	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
> >  	struct afs_read *fsreq;
> 
> 
> I wonder...would you be better served here by not using page_readlink
> for symlinks and instead use simple_get_link and roll your own readlink
> operation. It seems a bit more direct, and AFS seems to be the only
> caller of page_readlink.

Maybe.  At some point it will need to go through netfs_readpage() so that it
will get cached and maybe encrypted.  Possibly there should be a
netfs_readlink().  AFS directories too will at some point need to go through
netfs_readahead() or similar.

David

