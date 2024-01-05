Return-Path: <linux-fsdevel+bounces-7434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4CB824BFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 01:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEB7288927
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 00:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7434F1DFE8;
	Fri,  5 Jan 2024 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ny/NXZ9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492E31DFC9
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704413059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5WaHmrrzJBv7a+URkS6ztAOCLzOS5Gcgk0L1SHTlJFM=;
	b=Ny/NXZ9ijFjKON1VXNmzg9Y97Co7vfo0b1h2qAdCKpXckJnYkHkaWD4w3FAUs+GB5v5Cc3
	FtsmRx5d9jPKsqLx+opkn2n+fcsUqnoXZ2uvbRV2IgFcPZ4vglf65WNSVUvQroZoSs+vRw
	2/IwLOGr6I0GxgNq3v/hEBX7D3LcgvI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-sCoRdcW_OJ2yXyiw9ax9QA-1; Thu, 04 Jan 2024 19:04:13 -0500
X-MC-Unique: sCoRdcW_OJ2yXyiw9ax9QA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A956803916;
	Fri,  5 Jan 2024 00:04:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0524E3C27;
	Fri,  5 Jan 2024 00:04:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ulideurkqeiqztorsuvhynsrx2np7ohbmnx5nrddzl7zze7qpu@cg27bqalj7i5>
References: <ulideurkqeiqztorsuvhynsrx2np7ohbmnx5nrddzl7zze7qpu@cg27bqalj7i5> <20231018122518.128049-1-wedsonaf@gmail.com> <ZT7BPUAxsHQ/H/Hm@casper.infradead.org> <CANeycqrm1KCH=hOf2WyCg8BVZkX3DnPpaA3srrajgRfz0x=PiQ@mail.gmail.com> <ZZWhQGkl0xPiBD5/@casper.infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    Wedson Almeida Filho <wedsonaf@gmail.com>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Kent Overstreet <kent.overstreet@gmail.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
    Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1080085.1704413050.1@warthog.procyon.org.uk>
Date: Fri, 05 Jan 2024 00:04:10 +0000
Message-ID: <1080086.1704413050@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Kent Overstreet <kent.overstreet@linux.dev> wrote:

> So instead, it would seem easier to me to do the cleaner version on the
> Rust side, and then once we know what that looks like, maybe we update
> the C version to match - or maybe we light it all on fire and continue
> with rewriting everything in Rust... *shrug*

Please, no.  Please keep Rust separate and out of the core of the kernel and
subsystems.

David


