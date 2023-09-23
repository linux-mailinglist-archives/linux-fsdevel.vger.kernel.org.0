Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EADD7AC2D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 16:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjIWOw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 10:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjIWOw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:52:58 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DBD192;
        Sat, 23 Sep 2023 07:52:48 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4510182fe69so1494103137.3;
        Sat, 23 Sep 2023 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695480767; x=1696085567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwlxSAqIW9q+AC9IMz1LIgEWEyN6+XuZTJL4sShtOgw=;
        b=RmH/i9fNvq3gNhHATL92N0cr6qT2DbCgUVvls9j/Zr5rJkRWUchZzh5huiqnnOvnU2
         2fTtKFJv3WQv/Yhy2RP7/SFPUB/B5ZbmZxnThJAi8R88Q8zseVRs5+KOPt0s3o1C4dPi
         OPr0SfAPsOt5xVGCmb9AD3lVlPA33Er10VIWgc5L8f9miYW+JubHztSsPHBnE8S6dYSi
         MroUgPLktxqUDSmA0o7xWJNaF1gzpzupKKU1Bhe2FYk1cyemSDgdb9ur+CWTcOlc30Fv
         1cBdE4851sbUtVO/462yjOjqDr3Lu6sANHIV9ULn28nOsocPUresZt6akdAnD50GDmhO
         qpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695480767; x=1696085567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwlxSAqIW9q+AC9IMz1LIgEWEyN6+XuZTJL4sShtOgw=;
        b=v4tMo+mwO28qP9Nq09gJ5uvlePuzFz0lScZd5pw419DQZkmcGXA6NuVtEQB4HQSgx5
         uoa+lZqPByD4E+VhEzpaLqEWTl9mYV5iT5x0NvGwI1+NfO0YKLYivDRGuwCXjqIJEeor
         8WLHD7hIYUiocCYkrMGBRxpQLfc8dtZrz3sviy0q43Ta8Syrw6r103k27HI8lNb1cL+L
         WoGsRNtI7rBfYlVPb1oOi47h4/ucRMsjUnHR+Icm0yjJIig3lWZol9V3IFyR9xlffxeW
         +BoxOEJuYUwCbmAL8NKOyeEpYVl7yrdfoYTAPdoDppijvJ7eeu37qlieFbr4O2I18HXO
         Ye7Q==
X-Gm-Message-State: AOJu0YwVAH/R6rGN7/+jF+rjCBKQg86nFSVQFzLBuxVQ/iXva5/A5onM
        9cGyT7swb2vqjHTeaydrbsrgmvsMJsb/PhveV08=
X-Google-Smtp-Source: AGHT+IGUg5QHMM5ChrwrWZ3F7+uucRObwqHw+6AhB1bwVlqghcvjyTAKN2mYEMzlwAczwHJH69goDizuNgaQ2xnNGlM=
X-Received: by 2002:a67:cd05:0:b0:452:6fc1:a3e5 with SMTP id
 u5-20020a67cd05000000b004526fc1a3e5mr950135vsl.1.1695480767607; Sat, 23 Sep
 2023 07:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org> <CAOQ4uxiNfPoPiX0AERywqjaBH30MHQPxaZepnKeyEjJgTv8hYg@mail.gmail.com>
 <5e3b8a365160344f1188ff13afb0a26103121f99.camel@kernel.org>
In-Reply-To: <5e3b8a365160344f1188ff13afb0a26103121f99.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 23 Sep 2023 17:52:36 +0300
Message-ID: <CAOQ4uxjrt6ca4VDvPAL7USr6_SspCv0rkRkMJ4_W2S6vzV738g@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
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

On Sat, Sep 23, 2023 at 1:46=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Sat, 2023-09-23 at 10:15 +0300, Amir Goldstein wrote:
> > On Fri, Sep 22, 2023 at 8:15=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > My initial goal was to implement multigrain timestamps on most major
> > > filesystems, so we could present them to userland, and use them for
> > > NFSv3, etc.
> > >
> > > With the current implementation however, we can't guarantee that a fi=
le
> > > with a coarse grained timestamp modified after one with a fine graine=
d
> > > timestamp will always appear to have a later value. This could confus=
e
> > > some programs like make, rsync, find, etc. that depend on strict
> > > ordering requirements for timestamps.
> > >
> > > The goal of this version is more modest: fix XFS' change attribute.
> > > XFS's change attribute is bumped on atime updates in addition to othe=
r
> > > deliberate changes. This makes it unsuitable for export via nfsd.
> > >
> > > Jan Kara suggested keeping this functionality internal-only for now a=
nd
> > > plumbing the fine grained timestamps through getattr [1]. This set ta=
kes
> > > a slightly different approach and has XFS use the fine-grained attr t=
o
> > > fake up STATX_CHANGE_COOKIE in its getattr routine itself.
> > >
> > > While we keep fine-grained timestamps in struct inode, when presentin=
g
> > > the timestamps via getattr, we truncate them at a granularity of numb=
er
> > > of ns per jiffy,
> >
> > That's not good, because user explicitly set granular mtime would be
> > truncated too and booting with different kernels (HZ) would change
> > the observed timestamps of files.
> >
>
> Thinking about this some more, I think the first problem is easily
> addressable:
>
> The ctime isn't explicitly settable and with this set, we're already not
> truncating the atime. We haven't used any of the extra bits in the mtime
> yet, so we could just carve out a flag in there that says "this mtime
> was explicitly set and shouldn't be truncated before presentation".
>

I thought about this option too.
But note that the "mtime was explicitly set" flag needs
to be persisted to disk so you cannot store it in the high nsec bits.
At least XFS won't store those bits if you use them - they have to
be translated to an XFS inode flag and I don't know if changing
XFS on-disk format was on your wish list.

Thanks,
Amir.
