Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4895D48472A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 18:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiADRnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 12:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiADRnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:43:55 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E5CC061761
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jan 2022 09:43:55 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 8so33315310pgc.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jan 2022 09:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=13+cbru1EicSyFl290RL62qNhQ55+dHM2uIjjFzOwWQ=;
        b=qiqd4ZBl5BqJHPRL1WkKqev6zYNCBKXygXrnDR+B8P5U+ncr+nyYGcNLR7VtJRMbR+
         nu+XvQR0ZvTHDgijE3+Ephw/fASHy6xXWP0G97pDtjkfz1dKRsQLmc6PexXKZ6eOiTmr
         wLjrAbgjf1xpI3WYhgSKqeScUoNRXJvAlDnLd371vsx/3pwzIE9KXiKfaj3I/ZdHjqA8
         xBpOOwl5sZ+x9RvltjE0m8jfdToQt4TESxL7mb+P6lBPBE7kEi7z47aEbg/ZFbrTwxVh
         thDTi9pkTIUf/VFrmufk4T+y2xu0pNllCtxK03hhz2Xp5v22QQLi5JXx3XoNiDlljx2j
         eUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=13+cbru1EicSyFl290RL62qNhQ55+dHM2uIjjFzOwWQ=;
        b=4M9BmZZSBYTgh4Kx4Yq1qYjH6qv3HFXsAFkLRDcpshzIS5as87HQ3LJbt91Nw7gJsu
         eCPI8R2nM16PWER0imywFsw2rdejdqYRnuvGJkcO7kGy39F/AgqJmlhBk5aWnRSkOy0i
         OwuEZ4dM8Uxesfd9S83+HZ3sjOXuyJBMHwL4mw2aLBmawYDW2/tRh6sTcsu2RjohGwSM
         FuFZd+mRrEcv8yHTJ8bWoEQzc1soox9LKX0tNHUddMGAwHvQGXVcaes7xe5+Efl+/mqU
         Lw9CihcZSbU6MTp/8DQJz+DLnDFxNVk7tYlAe2FofjkFU1bdFGiI84w3Ca8nMPyxjKoj
         ox+g==
X-Gm-Message-State: AOAM533YcoVxvoTy1V9EOdJgdKNYDB7L+oWWQQGMlyIR//cygcZvvyA5
        /G2xlZlwdcs3qISlldykiNexXw==
X-Google-Smtp-Source: ABdhPJzQtrrXhdr9JNHtClHOyyxM1wCawkxYoqgHsdkj3QcxdAXEJm9cAZOEh3vO62LsqFUjGuIFog==
X-Received: by 2002:a63:ba47:: with SMTP id l7mr46031570pgu.75.1641318234513;
        Tue, 04 Jan 2022 09:43:54 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n14sm34881764pgd.80.2022.01.04.09.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:43:53 -0800 (PST)
Date:   Tue, 4 Jan 2022 17:43:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v3 kvm/queue 05/16] KVM: Maintain ofs_tree for fast
 memslot lookup by file offset
Message-ID: <YdSHViDXGkjz5t/Q@google.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-6-chao.p.peng@linux.intel.com>
 <YcS5uStTallwRs0G@google.com>
 <20211224035418.GA43608@chaop.bj.intel.com>
 <YcuGGCo5pR31GkZE@google.com>
 <20211231022636.GA7025@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231022636.GA7025@chaop.bj.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 31, 2021, Chao Peng wrote:
> On Tue, Dec 28, 2021 at 09:48:08PM +0000, Sean Christopherson wrote:
> >KVM handles
> > reverse engineering the memslot to get the offset and whatever else it needs.
> > notify_fallocate() and other callbacks are unchanged, though they probably can
> > drop the inode.
> > 
> > E.g. likely with bad math and handwaving on the overlap detection:
> > 
> > int kvm_private_fd_fallocate_range(void *owner, pgoff_t start, pgoff_t end)
> > {
> > 	struct kvm_memory_slot *slot = owner;
> > 	struct kvm_gfn_range gfn_range = {
> > 		.slot	   = slot,
> > 		.start	   = (start - slot->private_offset) >> PAGE_SHIFT,
> > 		.end	   = (end - slot->private_offset) >> PAGE_SHIFT,
> > 		.may_block = true,
> > 	};
> > 
> > 	if (!has_overlap(slot, start, end))
> > 		return 0;
> > 
> > 	gfn_range.end = min(gfn_range.end, slot->base_gfn + slot->npages);
> > 
> > 	kvm_unmap_gfn_range(slot->kvm, &gfn_range);
> > 	return 0;
> > }
> 
> I understand this KVM side handling, but again one fd can have multiple
> memslots. How shmem decides to notify which memslot from a list of
> memslots when it invokes the notify_fallocate()? Or just notify all
> the possible memslots then let KVM to check? 

Heh, yeah, those are the two choices.  :-)

Either the backing store needs to support registering callbacks for specific,
arbitrary ranges, or it needs to invoke all registered callbacks.  Invoking all
callbacks has my vote; it's much simpler to implement and is unlikely to incur
meaningful overhead.  _Something_ has to find the overlapping ranges, that cost
doesn't magically go away if it's pushed into the backing store.

Note, invoking all notifiers is also aligned with the mmu_notifier behavior.
