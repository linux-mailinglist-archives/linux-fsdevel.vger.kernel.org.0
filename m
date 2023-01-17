Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F0A66DE1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 13:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbjAQMva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 07:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbjAQMui (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:50:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530FF10E7;
        Tue, 17 Jan 2023 04:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673959815; x=1705495815;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=ymQ/JZoVFvqCeW/jz/ISyD5XcjWYygq7yVQJBCOqdNM=;
  b=j91g/xLgfMmOaOIBv18DcJdFvFkQCh8/o8WaQc16LDCL95PIrIp4Wdtt
   C2kfB4zYiMfZ2C2Lh3X0hLs4umqjcCp4lKPZ0Y3NQZj0Qo6FwrZ7qAZpC
   tsi9sN/FV93Ys3QmuHs5+gJOxzgziKjPtC2c0GF8muOdrS5bcQXGeoXQN
   yvLRDvW1zO99FKjAutzWezDEpicuQHVbYyTt4hKw/PFU4yhbf0vjd82pW
   KdVtnqRMWawHZ0uLjJ8Xz5tnb07VABpGddqk427v8YCPKDO8zSqD1h50a
   1GG3t+tZb54ksPxS7ACUnjWL39WCsS5MklGaMzORtFHif/sQE7H59fEZR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="322374485"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="322374485"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 04:50:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="691571557"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="691571557"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by orsmga001.jf.intel.com with ESMTP; 17 Jan 2023 04:50:02 -0800
Date:   Tue, 17 Jan 2023 20:42:14 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, kvm@vger.kernel.org,
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
Subject: Re: [PATCH v10 3/9] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20230117124214.GB273037@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
 <Y7azFdnnGAdGPqmv@kernel.org>
 <20230106094000.GA2297836@chaop.bj.intel.com>
 <Y7xrtf9FCuYRYm1q@google.com>
 <20230110091432.GA2441264@chaop.bj.intel.com>
 <Y8HdMzlNFhFwlkGS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8HdMzlNFhFwlkGS@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 10:37:39PM +0000, Sean Christopherson wrote:
> On Tue, Jan 10, 2023, Chao Peng wrote:
> > On Mon, Jan 09, 2023 at 07:32:05PM +0000, Sean Christopherson wrote:
> > > On Fri, Jan 06, 2023, Chao Peng wrote:
> > > > On Thu, Jan 05, 2023 at 11:23:01AM +0000, Jarkko Sakkinen wrote:
> > > > > On Fri, Dec 02, 2022 at 02:13:41PM +0800, Chao Peng wrote:
> > > > > > To make future maintenance easy, internally use a binary compatible
> > > > > > alias struct kvm_user_mem_region to handle both the normal and the
> > > > > > '_ext' variants.
> > > > > 
> > > > > Feels bit hacky IMHO, and more like a completely new feature than
> > > > > an extension.
> > > > > 
> > > > > Why not just add a new ioctl? The commit message does not address
> > > > > the most essential design here.
> > > > 
> > > > Yes, people can always choose to add a new ioctl for this kind of change
> > > > and the balance point here is we want to also avoid 'too many ioctls' if
> > > > the functionalities are similar.  The '_ext' variant reuses all the
> > > > existing fields in the 'normal' variant and most importantly KVM
> > > > internally can reuse most of the code. I certainly can add some words in
> > > > the commit message to explain this design choice.
> > > 
> > > After seeing the userspace side of this, I agree with Jarkko; overloading
> > > KVM_SET_USER_MEMORY_REGION is a hack.  E.g. the size validation ends up being
> > > bogus, and userspace ends up abusing unions or implementing kvm_user_mem_region
> > > itself.
> > 
> > How is the size validation being bogus? I don't quite follow.
> 
> The ioctl() magic embeds the size of the payload (struct kvm_userspace_memory_region
> in this case) in the ioctl() number, and that information is visible to userspace
> via _IOCTL_SIZE().  Attempting to take a larger size can mess up sanity checks,
> e.g. KVM selftests get tripped up on this assert if KVM_SET_USER_MEMORY_REGION is
> passed an "extended" struct.
> 
> 	#define kvm_do_ioctl(fd, cmd, arg)						\
> 	({										\
> 		kvm_static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) == _IOC_SIZE(cmd));	\
> 		ioctl(fd, cmd, arg);							\
> 	})

Got it. Thanks for the explanation.

Chao
