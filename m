Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFFD4C11E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 12:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbiBWLuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 06:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbiBWLua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:50:30 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30FA1AF0E;
        Wed, 23 Feb 2022 03:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645617002; x=1677153002;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=h059MTs1GCpelszK6wn0Y7AYm7QzLTn2WIrQltgpYTY=;
  b=nRRHW7f03jxQyNdvkoUZh5f8aLof2IJfkPM3Gi1QJoyN2RDvBK/HO2Qj
   vVuK3qlBD5KhKq4NfK9bwruNXAohTAfX4eWqfz/ko1TTVt0bjobwaVx+K
   hDmJYTV2qO0aB5hZLX9nASNJO/0yHrnluqRNLmrUITUewsktX3ncG9XHG
   Koj2TPTskERaZTku8Yc9Ry31LMmUMpCaGNlUDqjHIL9+hEqEl9pJ9J3OS
   eplZZIdYBIciiHLrpYBmC4sYjpvRwcNHw8Fuv40a+4RTA3pFD0pDoeRF5
   oWAhpvP41unbXK3PwmVqRUBldnphL2sXAvfmPh/ZvfzwlXixxdQqHJWwh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="239335570"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="239335570"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 03:50:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="532650031"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 23 Feb 2022 03:49:55 -0800
Date:   Wed, 23 Feb 2022 19:49:35 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Linux API <linux-api@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v4 01/12] mm/shmem: Introduce F_SEAL_INACCESSIBLE
Message-ID: <20220223114935.GA53733@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-2-chao.p.peng@linux.intel.com>
 <619547ad-de96-1be9-036b-a7b4e99b09a6@kernel.org>
 <20220217130631.GB32679@chaop.bj.intel.com>
 <2ca78dcb-61d9-4c9d-baa9-955b6f4298bb@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca78dcb-61d9-4c9d-baa9-955b6f4298bb@www.fastmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:09:35AM -0800, Andy Lutomirski wrote:
> On Thu, Feb 17, 2022, at 5:06 AM, Chao Peng wrote:
> > On Fri, Feb 11, 2022 at 03:33:35PM -0800, Andy Lutomirski wrote:
> >> On 1/18/22 05:21, Chao Peng wrote:
> >> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >> > 
> >> > Introduce a new seal F_SEAL_INACCESSIBLE indicating the content of
> >> > the file is inaccessible from userspace through ordinary MMU access
> >> > (e.g., read/write/mmap). However, the file content can be accessed
> >> > via a different mechanism (e.g. KVM MMU) indirectly.
> >> > 
> >> > It provides semantics required for KVM guest private memory support
> >> > that a file descriptor with this seal set is going to be used as the
> >> > source of guest memory in confidential computing environments such
> >> > as Intel TDX/AMD SEV but may not be accessible from host userspace.
> >> > 
> >> > At this time only shmem implements this seal.
> >> > 
> >> 
> >> I don't dislike this *that* much, but I do dislike this. F_SEAL_INACCESSIBLE
> >> essentially transmutes a memfd into a different type of object.  While this
> >> can apparently be done successfully and without races (as in this code),
> >> it's at least awkward.  I think that either creating a special inaccessible
> >> memfd should be a single operation that create the correct type of object or
> >> there should be a clear justification for why it's a two-step process.
> >
> > Now one justification maybe from Stever's comment to patch-00: for ARM
> > usage it can be used with creating a normal memfd, (partially)populate
> > it with initial guest memory content (e.g. firmware), and then
> > F_SEAL_INACCESSIBLE it just before the first time lunch of the guest in
> > KVM (definitely the current code needs to be changed to support that).
> 
> Except we don't allow F_SEAL_INACCESSIBLE on a non-empty file, right?  So this won't work.

Hmm, right, if we set F_SEAL_INACCESSIBLE on a non-empty file, we will 
need to make sure access to existing mmap-ed area should be prevented,
but that is hard.

> 
> In any case, the whole confidential VM initialization story is a bit buddy.  From the earlier emails, it sounds like ARM expects the host to fill in guest memory and measure it.  From my recollection of Intel's scheme (which may well be wrong, and I could easily be confusing it with SGX), TDX instead measures what is essentially a transcript of the series of operations that initializes the VM.  These are fundamentally not the same thing even if they accomplish the same end goal.  For TDX, we unavoidably need an operation (ioctl or similar) that initializes things according to the VM's instructions, and ARM ought to be able to use roughly the same mechanism.

Yes, TDX requires a ioctl. Steven may comment on the ARM part.

Chao
> 
> Also, if we ever get fancy and teach the page allocator about memory with reduced directmap permissions, it may well be more efficient for userspace to shove data into a memfd via ioctl than it is to mmap it and write the data.



