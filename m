Return-Path: <linux-fsdevel+bounces-40795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10226A27BCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07C93A2B0C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E35C218EB8;
	Tue,  4 Feb 2025 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJN1pk1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCAA218EB7
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698357; cv=none; b=D6BdQUWDRYZ41GJ2MTk6ksjcSVKhQfI8qi7R8VDlJtrYp1OckWH7LzN5YBy3xpQ5xPkL0J4yu//egLoykCYymF0K9ZCDeRK7hVC7o7ILXOveviMRerEGUQPRPRFBZ/ZMjENm1ziok9K5L51mKJZU96CdbdGAu0qcM1lSxNLQaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698357; c=relaxed/simple;
	bh=VwnTmfzAWVgSqpQSRE8nhjRaR6xj8a7kTfkzXYECGyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad2v+K8YwEAzVphnwJ2AuwzzCfpoQEoHPv9q0dz5no27f1dJnX7oDOdHC0oZy+taFYd3nzXa+TfF6ADeUNBJ5XIaatFfzXN23YpVtrmwxsvWhmw+UxpnuwD5ZWUnnyUFqDlhQ/zyWzwwTZcunufSAvnmzcpBXURiSjLh7b4V4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJN1pk1I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738698354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XKrV5HR+6Foo9Cd0LXegC7lzeoB1C0C7f5Uj0RB30OE=;
	b=bJN1pk1Im0RLGW13tauQt7xBKO7Yb6Cu733TWbvsbckuXYNJbKW0PySz0miB/KOgVQb7Iu
	nBYO6+QeRDNaHUwzrf8wuEKJ4fx/S0eSvNPLilF5QvQEMoob1RKHjRG3L5sEA9n6UjzXdH
	Q1t563wm2HMSvbDiEnRPOE9mY6gEM7Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-_k3BDQWiM8mnXGu3OlbG6A-1; Tue,
 04 Feb 2025 14:45:52 -0500
X-MC-Unique: _k3BDQWiM8mnXGu3OlbG6A-1
X-Mimecast-MFC-AGG-ID: _k3BDQWiM8mnXGu3OlbG6A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF51D1801F17;
	Tue,  4 Feb 2025 19:45:51 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AE6E195608E;
	Tue,  4 Feb 2025 19:45:50 +0000 (UTC)
Date: Tue, 4 Feb 2025 14:48:16 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 02/10] iomap: split out iomap check and reset logic
 from iter advance
Message-ID: <Z6JvACJuZbktb_8X@bfoster>
References: <20250204133044.80551-1-bfoster@redhat.com>
 <20250204133044.80551-3-bfoster@redhat.com>
 <20250204193056.GD21808@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204193056.GD21808@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Feb 04, 2025 at 11:30:56AM -0800, Darrick J. Wong wrote:
> On Tue, Feb 04, 2025 at 08:30:36AM -0500, Brian Foster wrote:
> > In preparation for more granular iomap_iter advancing, break out
> > some of the logic associated with higher level iteration from
> > iomap_advance_iter(). Specifically, factor the iomap reset code into
> > a separate helper and lift the iomap.length check into the calling
> > code, similar to how ->iomap_end() calls are handled.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/iter.c | 49 ++++++++++++++++++++++++++-----------------------
> >  1 file changed, 26 insertions(+), 23 deletions(-)
> > 
> > diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> > index 3790918646af..731ea7267f27 100644
> > --- a/fs/iomap/iter.c
> > +++ b/fs/iomap/iter.c
> > @@ -7,6 +7,13 @@
> >  #include <linux/iomap.h>
> >  #include "trace.h"
> >  
> > +static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
> > +{
> > +	iter->processed = 0;
> > +	memset(&iter->iomap, 0, sizeof(iter->iomap));
> > +	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
> > +}
> > +
> >  /*
> >   * Advance to the next range we need to map.
> >   *
> > @@ -14,32 +21,24 @@
> >   * processed - it was aborted because the extent the iomap spanned may have been
> >   * changed during the operation. In this case, the iteration behaviour is to
> >   * remap the unprocessed range of the iter, and that means we may need to remap
> > - * even when we've made no progress (i.e. iter->processed = 0). Hence the
> > - * "finished iterating" case needs to distinguish between
> > - * (processed = 0) meaning we are done and (processed = 0 && stale) meaning we
> > - * need to remap the entire remaining range.
> > + * even when we've made no progress (i.e. count = 0). Hence the "finished
> > + * iterating" case needs to distinguish between (count = 0) meaning we are done
> > + * and (count = 0 && stale) meaning we need to remap the entire remaining range.
> >   */
> > -static inline int iomap_iter_advance(struct iomap_iter *iter)
> > +static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
> >  {
> >  	bool stale = iter->iomap.flags & IOMAP_F_STALE;
> >  	int ret = 1;
> >  
> > -	/* handle the previous iteration (if any) */
> > -	if (iter->iomap.length) {
> > -		if (iter->processed < 0)
> > -			return iter->processed;
> > -		if (WARN_ON_ONCE(iter->processed > iomap_length(iter)))
> > -			return -EIO;
> > -		iter->pos += iter->processed;
> > -		iter->len -= iter->processed;
> > -		if (!iter->len || (!iter->processed && !stale))
> > -			ret = 0;
> > -	}
> > +	if (count < 0)
> > +		return count;
> > +	if (WARN_ON_ONCE(count > iomap_length(iter)))
> > +		return -EIO;
> > +	iter->pos += count;
> > +	iter->len -= count;
> > +	if (!iter->len || (!count && !stale))
> > +		ret = 0;
> >  
> > -	/* clear the per iteration state */
> > -	iter->processed = 0;
> > -	memset(&iter->iomap, 0, sizeof(iter->iomap));
> > -	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
> 
> Are there any consequences to not resetting the iter if
> iter->iomap.length is zero?  I think the answer is "no" because callers
> are supposed to initialize the iter with zeroes and filesystems are
> never supposed to return zero-length iomaps from ->begin_iomap, right?
> 

That matches my understanding..

> If the answers are "no" and "yes" then
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 

Thanks.

Brian

> --D
> 
> >  	return ret;
> >  }
> >  
> > @@ -82,10 +81,14 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
> >  			return ret;
> >  	}
> >  
> > +	/* advance and clear state from the previous iteration */
> >  	trace_iomap_iter(iter, ops, _RET_IP_);
> > -	ret = iomap_iter_advance(iter);
> > -	if (ret <= 0)
> > -		return ret;
> > +	if (iter->iomap.length) {
> > +		ret = iomap_iter_advance(iter, iter->processed);
> > +		iomap_iter_reset_iomap(iter);
> > +		if (ret <= 0)
> > +			return ret;
> > +	}
> >  
> >  	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
> >  			       &iter->iomap, &iter->srcmap);
> > -- 
> > 2.48.1
> > 
> > 
> 


