Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB0E7A000D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbjINJay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 05:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbjINJaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:30:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB11BF8
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 02:30:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ad8a822508so97796266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 02:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1694683847; x=1695288647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AGNKandpT5NJQi5/AVhbxV6HoTTqbRKSZ06ZbK3/luU=;
        b=EuckalfXH1JT3XTkUzTWkewdpQFiWl9xm/X1oFwXOucRbqaQYrGTv5pRzINx2+JbVB
         GN/RhmMwwvCunOdM4h/yE/8V3FHdy/1e405EOc4Uy9+7IgnDHytdaEbkjOK6ixXStyyg
         grBK+M9EhO4xMbIgTqOJbnPleXeJou4ay6rYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694683847; x=1695288647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGNKandpT5NJQi5/AVhbxV6HoTTqbRKSZ06ZbK3/luU=;
        b=OLmP3py9XUZ5uSyX3q3b6FR84y+pTH2LA3AtxDj4u7HRsLIsMECcQtxJv5Kcyl7fKS
         6Bc8CMwWeSDt2wkUdWlbphXsZRybKZhlfHw6clsfXCIybYGNy2LNJdUtWwGWVXPx03XP
         YJsnHs5ovcY+5lNWmRmCs3pybC/fwPKaVP2UhdT8yUpqDyF2n6DQjOVzPJJlX5L5iGny
         xiovjcl4PYStYytmV8Mx4NAr2TECmlaXMgOXND9gQEISXJvMk+Sf13w566p1IBR56KIC
         T8hQjv5kaIwQXp+Xajqz/N+aisGKkoHaD4XlpyXl+kTZmoj7/T/S0kXJgHLpRJu1bt/Y
         N3dA==
X-Gm-Message-State: AOJu0Yw/z0U4RoQ7lG9fO6LiazgUpc+jFcKfqyD8MH04xq0c/R7ARHQz
        0NWVRtnKuPwqGeGbRgCmCY8rv4JdQDdxKiIOuxzqLg==
X-Google-Smtp-Source: AGHT+IErxIuUSOrHMpZqSuqUdIXCMgDX2eTt5MQnPA0+NeX4YIBWXdWis7beQb0iCZTFlc7Klj2DKQaUtyCunDyiRVo=
X-Received: by 2002:a17:907:1c8e:b0:9a1:edb0:2a7f with SMTP id
 nb14-20020a1709071c8e00b009a1edb02a7fmr5062869ejc.6.1694683846431; Thu, 14
 Sep 2023 02:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-2-mszeredi@redhat.com>
 <20230914-himmel-imposant-546bd73250a8@brauner>
In-Reply-To: <20230914-himmel-imposant-546bd73250a8@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Sep 2023 11:30:34 +0200
Message-ID: <CAJfpegv8ZVyyZN7ppSYMD4g8i7rAP1_5UBxzSo869_SKmFhgvw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] add unique mount ID
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 14 Sept 2023 at 11:04, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Sep 13, 2023 at 05:22:34PM +0200, Miklos Szeredi wrote:
> > If a mount is released then it's mnt_id can immediately be reused.  This is
> > bad news for user interfaces that want to uniquely identify a mount.
> >
> > Implementing a unique mount ID is trivial (use a 64bit counter).
> > Unfortunately userspace assumes 32bit size and would overflow after the
> > counter reaches 2^32.
> >
> > Introduce a new 64bit ID alongside the old one.  Allow new interfaces to
> > work on both the old and new IDs by starting the counter from 2^32.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/mount.h                | 3 ++-
> >  fs/namespace.c            | 4 ++++
> >  fs/stat.c                 | 9 +++++++--
> >  include/uapi/linux/stat.h | 1 +
> >  4 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/mount.h b/fs/mount.h
> > index 130c07c2f8d2..a14f762b3f29 100644
> > --- a/fs/mount.h
> > +++ b/fs/mount.h
> > @@ -72,7 +72,8 @@ struct mount {
> >       struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
> >       __u32 mnt_fsnotify_mask;
> >  #endif
> > -     int mnt_id;                     /* mount identifier */
> > +     int mnt_id;                     /* mount identifier, reused */
> > +     u64 mnt_id_unique;              /* mount ID unique until reboot */
> >       int mnt_group_id;               /* peer group identifier */
> >       int mnt_expiry_mark;            /* true if marked for expiry */
> >       struct hlist_head mnt_pins;
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index e157efc54023..de47c5f66e17 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -68,6 +68,9 @@ static u64 event;
> >  static DEFINE_IDA(mnt_id_ida);
> >  static DEFINE_IDA(mnt_group_ida);
> >
> > +/* Don't allow confusion with mount ID allocated wit IDA */
> > +static atomic64_t mnt_id_ctr = ATOMIC64_INIT(1ULL << 32);
>
> Hm, is your concern that userspace confuses these two values? If so, I
> think we shouldn't worry about this.

Yes, one concern is that humans confuse the old and the new ID.

I also think it makes sense to allow the new interfaces to look up the
mount based on either the old or the new ID.   But I could be wrong
there, since that might encourage bad code.  Maybe the new interface
should only use take the new ID, which means no mixed use of
/proc/$$/mountinfo and statmnt/listmnt.

>
> If a userspace program retrieves a mntid and then confuses itself about
> what mnt id they're talking about something's very wrong anyway. So I'd
> rather not see us waste 32 bits just for that.

This is wasting a quarter of a billionth of the ID space.  We are
surely not concerned about that.

Thanks,
Miklos
