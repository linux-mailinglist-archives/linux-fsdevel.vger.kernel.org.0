Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A7F4BA06C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 13:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbiBQM5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 07:57:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiBQM5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:57:40 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C48C1C1ED8;
        Thu, 17 Feb 2022 04:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645102646; x=1676638646;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=muUyZFkT/XUwYXtZ4KuQ8w3WazrYqWNDm8XTjig5hYY=;
  b=F7D2plqBiebEWhtvkoEXTBnA3L6AYMfMXFNOK5/owrT7D0+8/8WarGyo
   thv5scP73eVRxho+FXBa+xcJZVkPPjfiumPk3YsuFbywYnKuGUAOMPEAH
   SqXGGd2tGSTHlUtRAufUMdwLpZjs39ocTCYhE/wlZUi1nyWrVQ45KccoH
   2XLydaH5uvVa3bqqQMUD8fVgRnfkc/z0kwuY91RN/WBYFvhtL9jfqX/t6
   w7OlcYSIlv5SJuJ+FVUnaGjwR4oGFYfPg0+0eAC4flZ9oztza57RXzA2Q
   +2Gx4b+2tW34XOvQfl5tESnm6Z7s30EtLnEGzbtKV/vV3Lq6zfYwr4yNT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="251064855"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="251064855"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 04:57:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="704785987"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 17 Feb 2022 04:57:18 -0800
Date:   Thu, 17 Feb 2022 20:56:57 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v4 01/12] mm/shmem: Introduce F_SEAL_INACCESSIBLE
Message-ID: <20220217125656.GA32679@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-2-chao.p.peng@linux.intel.com>
 <64407833-1387-0c46-c569-8b6a3db8e88c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64407833-1387-0c46-c569-8b6a3db8e88c@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 07, 2022 at 01:24:42PM +0100, Vlastimil Babka wrote:
> On 1/18/22 14:21, Chao Peng wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> >  /*
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 18f93c2d68f1..72185630e7c4 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1098,6 +1098,13 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
> >  		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
> >  			return -EPERM;
> >  
> > +		if (info->seals & F_SEAL_INACCESSIBLE) {
> > +			if(i_size_read(inode))
> 
> Is this needed? The rest of the function seems to trust oldsize obtained by
> plain reading inode->i_size well enough, so why be suddenly paranoid here?

oldsize sounds enough here, unless kirill has different mind.

> 
> > +				return -EPERM;
> > +			if (newsize & ~PAGE_MASK)
> > +				return -EINVAL;
> > +		}
> > +
> >  		if (newsize != oldsize) {
> >  			error = shmem_reacct_size(SHMEM_I(inode)->flags,
> > +		if ((info->seals & F_SEAL_INACCESSIBLE) &&
> > +		    (offset & ~PAGE_MASK || len & ~PAGE_MASK)) {
> 
> Could we use PAGE_ALIGNED()?

Yes, definitely, thanks.

Chao
> 
> > +			error = -EINVAL;
> > +			goto out;
> > +		}
> > +
> >  		shmem_falloc.waitq = &shmem_falloc_waitq;
> >  		shmem_falloc.start = (u64)unmap_start >> PAGE_SHIFT;
> >  		shmem_falloc.next = (unmap_end + 1) >> PAGE_SHIFT;
