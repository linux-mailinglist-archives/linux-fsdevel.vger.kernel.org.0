Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F39F57A18E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 16:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbiGSObD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 10:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbiGSO3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:29:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7273161B1F;
        Tue, 19 Jul 2022 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658240264; x=1689776264;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=uCiOnx7XhlhIdPTfR9PaYhGj+08ZCZ+aPucYOLw91eY=;
  b=OzzfxIk0a+IGaEkdENZ8GOJ0xXoWWjSt7xK9IOEN6umzrYBSCDXMqCBV
   aBFucqvgSeS1mk9zaPmZn9Sa+57cbgvT8bwAMNsYP1V0UXwi1pJPFwbZB
   AZdHjoLHdHcgfBBAcVIrfmkeXvlE8YUt7Z37jiR7k4wspDU6D2gXEkPlq
   /1zgyN5PMFKMefTfwqWQ2mzE+QBRsIwrpJ5gULnNtA/9rv++l3JU+5loD
   MSRs4eHjdpdesroG5ym1A71mzr616YEFm8qOIBEBfvralXIkDvcJdXcR3
   JmLhnsDBf0iceZuc6kBwGDg9BtaDjBerWKjWAKV0IUxEzV2hoHmYONnNF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="287247161"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="287247161"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:17:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="655777767"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jul 2022 07:17:33 -0700
Date:   Tue, 19 Jul 2022 22:12:43 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 13/14] KVM: Enable and expose KVM_MEM_PRIVATE
Message-ID: <20220719141243.GB84779@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-14-chao.p.peng@linux.intel.com>
 <de1e15b8-b7e7-d077-eff8-0992bd06e38a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1e15b8-b7e7-d077-eff8-0992bd06e38a@amd.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:55:24AM +0200, Gupta, Pankaj wrote:

...

> > @@ -4712,12 +4813,10 @@ static long kvm_vm_ioctl(struct file *filp,
> >   			(u32 __user *)(argp + offsetof(typeof(mem), flags))))
> >   			goto out;
> > -		if (flags & KVM_MEM_PRIVATE) {
> > -			r = -EINVAL;
> > -			goto out;
> > -		}
> > -
> > -		size = sizeof(struct kvm_userspace_memory_region);
> > +		if (flags & KVM_MEM_PRIVATE)
> > +			size = sizeof(struct kvm_userspace_memory_region_ext);
> 
> Not sure if we use kvm_userspace_memory_region_ext or kvm_user_mem_region,
> just for readability.

Somehow, but majorly for code maintainability, kvm_user_mem_region is
designed to be the alias of kvm_userspace_memory_region_ext so in the
code we can access the 'unpacked' fields using something like
'mem.usersapce_addr' instead of 'mem.region.userspace_addr'.

Chao
> 
> > +		else
> > +			size = sizeof(struct kvm_userspace_memory_region);
> >   		if (copy_from_user(&mem, argp, size))
> >   			goto out;
