Return-Path: <linux-fsdevel+bounces-17087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DFC8A784D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 01:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9345728583F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 23:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1882013B280;
	Tue, 16 Apr 2024 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eG8slGxK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3361813A40D
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308605; cv=none; b=Zyrv/rKAkan4OxYH1YIBwmPzRXm7miYC8URG7DDlIPjIwOzmoJlmjriZL2jfE/VH5WSzv/OxVtFMmA8ws6AVqwJm7Q8hhoXQm+DX3bNlEwJ8LNtqMruvtBcdMG0/2BebwwTtjfahVN4FNIoXyy24BsfCNk4EUMZrxBqgcJMOnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308605; c=relaxed/simple;
	bh=DNSKqIczlyBwuQ67ZFkxtx1MZSnOD27Vgyxg6uryKIE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=iR+wZmL4xw0obc1JYfOBJIKaff/p6OfDsqc5FSeOrmyY+5Rlt6p5M+z0KXR2TiDArCQluqOig0r6Ac9z3XTn/+fN8D6WStjr/VRVtYkwcXLE3bF5AZ2pM0442fF1c0aLkpjdeee2Lp+kVDTIj622CkB2Wl+PntlL67Y2w7KNbNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eG8slGxK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713308603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omkePlcDB8enwqcFXRle7B6BhP/V3w40pUO+LmEoCqU=;
	b=eG8slGxKfbwUr18HLRV3eAhgH0p4gX7NXa1pWoaqp1ONuQmawVxDd7RcQ3pCfExjpCKtJL
	BYuMFV9WdhklmXW4P39axMRC+K6T5uUqfGchGrmMVn6D0QODER1zdqBZ2yLAgu5kBZYbuU
	jwekeP/HrVw5xmfa5dtC6P6d3rZ22zo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-HZB_5gEsP8-Mrh_g6kWHzA-1; Tue, 16 Apr 2024 19:03:20 -0400
X-MC-Unique: HZB_5gEsP8-Mrh_g6kWHzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADE98803513;
	Tue, 16 Apr 2024 23:03:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C3961BDAA;
	Tue, 16 Apr 2024 23:03:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <9b7de2417924192fb411744171015877c1d4c677.camel@kernel.org>
References: <9b7de2417924192fb411744171015877c1d4c677.camel@kernel.org> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-12-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Matthew Wilcox <willy@infradead.org>,
    Steve French <smfrench@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 11/26] 9p: Use alternative invalidation to using launder_folio
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2756051.1713308590.1@warthog.procyon.org.uk>
Date: Wed, 17 Apr 2024 00:03:10 +0100
Message-ID: <2756052.1713308590@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Jeff Layton <jlayton@kernel.org> wrote:

> Shouldn't this include a call to filemap_invalidate_inode? Is just
> removing launder_folio enough to do this?

Good point.  netfs_unbuffered_write_iter() calls kiocb_invalidate_pages() -
which uses invalidate_inode_pages2_range() to discard the pagecache.  It
should probably use filemap_invalidate_inode() instead.

David


