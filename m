Return-Path: <linux-fsdevel+bounces-25811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D2950B5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 19:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38BC91C21A5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 17:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410301A2C15;
	Tue, 13 Aug 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qi8FTPGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE41A08DC
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569987; cv=none; b=cLTgs5E9b9UTkXrKLbuyTOmGeqPrS8nVnHjivtIiFdn6k2ut1ciSLURjsrIwNcPZtjN0aToA0FA1FYLuShfgraJptvlHl2KlPsp2C/2FleKwrXSx76dxw8PwPKHNTKuSN/GS2U4e22He2lXYBCu9jY7aEZepACoiA1nbkHHqvCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569987; c=relaxed/simple;
	bh=0YXQl9RRULqSJGPYZkkpI/HfI0mGMonjL6y/YBMOmIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It1gNtZxs825UmviMZr29uy1h99T3DcRGQ4HgNYv6dkQWYzJBn02zNPmP2HDRLD/dwJmzPqeJhbzvC+3tm0e1DmiODCuLMYBT1uwFz0LKhmJb6q3RzkNfdV/GXZkQzvHulB/PGzI5ZByHVx1bX+bTYQ5lNyCqINKbK7BACsq4W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qi8FTPGi; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Aug 2024 10:26:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723569982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOoXH+878iBF43lhixRe2ALsfBJsoWknXYuXgBmlG4Q=;
	b=Qi8FTPGigcPDhBtvmixCAeE7VIGnZ+W2cZR6KT3v8Gfw1MlEmobKwzlPzsxdaGNqBuFXj2
	wFdRaITWJmNvbIg/9yAkMBevZtSi9l/UvqCepmkijE9pd4/rbrEAK2rxlN9Ms8RnHZRe0+
	Od1Gheg01hHiMP1I3aAtJOWMtMiFIc4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	adobriyan@gmail.com, hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, 
	song@kernel.org, jannh@google.com, linux-fsdevel@vger.kernel.org, 
	willy@infradead.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v5 bpf-next 06/10] lib/buildid: implement sleepable
 build_id_parse() API
Message-ID: <oo36eeomtei6lbv6omt6p6d6yqhpbnr5gxxc5qulminw57lxrc@ztum4lzvulhj>
References: <20240813002932.3373935-1-andrii@kernel.org>
 <20240813002932.3373935-7-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813002932.3373935-7-andrii@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 12, 2024 at 05:29:28PM GMT, Andrii Nakryiko wrote:
> Extend freader with a flag specifying whether it's OK to cause page
> fault to fetch file data that is not already physically present in
> memory. With this, it's now easy to wait for data if the caller is
> running in sleepable (faultable) context.
> 
> We utilize read_cache_folio() to bring the desired folio into page
> cache, after which the rest of the logic works just the same at folio level.
> 
> Suggested-by: Omar Sandoval <osandov@fb.com>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

