Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B27650D75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 15:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiLSOhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Dec 2022 09:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiLSOgz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:36:55 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB46712090;
        Mon, 19 Dec 2022 06:36:34 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECC051EC06BD;
        Mon, 19 Dec 2022 15:36:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671460593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Nr0Z4OvkPMBKiUgwrvy1b0JeJ5CuH4u8cdycIbF3VTo=;
        b=g4O8WnDjjWmrtbFmMTY4G0yltCqzIeXhWywY3xwLBgdFTN9TCYZMZhAq9By4cTHHjnVkHt
        354idtEXaLQwUDtNstFC6rPiAS1iw8va+w5OrbtVNCuvMSntL0hbmQcddYbRIVl0pEcCkP
        SG+jpLF4Ne/7gzC4KSRDGyQn3EtYD1Q=
Date:   Mon, 19 Dec 2022 15:36:28 +0100
From:   Borislav Petkov <bp@alien8.de>
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
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <Y6B27MpZO8o1Asfe@zn.tnic>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 02, 2022 at 02:13:41PM +0800, Chao Peng wrote:
> In memory encryption usage, guest memory may be encrypted with special
> key and can be accessed only by the guest itself. We call such memory
> private memory. It's valueless and sometimes can cause problem to allow

valueless?

I can't parse that.

> userspace to access guest private memory. This new KVM memslot extension
> allows guest private memory being provided through a restrictedmem
> backed file descriptor(fd) and userspace is restricted to access the
> bookmarked memory in the fd.

bookmarked?

> This new extension, indicated by the new flag KVM_MEM_PRIVATE, adds two
> additional KVM memslot fields restricted_fd/restricted_offset to allow
> userspace to instruct KVM to provide guest memory through restricted_fd.
> 'guest_phys_addr' is mapped at the restricted_offset of restricted_fd
> and the size is 'memory_size'.
> 
> The extended memslot can still have the userspace_addr(hva). When use, a

"When un use, ..."

...

> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index a8e379a3afee..690cb21010e7 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -50,6 +50,8 @@ config KVM
>  	select INTERVAL_TREE
>  	select HAVE_KVM_PM_NOTIFIER if PM
>  	select HAVE_KVM_MEMORY_ATTRIBUTES
> +	select HAVE_KVM_RESTRICTED_MEM if X86_64
> +	select RESTRICTEDMEM if HAVE_KVM_RESTRICTED_MEM

Those deps here look weird.

RESTRICTEDMEM should be selected by TDX_GUEST as it can't live without
it.

Then you don't have to select HAVE_KVM_RESTRICTED_MEM simply because of
X86_64 - you need that functionality when the respective guest support
is enabled in KVM.

Then, looking forward into your patchset, I'm not sure you even
need HAVE_KVM_RESTRICTED_MEM - you could make it all depend on
CONFIG_RESTRICTEDMEM. But that's KVM folks call - I'd always aim for
less Kconfig items because we have waay too many.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
