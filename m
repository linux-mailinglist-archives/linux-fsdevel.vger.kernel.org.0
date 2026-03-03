Return-Path: <linux-fsdevel+bounces-79277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAk8Gagwp2mbfgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 20:04:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FAF1F59CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 20:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2C133101605
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 19:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E5371878;
	Tue,  3 Mar 2026 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBXTdrab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851537F016
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564459; cv=none; b=mwU0CiWhi9ywNJ9Vi1fzFl+eK2Dh5EK/S3fOeJ4Q8wpiV+alkwYvU2HwCSO172RBU+W0VkVSs/dQmb7tDxHNJ51Ck3O3uDTxLw3c2n8xn8Zhd3faHSmJu7M0N+CCw3lHw6vDiILy1uHf7hykDGczjSsmsv2qWThEyslqnxkZzUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564459; c=relaxed/simple;
	bh=it2PhwAJzHrNlHtUMjkccT7SK9XvkAxfTeL33bwhIH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+tlPyEmpBBPHU3rZWn0R4VbtzL3+nKUoUFQsYjeQ0jUG6Xi8CIahO6rIdPvthHRfhVeqZE/d/312pCmSqqX9RfJqdsgY3w7K1M1cxYTFHmDnaXnQEvQUGh/jTkmojtukRuBLISvD+qqMmJlSCA0/oVALX/onQZSQO/iQ7xPM8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBXTdrab; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772564455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ro+alnpaYPBuJVhNA1DURbitqa28ZNy+hRQTskYZdWI=;
	b=hBXTdrab6KYT7/7kFzOY5L+tmzLcEBYIOnZtDr0Hwz1yYkSFAQjR0rCWvIJZfcx9mbgCmz
	4QJ6v4zGaP3D5+X5R4FrP0Xs3sJ/h3Slhk04ifAhsp63vpabbzhd4WDeZERmaFDXOYMOT6
	8cG/vPuhm5caFnh6T3P8H++9Bqt3giU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-hPzaIKoWPQyhOAS_b-hPUA-1; Tue,
 03 Mar 2026 14:00:51 -0500
X-MC-Unique: hPzaIKoWPQyhOAS_b-hPUA-1
X-Mimecast-MFC-AGG-ID: hPzaIKoWPQyhOAS_b-hPUA_1772564450
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF8851955F1D;
	Tue,  3 Mar 2026 19:00:49 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35C7B1956053;
	Tue,  3 Mar 2026 19:00:49 +0000 (UTC)
Date: Tue, 3 Mar 2026 14:00:47 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <aacv39AZ5P9ubOZ5@bfoster>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-2-bfoster@redhat.com>
 <aY6_eqkIrMkOr039@infradead.org>
 <aY9hY7TwgMXJNzkI@bfoster>
 <aaXesgEmu46X7OwD@bfoster>
 <aabyFY0l7GTEHnoQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabyFY0l7GTEHnoQ@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: C6FAF1F59CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79277-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 06:37:09AM -0800, Christoph Hellwig wrote:
> On Mon, Mar 02, 2026 at 02:02:10PM -0500, Brian Foster wrote:
> > I got a chance to look into this. Note that I don't reproduce a
> > generic/127 failure (even after running a few iters), so I don't know if
> > that might be related to something on your end. I reproduce the other
> > two and those looked like straight failures to zero. From that I think
> > the issue is just that xfs_zoned_buffered_write_iomap_begin() minimally
> > needs the flush treatment from patch 1. I.e., something like the
> > appended diff allows these tests to pass with -rzoned=1.
> > 
> > Technically this could use the folio batch helper, but given that we
> > don't use that for the unwritten case (and thus already rely on the
> > iomap flush), and that this is currently experimental, I think this is
> > probably fine for now. Perhaps if we lift zeroing off into its own set
> > of callbacks, that might be a good opportunity to clean this up in both
> > places.
> 
> Note that unwritten extents aren't supported for zoned rt inodes, so
> that case doesn't actually exist.
> 

Oh I see. If I follow the high level flow here, zoned mode always writes
through COW fork delalloc, and then writeback appears to remove the
delalloc mapping and then does whatever physical zone allocation magic
further down in the submission path. So there are no unwritten extents
nor COW fork preallocation as far as I can tell.

I think that actually means the IOMAP_ZERO logic for the zoned
iomap_begin handler is slightly wrong as it is. I was originally
thinking this was just another COW fork prealloc situation, but in
actuality it looks like zoned mode intentionally creates this COW fork
blocks over data fork hole scenario on first write to a previously
unallocated file range.

IOMAP_ZERO returns a hole whenever one exists in the data fork, so that
means we're not properly reporting a data mapping up until the range is
allocated in the data fork (i.e. writeback occurs at least once). The
reason this has worked is presumably because iomap does the flush when
the range of a reported hole is dirty, so it retries the mapping lookup
after blocks are remapped and DTRT from there.

So the fix I posted works just the same.. lifting the flush just
preserves how things work today. But I think what this means is that we
should also be able to rework zoned mode IOMAP_ZERO handling to require
neither the flush nor dirty folio lookup. It should be able to return a
mapping to zero if blocks exist in either fork (allocating to COW fork
if necessary), otherwise report a hole.

Hmm.. maybe I'll take a look if we can do something like that from the
start. If it's not straightforward, I'll keep the flush fix for now and
come back to it later..

Brian

> The changes themselves look good.  I kinda hate the very deep
> indentation, but I can't really see a good way to fix that easily.
> 
> 


