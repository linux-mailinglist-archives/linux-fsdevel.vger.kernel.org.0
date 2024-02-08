Return-Path: <linux-fsdevel+bounces-10832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BE084E9C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 21:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2B91C240E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 20:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E04BA8D;
	Thu,  8 Feb 2024 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a3cUsjCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E620487B8;
	Thu,  8 Feb 2024 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424836; cv=none; b=LDzqzqZ6dLX0aRDLKk8wgTX0q7QbGeyiLdvQntYzryw/Zp7Q3yrONZ1hRkckJQJwS9uFJSS0aN3UrZeOJ5qwoFSWJryzuDViiViRUi/bjRmNUMKfImb4J3dL+59bP+MGfx0+38nrFLJ9hdGn9eTD9FC6iiJIO/86mfiildAdkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424836; c=relaxed/simple;
	bh=hY5pCcHr8ug1jwsyK7SWJs6C1KS3DdykXBC+j+28xYM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NyEdArd79FY+0ah67o3/+bqCUVxrFshl4BRNwDXL0VweorNhp7efQ6/KjqJLSK/qXokQD4FWaaA4qA5GrgKhVeW2lkZbbGv55mKkdHmFEXmQy36QASq06zcI5zHW5kJXodGCQvVn2yWDTU8DW4MNl0LNuS/Rqybi3bqarW07BGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a3cUsjCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD111C433C7;
	Thu,  8 Feb 2024 20:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707424836;
	bh=hY5pCcHr8ug1jwsyK7SWJs6C1KS3DdykXBC+j+28xYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a3cUsjCST8pixTIk2dgsBhj4sptXIGq5bEZE2KLUB8PmF+yW878fOAclqeiqzLTZs
	 iHhH4SBJJhnicK7O6Fb7nLI/WoVxyOwk7KL4wmLTYvgcplfrILemWxGI18z9OFHOKf
	 sKBXq++eGsUU4WQoVVv3AYXmgAQGTm4WfzPEt1cU=
Date: Thu, 8 Feb 2024 12:40:35 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: Add display flag for VM_MAYOVERLAY
Message-Id: <20240208124035.1c96c256d6e8c65f70b18675@linux-foundation.org>
In-Reply-To: <fb157154-5661-4925-b2c5-7952188b28f5@redhat.com>
References: <20240208084805.1252337-1-anshuman.khandual@arm.com>
	<fb157154-5661-4925-b2c5-7952188b28f5@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 17:48:26 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 08.02.24 09:48, Anshuman Khandual wrote:
> > VM_UFFD_MISSING flag is mutually exclussive with VM_MAYOVERLAY flag as they
> > both use the same bit position i.e 0x00000200 in the vm_flags. Let's update
> > show_smap_vma_flags() to display the correct flags depending on CONFIG_MMU.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > This applies on v6.8-rc3
> > 
> >   fs/proc/task_mmu.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 3f78ebbb795f..1c4eb25cfc17 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -681,7 +681,11 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> >   		[ilog2(VM_HUGEPAGE)]	= "hg",
> >   		[ilog2(VM_NOHUGEPAGE)]	= "nh",
> >   		[ilog2(VM_MERGEABLE)]	= "mg",
> > +#ifdef CONFIG_MMU
> >   		[ilog2(VM_UFFD_MISSING)]= "um",
> > +#else
> > +		[ilog2(VM_MAYOVERLAY)]	= "ov",
> > +#endif /* CONFIG_MMU */
> >   		[ilog2(VM_UFFD_WP)]	= "uw",
> >   #ifdef CONFIG_ARM64_MTE
> >   		[ilog2(VM_MTE)]		= "mt",
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

I'm thinking

Fixes: b6b7a8faf05c ("mm/nommu: don't use VM_MAYSHARE for MAP_PRIVATE mappings")
Cc: <stable@vger.kernel.org>

