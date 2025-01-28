Return-Path: <linux-fsdevel+bounces-40234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74E0A20B94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 14:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3E53A181E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DA01A8F6D;
	Tue, 28 Jan 2025 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aofDSgWJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C781A0BFE
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738072382; cv=none; b=qPZNW5mRMJCXfYTrP9Qy/SD9HhH/JF0/jbnuFTMn6dZ5ZDqYvvY2+vOzMwhC8uwL0I5SzWM2JBpMVBS1ckg825uCZD1QhNtkGHIRX6rIsN5e1Y7hZLyhfLdKU1R2RjeBiipkHgSb7xu2z4iFPoSOWo4FDkNT5z0ZU9T2daSUcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738072382; c=relaxed/simple;
	bh=JT8JuK/hccVCIG17KLpc3fYTf7jX9W0ROz8fTgRAcVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDJwu1dJodIe49+gAfvnrTPgEjuxvY07YC4OWjJCzxiD0ANsBLG5NUV8YgvjyetL6dgH54H8xA8QPNl80XLGvZI07Jih4zFeW1q5ZXG321SU/lvmm1PEVciSSQPvejdESySNGseUWmxCMQOKlSu9h9kGG9XDwGOYuaEJRZRCD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aofDSgWJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738072378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tALh136RPTYkOX5YwaYl6Mc7dtMdA9l58E8xXpcgk60=;
	b=aofDSgWJPoM2yPdmgeeHvmGKciJs13dlVReTexbWQukOFfahRwhjd5Of2yrz7+Ekx9KjcE
	feF4lcvFbKa1tdOTeb2Htoz9jDp6DBPVvve1g9/ZnV2f//tflWgum0kB/xWwx1XHTVAfXq
	K63uTXffCCHgs7edD989mgmW8hQcOtY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-BLJAXAOwNja8r5EemUXExQ-1; Tue,
 28 Jan 2025 08:52:55 -0500
X-MC-Unique: BLJAXAOwNja8r5EemUXExQ-1
X-Mimecast-MFC-AGG-ID: BLJAXAOwNja8r5EemUXExQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03E0E1955F36;
	Tue, 28 Jan 2025 13:52:54 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.118])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BDCD19560AA;
	Tue, 28 Jan 2025 13:52:53 +0000 (UTC)
Date: Tue, 28 Jan 2025 08:55:05 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iomap: refactor iter and advance continuation
 logic
Message-ID: <Z5jhuVsoM_L4SPRB@bfoster>
References: <20250122133434.535192-1-bfoster@redhat.com>
 <20250122133434.535192-4-bfoster@redhat.com>
 <Z5hsV876-PW46WsA@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5hsV876-PW46WsA@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Jan 27, 2025 at 09:34:15PM -0800, Christoph Hellwig wrote:
> On Wed, Jan 22, 2025 at 08:34:30AM -0500, Brian Foster wrote:
> > +	s64 ret;
> > +	bool stale = iter->iomap.flags & IOMAP_F_STALE;
> 
> Nit: I find code more redable if variables that initialized at
> declaration time (especially when derived from arguments) are
> before plain variable declarations.  Not a big thing here with just
> two of them, but variable counts keep growing over time.
> 

Ack. I have a couple pending changes for followon work I wanted to fold
into a v3 anyways, so I'll make that tweak.

> >  
> > -	if (iter->iomap.length && ops->iomap_end) {
> > +	if (!iter->iomap.length) {
> > +		trace_iomap_iter(iter, ops, _RET_IP_);
> > +		goto begin;
> > +	}
> 
> This might be a chance to split trace_iomap_iter into two trace points
> for the initial and following iterations?  Or maybe we shouldn't bother.
> 

Hmm.. not sure I see the value in a tracepoint just for the initial
case, but maybe we should just move trace_iomap_iter() to the top of the
function? We already have post-lookup tracepoints in iomap_iter_done()
to show the mappings, and that would remove the duplication. Hm?

> Otherwise this looks great:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks.

Brian


