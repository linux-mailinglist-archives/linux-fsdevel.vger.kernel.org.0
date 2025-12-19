Return-Path: <linux-fsdevel+bounces-71729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCD2CCFB28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 893E330985DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674E8330B07;
	Fri, 19 Dec 2025 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdzwsKZ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE332C320
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145656; cv=none; b=Ma2t8aOvQm0E0sQ+JrXDnpUivpvlCiJBgLpSSfRzaOQ2sIc7s+8dP8gOcD2MXwoMB11TeSotB5D6XL3j0lSzmIVRpGLGICXeC77EEyvotqa8tJ0eGiwOteWbefKod8SDj3gZMOYrfs6Xjy5QpBjVUesAHuM2OVjBOCpVljuFocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145656; c=relaxed/simple;
	bh=o0HDiAgm6YoMMOiGzNHnvcGVdbnbyQhF9T5VOu7HjCI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=CYB5ctuH2AwHfRfi68J0QUpcYxH75XIgaCwKvv9iPintK01WP1XYGkcLFI+FWZvpeUXPrE4Sy/LEmUH8JsGkszj6YcMNubs3uPZ8NIOHvkGhGTSZg5KhVwBQeWk9tnD9ZIr8/RsE/LJBmMUIgtl56DbLgLvEBGr8YHQLiImIeMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdzwsKZ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766145654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PPSWZV3CkHkyoWP6rsb6wn7o4NWFSfXRt1eUkC896Oo=;
	b=LdzwsKZ98ut/mJS8IUFHXVaW4Ego6JZ2IsH3C++nslhySWz3NB0hrNaBMccHBbht4BiZnB
	Z4ZAO1mL0LxzHuZOcSDWVUkI9an9UEVUXvFKk0nQSTJVZUuIFTgZjymzT2/MnEIrPeHl9l
	v6aQVBzG3vXK0huv6vjjuz3UdS3YeqU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-CHGpdqCPPL6ozMMWE-738A-1; Fri,
 19 Dec 2025 07:00:50 -0500
X-MC-Unique: CHGpdqCPPL6ozMMWE-738A-1
X-Mimecast-MFC-AGG-ID: CHGpdqCPPL6ozMMWE-738A_1766145648
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 226C61956050;
	Fri, 19 Dec 2025 12:00:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB593180045B;
	Fri, 19 Dec 2025 12:00:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aT-iwMpOfSoRzkTF@infradead.org>
References: <aT-iwMpOfSoRzkTF@infradead.org> <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org> <aTkNbptI5stvpBPn@infradead.org> <aTkjWsOyDzXq_bLv@codewreck.org> <aTkwKbnXvUZs4UU9@infradead.org> <aT1qEmxcOjuJEZH9@codewreck.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, asmadeus@codewreck.org,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
    Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
    Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter() iovec
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <815007.1766145642.1@warthog.procyon.org.uk>
Date: Fri, 19 Dec 2025 12:00:42 +0000
Message-ID: <815008.1766145642@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Christoph Hellwig <hch@infradead.org> wrote:

> So right now except for netfs everything is on a kvec.  Dave, what
> kind of iov_iter does netfs send down to the file system?

It depends.  For buffered I/O it's a ITER_FOLIOQ, as you might expect for both
reading and writing.

For direct (and unbuffered) I/O, it's more complicated.

For direct writes, if the source iter is user-backed, it'll be extracted to an
ITER_BVEC by netfs_extract_user_iter().  This calls iov_iter_extract_pages()
to do the pinning - and netfs will release the pins later.  However, the
network layer, if MSG_SPLICE_PAGES is set will attempt to take refs on those
pages.

For direct writes, if the source iter is ITER_BVEC/KVEC/FOLIOQ (also XARRAY,
but I'm trying to get rid of that), netfs passes a slice of the source iter
down to the filesystem.  Netfs does not take refs on it as there's no
guarantee that the memory it points to has pages with refcounts.

Netfs will at some point soon hopefully acquire the ability to do bounce
buffering, but it's not there yet.

Direct reads work the same as direct writes.

> I had a bit of a hard time reading through it, but I'd expect that any page
> pinning would be done in netfs and not below it?

Page pinning is done by netfs_extract_user_iter() calling
iov_iter_extract_pages() - but only for user-backed iterators.  The network
layer needs a way to be told how to handle these correctly (which it doesn't
currently).

kernel-backed pages may not be pinned or ref'd.  They can be buffered instead,
but pinning and ref-taking is not permitted for, say, kmalloc'd buffers.
Instead, we need to use a callback from the network layer to indicate
completion - and the network layer needs to change to not ref the pages.

(Note "pinning" != "ref-taking" thanks to GUP terminology)

> Why are we using iov_iters here and not something like a bio_vec?

Because your idea of vmalloc'ing a big bio_vec[] and copying it repeatedly in
order to stick bits on the ends is not good.  I have a relatively simple
solution I'm working on - and mostly have working - but the act of allocating
and transcribing into a bio_vec[] incurs a noticeable performance penalty:-/.

This will hopefully allow me to phase out ITER_FOLIOQ, but I will still need a
folio list inside netfs, firstly because we may have to split a folio across
multiple RPC ops of different sizes to multiple devices in parallel and
secondly because as Willy's plans unfold, folio structs will no longer be
colocated with page structs and page structs will be dynamically allocated and
looked up in some sort of tree instead of a flat array - which means going
from physaddr in bio_vec[] to struct folio will suck when it comes to cleaning
up the page flags after I/O.

>  What is the fs / transport supported to do with these iters?

Pass them to sendmsg() or recvmsg().  That's what they currently do.

David


