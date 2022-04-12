Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482284FE2E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 15:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354441AbiDLNmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 09:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiDLNmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:42:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998BE31528;
        Tue, 12 Apr 2022 06:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649770784; x=1681306784;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=imgoy6oXMIaQRH/0xG58po19cKwE7PGh6Cx68gmrnn8=;
  b=iBZgiXieIFqn0fX32cZGIlRZKFP5INhyCeNq/Q8ymNSW0mH+WdycG4FU
   vcavCDeouziBj6M55TGlMdHePMH3jKalAP9qBS3Hhr2musuAXY0TCwyEn
   imXRdnSsia/BfKrCbk3MWA05nkw0ox52hOBe52/v3z7vv2shdNVb+oX59
   dnerFSBn91BLek74n7njX84RHuvnCpTsDmDyqRi2aiSD9M41xW7X57Eue
   rkzNFaQRexm+2fygmto27bGd8U9L9YeSz99u0cWLgvPhTmk0Lg/F0hZzi
   8HRUKQ/Cs8hKSgmar3xk4bUXcXYP5xhTqLnihwFrQ0k0YTC76hH4daMxv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242317030"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="242317030"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:39:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="590329640"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga001.jf.intel.com with ESMTP; 12 Apr 2022 06:39:36 -0700
Date:   Tue, 12 Apr 2022 21:39:25 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 04/13] mm/shmem: Restrict MFD_INACCESSIBLE memory
 against RLIMIT_MEMLOCK
Message-ID: <20220412133925.GG8013@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-5-chao.p.peng@linux.intel.com>
 <Yk8L0CwKpTrv3Rg3@google.com>
 <20220411153233.54ljmi7zgqovhgsn@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411153233.54ljmi7zgqovhgsn@box.shutemov.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 06:32:33PM +0300, Kirill A. Shutemov wrote:
> On Thu, Apr 07, 2022 at 04:05:36PM +0000, Sean Christopherson wrote:
> > Hmm, shmem_writepage() already handles SHM_F_INACCESSIBLE by rejecting the swap, so
> > maybe it's just the page migration path that needs to be updated?
> 
> My early version prevented migration with -ENOTSUPP for
> address_space_operations::migratepage().
> 
> What's wrong with that approach?

I previously thought migratepage will not be called since we already
marked the pages as UNMOVABLE, sounds not correct?

Thanks,
Chao
> 
> -- 
>  Kirill A. Shutemov
