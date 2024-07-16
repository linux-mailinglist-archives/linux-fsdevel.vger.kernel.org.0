Return-Path: <linux-fsdevel+bounces-23791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DD693343C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 00:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04821C22F92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 22:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81BE13CA95;
	Tue, 16 Jul 2024 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bTJa1qtN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0047914A84
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721169069; cv=none; b=o3pXQMnRkUDJBwN1m425TAL914Jryj2if49altL41nTYHVu1Q5TKDDdBqWipZj2kLd0wDiZ2vcTxLFVWD+pYOpMrVt0AlMdFVNv7UxvhVYoy4QmV/VJNWdTjd9ikAEby1NkzmXNK30gpv82zwaayWgLMEIfnEIi/DpvuWzPzQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721169069; c=relaxed/simple;
	bh=UFoyg9T/I//Oz0s8nNgtOz4U170l/XAxZoAyOwE/YDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPjlbABsGaEU+h8SILV4Va1FzsnkcvecSQedsWgSfkGGeEQWlAFcDzKUhclrWXH/oc8z8MZyfnBj/61LFA2986d65sdOUV6w1dTvUbHkxofM/rJjU94T3da3o/ffzTumEs99fDgtVOwxRbK91zUcVMVBrvOcMNw6upDCD+RXdUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bTJa1qtN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tN8wjP7Fax1ckXn/zdPm2AC3kguQmtDKVJT6uBP8L1I=; b=bTJa1qtNB7aKGkPrs9FHAlY16q
	wOadMcV78Bq/UHgnjyl3zUmW8hpWR6v+FzKhA9knCeF6BURYecxD9JulhuzUCqBBDdisfXerCiV3v
	0iZtGcSqbjDZQDKHN7ehiWo1uOHKRxCzshz9yIeFx5JbMYaDdcKyFgvF2vfMYB5N+QhfJud7fqVVt
	1T8YMkCBKcbamd/SuRxl8FeAQ7/eTv1fNmPDLRCfUMmEJu2C3o/1ADFkY18PvFSG/Lj3fB6I1ZF0Z
	lWBFRXEle9gOddTPVfzYvwjw2DyW4cvsZsWcbO2WEwma3uxS5tgaqMPxIaKMRZbsy29UQHQTmiRdH
	YN/cZsLg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTqhL-00000000Jyb-11YO;
	Tue, 16 Jul 2024 22:31:03 +0000
Date: Tue, 16 Jul 2024 23:31:03 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/10] ufs: Convert ufs_get_page() to use a folio
Message-ID: <20240716223103.GA76604@ZenIV>
References: <20240709033029.1769992-1-willy@infradead.org>
 <20240709033029.1769992-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709033029.1769992-2-willy@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 09, 2024 at 04:30:18AM +0100, Matthew Wilcox (Oracle) wrote:

> +	struct folio *folio = read_mapping_folio(mapping, n, NULL);
> +
> +	if (IS_ERR(folio))
> +		return &folio->page;

		return ERR_CAST(folio);
would be better here; yes, I realize it's going away in the next commit,
but it's easier to follow that way (and actually makes the next commit
easier to follow as well).

