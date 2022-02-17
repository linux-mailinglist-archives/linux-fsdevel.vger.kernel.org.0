Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BD34BA107
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 14:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbiBQNYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 08:24:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240597AbiBQNYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:24:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7BDB10BE;
        Thu, 17 Feb 2022 05:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645104240; x=1676640240;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=7ROqYA+WyEzn2lj20W8JxFtIkCz3sbVl7IBm5h9FArM=;
  b=mCHOM8EOULjGU6gJsE7XAkjPWxh1VNf63ZXksMOwwdEdVT35KgHC/esN
   fV4TwLVVYhWqDyztrAH0l8w6Nyl63Km6A3Y+Lx+LLIv2VpbMCWdmhi3jA
   +LIXlLEqlN7SYidQ0SP6Bv78CiqUBH9arSqn3nQ57JFGLDcda628Eigq5
   qU57Im/ulAnLZ8d2r/+k6bYv4BXqtw0Y2PHIL3hp1tnwR3+i1zmtjJviN
   RpwLbsRww6snDbhGqStFySo+dUt4GnLP4iBqaLJTyEIixM/NQHgriW+sC
   v9n0EVgyYkk73qC0bvy9yKkbTlo6FrQeZIYk2m/w8wm5iksJ4Zgs7iwqS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="337315731"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="337315731"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 05:23:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="681959596"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2022 05:23:47 -0800
Date:   Thu, 17 Feb 2022 21:23:25 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
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
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v4 04/12] mm/shmem: Support memfile_notifier
Message-ID: <20220217132325.GD32679@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-5-chao.p.peng@linux.intel.com>
 <314affa4-fbcb-2cb9-deb7-f61a2ac99260@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <314affa4-fbcb-2cb9-deb7-f61a2ac99260@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 11, 2022 at 03:40:09PM -0800, Andy Lutomirski wrote:
> On 1/18/22 05:21, Chao Peng wrote:
> > It maintains a memfile_notifier list in shmem_inode_info structure and
> > implements memfile_pfn_ops callbacks defined by memfile_notifier. It
> > then exposes them to memfile_notifier via
> > shmem_get_memfile_notifier_info.
> > 
> > We use SGP_NOALLOC in shmem_get_lock_pfn since the pages should be
> > allocated by userspace for private memory. If there is no pages
> > allocated at the offset then error should be returned so KVM knows that
> > the memory is not private memory.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> 
> >   static int memfile_get_notifier_info(struct inode *inode,
> >   				     struct memfile_notifier_list **list,
> >   				     struct memfile_pfn_ops **ops)
> >   {
> > -	return -EOPNOTSUPP;
> > +	int ret = -EOPNOTSUPP;
> > +#ifdef CONFIG_SHMEM
> > +	ret = shmem_get_memfile_notifier_info(inode, list, ops);
> > +#endif
> > +	return ret;
> >   }
> 
> > +int shmem_get_memfile_notifier_info(struct inode *inode,
> > +				    struct memfile_notifier_list **list,
> > +				    struct memfile_pfn_ops **ops)
> > +{
> > +	struct shmem_inode_info *info;
> > +
> > +	if (!shmem_mapping(inode->i_mapping))
> > +		return -EINVAL;
> > +
> > +	info = SHMEM_I(inode);
> > +	*list = &info->memfile_notifiers;
> > +	if (ops)
> > +		*ops = &shmem_pfn_ops;
> > +
> > +	return 0;
> 
> I can't wrap my head around exactly who is supposed to call these functions
> and when, but there appears to be a missing check that the inode is actually
> a shmem inode.
> 
> What is this code trying to do?  It's very abstract.

This is to be called by memfile_(un)register_notifier in patch-03 to
allow shmem to be connected to memfile_notifer. But as Mike pointed out,
probably introducing a memfile_notifier_register_backing_store() sounds
better so backing store (e.g. shmem) can register itself to
memfile_notifier.

Chao
