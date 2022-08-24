Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934E659F6BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiHXJrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 05:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbiHXJqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:46:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709B561D56;
        Wed, 24 Aug 2022 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661334403; x=1692870403;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=8HINI0FFOmHZ98p+KrUxRjOuWiCSe4IMz6bvZat9QRk=;
  b=VEC2IPRa4/nMxztM1aPX5KBq3uRmsrlx84vpGJo30JMhOjT7NCbbKyxF
   p2nDnlQykp8sW2liM3a5kwU+T+xrFOsb7xXSZlWsBLhcm5/H+GLgxTuuI
   NkFBKFmBojUBrrwcGGDgYT2z4NH7B8N+irzrcTplevbIUF9M8M/LdxeCd
   Vju+BLkMplOOV6mxETkiKY4xYdPyJHFE/bfzJIUd9HGQR0jKHk1On0r/8
   1IrPOLICOuvhwYTmhfImFMH/8+1/xzBd922Ju6I6kiHBrIzlE/lrELGqU
   hgZbixw+f7qeibeBzUbBTgvCtzpArDa4r2z0Bnjom5Rd6ZQT7mkTzPdjH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="294708544"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="294708544"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 02:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="605977030"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2022 02:46:32 -0700
Date:   Wed, 24 Aug 2022 17:41:49 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        aarcange@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220824094149.GA1383966@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
 <Yv7XTON3MwuC1Q3U@google.com>
 <226ab26d-9aa8-dce2-c7f0-9e3f5b65b63@google.com>
 <b2743a3a-a1b4-2d2e-98be-87b58ad387cf@redhat.com>
 <YwT6x2g9jcMH60LI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwT6x2g9jcMH60LI@google.com>
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

On Tue, Aug 23, 2022 at 04:05:27PM +0000, Sean Christopherson wrote:
> On Tue, Aug 23, 2022, David Hildenbrand wrote:
> > On 19.08.22 05:38, Hugh Dickins wrote:
> > > On Fri, 19 Aug 2022, Sean Christopherson wrote:
> > >> On Thu, Aug 18, 2022, Kirill A . Shutemov wrote:
> > >>> On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
> > >>>> On Wed, 6 Jul 2022, Chao Peng wrote:
> > >>>> But since then, TDX in particular has forced an effort into preventing
> > >>>> (by flags, seals, notifiers) almost everything that makes it shmem/tmpfs.
> > >>>>
> > >>>> Are any of the shmem.c mods useful to existing users of shmem.c? No.
> > >>>> Is MFD_INACCESSIBLE useful or comprehensible to memfd_create() users? No.
> > >>
> > >> But QEMU and other VMMs are users of shmem and memfd.  The new features certainly
> > >> aren't useful for _all_ existing users, but I don't think it's fair to say that
> > >> they're not useful for _any_ existing users.
> > > 
> > > Okay, I stand corrected: there exist some users of memfd_create()
> > > who will also have use for "INACCESSIBLE" memory.
> > 
> > As raised in reply to the relevant patch, I'm not sure if we really have
> > to/want to expose MFD_INACCESSIBLE to user space. I feel like this is a
> > requirement of specific memfd_notifer (memfile_notifier) implementations
> > -- such as TDX that will convert the memory and MCE-kill the machine on
> > ordinary write access. We might be able to set/enforce this when
> > registering a notifier internally instead, and fail notifier
> > registration if a condition isn't met (e.g., existing mmap).
> >
> > So I'd be curious, which other users of shmem/memfd would benefit from
> > (MMU)-"INACCESSIBLE" memory obtained via memfd_create()?
> 
> I agree that there's no need to expose the inaccessible behavior via uAPI.  Making
> it a kernel-internal thing that's negotiated/resolved when KVM binds to the fd
> would align INACCESSIBLE with the UNMOVABLE and UNRECLAIMABLE flags (and any other
> flags that get added in the future).
> 
> AFAICT, the user-visible flag is a holdover from the early RFCs and doesn't provide
> any unique functionality.

That's also what I'm thinking. And I don't see problem immediately if
user has populated the fd at the binding time. Actually that looks an
advantage for previously discussed guest payload pre-loading.

> 
> If we go that route, we might want to have shmem/memfd require INACCESSIBLE to be
> set for the initial implementation.  I.e. disallow binding without INACCESSIBLE
> until there's a use case.

I can do that.

Chao
