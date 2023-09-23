Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDD47AC519
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 22:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjIWUnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 16:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWUnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 16:43:24 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F23B11B;
        Sat, 23 Sep 2023 13:43:18 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3ae31be5ee9so703560b6e.2;
        Sat, 23 Sep 2023 13:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695501797; x=1696106597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5fh3KTYudy9uf30WQHLYoA6WKrTKy0P0fUHqm5/Lms=;
        b=ltFotPsVYDAf/sIAjYkeCoMf1OKvvdQ5atbusBNuJqlFU9iHbT3sbo5Zs+ynd9kGmI
         OHScMeCB16Mb+U7hk3/Cd5q7uZhz1eiXdL4iPztN7ADQCGACrhZp2/OFzTdBEIOTd/sm
         jN7A/B1k3eV92DtqsIFLy68d/9NPo1DUYqfRKWFlJN05cY3W8otlKdDtHWXdFlJIT5ZG
         eY3ls7tM4YQOtx6chVwZp7qhsXABm0Hoc345j+OIAAwGc3Paa3q2vdU6GMfaSt2MQbih
         eVKsBm0h1Z63LxsTBgGlefx/e0uUGQf1utprMvCzUZq4Ag4u2OksPWmufm1RU5EVbySK
         NUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695501797; x=1696106597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5fh3KTYudy9uf30WQHLYoA6WKrTKy0P0fUHqm5/Lms=;
        b=kqiznan2vdFG67xb3scscUWj7rphEGR+FieUpiBRbHIvYPjPDqfcq1CTupWO2s1H/S
         ffMJy1pt68vcm2LWVBxS4xV1b3pnMlYGGteoEe58vsTDd93+VXoLsaI9A1fOiu36LQ+V
         X5bmGq4pEIiWF+r1aLwpVDxKpz1WLEzFQTuNeVpl+haQl7hoMcHWSwXscaRNMbrwz+nW
         FCDtcadjFZ4VyV0PIuKic4yTMN9wHPQnR1jYtcL2KcFHn3r7GHO6Q6GfY3O7ds98JYYE
         +4TOi1WQ+o2TqngImd0gXXA4ZeZlF3p9AQKOVp/VyZopT4LDLQFfsWfQeTAtX0JyfkvN
         kjmw==
X-Gm-Message-State: AOJu0Yxhn4sWcmoZdI16Bcu91tsN/4bNY84k80L2uusUp2Cmn/H8N+1t
        7kWj4RM54W4ylefX9zPiAvZeH0Q/+SUgTX5wAmk=
X-Google-Smtp-Source: AGHT+IGN/Glws95UsE4NgepBit03p5QHyayACy2aU/ZsaLEGKSY9pUo9lFqpFX/kbc8EpF+yjvBA4bQYzs1Xby88p10=
X-Received: by 2002:a05:6808:199f:b0:3a8:4d1f:9dd0 with SMTP id
 bj31-20020a056808199f00b003a84d1f9dd0mr4316251oib.30.1695501797512; Sat, 23
 Sep 2023 13:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org> <CAOQ4uxiNfPoPiX0AERywqjaBH30MHQPxaZepnKeyEjJgTv8hYg@mail.gmail.com>
 <5e3b8a365160344f1188ff13afb0a26103121f99.camel@kernel.org>
In-Reply-To: <5e3b8a365160344f1188ff13afb0a26103121f99.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 23 Sep 2023 23:43:06 +0300
Message-ID: <CAOQ4uxjGofKT2LcM_YmoMYsH42ETpB5kxQkh+21nCbYc=w1nEg@mail.gmail.com>
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
> The second problem (booting to older kernel) is a bit tougher to deal
> with however. I'll have to think about that one a bit more.

There is a straightforward solution to both these problems -
opt in with a mount option to truncate user visible timestamps to 100ns
(and not jiffy) resolution as Linus is trying to promote.

Thanks,
Amir.
