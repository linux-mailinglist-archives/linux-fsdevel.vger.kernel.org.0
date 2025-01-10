Return-Path: <linux-fsdevel+bounces-38897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7419EA098D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 18:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DBF3A921C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ABD214205;
	Fri, 10 Jan 2025 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UT9vx3ji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691F4400
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531253; cv=none; b=qz2hBQS+lBzvbZB9VaM7gurEYS3atyYVHbGxeOwbUb3C/lvZxPWBWOfIC/lKZ76MfSiogzDOL8wHqxFLj5x1GqlzMhpvPYk750wMkQFfSGYkhP32+FQhUH/Ik5NNudq34+PF7oTchsKcy/td/p4z3IQ3maGMoTnz/f1wlHcTolk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531253; c=relaxed/simple;
	bh=VA/FKVaR7GDaTjWGL/f1mEoRzaU+PasyCwGNPKsYBmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n12yNGRgDSyZg+FuUf/vecXNmkgQISaD3OU7YJH0OaYxHmTLZMW5jxShojfM6A9x1Elei9gU0y+M1vxJr/R5MohJHsNLNZZ3E1UAoVWXmd8zRDcc/37Vob7XWwdvnm0qpjhK3pOG/iGanKoqq07qNLbsFfbIBSafP4eg+R7uoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UT9vx3ji; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736531250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOTrqMQsxIH8YdctTiVSqzH2gAuMUYhGSSBs9tYVQ/w=;
	b=UT9vx3ji9T6wgUnT6xydZKDzp8qoKrmIDzhjomhyyeI+tALnt6aFgeXeUlrbeh0dm2UC7j
	/JwrSFF8Sk+MJ1oBqrZ/RVZhNbW32VJFAoP+6dXB8rnJqaOyrW85P/vTdSqrczvzzFsjca
	c+lv4j9nlslynvoCs/rZdgHXRQzKbjs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-qWVstE7AN12Sv5ngYgnJmw-1; Fri,
 10 Jan 2025 12:47:24 -0500
X-MC-Unique: qWVstE7AN12Sv5ngYgnJmw-1
X-Mimecast-MFC-AGG-ID: qWVstE7AN12Sv5ngYgnJmw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1D4819560AF;
	Fri, 10 Jan 2025 17:47:23 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.122])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E805630001BE;
	Fri, 10 Jan 2025 17:47:22 +0000 (UTC)
Date: Fri, 10 Jan 2025 12:49:29 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/6] iomap: factor out iomap length helper
Message-ID: <Z4FdqZpGRokcyh96@bfoster>
References: <20241213143610.1002526-1-bfoster@redhat.com>
 <20241213143610.1002526-3-bfoster@redhat.com>
 <Z390h2_8AmSQp_7R@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z390h2_8AmSQp_7R@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Jan 08, 2025 at 11:02:31PM -0800, Christoph Hellwig wrote:
> On Fri, Dec 13, 2024 at 09:36:06AM -0500, Brian Foster wrote:
> > In preparation to support more granular iomap iter advancing, factor
> > the pos/len values as parameters to length calculation.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  include/linux/iomap.h | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 5675af6b740c..cbacccb3fb14 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -236,13 +236,19 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
> >   *
> >   * Returns the length that the operation applies to for the current iteration.
> >   */
> > -static inline u64 iomap_length(const struct iomap_iter *iter)
> > +static inline u64 __iomap_length(const struct iomap_iter *iter, loff_t pos,
> > +		u64 len)
> 
> __iomap_length is not a a very good name for this, maybe something like
> iomap_cap_length?  Also please move the kerneldoc comment for
> iomap_length down to be next to it.
> 

Ok, seems reasonable, though I think I'd prefer something like
iomap_length_trim()..

Brian


