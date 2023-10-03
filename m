Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0E77B70F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 20:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbjJCSdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 14:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbjJCSdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:33:52 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D4783
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 11:33:48 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-65b0a54d436so7090726d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696358027; x=1696962827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9RZg3twPdN7SJarZ/3IsJk/93o/jgnrY3ylxDmEVWY=;
        b=eRtKp9K05iEcq6czK8WWvk3WTZ++XgFDyLqcu6+1oX0ugzs8SjqUerdeOsn8Jn+S+a
         Rpy8LEd552jIM6/9NM7DAXHJHLHqrqEU9NkfUoEkAJsUCI4BBoOpbhMm2G1dEj63V9fv
         /GYqc7rk7Ox2I814AlsLCgXMhhIGZ3uN5dkK/9Njfh/kuHoBPue1SCkb//S7UQQjvIwm
         3dkBcWU5wQzUGxI2n4IsVN3KFkCvOu5/a7L0L1DgESfayIvlDgdBurP8CVKwG/KPWgtd
         vToJJ9OFs+FK9KcJByAuVo/wM10OAXozd8GmN+xOsbcI+ovtuuCBE965+d1yFEMfZ+LE
         LSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696358027; x=1696962827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9RZg3twPdN7SJarZ/3IsJk/93o/jgnrY3ylxDmEVWY=;
        b=cGWb3SX0ftbkC1jgcsqekMM7dL1t+FsVrcHQ80Ft/1bXDb3LKHVigr5IaCK8c5tJB9
         Vmf7eRr5Khgac5/tzPaaysuostpWUW10BWaZL2/fxgOaZMQNOVgt75SHWuqXwaauRO8N
         TawjKd3EiXX4+aGHMEJRov39mbAWfkh6UYH1rAClrI4mQffQiji9o70rlH6w4eDRv8nm
         cBW9EzF5/H1bC8ogt9V6Q+CGOy0wu6j/Ca8vg8vKHTvh3G1maB29J1esXeN6e7fC4ok0
         RNM5BkgvW9K1xjy8JeDGjmsCNaPosJwaumw2/Y3D8txhqp5NawGSw0BF477KQ3v9EHjL
         e8Ig==
X-Gm-Message-State: AOJu0YwnznIWgzTDjPwCcEJSp4S7qs8/Mu/FifJTFPM0VKb21eItw/UZ
        bANSkljDK02ZRP74yVUaZyW0FgtTxY5Np6En29fCfw==
X-Google-Smtp-Source: AGHT+IFD9MiWpIrPl+X1KG+mF8SaIxZsGnEuN1WGAxrVYz5JoBkTLtzwKfCvY0TUsCLlDtWXvgqIVLrhKrhnAnrWPa0=
X-Received: by 2002:a0c:c409:0:b0:64f:3699:90cd with SMTP id
 r9-20020a0cc409000000b0064f369990cdmr170157qvi.42.1696358027177; Tue, 03 Oct
 2023 11:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-12-seanjc@google.com>
 <CA+EHjTzSUXx8P9gWmUERg4owxH6r6yNPm1_RL-BzS_2CNPtRKw@mail.gmail.com> <ZRw6X2BptZnRPNK7@google.com>
In-Reply-To: <ZRw6X2BptZnRPNK7@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 3 Oct 2023 19:33:09 +0100
Message-ID: <CA+EHjTzx+0pxh7DYONZUeJsm1GCiC6L8Vg_Tm9MLVEae-FKuQg@mail.gmail.com>
Subject: Re: [RFC PATCH v12 11/33] KVM: Introduce per-page memory attributes
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
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sean,


On Tue, Oct 3, 2023 at 4:59=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Oct 03, 2023, Fuad Tabba wrote:
> > Hi,
> >
> > > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > > index d2d913acf0df..f8642ff2eb9d 100644
> > > --- a/include/uapi/linux/kvm.h
> > > +++ b/include/uapi/linux/kvm.h
> > > @@ -1227,6 +1227,7 @@ struct kvm_ppc_resize_hpt {
> > >  #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
> > >  #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
> > >  #define KVM_CAP_USER_MEMORY2 230
> > > +#define KVM_CAP_MEMORY_ATTRIBUTES 231
> > >
> > >  #ifdef KVM_CAP_IRQ_ROUTING
> > >
> > > @@ -2293,4 +2294,17 @@ struct kvm_s390_zpci_op {
> > >  /* flags for kvm_s390_zpci_op->u.reg_aen.flags */
> > >  #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
> > >
> > > +/* Available with KVM_CAP_MEMORY_ATTRIBUTES */
> > > +#define KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES    _IOR(KVMIO,  0xd2, __=
u64)
> > > +#define KVM_SET_MEMORY_ATTRIBUTES              _IOW(KVMIO,  0xd3, st=
ruct kvm_memory_attributes)
> > > +
> > > +struct kvm_memory_attributes {
> > > +       __u64 address;
> > > +       __u64 size;
> > > +       __u64 attributes;
> > > +       __u64 flags;
> > > +};
> > > +
> > > +#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> > > +
> >
> > In pKVM, we don't want to allow setting (or clearing) of PRIVATE/SHARED
> > attributes from userspace.
>
> Why not?  The whole thing falls apart if userspace doesn't *know* the sta=
te of a
> page, and the only way for userspace to know the state of a page at a giv=
en moment
> in time is if userspace controls the attributes.  E.g. even if KVM were t=
o provide
> a way for userspace to query attributes, the attributes exposed to usrspa=
ce would
> become stale the instant KVM drops slots_lock (or whatever lock protects =
the attributes)
> since userspace couldn't prevent future changes.

I think I might not quite understand the purpose of the
KVM_SET_MEMORY_ATTRIBUTES ABI. In pKVM, all of a protected guest's
memory is private by default, until the guest shares it with the host
(via a hypercall), or another guest (future work). When the guest
shares it, userspace is notified via KVM_EXIT_HYPERCALL. In many use
cases, userspace doesn't need to keep track directly of all of this,
but can reactively un/map the memory being un/shared.

> Why does pKVM need to prevent userspace from stating *its* view of attrib=
utes?
>
> If the goal is to reduce memory overhead, that can be solved by using an =
internal,
> non-ABI attributes flag to track pKVM's view of SHARED vs. PRIVATE.  If t=
he guest
> attempts to access memory where pKVM and userspace don't agree on the sta=
te,
> generate an exit to userspace.  Or kill the guest.  Or do something else =
entirely.

For the pKVM hypervisor the guest's view of the attributes doesn't
matter. The hypervisor at the end of the day is the ultimate arbiter
for what is shared and with how. For pKVM (at least in my port of
guestmem), we use the memory attributes from guestmem essentially to
control which memory can be mapped by the host.

One difference between pKVM and TDX (as I understand it), is that TDX
uses the msb of the guest's IPA to indicate whether memory is shared
or private, and that can generate a mismatch on guest memory access
between what it thinks the state is, and what the sharing state in
reality is. pKVM doesn't have that. Memory is private by default, and
can be shared in-place, both in the guest's IPA space as well as the
underlying physical page.

> > However, we'd like to use the attributes xarray to track the sharing st=
ate of
> > guest pages at the host kernel.
> >
> > Moreover, we'd rather the default guest page state be PRIVATE, and
> > only specify which pages are shared. All pKVM guest pages start off as
> > private, and the majority will remain so.
>
> I would rather optimize kvm_vm_set_mem_attributes() to generate range-bas=
ed
> xarray entries, at which point it shouldn't matter all that much whether =
PRIVATE
> or SHARED is the default "empty" state.  We opted not to do that for the =
initial
> merge purely to keep the code as simple as possible (which is obviously s=
till not
> exactly simple).
>
> With range-based xarray entries, the cost of tagging huge chunks of memor=
y as
> PRIVATE should be a non-issue.  And if that's not enough for whatever rea=
son, I
> would rather define the polarity of PRIVATE on a per-VM basis, but only f=
or internal
> storage.

Sounds good.

> > I'm not sure if this is the best way to do this: One idea would be to m=
ove
> > the definition of KVM_MEMORY_ATTRIBUTE_PRIVATE to
> > arch/*/include/asm/kvm_host.h, which is where kvm_arch_supported_attrib=
utes()
> > lives as well. This would allow different architectures to specify thei=
r own
> > attributes (i.e., instead we'd have a KVM_MEMORY_ATTRIBUTE_SHARED for p=
KVM).
> > This wouldn't help in terms of preventing userspace from clearing attri=
butes
> > (i.e., setting a 0 attribute) though.
> >
> > The other thing, which we need for pKVM anyway, is to make
> > kvm_vm_set_mem_attributes() global, so that it can be called from outsi=
de of
> > kvm_main.c (already have a local patch for this that declares it in
> > kvm_host.h),
>
> That's no problem, but I am definitely opposed to KVM modifying attribute=
s that
> are owned by userspace.
>
> > and not gate this function by KVM_GENERIC_MEMORY_ATTRIBUTES.
>
> As above, I am opposed to pKVM having a completely different ABI for mana=
ging
> PRIVATE vs. SHARED.  I have no objection to pKVM using unclaimed flags in=
 the
> attributes to store extra metadata, but if KVM_SET_MEMORY_ATTRIBUTES does=
n't work
> for pKVM, then we've failed miserably and should revist the uAPI.

Like I said, pKVM doesn't need a userspace ABI for managing
PRIVATE/SHARED, just a way of tracking in the host kernel of what is
shared (as opposed to the hypervisor, which already has the
knowledge). The solution could simply be that pKVM does not enable
KVM_GENERIC_MEMORY_ATTRIBUTES, has its own tracking of the status of
the guest pages, and only selects KVM_PRIVATE_MEM.

Thanks!
/fuad
