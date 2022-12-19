Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6187A650858
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 09:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiLSIBZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Dec 2022 03:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLSIBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Dec 2022 03:01:23 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE4E389D;
        Mon, 19 Dec 2022 00:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671436881; x=1702972881;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=OfZ8wFDJ+6nAyql1Nd8OAfYvfKbri9zQQ6twPOrF8GY=;
  b=bmJW7eAv3NykjkhPT0YMpF5V5G+0fbG46x7W1i3HTwqmMKARmuZHao/+
   rABFuW/HYTc620BBaB7xVwFG6uDwKZkc9A2ZxTowDUpVfXVz8J7mBwLKD
   DZSYrNbOQ6MY6bXivT/tVMs2PrRUap95HnWaJiZnlf+MA8axKgGFn4i5E
   tfTSGgK3h4ENT7ncpRJNmId/hsfefBxjiOo+Qo7ZaH0sZo/w6e3z+0MMf
   dd7PA6g4oy59rp150ToXAPGF8zc7819cXYR3eHjYlGkerL1I3MDaglVKW
   kyX0AUoN+tgQtpllTQjXQuxGOZvBMhIVus4+Yaup4PMQmR9uQZ97+3/TL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="302716663"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="302716663"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2022 23:58:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="824757705"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="824757705"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga005.jf.intel.com with ESMTP; 18 Dec 2022 23:54:49 -0800
Date:   Mon, 19 Dec 2022 15:50:32 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
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
Message-ID: <20221219075032.GA1691829@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
 <cd950a78-5c5b-16ef-d0a6-ad2878af067e@intel.com>
 <20221208113003.GE1304936@chaop.bj.intel.com>
 <4d736cc0-f249-6531-c0af-7093c2c2537f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d736cc0-f249-6531-c0af-7093c2c2537f@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 08:04:14PM +0800, Xiaoyao Li wrote:
> On 12/8/2022 7:30 PM, Chao Peng wrote:
> > On Thu, Dec 08, 2022 at 04:37:03PM +0800, Xiaoyao Li wrote:
> > > On 12/2/2022 2:13 PM, Chao Peng wrote:
> > > 
> > > ..
> > > 
> > > > Together with the change, a new config HAVE_KVM_RESTRICTED_MEM is added
> > > > and right now it is selected on X86_64 only.
> > > > 
> > > 
> > >  From the patch implementation, I have no idea why HAVE_KVM_RESTRICTED_MEM is
> > > needed.
> > 
> > The reason is we want KVM further controls the feature enabling. An
> > opt-in CONFIG_RESTRICTEDMEM can cause problem if user sets that for
> > unsupported architectures.
> 
> HAVE_KVM_RESTRICTED_MEM is not used in this patch. It's better to introduce
> it in the patch that actually uses it.

It's being 'used' in this patch by reverse selecting RESTRICTEDMEM in
arch/x86/kvm/Kconfig, this gives people a sense where
restrictedmem_notifier comes from. Introducing the config with other
private/restricted memslot stuff together can also help future
supporting architectures better identify what they need do. But those
are trivial and moving to patch 08 sounds also good to me.

Thanks,
Chao
> 
> > Here is the original discussion:
> > https://lore.kernel.org/all/YkJLFu98hZOvTSrL@google.com/
> > 
> > Thanks,
> > Chao
