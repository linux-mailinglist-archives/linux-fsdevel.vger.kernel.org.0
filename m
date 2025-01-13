Return-Path: <linux-fsdevel+bounces-39000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10661A0AE83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 05:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27435164F1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 04:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6442E18C936;
	Mon, 13 Jan 2025 04:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Te18m+7d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275AF199B9;
	Mon, 13 Jan 2025 04:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736743600; cv=none; b=Gh1byCeg0WFII23XOeUDN6wHwOTLUSMjOrpqgLoXJDiBqk+B09LU2GYOcbxu/lMPTGTBWrq2dR+wwd9BxO9aUKGzovWmcTa1ZyFEeIByoOO0KYhn7PRE5gPgQiwVdwdhfjSVvtAgMX9pdYA+t5CLjRa8tUVz7y0aG9QoCMu2+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736743600; c=relaxed/simple;
	bh=bWckrvpu5CqhtSbERlVZCZ+jz+9C+VUraV+pytwmNdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFHTrg3EFmqNKr2NKhu0hkKi7hMvd2SL69eSt0QaWZIiPXwkextHoTpvV812QyinRWaPM7B0/A8/sBbv/tp8YUMn0lhtgduHeJvPXws0JSipvr+LSNMEuUzeUebnEy5Soa/3pRMcYUKRBMHHkaEjrmM7AOY/SFu6FEV8wDKbGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Te18m+7d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k2eODpRYt68Yubrzn8vlLc9+/DAYMbBIZ3nyt1oP4ik=; b=Te18m+7dC2rMVF2/V+WYSeHyRI
	T1Pa0aPY6UlZI44oH6FwS63P/7lKjfNZ4kz1RjuguVAg0FCXmeGZxdFQBN/u5yRkQNVUFq0jlhySL
	9DUy80kqy3LYOjNg/w8ba46WLLo8CpwseDye2g3cmcWNaKROTq8fkYWuQGCneTEF8iS0zbc9nsdx9
	831P5VRHW7doUol76zEava5pSCsxJnMS9pOs1B7R2aJAfWoz0C+Lj/PBHlgsFzd6TYMQsPymMLj8z
	Arfv0gBRVu112OCqgfNhRcipvEVuiH3WLglDzUi10c14Tn8pywc7soCem4Ul8nUDY5GHVE2JFxksj
	whNxR2Hg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXCLW-000000040mh-1lxJ;
	Mon, 13 Jan 2025 04:46:38 +0000
Date: Sun, 12 Jan 2025 20:46:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/6] iomap: factor out iomap length helper
Message-ID: <Z4SarsfEB9r9AZ_v@infradead.org>
References: <20241213143610.1002526-1-bfoster@redhat.com>
 <20241213143610.1002526-3-bfoster@redhat.com>
 <Z390h2_8AmSQp_7R@infradead.org>
 <Z4FdqZpGRokcyh96@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4FdqZpGRokcyh96@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 10, 2025 at 12:49:29PM -0500, Brian Foster wrote:
> > __iomap_length is not a a very good name for this, maybe something like
> > iomap_cap_length?  Also please move the kerneldoc comment for
> > iomap_length down to be next to it.
> > 
> 
> Ok, seems reasonable, though I think I'd prefer something like
> iomap_length_trim()..

Fine with me.


