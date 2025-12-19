Return-Path: <linux-fsdevel+bounces-71749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 511F9CD031A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 15:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06ED630A322C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F2E327C0B;
	Fri, 19 Dec 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAPtK90L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE2327BF5
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766152931; cv=none; b=q3BPaHDNltMpxwvJp1r4Hg7I972k+RKRCfmppugS8N0O+T2Z7FKGSUcqz6bUw+f4J4D5Ht+1m0k95YR/8KpX2yQt8SQ6JfxxBH0HU+ez1WYMBQZlOM5Iovs7mNNDjNxgwGoGCMc46qjf3h/hKdEMLCnineJj5ohwHcFvPWoEwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766152931; c=relaxed/simple;
	bh=lYIXcGcrOPmOZzFUGlVjofb/tOUmKZRLWpRMjul5nf0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=eBoziqt9chZiD6NgwJHDTDJmAoI+4OQzB+tOHrwpWom1ERaPEGVGfsf3Q+wcTBq4gHRoLz82ZIDY0elILuBqtf4gARhMHdozLr7dbPGVIHoFGF9mr9PrTXJNO0hEvfSNd5qLbcPA+J+4hBUtnBWE1yWmzIxwbmIQhTKydnaRHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAPtK90L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766152928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yzNnOFBqwNj3DGyLxibs+wwctNsN2xP1MIdjPWFUw7s=;
	b=cAPtK90Lm2ZcHuYxr09OzmCkhotou5Rj5HW204PE22N9sDVmO54T9jJIjDeF1JMzIjrkwN
	CK7kHbnWzYJ2L3sRzEIEnlOgUUztjVidYhQiOQsU7tIFQAfjghD1ymn/lIFUUZeNXS19DI
	Caymw78HpR/T7EKQjgbZa9b9Q7x1Kzs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-ou7AYO8ANTehcnavAX8JjA-1; Fri,
 19 Dec 2025 09:02:05 -0500
X-MC-Unique: ou7AYO8ANTehcnavAX8JjA-1
X-Mimecast-MFC-AGG-ID: ou7AYO8ANTehcnavAX8JjA_1766152923
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DA8E1955DD1;
	Fri, 19 Dec 2025 14:02:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6616D30001A2;
	Fri, 19 Dec 2025 14:01:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aUTP9oCJ9RkIYtKQ@codewreck.org>
References: <aUTP9oCJ9RkIYtKQ@codewreck.org> <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org> <aUMlUDBnBs8Bdqg0@codewreck.org> <aUQN96w9qi9FAxag@codewreck.org> <8622834.T7Z3S40VBb@weasel> <aUSK8vrhPLAGdQlv@codewreck.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: dhowells@redhat.com, Christian Schoenebeck <linux_oss@crudebyte.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Chris Arges <carges@cloudflare.com>, v9fs@lists.linux.dev,
    linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
    linux-fsdevel@vger.kernel.org
Subject: Re: 9p read corruption of mmaped content (Was: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter() iovec)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <818488.1766152917.1@warthog.procyon.org.uk>
Date: Fri, 19 Dec 2025 14:01:57 +0000
Message-ID: <818489.1766152917@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Dominique Martinet <asmadeus@codewreck.org> wrote:

>    netfs_collect_folio: R=00001b55 ix=00003 r=3000-4000 t=3000/5fb2
>    netfs_folio: i=157f3 ix=00003-00003 read-done
>    netfs_folio: i=157f3 ix=00003-00003 read-unlock
>    netfs_collect_folio: R=00001b55 ix=00004 r=4000-5000 t=4000/5fb2
>    netfs_folio: i=157f3 ix=00004-00004 read-done
>    netfs_folio: i=157f3 ix=00004-00004 read-unlock
>    netfs_collect_folio: R=00001b55 ix=00005 r=5000-5fb2 t=5000/5fb2
>    netfs_folio: i=157f3 ix=00005-00005 read-done
>    netfs_folio: i=157f3 ix=00005-00005 read-unlock
>    ...
>    netfs_collect_stream: R=00001b55[0:] cto=5fb2 frn=ffffffff
>    netfs_collect_state: R=00001b55 col=5fb2 cln=6000 n=c
>    netfs_collect_stream: R=00001b55[0:] cto=5fb2 frn=ffffffff
>    netfs_collect_state: R=00001b55 col=5fb2 cln=6000 n=8
>    ...
>    netfs_sreq: R=00001b55[2] ZERO SUBMT f=000 s=5fb2 0/4e s=0 e=0
>    netfs_sreq: R=00001b55[2] ZERO TERM  f=102 s=5fb2 4e/4e s=5 e=0

This would seem to show a problem, if not the problem.

We unlocked page ix=00005 before doing the ZERO subreq that clears the page
tail.  That shouldn't have happened since the collection point hasn't reached
the end of the folio yet.

David


