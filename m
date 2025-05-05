Return-Path: <linux-fsdevel+bounces-48096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F763AA95F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194C417A36D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E05C25C70B;
	Mon,  5 May 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7WN+RX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF025B69E
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455725; cv=none; b=GF0PxPV1RN+nBxKuSKWsdIb6xt1YFKyqLgFLxRnaqmnZYF+T3kHUjivX/5oRbMt8Do+QvtW3B0f1yWab7vzo1qCHImQEX5oavFjtLIHpgjLepMC6RNrz8BIoqyrtilYd1ZeKR4VT30/WkAhVo0c8vmmDEyjbQgicVX2exWiBN2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455725; c=relaxed/simple;
	bh=8tGLQZga7aGZl9It1u/Zab1ln94v0xzP/HHuXGv0CYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOvyZCFnN/ONVSwTZsgGfShQ+b3VKKkCsDYG33AbwaXaV82ly/GRJufOlwWMiBMTkgPJgQi8imRz3ut60BBCsL2petB3zTVyQ17p5Si/uchbDho7b158E6kRU7oIPQ+N5QQ+wcILOvoi9WW4OCRC8ND2/4XzUZzyDt2zLKUAsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7WN+RX0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746455722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m4mPBfADCJa/PKTByycbqjuGZHvNrFHttlmvTewoJV4=;
	b=h7WN+RX0J+aovd6qB9gytgruFY4R4Zoq0RXNtetsAtmmAfa2a0MoZQmrwy5MuCF7sDzOF8
	Uh7xfD5mfIPWvCuUgLR8Ml0v5hpdh9/OBOkVx7r2brR9CA8oR3zCs4zrWH/Yk+/yhVjZ09
	+Q9BGrmo5CULGZiqSN6YuGEAJ443aEc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-Q1kcGsYcNWir-Ex3Sh8Eng-1; Mon,
 05 May 2025 10:35:19 -0400
X-MC-Unique: Q1kcGsYcNWir-Ex3Sh8Eng-1
X-Mimecast-MFC-AGG-ID: Q1kcGsYcNWir-Ex3Sh8Eng_1746455718
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5A26180034A;
	Mon,  5 May 2025 14:35:18 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDBD7195608D;
	Mon,  5 May 2025 14:35:17 +0000 (UTC)
Date: Mon, 5 May 2025 10:38:29 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/6] iomap: helper to trim pos/bytes to within folio
Message-ID: <aBjNZctKamBxQTY7@bfoster>
References: <20250430190112.690800-1-bfoster@redhat.com>
 <20250430190112.690800-5-bfoster@redhat.com>
 <aBh-y_qLVZUGxMU_@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBh-y_qLVZUGxMU_@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, May 05, 2025 at 02:03:07AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 30, 2025 at 03:01:10PM -0400, Brian Foster wrote:
> > +/* trim pos and bytes to within a given folio */
> > +static loff_t iomap_trim_folio_range(struct iomap_iter *iter,
> > +		struct folio *folio, size_t *offset, u64 *bytes)
> > +{
> > +	loff_t pos = iter->pos;
> > +	size_t fsize = folio_size(folio);
> > +
> > +	WARN_ON_ONCE(pos < folio_pos(folio) || pos >= folio_pos(folio) + fsize);
> 
> Should this be two separate WARN_ON_ONCE calls to see which one
> triggered?
> 

Sure, can't hurt.

> > +
> > +	*offset = offset_in_folio(folio, pos);
> > +	if (*bytes > fsize - *offset)
> > +		*bytes = fsize - *offset;
> 
> 	*bytes = min(*bytes, fsize - *offset);
> 

Yep.

> ?
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks.

Brian


