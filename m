Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A07A834D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 15:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjITN0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 09:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjITN02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:26:28 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DDCAD;
        Wed, 20 Sep 2023 06:26:22 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d8168d08bebso6733138276.0;
        Wed, 20 Sep 2023 06:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695216381; x=1695821181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLSemmPCVbpBlbh+m2deXKw5bP0O8nVBE628nBizgpw=;
        b=RQYqQdAIbUXNvEhfRe/HFWt7N28jaTRuPd17fEMx3dUCartjNCLSDJy3zlRg9vf8F9
         4Vg93ygpGkhRCnV8uxNY+AX8ZGNEhDGSjzLFPfvUBr8tb+y4WHQK9trD4jTiG241f50x
         y/ZpsvVNHAVlhCmRdQkLJD2vaAv+9N0AKegvIa3XePuOUqYD7FaJhOpi3fHLXOD/GI28
         DlhFrTvIpiFtqNBd5qOgKx+8rxa8vvoG6iKthVjXfl92wDKNbZVWFqj5HjxYOlsK6dx7
         fqiXk9lHrcnSITMYj1kiMcp1addBrKr+MKMF0PcRXJOb9wxcfWpYqd2AyFd10VMItcrj
         9sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216381; x=1695821181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLSemmPCVbpBlbh+m2deXKw5bP0O8nVBE628nBizgpw=;
        b=Nl9yXsz8DlvYoEuM7gjXbMpWWYgsLxZyvLkVH3/XWQLSQGQa0sNIvr8Z4AZan+MV5w
         q1y2+NW41fBh/Q455bDdC9LnZUzT+SBbxb3gs2YfRj0TQsZxRI9rnf0eWwVB3GSTxke9
         cUtkgj9GGj2gTeu6HlhVc8DgRuOYJnpfVfz1RWFpKpesUTBvPNfTBCvsET+0Y8nigRYL
         sUlKCdsbcA9rX3LyXZZealw7Vo5tMFDOcCd5KWu+rM5b0vMpElQb/Xwu9xR49VL4sg7W
         O8UJ4hM7x4QK/Tcuun1GS06wNu7BwvZ9d4oNaH7RKJqso0FBXbjR8tm1/ftRhHV9RX6Z
         I9Fw==
X-Gm-Message-State: AOJu0YwU1seGA6BmXAXdwiu7kkTLpAw4SvcLk931DugktkTaWO7UVksE
        unjei1UFjk0NVzSmMCsHkjE=
X-Google-Smtp-Source: AGHT+IE/ekXzgzpQL2FYG5TRav8078a0qwSHcWzbwuzfHEewjceyL2ZgX3yM7AlZ0hCrmKJZWHto5w==
X-Received: by 2002:a25:d895:0:b0:d77:f89f:fe59 with SMTP id p143-20020a25d895000000b00d77f89ffe59mr2427415ybg.27.1695216381300;
        Wed, 20 Sep 2023 06:26:21 -0700 (PDT)
Received: from firmament.. ([89.187.171.240])
        by smtp.gmail.com with ESMTPSA id t76-20020a25aad2000000b00d80df761a6csm3355421ybi.10.2023.09.20.06.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:26:20 -0700 (PDT)
From:   Matthew House <mattlloydhouse@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Date:   Wed, 20 Sep 2023 09:26:03 -0400
Message-ID: <20230920132606.187860-1-mattlloydhouse@gmail.com>
In-Reply-To: <CAJfpeguMf7ouiW79iey1i68kYnCcvcpEXLpUNf+CF=aNWxXO2Q@mail.gmail.com>
References: <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com> <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com> <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com> <20230918-hierbei-erhielten-ba5ef74a5b52@brauner> <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com> <20230918-stuhl-spannend-9904d4addc93@brauner> <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com> <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner> <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com> <20230919003800.93141-1-mattlloydhouse@gmail.com> <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com> <20230919212840.144314-1-mattlloydhouse@gmail.com> <CAJfpeguMf7ouiW79iey1i68kYnCcvcpEXLpUNf+CF=aNWxXO2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 5:42 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Tue, 19 Sept 2023 at 23:28, Matthew House <mattlloydhouse@gmail.com> w=
rote:
>
> > More generally speaking, the biggest reason I dislike the current singl=
e-
> > buffer interface is that the output is "all or nothing": either the cal=
ler
> > has enough space in the buffer to store every single string, or it's un=
able
> > to get any fields at all, just an -EOVERFLOW. There's no room for the
> > caller to say that it just wants the integer fields and doesn't care ab=
out
> > the strings. Thus, to reliably call statmnt() on an arbitrary mount, the
> > ability to dynamically allocate memory is effectively mandatory. The on=
ly
> > real solution to this would be additional statx-like flags to select the
> > returned strings.
>
> It's already there:
>
> #define STMT_MNT_ROOT 0x00000008U /* Want/got mnt_root  */
> #define STMT_MNT_POINT 0x00000010U /* Want/got mnt_point */
> #define STMT_FS_TYPE 0x00000020U /* Want/got fs_type */
>
> For example, it's perfectly fine to do the following, and it's
> guaranteed not to return EOVERFLOW:
>=20
>         struct statmnt st;
>         unsigned int mask =3D STMT_SB_BASIC | STMT_MNT_BASIC;
>=20
>         ret =3D statmount(mnt_id, mask, &st, sizeof(st), flags);

Whoops, my apologies; perhaps I should try to learn to read for once. (I
just saw the undecorated sequence of stmt_numeric() and stmt_string() calls
and didn't notice the early exits within the functions.) I withdraw that
particular objection.

> > Besides that, if the caller is written in standard C but doesn't want to
> > use malloc(3) to allocate the buffer, then its helper function must be
> > written very carefully (with a wrapper struct around the header and dat=
a)
> > to satisfy the aliasing rules, which forbid programs from using a struct
> > statmnt * pointer to read from a declared char[N] array.
>
> I think you interpret aliasing rules incorrectly.  The issue with
> aliasing is if you access the same piece of memory though different
> types.  Which is not the case here.  In fact with the latest
> incarnation of the interface[1] there's no need to access the
> underlying buffer at all:
>
>         printf("mnt_root: <%s>\n", st->str + st->mnt_root);
>
> So the following is perfectly safe to do (as long as you don't care
> about buffer overflow):
>
>         char buf[10000];
>         struct statmnt *st =3D (void *) buf;
>
>         ret =3D statmount(mnt_id, mask, st, sizeof(buf), flags);

The declared type of a variable *is* one of the different types, as far as
the aliasing rules are concerned. In C17, section 6.5 ("Expressions"):

> The *effective type* of an object for an access to its stored value is
> the declared type of the object, if any. [More rules about objects with
> no declared type, i.e., those created with malloc(3) or realloc(3)...]
>
> An object shall have its stored value accessed only by an lvalue
> expression that has one of the following types:
>
> -- a type compatible with the effective type of the object,
>
> -- a qualified version of a type compatible with the effective type of
>    the object,
>
> -- a type that is the signed or unsigned type corresponding to the
>    effective type of the object,
>
> -- a type that is the signed or unsigned type corresponding to a
>    qualified version of the effective type of the object,
>
> -- an aggregate or union type that includes one of the aforementioned
>    types among its members (including, recursively, a member of a
>    subaggregate or contained union), or
>
> -- a character type.

In this case, buf is declared in the program as a char[10000] array, so the
declared type of each element is char, and the effective type of each
element is also char. If we want to access, say, st->mnt_id, the lvalue
expression has type __u64, and it tries to access 8 of the char objects.
However, the integer type that __u64 expands to doesn't meet any of those
criteria, so the aliasing rules are violated and the behavior is undefined.

(The statmount() helper could in theory avoid UB by saying the struct
statmnt object is stored in the buffer as if by memcpy(3), but it would
still be UB for the caller to access the fields of that pointer directly
instead of memcpy'ing them back out of the buffer. And practically no one
does that in the real world.)

It's a common misconception that the aliasing rules as written are about
accessing the same object through two different pointer types. That
corollary is indeed what compilers mainly care about, but the C/C++
standards further say that objects in memory "remember" the types they were
created with, and they demand that programs respect objects' original types
when trying to access them (except when accessing their raw representations
via a pointer of character type).

> If you do care about handling buffer overflows, then dynamic
> allocation is the only sane way.
>
> And before you dive into how this is going to be horrible because the
> buffer size needs to be doubled an unknown number of times, think a
> bit:  have you *ever* seen a line in /proc/self/mountinfo longer than
> say 1000 characters?   So if the buffer starts out at 64k, how often
> will this doubling happen?   Right: practically never.  Adding
> complexity to handle this case is nonsense, as I've said many times.
> And there is definitely nonzero complexity involved (just see the
> special casing in getxattr and listxattr implementations all over the
> place).
>
> Thanks,
> Miklos

I've always felt that capacity doubling is a bit wasteful, but it's
definitely something I can live with, especially if providing size feedback
is as complex as you suggest. Still, I'm not a big fan of single-buffer
interfaces in general, with how poorly they tend to interact with C's
aliasing rules. (Also, those kinds of interfaces also invite alignment
errors: for instance, your snippet above is missing the necessary union to
prevent the buffer from being misaligned, which would cause UB when you
cast it to a struct statmnt *.)

Thank you,
Matthew House
