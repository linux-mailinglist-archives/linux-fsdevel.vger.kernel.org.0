Return-Path: <linux-fsdevel+bounces-32232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1269A287B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 18:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5EC1C20EF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 16:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CA41DEFFB;
	Thu, 17 Oct 2024 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FXCDni8M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46661DE2DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182167; cv=none; b=BtBX+maSZ61ikUuRX0BgqlTa/H8ajtS5pbAL9Lo3DRFu2jklxRzPCLrrFc+5VgAB5mPFCL12HVEek5nEgY4hSdBSpgSBMT+Il8NCFAkbjtr9N5en2QQMJN15gZVpKfMYSuTSN9ZEAX5gLMsI7DwycpfTmLouUeAIVnYCLD8ehBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182167; c=relaxed/simple;
	bh=sZ6KP8thmTQCJtU/avHHKXCRMvWA2RP/s9vg/0Sk7og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AddpYR9kgW5BcZw4iUTCpIEIezGTraVTfeb84R10apf379iprzfcxD2lCKDMcpp8lBjs4E6Op8FPePyQfhNd0ZeClk2HPm10XhGtG5xsO+Dc6FUukk8md+/2WE9Dpxz/jDEQjH+0L+Mu1p3wt8TprPPIiWS/P0IgcPcp3pGRkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FXCDni8M; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Oct 2024 09:22:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729182163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HYfWHc3rTW2bhCLrf3pt7lBtznTfZpZDS4hxXdJ55M=;
	b=FXCDni8MUUcF8NX37WVf0D34cbKzVjXdly64eEk1LUbBlBp/ehUutZfN8QsUej6iamafWM
	QDe4QI2gZleF8ZMr32sHL62oy5q5dPhkGRYnexo7RWaHeQ79EepHt4BTU8tucPoZcqYbLr
	nlXdF5cFp2Q9t4b6BqcagKPzUYvzqnM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, Yi Lai <yi1.lai@intel.com>, 
	pbonzini@redhat.com, seanjc@google.com, tabba@google.com, jackmanb@google.com, 
	yosryahmed@google.com, jannh@google.com, rppt@kernel.org
Subject: Re: [PATCH bpf] lib/buildid: handle memfd_secret() files in
 build_id_parse()
Message-ID: <d62whv7kff5yshsyzkykgxpgfycfivygyhlqwifvudnj5adun7@kqd6hcsbmee6>
References: <20241014235631.1229438-1-andrii@kernel.org>
 <2rweiiittlxcio6kknwy45wez742mlgjnfdg3tq3xdkmyoq5nn@g7bfoqy4vdwt>
 <d62bd511-13ac-4030-a4f3-ff81025170c1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d62bd511-13ac-4030-a4f3-ff81025170c1@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 17, 2024 at 11:17:19AM GMT, David Hildenbrand wrote:
> On 16.10.24 20:39, Shakeel Butt wrote:
> > Ccing couple more folks who are doing similar work (ASI, guest_memfd)
> > 
> > Folks, what is the generic way to check if a given mapping has folios
> > unmapped from kernel address space?
> 
> 
> Can't we just lookup the mapping and refuse these folios that really
> shouldn't be looked at?
> 
> See gup_fast_folio_allowed() where we refuse secretmem_mapping().

That is exactly what this patch is doing. See [1]. The reason I asked
this question was because I see parallel efforts related to guest_memfd
and ASI are going to unmap folios from direct map. (Yosry already
explained ASI is a bit different). We want a more robust and future
proof solution.


[1] https://lore.kernel.org/all/20241014235631.1229438-1-andrii@kernel.org/

> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

