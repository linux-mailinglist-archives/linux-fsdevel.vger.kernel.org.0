Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CE14D0323
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243862AbiCGPnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbiCGPnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:43:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F33475E71;
        Mon,  7 Mar 2022 07:42:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8550210E9;
        Mon,  7 Mar 2022 15:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646667728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZUTivFJePfyCz85okn550yujg3K57yIFElsl/vVWig=;
        b=IZ2X4cEtBAxNFB6H08Ex+X60hrBCSVM4wolqLIm2L2EqydCfRCN7tzlMprpYmfD70fygGL
        nN7hZnMMfuOwBlKfpmqSCj7zCNUWKA/CwZept5p8b2Xd1JQ0RJMMo5NAIMzuPv2hcMZ0jU
        lnbZ+1+VErZHURmzu2MXgd6jv2YGpvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646667728;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZUTivFJePfyCz85okn550yujg3K57yIFElsl/vVWig=;
        b=NA4ARugU2jFvmNBk3+44mlkj1m3/UJDpBeSXPl1p02r6/bhVDBxaP2SiDQGGKWjJGCcJIB
        UY25+RP21PA9Z7BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D27513B5E;
        Mon,  7 Mar 2022 15:42:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rvTZGdAnJmKcLwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 07 Mar 2022 15:42:08 +0000
Message-ID: <9ac9a88f-54b4-a49f-0857-c3094d3e0d2b@suse.cz>
Date:   Mon, 7 Mar 2022 16:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-4-chao.p.peng@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 03/12] mm: Introduce memfile_notifier
In-Reply-To: <20220118132121.31388-4-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/18/22 14:21, Chao Peng wrote:
> This patch introduces memfile_notifier facility so existing memory file
> subsystems (e.g. tmpfs/hugetlbfs) can provide memory pages to allow a
> third kernel component to make use of memory bookmarked in the memory
> file and gets notified when the pages in the memory file become
> allocated/invalidated.
> 
> It will be used for KVM to use a file descriptor as the guest memory
> backing store and KVM will use this memfile_notifier interface to
> interact with memory file subsystems. In the future there might be other
> consumers (e.g. VFIO with encrypted device memory).
> 
> It consists two sets of callbacks:
>   - memfile_notifier_ops: callbacks for memory backing store to notify
>     KVM when memory gets allocated/invalidated.
>   - memfile_pfn_ops: callbacks for KVM to call into memory backing store
>     to request memory pages for guest private memory.
> 
> Userspace is in charge of guest memory lifecycle: it first allocates
> pages in memory backing store and then passes the fd to KVM and lets KVM
> register each memory slot to memory backing store via
> memfile_register_notifier.
> 
> The supported memory backing store should maintain a memfile_notifier list
> and provide routine for memfile_notifier to get the list head address and
> memfile_pfn_ops callbacks for memfile_register_notifier. It also should call
> memfile_notifier_fallocate/memfile_notifier_invalidate when the bookmarked
> memory gets allocated/invalidated.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Process nitpick:
Here and in patch 4/12 you have Kirill's S-o-b so there should probably be
also "From: Kirill ..." as was in v3? Or in case you modified the original
patches so much to become the primary author, you should add
"Co-developed-by: Kirill ..." here before his S-o-b.

> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/linux/memfile_notifier.h | 53 +++++++++++++++++++
>  mm/Kconfig                       |  4 ++
>  mm/Makefile                      |  1 +
>  mm/memfile_notifier.c            | 89 ++++++++++++++++++++++++++++++++
>  4 files changed, 147 insertions(+)
>  create mode 100644 include/linux/memfile_notifier.h
>  create mode 100644 mm/memfile_notifier.c
> 
> diff --git a/include/linux/memfile_notifier.h b/include/linux/memfile_notifier.h
> new file mode 100644
> index 000000000000..a03bebdd1322
> --- /dev/null
> +++ b/include/linux/memfile_notifier.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_MEMFILE_NOTIFIER_H
> +#define _LINUX_MEMFILE_NOTIFIER_H
> +
> +#include <linux/rculist.h>
> +#include <linux/spinlock.h>
> +#include <linux/srcu.h>
> +#include <linux/fs.h>
> +
> +struct memfile_notifier;
> +
> +struct memfile_notifier_ops {
> +	void (*invalidate)(struct memfile_notifier *notifier,
> +			   pgoff_t start, pgoff_t end);
> +	void (*fallocate)(struct memfile_notifier *notifier,
> +			  pgoff_t start, pgoff_t end);
> +};
> +
> +struct memfile_pfn_ops {
> +	long (*get_lock_pfn)(struct inode *inode, pgoff_t offset, int *order);
> +	void (*put_unlock_pfn)(unsigned long pfn);
> +};
> +
> +struct memfile_notifier {
> +	struct list_head list;
> +	struct memfile_notifier_ops *ops;
> +};
> +
> +struct memfile_notifier_list {
> +	struct list_head head;
> +	spinlock_t lock;
> +};
> +
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +static inline void memfile_notifier_list_init(struct memfile_notifier_list *list)
> +{
> +	INIT_LIST_HEAD(&list->head);
> +	spin_lock_init(&list->lock);
> +}
> +
> +extern void memfile_notifier_invalidate(struct memfile_notifier_list *list,
> +					pgoff_t start, pgoff_t end);
> +extern void memfile_notifier_fallocate(struct memfile_notifier_list *list,
> +				       pgoff_t start, pgoff_t end);
> +extern int memfile_register_notifier(struct inode *inode,
> +				     struct memfile_notifier *notifier,
> +				     struct memfile_pfn_ops **pfn_ops);
> +extern void memfile_unregister_notifier(struct inode *inode,
> +					struct memfile_notifier *notifier);
> +
> +#endif /* CONFIG_MEMFILE_NOTIFIER */
> +
> +#endif /* _LINUX_MEMFILE_NOTIFIER_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 28edafc820ad..fa31eda3c895 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -900,6 +900,10 @@ config IO_MAPPING
>  config SECRETMEM
>  	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
>  
> +config MEMFILE_NOTIFIER
> +	bool
> +	select SRCU
> +
>  source "mm/damon/Kconfig"
>  
>  endmenu
> diff --git a/mm/Makefile b/mm/Makefile
> index d6c0042e3aa0..80588f7c3bc2 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -130,3 +130,4 @@ obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
>  obj-$(CONFIG_IO_MAPPING) += io-mapping.o
>  obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
>  obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
> +obj-$(CONFIG_MEMFILE_NOTIFIER) += memfile_notifier.o
> diff --git a/mm/memfile_notifier.c b/mm/memfile_notifier.c
> new file mode 100644
> index 000000000000..8171d4601a04
> --- /dev/null
> +++ b/mm/memfile_notifier.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  linux/mm/memfile_notifier.c
> + *
> + *  Copyright (C) 2022  Intel Corporation.
> + *             Chao Peng <chao.p.peng@linux.intel.com>
> + */
> +
> +#include <linux/memfile_notifier.h>
> +#include <linux/srcu.h>
> +
> +DEFINE_STATIC_SRCU(srcu);
> +
> +void memfile_notifier_invalidate(struct memfile_notifier_list *list,
> +				 pgoff_t start, pgoff_t end)
> +{
> +	struct memfile_notifier *notifier;
> +	int id;
> +
> +	id = srcu_read_lock(&srcu);
> +	list_for_each_entry_srcu(notifier, &list->head, list,
> +				 srcu_read_lock_held(&srcu)) {
> +		if (notifier->ops && notifier->ops->invalidate)
> +			notifier->ops->invalidate(notifier, start, end);
> +	}
> +	srcu_read_unlock(&srcu, id);
> +}
> +
> +void memfile_notifier_fallocate(struct memfile_notifier_list *list,
> +				pgoff_t start, pgoff_t end)
> +{
> +	struct memfile_notifier *notifier;
> +	int id;
> +
> +	id = srcu_read_lock(&srcu);
> +	list_for_each_entry_srcu(notifier, &list->head, list,
> +				 srcu_read_lock_held(&srcu)) {
> +		if (notifier->ops && notifier->ops->fallocate)
> +			notifier->ops->fallocate(notifier, start, end);
> +	}
> +	srcu_read_unlock(&srcu, id);
> +}
> +
> +static int memfile_get_notifier_info(struct inode *inode,
> +				     struct memfile_notifier_list **list,
> +				     struct memfile_pfn_ops **ops)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +int memfile_register_notifier(struct inode *inode,
> +			      struct memfile_notifier *notifier,
> +			      struct memfile_pfn_ops **pfn_ops)
> +{
> +	struct memfile_notifier_list *list;
> +	int ret;
> +
> +	if (!inode || !notifier | !pfn_ops)
> +		return -EINVAL;
> +
> +	ret = memfile_get_notifier_info(inode, &list, pfn_ops);
> +	if (ret)
> +		return ret;
> +
> +	spin_lock(&list->lock);
> +	list_add_rcu(&notifier->list, &list->head);
> +	spin_unlock(&list->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(memfile_register_notifier);
> +
> +void memfile_unregister_notifier(struct inode *inode,
> +				 struct memfile_notifier *notifier)
> +{
> +	struct memfile_notifier_list *list;
> +
> +	if (!inode || !notifier)
> +		return;
> +
> +	BUG_ON(memfile_get_notifier_info(inode, &list, NULL));
> +
> +	spin_lock(&list->lock);
> +	list_del_rcu(&notifier->list);
> +	spin_unlock(&list->lock);
> +
> +	synchronize_srcu(&srcu);
> +}
> +EXPORT_SYMBOL_GPL(memfile_unregister_notifier);

