Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971C24649A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 09:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347976AbhLAIc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 03:32:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347970AbhLAIc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638347377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tUl7G8alL78nfbRo0WLNZl+gkt+X3mS2JKYOztBaCw=;
        b=Q9HTm2UK5n3YyPaocpbkGIT5GvvKs130tSBFOthRPS0We8O5q0q0Gtc4w75CTKqDgE3WFO
        XuiW0kuCl7iVjNlOLHIFV88qNNb/vS9d4TEqc7XK5Qct8yo1YZZqEMGiBh0QBVcXI8iuwp
        //esibe6Ljr4T6St26rp7mdaj0s+muY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-521-AnOULJD2MFCLO_7J_kL0gQ-1; Wed, 01 Dec 2021 03:29:34 -0500
X-MC-Unique: AnOULJD2MFCLO_7J_kL0gQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2A42190B2A1;
        Wed,  1 Dec 2021 08:29:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A14EB4D73A;
        Wed,  1 Dec 2021 08:29:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <bcefb8f2-576a-b3fc-cc29-89808ebfd7c1@linux.alibaba.com>
References: <bcefb8f2-576a-b3fc-cc29-89808ebfd7c1@linux.alibaba.com> <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk> <163819640393.215744.15212364106412961104.stgit@warthog.procyon.org.uk>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 44/64] cachefiles: Implement key to filename encoding
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <571667.1638347365.1@warthog.procyon.org.uk>
Date:   Wed, 01 Dec 2021 08:29:25 +0000
Message-ID: <571668.1638347365@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

JeffleXu <jefflexu@linux.alibaba.com> wrote:

> > +	/* If the path is usable ASCII, then we render it directly */
> > +	if (print) {
> > +		len = 1 + keylen + 1;
> > +		name = kmalloc(len, GFP_KERNEL);
> > +		if (!name)
> > +			return false;
> > +
> > +		name[0] = 'D'; /* Data object type, string encoding */
> > +		name[1 + keylen] = 0;
> > +		memcpy(name + 1, key, keylen);
> > +		goto success;
> 			^
> If we goto success from here,
> ...
> > +
> > +success:
> > +	name[len] = 0;
> 	     ^
> then it seems that this will cause an out-of-boundary access.

You're right.  I'll change that to:

		len = 1 + keylen;
		name = kmalloc(len + 1, GFP_KERNEL);

and I shouldn't need:

		name[1 + keylen] = 0;

as that's also done after the success label.

David

