Return-Path: <linux-fsdevel+bounces-55191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40407B08082
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 00:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1EA1C41A02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 22:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5952ED872;
	Wed, 16 Jul 2025 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FQ20TfVJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB842857F1;
	Wed, 16 Jul 2025 22:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704832; cv=none; b=eoZCDXBu4t4E4tyXd3J8S+wr42lcfHxXDAod36ZosQihC9WlSXwO1A6CTES4jeDaFznbPbCZh76PpS0gQhz9f3dF1TmZuiITOw7Srogdrq3w0YY3EEtCwXqfUcXuxArFfsh+JKlQu7/wMzrQj2xOrncICfXOSVjoC9jk7+h6PMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704832; c=relaxed/simple;
	bh=Tu5JRrTaLxjAsLV5SCPpe1Ex1V91jjvN1Tb/KDM9lNw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YkW93tqJ0B0gQYLnOVcHyuEL9CKfvS49c271PXnAOfLXKzEaiENxPPzARqV9gi6VJAkeqpV6Hy93KC50Nus29+TM8W6Ld0PUzW/AUbo9i5wOrxJhybX2QdQ3IBk4gVURibdlXd/o0bCI7HsH3Q+S2pPruHbtezI5giJfzsQ3S4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FQ20TfVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087D3C4CEE7;
	Wed, 16 Jul 2025 22:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752704832;
	bh=Tu5JRrTaLxjAsLV5SCPpe1Ex1V91jjvN1Tb/KDM9lNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FQ20TfVJv7WHG4iy+EX6C5O/ThLRdHt1x2CyduQoJ7kBpnfwVRY4iaXRGrPLDkcGE
	 DBema/GEK6i5vtv2C20l0NWl0W9bQMb+oyV+Fhec+AWeSTRdsHVXB/JrmwlAloVh2r
	 aiQsmw0UH40iuqW+2aualml7hoCW1ijLrIVxgQ0o=
Date: Wed, 16 Jul 2025 15:27:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, Oscar Salvador
 <osalvador@suse.de>, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v1 0/9] mm: vm_normal_page*() improvements
Message-Id: <20250716152710.59e09fe5056010322de2a1a3@linux-foundation.org>
In-Reply-To: <17a539fa-977c-4f3f-bedf-badd1fc1287a@redhat.com>
References: <20250715132350.2448901-1-david@redhat.com>
	<20250715163126.7bcaca25364dd68835bd9c8b@linux-foundation.org>
	<17a539fa-977c-4f3f-bedf-badd1fc1287a@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 10:47:29 +0200 David Hildenbrand <david@redhat.com> wrote:

> > 
> > However the series rejects due to the is_huge_zero_pmd ->
> > is_huge_zero_pfn changes in Luiz's "mm: introduce snapshot_page() v3"
> > series, so could we please have a redo against present mm-new?
> 
> I'm confused: mm-new *still* contains the patch from Luiz series that
> was originally part of the RFC here.
> 
> commit 791cb64cd7f8c2314c65d1dd5cb9e05e51c4cd70
> Author: David Hildenbrand <david@redhat.com>
> Date:   Mon Jul 14 09:16:51 2025 -0400
> 
>      mm/memory: introduce is_huge_zero_pfn() and use it in vm_normal_page_pmd()
> 
> If you want to put this series here before Luiz', you'll have to move that
> single patch as well.
> 
> But probably this series should be done on top of Luiz work, because Luiz
> fixes something.

I'm confused at your confused.  mm-new presently contains Luiz's latest
v3 series "mm: introduce snapshot_page()" which includes a copy of your
"mm/memory: introduce is_huge_zero_pfn() and use it in
vm_normal_page_pmd()".

> [that patch was part of the RFC series, but Luiz picked it up for his work, so I dropped it
> from this series and based it on top of current mm-new]

