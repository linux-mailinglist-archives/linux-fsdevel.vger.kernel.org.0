Return-Path: <linux-fsdevel+bounces-40310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB4EA221DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 17:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4166216218B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550461DE8BF;
	Wed, 29 Jan 2025 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Duo9zdub"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1033997
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168688; cv=none; b=rpLClOtCRqa3TxPE/XQAeJlNKw9FAt5pqfluRA79Pt3D/AM1aPjxL0qf3V97k4JZog8rvUHM2GDCIG7hzFESgavQ/HYVWgtHHQHzpJahKO8eX84+qpJM8P4SclbKM1I6N1GDtGLWdiJ7boeGQ+rc4Ko6o6ymzw4BiZjbAG6pBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168688; c=relaxed/simple;
	bh=9dnc3UMvxcDakfSi+aJSsnweYWtWFWzzL9kZlBCaaq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/wdvNarkZ+AYZICEEUZ5XNBMB0CL4tnjorYXKc+IKKahvZdPRYRSya8S0ldfaTuQra6+0RiiWHCuYxa//3zpEhkeR1lLAcRFSKBWZJ0pUM9Si25Xcxy4yIJVXPSO737ywI06C0pEW/Br2Zuz4HWJb7ZZyltSBkM9U/WMUPH4Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Duo9zdub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738168686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z6UCBpCPDZaJfs4ehOINBVWWzvORi86h6BNKWsa5pk=;
	b=Duo9zdub7JXkuZiTVHCcxnDyW48WPmLWZiSOsbDTQ8RGexPl6LMyPesAlY98FGTQt2zUMz
	B8QeBe7w79R/8tIZotmnruXPMmRaVPzu7dpQ32OfFbd2fXby9b+TkUlAiIrojL/Dq0C0Dm
	987QWZ9Vzd7B82UGoIZb7O5dsO6v6Ic=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-zuEqlgkAMWSE40G5DR1JcQ-1; Wed,
 29 Jan 2025 11:38:03 -0500
X-MC-Unique: zuEqlgkAMWSE40G5DR1JcQ-1
X-Mimecast-MFC-AGG-ID: zuEqlgkAMWSE40G5DR1JcQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56A5F1956056;
	Wed, 29 Jan 2025 16:38:02 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.113])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C6AF1955BE3;
	Wed, 29 Jan 2025 16:38:00 +0000 (UTC)
Date: Wed, 29 Jan 2025 11:40:13 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iomap: advance the iter directly on unshare range
Message-ID: <Z5pZ7d3hhvP6S-Qj@bfoster>
References: <20250122133434.535192-1-bfoster@redhat.com>
 <20250122133434.535192-7-bfoster@redhat.com>
 <Z5htdTPrS58_QKsc@infradead.org>
 <Z5ka7TYWr7Y9TrYO@bfoster>
 <Z5nC-n2EsEQcmm6X@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5nC-n2EsEQcmm6X@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jan 28, 2025 at 09:56:10PM -0800, Christoph Hellwig wrote:
> On Tue, Jan 28, 2025 at 12:59:09PM -0500, Brian Foster wrote:
> > But that raises another question. I'd want bytes to be s64 here to
> > support the current factoring, but iomap_length() returns a u64. In
> > poking around a bit I _think_ this is practically safe because the high
> > level operations are bound by loff_t (int64_t), so IIUC that means we
> > shouldn't actually see a length that doesn't fit in s64.
> > 
> > That said, that still seems a bit grotty. Perhaps one option could be to
> > tweak iomap_length() to return something like this:
> > 
> > 	min_t(u64, SSIZE_MAX, end);
> > 
> > ... to at least makes things explicit.
> 
> Yeah.  I'm actually not sure why went want to support 64-bit ranges.
> I don't even remember if this comes from Dave's really first version
> or was my idea, but in hindsight just sticking to ssize_t bounds
> would have been smarter.
> 

Ok, thanks.

> > I'd guess the (i.e. iomap_file_unshare()) loop logic would look more
> > like:
> > 
> > 	do {
> > 		...
> > 		ret = iomap_iter_advance(iter, &bytes);
> > 	} while (!ret && bytes > 0);
> > 
> > 	return ret;
> > 
> > Hmm.. now that I write it out that doesn't seem so bad. It does clean up
> > the return path a bit. I think I'll play around with that, but let me
> > know if there are other thoughts or ideas..
> 
> Given that all the kernel read/write code mixes up bytes and negative
> return values I think doing that in iomap is also fine.  But you are
> deeper into the code right now, and if you think splitting the errno
> and bytes is cleaner that sounds perfectly fine to me as well.  In
> general not overloading a single return value with two things tends
> to lead to cleaner code.
> 

Eh, I like the factoring that the combined return allows better, but I
don't want to get too clever and introduce type issues and whatnot in
the middle of these patches if I can help it. From what I see so far the
change to split out the error return uglifies things slightly in
iomap_iter(), but the flipside is that with the error check lifted out
the advance call from iomap_iter() can go away completely once
everything is switched over.

So if we do go with the int return for now (still testing), I might
revisit a change back to a combined s64 return (perhaps along with the
iomap_length() tweak above) in the future as a standalone cleanup when
this is all more settled and I have more mental bandwidth to think about
it. Thanks for the input.

> Although the above sniplet (I´m not sure how representative it is
> anyway) would be a bit nicer as the slightly more verbose version
> below:
> 
> 	do {
> 		...
> 		ret = iomap_iter_advance(iter, &bytes);
> 		if (ret)
> 			return ret;
> 	} while (bytes > 0);
> 

Ack.

Brian


