Return-Path: <linux-fsdevel+bounces-48035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D893AA8ED2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECB83A70E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E21D1E51FB;
	Mon,  5 May 2025 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ngQf3UD7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFF19E819;
	Mon,  5 May 2025 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435904; cv=none; b=NUROuoH0ZNTlnMjsGbbm13wF52RpNP8/Nk1Rjuk6NlcPWKgHyHgE3gqvK/1aEqOi1B6yrOJfU/nMMuJhh4e9w/5uGxw+DHrv5MGkYSMATUHhGSSpl8MXQwV90S8+Dy2zuDS1p/Le9r2xPxrhUHBWLwvlgqYE27wRFYL01pbZUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435904; c=relaxed/simple;
	bh=h9DE5ryR0zqOC8nzO88lN2YyWr2P5iuFj+knvnAgTmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev6S/B0mTrlDynzWuPy2E1OG3yWUUY75wsahWCkeuaDAk9p7jRNYCYkE5MQ+42zU+Pf56971AR9FgD+uJfrD6vHJxtby5Gn1QYOF4nZ6zMafkVYiOQOs/cQ0x3zyAEZk97kv4cTspYk1/vVQ42upbWVr37XmHd2BXnJMs4ijuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ngQf3UD7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GgYjeh2livmteX/WeUBi412mIcXPX0XquzzF2N6R6mo=; b=ngQf3UD7djT1UJiH4Gb6FtD1Wk
	IZW5UWlxKMWYFvQDnve1NdbiF1z3iAujz8ys0t1q4VhKVPYt18+G6mIDifVsgMPN+lCGslZLEE9C6
	irfyj+p1HGTvIBq3biJaFEwEhbKIU3PfnZ25zoGj86vG53AVofYRNj8kKzc1LlkjqpiCMicm8bdQ9
	CXS+NKBa4onF1rEvRB8yGW7js/uU3gTQ2FIyOmU3NZFWju/G85AgJsgVogC98s2lDyXQHAcj56GoA
	OC9edHBQC06YcfESOEgT7W+OSKU066/aWv5ocFYsSoy7WBYu+69kMUa6IW/YPD0J1M/Pwt4wmtveW
	+mBJfztw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBrl1-00000006rPg-0ECe;
	Mon, 05 May 2025 09:05:03 +0000
Date: Mon, 5 May 2025 02:05:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/6] iomap: rework iomap_write_begin() to return folio
 offset and length
Message-ID: <aBh_P4L99oRiJssd@infradead.org>
References: <20250430190112.690800-1-bfoster@redhat.com>
 <20250430190112.690800-7-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430190112.690800-7-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 30, 2025 at 03:01:12PM -0400, Brian Foster wrote:
> +	len = *plen > 0 ? min_t(u64, len, *plen) : len;

	len = min_not_zero(len, *plen);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

