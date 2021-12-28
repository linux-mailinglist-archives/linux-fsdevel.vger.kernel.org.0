Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B119480D89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 22:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhL1VsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 16:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhL1VsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:48:13 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0538DC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 13:48:13 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f8so6859265pgf.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 13:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AINbZEGCl8z/7FJgJFS1bW6C73bLWpVUK2DVW0sKcL8=;
        b=i8BDfu3Cbnb3Viigeb90+/RoyFCsdY4zmmhG67xy1/xKkRGBvV7zYsDSfUujxRz1M6
         WKWW+hF3hWcTBahPXxiAE2dd5TzfFfyW+kaCuL37DnTaDADymu2gDTSIFocZkVOxl6Bm
         CXzjV9xx6eCJ5Fw/xZYWhUhKQdZf9vwKMKPt6PajLZqspTsivs90pzHPbq5ZOF4iu0Al
         EogQs7/Dz0D2oeqbOHpA93p/WmGqQRboZHG7tge27x0qsYapE32/3MTkgYVB/z5hT7Oh
         xGGAYApGd3to+yh2r1kf72CjhAP/3e8BbkQgzoMOcENXvMEuD5Cz7S0TaFuhwptpdVII
         KgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AINbZEGCl8z/7FJgJFS1bW6C73bLWpVUK2DVW0sKcL8=;
        b=mvp/Ac9owV0tw6uoT6ywNT19pgLqCedGD+/V0OaQD0h25EEgGHIbo4cOseSkoc0A9N
         pY8xC8t9Kkq6ska83pGLzVLyK81gYw4qRQ4BG/tSPSAUtt3JlcRwYAlaWcjQ3+MjenHj
         UC5gVPH5atLiW5/rRvA9CCdlYHqmFY/lCp08AGb2A9TyUwffGeVUJSZROKYLik5F7xA+
         Ycc3QOLL6U8S6E5b5XQT/5BIySH+hQQZB2PPG1zzqGjoQ5mu4e2DZdK6MwlN2P+8vHI8
         lxb1AqZVeA6nYlY/7x3mRaE1yE0OaE29+K/YnZuGwIX3KI67MXpp5JFB0XxVNC7FZnop
         61FA==
X-Gm-Message-State: AOAM533/iq1bS1smmsFoozFpk6ndyvLwNrWbe+PxbyWF36mAxdh/QFBJ
        LNI7Gwz3NxA4Jq/dQvqoQygvfw==
X-Google-Smtp-Source: ABdhPJyKE3UVODPS1fshDuKNztoIqtf+jVLcm9grjNtuxnSRjURqBYuIllKdU8KU2kEC55IFpKtL1g==
X-Received: by 2002:a63:711a:: with SMTP id m26mr3052221pgc.49.1640728092301;
        Tue, 28 Dec 2021 13:48:12 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t8sm113511pfj.114.2021.12.28.13.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:48:11 -0800 (PST)
Date:   Tue, 28 Dec 2021 21:48:08 +0000
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
Message-ID: <YcuGGCo5pR31GkZE@google.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-6-chao.p.peng@linux.intel.com>
 <YcS5uStTallwRs0G@google.com>
 <20211224035418.GA43608@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224035418.GA43608@chaop.bj.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 24, 2021, Chao Peng wrote:
> On Thu, Dec 23, 2021 at 06:02:33PM +0000, Sean Christopherson wrote:
> > On Thu, Dec 23, 2021, Chao Peng wrote:
> > > Similar to hva_tree for hva range, maintain interval tree ofs_tree for
> > > offset range of a fd-based memslot so the lookup by offset range can be
> > > faster when memslot count is high.
> > 
> > This won't work.  The hva_tree relies on there being exactly one virtual address
> > space, whereas with private memory, userspace can map multiple files into the
> > guest at different gfns, but with overlapping offsets.
> 
> OK, that's the point.
> 
> > 
> > I also dislike hijacking __kvm_handle_hva_range() in patch 07.
> > 
> > KVM also needs to disallow mapping the same file+offset into multiple gfns, which
> > I don't see anywhere in this series.
> 
> This can be checked against file+offset overlapping with existing slots
> when register a new one.
> 
> > 
> > In other words, there needs to be a 1:1 gfn:file+offset mapping.  Since userspace
> > likely wants to allocate a single file for guest private memory and map it into
> > multiple discontiguous slots, e.g. to skip the PCI hole, the best idea off the top
> > of my head would be to register the notifier on a per-slot basis, not a per-VM
> > basis.  It would require a 'struct kvm *' in 'struct kvm_memory_slot', but that's
> > not a huge deal.
> > 
> > That way, KVM's notifier callback already knows the memslot and can compute overlap
> > between the memslot and the range by reversing the math done by kvm_memfd_get_pfn().
> > Then, armed with the gfn and slot, invalidation is just a matter of constructing
> > a struct kvm_gfn_range and invoking kvm_unmap_gfn_range().
> 
> KVM is easy but the kernel bits would be difficulty, it has to maintain
> fd+offset to memslot mapping because one fd can have multiple memslots,
> it need decide which memslot needs to be notified.

No, the kernel side maintains an opaque pointer like it does today, KVM handles
reverse engineering the memslot to get the offset and whatever else it needs.
notify_fallocate() and other callbacks are unchanged, though they probably can
drop the inode.

E.g. likely with bad math and handwaving on the overlap detection:

int kvm_private_fd_fallocate_range(void *owner, pgoff_t start, pgoff_t end)
{
	struct kvm_memory_slot *slot = owner;
	struct kvm_gfn_range gfn_range = {
		.slot	   = slot,
		.start	   = (start - slot->private_offset) >> PAGE_SHIFT,
		.end	   = (end - slot->private_offset) >> PAGE_SHIFT,
		.may_block = true,
	};

	if (!has_overlap(slot, start, end))
		return 0;

	gfn_range.end = min(gfn_range.end, slot->base_gfn + slot->npages);

	kvm_unmap_gfn_range(slot->kvm, &gfn_range);
	return 0;
}

