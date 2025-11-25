Return-Path: <linux-fsdevel+bounces-69768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10226C84A5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 737044E964A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E27315D32;
	Tue, 25 Nov 2025 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w8rc7S3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1EF314A60;
	Tue, 25 Nov 2025 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069017; cv=none; b=U018OdTYxaOjHb6KRdn9VKK+OkGWlf7GEkch1CAAcsnBfzsGKfAq/X1yGZU7OXY8OmVttyKsXxiEWxHVIai8f+PQ2LuWy8E59Hj01LZlaz/XFW8C2S6gyGsdoHEPi0F9WBn+zDsZODjcnEqrFamqmdVQexNUXodR7J/38/uIIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069017; c=relaxed/simple;
	bh=rVqhgIHkhh4tkrPvGkGQeFxF4BxMrIdBfKQD7LZrxJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CD39SqnJ/Npq5Gk/dik6MZIJfTz0EGc/YTHlHpPlLkyyMo8SKko4DajDTeMHT4K99jPDorMHp5OfczLJiEnJm0tkF1OGNDOdcn0MjZLfbDqrzopLpVYgjqoVzNE42JGaTrLXObCsgoVDwfoTG731axSFp63a/zsZLy7460lttAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w8rc7S3f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UaUIsgvhtJzJr4Zje3paOAITbSG1D1YJ5U0VZcRpzY8=; b=w8rc7S3fuiLes7ipunrhNyMV6W
	wZrNPXLpGX3q6DLMeywpPIIzFPtgWriKbXvt+i9P2GowHkGiYPRF1Q4Mxvg58nylIowzPvPdlFpLd
	HSrCS8XoAn582cJVRH+FqS7CTpgWdKllRiV/C69F3iT8YXyOAhOo0emK8UFtiszIEXILwuu0rXj8o
	X19WyV/9NKUncgIPLYRyJ9+bcgxDae/o2O43QXRWR5FVRyx7F3VTBXIfgKZDNDwRFExjBdr12R/SB
	r/Gd2Tx6xK0BnnQI2t/0uuY+2x9cSuGAnNImQm7vTjkjh2wiLLtlvP0DAVwPe2qGSqSIhRdbezCqK
	BsoI5eJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNqvx-0000000DBqb-3yPZ;
	Tue, 25 Nov 2025 11:10:09 +0000
Date: Tue, 25 Nov 2025 03:10:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: calling into file systems directly from ->queue_rq, was Re:
 [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
Message-ID: <aSWOkcLPxuIdshrn@infradead.org>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
 <aSP3SG_KaROJTBHx@infradead.org>
 <aSQfC2rzoCZcMfTH@fedora>
 <aSQf6gMFzn-4ohrh@infradead.org>
 <aSUbsDjHnQl0jZde@fedora>
 <db90b7b3-bf94-4531-8329-d9e0dbc6a997@linux.alibaba.com>
 <aSV0sDZGDoS-tLlp@fedora>
 <00bc891e-4137-4d93-83a5-e4030903ffab@linux.alibaba.com>
 <aSWHx3ynP9Z_6DeY@fedora>
 <4a5ec383-540b-461d-9e53-15593a22a61a@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a5ec383-540b-461d-9e53-15593a22a61a@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 25, 2025 at 06:57:15PM +0800, Gao Xiang wrote:
> I've said there is no clear list of which data needs to be
> saved/restored.
> 
> FSes can do _anything_. Maybe something in `current` needs
> to be saved, but anything that uses `current`/PID as
> a mapping key also needs to be saved, e.g., arbitrary
> 
> `hash_table[current]` or `context_table[current->pid]`.
> 
> Again, because not all filesystems allow nesting by design:
> Linux kernel doesn't need block filesystem to be nested.

Yes.  Various other PF_ flags also come to mind.  Or Kent's
magic fault disabling flag (although with bcachefs gone we can
probably remove that, thinking of it).


