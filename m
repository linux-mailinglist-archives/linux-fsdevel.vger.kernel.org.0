Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F66E65E9B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 12:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjAELXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 06:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjAELXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:23:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB0F4E424;
        Thu,  5 Jan 2023 03:23:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEDC761997;
        Thu,  5 Jan 2023 11:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFDCC433F0;
        Thu,  5 Jan 2023 11:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672917785;
        bh=MBba54j0/BydJyfXJmD3sqygtai2bpp7J4HBZnAheDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/NyAx/uidnIXzxaIjlXTomDF3irlmzZ+PCY7P4/TbnJUSJRD8UQ7c36MWpV71/Tn
         SYhuTjsjWfdmPqSLK8QE0FamFzSLRaWdbDObhW80t4Yhafl1J5jJ3bezM77sFrqnWb
         7d/hzJOkyMc1nznD1fbjGD1fMn5JHCEwQ/N74LIUmis17aSfr3aoYAViHr5UwZIwBZ
         vMhpJpECkrYJfV357eN/7+fWF/0BXMk6663rsy2BQ1Hqv+wpHrlCHOkVeWNUyq7jDe
         MlCQt3z62ym96XHYhLSz9H4UynTy+xVr4M24uMVE/AY6qAUqNbC4TlEczADxwM5pwj
         vjHmuNVYuOTeg==
Date:   Thu, 5 Jan 2023 11:23:01 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
Message-ID: <Y7azFdnnGAdGPqmv@kernel.org>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 02, 2022 at 02:13:41PM +0800, Chao Peng wrote:
> In memory encryption usage, guest memory may be encrypted with special
> key and can be accessed only by the guest itself. We call such memory
> private memory. It's valueless and sometimes can cause problem to allow
> userspace to access guest private memory. This new KVM memslot extension
> allows guest private memory being provided through a restrictedmem
> backed file descriptor(fd) and userspace is restricted to access the
> bookmarked memory in the fd.
> 
> This new extension, indicated by the new flag KVM_MEM_PRIVATE, adds two
> additional KVM memslot fields restricted_fd/restricted_offset to allow
> userspace to instruct KVM to provide guest memory through restricted_fd.
> 'guest_phys_addr' is mapped at the restricted_offset of restricted_fd
> and the size is 'memory_size'.
> 
> The extended memslot can still have the userspace_addr(hva). When use, a
> single memslot can maintain both private memory through restricted_fd
> and shared memory through userspace_addr. Whether the private or shared
> part is visible to guest is maintained by other KVM code.
> 
> A restrictedmem_notifier field is also added to the memslot structure to
> allow the restricted_fd's backing store to notify KVM the memory change,
> KVM then can invalidate its page table entries or handle memory errors.
> 
> Together with the change, a new config HAVE_KVM_RESTRICTED_MEM is added
> and right now it is selected on X86_64 only.
> 
> To make future maintenance easy, internally use a binary compatible
> alias struct kvm_user_mem_region to handle both the normal and the
> '_ext' variants.

Feels bit hacky IMHO, and more like a completely new feature than
an extension.

Why not just add a new ioctl? The commit message does not address
the most essential design here.

BR, Jarkko
