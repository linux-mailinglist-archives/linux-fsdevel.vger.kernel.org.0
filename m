Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD24BA1D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 14:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbiBQNru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 08:47:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241431AbiBQNrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:47:49 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE2AC7C33;
        Thu, 17 Feb 2022 05:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645105655; x=1676641655;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=00jU+EOCM+jaTdG7EhL3AgRMsoum/qW8+F9FVekDncc=;
  b=Y+GDxmtjn9iv1O3+8XGGFByZ3j5rF8sny/cDr1GM85e5pif9DNtlsJ4H
   XYQBG95z6aMsKqtdheJrNOIZvhJ/udJigVA0anXjKXfWuN0HJZ1UOjV3E
   8UcXVe7GRtTf4CIm20F4TbCtvnOgo8+jWzOkUvpdvd5ObrPrklNMfi34I
   l3wrLee+IKrRxiAmcxUOAkOaVI7R20yN/MuxJkTipep9Uoec2OI2s/1Rf
   ILYbYqNn+yGCh+SBEnxnKgvs7JmiuJ1mzynWVdb/xhn8cnE3ZsDq6Kusg
   36VF3fOrmjvYqSLIdlfC3rCemBp5ktgcyypNwF0KoQWlNVuJeGfTb1nVN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="251073528"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="251073528"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 05:47:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="503514098"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga002.jf.intel.com with ESMTP; 17 Feb 2022 05:47:27 -0800
Date:   Thu, 17 Feb 2022 21:47:05 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-api@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v4 00/12] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220217134705.GB33836@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <YgK3buC2xes9/lLj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgK3buC2xes9/lLj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 08, 2022 at 08:33:18PM +0200, Mike Rapoport wrote:
> (addded linux-api)
> 
> On Tue, Jan 18, 2022 at 09:21:09PM +0800, Chao Peng wrote:
> > This is the v4 of this series which try to implement the fd-based KVM
> > guest private memory. The patches are based on latest kvm/queue branch
> > commit:
> > 
> >   fea31d169094 KVM: x86/pmu: Fix available_event_types check for
> >                REF_CPU_CYCLES event
> > 
> > Introduction
> > ------------
> > In general this patch series introduce fd-based memslot which provides
> > guest memory through memory file descriptor fd[offset,size] instead of
> > hva/size. The fd can be created from a supported memory filesystem
> > like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
> > and the the memory backing store exchange callbacks when such memslot
> > gets created. At runtime KVM will call into callbacks provided by the
> > backing store to get the pfn with the fd+offset. Memory backing store
> > will also call into KVM callbacks when userspace fallocate/punch hole
> > on the fd to notify KVM to map/unmap secondary MMU page tables.
> > 
> > Comparing to existing hva-based memslot, this new type of memslot allows
> > guest memory unmapped from host userspace like QEMU and even the kernel
> > itself, therefore reduce attack surface and prevent bugs.
> > 
> > Based on this fd-based memslot, we can build guest private memory that
> > is going to be used in confidential computing environments such as Intel
> > TDX and AMD SEV. When supported, the memory backing store can provide
> > more enforcement on the fd and KVM can use a single memslot to hold both
> > the private and shared part of the guest memory. 
> > 
> > mm extension
> > ---------------------
> > Introduces new F_SEAL_INACCESSIBLE for shmem and new MFD_INACCESSIBLE
> > flag for memfd_create(), the file created with these flags cannot read(),
> > write() or mmap() etc via normal MMU operations. The file content can
> > only be used with the newly introduced memfile_notifier extension.
> 
> It would be great to see man page draft for new ABI flags

Yes I can provide the man page.

Thanks,
Chao
