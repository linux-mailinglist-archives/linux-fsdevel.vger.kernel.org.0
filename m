Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2E747E761
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 19:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349684AbhLWSCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 13:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244655AbhLWSCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:02:38 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEA6C061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 10:02:38 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 2so5545664pgb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 10:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F3vp7cNpz2qk0OIvJVZgGpZrlLI8cGs8eddNh3pH4O0=;
        b=V6LVAQd/8UIn8ldsx5JR1O9YpJZeToHbDLZbS7mg8/+loFV7/N7sZ+XhcLN4ER+wrt
         a4OJl94CKbfUSCf2rds4kBh5Lrrm72ej4Vw2jCZdwyaTpvW1Rfri5/b6D0d+XdP6rcLq
         EnCBOIjnXfg4hlKeBatFlHOFTTdwmCQQ6xeF/Ly1U82igCJHWiW1VL+d3kr+QmXcuLv8
         0JyTkQyChwcIVqzmWpqo1NlewbWrHW4RFSMnsRxLAB2r1vNJbOQ7FxBRMK3jdWuCu2Zf
         vQb1n9Yb12+2OopiSqPqPM/6Qm6od8AV54HqElWU29SUVdpkee1DGnFa+7+XiW0B251Y
         fEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F3vp7cNpz2qk0OIvJVZgGpZrlLI8cGs8eddNh3pH4O0=;
        b=MFP+IGCJ/ZXhfACTvGavPftoqfuKl5OhKGH8m2ANwCyZALHmeRrER62pa5hivyChRd
         kcnceq5N7D97gXs1nHQNqCiC6k5VNhIJ/SgBDMoIYoyHwZ4emDhsXBbBIJxLMacFylzC
         K+YjuH7Er2C+OSK2DgUaL8HLNC+ryj9VyzxAe4Vsz0/ue3cswr2VSY2X7J5RO3tFv7qO
         Jkzz0lE20QN9xgeheJNEyAUz7vwXrpCNOZ5XTXqn/TaKwjSvBniW5iiBDcCMTHuENHva
         qMbskGOij4cQQ/FvSsp1jkyOm7+Vt37jxDaGXgGiIRC1rRXW3dTRf4p9gwTPuFHOh6jR
         kaqA==
X-Gm-Message-State: AOAM531Nqbuyz0v9akeQ+h04vr0MgNsjssgJyVyTVIrO1IWJKFZMuJvh
        ePNupl6qO+npoqaLexuHZbu+Cw==
X-Google-Smtp-Source: ABdhPJwrV3ydO2yyHoylZ6+Gjlc1pXLEXn2GLpfX+eRE21Of6xThdp2NrJD74NCN2Jt8w5I9duli3Q==
X-Received: by 2002:a65:648b:: with SMTP id e11mr3022987pgv.138.1640282557705;
        Thu, 23 Dec 2021 10:02:37 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gg23sm9329532pjb.31.2021.12.23.10.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 10:02:36 -0800 (PST)
Date:   Thu, 23 Dec 2021 18:02:33 +0000
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
Message-ID: <YcS5uStTallwRs0G@google.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-6-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223123011.41044-6-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021, Chao Peng wrote:
> Similar to hva_tree for hva range, maintain interval tree ofs_tree for
> offset range of a fd-based memslot so the lookup by offset range can be
> faster when memslot count is high.

This won't work.  The hva_tree relies on there being exactly one virtual address
space, whereas with private memory, userspace can map multiple files into the
guest at different gfns, but with overlapping offsets.

I also dislike hijacking __kvm_handle_hva_range() in patch 07.

KVM also needs to disallow mapping the same file+offset into multiple gfns, which
I don't see anywhere in this series.

In other words, there needs to be a 1:1 gfn:file+offset mapping.  Since userspace
likely wants to allocate a single file for guest private memory and map it into
multiple discontiguous slots, e.g. to skip the PCI hole, the best idea off the top
of my head would be to register the notifier on a per-slot basis, not a per-VM
basis.  It would require a 'struct kvm *' in 'struct kvm_memory_slot', but that's
not a huge deal.

That way, KVM's notifier callback already knows the memslot and can compute overlap
between the memslot and the range by reversing the math done by kvm_memfd_get_pfn().
Then, armed with the gfn and slot, invalidation is just a matter of constructing
a struct kvm_gfn_range and invoking kvm_unmap_gfn_range().
