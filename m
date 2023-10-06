Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713847BB80F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 14:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjJFMtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 08:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJFMtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:49:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0226DCA
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 05:49:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c136ee106so372460966b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 05:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696596542; x=1697201342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AHjmOOVg74tMZjWptrYGXUC/br+tpPBZRDuB46pbJ4=;
        b=cybkrnUGy9JdW8Bq6HZ3s8LtKVkPFd3uIuxU3nZegmL8NCx/gJJvd4tkIGEOEjaGVc
         TBoQtvncVvvHAiLlNaACmW3GzFvABrLFQMBK7qZkiOr99ujkOEw1F7OLlOWTYVCaevW+
         0CZrL8GNUXClnCF0odjdk3rC5BDyMihuR2Mfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696596542; x=1697201342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AHjmOOVg74tMZjWptrYGXUC/br+tpPBZRDuB46pbJ4=;
        b=ADk7FG++uIYWG2RZvjEU9AYU/0Fa0PI1aTizYPkIdfiy9Q69IbP3InICp40ZqSDx2x
         HzgMkOFl7o63USb3binptCk2cVtEOwNlQKoMnpvBG/4wfBVGizq2/NrbeDVKzSZyvMBB
         pxonNXh3yGbkGtVBPv2kttj64pVDuQyq+dEqWAyWG88ZTqNLyt81L6rykjNMQtBaUgcv
         OBOLNNa8ciufFOjfRS3fQUBC7QmEqieO0dC1r5PkF4OxcmkeJf4Ewg2/cZKVdk7pIDEo
         OFkU4HFWk0M/+iuUik/Sa+nlYKChbEhH0mo/O4BBsmtO2pPPFglK3g7RBNocPjdy9XVy
         9b8A==
X-Gm-Message-State: AOJu0YyX4V8zZv4duJdm3yqIK9muPS6bhDqJyXAB8Da+5vdcKPiLFd8F
        Mk7X2nE84Uy262M+UJkjj81OjIA3Mg20D1WJLc3Vtw==
X-Google-Smtp-Source: AGHT+IHvhpoQukvgif68v6ZXOt6wMxc0dIOaTCgNjhO+rpuGoNyF7BA9zqJTf0SIaSVv9SnHJJPet2kdIR96Z6Sp450=
X-Received: by 2002:a17:907:7790:b0:9b9:facb:d950 with SMTP id
 ky16-20020a170907779000b009b9facbd950mr1823443ejc.72.1696596542320; Fri, 06
 Oct 2023 05:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-2-mszeredi@redhat.com>
 <CAJfpeguTQvA6cq-3JCEZx6wP+nvZX8E6_77pNRJUU2_S7cyAiA@mail.gmail.com> <CAOQ4uxgoA5eQCqXp0H7S+CtVM77OD4caQr59yHymtZUTwBCqLw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgoA5eQCqXp0H7S+CtVM77OD4caQr59yHymtZUTwBCqLw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Oct 2023 14:48:51 +0200
Message-ID: <CAJfpegudgvPQamq_9XyzE8-m5iVQSA=-2YPDcpt5sCtjmd9z0A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] add unique mount ID
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 6 Oct 2023 at 13:44, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Oct 5, 2023 at 6:52=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Thu, 28 Sept 2023 at 15:03, Miklos Szeredi <mszeredi@redhat.com> wro=
te:
> > >
> > > If a mount is released then its mnt_id can immediately be reused.  Th=
is is
> > > bad news for user interfaces that want to uniquely identify a mount.
> > >
> > > Implementing a unique mount ID is trivial (use a 64bit counter).
> > > Unfortunately userspace assumes 32bit size and would overflow after t=
he
> > > counter reaches 2^32.
> > >
> > > Introduce a new 64bit ID alongside the old one.  Initialize the count=
er to
> > > 2^32, this guarantees that the old and new IDs are never mixed up.
> >
> > It occurred to me that it might make sense to make this counter
> > per-namespace.  That would allow more separation between namespaces,
> > like preventing the observation of mount creations in other
> > namespaces.
> >
>
> Preventing the observation of mount creations in other mount namespaces
> is independent of whether a global mntid namespace is used.

A local ID space makes observation of mount creations in other
namespaces impossible.  While a global ID space does not.  ID
allocation could be designed in a way that makes observation
impossible, but that basically boils down to allocating separate
ranges to each namespace, which is equivalent to identifying mounts by
an {NSID, MNTID} pair.

>
> > Does a global number make any sense?
> >
>
> I think global mntid namepsace makes notifications API a lot easier.
> A process (e.g. systemd) may set marks to watch new mounts on
> different mount namespaces.
>
> If mntid could collide in different mount namepsaces, we will either
> need to describe the mount namespace in the event or worse,
> map child mount namespace mntid to parent mount namespace
> like with uids.

Mntids are quite different from uids in that a certain ID is only
valid in a certain namespace.   There's no inheritance or sharing of
mounts.  Also mounts cannot be moved from one namespace to another
(with the exception of mounts created in an anonymous namespace).

> If we use a global mntid namespace, multi mount namespace
> watching becomes much much easier.

If the watcher wants to interpret the received event it will have to
know the namespace anyway.  Otherwise it's just a meaningless number.

> Regarding the possible scopes for watching added/removed mounts
> we could support:
> - watch parent mount for children mounts (akin to inotify directory watch=
)

This probably makes sense.

> - watch all mounts of a filesystem

I don't see a use case.

> - watch all mounts in mount namespace

Yes.

> - watch on entire system

Again, I don't see how this could make sense.  Each time
unshare(CLONE_NEWNS) is invoked a storm of mount creation events will
happen.

I'd imagine that watching mounts is primarily to complement the
directory tree notifications, so that all changes to the path lookup
namespace of a process could be monitored.

Thanks,
Miklos
