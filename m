Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6A3598D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 11:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhDIJJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 05:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232642AbhDIJJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617959359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4HrPUNe1C2/eoGUl35UTxwdBVeab2D940Ztg0ThcXw=;
        b=V8OLG4XqlYGFgqXdOeTRNzweFqQIOQCR98Qo0Mz7JY7jmiLayP0h2hrRp9q1HQ8ZjoX0GJ
        /68JZOvTrOoHz/Ofwh/cfkRTZ3Ry9K6geRm40N/ygnR2CCa2z0T0U1vxd63OGAXcY/T75o
        7lf0EjAdTfsIheT5GhChj+XrSTwwzyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-DWcyR59bPNm8maj44EYDXw-1; Fri, 09 Apr 2021 05:09:15 -0400
X-MC-Unique: DWcyR59bPNm8maj44EYDXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 455B9107ACC7;
        Fri,  9 Apr 2021 09:09:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 529765D9E3;
        Fri,  9 Apr 2021 09:09:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YG+s0iw5o91KQIlW@zeniv-ca.linux.org.uk>
References: <YG+s0iw5o91KQIlW@zeniv-ca.linux.org.uk> <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk> <161789064740.6155.11932541175173658065.stgit@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/30] iov_iter: Add ITER_XARRAY
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <289824.1617959345.1@warthog.procyon.org.uk>
Date:   Fri, 09 Apr 2021 10:09:05 +0100
Message-ID: <289825.1617959345@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> > +#define iterate_all_kinds(i, n, v, I, B, K, X) {		\
> 
> Do you have any users that would pass different B and X?
> 
> > @@ -1440,7 +1665,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
> >  		return v.bv_len;
> >  	}),({
> >  		return -EFAULT;
> > -	})
> > +	}), 0
> 
> Correction - users that might get that flavour.  This one explicitly checks
> for xarray and doesn't get to iterate_... in that case.

This is the case for iterate_all_kinds(), but not for iterate_and_advance().

See _copy_mc_to_iter() for example: that can return directly out of the middle
of the loop, so the X variant must drop the rcu_read_lock(), but the B variant
doesn't need to.  You also can't just use break to get out as the X variant
has a loop within a loop to handle iteration over the subelements of a THP.

But with iterate_all_kinds(), I could just drop the X parameter and use the B
parameter for both, I think.

David

