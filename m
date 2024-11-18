Return-Path: <linux-fsdevel+bounces-35104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A175D9D127B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 14:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4561F23A0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 13:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B80B19D88D;
	Mon, 18 Nov 2024 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0Cnq2Gz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94B19ABCB
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938005; cv=none; b=aFhzeAOg9JbmQDW4uQzX0/4Mh4prRF4rUMpPSJghOI8cz8wh5SDHDojJAgEaLYi9i/Gy5OowcK0Fg3Sa66lkWHdatkF48Wwm6BAWqqkuan4jAZlLhK6AFId1+u8CgvXxfMiVRVTfOBfDpTHa8bz5xHeXzzEZ7hLHcioYqe0fINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938005; c=relaxed/simple;
	bh=vrrZwIA5mLsxJTexH4Ruo56nZj/iQ04rKBtfus6Snww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcCcjAh5Fhp0AXUCq8A5dECztxDOlexPjGTs5TVCUmOFvxshQTJD0SvN4ebJUSifV92p94I7odIg2gxofX5kZaQukRFyo0oYLsV4bsXrn+YSGXhaQIFMfx0O0NvXVbEcavFW3RKnwN5wDZFGSGRFtCXR7E7tgtb21dAwFG0J5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0Cnq2Gz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731938002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jNM+Ggdd5VK5j8i8cpp4E7tzP93ElEYjMY80yCgImfQ=;
	b=K0Cnq2Gz99wNfXKG+UzKPWUbpxTE4u/ueen8axoDV0ZC4HsmvHMw/+HPJOPqyotckU5jZt
	rE21+Ul827zcmNRc5GMZTTILbacmxq1zrdDRQ4GPsRfYd8GE1oE6i82hBN5e2ER7kWAsaL
	Zf8lh5dhPi+GSwYhTdY47oeZwpJDaxw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-eLiPnp_EOhqjFnOGZK8npQ-1; Mon,
 18 Nov 2024 08:53:21 -0500
X-MC-Unique: eLiPnp_EOhqjFnOGZK8npQ-1
X-Mimecast-MFC-AGG-ID: eLiPnp_EOhqjFnOGZK8npQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9161F1955F41;
	Mon, 18 Nov 2024 13:53:19 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97BC630001A0;
	Mon, 18 Nov 2024 13:53:18 +0000 (UTC)
Date: Mon, 18 Nov 2024 08:54:51 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	djwong@kernel.org
Subject: Re: [PATCH v4 2/3] iomap: lift zeroed mapping handling into
 iomap_zero_range()
Message-ID: <ZztHK7WTZLu2V8bD@bfoster>
References: <20241115200155.593665-1-bfoster@redhat.com>
 <20241115200155.593665-3-bfoster@redhat.com>
 <Zzre3i7UZARRpVgC@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzre3i7UZARRpVgC@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Nov 17, 2024 at 10:29:50PM -0800, Christoph Hellwig wrote:
> On Fri, Nov 15, 2024 at 03:01:54PM -0500, Brian Foster wrote:
> > In preparation for special handling of subranges, lift the zeroed
> > mapping logic from the iterator into the caller. Since this puts the
> > pagecache dirty check and flushing in the same place, streamline the
> > comments a bit as well.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> I don't want to block this improvement on stylistic things, but
> I still don't like moving more code than the function invocation into
> the iter body.  I hope you're okay with me undoing that sooner or later.
> 
> 

I actually think it's easier for you to just fix it up according to your
needs rather than spin around on the list on it, since I'm not totally
clear on what the goal is here anyways.

Not sure if you saw my comment here [1], but my goal is to eventually
remove this code anyways in favor of something that supports more of a
sparse folio iteration. Whether it gets removed first or reworked in the
meantime as part of broader cleanups isn't such a big deal. I just want
to point that out so it's clear it's not worth trying too hard to
beautify it.

Brian

[1] https://lore.kernel.org/linux-fsdevel/ZzdgWkt1DRCTWfCv@bfoster/


