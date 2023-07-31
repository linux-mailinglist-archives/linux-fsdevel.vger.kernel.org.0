Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775837691C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjGaJbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjGaJa7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:30:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EA10DF
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 02:30:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52229f084beso6789684a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690795847; x=1691400647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ziEHdMiDKlKGEA4myzpOfHCTiCmmAiAT9VETtxXexS8=;
        b=guIUa9TpRYBjI0stX0rR0q2KYRVdgo42Rwix6s3W6cxhGOSx6PVyCTdA5g/AS2h33d
         qccXGdTTxsaL3dKPpzdUGCwz9sOnNjZP2QZ+IRlflzPGUckJBW/eFq4DipVJqbUG5NQ/
         5teoOLbLNLvidR0nDX0dInMVzU60IzUEZpiCJ78DCgLwH4VDVpyvS+PFDJmp2H2Cqsaq
         ckd8/Aqk96/l2tM08ubMYTGsra64KF4plRKJW4CV/d6dRMYvZWy3I0q2vTBh3JUMjdY2
         e0xEUNA9wJufu3+8SkFanLOhloqOVlBS3eZCjfmk+1nbmTk3VOjLRNz4/M5kaTwNZDzq
         GaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690795847; x=1691400647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziEHdMiDKlKGEA4myzpOfHCTiCmmAiAT9VETtxXexS8=;
        b=bIFQJJQR1CxfOWI0WgPZl/TweowAG8DvWWDlCG3Rqw0zINlGUMNHnpgT8ekNCGluty
         Evrp6MjNhyfp43vQiy1y0D2WyauVBQFFSku8iITPU4IrzAF4WFtqTjq54/9rw87Yw3J9
         5qqCXuwz6touffVmFokO6UcS8okOn3pVpDeCvn9MIIz6UK1jPHN6nbeK6L+n/bsSnwlb
         qkGynFkPN0xCufifwk/gtgBLsQnYdBHeRJtLqY/KhyLOQlSPvqDJPqZFW5fr1LaUPUYu
         ml/rUWolQBLAqRu5OzZ2/4B/P7XcpwpmgeVIq8l6/1IDGmAVUuiWrxeAikxkOWOXqoaM
         kvSA==
X-Gm-Message-State: ABy/qLaLZNzpMinTHVqmZI+aJIfIsDYoGlvnTncp3ZoYVNHr0cUmQq7R
        XijvD5l72L18Dlnlif9o2WWT8A==
X-Google-Smtp-Source: APBJJlH9uJ20HU/xu6w4BzlZ8VKOTZ9pA8N8iNM1wVNpNPl9nuSdUi/k4VZmc0YpyQk9a9eYCl1pHA==
X-Received: by 2002:aa7:c554:0:b0:522:40dd:74f3 with SMTP id s20-20020aa7c554000000b0052240dd74f3mr9248786edr.39.1690795847077;
        Mon, 31 Jul 2023 02:30:47 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id q20-20020aa7da94000000b005228c045515sm5165439eds.14.2023.07.31.02.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:30:46 -0700 (PDT)
Date:   Mon, 31 Jul 2023 09:30:43 +0000
From:   Quentin Perret <qperret@google.com>
To:     Sean Christopherson <seanjc@google.com>
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
Subject: Re: [RFC PATCH v11 06/29] KVM: Introduce KVM_SET_USER_MEMORY_REGION2
Message-ID: <ZMd/Q4fytFhinDDj@google.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-7-seanjc@google.com>
 <ZMOJgnyzzUNIx+Tn@google.com>
 <ZMRXVZYaJ9wojGtS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMRXVZYaJ9wojGtS@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 28 Jul 2023 at 17:03:33 (-0700), Sean Christopherson wrote:
> On Fri, Jul 28, 2023, Quentin Perret wrote:
> > On Tuesday 18 Jul 2023 at 16:44:49 (-0700), Sean Christopherson wrote:
> > > --- a/include/uapi/linux/kvm.h
> > > +++ b/include/uapi/linux/kvm.h
> > > @@ -95,6 +95,16 @@ struct kvm_userspace_memory_region {
> > >  	__u64 userspace_addr; /* start of the userspace allocated memory */
> > >  };
> > >  
> > > +/* for KVM_SET_USER_MEMORY_REGION2 */
> > > +struct kvm_userspace_memory_region2 {
> > > +	__u32 slot;
> > > +	__u32 flags;
> > > +	__u64 guest_phys_addr;
> > > +	__u64 memory_size;
> > > +	__u64 userspace_addr;
> > > +	__u64 pad[16];
> > 
> > Should we replace that pad[16] with:
> > 
> > 	__u64 size;
> > 
> > where 'size' is the size of the structure as seen by userspace? This is
> > used in other UAPIs (see struct sched_attr for example) and is a bit
> > more robust for future extensions (e.g. an 'old' kernel can correctly
> > reject a newer version of the struct with additional fields it doesn't
> > know about if that makes sense, etc).
> 
> "flags" serves that purpose, i.e. allows userspace to opt-in to having KVM actually
> consume what is currently just padding.

Sure, I've just grown to dislike static padding of that type -- it ends
up being either a waste a space, or is too small, while the 'superior'
alternative (having a 'size' member) doesn't cost much and avoids those
problems.

But no strong opinion really, this struct really shouldn't grow much,
so I'm sure that'll be fine in practice.

> The padding is there mainly to simplify kernel/KVM code, e.g. the number of bytes
> that KVM needs to copy in is static.
> 
> But now that I think more on this, I don't know why we didn't just unconditionally
> bump the size of kvm_userspace_memory_region.  We tried to play games with unions
> and overlays, but that was a mess[*].
> 
> KVM would need to do multiple uaccess reads, but that's not a big deal.  Am I
> missing something, or did past us just get too clever and miss the obvious solution?
> 
> [*] https://lkml.kernel.org/r/Y7xrtf9FCuYRYm1q%40google.com

Right, so the first uaccess would get_user() the flags, based on that
we'd figure out the size of the struct, copy_from_user() what we need,
and then sanity check the flags are the same from both reads, or
something along those lines?

That doesn't sound too complicated to me, and as long as every extension
to the struct does come with a new flag I can't immediately see what
would go wrong.
