Return-Path: <linux-fsdevel+bounces-69137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EF7C70D7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 20:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 75D972ED6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 19:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8435E36CE15;
	Wed, 19 Nov 2025 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cvmA9fVW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5A302748
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580966; cv=none; b=jDuTik3pIUdRJvPtIuAVdHrIgQIhMHNf221Y1FImjEzNYvu/tIDdUHJlX4r21PcxJuwRxDGNXGR8zE5pZXcjI+PMK5VgS2xlKlaRCSqU3jC/rux2JLBYyE7AqZt6WO7DGhLx/8kjccG0tXSCPzO6OV/CkcUdLlIuMFL7z1cvgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580966; c=relaxed/simple;
	bh=FwDv0ZzjBjtPMOqKWFd6j71NY0EoeaFWOyxWS1lxjcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irdkdwEQ6mDUKn1ASJMUFnMwWXyREluTAEkdO1U7pBTiIsfP5fpPVNtUNLf9LypEG1Ixh4bmx/z9zyKWmO0Fi9OX22S8TnnjarlJp4SHBuBpXzKaSBVcZMD0OK5rkvx40+LZRXdEF//kHJDH62etI0AztKSu2zaFGyXkfyBfpok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cvmA9fVW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/q8uRNHdGwjldUB5Q3w09PYNajYEIE4OrZEjvdvqMqo=; b=cvmA9fVWG0P3QpBpx3N3JtSyxe
	iBRSGWncjyaafs0N9msdNSoFO2+eXZPd1G0XMiLEyng2zqq/R7oypRvq1z6sOBo/E+riqD6WC2IJy
	LSjh6qT6VzX4MvDP0/iXOOkapX7iGs0lGY76E3Rd8sclJVW5F+7YOpLoakcsb4OFNpqI3CrfNrwHN
	VgoAVDuV3Fmw/u0dyld5QCkMXdmL61VfuUXvOFuAAtARIRj+ta991B7zOqKzxXfLxdPf03XNWiymF
	5qvWeZdkcuv0OmY97n/aHTlUrDPh/ZmimDwNCzmdSDt6pQYgxN9YHjrUzFHhoGhlmQaPWQnmdkC7z
	qp0Yudag==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLny8-0000000Ha0V-3mFn;
	Wed, 19 Nov 2025 19:35:56 +0000
Date: Wed, 19 Nov 2025 19:35:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org,
	hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/9] iomap: use loff_t for file positions and offsets
 in writeback code
Message-ID: <aR4cHCv0eabXywYU@casper.infradead.org>
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
 <20251111193658.3495942-8-joannelkoong@gmail.com>
 <aR08JNZt4e8DNFwb@casper.infradead.org>
 <CAJnrk1Yby0ExKeGhSGxjHiYB9zA7z51V2iHdCjHLAn_Vox+x7g@mail.gmail.com>
 <20251119182750.GD196391@frogsfrogsfrogs>
 <CAJnrk1apaZmNyMGQ5ixfH8-10VL_aQAG8--3m-rUmB6-e-dtVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1apaZmNyMGQ5ixfH8-10VL_aQAG8--3m-rUmB6-e-dtVQ@mail.gmail.com>

On Wed, Nov 19, 2025 at 11:17:41AM -0800, Joanne Koong wrote:
> On Wed, Nov 19, 2025 at 10:27 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > xfs supports 9223372036854775807-byte files, so 0x7FFFFFFFFFFFF000
> > is a valid location for a folio.
> 
> Is 9223372036854775807 the last valid file position supported on xfs
> or does xfs also support positions beyond that?

#if BITS_PER_LONG==32
#define MAX_LFS_FILESIZE        ((loff_t)ULONG_MAX << PAGE_SHIFT)
#elif BITS_PER_LONG==64
#define MAX_LFS_FILESIZE        ((loff_t)LLONG_MAX)
#endif

Linux declines to support files beyond 2^63-1.  Today, anyway.

