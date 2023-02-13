Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7439D6944CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 12:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjBMLnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 06:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBMLnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:43:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9486C9ED0;
        Mon, 13 Feb 2023 03:43:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 28B9E211CE;
        Mon, 13 Feb 2023 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676288594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F//K38rKDr15Jtx1r41i6n+4rX+CROs5Z87l81vvAWI=;
        b=xOuYNLYRu5nLXwQb3gBau7FZPmpWmbfhwaT3PhHnYB7b3o4nqW3SEVKC421SAJlpARPJqc
        hDesbrzZdzuLQEH1SPHURdAjHkhPlDT0AD9wcixHc28oOezpET4UgU2DJVaMYAKj82Icy7
        ii1XMGY+PY5/fA0N9sKFNGIhEFom0V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676288594;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F//K38rKDr15Jtx1r41i6n+4rX+CROs5Z87l81vvAWI=;
        b=VmGErdeWf5NH0PyFaumSvLiOj+Keq7bHUhBfnwW5w9mOSNq+p2R76CoJJ7vjkmkUWDKULm
        LMwZHZhqveqfOoDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EB271391B;
        Mon, 13 Feb 2023 11:43:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mJIKFlEi6mPkJQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Feb 2023 11:43:13 +0000
Message-ID: <b7f61a97-c6d7-4302-d96c-bd1020c603dc@suse.cz>
Date:   Mon, 13 Feb 2023 12:43:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jmattson@google.com" <jmattson@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "tabba@google.com" <tabba@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "qperret@google.com" <qperret@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "vannapurve@google.com" <vannapurve@google.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
 <20221219075313.GB1691829@chaop.bj.intel.com>
 <deba096c85e41c3a15d122f2159986a74b16770f.camel@intel.com>
 <20221220072228.GA1724933@chaop.bj.intel.com>
 <126046ce506df070d57e6fe5ab9c92cdaf4cf9b7.camel@intel.com>
 <20221221133905.GA1766136@chaop.bj.intel.com> <Y6SevJt6XXOsmIBD@google.com>
 <20230123154334.mmbdpniy76zsec5m@box>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230123154334.mmbdpniy76zsec5m@box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23 16:43, Kirill A. Shutemov wrote:
> On Thu, Dec 22, 2022 at 06:15:24PM +0000, Sean Christopherson wrote:
>> On Wed, Dec 21, 2022, Chao Peng wrote:
>> > On Tue, Dec 20, 2022 at 08:33:05AM +0000, Huang, Kai wrote:
>> > > On Tue, 2022-12-20 at 15:22 +0800, Chao Peng wrote:
>> > > > On Mon, Dec 19, 2022 at 08:48:10AM +0000, Huang, Kai wrote:
>> > > > > On Mon, 2022-12-19 at 15:53 +0800, Chao Peng wrote:
>> > > But for non-restricted-mem case, it is correct for KVM to decrease page's
>> > > refcount after setting up mapping in the secondary mmu, otherwise the page will
>> > > be pinned by KVM for normal VM (since KVM uses GUP to get the page).
>> > 
>> > That's true. Actually even true for restrictedmem case, most likely we
>> > will still need the kvm_release_pfn_clean() for KVM generic code. On one
>> > side, other restrictedmem users like pKVM may not require page pinning
>> > at all. On the other side, see below.
>> > 
>> > > 
>> > > So what we are expecting is: for KVM if the page comes from restricted mem, then
>> > > KVM cannot decrease the refcount, otherwise for normal page via GUP KVM should.
>> 
>> No, requiring the user (KVM) to guard against lack of support for page migration
>> in restricted mem is a terrible API.  It's totally fine for restricted mem to not
>> support page migration until there's a use case, but punting the problem to KVM
>> is not acceptable.  Restricted mem itself doesn't yet support page migration,
>> e.g. explosions would occur even if KVM wanted to allow migration since there is
>> no notification to invalidate existing mappings.
> 
> I tried to find a way to hook into migration path from restrictedmem. It
> is not easy because from code-mm PoV the restrictedmem page just yet
> another shmem page.
> 
> It is somewhat dubious, but I think it should be safe to override
> mapping->a_ops for the shmem mapping.
> 
> It also eliminates need in special treatment for the restrictedmem pages
> from memory-failure code.
> 
> shmem_mapping() uses ->a_ops to detect shmem mapping. Modify the
> implementation to still be true for restrictedmem pages.
> 
> Build tested only.
> 
> Any comments?
> 
> diff --git a/include/linux/restrictedmem.h b/include/linux/restrictedmem.h
> index 6fddb08f03cc..73ded3c3bad1 100644
> --- a/include/linux/restrictedmem.h
> +++ b/include/linux/restrictedmem.h
> @@ -36,8 +36,6 @@ static inline bool file_is_restrictedmem(struct file *file)
>  	return file->f_inode->i_sb->s_magic == RESTRICTEDMEM_MAGIC;
>  }
>  
> -void restrictedmem_error_page(struct page *page, struct address_space *mapping);
> -
>  #else
>  
>  static inline bool file_is_restrictedmem(struct file *file)
> @@ -45,11 +43,6 @@ static inline bool file_is_restrictedmem(struct file *file)
>  	return false;
>  }
>  
> -static inline void restrictedmem_error_page(struct page *page,
> -					    struct address_space *mapping)
> -{
> -}
> -
>  #endif /* CONFIG_RESTRICTEDMEM */
>  
>  #endif /* _LINUX_RESTRICTEDMEM_H */
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index d500ea967dc7..a4af160f37e4 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -9,6 +9,7 @@
>  #include <linux/percpu_counter.h>
>  #include <linux/xattr.h>
>  #include <linux/fs_parser.h>
> +#include <linux/magic.h>
>  
>  /* inode in-kernel data */
>  
> @@ -75,10 +76,9 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
>  		unsigned long len, unsigned long pgoff, unsigned long flags);
>  extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
>  #ifdef CONFIG_SHMEM
> -extern const struct address_space_operations shmem_aops;
>  static inline bool shmem_mapping(struct address_space *mapping)
>  {
> -	return mapping->a_ops == &shmem_aops;
> +	return mapping->host->i_sb->s_magic == TMPFS_MAGIC;

Alternatively just check a_ops against two possible values? Fewer chained
dereferences, no-op with !CONFIG_RESTRICTEDMEM, maybe Hugh would be less
unhappy with that.

Besides that, IIRC Michael Roth mentioned that this approach for preventing
migration would be simpler for SNP than the refcount elevation? Do I recall
right and should this be pursued then?

>  }
>  #else
>  static inline bool shmem_mapping(struct address_space *mapping)
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f91b444e471e..145bb561ddb3 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -62,7 +62,6 @@
>  #include <linux/page-isolation.h>
>  #include <linux/pagewalk.h>
>  #include <linux/shmem_fs.h>
> -#include <linux/restrictedmem.h>
>  #include "swap.h"
>  #include "internal.h"
>  #include "ras/ras_event.h"
> @@ -941,8 +940,6 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>  		goto out;
>  	}
>  
> -	restrictedmem_error_page(p, mapping);
> -
>  	/*
>  	 * The shmem page is kept in page cache instead of truncating
>  	 * so is expected to have an extra refcount after error-handling.
> diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> index 15c52301eeb9..d0ca609b82cb 100644
> --- a/mm/restrictedmem.c
> +++ b/mm/restrictedmem.c
> @@ -189,6 +189,51 @@ static struct file *restrictedmem_file_create(struct file *memfd)
>  	return file;
>  }
>  
> +static int restricted_error_remove_page(struct address_space *mapping,
> +					struct page *page)
> +{
> +	struct super_block *sb = restrictedmem_mnt->mnt_sb;
> +	struct inode *inode, *next;
> +	pgoff_t start, end;
> +
> +	start = page->index;
> +	end = start + thp_nr_pages(page);
> +
> +	spin_lock(&sb->s_inode_list_lock);
> +	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
> +		struct restrictedmem *rm = inode->i_mapping->private_data;
> +		struct restrictedmem_notifier *notifier;
> +		struct file *memfd = rm->memfd;
> +		unsigned long index;
> +
> +		if (memfd->f_mapping != mapping)
> +			continue;
> +
> +		xa_for_each_range(&rm->bindings, index, notifier, start, end)
> +			notifier->ops->error(notifier, start, end);
> +		break;
> +	}
> +	spin_unlock(&sb->s_inode_list_lock);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_MIGRATION
> +static int restricted_folio(struct address_space *mapping, struct folio *dst,
> +			    struct folio *src, enum migrate_mode mode)
> +{
> +	return -EBUSY;
> +}
> +#endif
> +
> +static struct address_space_operations restricted_aops = {
> +	.dirty_folio	= noop_dirty_folio,
> +	.error_remove_page = restricted_error_remove_page,
> +#ifdef CONFIG_MIGRATION
> +	.migrate_folio	= restricted_folio,
> +#endif
> +};
> +
>  SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
>  {
>  	struct file *file, *restricted_file;
> @@ -209,6 +254,8 @@ SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
>  	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
>  	file->f_flags |= O_LARGEFILE;
>  
> +	file->f_mapping->a_ops = &restricted_aops;
> +
>  	restricted_file = restrictedmem_file_create(file);
>  	if (IS_ERR(restricted_file)) {
>  		err = PTR_ERR(restricted_file);
> @@ -293,31 +340,3 @@ int restrictedmem_get_page(struct file *file, pgoff_t offset,
>  }
>  EXPORT_SYMBOL_GPL(restrictedmem_get_page);
>  
> -void restrictedmem_error_page(struct page *page, struct address_space *mapping)
> -{
> -	struct super_block *sb = restrictedmem_mnt->mnt_sb;
> -	struct inode *inode, *next;
> -	pgoff_t start, end;
> -
> -	if (!shmem_mapping(mapping))
> -		return;
> -
> -	start = page->index;
> -	end = start + thp_nr_pages(page);
> -
> -	spin_lock(&sb->s_inode_list_lock);
> -	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
> -		struct restrictedmem *rm = inode->i_mapping->private_data;
> -		struct restrictedmem_notifier *notifier;
> -		struct file *memfd = rm->memfd;
> -		unsigned long index;
> -
> -		if (memfd->f_mapping != mapping)
> -			continue;
> -
> -		xa_for_each_range(&rm->bindings, index, notifier, start, end)
> -			notifier->ops->error(notifier, start, end);
> -		break;
> -	}
> -	spin_unlock(&sb->s_inode_list_lock);
> -}
> diff --git a/mm/shmem.c b/mm/shmem.c
> index c1d8b8a1aa3b..3df4d95784b9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -231,7 +231,7 @@ static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
>  }
>  
>  static const struct super_operations shmem_ops;
> -const struct address_space_operations shmem_aops;
> +static const struct address_space_operations shmem_aops;
>  static const struct file_operations shmem_file_operations;
>  static const struct inode_operations shmem_inode_operations;
>  static const struct inode_operations shmem_dir_inode_operations;
> @@ -3894,7 +3894,7 @@ static int shmem_error_remove_page(struct address_space *mapping,
>  	return 0;
>  }
>  
> -const struct address_space_operations shmem_aops = {
> +static const struct address_space_operations shmem_aops = {
>  	.writepage	= shmem_writepage,
>  	.dirty_folio	= noop_dirty_folio,
>  #ifdef CONFIG_TMPFS
> @@ -3906,7 +3906,6 @@ const struct address_space_operations shmem_aops = {
>  #endif
>  	.error_remove_page = shmem_error_remove_page,
>  };
> -EXPORT_SYMBOL(shmem_aops);
>  
>  static const struct file_operations shmem_file_operations = {
>  	.mmap		= shmem_mmap,

