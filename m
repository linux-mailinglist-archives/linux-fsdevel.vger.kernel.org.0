Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D4565FE3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 10:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjAFJqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 04:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjAFJqO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:46:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C3A625DC;
        Fri,  6 Jan 2023 01:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672998265; x=1704534265;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=fhXY6C/6U5im9JnhiBqmPE5GvqslI6HKlZc88plC8HU=;
  b=LCw2qM+/WlOf86kBXpCK6162AEhGv7KRqM1qPg0uofFdNn20fjPQJwKO
   V6aYMzKzdtlnEh1Z5C7X54efd3WfmAW37qDCUDsspLCXBGZoloyjJU2U4
   9bgMJjXrdcNUx9ilcP9N7LnBZ20ANVWcuwB/Kl9uqJYF7TjF9XkoPsJRU
   UyqlpEaJ03UIT2QJ0sBOxSljSyyZpNnzkoxZ0cH7KfjzdXvdk/0/32H39
   vY7hM2ZeyHuwy3FNmJxfjbQL6ssl62qAnLO8bLgZKGA6I7iKkP8VWdqpk
   YnM5LjRrXip4R0EhqPG+fBxHenJu/jdm3l/O7q6RMr2D3o7yWqefhmMw0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="320148916"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="320148916"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 01:44:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="901237278"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="901237278"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jan 2023 01:44:12 -0800
Date:   Fri, 6 Jan 2023 17:40:00 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
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
Subject: Re: [PATCH v10 3/9] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20230106094000.GA2297836@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
 <Y7azFdnnGAdGPqmv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7azFdnnGAdGPqmv@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 05, 2023 at 11:23:01AM +0000, Jarkko Sakkinen wrote:
> On Fri, Dec 02, 2022 at 02:13:41PM +0800, Chao Peng wrote:
> > In memory encryption usage, guest memory may be encrypted with special
> > key and can be accessed only by the guest itself. We call such memory
> > private memory. It's valueless and sometimes can cause problem to allow
> > userspace to access guest private memory. This new KVM memslot extension
> > allows guest private memory being provided through a restrictedmem
> > backed file descriptor(fd) and userspace is restricted to access the
> > bookmarked memory in the fd.
> > 
> > This new extension, indicated by the new flag KVM_MEM_PRIVATE, adds two
> > additional KVM memslot fields restricted_fd/restricted_offset to allow
> > userspace to instruct KVM to provide guest memory through restricted_fd.
> > 'guest_phys_addr' is mapped at the restricted_offset of restricted_fd
> > and the size is 'memory_size'.
> > 
> > The extended memslot can still have the userspace_addr(hva). When use, a
> > single memslot can maintain both private memory through restricted_fd
> > and shared memory through userspace_addr. Whether the private or shared
> > part is visible to guest is maintained by other KVM code.
> > 
> > A restrictedmem_notifier field is also added to the memslot structure to
> > allow the restricted_fd's backing store to notify KVM the memory change,
> > KVM then can invalidate its page table entries or handle memory errors.
> > 
> > Together with the change, a new config HAVE_KVM_RESTRICTED_MEM is added
> > and right now it is selected on X86_64 only.
> > 
> > To make future maintenance easy, internally use a binary compatible
> > alias struct kvm_user_mem_region to handle both the normal and the
> > '_ext' variants.
> 
> Feels bit hacky IMHO, and more like a completely new feature than
> an extension.
> 
> Why not just add a new ioctl? The commit message does not address
> the most essential design here.

Yes, people can always choose to add a new ioctl for this kind of change
and the balance point here is we want to also avoid 'too many ioctls' if
the functionalities are similar.  The '_ext' variant reuses all the
existing fields in the 'normal' variant and most importantly KVM
internally can reuse most of the code. I certainly can add some words in
the commit message to explain this design choice.

Thanks,
Chao
> 
> BR, Jarkko
