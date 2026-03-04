Return-Path: <linux-fsdevel+bounces-79405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEpKOWhHqGlOrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:53:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FECF201F8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B37F3303EFDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35293AEF4E;
	Wed,  4 Mar 2026 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjHphBoV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFDA30E82D
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635874; cv=none; b=EEaHVGhH+r3QvIglHpmnaV5mQt0D4Q1LM3mOFlS3zyVDBHthXbURM/RMM5npZfBfh4vrOrET0sMv9qw2fcf9kAExVc2PBVYLg94nVKuS6V7V+pwpPesx5L0djS3Gu+Ya3Oqb/ga+UM/HDokBL7qIlcyYCBOiInLxlikW9SM1e+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635874; c=relaxed/simple;
	bh=W8Cm5qIm4LQaWOvdq5hm44m3NqWwxLD5twkpvrzNyaE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=kunjW1piUhqjxDEp9Lf2xySmULUnV+c+rRFfOT4gXrQZgGvUy4Yi4hC4zRJZdpRibwxysWVdeNej+zEnN5tzcPHUu+wgXWtp47LPxlq8zrTl0RZCBMpsSgQlZtEEFPvz8sYlFJXCbInAeOhj2SJqqfTBPvRQ7FIcv+PfPhGwvCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjHphBoV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772635872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EIl/qIW2FbP2w2w5PevLs3/QQXME7hdmijpTZj9387g=;
	b=QjHphBoV4nqYlkwjMtR8CIkjMU5joPv1xzYasB8KVqQPmwZ8DRHwHzpIC4+J0FSM1Pwt0J
	5nt11H8PpdOTyGDLgrSXKFpJH/sIud6g5b3lo/mhB4NHF28DUVB5ddwXvPb/P9lEyDMskT
	FZeOdr+pjh3u/oAT/uugSRxraZ4/o0Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-1_qf4EzWN0Cw_Svt9tcqww-1; Wed,
 04 Mar 2026 09:51:09 -0500
X-MC-Unique: 1_qf4EzWN0Cw_Svt9tcqww-1
X-Mimecast-MFC-AGG-ID: 1_qf4EzWN0Cw_Svt9tcqww_1772635867
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EA601956060;
	Wed,  4 Mar 2026 14:51:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.194])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3687195608E;
	Wed,  4 Mar 2026 14:51:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aahEJ7hY-tXRRjJk@infradead.org>
References: <aahEJ7hY-tXRRjJk@infradead.org> <20260304140328.112636-1-dhowells@redhat.com> <20260304140328.112636-18-dhowells@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    Jens Axboe <axboe@kernel.dk>, Leon Romanovsky <leon@kernel.org>,
    Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH 17/17] netfs: Combine prepare and issue ops and grab the buffers on request
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <181469.1772635861.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Mar 2026 14:51:01 +0000
Message-ID: <181470.1772635861@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 5FECF201F8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79405-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,warthog.procyon.org.uk:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Mar 04, 2026 at 02:03:24PM +0000, David Howells wrote:
> > +/*
> > + * Query the occupancy of the cache in a region, returning the extent=
 of the
> > + * next chunk of cached data and the next hole.
> > + */
> > +static int cachefiles_query_occupancy(struct netfs_cache_resources *c=
res,
> > +				      struct fscache_occupancy *occ)
> > +{
> =

> Independent of fiemap or not, how is this supposed to work?  File
> systems can create speculative preallocations any time they want,
> so simply querying for holes vs data will corrupt your cache trivially.

SEEK_DATA and SEEK_HOLE avoid preallocations, I presume?

David


