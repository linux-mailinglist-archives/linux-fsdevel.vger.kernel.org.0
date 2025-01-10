Return-Path: <linux-fsdevel+bounces-38898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEE6A098DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 18:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094E51889FED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B43211A06;
	Fri, 10 Jan 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtS5zkgH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAD4400
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531310; cv=none; b=YtB/GMF2LWkQkDhjEF/Rao1Obxmgo9ifiazdfbY7d9+n2awlpb69NmtGAVmUfMkoKPLQGEqtAVohkNISnCaqx4IKN3z8MymdgZA8EYz10Bi5lV6w387PR7nOv5E1sqTYD4MWEWVHsBUviaEjchAotxMt0y4B+J8pO+YHS2ULzU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531310; c=relaxed/simple;
	bh=ZjI0Yq4FGn+GkSXqFo0WF+6B9scZByAqOwWp+No3sYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZZtAjcE23jVWWl5Hd07Jw4VkIn52/i2t9lpb81oTZimdIj0MsYCEgAQkgrGkd3fTnkzXAbM6O2VysTWm1FIOXvLjzw8LMAFGGItEy53UsH1tzc+l4Ow0poeVWwITOfhrVE3LQ7/rk3OoyqZNac1JoPjgxDHGnHOCH/rF5yqAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FtS5zkgH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736531305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=72dg8KM8tRk/8l1kJKpOdVlH3weeTD1Fu7M8nlC2W9E=;
	b=FtS5zkgHWDucUBWo+NkKxLePcVyRAP+Gj9qZK+TbyAFj0oT8JZUtaA4sKQFua9OezSjeNb
	/mxuDFWF6sE/iXqzuux66ygFeYhxF1O+Iaevn8i6KFyGP49x3CyVpIV+Fb0d0yLgXbc03q
	UHzfCJCYvpLET0FbfcjH9FyPCbukU54=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-pvqHy6ALPFe0kzadVIfSJg-1; Fri,
 10 Jan 2025 12:48:21 -0500
X-MC-Unique: pvqHy6ALPFe0kzadVIfSJg-1
X-Mimecast-MFC-AGG-ID: pvqHy6ALPFe0kzadVIfSJg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AC6E1955F79;
	Fri, 10 Jan 2025 17:48:20 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.122])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 424CD195E3D9;
	Fri, 10 Jan 2025 17:48:19 +0000 (UTC)
Date: Fri, 10 Jan 2025 12:50:26 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: support incremental iomap_iter advances
Message-ID: <Z4Fd4tUp1hFmGB2G@bfoster>
References: <20241213143610.1002526-1-bfoster@redhat.com>
 <20241213143610.1002526-4-bfoster@redhat.com>
 <Z391qhtj_c56nfc2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z391qhtj_c56nfc2@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Jan 08, 2025 at 11:07:22PM -0800, Christoph Hellwig wrote:
> On Fri, Dec 13, 2024 at 09:36:07AM -0500, Brian Foster wrote:
> > Note that the semantics for operations that use incremental advances
> > is slightly different than traditional operations. Operations that
> > advance the iter directly are expected to return success or failure
> > (i.e. 0 or negative error code) in iter.processed rather than the
> > number of bytes processed.
> 
> While the uses of the incremental advance later look nice, this bit
> is pretty ugly.  I wonder if we could just move overy everything to
> the incremental advance model, even if it isn't all that incremental,
> that is always call iomap_iter_advance from the processing loop and
> eventually remove the call in iomap_iter() entirely?
> 

Yeah, I agree this is a wart. Another option I thought about was
creating a new flag to declare which iteration mode a particular
operation uses, if for nothing else but to improve clarity.

FWIW my first pass at finding a solution here was actually with intent
to convert everything over, but then I got lost in the weeds of all the
various operations and gave up. I didn't want to spend forever changing
every op over for something before it was shown to work or be useful, so
my thought process was more to try and see this through for zero range
and if that pans out, follow up with changing everything else over as a
later step.

That said, this was early on before I had the idea fleshed out and I
don't recall all the details. I'll make a note to do another audit pass
at this and see how feasible it is. I suppose my immediate question on
that is: suppose the folio batch thing just doesn't pan out for whatever
reason.. would we think this is a worthwhile iteration cleanup on its
own?

> > @@ -36,7 +36,7 @@ static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
> >  		return -EIO;
> >  	iter->pos += count;
> >  	iter->len -= count;
> > -	if (!iter->len || (!count && !stale))
> > +	if (!iter->len || (!count && !stale && iomap_length(iter)))
> 
> This probably warrantd a comment even with the existing code, but really
> needs one now.
> 

Ack.

> > + * @iter_spos: The original start pos for the current iomap. Used for
> > + *	incremental iter advance.
> 
> Maybe spell out the usage as iter_start_pos in the field name as spos
> reads a little weird?
>

Ack.

Brian 


