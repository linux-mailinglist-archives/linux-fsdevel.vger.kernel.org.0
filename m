Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B066AFA4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 00:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCGX2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 18:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCGX17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 18:27:59 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2B1EC68
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 15:27:56 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id g18so14903086ljl.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 15:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678231675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgM5UWACpA1ziJGubEWxyksAdshP8CY52eV8GhV8Gkg=;
        b=TGT2yqt1nWpJRPljNttb9FcVv36E/Jt8A84ByzTR4qfutxQ7fHbpdB+EgF/6Hu8QEA
         lGav8SrhhYCem9wRNTeicDzl5ewmc3qyFq1vE8KfXRp3zg47pIamj2eOLTILU7cqykpP
         eIRethLM6K4/tMKQANyi6ZEnJZjZRMB/OCTP+DWXQsvO2zKmMTsPyQD8swSXLVTS2D5g
         zpu9uzYUHyfgWtbbJ7XEYTACwoPmJeHTPKHV/ad884DyulUXcTRi/oc/IJ8NR/H3zqZs
         tKa1AESMTbEZ0h1SvjwaE/87vK4azcWvVNgcCANUEXMYEwcMUPSMOuu0EJJvRrTgBIy/
         aRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678231675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgM5UWACpA1ziJGubEWxyksAdshP8CY52eV8GhV8Gkg=;
        b=x+us73X+UrChLAoKG7wS0XF2nJcUPL76QYFLPrEN/NX7iaS8w2tJrCEoCGnmtICivo
         O9DQcoIuHnYAd6vYyL5mtmvgBNyYFKGHHnhgfQnx3bGQdyFmVT59Pzh2dyG2hV4UvFZm
         0DJ0CJJMK4k2wKApK7O5lQefZqCBWh1y7BTbjLD+nTOI6OiyrYOiiXyhipMOEt+evHnV
         RkaIWE5XsodLhYx73aOngZ2I/UiFFAN/UHf2SBUimcAA3p66pqZBzdsVW0l5vCk4EDF0
         n3Y+ua8oJMTxllSfOKoMkis7wHl41czNwvG+bKolkZXRS3Q3c+tgAQHNhJTZbtarv96N
         5A6Q==
X-Gm-Message-State: AO0yUKXpkQcOnLO4p4puhmVrBbBTdhm9ASPDNG8rnhIcu2BmvSg52LZD
        0E2F+1bd1E6NSAHSnDzFvf9Zl7FLVWNOIp0oQMGXLQ==
X-Google-Smtp-Source: AK7set9qzhTKfHxML+MgHqsSuJRnPMnUneATXidb0+SUYjXa+h00K/U7lnIkoXpbPJNdsASUF+bM31GH9FkDBDE6CkE=
X-Received: by 2002:a05:651c:11c6:b0:295:d460:5a2d with SMTP id
 z6-20020a05651c11c600b00295d4605a2dmr4907216ljo.2.1678231674431; Tue, 07 Mar
 2023 15:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20230306225024.264858-1-axelrasmussen@google.com>
 <20230306225024.264858-4-axelrasmussen@google.com> <ZAaMs44nspRQJmrk@x1n>
In-Reply-To: <ZAaMs44nspRQJmrk@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 7 Mar 2023 15:27:17 -0800
Message-ID: <CAJHvVciQWctUoZtrPga-fhgBf2dtc+6ypwE3FYe8ApQWpQyL0Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm: userfaultfd: combine 'mode' and 'wp_copy' arguments
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
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

On Mon, Mar 6, 2023 at 5:00=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Mar 06, 2023 at 02:50:22PM -0800, Axel Rasmussen wrote:
> > Many userfaultfd ioctl functions take both a 'mode' and a 'wp_copy'
> > argument. In future commits we plan to plumb the flags through to more
> > places, so we'd be proliferating the very long argument list even
> > further.
> >
> > Let's take the time to simplify the argument list. Combine the two
> > arguments into one - and generalize, so when we add more flags in the
> > future, it doesn't imply more function arguments.
> >
> > Since the modes (copy, zeropage, continue) are mutually exclusive, stor=
e
> > them as an integer value (0, 1, 2) in the low bits. Place combine-able
> > flag bits in the high bits.
> >
> > This is quite similar to an earlier patch proposed by Nadav Amit
> > ("userfaultfd: introduce uffd_flags" - for some reason Lore no longer
> > has a copy of the patch). The main difference is that patch only handle=
d
>
> Lore has. :)
>
> https://lore.kernel.org/all/20220619233449.181323-2-namit@vmware.com
>
> And btw sorry to review late.
>
> > flags, whereas this patch *also* combines the "mode" argument into the
> > same type to shorten the argument list.
> >
> > Acked-by: James Houghton <jthoughton@google.com>
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>
> Mostly good to me, a few nitpicks below.
>
> [...]
>
> > +/* A combined operation mode + behavior flags. */
> > +typedef unsigned int __bitwise uffd_flags_t;
> > +
> > +/* Mutually exclusive modes of operation. */
> > +enum mfill_atomic_mode {
> > +     MFILL_ATOMIC_COPY =3D (__force uffd_flags_t) 0,
> > +     MFILL_ATOMIC_ZEROPAGE =3D (__force uffd_flags_t) 1,
> > +     MFILL_ATOMIC_CONTINUE =3D (__force uffd_flags_t) 2,
> > +     NR_MFILL_ATOMIC_MODES,
> >  };
>
> I never used enum like this.  I had a feeling that this will enforce
> setting the enum entries but would the enforce applied to later
> assignments?  I'm not sure.
>
> I had a quick test and actually I found sparse already complains about
> calculating the last enum entry:
>
> ---8<---
> $ cat a.c
> typedef unsigned int __attribute__((bitwise)) flags_t;
>
> enum {
>     FLAG1 =3D (__attribute__((force)) flags_t) 0,
>     FLAG_NUM,
> };
>
> void main(void)
> {
>     uffd_flags_t flags =3D FLAG1;
> }
> $ sparse a.c
> a.c:5:5: error: can't increment the last enum member
> ---8<---
>
> Maybe just use the simple "#define"s?

Agreed, if sparse isn't happy with this then using the force macros is
pointless.

The enum is valuable because it lets us get the # of modes; assuming
we agree that's useful below ...

>
> >
> > +#define MFILL_ATOMIC_MODE_BITS (const_ilog2(NR_MFILL_ATOMIC_MODES - 1)=
 + 1)
>
> Here IIUC it should be "const_ilog2(NR_MFILL_ATOMIC_MODES) + 1", but
> maybe..  we don't bother and define every bit explicitly?

If my reading of const_ilog2's definition is correct, then:

const_ilog2(4) =3D 2
const_ilog2(3) =3D 1
const_ilog2(2) =3D 1

For either 3 or 4 modes, we need 2 bits to represent them (0, 1, 2,
3), i.e. we want MFILL_ATOMIC_MODE_BITS =3D 2. I think this is correct
as is, because const_ilog2(4 - 1) + 1 =3D 2, and const_ilog2(3 - 1) + 1
=3D 2.

In other words, I think const_ilog2 is defined as floor(log2()),
whereas what we want is ceil(log2()).

The benefit of doing this vs. just doing defines with fixed values is,
if we ever added a new mode, we wouldn't have to do bit twiddling and
update the mask, flag bits, etc. - it would happen "automatically". I
prefer it this way, but I agree it is a matter of opinion / taste. :)
If you or others feel strongly this is overcomplicated, I can take the
other approach.

>
> > +#define MFILL_ATOMIC_BIT(nr) ((__force uffd_flags_t) BIT(MFILL_ATOMIC_=
MODE_BITS + (nr)))
> > +#define MFILL_ATOMIC_MODE_MASK (MFILL_ATOMIC_BIT(0) - 1)
> > +
> > +/* Flags controlling behavior. */
> > +#define MFILL_ATOMIC_WP MFILL_ATOMIC_BIT(0)
>
> [...]
>
> > @@ -312,9 +312,9 @@ static __always_inline ssize_t mfill_atomic_hugetlb=
(
> >                                             unsigned long dst_start,
> >                                             unsigned long src_start,
> >                                             unsigned long len,
> > -                                           enum mcopy_atomic_mode mode=
,
> > -                                           bool wp_copy)
> > +                                           uffd_flags_t flags)
> >  {
> > +     int mode =3D flags & MFILL_ATOMIC_MODE_MASK;
> >       struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> >       int vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> >       ssize_t err;
> > @@ -333,7 +333,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb=
(
> >        * by THP.  Since we can not reliably insert a zero page, this
> >        * feature is not supported.
> >        */
> > -     if (mode =3D=3D MCOPY_ATOMIC_ZEROPAGE) {
> > +     if (mode =3D=3D MFILL_ATOMIC_ZEROPAGE) {
>
> The mode comes from "& MFILL_ATOMIC_MODE_MASK" but it doesn't quickly tel=
l
> whether there's a shift for the mask.
>
> Would it look better we just have a helper to fetch the mode?  The functi=
on
> tells that whatever it returns must be the mode:
>
>        if (uffd_flags_get_mode(flags) =3D=3D MFILL_ATOMIC_ZEROPAGE)
>
> We also avoid quite a few "mode" variables.  All the rest bits will be fi=
ne
> to use "flags & FLAG1" if it's a boolean (so only this "mode" is slightly
> tricky).

Agreed, this is simpler. I'll make this change.

>
> What do you think?
>
> Thanks,
>
> --
> Peter Xu
>
