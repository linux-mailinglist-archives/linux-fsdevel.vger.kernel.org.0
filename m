Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A664851CD69
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387280AbiEFAKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 20:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241593AbiEFAKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 20:10:52 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3688A4EDED;
        Thu,  5 May 2022 17:07:11 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id p3so2832403qvi.7;
        Thu, 05 May 2022 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bydLn+MaadsEKy9TI70LzBq8Pin31TT5BFRic3vn7g=;
        b=kBDdht1mILQDR5YeRdYRciPLf6mSNjR+h0e4piIWG2v8aN4VZaGlo+qap7nOYmeaGx
         ykor7T6KQ9snP0rfDQPcX3sgVerXCx6FC9d88f3omuuFO3fMdZcld1G8nCw/Akc3Gk66
         +Qu5kDjJC6m2a14JBY4fOGHv0/fp27PK4YtfLLbObBYnvpqI8YJ16ej6DR96SbijW0HR
         dooiWGfHSDM94Ejq0KDN6sUCbFZ2lTi/X8tHyPUEpKdha+Q/KHe9K6CqgiaCtQi2X4OO
         Sz5YpmJMwt6PVDzlhGB4MI4AjRuGDD0jzgiSEmDxrsiqBlapkhAsLKWedHm/4m+kM8fk
         NFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bydLn+MaadsEKy9TI70LzBq8Pin31TT5BFRic3vn7g=;
        b=IBEgNahNw/9d6uFQBP3bI8e6AKjU+F+RSve1amoDcTVE41GejnOVH+OxPdCGZ4bVB7
         EkindYrBERxCMXZ4Es3gNqnMl1k4pU8nF2GQ8fylf3k1dAikUHBVnzyxdyDUgiOQg/e0
         rkPSWCaUtDue8oeRFQh3807NFKoD0njz/ZJEEv0KNFI5mb2+t78kBLvzsmFnlcWetVJN
         /o6M9GhjHLTPCNmVX6GgWf0PWiqkaNnYORqPo9St252yseOXt0NqLR3Dsjuffa5prA6D
         fWvLbxuWSNVwMDVI4wnOSh29HCOkrSvMk/fEk4ZINc1cVo5DApPcC+OLXMp8vSgLNYIj
         Akbw==
X-Gm-Message-State: AOAM531gmSWVRafE+L2n76R/mKxQalMo4g0VRnTlK2GTQxsWDRHdTOnC
        HI4JxJpE+9RuiT43uvJjxGL2Iloe6P1OGlXc0hs=
X-Google-Smtp-Source: ABdhPJyaDpmUFa8693GGOZKoshTrgqWPC/GVkZGfl0YdqcEiBmM9HArJu/b29zQy+tTX4iGxH14Qy7qgeQaSVDLphTM=
X-Received: by 2002:a05:6214:2409:b0:432:bf34:362f with SMTP id
 fv9-20020a056214240900b00432bf34362fmr485516qvb.66.1651795630327; Thu, 05 May
 2022 17:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <YnRf5CNN2yNKVu0B@mit.edu>
In-Reply-To: <YnRf5CNN2yNKVu0B@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 6 May 2022 03:06:59 +0300
Message-ID: <CAOQ4uxjXMMLBex0exsWYuA14QMc_0tPenx_bC2AynShUoGZzEw@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     tytso <tytso@mit.edu>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 6, 2022 at 2:38 AM tytso <tytso@mit.edu> wrote:
>
> On Tue, May 03, 2022 at 02:23:23PM +0200, Miklos Szeredi wrote:
> >
> > : - root
> > bar - an attribute
> > foo: - a folder (can contain attributes and/or folders)
> >
> > The contents of a folder is represented by a null separated list of names.
> >
> > Examples:
> >
> > $ getfattr -etext -n ":" .
> > # file: .
> > :="mnt:\000mntns:"
>
> In your example, does it matter what "." is?  It looks like in some
> cases, it makes no difference at all, and in other cases, like this,
> '.' *does* matter:

It does. If "." was a directory in /proc/ or in ext4 it might have had
more entries.

>
> > $ getfattr -etext -n ":mnt:info" .
> > # file: .
> > :mnt:info="21 1 254:0 / / rw,relatime - ext4 /dev/root rw\012"
>
> Is that right?
>
> > $ getfattr -etext -n ":mntns:" .
> > # file: .
> > :mntns:="21:\00022:\00024:\00025:\00023:\00026:\00027:\00028:\00029:\00030:\00031:"
>
> What is this returning?  All possible mount name spaces?  Or all of
> the mount spaces where '.' happens to exist?

This confused me too.
It is not returning the mount namespaces, it is returning all the mount ids
in the mount namespace of ".".
":mntns:mounts:" might have been a better choice of key.

Thanks,
Amir.

>
> Also, using the null character means that we can't really use shell
> scripts calling getfattr.  I understand that the problem is that in
> some cases, you might want to return a pathname, and NULL is the only
> character which is guaranteed not to show up in a pathname.  However,
> it makes parsing the returned value in a shell script exciting.
>
>                                          - Ted
