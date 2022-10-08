Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8326C5F8638
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiJHRgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 13:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiJHRgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 13:36:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34A041526;
        Sat,  8 Oct 2022 10:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FF7960AE5;
        Sat,  8 Oct 2022 17:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E23CC433D7;
        Sat,  8 Oct 2022 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665250553;
        bh=nAFecTafpi6Cui7vA6b8YkSuKqU56pFcMIrM2l6VfXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJ79rTDZDoZOoqyJ1p4euj7MzBAC4RxT7l1N9Iy0VIoZjXdoV8YF2DYVUomZrPgZJ
         UusXvel6i15sqSnYL9payXgqHy9nCDYdhs2SLj/peFcHVwsGAdd4vQYt04Fms8MefY
         n0golxj0X0OydUL1DHB7B5ncQNksTTImYnmYjABdGXeyFXvwxEMGpfVZQP4fRjgZ8i
         HYtTZAcmfbQFMOam3HjFBPVl+pgxt71ZlFeuP6bCyAVOXTLIlXHlr+wNjFquTOZiRX
         rRqj1YugIgbl2xgs4xtDtFK8WOkGXluEJO8Pn613Vs5w/RYaEtv/WzTWeLVOynb0hT
         V4MVh/JzSrXBg==
Date:   Sat, 8 Oct 2022 20:35:47 +0300
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
Message-ID: <Y0G085xCmFBxSodG@kernel.org>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-3-chao.p.peng@linux.intel.com>
 <Yz7s+JIexAHJm5dc@kernel.org>
 <Yz7vHXZmU3EpmI0j@kernel.org>
 <Yz71ogila0mSHxxJ@google.com>
 <Y0AJ++m/TxoscOZg@kernel.org>
 <Y0A+rogB6TRDtbyE@google.com>
 <Y0CgFIq6JnHmdWrL@kernel.org>
 <Y0GiEW0cYCNx5jyK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0GiEW0cYCNx5jyK@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 08, 2022 at 07:15:17PM +0300, Jarkko Sakkinen wrote:
> On Sat, Oct 08, 2022 at 12:54:32AM +0300, Jarkko Sakkinen wrote:
> > On Fri, Oct 07, 2022 at 02:58:54PM +0000, Sean Christopherson wrote:
> > > On Fri, Oct 07, 2022, Jarkko Sakkinen wrote:
> > > > On Thu, Oct 06, 2022 at 03:34:58PM +0000, Sean Christopherson wrote:
> > > > > On Thu, Oct 06, 2022, Jarkko Sakkinen wrote:
> > > > > > On Thu, Oct 06, 2022 at 05:58:03PM +0300, Jarkko Sakkinen wrote:
> > > > > > > On Thu, Sep 15, 2022 at 10:29:07PM +0800, Chao Peng wrote:
> > > > > > > > This new extension, indicated by the new flag KVM_MEM_PRIVATE, adds two
> > > > > > > > additional KVM memslot fields private_fd/private_offset to allow
> > > > > > > > userspace to specify that guest private memory provided from the
> > > > > > > > private_fd and guest_phys_addr mapped at the private_offset of the
> > > > > > > > private_fd, spanning a range of memory_size.
> > > > > > > > 
> > > > > > > > The extended memslot can still have the userspace_addr(hva). When use, a
> > > > > > > > single memslot can maintain both private memory through private
> > > > > > > > fd(private_fd/private_offset) and shared memory through
> > > > > > > > hva(userspace_addr). Whether the private or shared part is visible to
> > > > > > > > guest is maintained by other KVM code.
> > > > > > > 
> > > > > > > What is anyway the appeal of private_offset field, instead of having just
> > > > > > > 1:1 association between regions and files, i.e. one memfd per region?
> > > > > 
> > > > > Modifying memslots is slow, both in KVM and in QEMU (not sure about Google's VMM).
> > > > > E.g. if a vCPU converts a single page, it will be forced to wait until all other
> > > > > vCPUs drop SRCU, which can have severe latency spikes, e.g. if KVM is faulting in
> > > > > memory.  KVM's memslot updates also hold a mutex for the entire duration of the
> > > > > update, i.e. conversions on different vCPUs would be fully serialized, exacerbating
> > > > > the SRCU problem.
> > > > > 
> > > > > KVM also has historical baggage where it "needs" to zap _all_ SPTEs when any
> > > > > memslot is deleted.
> > > > > 
> > > > > Taking both a private_fd and a shared userspace address allows userspace to convert
> > > > > between private and shared without having to manipulate memslots.
> > > > 
> > > > Right, this was really good explanation, thank you.
> > > > 
> > > > Still wondering could this possibly work (or not):
> > > > 
> > > > 1. Union userspace_addr and private_fd.
> > > 
> > > No, because userspace needs to be able to provide both userspace_addr (shared
> > > memory) and private_fd (private memory) for a single memslot.
> > 
> > Got it, thanks for clearing my misunderstandings on this topic, and it
> > is quite obviously visible in 5/8 and 7/8. I.e. if I got it right,
> > memblock can be partially private, and you dig the shared holes with
> > KVM_MEMORY_ENCRYPT_UNREG_REGION. We have (in Enarx) ATM have memblock
> > per host mmap, I was looking into this dilated by that mindset but makes
> > definitely sense to support that.
> 
> For me the most useful reference with this feature is kvm_set_phys_mem()
> implementation in privmem-v8 branch. Took while to find it because I did
> not have much experience with QEMU code base. I'd even recommend to mention
> that function in the cover letter because it is really good reference on
> how this feature is supposed to be used.

While learning QEMU code, I also noticed bunch of comparison like this:

if (slot->flags | KVM_MEM_PRIVATE)

I guess those could be just replaced with unconditional fills as it does
not do any harm, if KVM_MEM_PRIVATE is not set.

BR, Jarkko
