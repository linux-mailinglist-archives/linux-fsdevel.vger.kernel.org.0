Return-Path: <linux-fsdevel+bounces-20626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDB88D637C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33902827CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4531586C8;
	Fri, 31 May 2024 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bZlaLhnY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B65158DDD
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163465; cv=none; b=TsldjgRBMSsxGESB+ZCcbd24e4tQ2yKQyr8Q1+fojdGAdYZqt3Z3EUkjhr/ngb7Tw+SkrXoe6ZSKoflSwcjrCVuLArPvkmzxDkADJj/RPn7LFCaywGf/Pg1QL2mwrZvkbafk7kOYEHhzexQsjDtqIoQLYyGX5Qc+xBSQ2Xnw5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163465; c=relaxed/simple;
	bh=2JWTnV+v8KustqyyaYQ8LeL+7Ou/Fm44hcDRtXE3wuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGo46D5SVnmQL8j9FOM42Ma98nbHEui6JwqKOGbF2NtjC4tD0c/3tnsSf8UdGN79H2hNnQGGX68Tjo0sCDKAsiJ8RSA3taE2tRPd3ks4MZxf1pQr16MYDYiaHb5S3KRvgxLbxekDj5Bnb5Uk6/aRgfSWqu3G/oeR670pX4yoZ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bZlaLhnY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CfMDi49qeEUjJhvHFEv74c5Pi3LEh/WbvbAJ0SSbIuA=; b=bZlaLhnYhE6Z4ckDBFpN6Musec
	EpjObwo+kLNoSt5WyqAioIXsE8xDOS0498M4icHF4dBY4nQtgqp1VV5R2MYi3Pqd/6vEbGacYKKax
	ONDXiDn4RnvHOO3gj5RzFRDAX7av/SArXDA48oAFWXhY92y9fRs4xyFdhrvt7hgIpWztfYvDTJ6sI
	9v7njxzrkyJpHzjCrd7ita1cV8n+sd6d+Rh7WZoR9a2Oi3s8GguQ++3yFCGjbmr+rED7fRGYYfUjL
	TOO6kYUtOwRLET3Sqsf/zhWKTKC6BexyAAYMT1jOo+KuU+v1dP2fJToAWvF6yJoEvhWap/O+NSMnT
	hX0ZyHug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD2eq-0000000AP8w-1m7q;
	Fri, 31 May 2024 13:51:00 +0000
Date: Fri, 31 May 2024 06:51:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrei Vagin <avagin@google.com>
Subject: Re: [PATCH RFC v2 15/19] export __wake_on_current_cpu
Message-ID: <ZlnVxNU7FfaUbk15@infradead.org>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-15-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-15-d149476b1d65@ddn.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 29, 2024 at 08:00:50PM +0200, Bernd Schubert wrote:
> This is needed by fuse-over-io-uring to wake up the waiting
> application thread on the core it was submitted from.
> Avoiding core switching is actually a major factor for
> fuse performance improvements of fuse-over-io-uring.

Then maybe split that into a separate enhancement?

> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -132,6 +132,7 @@ void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode
>  {
>  	__wake_up_common_lock(wq_head, mode, 1, WF_CURRENT_CPU, key);
>  }
> +EXPORT_SYMBOL(__wake_up_on_current_cpu);

I'll leave it to the scheduler maintainers if they want this exported
at all and if yes with the __-prefix and without a kerneldoc comment
explaining the API, but anything this low-level should be
EXPORT_SYMBOL_GPL for sure.


