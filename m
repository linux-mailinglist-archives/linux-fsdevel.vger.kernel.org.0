Return-Path: <linux-fsdevel+bounces-42298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9721CA400C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 21:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7269E441CED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 20:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3639B253B68;
	Fri, 21 Feb 2025 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J1gSTMHP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE9253B58;
	Fri, 21 Feb 2025 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169521; cv=none; b=QPjxWPacRc7woZKeMEehBcLvdNBd5LtCv0T6IIW8eLIjPcIvUvgJeUCKwEyp2DB0ZCmNZRPUNkigu/z5EGN3tWS15bon3q3iygUZFzacUwtiIoBOuhhh21U6UvTdJWwaWYYWILy67ofo2cIkpA/yi2VqB7H3zIWC1Qrem8FQXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169521; c=relaxed/simple;
	bh=n2mWrWfmMYEeieSfaz5crDcj8CgEyJA+PrQQydiEUcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jb0RXWE3KkZ0iy77/QKlo2meYs+y3Q+XV6zGMstQhtE+5qNvVmo7WRm3Jzj8JzhgcVO1ReGejB8vGtiB0Gx0kTuePjT4qZgpTxO9UiPfxiY6TqYvaE2ju9ncvNcfIg0RQIk6HJCmSoHVMrObdi4f7YhDzzsa/iuZHVmyrBfKZDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J1gSTMHP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hAm3p9v8B+1l5GQyM7hf4JtpPwNn3Z+XWSql/Do780M=; b=J1gSTMHPzC6//giA6rZgkDCO6G
	DxyXtoefT1i5AUdWUZA7Cg+LJCCMamTy1ZW/qTIcoBql2Hy0bbCnvWKVEjdyqN7zIWb9L4xtYitJY
	RCeJrpZL4/N3td4OW+08Fw7LgL30bzwyan50xvHUnZSZvso3D4Q25mn7buBYHkec/JjJHl3IE1f1n
	aj7JYA5ch9LUPkzfDSzUYnCEYHQn+Vyx5kJrsTIMueYWHqNe4h4anf7dNoaMLfVo0WzhPXXaVJYXn
	RZ1NwbBCvb2Fu7i2YAi4sa6hDeHsUTjYqOdZVTd4CgS85io6ztutk4zH7l7N4IEtR0aTKznV0SGSF
	nndq4CVA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlZaC-0000000F2SA-0UFb;
	Fri, 21 Feb 2025 20:25:12 +0000
Date: Fri, 21 Feb 2025 20:25:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, dave@stgolabs.net, david@fromorbit.com,
	djwong@kernel.org, kbusch@kernel.org, john.g.garry@oracle.com,
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v2 4/8] fs/mpage: use blocks_per_folio instead of
 blocks_per_page
Message-ID: <Z7jhJ9_AipEbpKmV@casper.infradead.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-5-mcgrof@kernel.org>
 <Z7Ow_ib2GDobCXdP@casper.infradead.org>
 <a4ba2d82-1f42-4d70-bf66-56ef9c037cca@suse.de>
 <Z7jM8p5boAOOxz_j@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7jM8p5boAOOxz_j@bombadil.infradead.org>

On Fri, Feb 21, 2025 at 10:58:58AM -0800, Luis Chamberlain wrote:
> @@ -385,7 +388,7 @@ int mpage_read_folio(struct folio *folio, get_block_t get_block)
>  {
>  	struct mpage_readpage_args args = {
>  		.folio = folio,
> -		.nr_pages = 1,
> +		.nr_pages = mapping_min_folio_nrpages(folio->mapping),

		.nr_pages = folio_nr_pages(folio);

since the folio is not necessarily the minimum size.

>  		.get_block = get_block,
>  	};
>  

