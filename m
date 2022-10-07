Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E445F7737
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 13:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJGLOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 07:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJGLOK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1519A223C;
        Fri,  7 Oct 2022 04:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8372961C4E;
        Fri,  7 Oct 2022 11:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF19C433C1;
        Fri,  7 Oct 2022 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665141248;
        bh=iGUUEynvCAjegBrsy6JU4OD39853Ax+NThhfisNR9Vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmKEzZfv+NcFm5KZPC8vC7ZMGO+4smagpqxidG4f8sTZ/z8q2aoMCJSNtysPorB+u
         kk9P97XlyfQbbtnFo8LHPNJFX9dz+rglzxIJfihqhOEfRZ95SMPj67dZ/fvnuNbSqC
         jqfHkAdl/kZOqmVgzI+rs0S1M/uPV1KhYkYw7RvKkChyMhuiR2/2wEETdeyyy8vdL+
         xSn8DoYpH/zTYYkmMvP9NOyVC0t2HvDfp9uL80OcPykiAatvUGYg8ebg5q6VkchIVf
         DXvK7t9XwhCTk3XnR5NXjkt3/qkelWVMPuwnPC3EPAwGRYke53ktd+UBomw4T2mbx6
         O0+yu62YgKnxg==
Date:   Fri, 7 Oct 2022 14:14:03 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 2/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <Y0AJ++m/TxoscOZg@kernel.org>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-3-chao.p.peng@linux.intel.com>
 <Yz7s+JIexAHJm5dc@kernel.org>
 <Yz7vHXZmU3EpmI0j@kernel.org>
 <Yz71ogila0mSHxxJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz71ogila0mSHxxJ@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:34:58PM +0000, Sean Christopherson wrote:
> On Thu, Oct 06, 2022, Jarkko Sakkinen wrote:
> > On Thu, Oct 06, 2022 at 05:58:03PM +0300, Jarkko Sakkinen wrote:
> > > On Thu, Sep 15, 2022 at 10:29:07PM +0800, Chao Peng wrote:
> > > > This new extension, indicated by the new flag KVM_MEM_PRIVATE, adds two
> > > > additional KVM memslot fields private_fd/private_offset to allow
> > > > userspace to specify that guest private memory provided from the
> > > > private_fd and guest_phys_addr mapped at the private_offset of the
> > > > private_fd, spanning a range of memory_size.
> > > > 
> > > > The extended memslot can still have the userspace_addr(hva). When use, a
> > > > single memslot can maintain both private memory through private
> > > > fd(private_fd/private_offset) and shared memory through
> > > > hva(userspace_addr). Whether the private or shared part is visible to
> > > > guest is maintained by other KVM code.
> > > 
> > > What is anyway the appeal of private_offset field, instead of having just
> > > 1:1 association between regions and files, i.e. one memfd per region?
> 
> Modifying memslots is slow, both in KVM and in QEMU (not sure about Google's VMM).
> E.g. if a vCPU converts a single page, it will be forced to wait until all other
> vCPUs drop SRCU, which can have severe latency spikes, e.g. if KVM is faulting in
> memory.  KVM's memslot updates also hold a mutex for the entire duration of the
> update, i.e. conversions on different vCPUs would be fully serialized, exacerbating
> the SRCU problem.
> 
> KVM also has historical baggage where it "needs" to zap _all_ SPTEs when any
> memslot is deleted.
> 
> Taking both a private_fd and a shared userspace address allows userspace to convert
> between private and shared without having to manipulate memslots.

Right, this was really good explanation, thank you.

Still wondering could this possibly work (or not):

1. Union userspace_addr and private_fd.
2. Instead of introducing private_offset, use guest_phys_addr as the
   offset.
  
BR, Jarkko
