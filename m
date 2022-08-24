Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBED59F7AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 12:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbiHXK1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 06:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiHXK0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:26:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513575C364;
        Wed, 24 Aug 2022 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661336751; x=1692872751;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=ov6LWOeGKE0o/d22MV9D8SJ+ovEHwDZEA5oKgTfWHCI=;
  b=ZZmaNVrL9o9DOsJ/T0nrahhlnw7jwtvBqZ/dWgvgwBbUarP2ggwysxKg
   le+275l4+d4mmoGocG31k5ZYGTsEKeO1kgi3Jr6RfMx4VyZVe4jxQ9qzY
   OICxHmWpHLrcEB9hpDsR3dzGmovtDuKahiwUI5sWGZVbU0KgWcXZF1gam
   cd3tB08jYfSPKZldcmsUIgRIS1PSRlqi5qbdK/bcwFIMTdKjpdqY2D/V9
   CBDVnIn+0le6QUBk56pZSRimPklw9Ja+yxKn9Rui0cmFvCiS4dgFR3R5Y
   x8xqAw83d4zwzwzmkpsgIt+I0qffxiqqjSSRKSqWtnOgZvLD5B016QoCC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="294714894"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="294714894"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 03:25:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="605986064"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2022 03:25:39 -0700
Date:   Wed, 24 Aug 2022 18:20:56 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
Message-ID: <20220824102056.GA1385482@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
 <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
 <472207cf-ff71-563b-7b66-0c7bea9ea8ad@redhat.com>
 <20220817234120.mw2j3cgshmuyo2vw@box.shutemov.name>
 <8f6f428b-85e6-a188-7f32-512b6aae0abf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f6f428b-85e6-a188-7f32-512b6aae0abf@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 23, 2022 at 09:36:57AM +0200, David Hildenbrand wrote:
> On 18.08.22 01:41, Kirill A. Shutemov wrote:
> > On Fri, Aug 05, 2022 at 07:55:38PM +0200, Paolo Bonzini wrote:
> >> On 7/21/22 11:44, David Hildenbrand wrote:
> >>>
> >>> Also, I*think*  you can place pages via userfaultfd into shmem. Not
> >>> sure if that would count "auto alloc", but it would certainly bypass
> >>> fallocate().
> >>
> >> Yeah, userfaultfd_register would probably have to forbid this for
> >> F_SEAL_AUTO_ALLOCATE vmas.  Maybe the memfile_node can be reused for this,
> >> adding a new MEMFILE_F_NO_AUTO_ALLOCATE flags?  Then userfault_register
> >> would do something like memfile_node_get_flags(vma->vm_file) and check the
> >> result.
> > 
> > I donno, memory allocation with userfaultfd looks pretty intentional to
> > me. Why would F_SEAL_AUTO_ALLOCATE prevent it?
> > 
> 
> Can't we say the same about a write()?
> 
> > Maybe we would need it in the future for post-copy migration or something?
> > 
> > Or existing practises around userfaultfd touch memory randomly and
> > therefore incompatible with F_SEAL_AUTO_ALLOCATE intent?
> > 
> > Note, that userfaultfd is only relevant for shared memory as it requires
> > VMA which we don't have for MFD_INACCESSIBLE.
> 
> This feature (F_SEAL_AUTO_ALLOCATE) is independent of all the lovely
> encrypted VM stuff, so it doesn't matter how it relates to MFD_INACCESSIBLE.

Right, this patch is for normal user accssible fd. In KVM this flag is
expected to be set on the shared part of the memslot, while all other
patches in this series are for private part of the memslot.

Private memory doesn't have this need because it's totally inaccissible
from userspace so no chance for userspace to write to the fd and cause
allocation by accident. While for shared memory, malicious/buggy guest
OS may cause userspace to write to any range of the shared fd and cause
memory allocation, even that range should the private memory not the
shared memory be visible to guest OS.

Chao
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
