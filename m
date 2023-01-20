Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E287F676181
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 00:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjATX24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 18:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjATX2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:28:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD2F53FB1;
        Fri, 20 Jan 2023 15:28:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6030620E5;
        Fri, 20 Jan 2023 23:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A1FC433EF;
        Fri, 20 Jan 2023 23:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674257333;
        bh=r2edRcFMISYKtEmPEu1cLKZR7c8iF9zsqqnoWv9hU3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8fMoEgfPYzBd+WPDibH/BLuqUwipoWJwcOyYpJ/Y0H3Rdml9thP589lRa96A/WAP
         uJE5kWD2JscX/Sdjpw0CyzXtfG/LxhSegqHv1fuSmC0iMrjiQf/55jY7QZ7uEHsAoF
         E8dMpHJh4CZNfldG+E9O6D3tHhc/7iue722H30CAwBzz6fKqrWs1mObgaZM6G6vx0B
         6CxilOppA+Ky31fjHsYwZe3m5vUlfrsP8m1+9pPun5WaqAcNvIxLws8pDATrUwg9mj
         ui7nzJ6cNZIPoyAp1NyeZPWJcbL3gGUtyqacFP7P3DAAb/PThvmhPJwGbNBhCwd+HW
         B5OlWz8gR2uWg==
Date:   Fri, 20 Jan 2023 23:28:50 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 3/9] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <Y8sjsvIJONydWpyQ@kernel.org>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
 <Y7azFdnnGAdGPqmv@kernel.org>
 <20230106094000.GA2297836@chaop.bj.intel.com>
 <Y7xrtf9FCuYRYm1q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7xrtf9FCuYRYm1q@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 07:32:05PM +0000, Sean Christopherson wrote:
> On Fri, Jan 06, 2023, Chao Peng wrote:
> > On Thu, Jan 05, 2023 at 11:23:01AM +0000, Jarkko Sakkinen wrote:
> > > On Fri, Dec 02, 2022 at 02:13:41PM +0800, Chao Peng wrote:
> > > > To make future maintenance easy, internally use a binary compatible
> > > > alias struct kvm_user_mem_region to handle both the normal and the
> > > > '_ext' variants.
> > > 
> > > Feels bit hacky IMHO, and more like a completely new feature than
> > > an extension.
> > > 
> > > Why not just add a new ioctl? The commit message does not address
> > > the most essential design here.
> > 
> > Yes, people can always choose to add a new ioctl for this kind of change
> > and the balance point here is we want to also avoid 'too many ioctls' if
> > the functionalities are similar.  The '_ext' variant reuses all the
> > existing fields in the 'normal' variant and most importantly KVM
> > internally can reuse most of the code. I certainly can add some words in
> > the commit message to explain this design choice.
> 
> After seeing the userspace side of this, I agree with Jarkko; overloading
> KVM_SET_USER_MEMORY_REGION is a hack.  E.g. the size validation ends up being
> bogus, and userspace ends up abusing unions or implementing kvm_user_mem_region
> itself.
> 
> It feels absolutely ridiculous, but I think the best option is to do:
> 
> #define KVM_SET_USER_MEMORY_REGION2 _IOW(KVMIO, 0x49, \
> 					 struct kvm_userspace_memory_region2)
> 
> /* for KVM_SET_USER_MEMORY_REGION2 */
> struct kvm_user_mem_region2 {
> 	__u32 slot;
> 	__u32 flags;
> 	__u64 guest_phys_addr;
> 	__u64 memory_size;
> 	__u64 userspace_addr;
> 	__u64 restricted_offset;
> 	__u32 restricted_fd;
> 	__u32 pad1;
> 	__u64 pad2[14];
> }
> 
> And it's consistent with other KVM ioctls(), e.g. KVM_SET_CPUID2.
> 
> Regarding the userspace side of things, please include Vishal's selftests in v11,
> it's impossible to properly review the uAPI changes without seeing the userspace
> side of things.  I'm in the process of reviewing Vishal's v2[*], I'll try to
> massage it into a set of patches that you can incorporate into your series.
> 
> [*] https://lore.kernel.org/all/20221205232341.4131240-1-vannapurve@google.com

+1

BR, Jarkko
