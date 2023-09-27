Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB87B0F19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 00:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjI0WtX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 18:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjI0WtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:49:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE179192
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 15:49:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c6052422acso36595ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695854955; x=1696459755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIJKJLaNcL8GDk+Ht7dCkCTcNn0oTRzFCuMLCDfzqz0=;
        b=AaSwqqVeTdv/v3H+H80PAcofpbSf4vm8a0iBx5kRp/QN8d5Q7k4kEMAwranTVwK5DI
         zxl0b+yUVWrp0Bfvlh94o6xMQohl7MzeA82Jf1T4ZnXrId3OwMnWUSOv81jl/yDlNN6N
         ZMZuQ5pA6WIGvyZBa+lsdo3b22ubzzpFXw1tL7kF821Ych4NmYLEtRXfXat12nJO9IIN
         8l3as0d5Vmxdy1O4+XMmZg4ivZ4hoq922Q7UVY363liccm1ZO8yIfjh1PTvOWgfrohHx
         jecj7jeBZcIFrywKs5pFQeQwFqnYXCe+vO6ZwSn2zFptJ6C1BHyAeY2bb7lNtHrasfpr
         2oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695854955; x=1696459755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIJKJLaNcL8GDk+Ht7dCkCTcNn0oTRzFCuMLCDfzqz0=;
        b=Uh1QPuafDSR41wiknKhxkUfymS86zdna7p5XxwTou7RV6ECxcYcXARViXjngbz7Obv
         41D8ZuEn64Uh05amdq0KGfSV2KGtNnhZo+5RzwzfvkMrwhezDbfRwknG2TPAqmpHp7+u
         i99srIDGSVlKlJM0FORHRud+sWHEozBQnHjhOJyLHU0+Xw6EeVi8FqCXTadkgMUMPTLG
         F8gXwVlPsxAEGZrW9eVQ9fb8Xs2GAiDDSc93tVKnE4W7Zbcw2TGpxlkmt1Om1ATKoJh0
         g9ptbiuaafmNHiP71MRy6IHq4wohrdu7RiGF0HkPEjJ1ylQxgczwO3EcuPO4SGrQUnCx
         3wdQ==
X-Gm-Message-State: AOJu0YwzD+xWrU3AGcE67ztlKwOP+aln+NlcQZ42kvKxR8myyJR5Ibaz
        TTDLHMrtgRjiaVcaFM2OzDZ9cf+FS11iyL6ID7tDxw==
X-Google-Smtp-Source: AGHT+IFg4xs/UWNT30KLKAXtF/O8kFcQ5dG9ij6JaTG86Q1zxSkGAbGJpi6P6KLyxdxnH8Dbwsd8eB1Rrn4s8EKe6hI=
X-Received: by 2002:a17:902:e751:b0:1c6:112f:5ceb with SMTP id
 p17-20020a170902e75100b001c6112f5cebmr562761plf.25.1695854955102; Wed, 27 Sep
 2023 15:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <CAJuCfpGb5Amo9Sk0yyruJt9NKaYe9-y+5jmU442NSf3+VT5-dA@mail.gmail.com>
 <CAG48ez2WNOMwPo4OMVUHbS4mirwbqHUY5qUaaZ9DTkXdkzrjiQ@mail.gmail.com>
 <CAJuCfpGcsBE2XqPJSVo1gdE_O96gzS5=ET=u0uSBSX3Lj56CtA@mail.gmail.com> <CAJuCfpHY5zhkS0OPxOK-twb6pDJg6OpXZnPquw_9wBmbjFiF9Q@mail.gmail.com>
In-Reply-To: <CAJuCfpHY5zhkS0OPxOK-twb6pDJg6OpXZnPquw_9wBmbjFiF9Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Sep 2023 00:48:37 +0200
Message-ID: <CAG48ez3w7kbetfhEd7trLhOKJYPw4jSVBeOC+psZZR84d-hJaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> On Wed, Sep 27, 2023 at 1:42=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Wed, Sep 27, 2023 at 1:04=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > On Wed, Sep 27, 2023 at 8:08=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > > On Wed, Sep 27, 2023 at 5:47=E2=80=AFAM Jann Horn <jannh@google.com=
> wrote:
> > > > > On Sat, Sep 23, 2023 at 3:31=E2=80=AFAM Suren Baghdasaryan <suren=
b@google.com> wrote:
> > > > > > +               dst_pmdval =3D pmdp_get_lockless(dst_pmd);
> > > > > > +               /*
> > > > > > +                * If the dst_pmd is mapped as THP don't overri=
de it and just
> > > > > > +                * be strict. If dst_pmd changes into TPH after=
 this check, the
> > > > > > +                * remap_pages_huge_pmd() will detect the chang=
e and retry
> > > > > > +                * while remap_pages_pte() will detect the chan=
ge and fail.
> > > > > > +                */
> > > > > > +               if (unlikely(pmd_trans_huge(dst_pmdval))) {
> > > > > > +                       err =3D -EEXIST;
> > > > > > +                       break;
> > > > > > +               }
> > > > > > +
> > > > > > +               ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> > > > > > +               if (ptl && !pmd_trans_huge(*src_pmd)) {
> > > > > > +                       spin_unlock(ptl);
> > > > > > +                       ptl =3D NULL;
> > > > > > +               }
> > > > >
> > > > > This still looks wrong - we do still have to split_huge_pmd()
> > > > > somewhere so that remap_pages_pte() works.
> > > >
> > > > Hmm, I guess this extra check is not even needed...
> > >
> > > Hm, and instead we'd bail at the pte_offset_map_nolock() in
> > > remap_pages_pte()? I guess that's unusual but works...
> >
> > Yes, that's what I was thinking but I agree, that seems fragile. Maybe
> > just bail out early if (ptl && !pmd_trans_huge())?
>
> No, actually we can still handle is_swap_pmd() case by splitting it
> and remapping the individual ptes. So, I can bail out only in case of
> pmd_devmap().

FWIW I only learned today that "real" swap PMDs don't actually exist -
only migration entries, which are encoded as swap PMDs, exist. You can
see that when you look through the cases that something like
__split_huge_pmd() or zap_pmd_range() actually handles.

So I think if you wanted to handle all the PMD types properly here
without splitting, you could do that without _too_ much extra code.
But idk if it's worth it.
