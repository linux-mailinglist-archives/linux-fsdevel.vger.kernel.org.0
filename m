Return-Path: <linux-fsdevel+bounces-40980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC8CA29B19
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 21:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74FC3A88A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C323212B3E;
	Wed,  5 Feb 2025 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fB7drKV+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293F720CCF4
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738786987; cv=none; b=gqC/1btnsJaAznSZuheWdvtw9iowCWzTb6ZX2Xm7nWVIyPIk3Q+7SWn++A4kVW3q6cEnYDZODyLxZUf0TIsmvQ3kgq5kwEU915fZd7CR41y92ozRouvtaLXr12QvB8Y6fnnpeLVOUq50aS8elKLeQBdgnnYsUtMIHGtmuNgvnYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738786987; c=relaxed/simple;
	bh=s08+laRbt4tGUaqo0bdSrKIz3v1o6Zw0T9CxiWjBXgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se2oo0zf+N9fom9LBYR8/CmQ4F4hu+5MZaiFR6+WgE3SaopmpHFlLMYkefNFVhZMWsks1cCPf6lkiGHu9LfwKrca2vGtIGhXwkXv30Wk6h3s6ZZwGTA89uogqnF+ro0xtuv6NplqSIfad1dSttzzQr2gJpoi+2w66KVv4ANIu3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fB7drKV+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738786985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hX1ETsk+/ojkDlrb+TeOSZXHsaBrsfJvcStDsHObzSQ=;
	b=fB7drKV+XeSr4UYo7o3/yMsDImO8DFYN0pBqvEJ98iCUvJgVRmZG5QLDWkHLN6Zix4e4oW
	p6G3g07XUh+aDvoff2P0lZBhGc7cBPNTg9NeSARM2mAVdXPUy0FgUbLoZU/tMg3vhJ3JyX
	UIL2JBWkrq7Pl34tbG/hCg0r9ceemww=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-nrxq096yNOm4Qps8uZD50A-1; Wed,
 05 Feb 2025 15:23:00 -0500
X-MC-Unique: nrxq096yNOm4Qps8uZD50A-1
X-Mimecast-MFC-AGG-ID: nrxq096yNOm4Qps8uZD50A
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AFFD1955D82;
	Wed,  5 Feb 2025 20:22:58 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 256ED180087A;
	Wed,  5 Feb 2025 20:22:57 +0000 (UTC)
Date: Wed, 5 Feb 2025 15:25:20 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 06/10] iomap: export iomap_iter_advance() and return
 remaining length
Message-ID: <Z6PJMBYs5HKpH_PX@bfoster>
References: <20250205135821.178256-1-bfoster@redhat.com>
 <20250205135821.178256-7-bfoster@redhat.com>
 <20250205185801.GO21808@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205185801.GO21808@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Feb 05, 2025 at 10:58:01AM -0800, Darrick J. Wong wrote:
> On Wed, Feb 05, 2025 at 08:58:17AM -0500, Brian Foster wrote:
> > As a final step for generic iter advance, export the helper and
> > update it to return the remaining length of the current iteration
> > after the advance. This will usually be 0 in the iomap_iter() case,
> > but will be useful for the various operations that iterate on their
> > own and will be updated to advance as they progress.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/iter.c       | 22 ++++++++--------------
> >  include/linux/iomap.h |  1 +
> >  2 files changed, 9 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> > index 8e0746ad80bd..cdba24dbbfd7 100644
> > --- a/fs/iomap/iter.c
> > +++ b/fs/iomap/iter.c
> > @@ -15,22 +15,16 @@ static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
> >  }
> >  
> >  /*
> > - * Advance to the next range we need to map.
> > - *
> > - * If the iomap is marked IOMAP_F_STALE, it means the existing map was not fully
> > - * processed - it was aborted because the extent the iomap spanned may have been
> > - * changed during the operation. In this case, the iteration behaviour is to
> > - * remap the unprocessed range of the iter, and that means we may need to remap
> > - * even when we've made no progress (i.e. count = 0). Hence the "finished
> > - * iterating" case needs to distinguish between (count = 0) meaning we are done
> > - * and (count = 0 && stale) meaning we need to remap the entire remaining range.
> > + * Advance the current iterator position and return the length remaining for the
> > + * current mapping.
> 
> This last sentence should state that the remaining length is returned
> via @count as an outparam and not through the function's return value.
> 

Ok.

Brian

> Otherwise looks ok to me.
> 
> --D
> 
> >   */
> > -static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
> > +int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
> >  {
> > -	if (WARN_ON_ONCE(count > iomap_length(iter)))
> > +	if (WARN_ON_ONCE(*count > iomap_length(iter)))
> >  		return -EIO;
> > -	iter->pos += count;
> > -	iter->len -= count;
> > +	iter->pos += *count;
> > +	iter->len -= *count;
> > +	*count = iomap_length(iter);
> >  	return 0;
> >  }
> >  
> > @@ -93,7 +87,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
> >  	 * advanced at all (i.e. no work was done for some reason) unless the
> >  	 * mapping has been marked stale and needs to be reprocessed.
> >  	 */
> > -	ret = iomap_iter_advance(iter, processed);
> > +	ret = iomap_iter_advance(iter, &processed);
> >  	if (!ret && iter->len > 0)
> >  		ret = 1;
> >  	if (ret > 0 && !iter->processed && !stale)
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index f5ca71ac2fa2..f304c602e5fe 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -229,6 +229,7 @@ struct iomap_iter {
> >  };
> >  
> >  int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
> > +int iomap_iter_advance(struct iomap_iter *iter, u64 *count);
> >  
> >  /**
> >   * iomap_length_trim - trimmed length of the current iomap iteration
> > -- 
> > 2.48.1
> > 
> > 
> 


