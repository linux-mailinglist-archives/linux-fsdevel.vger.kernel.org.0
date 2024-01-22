Return-Path: <linux-fsdevel+bounces-8387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A1F835B16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 07:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663A5286D8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 06:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799FF503;
	Mon, 22 Jan 2024 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u75XNfpl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3169F4F5;
	Mon, 22 Jan 2024 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905471; cv=none; b=gft+JBMKzqyyUsAX34GWZaDHFAR6rwzlnGxYg6JC2KTLUQX5HTjtJF6aRLMA9l3VtBboO7BsjDdet8krd7KX9JlR0Q++1wTh4JD7NMx2Y55w0V+Wy65ocmsSbzUjKIRWOvShVdE+YNUfpYrzOy3EHtJRMZVs3rs5uGaIMS5DmWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905471; c=relaxed/simple;
	bh=mwzmXKBgG1ZrVDQ23xNljKtoisRbH6r0MtjKj7Di0+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ffe3R0O/R2ascXunUbjbM6obzq9hxiTxbN2/gCuvfpvSMoF2kmf/viHZfkl4fXpV+H5/auK6o2FDIG1s9pPbBsbaImH7J/B0y0jiS9bX4zeemxPeWCZvxkGehZI3XO67m+nV+iGXFlOaf2xOMJfZVrCyRoiZ25OQaPa6BPaCD1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u75XNfpl; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Jan 2024 01:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705905467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkQ1DUjd2BJPh8gNuDAYke7vFyLqhKE5OH2wq384+50=;
	b=u75XNfpliqXNeaToB5S+UegqkdlOiVkCdhoahZFLlSLKqzNjOngGMv8RZzNHK7xYbERTIo
	dH4Lx2haOLsfMet4clqV+v2FMTwHHyC+IntiyOCEpHGC6qubjv6wosDnJDkQiKRJtPLXDu
	2sTtO8/Zxd4QFhEFtsy/RAL9MCbgq+M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: fix incorrect usage of REQ_OP_FLUSH
Message-ID: <eyyg26ls45xqdyjrvowm7hfusfr7ezr3pjve6ojikg4znys6dx@rd2ugzmo44r4>
References: <20240111073655.2095423-1-hch@lst.de>
 <ueeqal442uw77vrmonr5crix5jehetzg266725shaqi2oim6h7@4q4tlcm2y6k7>
 <20240122063007.GA23991@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122063007.GA23991@lst.de>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 22, 2024 at 07:30:07AM +0100, Christoph Hellwig wrote:
> On Fri, Jan 19, 2024 at 04:32:44PM -0500, Kent Overstreet wrote:
> > 
> > I've got a new bug report with this patch:
> > https://www.reddit.com/r/bcachefs/comments/19a2u3c/error_writing_journal_entry/
> > 
> > We seem to be geting -EOPNOTSUPP back from REQ_OP_FLUSH?
> 
> With the patch you are replying to you will not get -EOPNOTSUPP
> for REQ_OP_FLUSH?, because bcachefs won't send it as it's supposed to.
> 
> Without this patch as in current mainline you will get -EOPNOTSUPP
> because sending REQ_OP_FLUSH and finally check for that to catch bugs
> like the one fixed with this patch.

Then why did the user report -EOPNOTSUPP with the patch, which went away
when reverted?

