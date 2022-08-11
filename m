Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41458FDA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 15:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiHKNoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 09:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbiHKNoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:44:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A369661D5B;
        Thu, 11 Aug 2022 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660225450; x=1691761450;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=6G1vjfFDPRBJq3hrus4RUCAj1Ik6SbGGx7LGPLT4CKc=;
  b=d4c4cnSceeeu7pOr1M6yPJGfJ3fVRak7yxgC47zNN1IUy5Tdxab8FQpQ
   cnBQ7gPpd/hvDbuy5gyByOuMb4lwo8Im4oHMUbzDm0qlCTHn/ijQFZOvj
   Mq3lq+LDZMrEPRr48zUj5FDkcV8nz5k9ctL5KIPNwWcpCtzi1hkz1qA6q
   pWtjiYJKJbCH2SMClUXcoA9fT++42hoDozM5J4GtXDH6azUGtBvupYHp5
   MElZW9qgLRhScPlvOPYRA8D2igtaz9uCPWI1Q3gwwFAcoWWRDjFf8DJPw
   0BgRP0lvXbrnQokLfItXaKv0DQOp2FbifwnxcSyaisiM8C2qnOGVb1Sxb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271731755"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="271731755"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 06:44:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="665377410"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 11 Aug 2022 06:43:59 -0700
Date:   Thu, 11 Aug 2022 21:39:14 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        dhildenb@redhat.com, Michael Roth <michael.roth@amd.com>,
        mhocko@suse.com, Muchun Song <songmuchun@bytedance.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v7 03/14] mm: Introduce memfile_notifier
Message-ID: <20220811133914.GC916119@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-4-chao.p.peng@linux.intel.com>
 <13394075-fca0-6f2b-92a2-f1291fcec9a3@redhat.com>
 <20220810092232.GC862421@chaop.bj.intel.com>
 <00f1aa03-bc82-ffce-569b-e2d5c459992c@redhat.com>
 <YvPC87FMgF7uac7z@google.com>
 <YvT1zOQtTQl2t300@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvT1zOQtTQl2t300@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 11, 2022 at 12:27:56PM +0000, Quentin Perret wrote:
> +CC Fuad
> 
> On Wednesday 10 Aug 2022 at 14:38:43 (+0000), Sean Christopherson wrote:
> > > I understand Sean's suggestion about abstracting, but if the new name
> > > makes it harder to grasp and there isn't really an alternative to memfd
> > > in sight, I'm not so sure I enjoy the tried abstraction here.
> > 
> > ARM's pKVM implementation is potentially (hopefully) going to switch to this API
> > (as a consumer) sooner than later.  If they anticipate being able to use memfd,
> > then there's unlikely to be a second backing type any time soon.
> > 
> > Quentin, Will?
> 
> Yep, Fuad is currently trying to port the pKVM mm stuff on top of this
> series to see how well it fits, so stay tuned.

Good to hear that.

>I think there is still
> some room for discussion around page conversions (private->shared etc),
> and we'll need a clearer idea of what the code might look like to have a
> constructive discussion,

That's fine. Looking forward to your feedbacks.

>but so far it does seem like using a memfd (the
> new private one or perhaps just memfd_secret, to be discussed) + memfd
> notifiers is a promising option.

If it still memfd (even memfd_secret), maybe we can use the name
memfd_notifier?

Chao
