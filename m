Return-Path: <linux-fsdevel+bounces-29153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A9D9767BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 13:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8071F28B4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16C1BE250;
	Thu, 12 Sep 2024 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlvOBuDs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC621BE22A;
	Thu, 12 Sep 2024 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139838; cv=none; b=Yp2CRKRUKMzsm7tAyyJ+A51DoxKyYnknfSdcmVAJ+Yh+/wyqeD0fYDHvdLfFFM9yfORmZCUbiI7EhXE/i9ocfVr2w9+WFiEQWjh0uIOcFjQpn3RbzFvs69zpS+ikF+PJ0skGBoHNOB/tl0igNwRN4xYU62Spa483Lh9GdTF50Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139838; c=relaxed/simple;
	bh=ASKEujshUwUAQKq7+qtYTggR4rpjzptS8JkTy/cZSEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPA2wPk0mtEHqbHc8AdkLDU2V7akfVwvO6AphdnwS1gv3KkMl40WkMYXVau1k3BXEr53CPzgiPlw9NMrt6xy/6Eor+gecIPW8SzWCprTHMGdh1t4cvfQb1N/UCuVXqcT0swNv2X21ogyzU+t43b35Be760CpqI0CyhYlzzz6Y+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlvOBuDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1F8C4CEC5;
	Thu, 12 Sep 2024 11:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139838;
	bh=ASKEujshUwUAQKq7+qtYTggR4rpjzptS8JkTy/cZSEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlvOBuDsUhk42rm1aN38HY8iYcNeevzjnrJW42FM3qKLjNwUjR3iCgiXX+eR6O5AG
	 VA9JPJIsRDoJ0Sxt7rZrc11tUxJtCcRP67ykNKltP1HEb5Cl8iqkCzHgj2cvA/Wlcx
	 NsqV0R9Vrch1GImU+BPyTy2m3Mh7+xTBzszts4NY8k9cgB1VnH80wegyzZHsvSuQkF
	 WKDmz8DLYcveuCB87d1XfE2nmY54fNoHrSZBaC9A681AJYUjtLlwqmq6ypO46/gz3R
	 xvtTZ9VsIVBCRPILOxAeucTt3FRX1Ja8w9YgpNPGJwiwcUBFFkFT1oZNGO217ff79G
	 T34w5rvn3G4VA==
Date: Thu, 12 Sep 2024 13:17:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Jann Horn <jannh@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Message-ID: <20240912-urenkel-umorientieren-c27ce893af09@brauner>
References: <20240906051205.530219-1-andrii@kernel.org>
 <20240906051205.530219-3-andrii@kernel.org>
 <CAG48ez2G1Pf_RRRT0av=6r_4HcLZu6QMgveepk-ENo=PkaZC1w@mail.gmail.com>
 <CAEf4Bzb+ShZqcj9EKQB8U9tyaJ1LoOpRxd24v76FuPJP-=dkNg@mail.gmail.com>
 <CAJuCfpEhCm3QoZqemO=bX0snO16fxOssMWzLsiewkioiRV_aOA@mail.gmail.com>
 <CAEf4Bzbh_HWuHEZqHZ7MHFLtp+jFf2yiCWyd-RqY-hvm09d5Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbh_HWuHEZqHZ7MHFLtp+jFf2yiCWyd-RqY-hvm09d5Ow@mail.gmail.com>

On Tue, Sep 10, 2024 at 01:58:10PM GMT, Andrii Nakryiko wrote:
> On Tue, Sep 10, 2024 at 9:32 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Mon, Sep 9, 2024 at 2:29 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Sep 9, 2024 at 6:13 AM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > On Fri, Sep 6, 2024 at 7:12 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > > > Given filp_cachep is already marked SLAB_TYPESAFE_BY_RCU, we can safely
> > > > > access vma->vm_file->f_inode field locklessly under just rcu_read_lock()
> > > >
> > > > No, not every file is SLAB_TYPESAFE_BY_RCU - see for example
> > > > ovl_mmap(), which uses backing_file_mmap(), which does
> > > > vma_set_file(vma, file) where "file" comes from ovl_mmap()'s
> > > > "realfile", which comes from file->private_data, which is set in
> > > > ovl_open() to the return value of ovl_open_realfile(), which comes
> > > > from backing_file_open(), which allocates a file with
> > > > alloc_empty_backing_file(), which uses a normal kzalloc() without any
> > > > RCU stuff, with this comment:
> > > >
> > > >  * This is only for kernel internal use, and the allocate file must not be
> > > >  * installed into file tables or such.
> > > >
> > > > And when a backing_file is freed, you can see on the path
> > > > __fput() -> file_free()
> > > > that files with FMODE_BACKING are directly freed with kfree(), no RCU delay.
> > >
> > > Good catch on FMODE_BACKING, I didn't realize there is this exception, thanks!
> > >
> > > I think the way forward would be to detect that the backing file is in
> > > FMODE_BACKING and fall back to mmap_lock-protected code path.
> > >
> > > I guess I have the question to Liam and Suren, do you think it would
> > > be ok to add another bool after `bool detached` in struct
> > > vm_area_struct (guarded by CONFIG_PER_VMA_LOCK), or should we try to
> > > add an extra bit into vm_flags_t? The latter would work without
> > > CONFIG_PER_VMA_LOCK, but I don't know what's acceptable with mm folks.
> > >
> > > This flag can be set in vma_set_file() when swapping backing file and
> > > wherever else vma->vm_file might be set/updated (I need to audit the
> > > code).
> >
> > I understand that this would work but I'm not very eager to leak
> > vm_file attributes like FMODE_BACKING into vm_area_struct.
> > Instead maybe that exception can be avoided? Treating all vm_files
> 
> I agree, that would be best, of course. It seems like [1] was an
> optimization to avoid kfree_rcu() calls, not sure how big of a deal it
> is to undo that, given we do have a use case that calls for it now.
> Let's see what Christian thinks.

Do you just mean?

diff --git a/fs/file_table.c b/fs/file_table.c
index 7ce4d5dac080..03e58b28e539 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -68,7 +68,7 @@ static inline void file_free(struct file *f)
        put_cred(f->f_cred);
        if (unlikely(f->f_mode & FMODE_BACKING)) {
                path_put(backing_file_user_path(f));
-               kfree(backing_file(f));
+               kfree_rcu(backing_file(f));
        } else {
                kmem_cache_free(filp_cachep, f);
        }

Then the only thing you can do with FMODE_BACKING is to skip it. I think
that should be fine since backing files right now are only used by
overlayfs and I don't think the kfree_rcu() will be a performance issue.

> 
> > equally as RCU-safe would be a much simpler solution. I see that this
> > exception was introduced in [1] and I don't know if this was done for
> > performance reasons or something else. Christian, CCing you here to
> > please clarify.
> >
> > [1] https://lore.kernel.org/all/20231005-sakralbau-wappnen-f5c31755ed70@brauner/
> >
> > >
> > > >
> > > > So the RCU-ness of "struct file" is an implementation detail of the
> > > > VFS, and you can't rely on it for ->vm_file unless you get the VFS to
> > > > change how backing file lifetimes work, which might slow down some
> > > > other workload, or you find a way to figure out whether you're dealing
> > > > with a backing file without actually accessing the file.
> > > >
> > > > > +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
> > > > > +{
> > > > > +       const vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
> > > > > +       struct mm_struct *mm = current->mm;
> > > > > +       struct uprobe *uprobe;
> > > > > +       struct vm_area_struct *vma;
> > > > > +       struct file *vm_file;
> > > > > +       struct inode *vm_inode;
> > > > > +       unsigned long vm_pgoff, vm_start;
> > > > > +       int seq;
> > > > > +       loff_t offset;
> > > > > +
> > > > > +       if (!mmap_lock_speculation_start(mm, &seq))
> > > > > +               return NULL;
> > > > > +
> > > > > +       rcu_read_lock();
> > > > > +
> > > > > +       vma = vma_lookup(mm, bp_vaddr);
> > > > > +       if (!vma)
> > > > > +               goto bail;
> > > > > +
> > > > > +       vm_file = data_race(vma->vm_file);
> > > >
> > > > A plain "data_race()" says "I'm fine with this load tearing", but
> > > > you're relying on this load not tearing (since you access the vm_file
> > > > pointer below).
> > > > You're also relying on the "struct file" that vma->vm_file points to
> > > > being populated at this point, which means you need CONSUME semantics
> > > > here, which READ_ONCE() will give you, and something like RELEASE
> > > > semantics on any pairing store that populates vma->vm_file, which
> > > > means they'd all have to become something like smp_store_release()).
> > >
> > > vma->vm_file should be set in VMA before it is installed and is never
> > > modified afterwards, isn't that the case? So maybe no extra barrier
> > > are needed and READ_ONCE() would be enough.
> > >
> > > >
> > > > You might want to instead add another recheck of the sequence count
> > > > (which would involve at least a read memory barrier after the
> > > > preceding patch is fixed) after loading the ->vm_file pointer to
> > > > ensure that no one was concurrently changing the ->vm_file pointer
> > > > before you do memory accesses through it.
> > > >
> > > > > +       if (!vm_file || (vma->vm_flags & flags) != VM_MAYEXEC)
> > > > > +               goto bail;
> > > >
> > > > missing data_race() annotation on the vma->vm_flags access
> > >
> > > ack
> > >
> > > >
> > > > > +       vm_inode = data_race(vm_file->f_inode);
> > > >
> > > > As noted above, this doesn't work because you can't rely on having RCU
> > > > lifetime for the file. One *very* ugly hack you could do, if you think
> > > > this code is so performance-sensitive that you're willing to do fairly
> > > > atrocious things here, would be to do a "yes I am intentionally doing
> > > > a UAF read and I know the address might not even be mapped at this
> > > > point, it's fine, trust me" pattern, where you use
> > > > copy_from_kernel_nofault(), kind of like in prepend_copy() in
> > > > fs/d_path.c, and then immediately recheck the sequence count before
> > > > doing *anything* with this vm_inode pointer you just loaded.
> > > >
> > > >
> > >
> > > yeah, let's leave it as a very unfortunate plan B and try to solve it
> > > a bit cleaner.
> > >
> > >
> > > >
> > > > > +       vm_pgoff = data_race(vma->vm_pgoff);
> > > > > +       vm_start = data_race(vma->vm_start);
> > > > > +
> > > > > +       offset = (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_start);
> > > > > +       uprobe = find_uprobe_rcu(vm_inode, offset);
> > > > > +       if (!uprobe)
> > > > > +               goto bail;
> > > > > +
> > > > > +       /* now double check that nothing about MM changed */
> > > > > +       if (!mmap_lock_speculation_end(mm, seq))
> > > > > +               goto bail;
> > > > > +
> > > > > +       rcu_read_unlock();
> > > > > +
> > > > > +       /* happy case, we speculated successfully */
> > > > > +       return uprobe;
> > > > > +bail:
> > > > > +       rcu_read_unlock();
> > > > > +       return NULL;
> > > > > +}

