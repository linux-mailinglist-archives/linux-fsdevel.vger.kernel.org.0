Return-Path: <linux-fsdevel+bounces-27279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7CF95FFF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B721F227A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 03:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3637D1BF54;
	Tue, 27 Aug 2024 03:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KzMh5uQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FCB17D2
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 03:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724730389; cv=none; b=qgkjeoAgtqjKU2w8nauhwe4VmzPdHHwD5PuASvEyx/gXWK8VmT+bfruVKetqQHzZRLhDIjvMSAnZ5MfKqG0VhDTaLRtrbf/4ihKB0zBkdEnxAXNFly+TjbwCR+yPWQRZ3Wglec5wSNdKFq2wrTfQATV2oBhDTwLm2ppIrEIMFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724730389; c=relaxed/simple;
	bh=Be0UPqvHT+f6tfndMjq6qEOWV8mIBmolkyccY2s+j1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXtDsda06PHEhmh5j5IwTQr4zW2LxP7ASs/C5VgAukCDzIJ2JHwSazwVFZV7BUBtse/7jJp9W9TeOMnJ9KWpqzTGG8eztgETboQdSEdm3YpWSNK74c6s64OZDYYpnCpmVu1plZ6KPpwLTfScqhK3FUUB0/Fyt+NVSDIPX6+mT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KzMh5uQM; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 23:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724730385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sZOYCYtMYjTlpd/hIkR0T2CyO/7x5lAIgRzfcbKmRfY=;
	b=KzMh5uQMoLAIG/Nm7YPcPe5UW2H8NLRCzNP1KDsTo9XWYTnsaIFDwUnJg/AHOlthHCG/WU
	5khKuAI34KlgJCqmea/h9FaMBgNgpkL+K4u1l5eMfHrcEyNS+zflq6NllRqzx1xnft4QXE
	MuuTQtU1Q16SxisYWDDiRoXeHCP3VMs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org
Subject: Re: bcachefs dropped writes with lockless buffered io path,
 COMPACTION/MIGRATION=y
Message-ID: <7qttwffpydvnzqm7mjflqui7ywjb5gvhmvwebxktoth33ffpnc@llewszyqw42z>
References: <ieb2nptxxk2apxfijk3qcjoxlz5uitsl5jn6tigunjmuqmkrwm@le74h3edr6oy>
 <Zs1JwTsgNQiKXkdE@casper.infradead.org>
 <2iroae47robod2vijalby64iczk2emltrshmztlwyrxmkeiydd@4lxo55nlgpxo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2iroae47robod2vijalby64iczk2emltrshmztlwyrxmkeiydd@4lxo55nlgpxo>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 11:40:57PM GMT, Kent Overstreet wrote:
> On Tue, Aug 27, 2024 at 04:36:33AM GMT, Matthew Wilcox wrote:
> > On Mon, Aug 26, 2024 at 11:29:52PM -0400, Kent Overstreet wrote:
> > > We had a report of corruption on nixos, on tests that build a system
> > > image, it bisected to the patch that enabled buffered writes without
> > > taking the inode lock:
> > > 
> > > https://evilpiepirate.org/git/bcachefs.git/commit/?id=7e64c86cdc6c
> > > 
> > > It appears that dirty folios are being dropped somehow; corrupt files,
> > > when checked against good copies, have ranges of 0s that are 4k aligned
> > > (modulo 2k, likely a misaligned partition).
> > > 
> > > Interestingly, it only triggers for QEMU - the test fails pretty
> > > consistently and we have a lot of nixos users, we'd notice (via nix
> > > store verifies) if the corruption was more widespread. We believe it
> > > only triggers with QEMU's snapshots mode (but don't quote me on that).
> > 
> > Just to be crystal clear here, the corruption happens while running
> > bcachefs in the qemu guest, and it doesn't matter what the host
> > filesystem is?
> > 
> > Or did I misunderstand, and it occurs while running anything inside qemu
> > on top of a bcachefs host?
> 
> The host is running bcachefs, backing qemu's disk image.
> 
> (And I'm using nested virtualization for bisecting, it's been a lot to
> keep straight).

Also, the size of the missing data is not a power of two - it's not a
single folio.

