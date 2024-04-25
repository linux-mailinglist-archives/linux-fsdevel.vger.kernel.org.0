Return-Path: <linux-fsdevel+bounces-17788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 606FF8B232D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1666C1F22645
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50D1149DE9;
	Thu, 25 Apr 2024 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NL2h/pvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898D1494D2;
	Thu, 25 Apr 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053223; cv=none; b=Knv1k21y9IyeLgOl6X/VCorbL1B1zsBiBB+5929X9wsC8KxFN2CeRHYOw8MFbPEhLQpp3rezh91AfcFPaeo3IaCQtHL4uNRXpcj263O+jmGO6Oo13kPuCi+ipYAgMvOEOUE1V0uo+tgOJT5dRVf5xc5x29o2FXPiT+EMytyWk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053223; c=relaxed/simple;
	bh=kTygqRn5TnrYiQq0EdL4g698bxw2DbF8Yc06ogmZQjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEssbvq+4G1A4TZKermktnh7rLGvuKUeei3QECMTRIYfuBFIFZI4L8vHtoAt098syTFMkSEp+w2ThsK0w6RsPJ7yTres85yM96lrBfAoodAigokme+wyhG6h/9QzA+YbwRSoOL69X1yToJnrY5BYH1gSw3teIShUo2Y+6dG8mt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NL2h/pvk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Wpcc2EluftTR3n+n1SeM6zbEpUWGx7QYSyu+jsGwMo=; b=NL2h/pvkiBcr+1dzLWdofK3E0b
	sGfVi0Z4TZXvobq8MGiOimgjeTOXNDUIERbQH9ACUcD80ZDv15pW+25HpFYLPPbgaET0O9p5KlygX
	/YwTAWH5i0VoYkpWU/YUmLjb0uRXo8tMKymVfT9ulCeTXNA4QUqkIItp4xqdvwOmJTUWUo1qCLQcb
	RD3aA4Ps/SXf38DC1rrFmiBCirMkTktH8MXECpuUOB+IHrPeZm0vWlZq0vPaRsVbieJCcjhozR40h
	y1GvB3/jgIwfWxLdqS+I+TB/OFKZyEovpxsVOzWW3iat/OX/VQX683/LgNCSGHt4GeOOvZsNdrZgN
	ZqhHHHaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzzXZ-000000039NX-2m4Q;
	Thu, 25 Apr 2024 13:53:33 +0000
Date: Thu, 25 Apr 2024 14:53:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 6/7] iomap: Optimize iomap_read_folio
Message-ID: <ZipgXVyehTovrRmp@casper.infradead.org>
References: <cover.1714046808.git.ritesh.list@gmail.com>
 <a01641c22af0856fa2b19ab00a6660706056666d.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a01641c22af0856fa2b19ab00a6660706056666d.1714046808.git.ritesh.list@gmail.com>

On Thu, Apr 25, 2024 at 06:58:50PM +0530, Ritesh Harjani (IBM) wrote:
> +static loff_t iomap_read_folio_iter(const struct iomap_iter *iter,
> +		struct iomap_readpage_ctx *ctx)
> +{
> +	struct folio *folio = ctx->cur_folio;
> +	size_t pos = offset_in_folio(folio, iter->pos);

"pos" is position in file.  You should call this 'offset'.

> +	loff_t length = min_t(loff_t, folio_size(folio) - pos,
> +			      iomap_length(iter));
> +	loff_t done, ret;
> +
> +	for (done = 0; done < length; done += ret) {
> +		ret = iomap_readpage_iter(iter, ctx, done);
> +		if (ret <= 0)
> +			return ret;
> +	}

