Return-Path: <linux-fsdevel+bounces-40982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A22F9A29B1F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 21:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABC81655C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3364D2116F9;
	Wed,  5 Feb 2025 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1qCcfsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC3A846F
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738787112; cv=none; b=jd5Egm89ffai0S49RF8mRf3ow0mcEaa7zfx5j17vc5GHogpekQvP3wv9fWTnNQu5pKaWDZrHtey2JvK2f0kOS1v5318XBwX7jEoyeAuxH7Oqkf8mVBwftke5f35/xOeQy4XtLStBdiPtRy13BXE5JTtg9nswAofgmJO7IyVk/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738787112; c=relaxed/simple;
	bh=y/2NvVX2i0xJu8eDUkHz/Cnr+Ovxo5e6swckZfHCzZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtNzqHE8j5/p89c9aN4CcO0+U/osKhFQaRVf18ud+g/kMdJF5Vb61c7JV6W6iYbMiozbdibmWJFxZoV1zJhJd4l32SgY9zoppUEZ6QDsvegY8VmVGKdQDC/aoPVXNxnh+lyNF+GLVA7GCcAh2h6Fz/nAHVqueKs4FcM0jo+xlv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O1qCcfsi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738787110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKWUKlQeFRtrc/aYAbNT7uztxfgG+kxou6xZ6sInWHw=;
	b=O1qCcfsiWxkDXSnyGEbPGHkcm3/ChtSIlNPe2wqHYQGEa8HGCRtSFjhV0NKcBKV2hFjdk/
	IzAopqZIeK8k0aRMAEpfpcZ6jfQcgtPN30e0eVzAkR3vSMCfmNuFz5dNc65QnnL0F8R00C
	lOvGjrhUnnuUxtXLBLk+2sMhJX81P3I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-dDgkHZ3WPti2h2Grg5w-UA-1; Wed,
 05 Feb 2025 15:25:08 -0500
X-MC-Unique: dDgkHZ3WPti2h2Grg5w-UA-1
X-Mimecast-MFC-AGG-ID: dDgkHZ3WPti2h2Grg5w-UA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F9301956089;
	Wed,  5 Feb 2025 20:25:07 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B1AB1800570;
	Wed,  5 Feb 2025 20:25:05 +0000 (UTC)
Date: Wed, 5 Feb 2025 15:27:31 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 09/10] iomap: advance the iter directly on unshare
 range
Message-ID: <Z6PJs8RvbcfNJNcC@bfoster>
References: <20250205135821.178256-1-bfoster@redhat.com>
 <20250205135821.178256-10-bfoster@redhat.com>
 <20250205191610.GS21808@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205191610.GS21808@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Feb 05, 2025 at 11:16:10AM -0800, Darrick J. Wong wrote:
> On Wed, Feb 05, 2025 at 08:58:20AM -0500, Brian Foster wrote:
> > Modify unshare range to advance the iter directly. Replace the local
> > pos and length calculations with direct advances and loop based on
> > iter state instead.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/buffered-io.c | 23 +++++++++++------------
> >  1 file changed, 11 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 678c189faa58..f953bf66beb1 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1267,20 +1267,19 @@ EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
> >  static loff_t iomap_unshare_iter(struct iomap_iter *iter)
> >  {
> >  	struct iomap *iomap = &iter->iomap;
> > -	loff_t pos = iter->pos;
> > -	loff_t length = iomap_length(iter);
> > -	loff_t written = 0;
> > +	u64 bytes = iomap_length(iter);
> > +	int status;
> >  
> >  	if (!iomap_want_unshare_iter(iter))
> > -		return length;
> > +		return iomap_iter_advance(iter, &bytes);
> >  
> >  	do {
> >  		struct folio *folio;
> > -		int status;
> >  		size_t offset;
> > -		size_t bytes = min_t(u64, SIZE_MAX, length);
> > +		loff_t pos = iter->pos;
> 
> Do we still need the local variable here?
> 

Technically no.. Christoph brought up something similar in earlier
versions re: the pos/len variables (here and in subsequent patches) but
I'm leaving it like this for now because the folio batch work (which is
the impetus for this series) further refactors and removes much of this.

For example, pos gets pushed down into the write begin path so it can
manage state between the next folio in a provided batch and the current
position of the iter itself. So this pos code goes away from
unshare_iter() completely and this patch is just moving things one step
in that direction.

> Otherwise looks right to me, so
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 

Thanks.

Brian

> --D
> 
> >  		bool ret;
> >  
> > +		bytes = min_t(u64, SIZE_MAX, bytes);
> >  		status = iomap_write_begin(iter, pos, bytes, &folio);
> >  		if (unlikely(status))
> >  			return status;
> > @@ -1298,14 +1297,14 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
> >  
> >  		cond_resched();
> >  
> > -		pos += bytes;
> > -		written += bytes;
> > -		length -= bytes;
> > -
> >  		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
> > -	} while (length > 0);
> >  
> > -	return written;
> > +		status = iomap_iter_advance(iter, &bytes);
> > +		if (status)
> > +			break;
> > +	} while (bytes > 0);
> > +
> > +	return status;
> >  }
> >  
> >  int
> > -- 
> > 2.48.1
> > 
> > 
> 


