Return-Path: <linux-fsdevel+bounces-21940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D9690F83F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 23:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAF31C22552
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 21:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B3615B126;
	Wed, 19 Jun 2024 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QtfvMNUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D0015A850;
	Wed, 19 Jun 2024 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831047; cv=none; b=tVMlS6euTWh/J0SFElfn9KLB63fvelR2zlF/U/A2jzrh23MO3B225/WuZgJcx6s1Mt1J7zpOk9iBicHr5tt5xnDsLQulLB7x8UbtqIq5WFVBPPzXGBkPGNLDNpS6lXlKy34DjO859rIpwJs858/T6w/EjaN0lqIVxBsvweIy57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831047; c=relaxed/simple;
	bh=SbuyVo1Iry41OLSZVAo04bDKqQ8M45Bi9F93IiVDGZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP2BOUBOtXjSeyxtJ1ECn0dCfxdvF8Wp03fq9KPplGkZod6gREea9hwTTtCHfTECi2irH34WCBPAoLlACGr91EBYfnFXMWz0mp+ZBZjEmArqiPMzLqcDDxRfQdLge6c7nLYS0FbBC9MxUsqK5NQwkeH5P+9Cv5d8tAa5qwtA1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QtfvMNUs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2IBPUPKo0mqW5x1/ocRzXKcaHwxGR4JPvd7Vmk/D5tg=; b=QtfvMNUsLzhHtIyO15c8ZSH0Im
	5UjJspKkVhqe81OEdcg9wwQpzlJrYaGK+2/tANdnR1vaRBsyjCFbjjaWKEzxZpZq8ze1qRrjRqfXK
	8VH8KUG7YJJ6fq3t1/Qf+OXN8/3mktUp4oH8113TJN3xZgR4JsLObTCpCBhyhyRsrvz3JtD7khTxq
	+MnDT9x1chzkynwOHupqi5oZZEiHYYTFdyNXLqIcjYFZJJFOPabHEbbBHD9YfFZbrQiVQqcHN2jIH
	t1no/8WSLH7ce0c28OK5Uh5DwgEosB11gB2POERtqh9dJBVP6SEBJA+5Nl/1Vx4MhTSa451aqzxy0
	gB/6L1SQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sK2TH-00000005BKN-2JK3;
	Wed, 19 Jun 2024 21:03:59 +0000
Date: Wed, 19 Jun 2024 22:03:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Takaya Saeki <takayas@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Junichi Uekawa <uekawa@chromium.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] filemap: add trace events for get_pages, map_pages, and
 fault
Message-ID: <ZnNHvwV7tDlSFx8Y@casper.infradead.org>
References: <20240618093656.1944210-1-takayas@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618093656.1944210-1-takayas@chromium.org>

On Tue, Jun 18, 2024 at 09:36:56AM +0000, Takaya Saeki wrote:
> +	TP_printk(
> +		"dev %d:%d ino %lx ofs=%lu max_ofs=%lu",

It seems weird to have a space between dev and %d, but an equals between
ofs and %lu.  I see there is some precedent for this elsewhere, but
there are other places which use ino=.  I'd rather:

		"dev=%d:%d ino=%lx ofs=%lu max_ofs=%lu",

> +	TP_printk(
> +		"dev %d:%d ino %lx ofs=%lu",

Likewise.

> +		MAJOR(__entry->s_dev),
> +		MINOR(__entry->s_dev), __entry->i_ino,
> +		__entry->index << PAGE_SHIFT

This needs to be cast to an loff_t before shifting.


