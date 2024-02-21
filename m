Return-Path: <linux-fsdevel+bounces-12211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DC485D075
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 07:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F2D286EF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 06:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76CE3A8F1;
	Wed, 21 Feb 2024 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oU1axoh6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B13AC10;
	Wed, 21 Feb 2024 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496590; cv=none; b=XtiBDNIy6SrTEp1WvC/Fbq2aKdyhVr//STYnVA/l4l8zUAVfVuHqJneO/voPt+LoKS1BuNPIkHIwk0n9IlQP8sOkm22KV2YpHw1q4Su39l2dsrYMxFQmPtw/PvUJkt+gLlVCDbpi6HV8zb1e3akrL0IrrAQEkcKNQHmOW4uBNQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496590; c=relaxed/simple;
	bh=ia99tmS8KmTOegLvQOZLDw6x0Ukn8p88i5zcvMA08fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3EHGnqPl6p//IiBV5TnoR35AFx8lz1209EYS2PEsZ5ZMqEWA7VZPVtS/xXBPcK14NmWdIln39bP4TEPwiJ6ocd1BZIK8h8EO9Q3NyaG/AAT8nIe0yn+Flt72Ax5bYlmS9GgOFP+WZWfhwfdjv3bi99fsacp4i90exrxBJIvuGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oU1axoh6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OlrDKDxjflUCEmdbU7yemP1+yw4nEnT9q1BotCfOJkc=; b=oU1axoh6HQwSGAzpI/epDTb49U
	WEAtP2gf3fLrUV47CbxNuzpecwDD9Sn8h++6fwd67cO+AybJMKQoJ7KcnPylCYZqgHfPNg248NGQp
	4lXWpEdjwI23oU/81EUdyn7ASLvVX9JxcNpz/HplYPH3UBYw5nmmHd+BSFNit00qdDFGS29OG/vZq
	NtkEhTNgVZkdc2zXnhYkA1Jj3Rvo/IJD53NFDRktIl05j8kazm9hURnfND8DnUZyCo+/GAHQBCEPC
	FLukpqIgCcmJXRS3LiI4obesOCVLHb1MJIHNLsgvzLLSsgBl3LP4gdkWzOsCzYKhtlgEJwFLCKU48
	ala0aN1w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcg0Y-000000000xn-0oEg;
	Wed, 21 Feb 2024 06:23:06 +0000
Date: Wed, 21 Feb 2024 06:23:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm: use ERR_CAST() as a cleanup
Message-ID: <ZdWWyvoCyI4kp4hm@casper.infradead.org>
References: <5a64b69a-40a6-4add-b758-ec3a9d93eb11@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a64b69a-40a6-4add-b758-ec3a9d93eb11@moroto.mountain>

On Wed, Feb 21, 2024 at 09:22:13AM +0300, Dan Carpenter wrote:
> The ->page is the first and only member of the folio struct so this code
> works fine.  However, if we use ERR_CAST() then it's clearer that
> this is an error pointer.

NAK.  &folio->page is an indicator that this code is in need of cleanup.
I use it in my scripts.

