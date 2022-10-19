Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666A06045E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 14:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiJSMvk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 08:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiJSMvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:51:11 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9F011E45F
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 05:33:26 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g9so11210037qvo.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r1nN5HoJA+QWaw57MkfSZ7AXcUY2x7OwZdneDnG7JGw=;
        b=qCP25JB79dtuinCJjovrQ+TKlVOz9T5wtdGNWfI8zDBfRq7HVnhgmgos6nTOpv4v8x
         f8MuG6GJ/8AVlkzsMqmUvpvqtuSS7u7JkNO088lw2rx/kuXIYH5W6QPokXEBt2+m3rqY
         yMCE88rwDtHAxisr/tGgAOjX2/bidAA4mK+mPHENELzyG6eh0gg403vb2JPUyHmiKOzq
         0xL5PNWkYk5uUj/K4ZrE7RYTaT+r0sfpvJLneMaCeM88/lW6gyEE5n6GiZhnO1wCGhu5
         O90SDtVLGZUaFWz4MPu+fGVE85x+Rzyw8iUJDVipBVnQvxoPbtoXRNES1PfL7AicsUq2
         mXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1nN5HoJA+QWaw57MkfSZ7AXcUY2x7OwZdneDnG7JGw=;
        b=OYpOgrFRPWHlA6TXW7xdZXH5CJmJZ6MWgklAXyvktnx9w1SnzT5hcTUVdH5GEgHIPF
         jLRBlQ4wYez2pYKxeQGYqAF5gQJDlfugidSYANi/B0xHZAVwlEKvV/N+/cSMX0M3SZm8
         8XBX8EFvCPcOEZUSuIaosE3G6eQFIJLHuENBaputZQe2LTUnQqY3AAVYACwclBHoVeIu
         5iC3364SMfPr6anlHTdpycQ6hhAtbyObD/N5nSQZolt7/3zXV39A1l9K79N9cLt1pnax
         ZYk4yH+UZmPv3ADlmkTZlCNhU2i8dn0+CFqFmHoaEzUkl99Gohl9ZHyWigwLqiteBBJi
         u35g==
X-Gm-Message-State: ACrzQf01HSKwHVbwOgjBoejBfZD1t+S7f8slBVMzj9aZw1TTAwtV8Wpl
        WjVAV39GliDNc4gNuIZBeBVfX9T3N68b7B8Nb60Mm9KnTaNAWP82
X-Google-Smtp-Source: AMsMyM7OgqmWmR35JKSjTx1GS4Q97xb3oG8vx7AjlXbCobpvGFxtx2x+alqPYK1uk6NS6I1m/9K97poofI3i2/ANW0A=
X-Received: by 2002:a17:902:eb83:b0:185:46b7:7de3 with SMTP id
 q3-20020a170902eb8300b0018546b77de3mr8121909plg.19.1666182240739; Wed, 19 Oct
 2022 05:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com> <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
In-Reply-To: <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Wed, 19 Oct 2022 17:53:48 +0530
Message-ID: <CAGtprH_MiCxT2xSxD2UrM4M+ghL0V=XEZzEX4Fo5wQKV4fAL4w@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 8:04 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> KVM can use memfd-provided memory for guest memory. For normal userspace
> accessible memory, KVM userspace (e.g. QEMU) mmaps the memfd into its
> virtual address space and then tells KVM to use the virtual address to
> setup the mapping in the secondary page table (e.g. EPT).
>
> With confidential computing technologies like Intel TDX, the
> memfd-provided memory may be encrypted with special key for special
> software domain (e.g. KVM guest) and is not expected to be directly
> accessed by userspace. Precisely, userspace access to such encrypted
> memory may lead to host crash so it should be prevented.
>
> This patch introduces userspace inaccessible memfd (created with
> MFD_INACCESSIBLE). Its memory is inaccessible from userspace through
> ordinary MMU access (e.g. read/write/mmap) but can be accessed via
> in-kernel interface so KVM can directly interact with core-mm without
> the need to map the memory into KVM userspace.
>
> It provides semantics required for KVM guest private(encrypted) memory
> support that a file descriptor with this flag set is going to be used as
> the source of guest memory in confidential computing environments such
> as Intel TDX/AMD SEV.
>
> KVM userspace is still in charge of the lifecycle of the memfd. It
> should pass the opened fd to KVM. KVM uses the kernel APIs newly added
> in this patch to obtain the physical memory address and then populate
> the secondary page table entries.
>
> The userspace inaccessible memfd can be fallocate-ed and hole-punched
> from userspace. When hole-punching happens, KVM can get notified through
> inaccessible_notifier it then gets chance to remove any mapped entries
> of the range in the secondary page tables.
>
> The userspace inaccessible memfd itself is implemented as a shim layer
> on top of real memory file systems like tmpfs/hugetlbfs but this patch
> only implemented tmpfs. The allocated memory is currently marked as
> unmovable and unevictable, this is required for current confidential
> usage. But in future this might be changed.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/linux/memfd.h      |  24 ++++
>  include/uapi/linux/magic.h |   1 +
>  include/uapi/linux/memfd.h |   1 +
>  mm/Makefile                |   2 +-
>  mm/memfd.c                 |  25 ++++-
>  mm/memfd_inaccessible.c    | 219 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 270 insertions(+), 2 deletions(-)
>  create mode 100644 mm/memfd_inaccessible.c
>
> diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> index 4f1600413f91..334ddff08377 100644
> --- a/include/linux/memfd.h
> +++ b/include/linux/memfd.h
> @@ -3,6 +3,7 @@
>  #define __LINUX_MEMFD_H
>
>  #include <linux/file.h>
> +#include <linux/pfn_t.h>
>
>  #ifdef CONFIG_MEMFD_CREATE
>  extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg);
> @@ -13,4 +14,27 @@ static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned long a)
>  }
>  #endif
>
> +struct inaccessible_notifier;
> +
> +struct inaccessible_notifier_ops {
> +       void (*invalidate)(struct inaccessible_notifier *notifier,
> +                          pgoff_t start, pgoff_t end);
> +};
> +
> +struct inaccessible_notifier {
> +       struct list_head list;
> +       const struct inaccessible_notifier_ops *ops;
> +};
> +
> +void inaccessible_register_notifier(struct file *file,
> +                                   struct inaccessible_notifier *notifier);
> +void inaccessible_unregister_notifier(struct file *file,
> +                                     struct inaccessible_notifier *notifier);
> +
> +int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> +                        int *order);
> +void inaccessible_put_pfn(struct file *file, pfn_t pfn);
> +
> +struct file *memfd_mkinaccessible(struct file *memfd);
> +
>  #endif /* __LINUX_MEMFD_H */
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 6325d1d0e90f..9d066be3d7e8 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -101,5 +101,6 @@
>  #define DMA_BUF_MAGIC          0x444d4142      /* "DMAB" */
>  #define DEVMEM_MAGIC           0x454d444d      /* "DMEM" */
>  #define SECRETMEM_MAGIC                0x5345434d      /* "SECM" */
> +#define INACCESSIBLE_MAGIC     0x494e4143      /* "INAC" */
>
>  #endif /* __LINUX_MAGIC_H__ */
> diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
> index 7a8a26751c23..48750474b904 100644
> --- a/include/uapi/linux/memfd.h
> +++ b/include/uapi/linux/memfd.h
> @@ -8,6 +8,7 @@
>  #define MFD_CLOEXEC            0x0001U
>  #define MFD_ALLOW_SEALING      0x0002U
>  #define MFD_HUGETLB            0x0004U
> +#define MFD_INACCESSIBLE       0x0008U
>
>  /*
>   * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
> diff --git a/mm/Makefile b/mm/Makefile
> index 9a564f836403..f82e5d4b4388 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -126,7 +126,7 @@ obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o
>  obj-$(CONFIG_PERCPU_STATS) += percpu-stats.o
>  obj-$(CONFIG_ZONE_DEVICE) += memremap.o
>  obj-$(CONFIG_HMM_MIRROR) += hmm.o
> -obj-$(CONFIG_MEMFD_CREATE) += memfd.o
> +obj-$(CONFIG_MEMFD_CREATE) += memfd.o memfd_inaccessible.o
>  obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
>  obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
>  obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 08f5f8304746..1853a90f49ff 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -261,7 +261,8 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
>  #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
>  #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
>
> -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB)
> +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
> +                      MFD_INACCESSIBLE)
>
>  SYSCALL_DEFINE2(memfd_create,
>                 const char __user *, uname,
> @@ -283,6 +284,14 @@ SYSCALL_DEFINE2(memfd_create,
>                         return -EINVAL;
>         }
>
> +       /* Disallow sealing when MFD_INACCESSIBLE is set. */
> +       if ((flags & MFD_INACCESSIBLE) && (flags & MFD_ALLOW_SEALING))
> +               return -EINVAL;
> +
> +       /* TODO: add hugetlb support */
> +       if ((flags & MFD_INACCESSIBLE) && (flags & MFD_HUGETLB))
> +               return -EINVAL;
> +
>         /* length includes terminating zero */
>         len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
>         if (len <= 0)
> @@ -331,10 +340,24 @@ SYSCALL_DEFINE2(memfd_create,
>                 *file_seals &= ~F_SEAL_SEAL;
>         }
>
> +       if (flags & MFD_INACCESSIBLE) {
> +               struct file *inaccessible_file;
> +
> +               inaccessible_file = memfd_mkinaccessible(file);
> +               if (IS_ERR(inaccessible_file)) {
> +                       error = PTR_ERR(inaccessible_file);
> +                       goto err_file;
> +               }
> +
> +               file = inaccessible_file;
> +       }
> +
>         fd_install(fd, file);
>         kfree(name);
>         return fd;
>
> +err_file:
> +       fput(file);
>  err_fd:
>         put_unused_fd(fd);
>  err_name:
> diff --git a/mm/memfd_inaccessible.c b/mm/memfd_inaccessible.c
> new file mode 100644
> index 000000000000..2d33cbdd9282
> --- /dev/null
> +++ b/mm/memfd_inaccessible.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "linux/sbitmap.h"
> +#include <linux/memfd.h>
> +#include <linux/pagemap.h>
> +#include <linux/pseudo_fs.h>
> +#include <linux/shmem_fs.h>
> +#include <uapi/linux/falloc.h>
> +#include <uapi/linux/magic.h>
> +
> +struct inaccessible_data {
> +       struct mutex lock;
> +       struct file *memfd;
> +       struct list_head notifiers;
> +};
> +
> +static void inaccessible_notifier_invalidate(struct inaccessible_data *data,
> +                                pgoff_t start, pgoff_t end)
> +{
> +       struct inaccessible_notifier *notifier;
> +
> +       mutex_lock(&data->lock);
> +       list_for_each_entry(notifier, &data->notifiers, list) {
> +               notifier->ops->invalidate(notifier, start, end);
> +       }
> +       mutex_unlock(&data->lock);
> +}
> +
> +static int inaccessible_release(struct inode *inode, struct file *file)
> +{
> +       struct inaccessible_data *data = inode->i_mapping->private_data;
> +
> +       fput(data->memfd);
> +       kfree(data);
> +       return 0;
> +}
> +
> +static long inaccessible_fallocate(struct file *file, int mode,
> +                                  loff_t offset, loff_t len)
> +{
> +       struct inaccessible_data *data = file->f_mapping->private_data;
> +       struct file *memfd = data->memfd;
> +       int ret;
> +
> +       if (mode & FALLOC_FL_PUNCH_HOLE) {
> +               if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> +                       return -EINVAL;
> +       }
> +
> +       ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> +       inaccessible_notifier_invalidate(data, offset, offset + len);
> +       return ret;
> +}
> +
> +static const struct file_operations inaccessible_fops = {
> +       .release = inaccessible_release,
> +       .fallocate = inaccessible_fallocate,
> +};
> +
> +static int inaccessible_getattr(struct user_namespace *mnt_userns,
> +                               const struct path *path, struct kstat *stat,
> +                               u32 request_mask, unsigned int query_flags)
> +{
> +       struct inode *inode = d_inode(path->dentry);
> +       struct inaccessible_data *data = inode->i_mapping->private_data;
> +       struct file *memfd = data->memfd;
> +
> +       return memfd->f_inode->i_op->getattr(mnt_userns, path, stat,
> +                                            request_mask, query_flags);
> +}
> +
> +static int inaccessible_setattr(struct user_namespace *mnt_userns,
> +                               struct dentry *dentry, struct iattr *attr)
> +{
> +       struct inode *inode = d_inode(dentry);
> +       struct inaccessible_data *data = inode->i_mapping->private_data;
> +       struct file *memfd = data->memfd;
> +       int ret;
> +
> +       if (attr->ia_valid & ATTR_SIZE) {
> +               if (memfd->f_inode->i_size)
> +                       return -EPERM;
> +
> +               if (!PAGE_ALIGNED(attr->ia_size))
> +                       return -EINVAL;
> +       }
> +
> +       ret = memfd->f_inode->i_op->setattr(mnt_userns,
> +                                           file_dentry(memfd), attr);
> +       return ret;
> +}
> +
> +static const struct inode_operations inaccessible_iops = {
> +       .getattr = inaccessible_getattr,
> +       .setattr = inaccessible_setattr,
> +};
> +
> +static int inaccessible_init_fs_context(struct fs_context *fc)
> +{
> +       if (!init_pseudo(fc, INACCESSIBLE_MAGIC))
> +               return -ENOMEM;
> +
> +       fc->s_iflags |= SB_I_NOEXEC;
> +       return 0;
> +}
> +
> +static struct file_system_type inaccessible_fs = {
> +       .owner          = THIS_MODULE,
> +       .name           = "[inaccessible]",
> +       .init_fs_context = inaccessible_init_fs_context,
> +       .kill_sb        = kill_anon_super,
> +};
> +
> +static struct vfsmount *inaccessible_mnt;
> +
> +static __init int inaccessible_init(void)
> +{
> +       inaccessible_mnt = kern_mount(&inaccessible_fs);
> +       if (IS_ERR(inaccessible_mnt))
> +               return PTR_ERR(inaccessible_mnt);
> +       return 0;
> +}
> +fs_initcall(inaccessible_init);
> +
> +struct file *memfd_mkinaccessible(struct file *memfd)
> +{
> +       struct inaccessible_data *data;
> +       struct address_space *mapping;
> +       struct inode *inode;
> +       struct file *file;
> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return ERR_PTR(-ENOMEM);
> +
> +       data->memfd = memfd;
> +       mutex_init(&data->lock);
> +       INIT_LIST_HEAD(&data->notifiers);
> +
> +       inode = alloc_anon_inode(inaccessible_mnt->mnt_sb);
> +       if (IS_ERR(inode)) {
> +               kfree(data);
> +               return ERR_CAST(inode);
> +       }
> +
> +       inode->i_mode |= S_IFREG;
> +       inode->i_op = &inaccessible_iops;
> +       inode->i_mapping->private_data = data;
> +
> +       file = alloc_file_pseudo(inode, inaccessible_mnt,
> +                                "[memfd:inaccessible]", O_RDWR,
> +                                &inaccessible_fops);
> +       if (IS_ERR(file)) {
> +               iput(inode);
> +               kfree(data);
> +       }
> +
> +       file->f_flags |= O_LARGEFILE;
> +
> +       mapping = memfd->f_mapping;
> +       mapping_set_unevictable(mapping);
> +       mapping_set_gfp_mask(mapping,
> +                            mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);
> +
> +       return file;
> +}
> +
> +void inaccessible_register_notifier(struct file *file,
> +                                   struct inaccessible_notifier *notifier)
> +{
> +       struct inaccessible_data *data = file->f_mapping->private_data;
> +
> +       mutex_lock(&data->lock);
> +       list_add(&notifier->list, &data->notifiers);
> +       mutex_unlock(&data->lock);
> +}
> +EXPORT_SYMBOL_GPL(inaccessible_register_notifier);
> +
> +void inaccessible_unregister_notifier(struct file *file,
> +                                     struct inaccessible_notifier *notifier)
> +{
> +       struct inaccessible_data *data = file->f_mapping->private_data;
> +
> +       mutex_lock(&data->lock);
> +       list_del(&notifier->list);
> +       mutex_unlock(&data->lock);
> +}
> +EXPORT_SYMBOL_GPL(inaccessible_unregister_notifier);
> +
> +int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> +                        int *order)
> +{
> +       struct inaccessible_data *data = file->f_mapping->private_data;
> +       struct file *memfd = data->memfd;
> +       struct page *page;
> +       int ret;
> +
> +       ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
> +       if (ret)
> +               return ret;
> +
> +       *pfn = page_to_pfn_t(page);
> +       *order = thp_order(compound_head(page));
> +       SetPageUptodate(page);
> +       unlock_page(page);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(inaccessible_get_pfn);
> +
> +void inaccessible_put_pfn(struct file *file, pfn_t pfn)
> +{
> +       struct page *page = pfn_t_to_page(pfn);
> +
> +       if (WARN_ON_ONCE(!page))
> +               return;
> +
> +       put_page(page);
> +}
> +EXPORT_SYMBOL_GPL(inaccessible_put_pfn);
> --
> 2.25.1
>

In the context of userspace inaccessible memfd, what would be a
suggested way to enforce NUMA memory policy for physical memory
allocation? mbind[1] won't work here in absence of virtual address
range.

[1] https://github.com/chao-p/qemu/blob/privmem-v8/backends/hostmem.c#L382
