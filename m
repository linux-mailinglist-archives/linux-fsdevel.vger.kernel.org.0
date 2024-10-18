Return-Path: <linux-fsdevel+bounces-32370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C009A467B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 21:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EAD6B2212F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 19:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5EF204F68;
	Fri, 18 Oct 2024 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5uvTqpE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045E1185B48;
	Fri, 18 Oct 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278302; cv=none; b=qZbchbqTRHckq7z0Fez8GeqyT65fRy3DCKnH4xgDM54K17t3TcuiPMGIr0zeGCxQIfND6ne0msO4ZbCdwaghBeVBjMSz64hwOWteijB3+pnw3W83lruwCB+bNLlyexwSokzQIjS//bO+h06JeGVOqnCXjru8njD2tWcNWtrVRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278302; c=relaxed/simple;
	bh=FPm25//FWOl+CC1MWzk9hQUI9w5QiPt15s8anu8dklE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=PtZZpCKiUiDW2GhcM3rSnXGO+n3vLYmwIbeNOpdHWDW4UGAsKxjEcvET+Rx0RbnJBsXqNafBIXdi6bzpWzdyM3oaji9cuGWK60bC02mrT0ZOKhLR3JnhA+zgmm77vC2Kzj/KCK7JUTJNM6/Kt9m0Hw82ehDRPoBHsm9LEjUcWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5uvTqpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FA0C4CEC3;
	Fri, 18 Oct 2024 19:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729278301;
	bh=FPm25//FWOl+CC1MWzk9hQUI9w5QiPt15s8anu8dklE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5uvTqpERQM/xf087llem64Geo2ZtGqg+DGlihon2UFTSlgjhC5vcPMah+RtPR5jM
	 V9+ZHf5VFZjTmcJKtPceJvVyS89pTxSHtXENhw0ugAcvlBG6zaDYCdpiePQ9T4NkJw
	 yYakgWahYaH/gaXTAb0ZaK9Vl26Y4TZHqqw28s36BYO6YrF6GxaiOZZWpK4raV87ID
	 0ysPDESKTrAl8uBRXz//pA6XT++5p9W6jOADfciBCpAsxs9lJEyR+z9SP5o3THMssx
	 tyXLYLe23fAQn89EO4XXbpUekwhntYEad85YicmT7GWnJqiLCAR0TKmHOIvH3/pNMO
	 E7PgKiSEfhCCw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Oct 2024 22:04:56 +0300
Message-Id: <D4Z5ZUHK76A8.18SJLAWKCZ5IX@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>,
 <akpm@linux-foundation.org>, <Liam.Howlett@oracle.com>,
 <lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>, <jannh@google.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <ebpqwerty472123@gmail.com>, <paul@paul-moore.com>, <zohar@linux.ibm.com>,
 <dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>,
 <jmorris@namei.org>, <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, <stable@vger.kernel.org>,
 <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2] mm: Split critical region in remap_file_pages() and
 invoke LSMs in between
X-Mailer: aerc 0.18.2
References: <20241018161415.3845146-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20241018161415.3845146-1-roberto.sassu@huaweicloud.com>

On Fri Oct 18, 2024 at 7:14 PM EEST, Roberto Sassu wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> Commit ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in
> remap_file_pages()") fixed a security issue, it added an LSM check when
> trying to remap file pages, so that LSMs have the opportunity to evaluate
> such action like for other memory operations such as mmap() and mprotect(=
).
>
> However, that commit called security_mmap_file() inside the mmap_lock loc=
k,
> while the other calls do it before taking the lock, after commit
> 8b3ec6814c83 ("take security_mmap_file() outside of ->mmap_sem").
>
> This caused lock inversion issue with IMA which was taking the mmap_lock
> and i_mutex lock in the opposite way when the remap_file_pages() system
> call was called.
>
> Solve the issue by splitting the critical region in remap_file_pages() in
> two regions: the first takes a read lock of mmap_lock, retrieves the VMA
> and the file descriptor associated, and calculates the 'prot' and 'flags'
> variables; the second takes a write lock on mmap_lock, checks that the VM=
A
> flags and the VMA file descriptor are the same as the ones obtained in th=
e
> first critical region (otherwise the system call fails), and calls
> do_mmap().
>
> In between, after releasing the read lock and before taking the write loc=
k,
> call security_mmap_file(), and solve the lock inversion issue.
>
> Cc: stable@vger.kernel.org # v6.12-rcx
> Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap=
_file_pages()")
> Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-security-module/66f7b10e.050a0220.4=
6d20.0036.GAE@google.com/
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Tested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Tested-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/mmap.c | 69 +++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 52 insertions(+), 17 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9c0fb43064b5..f731dd69e162 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1640,6 +1640,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
>  	unsigned long populate =3D 0;
>  	unsigned long ret =3D -EINVAL;
>  	struct file *file;
> +	vm_flags_t vm_flags;
> =20
>  	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. See D=
ocumentation/mm/remap_file_pages.rst.\n",
>  		     current->comm, current->pid);
> @@ -1656,12 +1657,60 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, =
start, unsigned long, size,
>  	if (pgoff + (size >> PAGE_SHIFT) < pgoff)
>  		return ret;
> =20
> -	if (mmap_write_lock_killable(mm))
> +	if (mmap_read_lock_killable(mm))
>  		return -EINTR;
> =20
> +	/*
> +	 * Look up VMA under read lock first so we can perform the security
> +	 * without holding locks (which can be problematic). We reacquire a
> +	 * write lock later and check nothing changed underneath us.
> +	 */
>  	vma =3D vma_lookup(mm, start);
> =20
> -	if (!vma || !(vma->vm_flags & VM_SHARED))
> +	if (!vma || !(vma->vm_flags & VM_SHARED)) {
> +		mmap_read_unlock(mm);
> +		return -EINVAL;
> +	}
> +
> +	prot |=3D vma->vm_flags & VM_READ ? PROT_READ : 0;
> +	prot |=3D vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
> +	prot |=3D vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;

Not an actual review comment but we don't have a conversion macro and/or
inline for this, do we (and opposite direction)?

> +
> +	flags &=3D MAP_NONBLOCK;
> +	flags |=3D MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> +	if (vma->vm_flags & VM_LOCKED)
> +		flags |=3D MAP_LOCKED;
> +
> +	/* Save vm_flags used to calculate prot and flags, and recheck later. *=
/
> +	vm_flags =3D vma->vm_flags;
> +	file =3D get_file(vma->vm_file);
> +
> +	mmap_read_unlock(mm);
> +
> +	/* Call outside mmap_lock to be consistent with other callers. */
> +	ret =3D security_mmap_file(file, prot, flags);
> +	if (ret) {
> +		fput(file);
> +		return ret;
> +	}
> +
> +	ret =3D -EINVAL;
> +
> +	/* OK security check passed, take write lock + let it rip. */
> +	if (mmap_write_lock_killable(mm)) {
> +		fput(file);
> +		return -EINTR;
> +	}
> +
> +	vma =3D vma_lookup(mm, start);
> +
> +	if (!vma)
> +		goto out;
> +
> +	/* Make sure things didn't change under us. */
> +	if (vma->vm_flags !=3D vm_flags)
> +		goto out;
> +	if (vma->vm_file !=3D file)
>  		goto out;
> =20
>  	if (start + size > vma->vm_end) {
> @@ -1689,25 +1738,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, =
start, unsigned long, size,
>  			goto out;
>  	}
> =20
> -	prot |=3D vma->vm_flags & VM_READ ? PROT_READ : 0;
> -	prot |=3D vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
> -	prot |=3D vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
> -
> -	flags &=3D MAP_NONBLOCK;
> -	flags |=3D MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> -	if (vma->vm_flags & VM_LOCKED)
> -		flags |=3D MAP_LOCKED;
> -
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

BR, Jarkko

