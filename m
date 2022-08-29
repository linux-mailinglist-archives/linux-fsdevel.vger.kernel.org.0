Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228D95A5023
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 17:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiH2P0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 11:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiH2P0A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:26:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A225E4057F;
        Mon, 29 Aug 2022 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661786759; x=1693322759;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=xYdvX1PhD3Iug/xG1oZ0ioxeY0YVxwImFkNf9/6SStg=;
  b=hWdzhzZFwVFA5mNu2jfoAjjGOwCGsK2Gc/vg0/6FixGLwv3ntrqwitCK
   VE6ndI3r/6otqMBw8JEsVzE5Uvbi/ZSAQykMllBg3Os/pnVAIiKDQ3HlU
   xY8Mm+ZFTSV9saVBR+6PNPX7tq+VZ9yawCIUBIumHjZdFcPxvgBx/E3Wf
   JUsBTpRrE9g78IiId9/G7QTrxEnvaGlM/RBE6JeQtJBDW59hyOHCPVh3l
   fzXbNNS8fkrr/PwYRG00grNSj7LWGVQw2NMn4yVzBs2ZVxNvrULoSRhqH
   HXjd3AKajILPJoJ8tZPmlIueFtvJCTwUtMVM2nS+Sq6ft3iTb/SW5KvIP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="358886403"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="358886403"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 08:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="640973244"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2022 08:25:49 -0700
Date:   Mon, 29 Aug 2022 23:21:07 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Fuad Tabba <tabba@google.com>
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
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
Message-ID: <20220829152107.GD1586678@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
 <CA+EHjTzpb2PcGBbN61YqMWdQ5f-55Lt12ALHQ0pdwtGvV8nS8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTzpb2PcGBbN61YqMWdQ5f-55Lt12ALHQ0pdwtGvV8nS8g@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 04:19:43PM +0100, Fuad Tabba wrote:
> > +bool __weak kvm_arch_private_mem_supported(struct kvm *kvm)
> > +{
> > +       return false;
> > +}
> > +
> >  static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
> >  {
> >         u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
> > @@ -4689,6 +4729,22 @@ static long kvm_vm_ioctl(struct file *filp,
> >                 r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
> >                 break;
> >         }
> > +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> > +       case KVM_MEMORY_ENCRYPT_REG_REGION:
> > +       case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
> > +               struct kvm_enc_region region;
> > +
> > +               if (!kvm_arch_private_mem_supported(kvm))
> > +                       goto arch_vm_ioctl;
> > +
> > +               r = -EFAULT;
> > +               if (copy_from_user(&region, argp, sizeof(region)))
> > +                       goto out;
> > +
> > +               r = kvm_vm_ioctl_set_encrypted_region(kvm, ioctl, &region);
> > +               break;
> > +       }
> > +#endif
> >         case KVM_GET_DIRTY_LOG: {
> >                 struct kvm_dirty_log log;
> >
> > @@ -4842,6 +4898,7 @@ static long kvm_vm_ioctl(struct file *filp,
> >                 r = kvm_vm_ioctl_get_stats_fd(kvm);
> >                 break;
> >         default:
> > +arch_vm_ioctl:
> 
> It might be good to make this label conditional on
> CONFIG_HAVE_KVM_PRIVATE_MEM, otherwise you get a warning if
> CONFIG_HAVE_KVM_PRIVATE_MEM isn't defined.
> 
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
>  arch_vm_ioctl:
> +#endif

Right, as the bot already complains.

Chao
> 
> Cheers,
> /fuad
> 
> 
> 
> 
> 
> >                 r = kvm_arch_vm_ioctl(filp, ioctl, arg);
> >         }
> >  out:
> > --
> > 2.25.1
> >
