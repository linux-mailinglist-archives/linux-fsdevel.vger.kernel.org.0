Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E931759CB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 19:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjGSRrt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 13:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjGSRrr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:47:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA731FD9
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 10:47:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c926075a50cso1740889276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689788864; x=1692380864;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrpSlfvy8CWa29HQgq0qreuIOXt/Wldn9lf0s+IQ19g=;
        b=ArpFLxX4pd+nE6yhxk4kfQsyY2cBj0283wyB2UFD4pQNpbkrc+ZAbqxw+z+OgClanI
         8Bmj2Z7j2c1NhNgCvBdv83cjgOHHCOOMDHYftHtZeAL3vo412/Xbeep/S+CdApdBGNVE
         aduoGH7mk12lxFjmYh58eVW/1Ksc0OT9NLaSC1w5eMBSYs+0sTNoL7N0w3aZ0n2P+aH0
         VnFxLOrHPJ9r2ezOXOfj0cBYblwBN0Ye2w9Cgtba6HWxXo2yyLAo7PNbRfr5GAzKlZhF
         ic8thdmStV5nJQreXCY0jlMVC8WTwDKkeNH3l7/QHaf5X+Z1Dsac59JBXIEJlOoDRy4l
         I3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689788864; x=1692380864;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZrpSlfvy8CWa29HQgq0qreuIOXt/Wldn9lf0s+IQ19g=;
        b=jE1wr9rQWA/QgNRoXrhdgvDKurMkmTquIo51c/TDpn6AekA2jtjTBBKx9jXLkJpgps
         uGNT4KLLzqbwbrC3jBOorlMTmYFYifktEBXeHhxMT4j3sxGjOa++4NRs6vFZXbEolx3q
         n0uIGcNzIDQqMiz7Lc/QNA0lqfj0FpQkdYSPZLZmwotghwkNbRBI57+nP38IQmg+KGOy
         b96lmw1JRD1LaUXA+pQOSgHCyxPU6WhHBUhLxpX09bYi3Dldfsmpxm7NKSWxlDYAVh4l
         QV9BFbys0Ycfo9rDSFqifHMjFwHNgEIfGruQ0quR94UrAFexQWd9ph3JC3mDYm83LR0l
         e2fg==
X-Gm-Message-State: ABy/qLbl2bkqHYRdS4SBWD9mr0O7N/qwZ0/lrJJvhkByGizz0xdsYHQY
        NJoIVFscdeKjralQWpu0RNUFEgzGZQ8=
X-Google-Smtp-Source: APBJJlFlYUVvIIObTojpJ8UchQ4CwQtQGAVrCh++KpJ7LgJpdZRIA9xQwbGLQUVWTMKWnIrBZUJv99cvfhs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:f509:0:b0:ca3:3341:6315 with SMTP id
 a9-20020a25f509000000b00ca333416315mr42238ybe.0.1689788863726; Wed, 19 Jul
 2023 10:47:43 -0700 (PDT)
Date:   Wed, 19 Jul 2023 10:47:41 -0700
In-Reply-To: <CAGtprH9a2jX-hdww9GPuMrO9noNeXkoqE8oejtVn2vD0AZa3zA@mail.gmail.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-13-seanjc@google.com>
 <CAGtprH9a2jX-hdww9GPuMrO9noNeXkoqE8oejtVn2vD0AZa3zA@mail.gmail.com>
Message-ID: <ZLghvU4QzE0PtfNG@google.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023, Vishal Annapurve wrote:
> On Tue, Jul 18, 2023 at 4:49=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > ...
> > +static int kvm_gmem_error_page(struct address_space *mapping, struct p=
age *page)
> > +{
> > +       struct list_head *gmem_list =3D &mapping->private_list;
> > +       struct kvm_memory_slot *slot;
> > +       struct kvm_gmem *gmem;
> > +       unsigned long index;
> > +       pgoff_t start, end;
> > +       gfn_t gfn;
> > +
> > +       filemap_invalidate_lock_shared(mapping);
> > +
> > +       start =3D page->index;
> > +       end =3D start + thp_nr_pages(page);
> > +
> > +       list_for_each_entry(gmem, gmem_list, entry) {
> > +               xa_for_each_range(&gmem->bindings, index, slot, start, =
end - 1) {
> > +                       for (gfn =3D start; gfn < end; gfn++) {
> > +                               if (WARN_ON_ONCE(gfn < slot->base_gfn |=
|
> > +                                               gfn >=3D slot->base_gfn=
 + slot->npages))
> > +                                       continue;
> > +
> > +                               /*
> > +                                * FIXME: Tell userspace that the *priv=
ate*
> > +                                * memory encountered an error.
> > +                                */
> > +                               send_sig_mceerr(BUS_MCEERR_AR,
> > +                                               (void __user *)gfn_to_h=
va_memslot(slot, gfn),
> > +                                               PAGE_SHIFT, current);
>=20
> Does it make sense to replicate what happens with MCE handling on
> tmpfs backed guest memory:
> 1) Unmap gpa from guest
> 2) On the next guest EPT fault, exit to userspace to handle/log the
> mce error for the gpa.

Hmm, yes, that would be much better.  Ah, and kvm_gmem_get_pfn() needs to c=
heck
folio_test_hwpoison() and potentially PageHWPoison().  E.g. if the folio is=
 huge,
KVM needs to restrict the mapping to order-0 (target page isn't poisoned), =
or
return KVM_PFN_ERR_HWPOISON (taget page IS poisoned).

Alternatively, KVM could punch a hole in kvm_gmem_error_page(), but I don't=
 think
we want to do that because that would prevent forwarding the #MC to the gue=
st.
