Return-Path: <linux-fsdevel+bounces-35601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC5B9D6439
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 19:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C7E0B25263
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 18:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6409B1DFE16;
	Fri, 22 Nov 2024 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dpKJyFBg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6007082F;
	Fri, 22 Nov 2024 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732300415; cv=none; b=SpCZZhlPM5NaJMsR0UwukLGGxxJVtw7/mdYKS1KbcFGqUPCnxEEO4ml5yxLonn8W1FG74C7HkrWjrNlrMGTyHrNdPRBj528RzTvaU3Q146Q/32A/as9CU8khVlVeJB4S0Xzi7F93zjX3k+qIW14YIKwDofVsM18pxgyKTn/vcJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732300415; c=relaxed/simple;
	bh=s/lKxZ3bW4uqSdWd1QY3WYnqLJ1cbwt/7fWWgj5cKo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2HA/aY3fL4XuaafWUNt+JY+fCzrWrc3fGKX4Pi0jhypuFaiBvTTlwGK2qfJy279N6lCnsVpt+VD+mE6FNUax9MfVS2yzmQzof+RUhpw5UydwQtB8Ys4gKAghWVebdro5CCswyrQMkehl9b7JMr9m1uzGLqL5grer6wmyfj5FfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dpKJyFBg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2+K2vO+YH28AbBPpcin8XCiUS+NS9nCewhxVz1hPnHs=; b=dpKJyFBgo5rAV5bVvDqMFqw21z
	93FmlQvXiYAcgtJHjPq0kqXWIrXVNMYT1cax3pXa5gTAso3KQf7Ghn79Vb31Od4P1ff0dWeEKdpa0
	Nt0+RKtkYYTsePr9gI6Dx3LA2wxiz8eVxJbH1t6Gtcn18xAi8Sty91FlynmjrHllIjJoPhxwNPlvp
	/TC4eJqkps4ZMjV7WYLXOMPMj5NVJWDFL6gA0mbrojQFdKYLQ9xhGcSS3ZW/I7dBh2CDxxQ5kCKm+
	6S/k1wAeFJ1fQQFkViTvBF/zJ8qOleScAf0wLCPWMV+VhCEbsWqPqOyHNic4cpNwONVAtshrXeTo+
	j+hifZaw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEYT7-000000088t7-1mo1;
	Fri, 22 Nov 2024 18:33:25 +0000
Date: Fri, 22 Nov 2024 18:33:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Fuad Tabba <tabba@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	James Gowans <jgowans@amazon.com>, Mike Day <michael.day@amd.com>,
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org,
	devel@lists.orangefs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/2] mm: guestmem: Convert address_space operations to
 guestmem library
Message-ID: <Z0DOdTRAaK3whZKW@casper.infradead.org>
References: <20241122-guestmem-library-v5-0-450e92951a15@quicinc.com>
 <20241122-guestmem-library-v5-2-450e92951a15@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-guestmem-library-v5-2-450e92951a15@quicinc.com>

On Fri, Nov 22, 2024 at 09:29:39AM -0800, Elliot Berman wrote:
> A few near-term features are coming to guest_memfd which make sense to
> create a built-in library.

You haven't created a library, you've created a middle-layer.  This
file primarily consists of functions which redispatch to a function
pointer.  I think you'd be better off creating a library!  That is,
have the consumers register their own address_space_operations and
have functions in this library which provide useful implementations.

That's, eg, how iomap works:

const struct address_space_operations xfs_address_space_operations = {
        .read_folio             = xfs_vm_read_folio,
        .readahead              = xfs_vm_readahead,
        .writepages             = xfs_vm_writepages,
        .dirty_folio            = iomap_dirty_folio,
        .release_folio          = iomap_release_folio,
        .invalidate_folio       = iomap_invalidate_folio,
        .bmap                   = xfs_vm_bmap,
        .migrate_folio          = filemap_migrate_folio,
        .is_partially_uptodate  = iomap_is_partially_uptodate,
        .error_remove_folio     = generic_error_remove_folio,
        .swap_activate          = xfs_iomap_swapfile_activate,
};

Some of these functions are xfs specific, some are iomap specific and
some are the generic VFS implementations.

