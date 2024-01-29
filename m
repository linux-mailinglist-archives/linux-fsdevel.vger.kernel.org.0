Return-Path: <linux-fsdevel+bounces-9380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7772984082A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA53B1C22BCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460F664B7;
	Mon, 29 Jan 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgnpDePZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ED6657DB
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538145; cv=none; b=GDq769AHWVEKVwciX424NUKvoAbic7ZXxxG3ik/GUwlGvHiIyulkc/hxQ8zrP2aQGx28NHQrXG71CK1GLA9qlR4U4NdM3aKAnEnkQTELkO/or/zCBhMzLYR0ESkLbX5y1TXyOMPSJ1URzcri32+RD5kY5JxJb/U68YHIMQUf/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538145; c=relaxed/simple;
	bh=tCWWZomfJcyxHGHphvF07Z+awA1I576ll6ppz1EFzEw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=UOlLkgTvtfglTbGO/qaaKHGFw+wRLXXM4JZz23ap8xd/NBZHsJcNuW3EgYX/Hu/EUv6on62DYWFO5diexPgFsJ9asvnpNp7U7mCB5ILXPnzD+JLyYNnBj7RVFXR3XOehEQx0aBh2j+LAxnl5m3I967zWuYLhdt4YJhyz4ZjATTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgnpDePZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706538142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JY6BkJiBfGvFZHOyLdscqIayyamnbMR5+XLPiL0Fn18=;
	b=BgnpDePZi02bCUSDHjbqgypEyE1d/isJCszgp/LKhwLuIkfRmqGw7NlxEZYtJ6Cn3u/qkp
	mETmZJbN6l2xMWVmCGNW2OZot97meMjleVWjLcWL0Msw63nHfCIVVF5fCGmyNVjM5t6FcK
	Moc0mfODd/VxCIgJFdxPdvgZ669hRnc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-G4-T2WGhNT-FuUxip56YNA-1; Mon,
 29 Jan 2024 09:22:19 -0500
X-MC-Unique: G4-T2WGhNT-FuUxip56YNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 521DE1C0432A;
	Mon, 29 Jan 2024 14:22:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D63B2166B31;
	Mon, 29 Jan 2024 14:22:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1726980.McBZPkGeyK@silver>
References: <1726980.McBZPkGeyK@silver> <20240129115512.1281624-1-dhowells@redhat.com>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: dhowells@redhat.com, Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Matthew Wilcox <willy@infradead.org>,
    Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] 9p: Further netfslib-related changes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1400270.1706538135.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jan 2024 14:22:15 +0000
Message-ID: <1400271.1706538135@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Christian Schoenebeck <linux_oss@crudebyte.com> wrote:

> >  (1) Enable large folio support for 9p.  This is handled entirely by
> >      netfslib and is already supported in afs.  I wonder if we should =
limit
> >      the maximum folio size to 1MiB to match the maximum I/O size in t=
he 9p
> >      protocol.
> =

> The limit depends on user's 'msize' 9p client option and on the 9p trans=
port
> implementation. The hard limit with virtio transport for instance is cur=
rently
> just 500k (patches for virtio 4MB limit fetching dust unfortunately).

Okay.  Is that 500KiB or 512Kib?

> Would you see an advantage to limit folio size? I mean p9_client_read() =
etc.
> are automatically limiting the read/write chunk size accordingly.

For reads not so much, but for writes it would mean that a dirty folio is
either entirely written or entirely failed.  I don't know how important th=
is
would be for the 9p usecases.

David


