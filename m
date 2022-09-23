Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782F45E70ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 02:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiIWAxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 20:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiIWAxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:53:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336C563D3;
        Thu, 22 Sep 2022 17:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663894412; x=1695430412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N5ROSjhMMMcLpyjlHpJbtQYkQW/pwctSUSnQMueHIwE=;
  b=j0npw3hxIhk/PNb5lDfzUqD6jLjrltPDSjqtLFQjLyRdomVN6bRefFHz
   uXvWfgG4uz2MxxCNbni1bBuYLUa+koUygb7dcUoPhN2odkzkEqsUE2Wob
   Fo3ygUUA51auPuT+HUNkVklb8KJxTyVHf8P3Nv4GF0eEHysOqNnxnR5jK
   a+aoyB5TILiFMiHOHcYb4b+G3B3EocQyJuAwQzMVBtEvZSutXObl/iFrY
   gYXU6YQKmcVmT+UImswR9TWKMm2m/x/gVKgcmicaxRHWA+kzIVIcNHalx
   KMF697UTmPER7m2tv6+hrcdtos4Dsv4g4RgjJkJoqemIe2EOLD0fxzTul
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283569063"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="283569063"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:53:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="622334850"
Received: from dnessim-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.60.183])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:53:21 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6B9DA104532; Fri, 23 Sep 2022 03:53:19 +0300 (+03)
Date:   Fri, 23 Sep 2022 03:53:19 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Wang, Wei W" <wei.w.wang@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
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
        "Lutomirski, Andy" <luto@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <20220923005319.wkzpl36uailh4zbw@box.shutemov.name>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <DS0PR11MB63734D4DF4C4F368805EC97DDC4E9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Yyy8Pp0Y4NRzIzNw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyy8Pp0Y4NRzIzNw@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 07:49:18PM +0000, Sean Christopherson wrote:
> On Thu, Sep 22, 2022, Wang, Wei W wrote:
> > On Thursday, September 15, 2022 10:29 PM, Chao Peng wrote:
> > > +int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> > > +			 int *order)
> > 
> > Better to remove "order" from this interface?
> 
> Hard 'no'.
> 
> > Some callers only need to get pfn, and no need to bother with
> > defining and inputting something unused. For callers who need the "order",
> > can easily get it via thp_order(pfn_to_page(pfn)) on their own.
> 
> That requires (a) assuming the pfn is backed by struct page, and (b) assuming the
> struct page is a transparent huge page.  That might be true for the current
> implementation, but it most certainly will not always be true.
> 
> KVM originally did things like this, where there was dedicated code for THP vs.
> HugeTLB, and it was a mess.  The goal here is very much to avoid repeating those
> mistakes.  Have the backing store _tell_ KVM how big the mapping is, don't force
> KVM to rediscover the info on its own.

I guess we can allow order pointer to be NULL to cover caller that don't
need to know the order. Is it useful?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
