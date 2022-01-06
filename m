Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9584868F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 18:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbiAFRoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 12:44:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242260AbiAFRoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641491053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zpIRZHdll9Kvd0nCHQ+ZsJmW/V2ZBc2nIIWedRx6PP0=;
        b=bR3GxVjSoIQeuEyk0+GzR8OPzb07fxDPWWxUYZjo4hocfhoZzSS1c27XPtLAsiCShLE2K9
        BfFATgMGjzqt3Od6gRkP6k4daNJh734/veEw0GCYgA8elaXCs60wthQnBArH2k6Z/3EXjr
        kv9S/yUiGzuJJbxOAQxSlsP/qfuiHVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-Bg1iYB-BPxuii1R-44xhhw-1; Thu, 06 Jan 2022 12:44:10 -0500
X-MC-Unique: Bg1iYB-BPxuii1R-44xhhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EF87190A7A0;
        Thu,  6 Jan 2022 17:44:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E22B777479;
        Thu,  6 Jan 2022 17:44:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <568749bd7cc02908ecf6f3d6a611b6f9cf5c4afd.camel@kernel.org>
References: <568749bd7cc02908ecf6f3d6a611b6f9cf5c4afd.camel@kernel.org> <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk> <164021543872.640689.14370017789605073222.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 40/68] cachefiles: Implement cache registration and withdrawal
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2856723.1641491044.1@warthog.procyon.org.uk>
Date:   Thu, 06 Jan 2022 17:44:04 +0000
Message-ID: <2856724.1641491044@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> > +	/* check parameters */
> > +	ret = -EOPNOTSUPP;
> > +	if (d_is_negative(root) ||
> > +	    !d_backing_inode(root)->i_op->lookup ||
> > +	    !d_backing_inode(root)->i_op->mkdir ||
> > +	    !(d_backing_inode(root)->i_opflags & IOP_XATTR) ||
> > +	    !root->d_sb->s_op->statfs ||
> > +	    !root->d_sb->s_op->sync_fs ||
> > +	    root->d_sb->s_blocksize > PAGE_SIZE)
> > +		goto error_unsupported;
> > +
> 
> That's quite a collection of tests.
> 
> Most are obvious, but some comments explaining the need for others would
> not be a bad thing. In particular, why is s_blocksize > PAGE_SIZE
> unsupported?

It can't do page-sized DIO requests to a filesystem with a block size larger
than a page.  In the future I can work around that in conjunction with
netfslib by expanding read and write sizes.

> Also, should you vet whether the fs supports i_op->tmpfile here ?

That's a good idea.

David

