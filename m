Return-Path: <linux-fsdevel+bounces-35600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C369D6422
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 19:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B001280FE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6BE1DFDAF;
	Fri, 22 Nov 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cbSvla7i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D731DF255;
	Fri, 22 Nov 2024 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299791; cv=none; b=fqc6eGWcapF0ZM4D99Y0ZnCvmDnHoc5CRouNA/qBfLmCi3K3WZRx74aKaWzr0VnmuS9JuZFUJwjkcFzhyZ+AkAZoCgRSzQkbIDAD0CiVYwpyLrBM4floygq7DckCZRLx1JqQXgVtNel8yXBxGSRMsHro8cHKtuHRWs+/BywtRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299791; c=relaxed/simple;
	bh=yMq2dZlzx0j16v83wajqstloGi3wXiyrz+Joq5vwcH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqGYPTsF3iTGdKxj9X1Edj3eAhXiEZJqDWlrIdHjKX3JUtlGBLBRY3KdPf1xXcDqt23D55Ag7pl/0DFDLDBeUm3rWizhPCf4rWVCy1BR2w1mDj0uH+XqpgLv+rEjBb9wBrVnc2Bs+AnMKTtFwGzseV4sKLxP8RfI3B8BTZcWWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cbSvla7i; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9sYuGQL1WZhF2hZ3J+JuipVRSYMiUCSOWCts3kbR50A=; b=cbSvla7iPzxM6su8n80MIGoprm
	S+XTGfyXS26q0XPJZk402JCQashv0FVUmR9e5nqkM6A4/NUqk5ACCwY41XdwkX5lAWwZEOxa/YED3
	kxiKQOnp/rEYGoNa/EgL9HQ5Ds2fh3wiDja8v6+l1FmxXDjmCMPwfS+dMG2LkeFHpOq7/8b+mGuNt
	N3n5B3uye5L1DQ7tDPrmPgwy7GOFVso//2eg+HA3Pi55t0t8nnuPEt4kG1AgBRXmmawAToDF8P+7v
	ayC6bo0RQ0Bed9NsmeCJhHPgZmrfoiFQgDyBLTFMyiTbQUCB46To4bPPbgO6MCzScg1su5w8aiUWf
	GK6C7cQg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEYIw-000000088Di-12lh;
	Fri, 22 Nov 2024 18:22:54 +0000
Date: Fri, 22 Nov 2024 18:22:54 +0000
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
Subject: Re: [PATCH v5 1/2] filemap: Pass address_space mapping to
 ->free_folio()
Message-ID: <Z0DL_jL4Tw_Z1LKD@casper.infradead.org>
References: <20241122-guestmem-library-v5-0-450e92951a15@quicinc.com>
 <20241122-guestmem-library-v5-1-450e92951a15@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-guestmem-library-v5-1-450e92951a15@quicinc.com>

On Fri, Nov 22, 2024 at 09:29:38AM -0800, Elliot Berman wrote:
> When guest_memfd becomes a library, a callback will need to be made to
> the owner (KVM SEV) to update the RMP entry for the page back to shared
> state. This is currently being done as part of .free_folio() operation,
> but this callback shouldn't assume that folio->mapping is set/valid.

I think this could be slightly clearer ...

guest_memfd wants to inform the owner of the page that the folio has
been removed from the mapping.  The best place to do this is in the
free_folio() callback, but the folio's mapping pointer has already been
cleared.  Pass the mapping in so that the callback knows which mapping
the folio has been removed from.

> ---
>  Documentation/filesystems/locking.rst |  2 +-

Because life is hard, we also have documentation in vfs.rst.  Can you
please update that one too?

> +++ b/virt/kvm/guest_memfd.c
> @@ -358,7 +358,8 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  }
>  
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -static void kvm_gmem_free_folio(struct folio *folio)
> +static void kvm_gmem_free_folio(struct address_space *mapping,
> +				struct folio *folio)
>  {
>  	struct page *page = folio_page(folio, 0);
>  	kvm_pfn_t pfn = page_to_pfn(page);

You could just use folio_pfn() here; maybe sneak it in as part of this
patch or do a separate patch for it.

