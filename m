Return-Path: <linux-fsdevel+bounces-62165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EE0B86A0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 21:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013746272F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 19:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB042D47F9;
	Thu, 18 Sep 2025 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="e1PjzYEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A551B424F;
	Thu, 18 Sep 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222706; cv=none; b=DEKY+KE0+eSPGFnKeP7Mub7iYl2sIFK0HYBso3Ay51hFAKUFbWDpQ6AMkvUl4kT1QZrZ1yQj83fuI3rAQFlXAkU26nUAEHs9cYrlBtqkLJehnHExeqBjSphxo4BIg424jCDjHczOCYynLGEYvugLQbsm25VkxW3XSgUD2gEmLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222706; c=relaxed/simple;
	bh=lOR27FB60WfaXG9XY9l0rBk9RW2/T7eyBicEZvQ9F+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTifaP30JZzwIi7oLb1PEcFZAA+m/IjDZCw/nZH1LB33Oj1JdVRFsfYHYEWpwlCENgfFalbOOXLqtSCOwQevWaB6W+MwZw9XWTzcO82biD1ssNJs2MtvqWhCVs6jI2fKlGUxFsesIqPJclE7uI9eC2wQAzDalHQLeCD5M9Awl6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=e1PjzYEw; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58IHFrYs3277934;
	Thu, 18 Sep 2025 12:11:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=n7WMUyT5L/wA654bmEoUeQzuO+YeNxS6ichaQfAm4K0=; b=e1PjzYEwP6rW
	SfUk5eeciJxn+YRaNAOwJfo0mF1M9af1ue6fOutyvFad79DSht413xYSjq60mDZn
	YfAeHI3teHoLHj2Ahw36GPsEKjr9nWC6XNFV5yDHpZFkBziHEg6+zY9tRtbFHZ7L
	euLc+3yKJdYsaDbCHeYUrokmz4OdnyNONXB/EoFpk84RGhgSRcJayfWUqspezpej
	t5GboU+18x4kwUz9VDEY546JJy77c6NrIDp7S3nspwxS3VyRR3cDcJUXjns/AlUx
	vHU6c1NA5Yk/53XX8iJhs34HuxkDG9lTlReCBuQkPbYQPU3FHSiVsk3ft4wTv6TT
	ArN8tU50uw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 498f7yccgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Sep 2025 12:11:41 -0700 (PDT)
Received: from devbig091.ldc1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 18 Sep 2025 19:11:36 +0000
From: Chris Mason <clm@meta.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
        "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>,
        Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
	<agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann
	<arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Dan
 Williams" <dan.j.williams@intel.com>,
        Vishal Verma
	<vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre
	<nico@fluxnic.net>,
        "Muchun Song" <muchun.song@linux.dev>,
        Oscar Salvador
	<osalvador@suse.de>,
        "David Hildenbrand" <david@redhat.com>,
        Konstantin
 Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He
	<bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young
	<dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre
	<reinette.chatre@intel.com>,
        "Dave Martin" <Dave.Martin@arm.com>,
        James Morse
	<james.morse@arm.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        Christian
 Brauner <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
        "Liam R . Howlett"
	<Liam.Howlett@oracle.com>,
        "Vlastimil Babka" <vbabka@suse.cz>, Mike Rapoport
	<rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko
	<mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Andrey Konovalov"
	<andreyknvl@gmail.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato
	<pfalcato@suse.de>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
        <ntfs3@lists.linux.dev>, <kexec@lists.infradead.org>,
        <kasan-dev@googlegroups.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 11/16] mm: update mem char driver to use mmap_prepare
Date: Thu, 18 Sep 2025 12:11:05 -0700
Message-ID: <20250918191119.3622358-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aeee6a4896304d6dc7515e79d74f8bc5ec424415.1757534913.git.lorenzo.stoakes@oracle.com>
References:
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Wr8rMcfv c=1 sm=1 tr=0 ts=68cc596e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=QLIaiyCFZkuJlwHvl48A:9
X-Proofpoint-ORIG-GUID: yzU4eNHLhAUfSh4h33V6r2BXOldJckJZ
X-Proofpoint-GUID: yzU4eNHLhAUfSh4h33V6r2BXOldJckJZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDE3MCBTYWx0ZWRfX+OH6/CZXfYF1
 ZQZSd3MY5d1+huXM92tmUuaixGbvXh9eslNEM1bRcbWXduWBJkY9hM7pAwYK1UmVGB6+KtMLK3+
 5xu0OvXnTYTE5X3/j7r0YUT9jTEQIyg7vs2wzGv7et2oYHzPIQqFSONTUbrUfKZtQGE+5Ql2G/m
 FB+fFTcxSnJqueTYbtn/kFdO7ZXWcwZvUvPEHQAajQYNZXBbU5RIDDKbQMkKIDQGqkR8eZiO5xs
 q0uwGSCKiMwePOEm2hD3yphFf7LSfGFQnTUqyn0uufzwKaznKzrNA1c2BW91Ht07S88ASQbLxJd
 y3Z61QWwzOnbaToH1kdrhAuNayIEpInurTQIzwra/DJzb/lInqX9Bhz50sofEw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01

On Wed, 10 Sep 2025 21:22:06 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Update the mem char driver (backing /dev/mem and /dev/zero) to use
> f_op->mmap_prepare hook rather than the deprecated f_op->mmap.
> 
> The /dev/zero implementation has a very unique and rather concerning
> characteristic in that it converts MAP_PRIVATE mmap() mappings anonymous
> when they are, in fact, not.
> 
> The new f_op->mmap_prepare() can support this, but rather than introducing
> a helper function to perform this hack (and risk introducing other users),
> simply set desc->vm_op to NULL here and add a comment describing what's
> going on.
> 
> We also introduce shmem_zero_setup_desc() to allow for the shared mapping
> case via an f_op->mmap_prepare() hook, and generalise the code between this
> and shmem_zero_setup().
> 
> We also use the desc->action_error_hook to filter the remap error to
> -EAGAIN to keep behaviour consistent.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  drivers/char/mem.c       | 75 ++++++++++++++++++++++------------------
>  include/linux/shmem_fs.h |  3 +-
>  mm/shmem.c               | 40 ++++++++++++++++-----
>  3 files changed, 76 insertions(+), 42 deletions(-)
> 

[ ... ]

> diff --git a/mm/shmem.c b/mm/shmem.c
> index 990e33c6a776..cb6ff00eb4cb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c

[ ... ]

> @@ -5920,6 +5925,25 @@ int shmem_zero_setup(struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +/**
> + * shmem_zero_setup_desc - same as shmem_zero_setup, but determined by VMA
> + * descriptor for convenience.
> + * @desc: Describes VMA
> + * Returns: 0 on success, or error
> + */
> +int shmem_zero_setup_desc(struct vm_area_desc *desc)
> +{
> +	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vm_flags);
> +
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	desc->vm_file = file;
> +	desc->vm_ops = &shmem_anon_vm_ops;
> +
> +	return 0;
> +}
> +

Hi Lorenzo,

shmem_zero_setup() does a if (vma->vm_file) fput(vma->vm_file) dance.

It looks like we need one here too?

-chris

