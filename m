Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F4C5BC513
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 11:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiISJM6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 05:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiISJM4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B38324BD9
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 02:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663578771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jxl8dn6mQx+TY+/R8pZqq4F+YYfwiklYX5vSpv2CpI0=;
        b=J5pouKe1VlcV+F1AwRxlmUiVMY1Tb+t0g1cOLkkLtlqKoJVVND10eoYNZ0n92/FnQX4fBK
        ucOWgYT1xE7Lq/ieXh843dFzVgBleccnmtgLgDEOMvcZ4N8v7vrfgxqk/vXE0GGH6zswMn
        s/cjhXkl+5j7u1nFhKGqRmBeqA7u5Gw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-543-PYZTH3CcM1uWu3a434lXVw-1; Mon, 19 Sep 2022 05:12:50 -0400
X-MC-Unique: PYZTH3CcM1uWu3a434lXVw-1
Received: by mail-wr1-f70.google.com with SMTP id g15-20020adfbc8f000000b0022a4510a491so6120277wrh.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 02:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=jxl8dn6mQx+TY+/R8pZqq4F+YYfwiklYX5vSpv2CpI0=;
        b=QEqFu5oKtGJW0DHW1w9KGz1rPB2TLJIQ5jitQP8sPh8nHrWtj1dqF9fkbGFO7AwAbY
         z9qV4Qkj6yGfnW7vcDiknTBblQtx1OO6B7oRfmNmPQcayUptHYkKMB4ROfuSU9NXhQoe
         SOPywNiWpLWOMvFkwzbFcShR2cJIweENGMu7VwuQCa4q4/neXKA8GNr9YxOXMdCxBulo
         Or+ZLIW0tikeBHw6k37X+w4t7LBdZGGRdHZ8lSOCazY2me9PxeQknFWvsBgPygQujXOV
         9Sb+QJDaUQrmZQxHnFHx7s6q7LNFBKzhgiuFQeRU6zMp4U2a00ykd5Uowjhc432p3VXa
         UOUA==
X-Gm-Message-State: ACrzQf2mTWRvwLX8Q42WdnFBxR3Efpbm4+0n9hfJjf4lW9+r7ac0HjGU
        TvAnM66NegRU0cRTAl05pF3+N9uQvlpon/7YLAH3fztc305IB+I2PqM5LET0O3zPAFt24q4sqZ7
        YR5YTytFFBW7vV3W/Jfat1xSaRA==
X-Received: by 2002:a05:600c:434c:b0:3b4:82fb:5f78 with SMTP id r12-20020a05600c434c00b003b482fb5f78mr11569490wme.157.1663578769338;
        Mon, 19 Sep 2022 02:12:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM42ZT4pkoKjyDjQQPF2OgJto1LVpfUrBqi2mVYRAlQ8yoTL+vv0kZdwqQbz4IN8mCzxBGb4fw==
X-Received: by 2002:a05:600c:434c:b0:3b4:82fb:5f78 with SMTP id r12-20020a05600c434c00b003b482fb5f78mr11569468wme.157.1663578768973;
        Mon, 19 Sep 2022 02:12:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:c100:c136:f914:345f:f5f3? (p200300cbc703c100c136f914345ff5f3.dip0.t-ipconnect.de. [2003:cb:c703:c100:c136:f914:345f:f5f3])
        by smtp.gmail.com with ESMTPSA id bk23-20020a0560001d9700b0022b014fb0b7sm2473698wrb.110.2022.09.19.02.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 02:12:48 -0700 (PDT)
Message-ID: <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
Date:   Mon, 19 Sep 2022 11:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
In-Reply-To: <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15.09.22 16:29, Chao Peng wrote:
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

Initially my thaught was that this whole inaccessible thing is TDX 
specific and there is no need to force that on other mechanisms. That's 
why I suggested to not expose this to user space but handle the notifier 
requirements internally.

IIUC now, protected KVM has similar demands. Either access (read/write) 
of guest RAM would result in a fault and possibly crash the hypervisor 
(at least not the whole machine IIUC).

> 
> This patch introduces userspace inaccessible memfd (created with
> MFD_INACCESSIBLE). Its memory is inaccessible from userspace through
> ordinary MMU access (e.g. read/write/mmap) but can be accessed via
> in-kernel interface so KVM can directly interact with core-mm without
> the need to map the memory into KVM userspace.

With secretmem we decided to not add such "concept switch" flags and 
instead use a dedicated syscall.

What about memfd_inaccessible()? Especially, sealing and hugetlb are not 
even supported and it might take a while to support either.


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
>   include/linux/memfd.h      |  24 ++++
>   include/uapi/linux/magic.h |   1 +
>   include/uapi/linux/memfd.h |   1 +
>   mm/Makefile                |   2 +-
>   mm/memfd.c                 |  25 ++++-
>   mm/memfd_inaccessible.c    | 219 +++++++++++++++++++++++++++++++++++++
>   6 files changed, 270 insertions(+), 2 deletions(-)
>   create mode 100644 mm/memfd_inaccessible.c
> 
> diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> index 4f1600413f91..334ddff08377 100644
> --- a/include/linux/memfd.h
> +++ b/include/linux/memfd.h
> @@ -3,6 +3,7 @@
>   #define __LINUX_MEMFD_H
>   
>   #include <linux/file.h>
> +#include <linux/pfn_t.h>
>   
>   #ifdef CONFIG_MEMFD_CREATE
>   extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned long arg);
> @@ -13,4 +14,27 @@ static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned long a)
>   }
>   #endif
>   
> +struct inaccessible_notifier;
> +
> +struct inaccessible_notifier_ops {
> +	void (*invalidate)(struct inaccessible_notifier *notifier,
> +			   pgoff_t start, pgoff_t end);
> +};
> +
> +struct inaccessible_notifier {
> +	struct list_head list;
> +	const struct inaccessible_notifier_ops *ops;
> +};
> +
> +void inaccessible_register_notifier(struct file *file,
> +				    struct inaccessible_notifier *notifier);
> +void inaccessible_unregister_notifier(struct file *file,
> +				      struct inaccessible_notifier *notifier);
> +
> +int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> +			 int *order);
> +void inaccessible_put_pfn(struct file *file, pfn_t pfn);
> +
> +struct file *memfd_mkinaccessible(struct file *memfd);
> +
>   #endif /* __LINUX_MEMFD_H */
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 6325d1d0e90f..9d066be3d7e8 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -101,5 +101,6 @@
>   #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
>   #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
>   #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
> +#define INACCESSIBLE_MAGIC	0x494e4143	/* "INAC" */


[...]

> +
> +int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> +			 int *order)
> +{
> +	struct inaccessible_data *data = file->f_mapping->private_data;
> +	struct file *memfd = data->memfd;
> +	struct page *page;
> +	int ret;
> +
> +	ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
> +	if (ret)
> +		return ret;
> +
> +	*pfn = page_to_pfn_t(page);
> +	*order = thp_order(compound_head(page));
> +	SetPageUptodate(page);
> +	unlock_page(page);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(inaccessible_get_pfn);
> +
> +void inaccessible_put_pfn(struct file *file, pfn_t pfn)
> +{
> +	struct page *page = pfn_t_to_page(pfn);
> +
> +	if (WARN_ON_ONCE(!page))
> +		return;
> +
> +	put_page(page);
> +}
> +EXPORT_SYMBOL_GPL(inaccessible_put_pfn);

Sorry, I missed your reply regarding get/put interface.

https://lore.kernel.org/linux-mm/20220810092532.GD862421@chaop.bj.intel.com/

"We have a design assumption that somedays this can even support 
non-page based backing stores."

As long as there is no such user in sight (especially how to get the 
memfd from even allocating such memory which will require bigger 
changes), I prefer to keep it simple here and work on pages/folios. No 
need to over-complicate it for now.


-- 
Thanks,

David / dhildenb

