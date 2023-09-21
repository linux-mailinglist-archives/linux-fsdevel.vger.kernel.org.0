Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A57B7A9959
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjIUSNj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjIUSMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:12:33 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F009D53650
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:31:49 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d8165e3b209so3425080276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695317502; x=1695922302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tLFWbcb1IrLWIYefg9HuOVDdBjkCq6t27dXg5hrJMc=;
        b=I3n5YZtiK7mWzqyvGKFFFHjiCYJ9grulFq6BYwVEucI3pHJ8a+TSg4nJtxx8XK5Uww
         OfTHzOBM8b7QxqfI0PlqCBO5L5AWhrLv1j+8pEVd4C9DCI+swdWrt6Y6z5J8jBhv+2cK
         r8j+YBCfBYUXE0Gs95IGPvvJ+/+YVbNRt0XtsenNav1qzn6F2hpR97IfzmklOg0Cibtn
         wV2hW+49LJdyM5nHEAfoI7w5HXwhc0I8BZJWv8ML3ajFJl+QE2oZxS88Wjl9jud8jNZC
         Sewq9TNbdJ/zCdoLSgTlzTQTPyvUPg28ickOcMTZksNcILZcc+upaCBWcjnFaXfhIqDH
         3CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317502; x=1695922302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tLFWbcb1IrLWIYefg9HuOVDdBjkCq6t27dXg5hrJMc=;
        b=P3Q3yzflOmrvbxY3qo9vZ3cmUMT7PA+YeLxGqxdOpNd+v7NMRjR/v84eU8nThEsx+8
         aGjnWTeUbfZAQhItMhs4+g/0JN+0Q0D/YynqqZ8Q0fvHpzpfW3knQGbyXgqe0t/bkDBo
         wuYnigroZKFRMa+EQ+GvlsOIYKa/S2CUL/c3fZltL6cYXjdI8g4bweMiZBnh135zOfSR
         LtOCdJTII/bGOFCvgVE8A22Yd8MiaBHhfMoEugNR4zmZBSM6GamJVAn8gVtle82PpyxC
         ItcHc8ts5OPb+UDxoJ/Lp1W7g4bsiW5TW6MI9kCKow7DIB/wbB6M84POmckOTUK4Dyol
         ezfg==
X-Gm-Message-State: AOJu0Yxri01wpO3+9QgUsFYDdiIofQ2gz9lr6BQ+ROKiQEOtjcnFsIPO
        IJ6zy41RY1u7NdHUtW/7WnjiePyvSclJXMxMYomm0UM4jXo=
X-Google-Smtp-Source: AGHT+IHX/dI/2JinkMoZScr9VzhGhRn3WTVCXI4+LcXkDcLNcFF91JSrjqSIzn/Oj3vS4Wie0igsm5UUt1W8PYEZar0=
X-Received: by 2002:a05:6102:36c5:b0:452:61fa:1e04 with SMTP id
 z5-20020a05610236c500b0045261fa1e04mr4074837vss.9.1695281613221; Thu, 21 Sep
 2023 00:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
 <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com> <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
In-Reply-To: <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Sep 2023 10:33:21 +0300
Message-ID: <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 9:15=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 20 Sept 2023 at 15:57, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Unlike Alession's version, this implementation uses the explicit ioctl
> > flag FUSE_BACKING_MAP_ID to setup an "inode unbound" backing file
> > and the explicit open flag FOPEN_PASSTHROUGH_AUTO_CLOSE
> > to unmap the backing id, when the backing file is assigned to the fuse =
file.
>
> That sounds about right.  I'm not sure the flexibility provided by the
> auto/noauto mode is really needed, but taking this out later in the
> development process shouldn't be a problem.
>
> >
> > FOPEN_PASSTHROUGH (without AUTO_CLOSE) would let the server
> > manage the backing ids, but that mode is not implemented in the example=
.
> >
> > The seconds passthrough_hp commit:
> > - Enable passthrough of multiple fuse files to the same backing file
> >
> > Maps all the rdonly FUSE files to the same "inode bound" backing
> > file that is setup on the first rdonly open of an inode.
> > The implementation uses the ioctl flag FUSE_BACKING_MAP_INODE
> > and the open flag FOPEN_PASSTHROUGH (AUTO_CLOSE not
> > supported in this mode).
>
> I think the natural interface would be to setup the inode mapping in
> the lookup reply (using the normal backing ID).
>
> With your current method, what's the good time for establishing the
> mapping?  After the lookup succeeded, obviously.  But then it might
> already have raced with open...
>

I don't understand the concern.

This API leaves the control of when to setup/teardown the
mapping completely in the hands of the server.

Avoiding races in the "inode bound" mode is also the responsibility
of the server.

Quoting from the kernel commit of FUSE_BACKING_MAP_INODE:

"If an inode bound backing file already exists, the ioctl returns -EEXIST.
 Managing which thread sets up the backing file for concurrent file open
 requests is the responsibility of the server.
...
 The FUSE server may call FUSE_DEV_IOC_BACKING_CLOSE ioctl to break
 the association between the backing file and the inode.

 If there is no inode bound backing file, the ioctl returns -ENOENT.
 Managing which thread detaches the backing file is the responsibility of
 the server."

In my example, the server happens to setup the mapping
of the backing file to inode
*before the first open for read on the inode*
and to teardown the mapping
*after the last close on the inode* (not even last rdonly file close)
but this is an arbitrary implementation choice of the server.

This example server has a lock on the server inode object,
which is already used among other things to safely track the number
of open fd on that inode (inode.nopen), so it was easy to
implement the map/unmap in these code points.

> >
> > The "inode bound" shared backing file is released of inode evict
> > of course, but the example explicitly unmaps the inode bound
> > backing file on close of the last open file of an inode.
> >
> > Writable files still use the per-open unmap-on-release mode.
>
> What's the reason for using different modes on different types of opens?
>

The reason is to demonstrate that different FUSE files can use
different backing file modes and that several FUSE files can share
the same backing file.

In the "inode bound" mode, the backing file is *shared* among all
openers of the inode that set backing_id =3D 0 in the open reply.

If I wanted to demo share the same backing file for readers and writers
I would have needed to re-open the backing file with O_RDWR
on the first rdonly open.

It was convenient for the purpose of the demo to share the rdonly
file from the first rdonly open, among all readers. This demo is
not 100% correct in the sense that if the first open for read
has O_NOATIME and the other open for read do not, all will
use the backing file with O_NOATIME, but this is a minor
implementation detail that the server is fully able to handle.

From your questions, it seems that you either do not like my
proposal of the special backing_id 0, or maybe you missed it
because I did not point it out.

The current kernel implementation does NOT refcount the
backing_id only the fuse_backing object.

The way that auto-close-on-evict is implemented is simply by
not having a backing_id for the "inode bound" backing files.

The way that auto-close-on-fput is implemented is simply by
handing over the backing_id from server to kernel on open
reply, which unmaps the backing_id and atomically transfers the
ownership of the fuse_backing object to the fuse file.

This is not the most powerful API, but
1. It is simple
2. It can be extended later (i.e. by allowing both
    FUSE_BACKING_MAP_{INODE,ID} or another flag)

Is that clear? Do I need to document it better?
Do you find this API useful/acceptable?

If not, I can drop the FUSE_BACKING_MAP_INODE mode
patch and implement the server managed backing ids mode
in the example (by storing the backing_id in the server inode).

Thanks,
Amir.
