Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469CA4BA09B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 14:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240669AbiBQNHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 08:07:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbiBQNHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:07:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D50105A9D;
        Thu, 17 Feb 2022 05:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645103221; x=1676639221;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=xA8H4mCuPL0+Y5H2RRjONOFAaibouE9qYQsummWmUDo=;
  b=aMNw7pRa+alHrCvUlPZSDNgXHuOgdVAYpRvtWtRYfQg8WRw8AXq72jmh
   VRbPq0FdNtsyadDd/CuUxZ9cM/bdvP6d7/HKJ0DzM1RtKNNQky/1N0kD+
   DxNK6T172poY8G9eRhOLRqpYvavLamNNSg7P12UxRRmqj+LETEYz7zDSQ
   7u5OrHpqUn/VFu9N8OKfipFYEOKkl18iPI9rjporPOBrow12eeHol2sll
   eBP1h231szuwPPwTRe44InuTf7f+EUpMxoxs4Eq4pRXRKLRv9i92roUPM
   GhKGZTjWUTlJLPeE4IATQAjT2JC9xj2DMmu5+M17tSDeOkoUjaiVsQq5B
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="230830598"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="230830598"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 05:07:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="704790168"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 17 Feb 2022 05:06:52 -0800
Date:   Thu, 17 Feb 2022 21:06:31 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Linux API <linux-api@vger.kernel.org>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v4 01/12] mm/shmem: Introduce F_SEAL_INACCESSIBLE
Message-ID: <20220217130631.GB32679@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-2-chao.p.peng@linux.intel.com>
 <619547ad-de96-1be9-036b-a7b4e99b09a6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <619547ad-de96-1be9-036b-a7b4e99b09a6@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 11, 2022 at 03:33:35PM -0800, Andy Lutomirski wrote:
> On 1/18/22 05:21, Chao Peng wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > Introduce a new seal F_SEAL_INACCESSIBLE indicating the content of
> > the file is inaccessible from userspace through ordinary MMU access
> > (e.g., read/write/mmap). However, the file content can be accessed
> > via a different mechanism (e.g. KVM MMU) indirectly.
> > 
> > It provides semantics required for KVM guest private memory support
> > that a file descriptor with this seal set is going to be used as the
> > source of guest memory in confidential computing environments such
> > as Intel TDX/AMD SEV but may not be accessible from host userspace.
> > 
> > At this time only shmem implements this seal.
> > 
> 
> I don't dislike this *that* much, but I do dislike this. F_SEAL_INACCESSIBLE
> essentially transmutes a memfd into a different type of object.  While this
> can apparently be done successfully and without races (as in this code),
> it's at least awkward.  I think that either creating a special inaccessible
> memfd should be a single operation that create the correct type of object or
> there should be a clear justification for why it's a two-step process.

Now one justification maybe from Stever's comment to patch-00: for ARM
usage it can be used with creating a normal memfd, (partially)populate
it with initial guest memory content (e.g. firmware), and then
F_SEAL_INACCESSIBLE it just before the first time lunch of the guest in
KVM (definitely the current code needs to be changed to support that).

Thanks,
Chao
> 
> (Imagine if the way to create an eventfd would be to call timerfd_create()
> and then do a special fcntl to turn it into an eventfd but only if it's not
> currently armed.  This would be weird.)
