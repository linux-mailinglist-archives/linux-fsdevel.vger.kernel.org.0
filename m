Return-Path: <linux-fsdevel+bounces-32358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915D19A42E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 17:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC932820A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAACA20264A;
	Fri, 18 Oct 2024 15:50:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78943168488;
	Fri, 18 Oct 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266649; cv=none; b=SRNj4sVjm2TWyOZdhQPOAvYCn/PSTusR8bhKf00EH6XJH/HLbipK65br1DfWg9xf9ZyT4s/EUb2t/bapM7iShg4Cb4vi14xAELBpmabtP2F9IIhEGUcyPPdux70P17V8OrXkie2yCAtyvFo3qiHKtpAb+82U0DdIFssQdKm9TJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266649; c=relaxed/simple;
	bh=q6a3s5rOmOXUmMUoQAySD+G51ycl3tgw3tbHO9jKGI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PYz69pbYQWRMdigGJUHwuvPi5SUse96P1jBvQ1k8KoUp1Vsr2WJnTya4l8iUR/a9EKGRkFoSTR1lVKtkJkvZAFV8t/PQ1trkydazXw/bgKV0/Z5+rO09hxzg7ini7MNUirpsrV46aHRGQU6kRTYhNgTM0tzUi9H1HJGpFStF484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XVTDN66Lqz9v7JC;
	Fri, 18 Oct 2024 23:30:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 168A2140B08;
	Fri, 18 Oct 2024 23:50:35 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCnCMm9gxJn0hohAw--.60739S2;
	Fri, 18 Oct 2024 16:50:34 +0100 (CET)
Message-ID: <e7c6f3538ad24620014d914785afc2a49294dabf.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] mm: Split locks in remap_file_pages()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ebpqwerty472123@gmail.com, paul@paul-moore.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Kirill A. Shutemov"
	 <kirill.shutemov@linux.intel.com>, stable@vger.kernel.org, 
	syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com, Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Fri, 18 Oct 2024 17:50:19 +0200
In-Reply-To: <784c68fa023e99c53cd07265f0524e386815b443.camel@huaweicloud.com>
References: <20241018144710.3800385-1-roberto.sassu@huaweicloud.com>
	 <fa8cad07-c6d5-42aa-b58b-27ddbf86c1c5@lucifer.local>
	 <784c68fa023e99c53cd07265f0524e386815b443.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCnCMm9gxJn0hohAw--.60739S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw1rXFyxCw43tr48ZFyDAwb_yoWxGF48pF
	95J3WqkF4UXFyxCrnFq3WqgFyFyry8KryUu3y3JFy8Ar9FvF1fKrWfGFy5uF4DArs7AFZ5
	ZF4jyrZxGFZ8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j7l19UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABGcRw-kLwQABsC

On Fri, 2024-10-18 at 17:45 +0200, Roberto Sassu wrote:
> On Fri, 2024-10-18 at 16:42 +0100, Lorenzo Stoakes wrote:
> > On Fri, Oct 18, 2024 at 04:47:10PM +0200, Roberto Sassu wrote:
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > >=20
> > > Commit ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in
> > > remap_file_pages()") fixed a security issue, it added an LSM check wh=
en
> > > trying to remap file pages, so that LSMs have the opportunity to eval=
uate
> > > such action like for other memory operations such as mmap() and mprot=
ect().
> > >=20
> > > However, that commit called security_mmap_file() inside the mmap_lock=
 lock,
> > > while the other calls do it before taking the lock, after commit
> > > 8b3ec6814c83 ("take security_mmap_file() outside of ->mmap_sem").
> > >=20
> > > This caused lock inversion issue with IMA which was taking the mmap_l=
ock
> > > and i_mutex lock in the opposite way when the remap_file_pages() syst=
em
> > > call was called.
> > >=20
> > > Solve the issue by splitting the critical region in remap_file_pages(=
) in
> > > two regions: the first takes a read lock of mmap_lock and retrieves t=
he VMA
> > > and the file associated, and calculate the 'prot' and 'flags' variabl=
e; the
> > > second takes a write lock on mmap_lock, checks that the VMA flags and=
 the
> > > VMA file descriptor are the same as the ones obtained in the first cr=
itical
> > > region (otherwise the system call fails), and calls do_mmap().
> > >=20
> > > In between, after releasing the read lock and taking the write lock, =
call
> > > security_mmap_file(), and solve the lock inversion issue.
> >=20
> > Great description!
> >=20
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in r=
emap_file_pages()")
> > > Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/linux-security-module/66f7b10e.050a02=
20.46d20.0036.GAE@google.com/
> > > Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com> (Calculate prot=
 and flags earlier)
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >=20
> > Other than some nits below:
> >=20
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >=20
> > I think you're definitely good to un-RFC here.
>=20
> Perfect, will do. Thank you!

I'm just going to change a bit the commit title:

mm: Split critical region in remap_file_pages() and invoke LSMs in
between

Roberto

> Roberto
>=20
> > > ---
> > >  mm/mmap.c | 62 ++++++++++++++++++++++++++++++++++++++++-------------=
--
> > >  1 file changed, 45 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 9c0fb43064b5..762944427e03 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1640,6 +1640,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long=
, start, unsigned long, size,
> > >  	unsigned long populate =3D 0;
> > >  	unsigned long ret =3D -EINVAL;
> > >  	struct file *file;
> > > +	vm_flags_t vm_flags;
> > >=20
> > >  	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. S=
ee Documentation/mm/remap_file_pages.rst.\n",
> > >  		     current->comm, current->pid);
> > > @@ -1656,12 +1657,53 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned lo=
ng, start, unsigned long, size,
> > >  	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
> > >  		return ret;
> > >=20
> > > -	if (mmap_write_lock_killable(mm))
> > > +	if (mmap_read_lock_killable(mm))
> > > +		return -EINTR;
> >=20
> > I'm kinda verbose generally, but I'd love a comment like:
> >=20
> > 	/*
> > 	 * Look up VMA under read lock first so we can perform the security
> > 	 * without holding locks (which can be problematic). We reacquire a
> > 	 * write lock later and check nothing changed underneath us.
> > 	 */
> >=20
> > > +
> > > +	vma =3D vma_lookup(mm, start);
> > > +
> > > +	if (!vma || !(vma->vm_flags & VM_SHARED)) {
> > > +		mmap_read_unlock(mm);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	prot |=3D vma->vm_flags & VM_READ ? PROT_READ : 0;
> > > +	prot |=3D vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
> > > +	prot |=3D vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
> > > +
> > > +	flags &=3D MAP_NONBLOCK;
> > > +	flags |=3D MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> > > +	if (vma->vm_flags & VM_LOCKED)
> > > +		flags |=3D MAP_LOCKED;
> > > +
> > > +	/* Save vm_flags used to calculate prot and flags, and recheck late=
r. */
> > > +	vm_flags =3D vma->vm_flags;
> > > +	file =3D get_file(vma->vm_file);
> > > +
> > > +	mmap_read_unlock(mm);
> > > +
> >=20
> > Maybe worth adding a comment to explain why you're doing this without t=
he
> > lock so somebody looking at this later can understand the dance?
> >=20
> > > +	ret =3D security_mmap_file(file, prot, flags);
> > > +	if (ret) {
> > > +		fput(file);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D -EINVAL;
> > > +
> >=20
> > Again, being verbose, I'd put something here like:
> >=20
> > 	/* OK security check passed, take write lock + let it rip */
> >=20
> > > +	if (mmap_write_lock_killable(mm)) {
> > > +		fput(file);
> > >  		return -EINTR;
> > > +	}
> > >=20
> > >  	vma =3D vma_lookup(mm, start);
> > >=20
> > > -	if (!vma || !(vma->vm_flags & VM_SHARED))
> > > +	if (!vma)
> > > +		goto out;
> > > +
> >=20
> > I'd also add something like:
> >=20
> > 	/* Make sure things didn't change under us. */
> >=20
> > > +	if (vma->vm_flags !=3D vm_flags)
> > > +		goto out;
> > > +
> >=20
> > And drop this newline to group them together (super nitty I know, sorry=
!)
> >=20
> > > +	if (vma->vm_file !=3D file)
> > >  		goto out;
> > >=20
> > >  	if (start + size > vma->vm_end) {
> > > @@ -1689,25 +1731,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned lo=
ng, start, unsigned long, size,
> > >  			goto out;
> > >  	}
> > >=20
> > > -	prot |=3D vma->vm_flags & VM_READ ? PROT_READ : 0;
> > > -	prot |=3D vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
> > > -	prot |=3D vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
> > > -
> > > -	flags &=3D MAP_NONBLOCK;
> > > -	flags |=3D MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> > > -	if (vma->vm_flags & VM_LOCKED)
> > > -		flags |=3D MAP_LOCKED;
> > > -
> > > -	file =3D get_file(vma->vm_file);
> > > -	ret =3D security_mmap_file(vma->vm_file, prot, flags);
> > > -	if (ret)
> > > -		goto out_fput;
> > >  	ret =3D do_mmap(vma->vm_file, start, size,
> > >  			prot, flags, 0, pgoff, &populate, NULL);
> > > -out_fput:
> > > -	fput(file);
> > >  out:
> > >  	mmap_write_unlock(mm);
> > > +	fput(file);
> > >  	if (populate)
> > >  		mm_populate(ret, populate);
> > >  	if (!IS_ERR_VALUE(ret))
> > > --
> > > 2.34.1
> > >=20
> >=20
> > These are just nits, this looks good to me!
>=20


