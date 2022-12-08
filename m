Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E505646EAE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Dec 2022 12:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLHLeh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Dec 2022 06:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLHLeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:34:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B64A66C92;
        Thu,  8 Dec 2022 03:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670499274; x=1702035274;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=BNKj0Q3HaLW0QQmlzFra5ewPCCLiShH0XE7KzON/axc=;
  b=ZBdy+j/fchQRGmGKP7GDgoYIYvGsgJV4ZOXLhYPAn8C0c++ME7RVjpkJ
   cBlA8tUIxFHdKaTCPFLfgzUi8EQnBhQLOI3deLcWW7UBkWFKP0AJN8dBa
   SNFnztz9sNY8zj2/Frtf8hEWFtCgsJQie62pcz5dvhCBlBT0G4QN3ahA1
   qclFaZFnIVcscJ5hXHqncfBMdr7Yaa3HlW+CxOMbiXG+muzeoABvVVqE/
   Y6Eno96YqlLZLJpGhZuhSkqyflapfejVrEgmlr6G2gD90HUPDhZ6dsQRu
   k+/mVeN9omqrHS+5msglRxsGzOzTGWsQ/4TNCQfjBhl+dhG7tMMH7NTQ4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315865225"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="315865225"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 03:34:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="624670349"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="624670349"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga006.jf.intel.com with ESMTP; 08 Dec 2022 03:34:22 -0800
Date:   Thu, 8 Dec 2022 19:30:03 +0800
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
Message-ID: <20221208113003.GE1304936@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
 <cd950a78-5c5b-16ef-d0a6-ad2878af067e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd950a78-5c5b-16ef-d0a6-ad2878af067e@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 08, 2022 at 04:37:03PM +0800, Xiaoyao Li wrote:
> On 12/2/2022 2:13 PM, Chao Peng wrote:
> 
> ..
> 
> > Together with the change, a new config HAVE_KVM_RESTRICTED_MEM is added
> > and right now it is selected on X86_64 only.
> > 
> 
> From the patch implementation, I have no idea why HAVE_KVM_RESTRICTED_MEM is
> needed.

The reason is we want KVM further controls the feature enabling. An
opt-in CONFIG_RESTRICTEDMEM can cause problem if user sets that for
unsupported architectures.

Here is the original discussion:
https://lore.kernel.org/all/YkJLFu98hZOvTSrL@google.com/

Thanks,
Chao
