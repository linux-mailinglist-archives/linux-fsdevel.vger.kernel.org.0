Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AEC7945FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 00:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244988AbjIFWLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 18:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244984AbjIFWLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D852819AF
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694038227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sW5n0U9nqfDRjI4qbYKErrgizSRaxysFjpyGkvRHBg=;
        b=Pg99Aw0dhrjssfj+plRZ73iAzmz80+t6FzoooYMo5YOjDFkLKZv62XF4FxljMbibakqOrb
        gWlugmjp43pbB5CdnXYoQls8seJQWvdY++J14P9i7h5PP0X9VcuRGlwMkKJAy4kV+FVodZ
        XQCAdiOokbHqs1rtsWQOjmjv9FyPDWo=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-OkTWCiPEPr-_X_NkMaUlUA-1; Wed, 06 Sep 2023 18:10:25 -0400
X-MC-Unique: OkTWCiPEPr-_X_NkMaUlUA-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-44d417b639dso108031137.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 15:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694038225; x=1694643025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sW5n0U9nqfDRjI4qbYKErrgizSRaxysFjpyGkvRHBg=;
        b=VKfK1ob5AXfk/sKz/VLXIlWqvOhtWDcZo2x/yef0BXq3qpS+pKZ4TRCjcBDHD21cVu
         0bOl7mMIia+ZmCJoB2utzsJiE1e/3mLNZOfD4GGb79hvGJqZjka1uqvFMqkLgbkp3IZ6
         ABti7UVQ53iq92j7n0yh5JK6i30/apa2wJsTGIKYBCwxEKtu526iBrXxitnSB9JxbeMd
         PoHuhdH6ce5WTuU+ygWXrNyzKOE16+pSovhPecbtvivuIVUs2jmO92RuXGCXvJ1Kx0p4
         nQXvPru9EODOrrdagiRLA439kFGRk6tRfYKA6Ue+uYFtxD+UBjzUHpAw41VXVIrKZcuc
         L+xw==
X-Gm-Message-State: AOJu0YzbxgKzorWumUOz3m/WKIW52iDAtDIIquHDOFjh82a7V1WjSUHQ
        yztU/Pbujjpc9gyFDhgZOXg6xP8aszkfUUVnQB9+8xMXTFU+b8iVmRRnwDjxqwTvOh4NoNlRq6g
        82G+SAOpc/wFv5XpDCYRUwzcblLN3LtpboqNW7t4lVA==
X-Received: by 2002:a67:ee4d:0:b0:444:17aa:df60 with SMTP id g13-20020a67ee4d000000b0044417aadf60mr4110692vsp.13.1694038225085;
        Wed, 06 Sep 2023 15:10:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp5n1WB8R1og/NcZaTM8SckALAeHpMUrTVBDu8TXyXcr3qI/pIRPsrfv30I89brgsoG52emGtevyCvY1jn784=
X-Received: by 2002:a67:ee4d:0:b0:444:17aa:df60 with SMTP id
 g13-20020a67ee4d000000b0044417aadf60mr4110646vsp.13.1694038224758; Wed, 06
 Sep 2023 15:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-14-seanjc@google.com>
 <84a908ae-04c7-51c7-c9a8-119e1933a189@redhat.com> <ZLq8ylTsFQ1s4BAZ@google.com>
In-Reply-To: <ZLq8ylTsFQ1s4BAZ@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 7 Sep 2023 00:10:13 +0200
Message-ID: <CABgObfYLuRx5oAfOKM1fNuyRw5BNhe127sbRYhmpoT9MsjMYQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v11 13/29] KVM: Add transparent hugepage support for
 dedicated guest memory
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 21, 2023 at 7:13=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> On Fri, Jul 21, 2023, Paolo Bonzini wrote:
> > On 7/19/23 01:44, Sean Christopherson wrote:
> > > @@ -413,6 +454,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_c=
reate_guest_memfd *args)
> > >     u64 flags =3D args->flags;
> > >     u64 valid_flags =3D 0;
> > > +   if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > > +           valid_flags |=3D KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
> > > +
> >
> > I think it should be always allowed.  The outcome would just be "never =
have
> > a hugepage" if thp is not enabled in the kernel.
>
> I don't have a strong preference.  My thinking was that userspace would p=
robably
> rather have an explicit error, as opposed to silently running with a misc=
onfigured
> setup.

Considering that is how madvise(MADV_HUGEPAGE) behaves, your patch is
good. I disagree but consistency is better.

Paolo

