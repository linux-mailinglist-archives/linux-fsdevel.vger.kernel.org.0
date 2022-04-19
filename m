Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A7B507CA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 00:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358248AbiDSWnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 18:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358042AbiDSWnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:43:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD911581A
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 15:40:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j8so49826pll.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jj65B/Q5u+6/PbNUYjs1QdIcGYmBVQVJnII5Wt+lIX4=;
        b=I1nobehVf5LWIA7uopWD44Vv9PFicIlwJ83srfQrmZBtflj2atQJNxVv37gj4T4l6v
         ScNi3IZVoLT5qpIizY9su9A+Gg9F3EImVTRjv9aQAAxS2kei4tEtl7sH9RRka1Mc+h0i
         3J1w1FYAB9pXAlDmlVX9UJydCY8Hw6IJX2CqVhTFuZprTscj2mU2kcxYbydeeIrRNG+0
         /hdiIk2glg2k2TPStCK1q71Rq2aAqP23tYdUpYm5CzdhY0DW9Ssn6m9sVY8WEQyaIIQA
         ZlAaw8heoEOaMNA8nyRAyYDxmBrb15yBY5YrSLDiOl1MOET5f0HiV/cXzEtZGNQ6Jz+o
         1c7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jj65B/Q5u+6/PbNUYjs1QdIcGYmBVQVJnII5Wt+lIX4=;
        b=mM/VbFtNTpdXs77bg3B+ukooJjUFJIPprszZUSxDWbVDbPurraeXhp0HydJNWtgJji
         Ri4zSVbSQYp8ECNCpTBpmM1bGKl6si9cYxQj1loBDC6OA43uu/BAtVRoYhjnPVts5Iov
         wF2VGZJYXnDNX0FbUlhKcP3IZS9xjokjhkS2bKH671lf+VWqFuXCQwGCtkA7SSd5KgFn
         5ChsbKHe+1WeLjsVBK0nfqsHs4z+5pWpWq7i75jyDKe8s0twAsRwAG2HUFhA2RElCydl
         EoIl8S71eshG4CQHBEbhSLTICSHOhDhlsjosIYTK6pz7fw68odn5D2K23ndPCCjlirIB
         y38g==
X-Gm-Message-State: AOAM532o0en752zTp1hyo4/JkZ656YFJTQnaaRj/7In5VR6iBzE0MuFQ
        a6KIviL33VZ1nGwec5ggiFusSZKgZZV1AeMCPOhZpvLVH8s=
X-Google-Smtp-Source: ABdhPJww/F0+ShnRulehEAsze0oZV1m6PnQGb4q7nZZiU5Dg58u6Z1IHEBgnXvUTReeiVw8AeB78Z4kC+sTgEsLi9v4=
X-Received: by 2002:a17:90b:4d86:b0:1d2:cd59:d275 with SMTP id
 oj6-20020a17090b4d8600b001d2cd59d275mr888317pjb.119.1650408020788; Tue, 19
 Apr 2022 15:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com> <20220310140911.50924-4-chao.p.peng@linux.intel.com>
In-Reply-To: <20220310140911.50924-4-chao.p.peng@linux.intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 19 Apr 2022 15:40:09 -0700
Message-ID: <CAGtprH9X-v-R+UiAvdvKgqAqoc4MBJAWTnoEtP+Y2nip_y8Heg@mail.gmail.com>
Subject: Re: [PATCH v5 03/13] mm/shmem: Support memfile_notifier
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 6:10 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> It maintains a memfile_notifier list in shmem_inode_info structure and
> implements memfile_pfn_ops callbacks defined by memfile_notifier. It
> then exposes them to memfile_notifier via
> shmem_get_memfile_notifier_info.
>
> We use SGP_NOALLOC in shmem_get_lock_pfn since the pages should be
> allocated by userspace for private memory. If there is no pages
> allocated at the offset then error should be returned so KVM knows that
> the memory is not private memory.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/linux/shmem_fs.h |  4 +++
>  mm/shmem.c               | 76 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 2dde843f28ef..7bb16f2d2825 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -9,6 +9,7 @@
>  #include <linux/percpu_counter.h>
>  #include <linux/xattr.h>
>  #include <linux/fs_parser.h>
> +#include <linux/memfile_notifier.h>
>
>  /* inode in-kernel data */
>
> @@ -28,6 +29,9 @@ struct shmem_inode_info {
>         struct simple_xattrs    xattrs;         /* list of xattrs */
>         atomic_t                stop_eviction;  /* hold when working on inode */
>         unsigned int            xflags;         /* shmem extended flags */
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +       struct memfile_notifier_list memfile_notifiers;
> +#endif
>         struct inode            vfs_inode;
>  };
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 9b31a7056009..7b43e274c9a2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -903,6 +903,28 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
>         return page ? page_folio(page) : NULL;
>  }
>
> +static void notify_fallocate(struct inode *inode, pgoff_t start, pgoff_t end)
> +{
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +       struct shmem_inode_info *info = SHMEM_I(inode);
> +
> +       memfile_notifier_fallocate(&info->memfile_notifiers, start, end);
> +#endif
> +}
> +
> +static void notify_invalidate_page(struct inode *inode, struct folio *folio,
> +                                  pgoff_t start, pgoff_t end)
> +{
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +       struct shmem_inode_info *info = SHMEM_I(inode);
> +
> +       start = max(start, folio->index);
> +       end = min(end, folio->index + folio_nr_pages(folio));
> +
> +       memfile_notifier_invalidate(&info->memfile_notifiers, start, end);
> +#endif
> +}
> +
>  /*
>   * Remove range of pages and swap entries from page cache, and free them.
>   * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
> @@ -946,6 +968,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>                         }
>                         index += folio_nr_pages(folio) - 1;
>
> +                       notify_invalidate_page(inode, folio, start, end);
> +
>                         if (!unfalloc || !folio_test_uptodate(folio))
>                                 truncate_inode_folio(mapping, folio);
>                         folio_unlock(folio);
> @@ -1019,6 +1043,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>                                         index--;
>                                         break;
>                                 }
> +
> +                               notify_invalidate_page(inode, folio, start, end);
> +

Should this be done in batches or done once for all of range [start, end)?

>                                 VM_BUG_ON_FOLIO(folio_test_writeback(folio),
>                                                 folio);
>                                 truncate_inode_folio(mapping, folio);
> @@ -2279,6 +2306,9 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>                 info->flags = flags & VM_NORESERVE;
>                 INIT_LIST_HEAD(&info->shrinklist);
>                 INIT_LIST_HEAD(&info->swaplist);
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +               memfile_notifier_list_init(&info->memfile_notifiers);
> +#endif
>                 simple_xattrs_init(&info->xattrs);
>                 cache_no_acl(inode);
>                 mapping_set_large_folios(inode->i_mapping);
> @@ -2802,6 +2832,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>         if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
>                 i_size_write(inode, offset + len);
>         inode->i_ctime = current_time(inode);
> +       notify_fallocate(inode, start, end);
>  undone:
>         spin_lock(&inode->i_lock);
>         inode->i_private = NULL;
> @@ -3909,6 +3940,47 @@ static struct file_system_type shmem_fs_type = {
>         .fs_flags       = FS_USERNS_MOUNT,
>  };
>
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +static long shmem_get_lock_pfn(struct inode *inode, pgoff_t offset, int *order)
> +{
> +       struct page *page;
> +       int ret;
> +
> +       ret = shmem_getpage(inode, offset, &page, SGP_NOALLOC);
> +       if (ret)
> +               return ret;
> +
> +       *order = thp_order(compound_head(page));
> +
> +       return page_to_pfn(page);
> +}
> +
> +static void shmem_put_unlock_pfn(unsigned long pfn)
> +{
> +       struct page *page = pfn_to_page(pfn);
> +
> +       VM_BUG_ON_PAGE(!PageLocked(page), page);
> +
> +       set_page_dirty(page);
> +       unlock_page(page);
> +       put_page(page);
> +}
> +
> +static struct memfile_notifier_list* shmem_get_notifier_list(struct inode *inode)
> +{
> +       if (!shmem_mapping(inode->i_mapping))
> +               return NULL;
> +
> +       return  &SHMEM_I(inode)->memfile_notifiers;
> +}
> +
> +static struct memfile_backing_store shmem_backing_store = {
> +       .pfn_ops.get_lock_pfn = shmem_get_lock_pfn,
> +       .pfn_ops.put_unlock_pfn = shmem_put_unlock_pfn,
> +       .get_notifier_list = shmem_get_notifier_list,
> +};
> +#endif /* CONFIG_MEMFILE_NOTIFIER */
> +
>  int __init shmem_init(void)
>  {
>         int error;
> @@ -3934,6 +4006,10 @@ int __init shmem_init(void)
>         else
>                 shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
>  #endif
> +
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +       memfile_register_backing_store(&shmem_backing_store);
> +#endif
>         return 0;
>
>  out1:
> --
> 2.17.1
>
