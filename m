Return-Path: <linux-fsdevel+bounces-32350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73BA9A3F9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 15:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD14284454
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122A91D935F;
	Fri, 18 Oct 2024 13:29:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9D01CABA;
	Fri, 18 Oct 2024 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258174; cv=none; b=V1bk2tDIph3vGjtYnCCwlBxWYPvp7XNWmrj8rQDfaSwUqEZM+kIfeY0ULD05trhEBD8QvaG1m+no7XIobWbgTd65Dz4I54vxo9dt3KzrD/gwkTuviD+iTblfT2H93733sPZtolqG/TIhd5I1/aPe1Gai99MjPESvh38J5ngqvEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258174; c=relaxed/simple;
	bh=RZ6dj9vRCUkiAFZKjQ6w5AG7jaUlhyYdQDcOPRxtjwM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gj7kLeqhL/jy1OJBqc8oR2ORwl3X+tP5ehRieoZNoR8RDoswCaH3UOKkuoWF8TEPL/Qz7MiXzz6o+6G/nBhNqMEwEHMUb55LxeYc73obir40DVPEOz4QiuTL+usjgBMWdjx1wjQKTklIHkmMcqCfTy6zIz3snAZF8GZvGCkL3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XVPyL33wPz9v7JP;
	Fri, 18 Oct 2024 21:03:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 3249A1402A5;
	Fri, 18 Oct 2024 21:29:22 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDHWDClYhJnwGEYAw--.52096S2;
	Fri, 18 Oct 2024 14:29:21 +0100 (CET)
Message-ID: <e6d5e3b0b35db5d569b418b73395574f8b63e445.camel@huaweicloud.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>, Lorenzo Stoakes
	 <lorenzo.stoakes@oracle.com>
Cc: Paul Moore <paul@paul-moore.com>, ebpqwerty472123@gmail.com, 
 kirill.shutemov@linux.intel.com, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, jmorris@namei.org,
 serge@hallyn.com,  linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
 linux-mm@kvack.org, akpm@linux-foundation.org,  vbabka@suse.cz,
 linux-fsdevel@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>, Jann
 Horn <jannh@google.com>
Date: Fri, 18 Oct 2024 15:29:05 +0200
In-Reply-To: <gl4pf7gezpjtvnbp4lzyb65wqaiw3xzjjrs3476j5odxsfzvsj@oouue73v3cgr>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
	 <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
	 <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
	 <7358f12d852964d9209492e337d33b8880234b74.camel@huaweicloud.com>
	 <593282dbc9f48673c8f3b8e0f28e100f34141115.camel@huaweicloud.com>
	 <15bb94a306d3432de55c0a12f29e7ed2b5fa3ba1.camel@huaweicloud.com>
	 <c1e47882720fe45aa9d04d663f5a6fd39a046bcb.camel@huaweicloud.com>
	 <b498e3b004bedc460991e167c154cc88d568f587.camel@huaweicloud.com>
	 <ggvucjixgiuelt6vjz6oawgyobmzrhifaozqqvupwfso65ia7c@bauvfqtvq6lv>
	 <e89f6b61-a57f-4848-87f1-8e2282bc5aea@lucifer.local>
	 <gl4pf7gezpjtvnbp4lzyb65wqaiw3xzjjrs3476j5odxsfzvsj@oouue73v3cgr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHWDClYhJnwGEYAw--.52096S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF13JFWrJw1fuF43Jw4Utwb_yoW5Crykpr
	yrJa4qgFWYqFyxXrn2q3Z0gFn0yayUKFy7urWrXry8AwnrtFnxCr4rGFy5urs8Ar1kAFyF
	vF4UCFZakFW7JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABGcRxH8JsgAAsw

On Fri, 2024-10-18 at 14:05 +0300, Kirill A. Shutemov wrote:
> On Fri, Oct 18, 2024 at 12:00:22PM +0100, Lorenzo Stoakes wrote:
> > + Liam, Jann
> >=20
> > On Fri, Oct 18, 2024 at 01:49:06PM +0300, Kirill A. Shutemov wrote:
> > > On Fri, Oct 18, 2024 at 11:24:06AM +0200, Roberto Sassu wrote:
> > > > Probably it is hard, @Kirill would there be any way to safely move
> > > > security_mmap_file() out of the mmap_lock lock?
> > >=20
> > > What about something like this (untested):
> > >=20
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index dd4b35a25aeb..03473e77d356 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1646,6 +1646,26 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned lon=
g, start, unsigned long, size,
> > >  	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
> > >  		return ret;
> > >=20
> > > +	if (mmap_read_lock_killable(mm))
> > > +		return -EINTR;
> > > +
> > > +	vma =3D vma_lookup(mm, start);
> > > +
> > > +	if (!vma || !(vma->vm_flags & VM_SHARED)) {
> > > +		mmap_read_unlock(mm);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	file =3D get_file(vma->vm_file);
> > > +
> > > +	mmap_read_unlock(mm);
> > > +
> > > +	ret =3D security_mmap_file(vma->vm_file, prot, flags);
> >=20
> > Accessing VMA fields without any kind of lock is... very much not advis=
ed.
> >=20
> > I'm guessing you meant to say:
> >=20
> > 	ret =3D security_mmap_file(file, prot, flags);
> >=20
> > Here? :)
>=20
> Sure. My bad.
>=20
> Patch with all fixups:
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dd4b35a25aeb..541787d526b6 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1646,14 +1646,41 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, =
start, unsigned long, size,
>  	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
>  		return ret;
> =20
> -	if (mmap_write_lock_killable(mm))
> +	if (mmap_read_lock_killable(mm))
>  		return -EINTR;
> =20
>  	vma =3D vma_lookup(mm, start);
> =20
> +	if (!vma || !(vma->vm_flags & VM_SHARED)) {
> +		mmap_read_unlock(mm);
> +		return -EINVAL;
> +	}
> +
> +	file =3D get_file(vma->vm_file);
> +
> +	mmap_read_unlock(mm);
> +
> +	ret =3D security_mmap_file(file, prot, flags);

Uhm, I have to calculate prot and flags before. I can check if what I
used here changed in the next lock, and refuse.

Roberto

> +	if (ret) {
> +		fput(file);
> +		return ret;
> +	}
> +
> +	ret =3D -EINVAL;
> +
> +	if (mmap_write_lock_killable(mm)) {
> +		fput(file);
> +		return -EINTR;
> +	}
> +
> +	vma =3D vma_lookup(mm, start);
> +
>  	if (!vma || !(vma->vm_flags & VM_SHARED))
>  		goto out;
> =20
> +	if (vma->vm_file !=3D file)
> +		goto out;
> +
>  	if (start + size > vma->vm_end) {
>  		VMA_ITERATOR(vmi, mm, vma->vm_end);
>  		struct vm_area_struct *next, *prev =3D vma;
> @@ -1688,16 +1715,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, =
start, unsigned long, size,
>  	if (vma->vm_flags & VM_LOCKED)
>  		flags |=3D MAP_LOCKED;
> =20
> -	file =3D get_file(vma->vm_file);
> -	ret =3D security_mmap_file(vma->vm_file, prot, flags);
> -	if (ret)
> -		goto out_fput;
>  	ret =3D do_mmap(vma->vm_file, start, size,
>  			prot, flags, 0, pgoff, &populate, NULL);
> -out_fput:
> -	fput(file);
>  out:
>  	mmap_write_unlock(mm);
> +	fput(file);
>  	if (populate)
>  		mm_populate(ret, populate);
>  	if (!IS_ERR_VALUE(ret))


