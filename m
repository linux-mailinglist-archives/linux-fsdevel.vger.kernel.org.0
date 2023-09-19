Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974FB7A6CF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 23:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjISV3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 17:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISV3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:29:03 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783F9AD;
        Tue, 19 Sep 2023 14:28:57 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1d69b2ffa1fso2686253fac.2;
        Tue, 19 Sep 2023 14:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695158937; x=1695763737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k83mB67AhO9crOADOMNRAqoI12asl4cHCEzQDkmUjKY=;
        b=aozX6lmnXxRKnK3BNK0hYG13zEunx9VGbc0EyxTW+CbUFmDUeb5nqSQFUKKC7KGiFb
         biVR7VYyVVUkmwperKkWTSlEjSalORaeiDmX7PVUPlIzndOynKMbCrdF1ppPseJKJkzZ
         TXdxeRhjo4PGzDdTDo9lRudVyeymTMU/KkxQrKlOCCI4qTSB7TXiD5kGlmhkKdOTPPy9
         y2s+ZLSTfBBwD0bPXUmx/MquYLEkG1i/q8QfIuLo0DOo/vjzUt1aVpR1X3mdq2fI5S64
         w+w+jhwiADgpEsWoHZ4rYpA3RuOhNNsDQFIg29veLM0w8yqPKZmVT6fX6Ju4i16C+c74
         VEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695158937; x=1695763737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k83mB67AhO9crOADOMNRAqoI12asl4cHCEzQDkmUjKY=;
        b=T0lDkENS3J6rg+bWwhm9926pWime04CiZ64GK3OaNByF7fy/5rQdzZ2cTlFDD8wR+A
         tczuf0K5Rupm00J8/rPeYy4qdDJgF0ff0pIWS5eSyIq6jB+rbIkxtbX11IMugxVFIelI
         0RuzkEfJONDjH8R8bAzz/CSgnj0coWPFku4eJyzFdr99A868FHK9o+cvz7tP49OQAAsU
         fGze7XHEJ1DddYBQBxUQBaLEyDywdZD28l2ivylxyqGHwUHqHJCd5DgnX5nZAkT/L2KD
         H6a/YOiMzUPQ4S6BOu6IphR1bpP/Vw77CV6a0rakS1OyCTc0SO/8Gg8f9GK85wFHoifa
         +C+g==
X-Gm-Message-State: AOJu0YzNa9tKgHQVavM9v0kahmNghL36fhE12cjdT2mkLJEp2XXQ9oMk
        R58oPfovW56oViuD/Fo5Q+E=
X-Google-Smtp-Source: AGHT+IGSw6IsB8OK6JkcDjxUHlHYWdIdH576aFSFhR7R4tcyE4+vdzO3paz63AelUmM2aazXgb99+Q==
X-Received: by 2002:a05:6870:391f:b0:1bf:e522:7133 with SMTP id b31-20020a056870391f00b001bfe5227133mr736132oap.38.1695158936538;
        Tue, 19 Sep 2023 14:28:56 -0700 (PDT)
Received: from firmament.. (h198-137-20-64.xnet.uga.edu. [198.137.20.64])
        by smtp.gmail.com with ESMTPSA id z185-20020a8189c2000000b0059af9f2ee68sm3377091ywf.66.2023.09.19.14.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 14:28:56 -0700 (PDT)
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
Date:   Tue, 19 Sep 2023 17:28:38 -0400
Message-ID: <20230919212840.144314-1-mattlloydhouse@gmail.com>
In-Reply-To: <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com>
References: <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com> <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com> <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com> <20230918-hierbei-erhielten-ba5ef74a5b52@brauner> <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com> <20230918-stuhl-spannend-9904d4addc93@brauner> <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com> <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner> <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com> <20230919003800.93141-1-mattlloydhouse@gmail.com> <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com>
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

On Tue, Sep 19, 2023 at 4:02 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Tue, 19 Sept 2023 at 02:38, Matthew House <mattlloydhouse@gmail.com> w=
rote:
>
> > One natural solution is to set either of the two lengths to the expected
> > size if the provided buffer are too small. That way, the caller learns =
both
> > which of the buffers is too small, and how large they need to be. Repla=
cing
> > a provided size with an expected size in this way already has precedent=
 in
> > existing syscalls:
>
> This is where the thread started.  Knowing the size of the buffer is
> no good, since the needed buffer could change between calls.

As Brauner mentioned, this does not change with the single-buffer
interface. And since changes are not likely to occur extremely frequently,
I feel like it would be better for the caller to only need one retry in the
common case rather than N retries for however many doublings it takes to
fit the whole buffer.

> We are trying to create a simple interface, no?  My proposal would
> need a helper like this:
>
> struct statmnt *statmount(uint64_t mnt_id, uint64_t mask, unsigned int fl=
ags)
> {
>         size_t bufsize =3D 1 << 15;
>         void *buf;
>         int ret;
>
>         for (;;) {
>                 buf =3D malloc(bufsize <<=3D 1);
>                 if (!buf)
>                         return NULL;
>                 ret =3D syscall(__NR_statmnt, mnt_id, mask, buf, bufsize,=
 flags);
>                 if (!ret)
>                         return buf;
>                 free(buf);
>                 if (errno !=3D EOVERFLOW)
>                         return NULL;
>         }
> }
>
> Christian's would be (ignoring .fs_type for now):
>
> int statmount(uint64_t mnt_id, uint64_t mask, struct statmnt *st,
> unsigned int flags)
> {
>         int ret;
>
>         st->mnt_root_size =3D 1 << 15;
>         st->mountpoint_size =3D 1 << 15;
>         for (;;) {
>                 st->mnt_root =3D malloc(st->mnt_root_size <<=3D 1);
>                 st->mountpoint =3D malloc(st->mountpoint <<=3D 1);
>                 if (!st->mnt_root || !st->mountpoint) {
>                         free(st->mnt_root);
>                         free(st->mountpoint);
>                         return -1;
>                 }
>                 ret =3D syscall(__NR_statmnt, mnt_id, mask, st,
> sizeof(*st), flags);
>                 if (!ret || errno !=3D EOVERFLOW)
>                         return ret;
>                 free(st->mnt_root);
>                 free(st->mountpoint);
>         }
> }
>
> It's not hugely more complex, but more complex nonetheless.
>
> Also having the helper allocate buffers inside the struct could easily
> result in leaks since it's not obvious what the caller needs to free,
> while in the first example it is.

There's nothing stopping the userspace helper from exposing a contiguous
buffer that can be easily freed, even if the kernel API uses a separate-
buffer interface internally. It just takes a bit of addition in the helper
to calculate the correct pointers. To wit:

struct statmnt *statmount(uint64_t mnt_id, uint64_t mask, unsigned int flag=
s)
{
        uint32_t mnt_root_size =3D PATH_MAX;
        uint32_t mountpoint_size =3D PATH_MAX;
        struct statmnt *st;
        int ret;

        for (;;) {
                st =3D malloc(sizeof(*st) + mnt_root_size + mountpoint_size=
);
                if (!st)
                        return NULL;
                st->mnt_root =3D (char *)st + sizeof(*st);
                st->mountpoint =3D (char *)st + sizeof(*st) + mnt_root_size;
                st->mnt_root_size =3D mnt_root_size;
                st->mountpoint_size =3D mountpoint_size;
                ret =3D syscall(__NR_statmnt, mnt_id, mask, st, sizeof(*st),
                              flags);
                if (ret) {
                        free(st);
                        return NULL;
                }
                if (st->mnt_root_size <=3D mnt_root_size &&
                    st->mountpoint_size <=3D mountpoint_size)
                        return st;
                mnt_root_size =3D st->mnt_root_size;
                mountpoint_size =3D st->mountpoint_size;
                free(st);
        }
}

(This is also far more helpful for users of the returned struct statmnt *,
since they can just dereference the two pointers instead of having to
decode the offsets by hand.)

More generally speaking, the biggest reason I dislike the current single-
buffer interface is that the output is "all or nothing": either the caller
has enough space in the buffer to store every single string, or it's unable
to get any fields at all, just an -EOVERFLOW. There's no room for the
caller to say that it just wants the integer fields and doesn't care about
the strings. Thus, to reliably call statmnt() on an arbitrary mount, the
ability to dynamically allocate memory is effectively mandatory. The only
real solution to this would be additional statx-like flags to select the
returned strings.

Meanwhile, with a separate-buffer interface, where the caller provides a
pointer and capacity for each string, granular output would be trivial: the
caller could just specify NULL/0 for any string it doesn't want, and still
successfully retrieve all the integer fields. This would also work well if
the caller, e.g., wants to set a hard cap of PATH_MAX bytes for each string
(since it's using static buffers), but nonetheless wants to retrieve the
integer fields if a string is too long.

Besides that, if the caller is written in standard C but doesn't want to
use malloc(3) to allocate the buffer, then its helper function must be
written very carefully (with a wrapper struct around the header and data)
to satisfy the aliasing rules, which forbid programs from using a struct
statmnt * pointer to read from a declared char[N] array. In practice,
callers tend to very rarely exercise this proper care with existing single-
buffer interfaces, such as recvmsg(2)'s msg_control buffer, and I would not
be very happy if statmnt() further contributed to this widespread issue.

Thank you,
Matthew House
