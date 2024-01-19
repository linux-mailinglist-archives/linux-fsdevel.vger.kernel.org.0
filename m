Return-Path: <linux-fsdevel+bounces-8347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634F833052
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 22:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0885A1F23FF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 21:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA25821B;
	Fri, 19 Jan 2024 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PgiUbtlK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F958123
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699973; cv=none; b=PEWlHf4Pjtw/YBEkgkuldOVMMSBo1Cu5thsLOaan2I6L4IIc8WA13zQlO1hyElnX/Xj1Ag6wrEcMOtVWeVOYULzYf2+q4E9nOlGCEaul2vVur6SlCZEfkrCLMCM4steRKfUfNRa/afhcOomrvW+jx9U4JJMQ6HO/lELI72VziAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699973; c=relaxed/simple;
	bh=rb/0RRAKqD0zgupgeIMpklHRq1/MvnRXbqIFVvvnzi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7uvM2MqNWT6VxuwvrygzaX8KTBu0iG1kyyqqXhdf4mpX+Oj+GwqsmRUA4dvExkDg8DPz++pOUrgp/hIudWIKjMwZ6sYdGYbTaExw3CX2U12K6E3NbqAvJWJGtZaZqntC/586LmVz3pxNXn+mZt6yJZT7tFgNlFNnULIGcol4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PgiUbtlK; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Jan 2024 16:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705699969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FLomblPJcMeiSxlixDm3RulK3ybZSKceq36X6Ta4QV8=;
	b=PgiUbtlKrppC7aYHRvo+rWp7WthBgUf+B0PYwy/3SIFxexUpCeA79apDrlK3JO2qMEsI9f
	0ojmGVfhK3DfcM+21Ilht00/8pu7YLroHlo3wCwMsUAJnaGeWGOxx/BFY9QlP53e7NPynB
	EtJyKwVNW4vB/DnGE1+WN+GoZBGIWWM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: fix incorrect usage of REQ_OP_FLUSH
Message-ID: <ueeqal442uw77vrmonr5crix5jehetzg266725shaqi2oim6h7@4q4tlcm2y6k7>
References: <20240111073655.2095423-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111073655.2095423-1-hch@lst.de>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 11, 2024 at 08:36:55AM +0100, Christoph Hellwig wrote:
> REQ_OP_FLUSH is only for internal use in the blk-mq and request based
> drivers. File systems and other block layer consumers must use
> REQ_OP_WRITE | REQ_PREFLUSH as documented in
> Documentation/block/writeback_cache_control.rst.
> 
> While REQ_OP_FLUSH appears to work for blk-mq drivers it does not
> get the proper flush state machine handling, and completely fails
> for any bio based drivers, including all the stacking drivers.  The
> block layer will also get a check in 6.8 to reject this use case
> entirely.
> 
> [Note: completely untested, but as this never got fixed since the
> original bug report in November:
> 
>    https://bugzilla.kernel.org/show_bug.cgi?id=218184
> 
> and the the discussion in December:
> 
>     https://lore.kernel.org/all/20231221053016.72cqcfg46vxwohcj@moria.home.lan/T/
> 
> this seems to be best way to force it]
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I've got a new bug report with this patch:
https://www.reddit.com/r/bcachefs/comments/19a2u3c/error_writing_journal_entry/

We seem to be geting -EOPNOTSUPP back from REQ_OP_FLUSH?

