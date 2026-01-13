Return-Path: <linux-fsdevel+bounces-73492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 443B0D1ADA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65A03304357A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78AC3191B4;
	Tue, 13 Jan 2026 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UTCLlh/+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE621C17D
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329171; cv=none; b=aUH/ENdEIYZusPtrl3D7j4NcO0DSXvUuLja24OfcMhupcWAhM6sVXvXUenSYe9qqT0vD2rshmoNZlzn9+YWhD4VvOEDg4JmvntjOPofR5j/oqMtN+50dmgsyqoN4cl0VoumiBEAK4PYV9yXA5XOx0rwU84GtDzWoBJ3AGKQ+bKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329171; c=relaxed/simple;
	bh=t0VbeULF0Rn4uBd0ffw5Oo7ZCuM+7iztstrH0ybhxkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHaCHFcpjC9981AWkGOUeSxjuj0Pcr3nHFib+cjioZt9x8aZF4l/CuTXECFafj6o+Ew6l8UfoUtNaRvN2OD633y57XRq3oZeXHQwTawEByAl/puvLdhNAzH1H+trXf1puYy2h2pnXDzRHjXQdGa5ZSsU7XYSWemIkHgzlsu2ObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UTCLlh/+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ROnb7o/XxF/fqYwZeIOgvJeBy1sEnTSqitnXwpzSH9o=; b=UTCLlh/+4E7B0HUf5h8kfa8RkN
	u1K4dhvv5Tbfb+XNZdVsreMCMPxM2nd/7SV4P3WJZsMr8iDb+8t02bIy1SuQY/3kQYLgwvRRH5uVa
	wiucA7Ts9s7+PeFSKizbSZT07ASFF97aswnseBQt1oXL6xGmEEte+wCsYO5fd1JB7LSjWykY+7Cpn
	DlcLwePp+7CX74A2fBcag31DcaKGMU5XtUM7nglTRLj4jS6Z9yReI68SAnwJbO7kjre6KfUI0m2Gw
	VNCpoKtLZefcLPsnQuB6o+BSx8c0MvjYvHp51wP7VJW8025o37FZ4ELLrVcBMXbQ5DxoB6LQhhH2w
	H/Ypi71A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfjC9-000000055R8-1B0x;
	Tue, 13 Jan 2026 18:32:45 +0000
Date: Tue, 13 Jan 2026 18:32:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Nanzhe Zhao <nzzhao@126.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add 'folio_in_bio' to handle
 readahead folios with no BIO submission
Message-ID: <aWaPzQ8JXNBdzb4U@casper.infradead.org>
References: <20260111100941.119765-1-nzzhao@126.com>
 <20260111100941.119765-2-nzzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111100941.119765-2-nzzhao@126.com>

On Sun, Jan 11, 2026 at 06:09:40PM +0800, Nanzhe Zhao wrote:
> @@ -2545,6 +2548,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  	}
>  	trace_f2fs_read_folio(folio, DATA);
>  	if (rac) {
> +		if (!folio_in_bio) {
> +			if (!ret)
> +				folio_mark_uptodate(folio);
> +			folio_unlock(folio);

		folio_end_read(folio, ret == 0);

surely?

