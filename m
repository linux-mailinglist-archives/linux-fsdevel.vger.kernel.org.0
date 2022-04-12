Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD20F4FE24E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 15:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354519AbiDLNYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 09:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356021AbiDLNWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:22:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53340D6D;
        Tue, 12 Apr 2022 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649769192; x=1681305192;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=THXNbE6uwc6VmEva3UG39/ka2/jfkbL0RmRgTIEQt8M=;
  b=fCmZykE24AWdHyuYnbHbQjNmK3JasMMSy1iz72xn/BCaWcAeky3CT4dT
   XtGXnXgagHs6cPge+VGDAPOFS9MggTd68WJ6jpRKeVhM4sEiew7fHNbT9
   y3H+PQ9lC6ImGFXOOpWgbKbEQ49T6Fw/spHDK0wbbb1KHK2ezmQ4IkyGS
   nsgfrx0WDMpqfJkvuu1kL10uKmS9m/w24hbPk0wKWaaRRJ/C0JPZiegQC
   MOgYINf9rzDI3e6WlKBvcgCCdR70uWtjknODOzseEg0bLP84XdBAq+OmU
   bAWooNWUdBHNRUeSxMS+XeRnuv7C9fiqImRlnrA2dW+ImFGJAIgOUbOLX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262550916"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="262550916"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 06:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="699828966"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2022 06:13:04 -0700
Date:   Tue, 12 Apr 2022 21:12:54 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Wanpeng Li <wanpengli@tencent.com>, jun.nakajima@intel.com,
        david@redhat.com, "J . Bruce Fields" <bfields@fieldses.org>,
        dave.hansen@intel.com, "H . Peter Anvin" <hpa@zytor.com>,
        ak@linux.intel.com, Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Steven Price <steven.price@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Borislav Petkov <bp@alien8.de>, luto@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Annapurve <vannapurve@google.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v5 03/13] mm/shmem: Support memfile_notifier
Message-ID: <20220412131254.GF8013@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-4-chao.p.peng@linux.intel.com>
 <20220411152647.uvl2ukuwishsckys@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411152647.uvl2ukuwishsckys@box.shutemov.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 06:26:47PM +0300, Kirill A. Shutemov wrote:
> On Thu, Mar 10, 2022 at 10:09:01PM +0800, Chao Peng wrote:
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 9b31a7056009..7b43e274c9a2 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -903,6 +903,28 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
> >  	return page ? page_folio(page) : NULL;
> >  }
> >  
> > +static void notify_fallocate(struct inode *inode, pgoff_t start, pgoff_t end)
> > +{
> > +#ifdef CONFIG_MEMFILE_NOTIFIER
> > +	struct shmem_inode_info *info = SHMEM_I(inode);
> > +
> > +	memfile_notifier_fallocate(&info->memfile_notifiers, start, end);
> > +#endif
> 
> All these #ifdefs look ugly. Could you provide dummy memfile_* for
> !MEMFILE_NOTIFIER case?
Sure.

Chao
> 
> -- 
>  Kirill A. Shutemov
