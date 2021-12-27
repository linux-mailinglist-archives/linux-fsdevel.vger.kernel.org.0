Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5976348053F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 00:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhL0Xus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 18:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbhL0Xus (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 18:50:48 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ECCC06173E;
        Mon, 27 Dec 2021 15:50:47 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g2so14555604pgo.9;
        Mon, 27 Dec 2021 15:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jMDYAAEzWKf+ZWKv9FVeegcQUYl4xuyCtWob58cAQWw=;
        b=Mn7hUoT2uvnAFbeYWRxfKqSyou/4u6IWp5Ab9qGalAnlr7CngmbOyRZZC+s5asEIUW
         D9pKUg8BUKSlcrGHpuRE0eVQ4R7/edscU9ohcmHdtsmKqr+Boz5j3tg6LOO5/I88JJv4
         TZK7o2ygufhlP3LYfuzuoWG7p9becxKvBXHa41Cizd2XQ8ivuEkcaWMZ99iHFwZnjN1i
         KeMwOIR2V0jav1n+UfooUNeR5uBznQwTmB2E267YriDa4fRhYLSFBc3Uf4oK+pSoJTaC
         K1JaaZzvNioZAMKg1NKVaFFaQ2xG0686bGDyixKpHfpRm1UO6iFaJuVD9qoCX9mzH8P7
         OoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jMDYAAEzWKf+ZWKv9FVeegcQUYl4xuyCtWob58cAQWw=;
        b=ipoPxSmj4yk7e5sCGclQPtw21XY/kUbGuvicZHjDtKAiFkaIWKTbfHRzSip1uH7Wmn
         YnPmmAdIQg5k6ZAP2qz7F0+yUaU08NzwiOZz6X6RIC7Ke0TsGFEjVoYP93tOuTMApnmM
         MRr07zYVuWPfck5V1kHJlTmS6u1sifycPfRUbJLJhh0KUKvqheOHya7I9MKYKo2AEazv
         lD6/kwFw5Fsv0fbPTYp16pjrbZZttltdLVPT8H+uvJZKCFJdDvz5HOm3soxuNSOWUGkR
         ZI2lgJc1fPYlG8bI6LmPyrqeV7gP8YkbO4NOk+8ZkG+RuIjTiGxYt9deA8KWmsnZv/lw
         Ljvw==
X-Gm-Message-State: AOAM533nUHlu+h0BRza8iDp1m8CLLOLSAo90qg/5bprG8+eSvW46luQL
        Q/5VNwcpCyu4slvh/ZPke7o=
X-Google-Smtp-Source: ABdhPJyliKjaqPaj3bkR5OEDX+2h8UmXBD78mFpsM4oAqOKbEenA5uObRsI4rm3mReETZDeq4yKueA==
X-Received: by 2002:a62:158f:0:b0:4ba:b456:24b9 with SMTP id 137-20020a62158f000000b004bab45624b9mr19854677pfv.86.1640649047357;
        Mon, 27 Dec 2021 15:50:47 -0800 (PST)
Received: from localhost (176.222.229.35.bc.googleusercontent.com. [35.229.222.176])
        by smtp.gmail.com with ESMTPSA id 10sm18533824pfm.56.2021.12.27.15.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 15:50:46 -0800 (PST)
Date:   Tue, 28 Dec 2021 07:50:42 +0800
From:   Yao Yuan <yaoyuan0329os@gmail.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v3 kvm/queue 05/16] KVM: Maintain ofs_tree for fast
 memslot lookup by file offset
Message-ID: <20211227235042.rmnwzcqy6ujj75zp@sapienza>
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

On Fri, Dec 24, 2021 at 11:54:18AM +0800, Chao Peng wrote:
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

How about pass "context" of fd (e.g. the gfn/hva start point) when register
the invalidation notifier to fd, then in callback kvm can convert the
offset to absolute hva/gfn with such "context", then do memslot invalidation.

>
> Thanks,
> Chao
