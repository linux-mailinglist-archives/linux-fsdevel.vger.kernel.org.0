Return-Path: <linux-fsdevel+bounces-62526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881E8B978F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 23:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414384C2A88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 21:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED8230CB33;
	Tue, 23 Sep 2025 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YQt4yJD4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26BF309F12;
	Tue, 23 Sep 2025 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662228; cv=none; b=PVHlDbqMvJZj0ItQGaDgQ+uqwAiaN64FgKa0TKo2KsUWa2H51pg71vABtbhN+1kN6tIMgUVHEXfFvrGsaKyMLj6R7wCeKjaPq6PPL2chUT1rkMLDKYfwnDgSjSnx2JxM3xpFTmcreDIP41Edm73mi0YdfiMxMB2A1ZcqHJeTt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662228; c=relaxed/simple;
	bh=9maMwx7/tfxHiKFTD825WGlX9Scv4cfcxvOcT74ZDTg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Pi0DfaJdRl5ndPhT9JZmFJDPc3iVs+8tFZuMJf37jiy6ALr6yMWpKMuN4fNUflp9U2An4pEBQR4Ya4B6fV5NrhXYbo2O3OujraoYOp4x4/LMAHnDdEvBxr79LruOlqifo+gnrVFcTyU5xX+LkTg8gqJ73cpF+YT4kzPUAms4Hrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YQt4yJD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CB1C4CEF5;
	Tue, 23 Sep 2025 21:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758662227;
	bh=9maMwx7/tfxHiKFTD825WGlX9Scv4cfcxvOcT74ZDTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YQt4yJD4LLyMB/AA7fhRdzHKMMyKrYX7tPYO7bcgLcaYZEMTEEDS+V/u87paR8mvk
	 vaZ6Hf5HJhiz4iN6UcpLvuzXo0K/kulYjPZuGmcFLhgj45aLOuctbBJIR6+SoLAoCq
	 q1aNHSIO3K1aKeAi1QD+S0yrDrsK77/N3Jf/bOOk=
Date: Tue, 23 Sep 2025 14:17:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jonathan Corbet
 <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, Guo Ren
 <guoren@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Baoquan He
 <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, James Morse
 <james.morse@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
 ntfs3@lists.linux.dev, kexec@lists.infradead.org,
 kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
 iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 11/14] mm/hugetlbfs: update hugetlbfs to use
 mmap_prepare
Message-Id: <20250923141704.90fba5bdf8c790e0496e6ac1@linux-foundation.org>
In-Reply-To: <aNKJ6b7kmT_u0A4c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
	<e5532a0aff1991a1b5435dcb358b7d35abc80f3b.1758135681.git.lorenzo.stoakes@oracle.com>
	<aNKJ6b7kmT_u0A4c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 13:52:09 +0200 Sumanth Korikkar <sumanthk@linux.ibm.com> wrote:

> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -96,8 +96,15 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
> >  #define PGOFF_LOFFT_MAX \
> >  	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
> >  
> > -static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
> > +static int hugetlb_file_mmap_prepare_success(const struct vm_area_struct *vma)
> >  {
> > +	/* Unfortunate we have to reassign vma->vm_private_data. */
> > +	return hugetlb_vma_lock_alloc((struct vm_area_struct *)vma);
> > +}
> 
> Hi Lorenzo,
> 
> The following tests causes the kernel to enter a blocked state,
> suggesting an issue related to locking order. I was able to reproduce
> this behavior in certain test runs.

Thanks.  I pulled this series out of mm.git's mm-stable branch, put it
back into mm-unstable.

