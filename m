Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD73F2FEDB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 15:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbhAUO4h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 09:56:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732146AbhAUO4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611240885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=afmDN/YwbtUqz/j1cZ3aF4okApTZWuiODMoly6KagV4=;
        b=R+oLs24QP4fYD+0lkT27B/bJmEKtoRFvgKk1jo5DZ3ojSd4D5UZfA35btdb5/+jICcJnQ3
        NqbvANwlRmSfLFR+r138jy5fM6r0K3r6ezTjhMx7noVd1lUjK66MT085ONnMUpfio8eW9D
        GvgOmkJGK8Sxac8IRm5ZUfq9jGsbiGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-2mJhBzxPP_CRkRxCUJ_DQw-1; Thu, 21 Jan 2021 09:54:42 -0500
X-MC-Unique: 2mJhBzxPP_CRkRxCUJ_DQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D201C1800D42;
        Thu, 21 Jan 2021 14:54:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 699585C8AB;
        Thu, 21 Jan 2021 14:54:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210121133406.GP2260413@casper.infradead.org>
References: <20210121133406.GP2260413@casper.infradead.org> <161118128472.1232039.11746799833066425131.stgit@warthog.procyon.org.uk> <161118129703.1232039.17141248432017826976.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/25] iov_iter: Add ITER_XARRAY
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1668556.1611240871.1@warthog.procyon.org.uk>
Date:   Thu, 21 Jan 2021 14:54:31 +0000
Message-ID: <1668557.1611240871@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Jan 20, 2021 at 10:21:37PM +0000, David Howells wrote:
> > -#define iterate_all_kinds(i, n, v, I, B, K) {			\
> > +#define iterate_all_kinds(i, n, v, I, B, K, X) {		\
> 
> Do you need to add the X parameter?  It seems to always be the same as B.

It isn't.  See iov_get_pages() for example.

David

