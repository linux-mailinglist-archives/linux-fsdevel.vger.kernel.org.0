Return-Path: <linux-fsdevel+bounces-61892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBC4B80008
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4E63284F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 09:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8612309EFE;
	Wed, 17 Sep 2025 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOSe7VCM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C1306D4B
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100853; cv=none; b=eu35z/BgEdaybQP1PRjYUhSnAJTJUhMUt+GSxtMLP7JtV8BLEoqHUA4VzL8RolA2wtDEHl0Q7UkVqTQjeSRSRk48BZPr0/yBhzlt2ZU1dKVfsdnpiZR6LFSFKVuYVN+rl0naZtquHDS7yNIdg8Ug/gh1ZyRGW1XamVVYddxRJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100853; c=relaxed/simple;
	bh=GPrMgKLIF76NvpNeh03mLIHEOaiBvol3hzVk3son8tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNhVgXhcSmpzX29aPt1Rak6xwmOhOA1vJ1iNsI8x8Aws/7GXKPIB/QMpPOIOLn+XCI/aMgE0KJUXBkOMFByTj5774wdbx9+6VFDTWTifSsTyy/q0edzDpbvXE5084G6PP3CsCvDA9nRDkqPBivCVLk+QP5XrhZaDwow5QROtm2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOSe7VCM; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30ccec59b4bso4895882fac.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758100850; x=1758705650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ox09wceLheN9CV/GNKAbltAUFRxxk0VbuNEPceF8/DQ=;
        b=SOSe7VCMhoCLfGmUaYB6GzCdWwStBaaY2tOuKd2oo+GJyneR5SYpsEdYYIgPoTu58s
         /P8BrPZ+AY9skH1sKfJBZNpx2fMK5qPx90ZcCmLu8B0mBFrVw35eoAn7XGDWRCbUx2fT
         AYOyLvXzoXkq4eolmfS2JeG81abYUpAvgF5ZhjdilnMCZrJMKfVKuFHVtMwxl6DAbur7
         Frci7n+jXhNdLXtJ2wui2OP8h81JQBnoNXXyedY7Av63BxERfqOfjgstBFx1+3bwJ0sh
         2njAnl4Rdv896JknCeJMxUzvtOwTipYdnVVCI3uqqVdj3GLmmYbRJG/DWxFGYm2P4AxB
         +SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100850; x=1758705650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ox09wceLheN9CV/GNKAbltAUFRxxk0VbuNEPceF8/DQ=;
        b=IXz2vaGqWmaBCS6bwOS3PyqgV9zNtDqrHw4p1uuhQiituwV+0BrdWviyldrHs0ZNiG
         wh92YZTNDLY7by6f7OI6kJX0Tcbjtenys9dQWmrIAVf9CnSXbcp4aIo4twFophegO2ui
         tz1QylpzTP0eyS10J8tdbpmrZ8rCN3da77peE8NRZgfjCK99T0ApygyPnFO07ItwZK5+
         iipk9qDVLG31xmd8Ro71QjNve0PAaoqcpgm3EoH32nHwgAbgJHaVUaFC65vyF/EYp+Rg
         us+MZ7ofxVK8otn0zc7NFLbkJ3ath4rYt5XeRvnmGrNaCiaJlfrcemgi68eDX4lDCdnV
         01QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm7ls5OJKVNES4nJeP0akrJ3UWVW7McHNTJNsI422lV0lmhAZav7n/et/3B/Knc4Tw5HCkuy/lZWpK6IgB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo7ZIrbfqu8ZMAgVk+EWS6hWhHv8OeKsi3wmkbJUv9DSTJw4Tp
	iiOMIFgbYny97StJjtVsrRBrmTWOTFnNSV3iYzANVq3JYxF6nzqe3lnY4a8gAqyFOFcKxVEQjv9
	EmtJnP2Wae0G9b4/XvO2Pq6HaOHo7mxw=
X-Gm-Gg: ASbGnctqKJJuOGv+uqGBwiAEGFz+z7AF2U3gzlFFtS9RsrFrVAALABKGy5u+xp35det
	7Rc1alvz/di3yK6IijstCvi9Dy18B+jAKlYEoJ6721h28lRSkkw86W9KEW2UiyKVhdSSWeDS4/P
	9RKZKCNLQ9jz6MG4ywtR3RCF7tmIj5pMDfTjmMfy+3Ym7QBkQquSmyzXEjV0r8qc87fqtip40Lt
	COuSg==
X-Google-Smtp-Source: AGHT+IEvi/vcvuNXEKryAobinAuQaOybDNziHzvdIl5fQxCUxTSrL6UDLu1P/TgPbjPopqUhtAHphiQym0mzQtaf3UA=
X-Received: by 2002:a05:6871:d618:b0:31d:6467:3ddd with SMTP id
 586e51a60fabf-335be8c863emr772149fac.3.1758100850540; Wed, 17 Sep 2025
 02:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917033703.1695933-1-zhangchunyan@iscas.ac.cn>
 <20250917033703.1695933-3-zhangchunyan@iscas.ac.cn> <bc87f2a8-7a9c-4416-9106-bdf4b98e40a8@redhat.com>
In-Reply-To: <bc87f2a8-7a9c-4416-9106-bdf4b98e40a8@redhat.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 17 Sep 2025 17:20:14 +0800
X-Gm-Features: AS18NWA4SAC8zxdE-h5_sRhBzgX8xMPmN4jL9phgOErltDfEWb2iq0mEGYtEXpk
Message-ID: <CAAfSe-vjgcgFyvVoci8F9ra4JwbDcdbhsxjSL0j8=0CCKAzFHQ@mail.gmail.com>
Subject: Re: [PATCH V13 2/6] mm: userfaultfd: Add pgtable_supports_uffd_wp()
To: David Hildenbrand <david@redhat.com>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, linux-riscv@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, Deepak Gupta <debug@rivosinc.com>, 
	Ved Shanbhogue <ved@rivosinc.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 15:25, David Hildenbrand <david@redhat.com> wrote:
>
> On 17.09.25 05:36, Chunyan Zhang wrote:
> > Some platforms can customize the PTE/PMD entry uffd-wp bit making
> > it unavailable even if the architecture provides the resource.
> > This patch adds a macro API that allows architectures to define their
> > specific implementations to check if the uffd-wp bit is available
> > on which device the kernel is running.
> >
> > Also this patch is removing "ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP" and
> > "ifdef CONFIG_PTE_MARKER_UFFD_WP" in favor of pgtable_supports_uffd_wp()
> > and uffd_supports_wp_marker() checks respectively that default to
> > IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP) and
> > "IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP) && IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP)"
> > if not overridden by the architecture, no change in behavior is expected.
> >
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> > ---
>
> [...]
>
> Taking another look.
>
> >   /* mm helpers */
> > @@ -415,68 +475,24 @@ static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
> >       return false;
> >   }
> >
> > -#endif /* CONFIG_USERFAULTFD */
> > -
> >   static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
> >   {
> > -     /* Only wr-protect mode uses pte markers */
> > -     if (!userfaultfd_wp(vma))
> >               return false;
>
> Isn't this indented one level too deep?

Oh right, I will fix these.

Thanks to you spotting them out!

Chunyan

>
> > -
> > -     /* File-based uffd-wp always need markers */
> > -     if (!vma_is_anonymous(vma))
> > -             return true;
> > -
> > -     /*
> > -      * Anonymous uffd-wp only needs the markers if WP_UNPOPULATED
> > -      * enabled (to apply markers on zero pages).
> > -      */
> > -     return userfaultfd_wp_unpopulated(vma);
> >   }
> >
> >   static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
> >   {
> > -#ifdef CONFIG_PTE_MARKER_UFFD_WP
> > -     return is_pte_marker_entry(entry) &&
> > -         (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
> > -#else
> > -     return false;
> > -#endif
> > +             return false;
>
> Same here.
>
> >   }
> >
> >   static inline bool pte_marker_uffd_wp(pte_t pte)
> >   {
> > -#ifdef CONFIG_PTE_MARKER_UFFD_WP
> > -     swp_entry_t entry;
> > -
> > -     if (!is_swap_pte(pte))
> >               return false;
>
> Same here.
>
> > -
> > -     entry = pte_to_swp_entry(pte);
> > -
> > -     return pte_marker_entry_uffd_wp(entry);
> > -#else
> > -     return false;
> > -#endif
> >   }
>
>
> --
> Cheers
>
> David / dhildenb
>

