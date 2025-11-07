Return-Path: <linux-fsdevel+bounces-67427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADC3C3FD76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 13:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC7544E194E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 12:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07073326D77;
	Fri,  7 Nov 2025 12:04:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA82269B1C;
	Fri,  7 Nov 2025 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517082; cv=none; b=KLBNoy6us0ip8oeYzBEqxgIIe6l9ydnwNmdnCNA+pxGM20FQuDO5VMnkHH+P+VIIRKBZLqBDBKXZsu5z8y8CWItOJIq3ojLu6LP1OZ73mWZWsyR0pU9p4omdgdBAw8IQ6hUYTV/nA4XecD25TjrIY8sqZSDcuVoX06XhDR602s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517082; c=relaxed/simple;
	bh=Epw17cthqYzDX97VXV8EU7xcIfrOT5z14NvJbIIKY1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzIC8rLnw4EuHNfbHXZ6d3tLidD4SCYulussPwGOEYI1opJkvM5jfmwxv+jb/NGSq8Qxg0R2KckQTvGBaZMMg3X6ZkP9c6Ip+xqvIRLfJgzi1LWWt0v6skaw74AHDGwSg0kJs4SaHbMYkBbpPUr3hXEDbjf9VrbTxGEOybJeenE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71163227AAE; Fri,  7 Nov 2025 13:04:36 +0100 (CET)
Date: Fri, 7 Nov 2025 13:04:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/9] mempool: add error injection support
Message-ID: <20251107120436.GB30551@lst.de>
References: <20251031093517.1603379-1-hch@lst.de> <20251031093517.1603379-3-hch@lst.de> <20251107032900.GB16450@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107032900.GB16450@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 07:29:00PM -0800, Eric Biggers wrote:
> > +static DECLARE_FAULT_ATTR(fail_mempool_alloc);
> > +
> > +static int __init mempool_faul_inject_init(void)
> > +{
> > +	return PTR_ERR_OR_ZERO(fault_create_debugfs_attr("fail_mempool_alloc",
> > +			NULL, &fail_mempool_alloc));
> > +}
> > +late_initcall(mempool_faul_inject_init);
> 
> Initcalls usually go at the bottom of the file.

For a generic init function yes.  But given that this is only for error
injection, I'd rather keep the error injection handling in one spot.

> 
> > +	if (should_fail_ex(&fail_mempool_alloc, 1, FAULT_NOWARN)) {
> 
> This doesn't build when CONFIG_FAULT_INJECTION=n.

Yeah, the buildbot already told me.  For some reason there is a
!CONFIG_FAULT_INJECTION stube for should_fail_ex, but the flags are
not defined in that case.  I'll add another patch to the series to
fix it.


