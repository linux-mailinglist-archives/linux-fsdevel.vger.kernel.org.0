Return-Path: <linux-fsdevel+bounces-40796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE1A27BD2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7BA3A15F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42251547D8;
	Tue,  4 Feb 2025 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBT6x5Qw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F22045A8
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698397; cv=none; b=MT2HMiJl/V5RABz7nkGnkAOkWoMKwZm23YcPsbzsvlX70Fwqbb07sRtuw+iAbc5zsj+bzodctqN8k6uwNIcs9+w5waEaPGDfhIuR1FXOdGOu9e8lvwItOLxQzXg1q+Vt4VQ/t8w+irDFE+LtHTm+7EwDtydOnev2QIEduzMlCes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698397; c=relaxed/simple;
	bh=31njNMVaG7WaLHJQ97kDvHDfCOIKYLVTuULO4m5nTb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQr3VGhkvv+zgWMkP5UoTwZulk+spFjoWoKkwpMtQxjRHuT2rjETRlAG+ytFR1ciQp0vnE3VLIrk9iPBASBTcfaNWr/TB7fNkE+E97QezM46JMOPUi1VptywyjNVd4BdBt331SxdBSUeUYtBhVsguPOTIianDdvXfvOxBQPblqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBT6x5Qw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738698394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AkiawKxictVEYAq65vSjLKXW3LKyZTiWo/d+bW5bCc=;
	b=JBT6x5QwUemYe75bxMMGnjxPa+TvnHA3/mtQMV5VWJCOnSo4fWWFHlVmud1+MkZjzRBmmh
	eKN+Ilf5VerFvWHn8/sQKaJbeVnb0zuNA+MSz1QwnkM33HNsWkG0N4WX7UzRAg+KoZWKJn
	vT1LYrqHFMOHCClycCsa4sf3F3MnkTE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-x7fU8232NJSenZEStsO8JQ-1; Tue,
 04 Feb 2025 14:46:29 -0500
X-MC-Unique: x7fU8232NJSenZEStsO8JQ-1
X-Mimecast-MFC-AGG-ID: x7fU8232NJSenZEStsO8JQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5619C19560BA;
	Tue,  4 Feb 2025 19:46:28 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D894195608E;
	Tue,  4 Feb 2025 19:46:26 +0000 (UTC)
Date: Tue, 4 Feb 2025 14:48:52 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 04/10] iomap: lift error code check out of
 iomap_iter_advance()
Message-ID: <Z6JvJK7_0JZJ1Ki9@bfoster>
References: <20250204133044.80551-1-bfoster@redhat.com>
 <20250204133044.80551-5-bfoster@redhat.com>
 <20250204192353.GC21808@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204192353.GC21808@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Feb 04, 2025 at 11:23:53AM -0800, Darrick J. Wong wrote:
> On Tue, Feb 04, 2025 at 08:30:38AM -0500, Brian Foster wrote:
> > The error code is only used to check whether iomap_iter() should
> > terminate due to an error returned in iter.processed. Lift the check
> > out of iomap_iter_advance() in preparation to make it more generic.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/iter.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> > index a2ae99fe6431..fcc8d75dd22f 100644
> > --- a/fs/iomap/iter.c
> > +++ b/fs/iomap/iter.c
> > @@ -30,8 +30,6 @@ static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
> >  	bool stale = iter->iomap.flags & IOMAP_F_STALE;
> >  	int ret = 1;
> >  
> > -	if (count < 0)
> > -		return count;
> >  	if (WARN_ON_ONCE(count > iomap_length(iter)))
> >  		return -EIO;
> >  	iter->pos += count;
> > @@ -86,6 +84,11 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
> >  			return ret;
> >  	}
> >  
> > +	if (iter->processed < 0) {
> > +		iomap_iter_reset_iomap(iter);
> > +		return iter->processed;
> 
> Doesn't iomap_iter_reset_iomap reset iter->processed to zero?
> 

Urgh.. factoring breakage. Patches 3-6 were all one patch in v3 and for
some reason I left the processed = iter->processed assignment that
avoids this problem for patch 6. That should probably get pulled back to
here. I'll fix that up in v5.

Brian

> --D
> 
> > +	}
> > +
> >  	/* advance and clear state from the previous iteration */
> >  	ret = iomap_iter_advance(iter, iter->processed);
> >  	iomap_iter_reset_iomap(iter);
> > -- 
> > 2.48.1
> > 
> > 
> 


