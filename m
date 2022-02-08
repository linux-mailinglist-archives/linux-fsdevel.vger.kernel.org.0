Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4034AE0CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 19:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384940AbiBHSaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 13:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbiBHSaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:30:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187D9C061576;
        Tue,  8 Feb 2022 10:30:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 826EB60C03;
        Tue,  8 Feb 2022 18:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE202C004E1;
        Tue,  8 Feb 2022 18:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644345012;
        bh=K1+hCMMTsSLAKEwPC2EsRQPw6UUAUoQD7/b994l5uXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hU0/lVYyJT31vQOIQHTGA9EAF5MsH0yBJrrzVhzs5zFaILZgEK67dSeqfC+QFLTOv
         wDEHu/wGnGQw/izyM8f2rVPRjKCmfSIBJWN6OXDQqz9FlGcsE9HTE8xL9T+wK1nCqo
         VYSc96T4yxQHoazACG8qE7ItaZZ0/+e5f4t9qECopa0WKxq14XUpwujb/465+ADL4l
         ZrqaO8XGD1kFMx77cphrzAUlOLE0AJ1YRnylOk654H7ZFivYUhkhnpZdMA+z4jUb9o
         osb53N7WGxlLdzYzz0RvOz0lLWVajHKxZvJpjtYwCPk76/Ufz4GDZ4WuwK6HIcASMh
         DEm/eb7KgyCbQ==
Date:   Tue, 8 Feb 2022 20:29:56 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v4 04/12] mm/shmem: Support memfile_notifier
Message-ID: <YgK2pDB34AsqCHd0@kernel.org>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-5-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118132121.31388-5-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, Jan 18, 2022 at 09:21:13PM +0800, Chao Peng wrote:
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
>  include/linux/shmem_fs.h |  4 ++
>  mm/memfile_notifier.c    | 12 +++++-
>  mm/shmem.c               | 81 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 166158b6e917..461633587eaf 100644
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
> @@ -24,6 +25,9 @@ struct shmem_inode_info {
>  	struct shared_policy	policy;		/* NUMA memory alloc policy */
>  	struct simple_xattrs	xattrs;		/* list of xattrs */
>  	atomic_t		stop_eviction;	/* hold when working on inode */
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +	struct memfile_notifier_list memfile_notifiers;
> +#endif
>  	struct inode		vfs_inode;
>  };
>  
> diff --git a/mm/memfile_notifier.c b/mm/memfile_notifier.c
> index 8171d4601a04..b4699cbf629e 100644
> --- a/mm/memfile_notifier.c
> +++ b/mm/memfile_notifier.c
> @@ -41,11 +41,21 @@ void memfile_notifier_fallocate(struct memfile_notifier_list *list,
>  	srcu_read_unlock(&srcu, id);
>  }
>  
> +#ifdef CONFIG_SHMEM
> +extern int shmem_get_memfile_notifier_info(struct inode *inode,
> +					struct memfile_notifier_list **list,
> +					struct memfile_pfn_ops **ops);
> +#endif
> +
>  static int memfile_get_notifier_info(struct inode *inode,
>  				     struct memfile_notifier_list **list,
>  				     struct memfile_pfn_ops **ops)
>  {
> -	return -EOPNOTSUPP;
> +	int ret = -EOPNOTSUPP;
> +#ifdef CONFIG_SHMEM
> +	ret = shmem_get_memfile_notifier_info(inode, list, ops);
> +#endif

This looks backwards. Can we have some register method for memory backing
store and call it from shmem.c?

> +	return ret;
>  }
>  
>  int memfile_register_notifier(struct inode *inode,

-- 
Sincerely yours,
Mike.
