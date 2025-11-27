Return-Path: <linux-fsdevel+bounces-70035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CB4C8EB6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 15:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8095D34BCE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE20B332EB4;
	Thu, 27 Nov 2025 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Md7AUvsJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCFC2D97B0;
	Thu, 27 Nov 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252667; cv=none; b=plNDV088e+yF373nyIgbBTNUCiROh8GK+6oHoo+MqzRSEjYc4+g46eBc86+JkEb1sKG45ZDdwprPrAAr7HpPWof7IT8Ju6L6S4OLYO2jCIAcf3+JmdbThk/Ndg6c909tOesCC6T41MPcDrGul5ZY3Xm3bzV50icpaZxBPWRdzVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252667; c=relaxed/simple;
	bh=FUGzyqSmNg/3dD1ulJ8dHwa2zFLFc3wNVHcRJH/tBjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gj9KESJv2YsgFBjwkD20+PCf7HAlEF4+0I0H2qO6zzoZ4J0jnnh6jJxaquigvOVe4tFUzgqEBmIcF+MQfi52a8bzeetrj7air1lQysPpijkxPiyNcTSW+jqdIptxwQDKif4Nqx3muQcCbDZgqWdux04w6KydeyLizhAMi7lzSNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Md7AUvsJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=F+YJcNTnZipSTHzHvP7VT6KqL2agMe1FxyPDxMOqh5s=; b=Md7AUvsJZXv8HzqmqBQH9zMWlt
	055/vUKlYmH5uhcx9w76D7KXRwIntDZCeyCM2Yq63DAQqF880UbEIVMIZ8tIwaBxvg7sAWw/ypKF0
	9HbCKZbwd7+otQnKIDqFmnmX0VYdKlcwZ0/WbdpwqOza9AYAutIxsV9lZtFL/20c81Hbon8JI4Th6
	99OeCCUmiasQr7OmkQMF8QK8mHYFwex7VIExyOhnHSU6fLyZB19xKJEiNI3eUseO3fqcWoBlZz5Ad
	0tOJNa+SAEAml+PX0EKGRayR8W9ZXcbJ8s9smYXR7dwXVMqbntkA53/kXZDI1swQzZOr4DKzMpBBP
	bf4xIpiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOci6-0000000BpO1-1mHV;
	Thu, 27 Nov 2025 14:11:02 +0000
Date: Thu, 27 Nov 2025 14:11:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Jan Sokolowski <jan.sokolowski@intel.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/1] idr: do not create idr if new id would be
 outside given range
Message-ID: <aShb9lLyR537WDNq@casper.infradead.org>
References: <20251127092732.684959-1-jan.sokolowski@intel.com>
 <20251127092732.684959-2-jan.sokolowski@intel.com>
 <aShYJta2EHh1d8az@casper.infradead.org>
 <06dbd4f8-ef5f-458c-a8b4-8a8fb2a7877c@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06dbd4f8-ef5f-458c-a8b4-8a8fb2a7877c@amd.com>

On Thu, Nov 27, 2025 at 03:03:20PM +0100, Christian König wrote:
> On 11/27/25 14:54, Matthew Wilcox wrote:
> > On Thu, Nov 27, 2025 at 10:27:32AM +0100, Jan Sokolowski wrote:
> >> A scenario was found where trying to add id in range 0,1
> >> would return an id of 2, which is outside the range and thus
> >> now what the user would expect.
> > 
> > Can you do a bit better with this bug report?  Under what circumstances
> > does this happen?  Preferably answer in the form of a test case for the
> > IDR test suite.  Here's my attempt to recreate your situation based on
> > what I read in that thread.  It doesn't show a problem, so clearly I got
> > something wrong.
> 
> According to Jan the observation he has is that this code:
> 
> idr_init_base(&idr, 1);
> id = idr_alloc(&idr, dummy_ptr, 0, 1, GFP_KERNEL);
> 
> Gives him id=2 in return.

Hm.  That's not what it does for me.  It gives me id == 1, which isn't
correct!  I'll look into that, but it'd be helpful to know what
combination of inputs gives us 2.

To be completely clear, here's what I'm looking at:

+void idr_alloc2_test(void)
+{
+       int id;
+       struct idr idr = IDR_INIT_BASE(idr, 1);
+
+       id = idr_alloc(&idr, idr_alloc2_test, 0, 1, GFP_KERNEL);
+       printf("id = %d\n", id);

and I think that should return -ENOSPC instead of 1, since we told it to
allocate exclusive of 1.


