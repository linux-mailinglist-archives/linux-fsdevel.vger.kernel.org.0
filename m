Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4376794B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 02:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjG2ADk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 20:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbjG2ADh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:03:37 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5C83C22
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 17:03:35 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bb982d2572so17187825ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 17:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690589015; x=1691193815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJg9MbukUkeAf25VcBnSvGPEfaUIyqqF94QJU8orhSY=;
        b=Zp0GOXqU9vAtanM7byzLEY1ZTAuQCQrnfrak1thKcFFHMBCZO/N4KqKDBd5I3kJffW
         Vh8ovzLtMVpv7R9tgjnJuitRPz0iowTqbSccpqb9sCrit8s8jZkHgE3EKWmaz9/YJybN
         uhR+1LBQ/EGKFm12kofvmo1N8Or8Mhd5I9QIxgAZxJjUnAncn/OfNQ+xg9V9rSfFrTW5
         6+gyXWvxsDfod0XUAEoSS/aCS0HqakbjGuI1/I8BU2Uy6FDW2YJ6LrCVt60GU5GehRX5
         3Ug/sPFW2Iawha4cKCkpfEtG9Mwjo7aL2M8Rz65tztUDm7ObzFqkZ6ozvUAWJtziwaLO
         +gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690589015; x=1691193815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJg9MbukUkeAf25VcBnSvGPEfaUIyqqF94QJU8orhSY=;
        b=Oi8EZg6Tzsczk3rnA111bdqYmT88EsCgGBkhtjeGv+05JHfYzuZ9IwmAZcoP7yAl4l
         iNmwMwwRh1Rkm9a5wya5KcZYD0hg5iE/6cSHCc2tPV+EuZdI6m0h1MMSljIew0dtOaBy
         AYnsnTjnrdtW0NTd/KWQA8FPKicQSKxJJDF4BxZB5k5SU6n2ylU3MoXA5DjwPaR3H8BR
         93rPDZb+rK1dTJ3S1l8gRCZ09iojG5032om0GUQu054r7p0uevH6uGGeMdt6W8v5fzfA
         XU696zj165itGpX5IYFAOS+qYJNj3GQYRnJqtsPc7PDHFDkrLB6IdeKgAK6ypVrWnRWl
         4xpw==
X-Gm-Message-State: ABy/qLZlqoDyYi6BWS4LRv86N/0U35xXEdrSk9AhgpmtRU3YLHSLnvdp
        wUotRMmTsllq2NqtbmSKZzsichQVwKg=
X-Google-Smtp-Source: APBJJlGy4rMQGFiWHQC+IuRONPQH0HvvNAt7asJXiFk+bZ/uVjfNOjPYVgrOl+x+eQJGyA+j61wbqvGP0DI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c951:b0:1ae:6895:cb96 with SMTP id
 i17-20020a170902c95100b001ae6895cb96mr12864pla.5.1690589014804; Fri, 28 Jul
 2023 17:03:34 -0700 (PDT)
Date:   Fri, 28 Jul 2023 17:03:33 -0700
In-Reply-To: <ZMOJgnyzzUNIx+Tn@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-7-seanjc@google.com>
 <ZMOJgnyzzUNIx+Tn@google.com>
Message-ID: <ZMRXVZYaJ9wojGtS@google.com>
Subject: Re: [RFC PATCH v11 06/29] KVM: Introduce KVM_SET_USER_MEMORY_REGION2
From:   Sean Christopherson <seanjc@google.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 28, 2023, Quentin Perret wrote:
> On Tuesday 18 Jul 2023 at 16:44:49 (-0700), Sean Christopherson wrote:
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -95,6 +95,16 @@ struct kvm_userspace_memory_region {
> >  	__u64 userspace_addr; /* start of the userspace allocated memory */
> >  };
> >  
> > +/* for KVM_SET_USER_MEMORY_REGION2 */
> > +struct kvm_userspace_memory_region2 {
> > +	__u32 slot;
> > +	__u32 flags;
> > +	__u64 guest_phys_addr;
> > +	__u64 memory_size;
> > +	__u64 userspace_addr;
> > +	__u64 pad[16];
> 
> Should we replace that pad[16] with:
> 
> 	__u64 size;
> 
> where 'size' is the size of the structure as seen by userspace? This is
> used in other UAPIs (see struct sched_attr for example) and is a bit
> more robust for future extensions (e.g. an 'old' kernel can correctly
> reject a newer version of the struct with additional fields it doesn't
> know about if that makes sense, etc).

"flags" serves that purpose, i.e. allows userspace to opt-in to having KVM actually
consume what is currently just padding.

The padding is there mainly to simplify kernel/KVM code, e.g. the number of bytes
that KVM needs to copy in is static.

But now that I think more on this, I don't know why we didn't just unconditionally
bump the size of kvm_userspace_memory_region.  We tried to play games with unions
and overlays, but that was a mess[*].

KVM would need to do multiple uaccess reads, but that's not a big deal.  Am I
missing something, or did past us just get too clever and miss the obvious solution?

[*] https://lkml.kernel.org/r/Y7xrtf9FCuYRYm1q%40google.com
