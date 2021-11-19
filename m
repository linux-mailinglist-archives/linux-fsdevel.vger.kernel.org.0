Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAC2457752
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 20:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbhKSTuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 14:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbhKSTuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 14:50:54 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3310DC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 11:47:48 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id b11so7832525qvm.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 11:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b8HwEu/l2NAGuMcWKH5jQM9AiiPfyTyPdU6LnAiTwjE=;
        b=eXYLScpgWGOSOqBVSQtdTVD++xT2fUA+29WU5uRjLvVVyE3JEysFYMD3c5m3MUuwhi
         2/dEOlgu6r/9aoIpMC/3VJ29OZt+Y5gY+DeEvBjU4JCXVvlQTRyE4kipd4bnNE4VfygO
         gi2wVXk5KMG1My3gjGCyppqDyPaW46HK5/4P7hKcEdPibptKWHECr7E7AOpM6qgeV0Gk
         5XFBGCzNpMsoTIPVISn+JIpRXTxD1C4vDaEFVrlgHo58JmtwUKTR1DrLx7zfgn5Z1MG8
         NtfI2Hh1jxXAWFSVfmkK0Vl+a+bgSvADPQFiF6otkPWuXnCgFRePBcvR1qLvCTFwllWk
         rJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b8HwEu/l2NAGuMcWKH5jQM9AiiPfyTyPdU6LnAiTwjE=;
        b=oCuK+h3JyrVKrMWnqidwJtaH8+cqSEsLplnTf2O1UCGYR4eVUooRQv/AQCDXUo1TTF
         O3UgXbcI1xZp6s64Xc4UCFPlQOY1fUFmSNnXlLdqD54Ns4kG+aX89kHXiwHfYSQmf43H
         z0py79w2YdHtH1SqN0A8M5vdX5g4WXyt2y3O52Wyz3ziVbnsbEHAJP8V5GpU/cF/z0A0
         SnlKAMLcextiMRHmzE9RcP7GbA8nXqbljut3WvWK5VSdzoXY1LbQUhF9b0gGbtzOmOog
         /1sXR71z7Yk+Fbq0vWWKrb1m1DJ2YwTXER+KtrkkdXjlULyiNI247uPhE1rSo4xU4JT1
         +1rA==
X-Gm-Message-State: AOAM532IgJdivtaPe3D9vv0iL72P0myGXxzsL9cZcehg4r5oaPlpdU2/
        Lbyg1HWlc03lSaP9nTMUyfj1RA==
X-Google-Smtp-Source: ABdhPJwYijRrK8qgpzAhCkRXoqK9YWbXTodbosR5h3I14ZDdTjYbPRJ8dYw0rADALVOrpBmC6Q7oWg==
X-Received: by 2002:a05:6214:4107:: with SMTP id kc7mr76325935qvb.57.1637351267376;
        Fri, 19 Nov 2021 11:47:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id d13sm339977qkn.100.2021.11.19.11.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 11:47:46 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mo9rO-00Cdid-BP; Fri, 19 Nov 2021 15:47:46 -0400
Date:   Fri, 19 Nov 2021 15:47:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sean Christopherson <seanjc@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Message-ID: <20211119194746.GM876299@ziepe.ca>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
 <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
 <YZf4aAlbyeWw8wUk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZf4aAlbyeWw8wUk@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 07:18:00PM +0000, Sean Christopherson wrote:
> On Fri, Nov 19, 2021, David Hildenbrand wrote:
> > On 19.11.21 16:19, Jason Gunthorpe wrote:
> > > As designed the above looks useful to import a memfd to a VFIO
> > > container but could you consider some more generic naming than calling
> > > this 'guest' ?
> > 
> > +1 the guest terminology is somewhat sob-optimal.
> 
> For the F_SEAL part, maybe F_SEAL_UNMAPPABLE?

Perhaps INACCESSIBLE?

> No ideas for the kernel API, but that's also less concerning since
> it's not set in stone.  I'm also not sure that dedicated APIs for
> each high-ish level use case would be a bad thing, as the semantics
> are unlikely to be different to some extent.  E.g. for the KVM use
> case, there can be at most one guest associated with the fd, but
> there can be any number of VFIO devices attached to the fd.

Even the kvm thing is not a hard restriction when you take away
confidential compute.

Why can't we have multiple KVMs linked to the same FD if the memory
isn't encrypted? Sure it isn't actually useful but it should work
fine.

Supporting only one thing is just a way to avoid having a linked list
of clients to broadcast invalidations too - for instance by using a
standard notifier block...

Also, how does dirty tracking work on this memory?

Jason
