Return-Path: <linux-fsdevel+bounces-2913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0647A7EC8C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 17:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C341F22865
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 16:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D063BB57;
	Wed, 15 Nov 2023 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BChPHrMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E331381C3
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 16:40:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE938D4D
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 08:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700066391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HCpNMTIKyOeROsc7/RWOAvMZhqSI0z3duXfnje8m3KQ=;
	b=BChPHrMVBjvq8R3sEZBApf7cIzr0LA4Xib2PFEYal0rgj8FlW58rWb9RMOMhbhDHltujU8
	bklLCp5QJk7EieQjxbZm8JG+RqGvRAMRz19hF4zzWEknHvjGBnkTQ9W5B5i0tDYXCqRrR2
	Zg7XlpopxHbIdrWfvozeqmy2e+S/Kwo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-UdDnholkMuG4DRRASuNUrQ-1; Wed, 15 Nov 2023 11:39:50 -0500
X-MC-Unique: UdDnholkMuG4DRRASuNUrQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6F20101B04B;
	Wed, 15 Nov 2023 16:39:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F0B85492BE8;
	Wed, 15 Nov 2023 16:39:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com>
References: <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com> <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-6-dhowells@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
    Christoph Hellwig <hch@lst.de>,
    David Laight <David.Laight@aculab.com>,
    Matthew Wilcox <willy@infradead.org>,
    Brendan Higgins <brendanhiggins@google.com>,
    David Gow <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
    linux-block@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
    kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
    Andrew Morton <akpm@linux-foundation.org>,
    Christian Brauner <brauner@kernel.org>,
    David Hildenbrand <david@redhat.com>,
    John Hubbard <jhubbard@nvidia.com>,
    Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
    Heiko Carstens <hca@linux.ibm.com>,
    Vasily Gorbik <gor@linux.ibm.com>,
    Alexander Gordeev <agordeev@linux.ibm.com>,
    Christian Borntraeger <borntraeger@linux.ibm.com>,
    Sven Schnelle <svens@linux.ibm.com>, loongarch@lists.linux.dev,
    linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 05/10] iov_iter: Create a function to prepare userspace VM for UBUF/IOVEC tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3936725.1700066370.1@warthog.procyon.org.uk>
Date: Wed, 15 Nov 2023 16:39:30 +0000
Message-ID: <3936726.1700066370@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> From a quick look, what you were doing was checking that the patterns
> you set up in user space came through ok. Dammit, what's wrong with
> just using read()/write() on a pipe, or splice, or whatever. It will
> test exactly the same iov_iter thing.

I was trying to make it possible to do these tests before starting userspace
as there's a good chance that if the UBUF/IOVEC iterators don't work right
then your system can't be booted.

Anyway, if I drop patches 5, 6, 7 and 10 (ie. the ones doing stuff with UBUF
and IOVEC-type iterators), would you be okay with the rest?

David


