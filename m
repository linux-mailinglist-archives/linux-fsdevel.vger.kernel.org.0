Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078B46A1665
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 06:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjBXFuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 00:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBXFut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 00:50:49 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519B75D469;
        Thu, 23 Feb 2023 21:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677217847; x=1708753847;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=V5pIfvtAVZdi4oFKptzL072SqpQseaciK4VwcTkzV+I=;
  b=Cyp6qrE1loekRxb4+d/NJxSg5WhevzUG2zSzU1Pg89OI1LKtpWuW+/b+
   POGp4DTcniUcrauEiltBTWi7uIpHE/z4GwAXjs0x3GA2ECMTqyt/uI/F9
   lh54A3qYHOuzK44QXBGcIcqJCe9QhtnFiCDz7zKWsoeEfyqNgHuUDexz2
   NwxQqQxqlCnt0FuHkGYkHefCkQHEf1StgOjwp6cnz2GWJ3V2YA2ZYlm9Q
   b0yf5xJr2P8vsJa7WpTqXKXZcbuinmzIf6WYIPJSQDENNN+0xc9keJJa5
   gGLtwSzM7gaKkN+eAMtGljDeqkP3W03P3ufRaxmvMZU7JzRHub3kMVUHy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="419636439"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="419636439"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 21:50:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="741550783"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="741550783"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by fmsmga004.fm.intel.com with ESMTP; 23 Feb 2023 21:50:36 -0800
Date:   Fri, 24 Feb 2023 13:42:56 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20230224054256.GA1701111@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <Y8HTITl1+Oe0H7Gd@google.com>
 <7555a235-76be-abf5-075a-80dbe6f1ea8e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7555a235-76be-abf5-075a-80dbe6f1ea8e@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > int restrictedmem_bind(struct file *file, pgoff_t start, pgoff_t end,
> > 		       struct restrictedmem_notifier *notifier, bool exclusive)
> > {
> > 	struct restrictedmem *rm = file->f_mapping->private_data;
> > 	int ret = -EINVAL;
> > 
> > 	down_write(&rm->lock);
> > 
> > 	/* Non-exclusive mappings are not yet implemented. */
> > 	if (!exclusive)
> > 		goto out_unlock;
> > 
> > 	if (!xa_empty(&rm->bindings)) {
> > 		if (exclusive != rm->exclusive)
> > 			goto out_unlock;
> > 
> > 		if (exclusive && xa_find(&rm->bindings, &start, end, XA_PRESENT))
> > 			goto out_unlock;
> > 	}
> > 
> > 	xa_store_range(&rm->bindings, start, end, notifier, GFP_KERNEL);
> 
> 
> || ld: mm/restrictedmem.o: in function `restrictedmem_bind':
> mm/restrictedmem.c|295| undefined reference to `xa_store_range'

Right, xa_store_range() is only available for XARRAY_MULTI.

> 
> 
> This is missing:
> ===
> diff --git a/mm/Kconfig b/mm/Kconfig
> index f952d0172080..03aca542c0da 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1087,6 +1087,7 @@ config SECRETMEM
>  config RESTRICTEDMEM
>         bool
>         depends on TMPFS
> +       select XARRAY_MULTI
> ===
> 
> Thanks,
> 
> 
> 
> > 	rm->exclusive = exclusive;
> > 	ret = 0;
> > out_unlock:
> > 	up_write(&rm->lock);
> > 	return ret;
> > }
> > EXPORT_SYMBOL_GPL(restrictedmem_bind);
> > 
> > void restrictedmem_unbind(struct file *file, pgoff_t start, pgoff_t end,
> > 			  struct restrictedmem_notifier *notifier)
> > {
> > 	struct restrictedmem *rm = file->f_mapping->private_data;
> > 
> > 	down_write(&rm->lock);
> > 	xa_store_range(&rm->bindings, start, end, NULL, GFP_KERNEL);
> > 	synchronize_rcu();
> > 	up_write(&rm->lock);
> > }
> > EXPORT_SYMBOL_GPL(restrictedmem_unbind);
> 
> -- 
> Alexey
