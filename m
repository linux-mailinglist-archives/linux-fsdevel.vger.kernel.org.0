Return-Path: <linux-fsdevel+bounces-51159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355B1AD35E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 14:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795BC176BE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 12:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089C528FFD6;
	Tue, 10 Jun 2025 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMd1EfyS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37BF28FFC0
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557873; cv=none; b=E9JpruidLdxkrvXj8kcXdNTQWj35t7wtqQOPnFg7sLfzXf6atR7bbtgrtTMMC2zeZOwqulnz9cMjrHJ6O2eSZzqZ9UdiG+rMMW8+ghrfDey2VcBTXkixiDah0qMFh9McqTl1MjajJ6WEAcgrYPYV6zjvmm5J24wFoYJVFf7aTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557873; c=relaxed/simple;
	bh=WR1IvjKce/LjzRZOcbtmWruofFOuKxjHeqIAxYhXmbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WA72I2Hl3P0diYUrorNK/PAT1dUXKZ7+kYRlEP9xzZ56UWDIPoG5qCw3TDEFBzzI9/jDSGKF2oupiGBJHOpwspNL/Sc/rwVOEP7h98s9UI1wCpaPs2YPPmS92qObETtb1AEtqYPq/2cG9mJUdyj8smIAZXmhrntdDfUiM+VWUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMd1EfyS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749557871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/6IzAqLESSIhSDCeJuIE6lmtZtXtjyDSciPHX9jJ0I=;
	b=dMd1EfySxpaxcute4mx9NoQNLhaElL6Id1VANixW0CgahZCs1Gu1Xis47pq0tqzy4sJojN
	WAV9RICse+pAA+a1kQwr/TJiFbQf/tHMmqsYm+IMWfM54ovKT4VlgMmwPtrk3aUffp204O
	kdADLt2cvpcrOheWf9iPPE0UccB+5Y8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-hoz5Q-XIM8CfhM5YiT0kww-1; Tue,
 10 Jun 2025 08:17:45 -0400
X-MC-Unique: hoz5Q-XIM8CfhM5YiT0kww-1
X-Mimecast-MFC-AGG-ID: hoz5Q-XIM8CfhM5YiT0kww_1749557864
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE4191800366;
	Tue, 10 Jun 2025 12:17:43 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B368830001B1;
	Tue, 10 Jun 2025 12:17:41 +0000 (UTC)
Date: Tue, 10 Jun 2025 08:21:16 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/7] iomap: optional zero range dirty folio processing
Message-ID: <aEgjPCJ0hi0oew4y@bfoster>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-4-bfoster@redhat.com>
 <20250609160420.GC6156@frogsfrogsfrogs>
 <aEe0G8a8qL2CjgOg@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEe0G8a8qL2CjgOg@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jun 09, 2025 at 09:27:07PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 09, 2025 at 09:04:20AM -0700, Darrick J. Wong wrote:
> > > +	if (iter->fbatch) {
> > > +		struct folio *folio = folio_batch_next(iter->fbatch);
> > > +
> > > +		if (folio) {
> > > +			folio_get(folio);
> > > +			folio_lock(folio);
> > 
> > Hrm.  So each folio that is added to the batch isn't locked, nor does
> > the batch (or iomap) hold a refcount on the folio until we get here.
> 
> find_get_entry references a folio, and filemap_get_folios_dirty
> preserves that reference.  It will be released in folio_batch_release.
> So this just add an extra reference for local operation so that the
> rest of iomap doesn't need to know about that magic.
> 

Exactly.

> > Do
> > we have to re-check that folio->{mapping,index} match what iomap is
> > trying to process?  Or can we assume that nobody has removed the folio
> > from the mapping?
> 
> That's a good point, though  as without having the folio locked it
> could get truncated, so I think we'll have to redo the truncate
> check here.
> 
> 

Hm Ok thanks, I'll take a closer look at that..

Brian


