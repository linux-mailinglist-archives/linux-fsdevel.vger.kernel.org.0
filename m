Return-Path: <linux-fsdevel+bounces-6784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552CD81C963
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 12:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386C6B23C9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEA11803C;
	Fri, 22 Dec 2023 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRURTACp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF0117989
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703245801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2Kc5SDyR2sa98m7GGfG0OJjTCYVmXAF9D404GjbeCw=;
	b=CRURTACpBzbE6yVfJaX4KXc/6LUeCQPtt4vM38/xiKaLx/ocYmIOXn4SkqIQKGb2z8ORuT
	r70yfFF5lqiCTV3ETWJivYzIni+PTp/unvK267+sX5+kN8/rW9fPz9JXGPQuUcz2PIwdGb
	ywxsydgxB1JzfnYWN44BEoxrNu1wh/M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-gMeN3nQqMpKa8ASINIbPcw-1; Fri, 22 Dec 2023 06:49:57 -0500
X-MC-Unique: gMeN3nQqMpKa8ASINIbPcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2C45868A20;
	Fri, 22 Dec 2023 11:49:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 71FCC2026D66;
	Fri, 22 Dec 2023 11:49:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231221230153.GA1607352@dev-arch.thelio-3990X>
References: <20231221230153.GA1607352@dev-arch.thelio-3990X> <20231221132400.1601991-1-dhowells@redhat.com> <20231221132400.1601991-38-dhowells@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>,
    Anna Schumaker <Anna.Schumaker@Netapp.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 37/40] netfs: Optimise away reads above the point at which there can be no data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2202547.1703245791.1@warthog.procyon.org.uk>
Date: Fri, 22 Dec 2023 11:49:51 +0000
Message-ID: <2202548.1703245791@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Nathan Chancellor <nathan@kernel.org> wrote:

> It appears that ctx->inode.i_mapping is NULL in netfs_inode_init(). This
> patch appears to cure the problem for me but I am not sure if it is
> proper or not.

I'm not sure that's the best way.  It kind of indicates that
nfs_netfs_inode_init() is not being called in the right place - it should
really be called after alloc_inode() has called inode_init_always().

However, mapping_set_release_always() makes ->release_folio() and
->invalidate_folio() always called for an inode's folios, even if PG_private
is not set - the idea being that this allows netfslib to update the
"zero_point" when a page we've written to the server gets invalidated here,
thereby requiring us to go fetch it again.

Now, NFS doesn't make use of this feature and fscache and cachefiles don't use
it directly, so we might not want to call mapping_set_release_always() for
NFS.

I'm not sure NFS can even reliably make use of it unless it's using a lease
unless it gets change notifications from the server.

So I'm thinking of applying your patch but add a comment to say why we're
doing it.  A better way, though, is to move the call to nfs_netfs_inode_init()
and give it a flag to say whether or not we want the facility.

David


