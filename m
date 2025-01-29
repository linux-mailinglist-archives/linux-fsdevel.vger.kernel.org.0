Return-Path: <linux-fsdevel+bounces-40275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59FFA21784
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 06:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EBA18895B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 05:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D641917C7;
	Wed, 29 Jan 2025 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rn9Qi10m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B85672;
	Wed, 29 Jan 2025 05:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738129852; cv=none; b=E1rn2C1x1wY0oKJ+PUPhnxT+xy76fUvTr1q42BOxZ9Bug4dzBzblL81w4kHW2LJ6VpsulQ+YLc+Yfba0x5BfXnYttz4oftAhUAPwkf5T3r9suMBV3lb7RWm9rVBsB7W1i5FuyFsqIJPKe6O21oGAR2UO+cbj8k4lbNVsy523vPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738129852; c=relaxed/simple;
	bh=J/7W6xJeMw7GGt5s08ulurtY7jIaXHTITBV7uEN3Uj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPWMrM/YCSA/eStuMIqtIgbjdMftbwtHmue/tN5EWye1fXytAq4E94Y4fNXDot8pePx8DwwooQS2WYjG7YxV9scT7dSVsN4zU54/Q6jytrGxx1/XXW1/xuzJg7n4C3FrUJPnIyk4n6mvKOJ+Dzkp2XLCQiX6ScJ3q3fiiGzKTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rn9Qi10m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GPS6YnzC1efcASfrM9td3LqVpncOmCE01K6G8cnjqPs=; b=Rn9Qi10mGpJlFyslhRL7vT5fzR
	1e0RgZyeZL55jB728mFYucB/7g0n/WDYQFO4AmtsDtsJO253b4CDkYH9XPEFkBtTjVc3rC2g31xw4
	BTWEuj1WaiZi0NIY9gNS2cwR5Kyb2EzkXWb+zdYET6GZtnyAj/AmcOpzPUky9FOTsbI44LT7wAT/e
	pl2w9NFfYgIJp1VC2rH3hTrnzppjyo0KpXClcorRVCPn8C6iKjGm4cDvsTOK1l/lyPBadq2Zxd1VH
	gf3EkILMj76i6ET7b36xlboelk5XSaW3JXbA9RCD0oOCFRMqZXOH/9HcMzuEJ9sEYRdgPBd0Y8iXy
	rOD+tlTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1td0yP-00000006N7z-1PXG;
	Wed, 29 Jan 2025 05:50:49 +0000
Date: Tue, 28 Jan 2025 21:50:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iomap: refactor iter and advance continuation
 logic
Message-ID: <Z5nBufkUS3XtoUxT@infradead.org>
References: <20250122133434.535192-1-bfoster@redhat.com>
 <20250122133434.535192-4-bfoster@redhat.com>
 <Z5hsV876-PW46WsA@infradead.org>
 <Z5jhuVsoM_L4SPRB@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5jhuVsoM_L4SPRB@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 28, 2025 at 08:55:05AM -0500, Brian Foster wrote:
> > > +	if (!iter->iomap.length) {
> > > +		trace_iomap_iter(iter, ops, _RET_IP_);
> > > +		goto begin;
> > > +	}
> > 
> > This might be a chance to split trace_iomap_iter into two trace points
> > for the initial and following iterations?  Or maybe we shouldn't bother.
> > 
> 
> Hmm.. not sure I see the value in a tracepoint just for the initial
> case, but maybe we should just move trace_iomap_iter() to the top of the
> function? We already have post-lookup tracepoints in iomap_iter_done()
> to show the mappings, and that would remove the duplication. Hm?

Sounds sensible.


