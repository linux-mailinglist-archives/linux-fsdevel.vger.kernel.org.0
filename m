Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE81569E02C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 13:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjBUMUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 07:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjBUMUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:20:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73788298FB;
        Tue, 21 Feb 2023 04:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676981979; x=1708517979;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=rNp1uu81FPNgOnZRpB88mbF0GVkK0krzknn+hkCEz0w=;
  b=ky4+DfEmHijY+TsNIKQ/6ZIY75zcG1IX82m1I20l3iA4dy2gV0fis//W
   J8r78r++jjJC4aFUjdNbsw/+NsCmf5joNSJuORUxKR0Q49cKdkEUsuw9B
   ZJCxTqpt1jPJIUoE/KnNYxsHRulAt4hxSWB48OJn4wUqe9SnsnWloAadg
   F4dsp1MsislcvI+/SKheGhgG5MyzyYiRR2Xa+8oLXajguWG+4LGUzRusg
   iw418CG0J4RdeLwNN1qKv7SD009uOAnMhH1+kSjXBL3nO6MjRtkcDgVUZ
   488MgEAZIAvJdaFgzq3shtjOdk2Dq9twq0ugaIAXrdkf4EOpLkMXNpBMU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="316337822"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="316337822"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 04:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="917165304"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="917165304"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2023 04:19:16 -0800
Date:   Tue, 21 Feb 2023 20:11:35 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>, kvm@vger.kernel.org,
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
        mhocko@suse.com, wei.w.wang@intel.com
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20230221121135.GA1595130@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
 <20230119111308.GC2976263@ls.amr.corp.intel.com>
 <Y8lg1G2lRIrI/hld@google.com>
 <20230119223704.GD2976263@ls.amr.corp.intel.com>
 <Y880FiYF7YCtsw/i@google.com>
 <20230213130102.two7q3kkcf254uof@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213130102.two7q3kkcf254uof@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Hi Sean,
> 
> We've rebased the SEV+SNP support onto your updated UPM base support
> tree and things seem to be working okay, but we needed some fixups on
> top of the base support get things working, along with 1 workaround
> for an issue that hasn't been root-caused yet:
> 
>   https://github.com/mdroth/linux/commits/upmv10b-host-snp-v8-wip
> 
>   *stash (upm_base_support): mm: restrictedmem: Kirill's pinning implementation
>   *workaround (use_base_support): mm: restrictedmem: loosen exclusivity check

What I'm seeing is Slot#3 gets added first and then deleted. When it's
gets added, Slot#0 already has the same range bound to restrictedmem so
trigger the exclusive check. This check is exactly the current code for.

>   *fixup (upm_base_support): KVM: use inclusive ranges for restrictedmem binding/unbinding
>   *fixup (upm_base_support): mm: restrictedmem: use inclusive ranges for issuing invalidations

As many kernel APIs treat 'end' as exclusive, I would rather keep using
exclusive 'end' for these APIs(restrictedmem_bind/restrictedmem_unbind
and notifier callbacks) but fix it internally in the restrictedmem. E.g.
all the places where xarray API needs a 'last'/'max' we use 'end - 1'.
See below for the change.

>   *fixup (upm_base_support): KVM: fix restrictedmem GFN range calculations

Subtracting slot->restrictedmem.index for start/end in
restrictedmem_get_gfn_range() is the correct fix.

>   *fixup (upm_base_support): KVM: selftests: CoCo compilation fixes
> 
> We plan to post an updated RFC for v8 soon, but also wanted to share
> the staging tree in case you end up looking at the UPM integration aspects
> before then.
> 
> -Mike

This is the restrictedmem fix to solve 'end' being stored and checked in xarray:

--- a/mm/restrictedmem.c
+++ b/mm/restrictedmem.c
@@ -46,12 +46,12 @@ static long restrictedmem_punch_hole(struct restrictedmem *rm, int mode,
         */
        down_read(&rm->lock);
 
-       xa_for_each_range(&rm->bindings, index, notifier, start, end)
+       xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
                notifier->ops->invalidate_start(notifier, start, end);
 
        ret = memfd->f_op->fallocate(memfd, mode, offset, len);
 
-       xa_for_each_range(&rm->bindings, index, notifier, start, end)
+       xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
                notifier->ops->invalidate_end(notifier, start, end);
 
        up_read(&rm->lock);
@@ -224,7 +224,7 @@ static int restricted_error_remove_page(struct address_space *mapping,
                }
                spin_unlock(&inode->i_lock);
 
-               xa_for_each_range(&rm->bindings, index, notifier, start, end)
+               xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
                        notifier->ops->error(notifier, start, end);
                break;
        }
@@ -301,11 +301,12 @@ int restrictedmem_bind(struct file *file, pgoff_t start, pgoff_t end,
                if (exclusive != rm->exclusive)
                        goto out_unlock;
 
-               if (exclusive && xa_find(&rm->bindings, &start, end, XA_PRESENT))
+               if (exclusive &&
+                   xa_find(&rm->bindings, &start, end - 1, XA_PRESENT))
                        goto out_unlock;
        }
 
-       xa_store_range(&rm->bindings, start, end, notifier, GFP_KERNEL);
+       xa_store_range(&rm->bindings, start, end - 1, notifier, GFP_KERNEL);
        rm->exclusive = exclusive;
        ret = 0;
 out_unlock:
@@ -320,7 +321,7 @@ void restrictedmem_unbind(struct file *file, pgoff_t start, pgoff_t end,
        struct restrictedmem *rm = file->f_mapping->private_data;
 
        down_write(&rm->lock);
-       xa_store_range(&rm->bindings, start, end, NULL, GFP_KERNEL);
+       xa_store_range(&rm->bindings, start, end - 1, NULL, GFP_KERNEL);
        synchronize_rcu();
        up_write(&rm->lock);
 }
