Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F8C5F5C61
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 00:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJEWGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 18:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJEWGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:06:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CDF558FE;
        Wed,  5 Oct 2022 15:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 249DAB81F47;
        Wed,  5 Oct 2022 22:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B71C433C1;
        Wed,  5 Oct 2022 22:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665007561;
        bh=FZGWwvWcMPwpxhSCd2CpWK7kBaSufMBeg2cE71W2BOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kdwp8mBwA4DxgGXMH8RNJfp6niTBmA+A9hvnQifpjbB/DwhTINU4J92nzxhIihcHU
         3HR6iqLo8aUthnB8oK7k1r0em3qa9j73goc4WNh/TYrAcrV/j62fbfBQtjg7XtfHWo
         qCO/KBvOtXmtDmsgBesgS10c3dnJ6gGWsOHMnVypAyumop+29fsWTApZgz7r0wS7/X
         6z0++64qq/oG9Y0sPvjb+ba5dE+/RUzUVbhDILKLMRTsU88wTBvOOBUUs6KszlPfrC
         f5joADFiEGvpbEDfO8T7W7oqNqs7Hg84FMWv/ZXI4zp9NyZbNLqY+wby7ze6dNi6ti
         3a8z6u/Jb6R5g==
Date:   Thu, 6 Oct 2022 01:05:57 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
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
Message-ID: <Yz3/xWWaIRr6k1d3@kernel.org>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-3-chao.p.peng@linux.intel.com>
 <Yz2AwVjymt7xb1sL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz2AwVjymt7xb1sL@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 05, 2022 at 04:04:05PM +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 15, 2022 at 10:29:07PM +0800, Chao Peng wrote:
> > In memory encryption usage, guest memory may be encrypted with special
> > key and can be accessed only by the VM itself. We call such memory
> > private memory. It's valueless and sometimes can cause problem to allow
> > userspace to access guest private memory. This patch extends the KVM
> > memslot definition so that guest private memory can be provided though
> > an inaccessible_notifier enlightened file descriptor (fd), without being
> > mmaped into userspace.
> > 
> > This new extension, indicated by the new flag KVM_MEM_PRIVATE, adds two
> > additional KVM memslot fields private_fd/private_offset to allow
> > userspace to specify that guest private memory provided from the
> > private_fd and guest_phys_addr mapped at the private_offset of the
> > private_fd, spanning a range of memory_size.
> > 
> > The extended memslot can still have the userspace_addr(hva). When use, a
> > single memslot can maintain both private memory through private
> > fd(private_fd/private_offset) and shared memory through
> > hva(userspace_addr). Whether the private or shared part is visible to
> > guest is maintained by other KVM code.
> > 
> > Since there is no userspace mapping for private fd so we cannot
> > get_user_pages() to get the pfn in KVM, instead we add a new
> > inaccessible_notifier in the internal memslot structure and rely on it
> > to get pfn by interacting with the memory file systems.
> > 
> > Together with the change, a new config HAVE_KVM_PRIVATE_MEM is added and
> > right now it is selected on X86_64 for Intel TDX usage.
> > 
> > To make code maintenance easy, internally we use a binary compatible
> > alias struct kvm_user_mem_region to handle both the normal and the
> > '_ext' variants.
> > 
> > Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> 
> What if userspace_addr would contain address of an extension structure,
> if the flag is set, instead of shared address? I.e. interpret that field
> differently (could be turned into union too ofc).
> 
> That idea could be at least re-used, if there's ever any new KVM_MEM_*
> flags that would need an extension.
> 
> E.g. have struct kvm_userspace_memory_private, which contains shared
> address, fd and the offset.

Or add a new ioctl number instead of messing with the existing
parameter structure, e.g. KVM_SET_USER_MEMORY_REGION_PRIVATE.

With this alternative and the current approach in the patch,
it would be better just to redefine the struct fields that are
common.

It actually would reduce redundancy because then there is no
need to create that somewhat confusing kernel version of the
same struct, right? You don't save any redundancy with this
"embedded struct" approach.

BR, Jarkko
