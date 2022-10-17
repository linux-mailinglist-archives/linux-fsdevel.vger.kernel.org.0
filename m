Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81560134F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJQQUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 12:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJQQUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:20:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA74B6C119;
        Mon, 17 Oct 2022 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666023614; x=1697559614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K4vrfLL2l6+gAD4B8xJLdJX5MnNTNVmUNPLnkielra0=;
  b=N7nxCALdyfkB4kjyQpAPG8oGeGiM2N5usrExBdOLiek/UhUGZ31J4gEC
   VPqthDlBSqaSkqrCooUdR1mvD1mDd4MSxuyXJLeuPKAgAl4v2Mio8HTEQ
   gMpjfg6sacyM0rcD1iO951v+8UAjHwz79SELDQ/JMvd/rSl06U5wgp88h
   naGCHhXJmFB1TvRKw5xg6antWgNZZVJTmXgJ026VXgSJBiiDaw5rrDbMy
   ClrYRkTahv9KmlzDG1fLz1IYVPLK83bObIdKibys1iwAlYr6S5A651JVs
   fgnyGyE8eRzglyNyJCM/wI1tcXYIf5O6P+bSDA4Wp3/1iXEQP9m+sqlUy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="370042966"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="370042966"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 09:20:12 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="606182872"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="606182872"
Received: from dludovic-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.44.179])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 09:19:58 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id EC9CB1045CA; Mon, 17 Oct 2022 19:19:55 +0300 (+03)
Date:   Mon, 17 Oct 2022 19:19:55 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
Message-ID: <20221017161955.t4gditaztbwijgcn@box.shutemov.name>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <de680280-f6b1-9337-2ae4-4b2faf2b823b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de680280-f6b1-9337-2ae4-4b2faf2b823b@suse.cz>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 03:00:21PM +0200, Vlastimil Babka wrote:
> On 9/15/22 16:29, Chao Peng wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > KVM can use memfd-provided memory for guest memory. For normal userspace
> > accessible memory, KVM userspace (e.g. QEMU) mmaps the memfd into its
> > virtual address space and then tells KVM to use the virtual address to
> > setup the mapping in the secondary page table (e.g. EPT).
> > 
> > With confidential computing technologies like Intel TDX, the
> > memfd-provided memory may be encrypted with special key for special
> > software domain (e.g. KVM guest) and is not expected to be directly
> > accessed by userspace. Precisely, userspace access to such encrypted
> > memory may lead to host crash so it should be prevented.
> > 
> > This patch introduces userspace inaccessible memfd (created with
> > MFD_INACCESSIBLE). Its memory is inaccessible from userspace through
> > ordinary MMU access (e.g. read/write/mmap) but can be accessed via
> > in-kernel interface so KVM can directly interact with core-mm without
> > the need to map the memory into KVM userspace.
> > 
> > It provides semantics required for KVM guest private(encrypted) memory
> > support that a file descriptor with this flag set is going to be used as
> > the source of guest memory in confidential computing environments such
> > as Intel TDX/AMD SEV.
> > 
> > KVM userspace is still in charge of the lifecycle of the memfd. It
> > should pass the opened fd to KVM. KVM uses the kernel APIs newly added
> > in this patch to obtain the physical memory address and then populate
> > the secondary page table entries.
> > 
> > The userspace inaccessible memfd can be fallocate-ed and hole-punched
> > from userspace. When hole-punching happens, KVM can get notified through
> > inaccessible_notifier it then gets chance to remove any mapped entries
> > of the range in the secondary page tables.
> > 
> > The userspace inaccessible memfd itself is implemented as a shim layer
> > on top of real memory file systems like tmpfs/hugetlbfs but this patch
> > only implemented tmpfs. The allocated memory is currently marked as
> > unmovable and unevictable, this is required for current confidential
> > usage. But in future this might be changed.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> 
> ...
> 
> > +static long inaccessible_fallocate(struct file *file, int mode,
> > +				   loff_t offset, loff_t len)
> > +{
> > +	struct inaccessible_data *data = file->f_mapping->private_data;
> > +	struct file *memfd = data->memfd;
> > +	int ret;
> > +
> > +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> > +		if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> > +			return -EINVAL;
> > +	}
> > +
> > +	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> > +	inaccessible_notifier_invalidate(data, offset, offset + len);
> 
> Wonder if invalidate should precede the actual hole punch, otherwise we open
> a window where the page tables point to memory no longer valid?

Yes, you are right. Thanks for catching this.

> > +	return ret;
> > +}
> > +
> 
> ...
> 
> > +
> > +static struct file_system_type inaccessible_fs = {
> > +	.owner		= THIS_MODULE,
> > +	.name		= "[inaccessible]",
> 
> Dunno where exactly is this name visible, but shouldn't it better be
> "[memfd:inaccessible]"?

Maybe. And skip brackets.

> 
> > +	.init_fs_context = inaccessible_init_fs_context,
> > +	.kill_sb	= kill_anon_super,
> > +};
> > +
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
