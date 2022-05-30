Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842C8537995
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 13:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiE3LMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 07:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiE3LML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 07:12:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E43679818;
        Mon, 30 May 2022 04:12:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z7so2215127edm.13;
        Mon, 30 May 2022 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BPBLFyQ8NC6AfQ4pTqQuan/NBf30qcif989YZ5u9L0=;
        b=eZl19VGsqnbzNubpDJj5CyTloc9FIN2p7Aj1K9DC3KRGbpjtkqAHXZ3qHj/UsqF3a9
         Msgh22pxVs6FPZ+tvk9nP688zJ6mU8HPkJuxVSGSgyE0JzRirHhLlNCmtPPitsF1MZus
         7blJTJn2CItZLNwjaFOxmBt2D7N2Scz3ub628+Kj3bQLDAwb6HmjGXv6PCaUpOY2ZCiY
         FbVDJKUXkXMl948d/M9tNT5hdAXqwoFpMg2un5+onx6/8l5XMlpQTWOhJR6tIyHKLiRM
         Lk4Kjpo1+5B4Ecau0YKaUZAkBJydKrXzothixEIZo2Lfs7QgVYNnSmzIfwhdd1XXitU6
         oKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BPBLFyQ8NC6AfQ4pTqQuan/NBf30qcif989YZ5u9L0=;
        b=dyk+RyW8Rx0C+kz2Ft5KHGbJFLhq65JP1yNOrJLUhdus4rR70fnbwqQ8i08Ytdr/cA
         /yle5mUv4j2J9j+1OhOb1ZbmLgWBX1nqgH/3DBW3N9miHY0MH6Q7mW2O/3V90tf+FR0I
         RlXyalEhqMNv4p+Q5apxGBnePpFkc6AmUquvx1kKOG8W6WGAPtx02G//Y/1uX7THRkdE
         Nr9L+MKiYF3oEHf0a8cQso7F5s/q6cz+yrDbYoDsYeD8Bf2d9Z82WaBfzEqRMimRHyPU
         IlS5i3E/J72576V/yA9OrKDVV8z9Z61qZ0OgXkGuyCffBCVWiV+HbjzAyOFNzuQIkcpF
         RVgQ==
X-Gm-Message-State: AOAM531A1hrFs4P2qEUuEOeV2oPOg60w3E/iA2dC3SlqeMWGPhDSDCIt
        YFNhjGHGhizs0P3MhFk7p3TpkTlYhiNSNiV/hko=
X-Google-Smtp-Source: ABdhPJyzzbFBqovzJ8wyS+m0VTPiFmhYYtu7K6GM6G9KZbhhTmZQXShGqxffgrDWCaCaJR3o79PvWwA0JoUDilgzONk=
X-Received: by 2002:a05:6402:1150:b0:42a:9dbf:8860 with SMTP id
 g16-20020a056402115000b0042a9dbf8860mr57997158edw.350.1653909126999; Mon, 30
 May 2022 04:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649370874.git.khalid.aziz@oracle.com> <5c96dd165d7ec3da14306b8fd857c7eb95a8c3e6.1649370874.git.khalid.aziz@oracle.com>
In-Reply-To: <5c96dd165d7ec3da14306b8fd857c7eb95a8c3e6.1649370874.git.khalid.aziz@oracle.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 30 May 2022 23:11:55 +1200
Message-ID: <CAGsJ_4xPFu5FCQtNE6cJxbV7kMQXNtzotBFQKC3OkXUOtweyYQ@mail.gmail.com>
Subject: Re: [PATCH v1 08/14] mm/mshare: Add basic page table sharing using mshare
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, ebiederm@xmission.com,
        hagen@jauu.net, jack@suse.cz, Kees Cook <keescook@chromium.org>,
        kirill@shutemov.name, kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        Andy Lutomirski <luto@kernel.org>, markhemm@googlemail.com,
        pcc@google.com, Mike Rapoport <rppt@kernel.org>,
        sieberf@amazon.com, sjpark@amazon.de,
        Suren Baghdasaryan <surenb@google.com>, tst@schoebel-theuer.de,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 12, 2022 at 4:07 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> This patch adds basic page table sharing across tasks by making
> mshare syscall. It does this by creating a new mm_struct which
> hosts the shared vmas and page tables. This mm_struct is
> maintained as long as there is at least one task using the mshare'd
> range. It is cleaned up by the last mshare_unlink syscall.
>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/internal.h |   2 +
>  mm/memory.c   |  35 ++++++++++
>  mm/mshare.c   | 190 ++++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 214 insertions(+), 13 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index cf50a471384e..68f82f0f8b66 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -718,6 +718,8 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
>  int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
>                       unsigned long addr, int page_nid, int *flags);
>
> +extern vm_fault_t find_shared_vma(struct vm_area_struct **vma,
> +                       unsigned long *addrp);
>  static inline bool vma_is_shared(const struct vm_area_struct *vma)
>  {
>         return vma->vm_flags & VM_SHARED_PT;
> diff --git a/mm/memory.c b/mm/memory.c
> index c125c4969913..c77c0d643ea8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4776,6 +4776,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>                            unsigned int flags, struct pt_regs *regs)
>  {
>         vm_fault_t ret;
> +       bool shared = false;
>
>         __set_current_state(TASK_RUNNING);
>
> @@ -4785,6 +4786,15 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>         /* do counter updates before entering really critical section. */
>         check_sync_rss_stat(current);
>
> +       if (unlikely(vma_is_shared(vma))) {
> +               ret = find_shared_vma(&vma, &address);
> +               if (ret)
> +                       return ret;
> +               if (!vma)
> +                       return VM_FAULT_SIGSEGV;
> +               shared = true;
> +       }
> +
>         if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
>                                             flags & FAULT_FLAG_INSTRUCTION,
>                                             flags & FAULT_FLAG_REMOTE))
> @@ -4802,6 +4812,31 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>         else
>                 ret = __handle_mm_fault(vma, address, flags);
>
> +       /*
> +        * Release the read lock on shared VMA's parent mm unless
> +        * __handle_mm_fault released the lock already.
> +        * __handle_mm_fault sets VM_FAULT_RETRY in return value if
> +        * it released mmap lock. If lock was released, that implies
> +        * the lock would have been released on task's original mm if
> +        * this were not a shared PTE vma. To keep lock state consistent,
> +        * make sure to release the lock on task's original mm
> +        */
> +       if (shared) {
> +               int release_mmlock = 1;
> +
> +               if (!(ret & VM_FAULT_RETRY)) {
> +                       mmap_read_unlock(vma->vm_mm);
> +                       release_mmlock = 0;
> +               } else if ((flags & FAULT_FLAG_ALLOW_RETRY) &&
> +                       (flags & FAULT_FLAG_RETRY_NOWAIT)) {
> +                       mmap_read_unlock(vma->vm_mm);
> +                       release_mmlock = 0;
> +               }
> +
> +               if (release_mmlock)
> +                       mmap_read_unlock(current->mm);
> +       }
> +
>         if (flags & FAULT_FLAG_USER) {
>                 mem_cgroup_exit_user_fault();
>                 /*
> diff --git a/mm/mshare.c b/mm/mshare.c
> index cd2f7ad24d9d..d1896adcb00f 100644
> --- a/mm/mshare.c
> +++ b/mm/mshare.c
> @@ -17,18 +17,49 @@
>  #include <linux/pseudo_fs.h>
>  #include <linux/fileattr.h>
>  #include <linux/refcount.h>
> +#include <linux/mman.h>
>  #include <linux/sched/mm.h>
>  #include <uapi/linux/magic.h>
>  #include <uapi/linux/limits.h>
>
>  struct mshare_data {
> -       struct mm_struct *mm;
> +       struct mm_struct *mm, *host_mm;
>         mode_t mode;
>         refcount_t refcnt;
>  };
>
>  static struct super_block *msharefs_sb;
>
> +/* Returns holding the host mm's lock for read.  Caller must release. */
> +vm_fault_t
> +find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp)
> +{
> +       struct vm_area_struct *vma, *guest = *vmap;
> +       struct mshare_data *info = guest->vm_private_data;
> +       struct mm_struct *host_mm = info->mm;
> +       unsigned long host_addr;
> +       pgd_t *pgd, *guest_pgd;
> +
> +       host_addr = *addrp - guest->vm_start + host_mm->mmap_base;
> +       pgd = pgd_offset(host_mm, host_addr);
> +       guest_pgd = pgd_offset(current->mm, *addrp);
> +       if (!pgd_same(*guest_pgd, *pgd)) {
> +               set_pgd(guest_pgd, *pgd);
> +               return VM_FAULT_NOPAGE;
> +       }
> +
> +       *addrp = host_addr;
> +       mmap_read_lock(host_mm);
> +       vma = find_vma(host_mm, host_addr);
> +
> +       /* XXX: expand stack? */
> +       if (vma && vma->vm_start > host_addr)
> +               vma = NULL;
> +
> +       *vmap = vma;
> +       return 0;
> +}
> +
>  static void
>  msharefs_evict_inode(struct inode *inode)
>  {
> @@ -169,11 +200,13 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>                 unsigned long, len, int, oflag, mode_t, mode)
>  {
>         struct mshare_data *info;
> -       struct mm_struct *mm;
>         struct filename *fname = getname(name);
>         struct dentry *dentry;
>         struct inode *inode;
>         struct qstr namestr;
> +       struct vm_area_struct *vma, *next, *new_vma;
> +       struct mm_struct *new_mm;
> +       unsigned long end;
>         int err = PTR_ERR(fname);
>
>         /*
> @@ -193,6 +226,8 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>         if (IS_ERR(fname))
>                 goto err_out;
>
> +       end = addr + len;
> +
>         /*
>          * Does this mshare entry exist already? If it does, calling
>          * mshare with O_EXCL|O_CREAT is an error
> @@ -205,49 +240,165 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>         inode_lock(d_inode(msharefs_sb->s_root));
>         dentry = d_lookup(msharefs_sb->s_root, &namestr);
>         if (dentry && (oflag & (O_EXCL|O_CREAT))) {
> +               inode = d_inode(dentry);
>                 err = -EEXIST;
>                 dput(dentry);
>                 goto err_unlock_inode;
>         }
>
>         if (dentry) {
> +               unsigned long mapaddr, prot = PROT_NONE;
> +
>                 inode = d_inode(dentry);
>                 if (inode == NULL) {
> +                       mmap_write_unlock(current->mm);
>                         err = -EINVAL;
>                         goto err_out;
>                 }
>                 info = inode->i_private;
> -               refcount_inc(&info->refcnt);
>                 dput(dentry);
> +
> +               /*
> +                * Map in the address range as anonymous mappings
> +                */
> +               oflag &= (O_RDONLY | O_WRONLY | O_RDWR);
> +               if (oflag & O_RDONLY)
> +                       prot |= PROT_READ;
> +               else if (oflag & O_WRONLY)
> +                       prot |= PROT_WRITE;
> +               else if (oflag & O_RDWR)
> +                       prot |= (PROT_READ | PROT_WRITE);
> +               mapaddr = vm_mmap(NULL, addr, len, prot,
> +                               MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, 0);

From the perspective of hardware, do we have to use MAP_FIXED to make
sure those processes sharing PTE
use the same virtual address for the shared area? or actually we don't
necessarily need it? as long as the
upper level pgtable entries point to the same lower level pgtable?


> +               if (IS_ERR((void *)mapaddr)) {
> +                       err = -EINVAL;
> +                       goto err_out;
> +               }
> +
> +               refcount_inc(&info->refcnt);
> +
> +               /*
> +                * Now that we have mmap'd the mshare'd range, update vma
> +                * flags and vm_mm pointer for this mshare'd range.
> +                */
> +               mmap_write_lock(current->mm);
> +               vma = find_vma(current->mm, addr);
> +               if (vma && vma->vm_start < addr) {
> +                       mmap_write_unlock(current->mm);
> +                       err = -EINVAL;
> +                       goto err_out;
> +               }
> +
> +               while (vma && vma->vm_start < (addr + len)) {
> +                       vma->vm_private_data = info;
> +                       vma->vm_mm = info->mm;
> +                       vma->vm_flags |= VM_SHARED_PT;
> +                       next = vma->vm_next;
> +                       vma = next;
> +               }
>         } else {
> -               mm = mm_alloc();
> -               if (!mm)
> +               unsigned long myaddr;
> +               struct mm_struct *old_mm;
> +
> +               old_mm = current->mm;
> +               new_mm = mm_alloc();
> +               if (!new_mm)
>                         return -ENOMEM;
>                 info = kzalloc(sizeof(*info), GFP_KERNEL);
>                 if (!info) {
>                         err = -ENOMEM;
>                         goto err_relmm;
>                 }
> -               mm->mmap_base = addr;
> -               mm->task_size = addr + len;
> -               if (!mm->task_size)
> -                       mm->task_size--;
> -               info->mm = mm;
> +               new_mm->mmap_base = addr;
> +               new_mm->task_size = addr + len;
> +               if (!new_mm->task_size)
> +                       new_mm->task_size--;
> +               info->mm = new_mm;
> +               info->host_mm = old_mm;
>                 info->mode = mode;
>                 refcount_set(&info->refcnt, 1);
> +
> +               /*
> +                * VMAs for this address range may or may not exist.
> +                * If VMAs exist, they should be marked as shared at
> +                * this point and page table info should be copied
> +                * over to newly created mm_struct. TODO: If VMAs do not
> +                * exist, create them and mark them as shared.
> +                */
> +               mmap_write_lock(old_mm);
> +               vma = find_vma_intersection(old_mm, addr, end);
> +               if (!vma) {
> +                       err = -EINVAL;
> +                       goto unlock;
> +               }
> +               /*
> +                * TODO: If the currently allocated VMA goes beyond the
> +                * mshare'd range, this VMA needs to be split.
> +                *
> +                * Double check that source VMAs do not extend outside
> +                * the range
> +                */
> +               vma = find_vma(old_mm, addr + len);
> +               if (vma && vma->vm_start < (addr + len)) {
> +                       err = -EINVAL;
> +                       goto unlock;
> +               }
> +
> +               vma = find_vma(old_mm, addr);
> +               if (vma && vma->vm_start < addr) {
> +                       err = -EINVAL;
> +                       goto unlock;
> +               }
> +
> +               mmap_write_lock(new_mm);
> +               while (vma && vma->vm_start < (addr + len)) {
> +                       /*
> +                        * Copy this vma over to host mm
> +                        */
> +                       vma->vm_private_data = info;
> +                       vma->vm_mm = new_mm;
> +                       vma->vm_flags |= VM_SHARED_PT;
> +                       new_vma = vm_area_dup(vma);
> +                       if (!new_vma) {
> +                               err = -ENOMEM;
> +                               goto unlock;
> +                       }
> +                       err = insert_vm_struct(new_mm, new_vma);
> +                       if (err)
> +                               goto unlock;
> +
> +                       vma = vma->vm_next;
> +               }
> +               mmap_write_unlock(new_mm);
> +
>                 err = mshare_file_create(fname, oflag, info);
>                 if (err)
> -                       goto err_relinfo;
> +                       goto unlock;
> +
> +               /*
> +                * Copy over current PTEs
> +                */
> +               myaddr = addr;
> +               while (myaddr < new_mm->task_size) {
> +                       *pgd_offset(new_mm, myaddr) = *pgd_offset(old_mm, myaddr);
> +                       myaddr += PGDIR_SIZE;
> +               }
> +               /*
> +                * TODO: Free the corresponding page table in calling
> +                * process
> +                */
>         }
>
> +       mmap_write_unlock(current->mm);
>         inode_unlock(d_inode(msharefs_sb->s_root));
>         putname(fname);
>         return 0;
>
> -err_relinfo:
> +unlock:
> +       mmap_write_unlock(current->mm);
>         kfree(info);
>  err_relmm:
> -       mmput(mm);
> +       mmput(new_mm);
>  err_unlock_inode:
>         inode_unlock(d_inode(msharefs_sb->s_root));
>  err_out:
> @@ -294,11 +445,24 @@ SYSCALL_DEFINE1(mshare_unlink, const char *, name)
>
>         /*
>          * Is this the last reference?
> +        * TODO: permission checks are needed before proceeding
>          */
>         if (refcount_dec_and_test(&info->refcnt)) {
>                 simple_unlink(d_inode(msharefs_sb->s_root), dentry);
>                 d_drop(dentry);
>                 d_delete(dentry);
> +               /*
> +                * TODO: Release all physical pages allocated for this
> +                * mshare range and release associated page table. If
> +                * the final unlink happens from the process that created
> +                * mshare'd range, do we return page tables and pages to
> +                * that process so the creating process can continue using
> +                * the address range it had chosen to mshare at some
> +                * point?
> +                *
> +                * TODO: unmap shared vmas from every task that is using
> +                * this mshare'd range.
> +                */
>                 mmput(info->mm);
>                 kfree(info);
>         } else {
> --
> 2.32.0
>

Thanks
Barry
