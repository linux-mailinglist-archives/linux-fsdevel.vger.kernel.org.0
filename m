Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A845E70FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 02:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiIWA6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 20:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiIWA6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:58:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B8D1114E4;
        Thu, 22 Sep 2022 17:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663894700; x=1695430700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ml+yVLdWFYzsyDqjZioBXvGBweEy273hCGRMNDKeVO8=;
  b=cd/1LyD4UQVamNgO/s0DIDHY0YYMwsxXkU6wVfMS6PVBSRoZfSD1P2Ko
   Vnb1+yy8FZ6WSo25k6uJfqi9OR4R8b0mOeOgtbamZHM9K79UWaEcxEI16
   6iX9z60x98poA+XBv6X7o/QPTdYBsdWWj8k5xg4/9wSLHgxiZAgdWrgtk
   5mEMUtUysJRmxtmJFGIkNKs2cePtum9tu74+Nwz5byEdqLXmnVN5/bh+d
   FVaA44ytENtwrQyqnepff6pxG76WWar4D42MkVbXiKWBs2NmLS9txY5vw
   erguz2zz1ymybWIJUUw05E5/grhuqjbOTm190r1FX8vxytG6Ypc4W9JxJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364488768"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="364488768"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:58:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="615437441"
Received: from dnessim-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.60.183])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:58:10 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5F4F01044E2; Fri, 23 Sep 2022 03:58:08 +0300 (+03)
Date:   Fri, 23 Sep 2022 03:58:08 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Jonathan Corbet <corbet@lwn.net>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        aarcange@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <20220923005808.vfltoecttoatgw5o@box.shutemov.name>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 11:12:46AM +0200, David Hildenbrand wrote:
> > diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> > index 6325d1d0e90f..9d066be3d7e8 100644
> > --- a/include/uapi/linux/magic.h
> > +++ b/include/uapi/linux/magic.h
> > @@ -101,5 +101,6 @@
> >   #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
> >   #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
> >   #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
> > +#define INACCESSIBLE_MAGIC	0x494e4143	/* "INAC" */
> 
> 
> [...]
> 
> > +
> > +int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> > +			 int *order)
> > +{
> > +	struct inaccessible_data *data = file->f_mapping->private_data;
> > +	struct file *memfd = data->memfd;
> > +	struct page *page;
> > +	int ret;
> > +
> > +	ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*pfn = page_to_pfn_t(page);
> > +	*order = thp_order(compound_head(page));
> > +	SetPageUptodate(page);
> > +	unlock_page(page);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(inaccessible_get_pfn);
> > +
> > +void inaccessible_put_pfn(struct file *file, pfn_t pfn)
> > +{
> > +	struct page *page = pfn_t_to_page(pfn);
> > +
> > +	if (WARN_ON_ONCE(!page))
> > +		return;
> > +
> > +	put_page(page);
> > +}
> > +EXPORT_SYMBOL_GPL(inaccessible_put_pfn);
> 
> Sorry, I missed your reply regarding get/put interface.
> 
> https://lore.kernel.org/linux-mm/20220810092532.GD862421@chaop.bj.intel.com/
> 
> "We have a design assumption that somedays this can even support non-page
> based backing stores."
> 
> As long as there is no such user in sight (especially how to get the memfd
> from even allocating such memory which will require bigger changes), I
> prefer to keep it simple here and work on pages/folios. No need to
> over-complicate it for now.

Sean, Paolo , what is your take on this? Do you have conrete use case of
pageless backend for the mechanism in sight? Maybe DAX?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
