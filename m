Return-Path: <linux-fsdevel+bounces-40089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F043A1BDBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 22:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55883AAD4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 21:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8173B1DCB21;
	Fri, 24 Jan 2025 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nJ5LgdXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771BF1DC9AE
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737752981; cv=none; b=u6xpweNmZqgF19HfY6EA/aE5jy5omp42GBVX0aNJGdhbdHDv39My5Ja1Fv+Pyrcl2ikpSlZ1EAf+9mnNMEr5iPPRHTy7UhIGiMLZtPlx3hRSwYSf9WkMjWkQAAuCoNAPUF2gnwWmcqMoTzqpubnWzGuI0CpVbMPmKy0vBs+7xos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737752981; c=relaxed/simple;
	bh=I/MHonMaXLBBigeUwx/AnqWFm+drlLHfrklhJLt43sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWvu674OGgtKK9eNR1ERBTkjMjI72xfEMY8QSjIjHVU6ylCbJJL+g14SQRajHbWUtGJBs+PF/2287qZS+d/u+L6xfuarFd2F9kFHaZI2X86MeDD3hIta6VKXvwTmswsIrDW8HKFTRICddvhRj3Rg43wW115/ere8cBuoIyxen2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nJ5LgdXa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bp4ZV7Qo6Tfe/pXGBMeweFxUXbdjHD4d9DgwQa4VwKc=; b=nJ5LgdXafSiRvFmLJurQtlCkVO
	WmwJcN+Vu+6pxoJ+mB+smxWEn3N7Rbbq2HCK2CaFw7nLEb4dGzPiOclum504+v8PoyimTOVOKtGdM
	M1yWzEFpv/gpusyE2a3OXKsam8aQYywVJ9oEtLzoCUo6NIIpmxbQzSZZotEZr1XUFPGJrGkmJa1Vw
	XLe45X64bvTZK3trUWQ041/22oDgtJ1LznGPvo1hx7nTxETMdj4+xBtcptXEXR25ZY6L1DeW0OgFz
	sIfdfr+GxyDf/OMWQ2OI5T1iLf4+HmXTwTwNjWjJqH92G8FkIsCH5StmpcakrzaV7P2NOxHT41/yH
	erq60Fbw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tbQvg-00000000qq5-1EDw;
	Fri, 24 Jan 2025 21:09:28 +0000
Date: Fri, 24 Jan 2025 21:09:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Day, Timothy" <timday@amazon.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jsimmons@infradead.org" <jsimmons@infradead.org>,
	Andreas Dilger <adilger@ddn.com>, "neilb@suse.de" <neilb@suse.de>
Subject: Re: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
Message-ID: <Z5QBiMvc-A2bJXwh@casper.infradead.org>
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>

On Fri, Jan 24, 2025 at 08:50:02PM +0000, Day, Timothy wrote:
> Lustre has already received a plethora of feedback in the past.
> While much of that has been addressed since - the kernel is a
> moving target. Several filesystems have been merged (or removed)
> since Lustre left staging. We're aiming to avoid the mistakes of
> the past and hope to address as many concerns as possible before
> submitting for inclusion.

I'm broadly in favour of adding Lustre, however I'd really like it to not
increase my workload substantially.  Ideally it would use iomap instead of
buffer heads (although maybe that's not feasible).

What's not negotiable for me is the use of folios; Lustre must be
fully converted to the folio API.  No use of any of the functions in
mm/folio-compat.c.  If you can grep for 'struct page' in Lustre and
find nothing, that's a great place to be (not all filesystems in the
kernel have reached that stage yet, and there are good reasons why some
filesystems still use bare pages).

Support for large folios would not be a requirement.  It's just a really
good idea if you care about performance ;-)

I hope it doesn't still use ->writepage.  We're almost rid of it in
filesystems.

Ultimately, I think you'll want to describe the workflow you see Lustre
adopting once it's upstream -- I've had too many filesystems say to me
"Oh, you have to submit your patch against our git tree and then we'll
apply it to the kernel later".  That's not acceptable; the kernel is
upstream, not your private git tree.


