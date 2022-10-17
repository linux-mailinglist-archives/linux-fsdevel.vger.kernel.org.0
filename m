Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7961A601B92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 23:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJQV45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 17:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiJQV44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:56:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B777C604B4;
        Mon, 17 Oct 2022 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666043815; x=1697579815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+DTNPAffPPvJd+GNSv7BeFveo34E4B6ZbDE8a3YpK5s=;
  b=IWrDNptf3+iZ2vmKdCe+BE6xGi30LY4kbfjb/7RAgbYVaIdxteLwZaN8
   qxrb6wlKI2gh716uY0Ph1jSeHGDf0iK/SZ2ZmTigzOhf2CPocbcWx3NwM
   VMuGBmiUBGWw/+YfFlwvOzyIF0fVLdojpHt0SxqC1nqiycUH14dPWLv7g
   7nTybIc52FYrdxf8SWmIHf40z5EzMqMCrWDJNlJxw7uJbJDx0HdTqx2hc
   qhfjq/WuUl6UjAnFG2EMqD2+mx0ynl9kSraQiyVPFGIkSYsjMiYIPQGkW
   IXogcNQamdnWV4scimBkiysdN0XHmeY2cCxwFwe0d7ykH+2DqxiZDfRgF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="370128247"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="370128247"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 14:56:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="803493914"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="803493914"
Received: from dludovic-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.44.179])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 14:56:43 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 068F6104611; Tue, 18 Oct 2022 00:56:41 +0300 (+03)
Date:   Tue, 18 Oct 2022 00:56:40 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <20221017215640.hobzcz47es7dq2bi@box.shutemov.name>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <de680280-f6b1-9337-2ae4-4b2faf2b823b@suse.cz>
 <20221017161955.t4gditaztbwijgcn@box.shutemov.name>
 <c63ad0cd-d517-0f1e-59e9-927d8ae15a1a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63ad0cd-d517-0f1e-59e9-927d8ae15a1a@amd.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 06:39:06PM +0200, Gupta, Pankaj wrote:
> On 10/17/2022 6:19 PM, Kirill A . Shutemov wrote:
> > On Mon, Oct 17, 2022 at 03:00:21PM +0200, Vlastimil Babka wrote:
> > > On 9/15/22 16:29, Chao Peng wrote:
> > > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > > 
> > > > KVM can use memfd-provided memory for guest memory. For normal userspace
> > > > accessible memory, KVM userspace (e.g. QEMU) mmaps the memfd into its
> > > > virtual address space and then tells KVM to use the virtual address to
> > > > setup the mapping in the secondary page table (e.g. EPT).
> > > > 
> > > > With confidential computing technologies like Intel TDX, the
> > > > memfd-provided memory may be encrypted with special key for special
> > > > software domain (e.g. KVM guest) and is not expected to be directly
> > > > accessed by userspace. Precisely, userspace access to such encrypted
> > > > memory may lead to host crash so it should be prevented.
> > > > 
> > > > This patch introduces userspace inaccessible memfd (created with
> > > > MFD_INACCESSIBLE). Its memory is inaccessible from userspace through
> > > > ordinary MMU access (e.g. read/write/mmap) but can be accessed via
> > > > in-kernel interface so KVM can directly interact with core-mm without
> > > > the need to map the memory into KVM userspace.
> > > > 
> > > > It provides semantics required for KVM guest private(encrypted) memory
> > > > support that a file descriptor with this flag set is going to be used as
> > > > the source of guest memory in confidential computing environments such
> > > > as Intel TDX/AMD SEV.
> > > > 
> > > > KVM userspace is still in charge of the lifecycle of the memfd. It
> > > > should pass the opened fd to KVM. KVM uses the kernel APIs newly added
> > > > in this patch to obtain the physical memory address and then populate
> > > > the secondary page table entries.
> > > > 
> > > > The userspace inaccessible memfd can be fallocate-ed and hole-punched
> > > > from userspace. When hole-punching happens, KVM can get notified through
> > > > inaccessible_notifier it then gets chance to remove any mapped entries
> > > > of the range in the secondary page tables.
> > > > 
> > > > The userspace inaccessible memfd itself is implemented as a shim layer
> > > > on top of real memory file systems like tmpfs/hugetlbfs but this patch
> > > > only implemented tmpfs. The allocated memory is currently marked as
> > > > unmovable and unevictable, this is required for current confidential
> > > > usage. But in future this might be changed.
> > > > 
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > > ---
> > > 
> > > ...
> > > 
> > > > +static long inaccessible_fallocate(struct file *file, int mode,
> > > > +				   loff_t offset, loff_t len)
> > > > +{
> > > > +	struct inaccessible_data *data = file->f_mapping->private_data;
> > > > +	struct file *memfd = data->memfd;
> > > > +	int ret;
> > > > +
> > > > +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> > > > +		if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> > > > +			return -EINVAL;
> > > > +	}
> > > > +
> > > > +	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> > > > +	inaccessible_notifier_invalidate(data, offset, offset + len);
> > > 
> > > Wonder if invalidate should precede the actual hole punch, otherwise we open
> > > a window where the page tables point to memory no longer valid?
> > 
> > Yes, you are right. Thanks for catching this.
> 
> I also noticed this. But then thought the memory would be anyways zeroed
> (hole punched) before this call?

Hole punching can free pages, given that offset/len covers full page.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
