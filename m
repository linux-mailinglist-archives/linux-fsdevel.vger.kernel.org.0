Return-Path: <linux-fsdevel+bounces-41482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2BDA2FBDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 22:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7051888D7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 21:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9642B24E4BC;
	Mon, 10 Feb 2025 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t97e1HkA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE26E24CEF9;
	Mon, 10 Feb 2025 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739222289; cv=none; b=VeSQW1PnhqMp5YQrOJk7ja2TjdkZonsH57xILoaax3Yf++hVDOe45W98UL9R8EAFwErOdRspZ210SOkbCCF+24gozWs+Zw+1HkhBa7OZEiaof9BzI6WJdMpDqJwsD4HhO0fDQ52cf3YMG9JSoEVcJBBRdu70yQflk8gkZGDhrnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739222289; c=relaxed/simple;
	bh=FqFgLXXsWXWhhqPFJsoFGXHoF0ZClHSi4272/zYwWJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5JkIrsxTy/KBFuUhMSmADjCRiGCS96gjbp+pXvsOtoW73xxskJJtRxwjj+YHNinjwMYqX87aqmI0k9jFt8mIhQg8sjQfKhGsk26jRklQPRXn2/epLtz5SGmhMRBnffaNcYdfivz1N6EfcR6YcDGgg01nS8PJeSBCpC2qJx0dYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t97e1HkA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GrlnFGpTcpJHCevQurfmbvgrKTwhzhcmfTdnYrE4ibo=; b=t97e1HkAox5QN0FLIyIeq2exVs
	fNXQoKT2xnLU9hq01Pm8bHhbRiEIb3VPUqtADDs4T5xFWweQ9C+WAptWLuHbXKs1LCEq8KVMstqHS
	itl4c2oNuCT4jWChinvOLxrUiZ2ORAE1Sq3MpdHBTAXn9nnwDCCE6jP5+xcq595s3wJ32wX78Ekan
	U57P6N30p8LMIITW/AkzhvDt60KarhszJowEw34KladrLUc9H+XaHzq0p4iNGm4TxjEZar0EbXELC
	xAZAC3js7tMDnPm56iJfWjNWcpcToIMtQOqkVHwSLdNFoPMUubq2SWetqQ3Cp1AcBiFTshuer8aqD
	qglLbrNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thbAK-0000000Gmuv-2i7Q;
	Mon, 10 Feb 2025 21:18:04 +0000
Date: Mon, 10 Feb 2025 21:18:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org, hch@lst.de,
	Avi Kivity <avi@scylladb.com>
Subject: Re: Possible regression with buffered writes + NOWAIT behavior,
 under memory pressure
Message-ID: <Z6ptDG96_MrdN07R@casper.infradead.org>
References: <CAKhLTr1UL3ePTpYjXOx2AJfNk8Ku2EdcEfu+CH1sf3Asr=B-Dw@mail.gmail.com>
 <Z6prC2fBbd6UE49r@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6prC2fBbd6UE49r@dread.disaster.area>

On Tue, Feb 11, 2025 at 08:09:31AM +1100, Dave Chinner wrote:
> Better to only do the FGP_NOWAIT check when a failure occurs; that
> puts it in the slow path rather than having to evaluate it
> unnecessarily every time through the function/loop. i.e.
> 
>  		folio = filemap_alloc_folio(gfp, order);
> -		if (!folio)
> -			return ERR_PTR(-ENOMEM);
> +		if (!folio) {
> +			if (fgp_flags & FGP_NOWAIT)
> +				err = -EAGAIN;
> +			else
> +				err = -ENOMEM;
> +			continue;
> +		}

Or would we be better off handling ENOMEM the same way we handle EAGAIN?
eg something like:

+++ b/io_uring/io_uring.c
@@ -1842,7 +1842,7 @@ void io_wq_submit_work(struct io_wq_work *work)

        do {
                ret = io_issue_sqe(req, issue_flags);
-               if (ret != -EAGAIN)
+               if (ret != -EAGAIN || ret != -ENOMEM)
                        break;

                /*


