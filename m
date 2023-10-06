Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4D37BB6E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjJFLow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 07:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjJFLov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:44:51 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AC1CE;
        Fri,  6 Oct 2023 04:44:50 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-65b0e623189so10041076d6.1;
        Fri, 06 Oct 2023 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696592689; x=1697197489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM+JEXPoWkqE2R2OZqnBYJfbJJGioqTQDA2fARdnsWI=;
        b=F7BpiSVf2F/x2fwRipqpz0Th059a8mX5wASI3qWhlG1NAZjnY/YFoftm3vrZQdXy4X
         78fdwPcMJ/Jvls85aPUMT0LVMB/Qx20twYzaOfzAr5yz8pY5PlwgJed5KPy6WLMVic0h
         aLLqXRQnS1GmZfZ63bRFFY894P7GXcxd+edrurwd6xyZZ4T0ybn9CGqzYftouc24roMK
         qQ0tD/CYDdruznRN+6JwegvDVITdnqjXJ3I4gkMCC3b433wgiMRVB193FsUgXIIqa6T5
         BLQOQXYzwxsbo/tXezj9UZXoQNsPLe6hIDwhKS2kytOI9A+54c4nuFqlpnHm5dlA4RAG
         ylow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696592690; x=1697197490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM+JEXPoWkqE2R2OZqnBYJfbJJGioqTQDA2fARdnsWI=;
        b=RGDrjEb15zBWB5uYU6ac25EbSEf1t4LKYAkgsh/UMNDkJiN+egaRSa1l3kYtPAAo4t
         ppGdIkpwGJV1s7L6lWEhxKTyvHS9kvTJOR3jM5WNsguG+SKWA09OeFDfPVvWkYbOLjqp
         muezzkrcnhbJfgPygYwBO8I6UuIVwOB3E4XGHOUgG/aQHdTmx4xitPawhYJ5OJeqVl2L
         5R31Us+NgpsW65az9thv3HNAFbe33KWEE8M1LN7KnVsdPbuWLsQ2JBO/l+/Rhc+VfZTL
         bHaHN+0pMZCqMZ9CUbC2iItC5nQXBabAGFMVs2+tdzHYv6x/8T9s5ke37qdIcYCSz00U
         WtPw==
X-Gm-Message-State: AOJu0YxnKjr7mlv1EIuHEMYw1uClS653nJutBKo9vZp390Ypqn4UI3IN
        kyeodw0Oos9uUYCIzYGi6/1Z9x4sJs7BkJATPm3ee5A9
X-Google-Smtp-Source: AGHT+IHVLFeVcOso79B+AyG6TlZQfq3OF2axjCboJd9gZ3N2/TlbvkrJJ9EFkyHfFiFvnF3ZBj+hl0iH+2OYB3iQySU=
X-Received: by 2002:a0c:c409:0:b0:64f:3699:90cd with SMTP id
 r9-20020a0cc409000000b0064f369990cdmr8286281qvi.42.1696592689654; Fri, 06 Oct
 2023 04:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-2-mszeredi@redhat.com>
 <CAJfpeguTQvA6cq-3JCEZx6wP+nvZX8E6_77pNRJUU2_S7cyAiA@mail.gmail.com>
In-Reply-To: <CAJfpeguTQvA6cq-3JCEZx6wP+nvZX8E6_77pNRJUU2_S7cyAiA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 6 Oct 2023 14:44:38 +0300
Message-ID: <CAOQ4uxgoA5eQCqXp0H7S+CtVM77OD4caQr59yHymtZUTwBCqLw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] add unique mount ID
To:     Miklos Szeredi <miklos@szeredi.hu>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 5, 2023 at 6:52=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Thu, 28 Sept 2023 at 15:03, Miklos Szeredi <mszeredi@redhat.com> wrote=
:
> >
> > If a mount is released then its mnt_id can immediately be reused.  This=
 is
> > bad news for user interfaces that want to uniquely identify a mount.
> >
> > Implementing a unique mount ID is trivial (use a 64bit counter).
> > Unfortunately userspace assumes 32bit size and would overflow after the
> > counter reaches 2^32.
> >
> > Introduce a new 64bit ID alongside the old one.  Initialize the counter=
 to
> > 2^32, this guarantees that the old and new IDs are never mixed up.
>
> It occurred to me that it might make sense to make this counter
> per-namespace.  That would allow more separation between namespaces,
> like preventing the observation of mount creations in other
> namespaces.
>

Preventing the observation of mount creations in other mount namespaces
is independent of whether a global mntid namespace is used.

> Does a global number make any sense?
>

I think global mntid namepsace makes notifications API a lot easier.
A process (e.g. systemd) may set marks to watch new mounts on
different mount namespaces.

If mntid could collide in different mount namepsaces, we will either
need to describe the mount namespace in the event or worse,
map child mount namespace mntid to parent mount namespace
like with uids.

If we use a global mntid namespace, multi mount namespace
watching becomes much much easier.

Regarding the possible scopes for watching added/removed mounts
we could support:
- watch parent mount for children mounts (akin to inotify directory watch)
- watch all mounts of a filesystem
- watch all mounts in mount namespace
- watch on entire system

Not sure which of the above we will end up implementing, but the
first two can use existing fanotify mount/sb marks.

Thanks,
Amir.
