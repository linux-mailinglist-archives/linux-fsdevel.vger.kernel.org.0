Return-Path: <linux-fsdevel+bounces-17110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F3B8A7F04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27055282D31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D24612D20E;
	Wed, 17 Apr 2024 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnaClXaV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2B7CF33
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344586; cv=none; b=u8Np7wpeYb0JSKBYF1+cyDYmYemiVnV3lydQfYzVHq4BbI1F+I2bWsA7Cy0VUoIEIqYs8uzW3n+2BAWdxdjrBsIJvQpcrQWtnJCCtImIyAdL1QH+sGWLjbyqjiqx3NmBbKMjXe3fAUL751qvPFJXXde37w/R0pne/3arpYhm8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344586; c=relaxed/simple;
	bh=R4xZIyD420GCJPk7IwQrpmZ24e54I/xuenwhI6qQfh8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=F+kdEqLAh7FwhXpCs+TA+cKABljAOsq+4tble2tkCzLYjFmOJ3LiCV9givGO4p23cL93Yx3lQZSZSkYpEdkXX4dhdMFC3O9zDy+hztWo14DDgyp5WHSEu22MJXo7j6SUKOR+iWFvREHh4aIqCvxA2wgilO5tlnzg+lbq4R3uxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnaClXaV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713344584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cqHolZFVcFPpeLBdV05ZqicpNbJqZRKW17Kvjt/Abs=;
	b=RnaClXaVGrfX09bDkufjzSAK9KMoLmEnNPlRGuc1UbfE7ECBKZ7GlzdR6B3zLltZh4GvXE
	8e9ID4CPFzc70tnjLNlVKYtZFJ6WXbaWACGLYsnh8Lhnt5UqlK4VOgsHgQ/eqv1g24IOyD
	vnRVA9/BxUNxHui8eerytftKtOF4sQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-UAKkPT0cNTu8x3FwjUWu1g-1; Wed, 17 Apr 2024 05:03:00 -0400
X-MC-Unique: UAKkPT0cNTu8x3FwjUWu1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D56BA10499A0;
	Wed, 17 Apr 2024 09:02:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F32BC13FA2;
	Wed, 17 Apr 2024 09:02:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3570373a3db66151033a3667cb8c28bbf8bc505b.camel@kernel.org>
References: <3570373a3db66151033a3667cb8c28bbf8bc505b.camel@kernel.org> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-10-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
    Christian Brauner <christian@brauner.io>,
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
    linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Christoph Hellwig <hch@lst.de>,
    Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>, devel@lists.orangefs.org
Subject: Re: [PATCH 09/26] mm: Provide a means of invalidation without using launder_folio
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28262.1713344568.1@warthog.procyon.org.uk>
Date: Wed, 17 Apr 2024 10:02:48 +0100
Message-ID: <28263.1713344568@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Jeff Layton <jlayton@kernel.org> wrote:

> I'd have liked to have seen the first caller of this function too.

Looking again at my code, I also need to make netfs_unbuffered_write_iter()
use this function too.  I missed it before because that wasn't calling
invalidate_inode_pages2_range() directly, but rather going through
kiocb_invalidate_pages().

So I'll add those changes into this patch to give you a first caller.  I also
then need to make filemap_invalidate_inode() take a byte range.

David


