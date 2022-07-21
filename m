Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376A757D5CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 23:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiGUVTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 17:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiGUVTM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:19:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB948AB07
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 14:19:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 70so2894345pfx.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ScpzxJyKmeludExQxXIszukI2lfSKDVjTGaUtRwviD0=;
        b=fYYV0vbwKMgnf6isTcV+vMM02uE3HouFd898nbPDmChcgRckNqpK/32TxwPnHN227J
         ++L0os8W6x9ium+SRGtN1Ky0yP28Yuv/qHye6YY85twUgSpz5cL4iafN1yWBzT5mF5jT
         zfZ0audvBpI4c00xFJNjzqhLBl3DeJoNNfW967aC5PgjacYCopiCYm4yTM/A0/u+cirV
         MUabNXNe86MjLj4FukHS14w3Pyv+H9Fs6bPQsVG7BpQl5iGi6UTeRa3otGxN0BH1ah9v
         19fMAXWCGwObG/1U0EneiYQ/0oaLDLnpN90yC2Rxw6G7kn46NiP6IFXR/iv11/pJMTkK
         uw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ScpzxJyKmeludExQxXIszukI2lfSKDVjTGaUtRwviD0=;
        b=f1ccBNSzpVC1bukZySYBft09HAXzOLKYANR81WM6F+vZJ9fquIYxgDjgeP+YUpxEN/
         KNDApAEI/sDtg5C/PQ8QrTeOHqmBxzncwThzb4vk35ELCo298p6tb7nLl8RjQE3loFDP
         vF5BbTx1S9v/ghS+pN6qy9QmCzqCeutpGzQvYBabL380uBqyjp71FHdc0QI/8WkGAVcO
         KehMMEwQpw7OS/FwT4wECvtbD9lApyvbV3gd6Ubpe6vbjb0Osi0bWdZQFmd23Bml1Dx5
         i3iJTjNO3MgdUn0eDHCuNEgFuxLB1B3ggiw03/IEq2Mo68lADoj9roHxKBx67PQBQRpJ
         +m+g==
X-Gm-Message-State: AJIora9gjJ6nYuMNKZTJ34XooQ+iTVjrXFstzWXIbe5tDaPUbR+EhP/I
        0s2eP/kwKCNMRpg1/HGT0heT0g==
X-Google-Smtp-Source: AGRyM1tRhRp+6mg/TcG9DeP0WjeN5fNx2D34QSPiNsnaUnKIDpEjYXyyrYr8GL+NFtkg+bEZ2FCYeg==
X-Received: by 2002:a65:6d19:0:b0:41a:625e:7d7a with SMTP id bf25-20020a656d19000000b0041a625e7d7amr275152pgb.506.1658438350139;
        Thu, 21 Jul 2022 14:19:10 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id i67-20020a62c146000000b005289fbef7c4sm2243655pfg.140.2022.07.21.14.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:19:09 -0700 (PDT)
Date:   Thu, 21 Jul 2022 21:19:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Price <steven.price@arm.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        nikunj@amd.com, ashish.kalra@amd.com
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YtnCyqbI26QfRuOP@google.com>
References: <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com>
 <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com>
 <YkyEaYiL0BrDYcZv@google.com>
 <20220422105612.GB61987@chaop.bj.intel.com>
 <20220509223056.pyazfxjwjvipmytb@amd.com>
 <YnmjvX9ow4elYsY8@google.com>
 <c3ca63d6-db27-d783-40ca-486b3fbbced7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3ca63d6-db27-d783-40ca-486b3fbbced7@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 21, 2022, Gupta, Pankaj wrote:
> 
> Hi Sean, Chao,
> 
> While attempting to solve the pre-boot guest payload/firmware population
> into private memory for SEV SNP, retrieved this thread. Have question below:
> 
> > > > Requirements & Gaps
> > > > -------------------------------------
> > > >    - Confidential computing(CC): TDX/SEV/CCA
> > > >      * Need support both explicit/implicit conversions.
> > > >      * Need support only destructive conversion at runtime.
> > > >      * The current patch should just work, but prefer to have pre-boot guest
> > > >        payload/firmware population into private memory for performance.
> > > 
> > > Not just performance in the case of SEV, it's needed there because firmware
> > > only supports in-place encryption of guest memory, there's no mechanism to
> > > provide a separate buffer to load into guest memory at pre-boot time. I
> > > think you're aware of this but wanted to point that out just in case.
> > 
> > I view it as a performance problem because nothing stops KVM from copying from
> > userspace into the private fd during the SEV ioctl().  What's missing is the
> > ability for userspace to directly initialze the private fd, which may or may not
> > avoid an extra memcpy() depending on how clever userspace is.
> Can you please elaborate more what you see as a performance problem? And
> possible ways to solve it?

Oh, I'm not saying there actually _is_ a performance problem.  What I'm saying is
that in-place encryption is not a functional requirement, which means it's purely
an optimization, and thus we should other bother supporting in-place encryption
_if_ it would solve a performane bottleneck.
