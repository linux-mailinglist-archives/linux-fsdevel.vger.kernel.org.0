Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE01351A21D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 16:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351256AbiEDO00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 10:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbiEDO0Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 10:26:25 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9999A2019D;
        Wed,  4 May 2022 07:22:49 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id jt15so930600qvb.8;
        Wed, 04 May 2022 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOJe8EFexHCJl/2Bc6RO8FsgtVtMHIZENqTmuqDEE2I=;
        b=R+I1KpWncwM37jcDvaWaBIuoT9NF2QuLZPr3IjIF3/+9wYNZpMUCmWM4I8X+wd0R+j
         4jCa+JKhojklqTV34Vg8ws3Oj4dt2uZ3xeqEHypoOH7pgSfZiWXKgAtZrCNR8OV5iOr9
         N7Z9D3bLQTIAL14ZgAhrx9teDv5uV/2WjOwbkygKqUE6TcMQeMUXn1WQtyfO4RP0psnV
         pTyNZ8JD/FOYiPBRQW9RN9KF0Q7I6RcCX8WLgk5BMVpfM/StWJDN+IIJXZKLDNqbHRJx
         9mj1bVojs2UukUKW8UG5Xm5x0UKWCBJUxqN2XI2jMIuU0oaHoqazZWigbqbZ6h2kF7HO
         u8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOJe8EFexHCJl/2Bc6RO8FsgtVtMHIZENqTmuqDEE2I=;
        b=TrHsyD4Ex1gOrU53MOICf+G9y9zhcO0bChKTomw5a+cNtgNZTkzfMmaleA754KI8CU
         W+7HTW92QUzltdD9SztzV6K0LDD34MYF2v6CgD0jw5oah3eRfJyZSATGuEKCczY3X6ak
         SlfAzsJhW/HIngoWbatqeYD/oiVs7P1AcNc/luB+NrxxcSwfeA9fQZ72GjV1SQO4ngIy
         eMamI+HldtmeTfVlqORWuafRjqbs+EpWiW0QRIbt6pa0QMTyPPbI7VB7oLXdOBQ0jA/g
         Zvt/z9KhyqsEAIOcgV/ComeWKR0n11jG57praE3qi+EFDHTOuf6PjiMdr/DPIBsUushQ
         adHQ==
X-Gm-Message-State: AOAM531snmsNWPQRxsxwWcVcwOAlef24Qm0xTmPRGH9t2bcWUSUcPeI2
        VuNIXi6O2jN618dTJrTaakiT1LrOZKS+SL3fvzs=
X-Google-Smtp-Source: ABdhPJwSLcDDkqI8PXeUJie+v61GcNmYEMGXjvyoA5jowaY5/ifSkN39Q1mNINDyd/sv/G2PmFUQ5nrtxbNGknZIn08=
X-Received: by 2002:a05:6214:1cc4:b0:435:35c3:f0f1 with SMTP id
 g4-20020a0562141cc400b0043535c3f0f1mr17657763qvd.0.1651674168694; Wed, 04 May
 2022 07:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220503224305.GF1360180@dread.disaster.area>
 <CAJfpegt_p2Tg+Tr34PtKSXvTyTJdTTwALMPRVE8KK2NmNVZhEg@mail.gmail.com>
In-Reply-To: <CAJfpegt_p2Tg+Tr34PtKSXvTyTJdTTwALMPRVE8KK2NmNVZhEg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 May 2022 17:22:37 +0300
Message-ID: <CAOQ4uxhALMgZeFHpPhu8oshrBzBjHcV-vTpFO=b-MeQ3OsQ6Ug@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
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

On Wed, May 4, 2022 at 10:18 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 4 May 2022 at 00:43, Dave Chinner <david@fromorbit.com> wrote:
>
> > "values" is a very generic name - probably should end up being
> > something more descriptive of the functionality is provides,
> > especially if the header file is going to be dumped in
> > include/linux/. I don't really have a good suggestion at the moment,
> > though.
>
> The obvious ones are stat and attr, which are taken already.   Info is
> probably too generic as well.
>
> Ideas are welcome.

I was thinking of "properties".

>
> >
> > ....
> >
> > > +
> > > +enum {
> > > +     VAL_MNT_INFO,
> > > +};
> > > +
> > > +static struct val_desc val_mnt_group[] = {
> > > +     { VD_NAME("info"),              .idx = VAL_MNT_INFO             },
> > > +     { }
> > > +};
> > ....
> > > +
> > > +
> > > +static struct val_desc val_toplevel_group[] = {
> > > +     { VD_NAME("mnt:"),      .get = val_mnt_get,     },
> > > +     { VD_NAME("mntns:"),    .get = val_mntns_get,   },
> > > +     { },
> > > +};
> >
> > I know this is an early POC, my main question is how do you
> > envisiage this table driven structure being extended down from just
> > the mount into the filesystem so we can expose filesystem specific
> > information that isn't covered by generic interfaces like statx?
>
> I was thinking of adding a i_op callback.   The details are a bit
> fuzzy, since the vfs and the fs would have to work together when
> listing the attributes and possibly also when retrieving the attribute
> itself (think mount options).
>

No, please do not think mount options :)
Please think of an interface that does not mix vfs and fs properties.

Sure, with mount(2) you can mix fs and vfs options, but with the new interface
they should be clearly separated for set and get if possible.

":mnt:info" key to get the effective mount options (as in /proc/$$/mountinfo)
does not contradict that, because it can be read only.

Thanks,
Amir.
