Return-Path: <linux-fsdevel+bounces-76877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDKPEASFi2neVAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:20:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C924111E9A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B172330599FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D5F330678;
	Tue, 10 Feb 2026 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBv5z+LB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1AB38A738
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770751204; cv=none; b=LEPMx50hcyuWIVF6r6kfuJa2fa1fDUS/f4dlE32e0Dtu6cxmvl7x/nLK8BvUVLx51vFtLaCmNEZzK6+/eSBrzLkqVChX1cX1nyFGB5saOvxztDIGTa/6YZxRSH8HDwjIcQPwPSlQXUgqeHkVbHsMp0UUn2PsC6HGGygQDE3m1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770751204; c=relaxed/simple;
	bh=smeOkN0pEoBbEQBOMDYp8EI9S/NuJmtyNPIxdgVqV1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6x9s2tmETOvHP1BbCHz929nnwHEeOYsp79VQ+pcystSXPneyOl1oWwSZEaq0MV20ybpm+3t9gg7KuAnzUH9+gf/NLUCDQOs193+8DDv7m7aH5BSXeAq3SxDoba5MUqklIX8NZCevvfnChy8cyD1HIethaPW5yMxuydk76/LRUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBv5z+LB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770751201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yrTZH/JYiu3KRVUuaNiw9UxIiZxh8Yy+qtGjOysCAm8=;
	b=IBv5z+LB1SkmGEFM9GZ+Tt0m+4nUbQ8yfHy7KnsvpMsXhuCNInBDUEsWsmntFgcJJSUdFS
	8kolPTNC4Ic5bdl6PsqWQoRhcj+FqlO7D7aa+emXerjrpQRlxG/cMJTbA8uAG37JniofZR
	ezGcCFz/mWTShJSDUPuX0VOYe5HY8mk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-E4O7bXHEMHyA8l0gQE8kaA-1; Tue,
 10 Feb 2026 14:19:57 -0500
X-MC-Unique: E4O7bXHEMHyA8l0gQE8kaA-1
X-Mimecast-MFC-AGG-ID: E4O7bXHEMHyA8l0gQE8kaA_1770751196
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFAC21955F12;
	Tue, 10 Feb 2026 19:19:56 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CD0830001A8;
	Tue, 10 Feb 2026 19:19:55 +0000 (UTC)
Date: Tue, 10 Feb 2026 14:19:53 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 5/5] xfs: replace zero range flush with folio batch
Message-ID: <aYuE2a0DdXZAPwXC@bfoster>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-6-bfoster@redhat.com>
 <aYta8A6dBpjZyb8c@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYta8A6dBpjZyb8c@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76877-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C924111E9A7
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 08:21:04AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 29, 2026 at 10:50:28AM -0500, Brian Foster wrote:
> > Now that the zero range pagecache flush is purely isolated to
> > providing zeroing correctness in this case, we can remove it and
> > replace it with the folio batch mechanism that is used for handling
> > unwritten extents.
> > 
> > This is still slightly odd in that XFS reports a hole vs. a mapping
> > that reflects the COW fork extents, but that has always been the
> > case in this situation and so a separate issue
> 
> I wish we could fix it eventually.  One thing that came to my mind
> a few times would be to do all writes through the COW fork, and
> instead renaming it a 'staging' or similar fork, because it then
> contains all data not recorded into the inode yet.  But that would
> be a huge lift..
> 

I failed to rework this as an initial step (as discussed in the prior
version of this series), but I got back to playing with it a bit after
posting this version and I think I have a prototype that so far seems to
work on top of this series.

For context, the idea is basically that instead of always reporting COW
fork blocks over data fork holes as a hole mapping, we report it as a
shared/COW mapping when the conditions to require zeroing are met. That
basically means that 1. only when the folio batch is not empty and 2.
only when the mapping is fully within EOF. The caveat to the latter is
that we also have to split at the EOF boundary the same way the existing
zero range code does to trigger post-eof delalloc conversion.

This adds a bit more code in the same area as this series. It doesn't
seem terrible so far, but it was one reason I was wondering if this
perhaps warranted splitting off its own callback. The behavior for zero
range here is unique enough from standard read/write ops such that might
be a readability improvement. Since I'm not the only person with that
thought, I'll take a proper look and see if it's worth a prototype to go
along with the mapping behavior change..

Brian

> The patch itself looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 


