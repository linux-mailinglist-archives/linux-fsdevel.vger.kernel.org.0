Return-Path: <linux-fsdevel+bounces-58352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA6FB2D06D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 01:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1871C44AC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 23:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7AA26F2A9;
	Tue, 19 Aug 2025 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aS/up6TF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07C2144CF;
	Tue, 19 Aug 2025 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755647210; cv=none; b=TIGV5b13XFkSM2NQ6jWWK4HkjmEIgE+WSmjtnNFxqMEt4uve2v0esYkrzrqjPDeMJNPvtaWJ47q/ON4fsHwWGXKuI/k2xlcB1X1g20xJMovLcOY8rsuTmWF3r+fJzLmLhA9vNITdBcJLPQeKhvkwSUcNzX9+fk8tCiBkNFf7iU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755647210; c=relaxed/simple;
	bh=HUJtDAvIqdYHH1g4yk/efkwTUsCC8OsmnwxTPAC3dhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIQuZlETMUhfIG3HqJQyngaOsdcFe3pn8PaEAd7mtaX7Cq0aGTofrXRwZ3NV4UuusjplBCs8JyBZLhyOcCO31yGp+C5RqtlbltAM2pBedZq1AzR3leUPNRMru6fvggVs9fhQ15ZRgMbUX7QVVElp8kiaP5PV6D+84tO5ZZfgWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aS/up6TF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HEUPIQNacF5PxxegBqbsUnaXiJZQ0xuzwBbC1vo0iYE=; b=aS/up6TFfUES39twyNhHcGUqhQ
	2LbOzNknbl7g1/yUUQZydAWqxAyuy2e9u5wgiuF4bjCY5NA2/4SremYME0vfgd0N0ze1tyaYjwkmQ
	PopQ7jcFhndtS2D6BklWFz8raGWRRvXKNF24dDrLnvmFCPxqvUdmRf1i9yu1iy62WI0nmEjdJhYQk
	SSou+oZF1u9gKQG5RBnIvp80YXgpVpdvR0BkpJH9/uqV3CGBpcI1Q6B0A1WYcxQRlCDSoUkkLy6jh
	powKvt5Y8cun2DJP82W2jBsIud7NAnejHd4nmDHQbkTeTmNWxIBZYmAB1/LXwPtc7PjdfBkjsqj0M
	5zaqkVWA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoW2N-0000000E9dY-1uMv;
	Tue, 19 Aug 2025 23:46:43 +0000
Date: Wed, 20 Aug 2025 00:46:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Boris Burkov <boris@bur.io>, akpm@linux-foundation.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, kernel-team@fb.com, wqu@suse.com,
	mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev,
	hannes@cmpxchg.org
Subject: Re: [PATCH v3 2/4] mm: add vmstat for cgroup uncharged pages
Message-ID: <aKUM49I-4D24MmwZ@casper.infradead.org>
References: <cover.1755562487.git.boris@bur.io>
 <04b3a5c9944d79072d752c85dac1294ca9bee183.1755562487.git.boris@bur.io>
 <aKPmiWAwDPNdNBUA@casper.infradead.org>
 <tw5qydmgv35v63lhqgl7zbjmgwxm2cujqdjq3deicdz2k26ymh@mnxhz43e6jwl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tw5qydmgv35v63lhqgl7zbjmgwxm2cujqdjq3deicdz2k26ymh@mnxhz43e6jwl>

On Tue, Aug 19, 2025 at 08:53:59AM -0700, Shakeel Butt wrote:
> My initial thinking was based on Qu's original proposal which was using
> root memcg where there will not be any difference between accounted
> file pages and system wide file pages. However with Boris's change, we
> can actually get the estimate, as you pointed out, by subtracting the
> number of accounted file pages from system wide number of file pages.
> 
> However I still think we should keep this new metric because of
> performance reason. To get accounted file pages, we need to read
> memory.stat of the root memcg which can be very expensive. Basically it
> may have to flush the rstat update trees on all the CPUs on the system.
> Since this new metric will be used to calculate system overhead, the
> high cost will limit how frequently a user can query the latest stat.

OK, but couldn't we make that argument for anything else?  Like slab,
say.  Why's "file" memory different?

