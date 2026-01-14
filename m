Return-Path: <linux-fsdevel+bounces-73786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E9BD20699
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 18:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DD3A30E42C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367723A7845;
	Wed, 14 Jan 2026 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5rGUtxb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDBB3A4AD6;
	Wed, 14 Jan 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409956; cv=none; b=VQH0cNKaqP+ohCHLlLRW9H1lo8x04IpRk1sNRNqPK5lKzrZB8PFrhTIBGwjw7hsLmmn8VYWmJ1zek1tP6fKMkQmqHbBJ7KurlKhIOZ2ZBWR6u+b9p3xHqyYyFFCOFEFTst2KjashzkbA+K1yQH7IQW0mrCQJyKHXZVjE/57U4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409956; c=relaxed/simple;
	bh=B0iF/dvyn/kec3053bYjCb0vU7YgriPK61h7HY9oPK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyS6DKzFVo5grsJlZZxf2t8IADrF1HiKBF0tG07lhjikNjk9DuTHT7nYzQodDuyFjdQ1lDsq2YAbhCxLEBP9E7HV5O+vdWIkKSc3hLJ/8X+KABmoMqIprDkIDqxHiaVxnDavPJcyU9/G9EeF02nFoZxQnF6koiHtUKpJDRq3jjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5rGUtxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DD4C4CEF7;
	Wed, 14 Jan 2026 16:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768409956;
	bh=B0iF/dvyn/kec3053bYjCb0vU7YgriPK61h7HY9oPK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5rGUtxbTEFRVIwKmrHc2xHpl8euv4Jw61qaIMJHTpRKz2a4Wpu0xrGEmM+eetht/
	 4kyUSIxUQSya+dfCBPaIyUSuOepCAXBVpCLeUw9fXTaK0jHnNxz6JsxoBI0MeNnHe/
	 vId4RJ2fHC56O9ppqki5yeCg8P2YagaI8NbnorlgkUhxqq4FrrxrB8qQpQ47T0KUNW
	 eYsitdf330m4rKkulB74dq5rn6lk3DOk5FWv5qS9Wio7TIXz3v9cpvERGIp6LF6tfC
	 3Ws/w2epkFANtwCr7qac4IeIbQNoqU3eltzoWZlT5jAI12pCtBM4YHIACXBKdiJhyN
	 3eE40h0j90mxw==
Date: Wed, 14 Jan 2026 18:58:51 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Chris Mason <clm@meta.com>, Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, jasonmiu@google.com,
	graf@amazon.com, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v8 14/18] mm: memfd_luo: allow preserving memfd
Message-ID: <aWfLS48tG7XInpNN@kernel.org>
References: <20251125165850.3389713-15-pasha.tatashin@soleen.com>
 <20260113140927.1074142-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113140927.1074142-1-clm@meta.com>

On Tue, Jan 13, 2026 at 06:09:23AM -0800, Chris Mason wrote:
> On Tue, 25 Nov 2025 11:58:44 -0500 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> 
> Hi everyone,
> 
> I'm running the v6.19 mm commits through patch review automation, and this
> commit was flagged.  I don't know this code well, but it looks like it
> might be a real bug.
> 
> [AI review output below]
> 
> > diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> > new file mode 100644
> > index 0000000000000..4f6ba63b43105
> > --- /dev/null
> > +++ b/mm/memfd_luo.c
> 
> [ ... ]
> 
> > +static int memfd_luo_retrieve_folios(struct file *file,
> > +				     struct memfd_luo_folio_ser *folios_ser,
> > +				     u64 nr_folios)
> > +{
> > +	struct inode *inode = file_inode(file);
> > +	struct address_space *mapping = inode->i_mapping;
> > +	struct folio *folio;
> > +	int err = -EIO;
> > +	long i;
> > +
> > +	for (i = 0; i < nr_folios; i++) {
> 
> [ ... ]
> 
> > +		err = shmem_add_to_page_cache(folio, mapping, index, NULL,
> > +					      mapping_gfp_mask(mapping));
> > +		if (err) {
> > +			pr_err("shmem: failed to add to page cache folio index %ld: %d\n",
> > +			       i, err);
> > +			goto unlock_folio;
> > +		}
> > +
> > +		if (flags & MEMFD_LUO_FOLIO_UPTODATE)
> > +			folio_mark_uptodate(folio);
> > +		if (flags & MEMFD_LUO_FOLIO_DIRTY)
> > +			folio_mark_dirty(folio);
> > +
> > +		err = shmem_inode_acct_blocks(inode, 1);
> > +		if (err) {
> > +			pr_err("shmem: failed to account folio index %ld: %d\n",
> > +			       i, err);
> > +			goto unlock_folio;
> > +		}
> 
> When shmem_inode_acct_blocks() fails here, the folio has already been
> added to the page cache by shmem_add_to_page_cache(). Should the folio be
> removed from the page cache before going to unlock_folio?
> 
> Looking at shmem_alloc_and_add_folio() in mm/shmem.c, when
> shmem_inode_acct_blocks() fails after the folio has been added, it calls
> filemap_remove_folio() to remove it:
> 
>     error = shmem_inode_acct_blocks(inode, pages);
>     if (error) {
>         ...
>         if (error) {
>             filemap_remove_folio(folio);
>             goto unlock;
>         }
>     }
> 
> Without this, the folio remains in the page cache (counted in
> mapping->nrpages) but info->alloced is not incremented (since
> shmem_recalc_inode is not called). This could cause shmem accounting
> inconsistency.
 
My understanding that if anything fails in memfd_luo_retrieve_folios() the
file is destroyed anyway and the accounting wouldn't matter.

But to be on the safe side we should fix the error handling here.
@Pratyush, what do you say?

-- 
Sincerely yours,
Mike.

