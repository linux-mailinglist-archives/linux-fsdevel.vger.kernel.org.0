Return-Path: <linux-fsdevel+bounces-73802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FCFD20F1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 20:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DB7A30245A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1691433D6F2;
	Wed, 14 Jan 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3zkJyOI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BEB33BBAB;
	Wed, 14 Jan 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417209; cv=none; b=Ea7NA9EO09ru40Lmup+g4zfg4fnp522wFcDSyFsMzMk2fHHIkosdhg/gia5isTwAE6zqokkSp420l0lJTyv5/fM9oV7ufqkgn0upuTkGzHaFiqsqukkq7esIJnEZNSad+yNaicV4O4Boog6KA+X1pOho1yIB4sKoreTQn4dAEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417209; c=relaxed/simple;
	bh=Ea4+GFq3dvRVKBWLXL2dGpjC6QUsN/5CKbbkdtcSkAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JiU64dDY8/nfCPSd7N6j+A1zOOZlB1+ErXaCzqAbxo99EmNRTxRftnnf/VmwRbXfL1GN0iFu0uNaJGY2ONmmMktBV0KG1EyJIVMbsvgdHewGxbz4A0w9OwVR5NjfTqYApdFdOLtMAUzl85GwtTDtc/laKSahOlyy0aHnc7WYZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3zkJyOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8F8C4CEF7;
	Wed, 14 Jan 2026 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768417208;
	bh=Ea4+GFq3dvRVKBWLXL2dGpjC6QUsN/5CKbbkdtcSkAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=A3zkJyOIMhlgNA/h3KeOk3OevIOv/TNRnD9jwxfEpcT4iwUdK7IuStF/J4dAztaS2
	 QxiG/782koAMadAkIagGwjkxXsaprOWjFRbvT9uiHPQCmYN+ISppQv31zLJ7cx6/tI
	 vlDr+NkuUQznVfygHj1igc6to9U/6XHduqX+fNf+tkeAdyjo2Skd3vu3iRaRWSJwBI
	 KsKMHuc/b9okeyVJ8ji42js4SGI8WGBHnUZNX80EUCFhdqSNsRwpKpFZtZWE2xesQ3
	 RYisN7Fo16Hh+Fb4JXNRjk+iDzt9AJ6QSl7Nha3hD9wS1BPYDLxxTkWo1MAb4WLciX
	 1Buo4VHDjDTFA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Chris Mason <clm@meta.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  jasonmiu@google.com,
  graf@amazon.com,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  linux@weissschuh.net,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-mm@kvack.org,
  gregkh@linuxfoundation.org,  tglx@linutronix.de,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  x86@kernel.org,
  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org
Subject: Re: [PATCH v8 14/18] mm: memfd_luo: allow preserving memfd
In-Reply-To: <aWfLS48tG7XInpNN@kernel.org> (Mike Rapoport's message of "Wed,
	14 Jan 2026 18:58:51 +0200")
References: <20251125165850.3389713-15-pasha.tatashin@soleen.com>
	<20260113140927.1074142-1-clm@meta.com> <aWfLS48tG7XInpNN@kernel.org>
Date: Wed, 14 Jan 2026 18:59:56 +0000
Message-ID: <2vxzikd4hvf7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 14 2026, Mike Rapoport wrote:

> On Tue, Jan 13, 2026 at 06:09:23AM -0800, Chris Mason wrote:
>> On Tue, 25 Nov 2025 11:58:44 -0500 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>> 
>> Hi everyone,
>> 
>> I'm running the v6.19 mm commits through patch review automation, and this
>> commit was flagged.  I don't know this code well, but it looks like it
>> might be a real bug.
>> 
>> [AI review output below]
>> 
>> > diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
>> > new file mode 100644
>> > index 0000000000000..4f6ba63b43105
>> > --- /dev/null
>> > +++ b/mm/memfd_luo.c
>> 
>> [ ... ]
>> 
>> > +static int memfd_luo_retrieve_folios(struct file *file,
>> > +				     struct memfd_luo_folio_ser *folios_ser,
>> > +				     u64 nr_folios)
>> > +{
>> > +	struct inode *inode = file_inode(file);
>> > +	struct address_space *mapping = inode->i_mapping;
>> > +	struct folio *folio;
>> > +	int err = -EIO;
>> > +	long i;
>> > +
>> > +	for (i = 0; i < nr_folios; i++) {
>> 
>> [ ... ]
>> 
>> > +		err = shmem_add_to_page_cache(folio, mapping, index, NULL,
>> > +					      mapping_gfp_mask(mapping));
>> > +		if (err) {
>> > +			pr_err("shmem: failed to add to page cache folio index %ld: %d\n",
>> > +			       i, err);
>> > +			goto unlock_folio;
>> > +		}
>> > +
>> > +		if (flags & MEMFD_LUO_FOLIO_UPTODATE)
>> > +			folio_mark_uptodate(folio);
>> > +		if (flags & MEMFD_LUO_FOLIO_DIRTY)
>> > +			folio_mark_dirty(folio);
>> > +
>> > +		err = shmem_inode_acct_blocks(inode, 1);
>> > +		if (err) {
>> > +			pr_err("shmem: failed to account folio index %ld: %d\n",
>> > +			       i, err);
>> > +			goto unlock_folio;
>> > +		}
>> 
>> When shmem_inode_acct_blocks() fails here, the folio has already been
>> added to the page cache by shmem_add_to_page_cache(). Should the folio be
>> removed from the page cache before going to unlock_folio?
>> 
>> Looking at shmem_alloc_and_add_folio() in mm/shmem.c, when
>> shmem_inode_acct_blocks() fails after the folio has been added, it calls
>> filemap_remove_folio() to remove it:
>> 
>>     error = shmem_inode_acct_blocks(inode, pages);
>>     if (error) {
>>         ...
>>         if (error) {
>>             filemap_remove_folio(folio);
>>             goto unlock;
>>         }
>>     }
>> 
>> Without this, the folio remains in the page cache (counted in
>> mapping->nrpages) but info->alloced is not incremented (since
>> shmem_recalc_inode is not called). This could cause shmem accounting
>> inconsistency.
>  
> My understanding that if anything fails in memfd_luo_retrieve_folios() the
> file is destroyed anyway and the accounting wouldn't matter.
>
> But to be on the safe side we should fix the error handling here.
> @Pratyush, what do you say?

Yeah, I don't think the inode's alloced accounting is a real issue here
since the file will be destroyed immediately after. This is why I didn't
want to add the extra complexity of the error handling.

But now that I think of it, perhaps the lingering unaccounted folio
might cause an underflow in vm_committed_as. shmem_inode_acct_blocks()
cleans up the vm_acct_memory() call in case of failure. But perhaps the
iput() triggers an extra shmem_unacct_memory() because of the lingering
folio.

I am not 100% sure that can actually happen since the code is a bit
complex. Let me check and get back to you.

-- 
Regards,
Pratyush Yadav

