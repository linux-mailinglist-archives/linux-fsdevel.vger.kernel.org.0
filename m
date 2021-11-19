Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA6C4576F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 20:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhKSTVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 14:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhKSTVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 14:21:07 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B6CC061748
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 11:18:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so9599631pjb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 11:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g/YNskCC8H0pIrRty3bOxTWWIwZezM/dF8uipgTGVfY=;
        b=CNOzkM2IBiGjqfRhSRYpA8+aOR9+w9kYa1mO17Fub/lEhXiodlJQQbYvAU23XPSB80
         zEPvGqgAhRJ6Ac9fwqtRfF+TRjsCcSQq5iPvk/1Ntl7JnciUfiF+ZDILvu0CHa2qGnpl
         ujk4JKugJX/qAenq8IEMYsdgtnjBtqpUR91i9SBdt8L7pGQrEmbiL4/gffr02rrMSJmz
         6yzyBXWa8jt0zBA9CA494YG0zM4LbpueA4wdoIYm5oesyznYRillp/PJwv9KFNX7usVm
         7PTxEHROAZHj6Qj+AaUATSaSV1EpFTybV/lhNnk/ZpIoUTNLB6A6TpiLrhOQ7Y6XFsOL
         ut9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g/YNskCC8H0pIrRty3bOxTWWIwZezM/dF8uipgTGVfY=;
        b=l3cG5pIC30TaRtgl6Tg96kxeC8GgNv6NzEIUzZ87IK9Tb5RbzxSdmxuFq5edJdW1eC
         Z/PbTncl5wb0yeO5DelSws6GX5NfFBHVzZhLOX6HFu7cmCFMSuZdecMqRle7p5avTqJF
         WyepziI+hVC58JgVhQO4pAYjR/UfoxEszhxHNyHK1Xv0H3+B6NMAC3ZtMsJfUeB9fQ/0
         X2fybS5/DPp4lv0i4XY6snjInQMGyslf8XVm+ntPbSXLZNCUSRar2/zk21Yjw4TCz/YV
         ktBprPusib6s/urwmkCONhvGtxApB2gqrKcK24KKC43G89X4/mAWSG1hAV0sx4ToYz8L
         XoYw==
X-Gm-Message-State: AOAM532DNNNid/UXxeoDzekoijyygSLsXUd4E3f/Kvk2RfQ11+zdcEpb
        rX8pnV/1kRjpu6K9CdtGgDzAUg==
X-Google-Smtp-Source: ABdhPJxLPt6CntmozfnHLwXqny0KwCU2vgLZSjJXfMA4iRfgP9luxNnbV0AtIM87S/ieQOg/r1KAAQ==
X-Received: by 2002:a17:902:b28a:b0:142:3e17:38d8 with SMTP id u10-20020a170902b28a00b001423e1738d8mr80638372plr.56.1637349484440;
        Fri, 19 Nov 2021 11:18:04 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f15sm426180pfe.171.2021.11.19.11.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 11:18:03 -0800 (PST)
Date:   Fri, 19 Nov 2021 19:18:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <YZf4aAlbyeWw8wUk@google.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
 <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021, David Hildenbrand wrote:
> On 19.11.21 16:19, Jason Gunthorpe wrote:
> > As designed the above looks useful to import a memfd to a VFIO
> > container but could you consider some more generic naming than calling
> > this 'guest' ?
> 
> +1 the guest terminology is somewhat sob-optimal.

For the F_SEAL part, maybe F_SEAL_UNMAPPABLE?

No ideas for the kernel API, but that's also less concerning since it's not set
in stone.  I'm also not sure that dedicated APIs for each high-ish level use case
would be a bad thing, as the semantics are unlikely to be different to some extent.
E.g. for the KVM use case, there can be at most one guest associated with the fd,
but there can be any number of VFIO devices attached to the fd.
