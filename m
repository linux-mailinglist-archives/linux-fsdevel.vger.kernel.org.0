Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B27463C1C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 15:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiK2OFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 09:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiK2OFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:05:19 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DD85D690;
        Tue, 29 Nov 2022 06:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669730707; x=1701266707;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=CqOGW8Zm184KDMv0CHU80C03eQzUbVrHdpSNa5YjJCg=;
  b=e3cA7wEtcBbLJtX7B4+pF4gn/L60TEPpPOdBg46I5zkwfOxaFXLtHtEe
   BYe5+GsDObd0VQV/LJL2vVrxLJuqPvsVDHs5r6KGdIRcjBvODAyLhawyC
   Bm2CDm14TP3in5cXNQCNKGPH8GOhlA/Kc1b9v2Q8TWiy+wbK6u+RJNn8i
   S/uzXv2QBeU8ZDdUllScASEpAWVK9zOHNqjeqh4kkECAVbk2gN8H/d7aE
   faa9kw1xwA4NF4ItENz5OcM1ZZFey5NIJqmSUMuiMhs7M2xdLPxlt9pvm
   vFGjUdoQaaHDSOmuEK/G1z1a2Uet7XVIp8iFYTMVGFdjCiWlVUTN3MHGJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="316948610"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="316948610"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 06:04:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="707221830"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="707221830"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 29 Nov 2022 06:04:07 -0800
Date:   Tue, 29 Nov 2022 21:59:46 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
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
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        tabba@google.com, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221129135946.GB902164@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221129000632.sz6pobh6p7teouiu@amd.com>
 <20221129112139.usp6dqhbih47qpjl@box.shutemov.name>
 <6d7f7775-5703-c27a-e57b-03aafb4de712@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d7f7775-5703-c27a-e57b-03aafb4de712@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 29, 2022 at 12:39:06PM +0100, David Hildenbrand wrote:
> On 29.11.22 12:21, Kirill A. Shutemov wrote:
> > On Mon, Nov 28, 2022 at 06:06:32PM -0600, Michael Roth wrote:
> > > On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
> > > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > > 
> > > 
> > > <snip>
> > > 
> > > > +static struct file *restrictedmem_file_create(struct file *memfd)
> > > > +{
> > > > +	struct restrictedmem_data *data;
> > > > +	struct address_space *mapping;
> > > > +	struct inode *inode;
> > > > +	struct file *file;
> > > > +
> > > > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > > > +	if (!data)
> > > > +		return ERR_PTR(-ENOMEM);
> > > > +
> > > > +	data->memfd = memfd;
> > > > +	mutex_init(&data->lock);
> > > > +	INIT_LIST_HEAD(&data->notifiers);
> > > > +
> > > > +	inode = alloc_anon_inode(restrictedmem_mnt->mnt_sb);
> > > > +	if (IS_ERR(inode)) {
> > > > +		kfree(data);
> > > > +		return ERR_CAST(inode);
> > > > +	}
> > > > +
> > > > +	inode->i_mode |= S_IFREG;
> > > > +	inode->i_op = &restrictedmem_iops;
> > > > +	inode->i_mapping->private_data = data;
> > > > +
> > > > +	file = alloc_file_pseudo(inode, restrictedmem_mnt,
> > > > +				 "restrictedmem", O_RDWR,
> > > > +				 &restrictedmem_fops);
> > > > +	if (IS_ERR(file)) {
> > > > +		iput(inode);
> > > > +		kfree(data);
> > > > +		return ERR_CAST(file);
> > > > +	}
> > > > +
> > > > +	file->f_flags |= O_LARGEFILE;
> > > > +
> > > > +	mapping = memfd->f_mapping;
> > > > +	mapping_set_unevictable(mapping);
> > > > +	mapping_set_gfp_mask(mapping,
> > > > +			     mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);
> > > 
> > > Is this supposed to prevent migration of pages being used for
> > > restrictedmem/shmem backend?
> > 
> > Yes, my bad. I expected it to prevent migration, but it is not true.
> 
> Maybe add a comment that these pages are not movable and we don't want to
> place them into movable pageblocks (including CMA and ZONE_MOVABLE). That's
> the primary purpose of the GFP mask here.

Yes I can do that.

Chao
> 
> -- 
> Thanks,
> 
> David / dhildenb
