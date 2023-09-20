Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E337A8455
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 15:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbjITN5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 09:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbjITN5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:57:15 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CC618C
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 06:57:08 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-49618e09f16so2689437e0c.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695218227; x=1695823027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhaPqEvqUiS8JbgKj+43v3M6B7M27lucTNFcAUnIHvw=;
        b=H6oy1lHFhkpycjrtA3Ith0/bXITI0kqIb9GL45fCYbW3vwgc4BUnuYee74K7q6BBJ7
         hWIRXyClZ4xj80ZfQzNtkQQX439VHfeP2kfPy+cNpaJeA5rxDB1uv/a9d/E15p7LGjM4
         5JvMx6xUi68PG/SH1OfUluD78Kf1yl/XqCGUmVRMqJpPoZrNOkV27//b33w9NCr2JM7P
         IxbciKJV5pw4VR6d6K45yddN100t7hbxV/N8qR4gEqXvhHAY31Qan+27q7zTyB4yR1Za
         RC7pkHx5Eu1G+AulZkZ7TarrpQv+2xn8xDEqAnOTz5mA/KNOU6YDn3Inyevczuq3Hwzm
         QEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695218227; x=1695823027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhaPqEvqUiS8JbgKj+43v3M6B7M27lucTNFcAUnIHvw=;
        b=S3v6d2NtP07YYX+XnJdV2ZMI3arSuP7VcfNVvmBsikq5o6y22Ib8EudoN8E2NsA0aE
         I8wV5At6GFtXhzuCqOe4ztIANGoHOermMBHSR36pBLQCWFHPAQTycAm1wydfGTcpPr6g
         G90hRfdBAq8SdTIkUugD3qDgTXx0lb2ZaOfM1t09afXJNUHwOUr5CD/7hQZEM7fHVvfG
         tj2DlUZsMSUBIL0wefaaCd4d/ulZVf/58tADp75wZ1PZWKxz8sK8oXbhNEIOoWGRErTf
         9LL8qo+Amzkpi437C85V3Q+Bg43rO/egcbga9QOjRHXfToO6TH5i1kJvJvfLXXHYTXtP
         NgOw==
X-Gm-Message-State: AOJu0YzXCJmgtaiviBomV/yG8QdZ20iqQQa8eifZxTaycQFRC4Ukt8u+
        XpIGkT1J6cfD4KGAUg8CNrcI8qGk6A0KFCQSBqI=
X-Google-Smtp-Source: AGHT+IEug4kqLHC4+7uIjMlwhOY1hz76wDeif6DtHr8RfKvWQTw1JulgUcQsANxC4QU4ZS5JDo5KzFLcwHEMqmWTpjs=
X-Received: by 2002:a1f:d686:0:b0:495:bf44:6a07 with SMTP id
 n128-20020a1fd686000000b00495bf446a07mr2327555vkg.9.1695218227091; Wed, 20
 Sep 2023 06:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com> <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 20 Sep 2023 16:56:55 +0300
Message-ID: <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
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

On Tue, Aug 29, 2023 at 9:14=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Jun 6, 2023 at 4:06=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Tue, 6 Jun 2023 at 13:19, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Tue, Jun 6, 2023 at 12:49=E2=80=AFPM Miklos Szeredi <miklos@szered=
i.hu> wrote:
>
> [...]
>
> > > >    I'm not sure that the per-file part of this is necessary, doing
> > > > everything per-inode should be okay.   What are the benefits?
> > > >
> > >
> > > I agree that semantics are simpler with per-inode.
> > > The only benefit I see to per-file is the lifetime of the mapping.
> > >
> > > It is very easy IMO to program with a mapping scope of
> > > open-to-close that is requested by FOPEN_PASSTHROUGH
> > > and FOPEN_PASSTHROUGH_AUTO_CLOSE.
> >
> > Right, and this case the resource limiting is also easy to think about.
> >
> > I'm not worried about consistency, fuse server can do whatever it
> > wants with the data anyway.  I am worried about the visibility of the
> > mapping.  One idea would be to create a kernel thread for each fuse sb
> > instance and install mapped files into that thread's file table.  In
> > theory this should be trivial as the VFS has all the helpers that can
> > do this safely.
> >
>
> Sounds doable.
> I will look into this after I get the basics sorted out.
>
> > >
> > > I think if I can make this patch set work per-inode, the roadmap
> > > from here to FUSE-BPF would be much more clear.
> >
> > One advantage of per-inode non-autoclose would be that open could be
> > done without a roundtrip to the server.   However the resource
> > limiting becomes harder to think about.
> >
> > So it might make sense to just create two separate modes:
> >
> >  - per-open unmap-on-release (autoclose)
> >  - per-inode unmap-on-forget (non-autoclose, mapping can be torn down
> > explicitly)
> >
>

Miklos,

I have a POC for the two modes above, see kernel patches [1] and
passthrough_hp example[2].

As far as I know, I addressed all your review comments on v13:
1. factor out common helpers from overlayfs
2. factor out ioctl helpers
3. per-file and per-inode backing file modes
4. optional auto close flag

Only thing not addressed yet is lsof-visibility of the backing files.

The first passthrough_hp commit:
- Enable passthrough mode for read/write operations

Is the original passthrough_hp POC of Alessio, which implements
the per-open unmap-on-release (autoclose), as the original POC did.

Unlike Alession's version, this implementation uses the explicit ioctl
flag FUSE_BACKING_MAP_ID to setup an "inode unbound" backing file
and the explicit open flag FOPEN_PASSTHROUGH_AUTO_CLOSE
to unmap the backing id, when the backing file is assigned to the fuse file=
.

FOPEN_PASSTHROUGH (without AUTO_CLOSE) would let the server
manage the backing ids, but that mode is not implemented in the example.

The seconds passthrough_hp commit:
- Enable passthrough of multiple fuse files to the same backing file

Maps all the rdonly FUSE files to the same "inode bound" backing
file that is setup on the first rdonly open of an inode.
The implementation uses the ioctl flag FUSE_BACKING_MAP_INODE
and the open flag FOPEN_PASSTHROUGH (AUTO_CLOSE not
supported in this mode).

The "inode bound" shared backing file is released of inode evict
of course, but the example explicitly unmaps the inode bound
backing file on close of the last open file of an inode.

Writable files still use the per-open unmap-on-release mode.

I ran this POC on fstests using the newly added support for
running fuse in fstests with a mount helper (one libfuse patch
in my branch improves the mount helper).

First I verified that the group -g quick.rw passes on baseline
passthrough_hp and then I tested with backing files enabled.
The tests found some failures with splice_{read/write}, so
I added support for splice_{read/write} to backing files and
then all the tests passed.

NOTE that if the FOPEN_PASSTHROUGH directive fails for
any reason, this will not fail the open - it will just open the file
without passthrough, and if a valid backing_id is provided
with FOPEN_PASSTHROUGH_AUTO_CLOSE, then the
backing file will be auto closed regardless if the open fails.

Please ACK this API design and then I will continue to clean up
the kernel patches and post them for review.

I still plan to:
1. Move more code into backing_file helpers (i.e. splice/mmap)
2. Install fds of backing files in kernel task file table

Please let me know if you have any comments so far and if
you want me to post the patches even without the kernel task,
as that may take me a bit longer to get to.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fuse-backing-fd
[1] https://github.com/amir73il/libfuse/commits/fuse-backing-fd
