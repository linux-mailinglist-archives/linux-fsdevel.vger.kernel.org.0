Return-Path: <linux-fsdevel+bounces-33691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61749BD57A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 19:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB580284120
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CD71EABC6;
	Tue,  5 Nov 2024 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FPVui947"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B111E766B;
	Tue,  5 Nov 2024 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832946; cv=none; b=upRHdqvp3N2z8JwJskkKK0DXwgqa29obiBAZozdhSL9uUUF0hTcFQGFOvqz8g5mJ8fnrgYcrn/qtL9cIT+VgUd8OfYlukse0mWAaZLXrtFTGqmj6mwx7rRCDQ2pjE6rrSGgFCJJvAY/GkuucZ+V8BMIZhq2fgStkveSoI3D+dow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832946; c=relaxed/simple;
	bh=FyJwrbSOcefmy8hObu/h5kbLIkpKrzUHjU9Sx8dH+Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sp9yCkqLOLpAIbKbqRY7Px6+k8AGgrTBbRkWnpd27AmRk4lWIMXu+xMyRBTZbG/+DYSZaFngCIAQMLOT1hIHlkK4GNvFqNZNJBfEWIRYUycCRG5VBEECtRXZra7divgON/RznWP3vm3QP26mt9B8xo0hj5zG/2FsfsclQAx8J7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FPVui947; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=csnfmaX6tlJo2e1eAq4rsKokiFMcmhKAZZMJd6wjEOo=; b=FPVui947CyQVumsA4kSLOHx2jG
	spiyu2eEwhqOv10c3+Cy5zAaO0g8RtQFw7P/9bC91PgnvxTHviirZm0Ie69+03ccTOzmjScAGG66U
	Wq5BXDoq553rH6hMz4v64bZty6Bb4lZtRz3t8ih8Yg5/W6B9egy7z7zWixbgXb0CpW+fL6LXA7qT0
	qPNR1+I4R5xn+pxUhM2wB2IvMaqbGH+Hkc0mW8SoLOYe2JJhCwiQBLODdErd8HSxY1lKZ4k7Io132
	mG4P3OnM4Ezlzw7TaqiXA0aXcq4vySmfOcI6jfVmNw4RWVZuDsUYFy/h0AkCCO/7QywZwTlOxnF9M
	a9arNg0w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8OiF-00000003Tnf-38ZX;
	Tue, 05 Nov 2024 18:55:35 +0000
Date: Tue, 5 Nov 2024 18:55:35 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shivank Garg <shivankg@amd.com>
Cc: x86@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, kvm@vger.kernel.org, chao.gao@intel.com,
	pgonda@google.com, thomas.lendacky@amd.com, seanjc@google.com,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, arnd@arndb.de, pbonzini@redhat.com,
	kees@kernel.org, bharata@amd.com, nikunj@amd.com,
	michael.day@amd.com, Neeraj.Upadhyay@amd.com
Subject: Re: [RFC PATCH 0/4] Add fbind() and NUMA mempolicy support for KVM
 guest_memfd
Message-ID: <ZypqJ0e-J3C_K8LA@casper.infradead.org>
References: <20241105164549.154700-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105164549.154700-1-shivankg@amd.com>

On Tue, Nov 05, 2024 at 04:45:45PM +0000, Shivank Garg wrote:
> This patch series introduces fbind() syscall to support NUMA memory
> policies for KVM guest_memfd, allowing VMMs to configure memory placement
> for guest memory. This addresses the current limitation where guest_memfd
> allocations ignore NUMA policies, potentially impacting performance of
> memory-locality-sensitive workloads.

Why does guest_memfd ignore numa policies?  The pagecache doesn't,
eg in vma_alloc_folio_noprof().

