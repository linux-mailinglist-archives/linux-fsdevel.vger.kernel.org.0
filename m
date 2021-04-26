Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C09036B7E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhDZRRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 13:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhDZRRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:17:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659C1C061574;
        Mon, 26 Apr 2021 10:16:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n21so9382112eji.1;
        Mon, 26 Apr 2021 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MEQOXDj6Vgsm7PgstPVKkjDi+uEdC9l5WYAKRjEbAYE=;
        b=oTH1HkdzYYUPW8cHWfQ0imYh3cFVPYoyw8lxejZccnbarXtTcrhRnYCj8t5f2VxSK9
         rsIHRhiH8akhspWHUSFDJJDzTOd7SRE4Yd3fWh55n71rahc6ADYdIIoFUWi2J2IwIvYa
         Kg7p+Sh3cCemAYxFlfwxHzi+5yuB4C+pWp6nUIPe7i4wMASAuLngq+m3Xyo1aBe1ndnk
         uZ9xvsPoPKVgMH1zGDptrfmqEp4M9bByGw36setvTaqSrz5dbmb13lW4F0Rgo0KI64XA
         nep71waWSCrLtP1WCmznO2df/AR5gB/0mrMwVQJHVoC7D4A5Ukw98WVza+AVHfFPxPgK
         xQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MEQOXDj6Vgsm7PgstPVKkjDi+uEdC9l5WYAKRjEbAYE=;
        b=ajDz1lOUh20N5ESzAjeSp+KoZuBahR67+39R4UYDDzdVgDXUJiLRA6gfPxDJTwjs8i
         W4wcVQeKURgkjoYio18rl1/5In1ZDxV4MnKKYABEYBRgBca5+hGz63ZIQR9LJ+/jgUM8
         hU6LRPKRU3JVsEXC+oERVok1yPagzL6N1HJ7/jTt8CTs1hmo7QY5WGjzEWrHD3E2uPsf
         SDSAZOWR6Ex6XiJmz238g2XWJmgqKfu8dWMp/GGG7Ftkq9L/hNr4hDeR91YGHJ4rt01e
         dYNt3PMyTnotW+tR5bw4O8E6rVrkjYqtqJ4DtZd0NVAyY1KR3aLZYnkdElTk59OHwpMC
         QpmQ==
X-Gm-Message-State: AOAM533XdE2lGugOo6CL1tJ/WMYedRYH8XaG21aVuhHty/JOlPLzL/o5
        TbNY1+m2aAgnGoCdhJnJ/BIOjXlp9jr7W2iuWKI=
X-Google-Smtp-Source: ABdhPJxIdN1PxBwdg2dwtvV5W+8kY/OJgamP7VcdpgA/qUwq+QFGwRzoIgAQfNyzdDXIuTk8mZddXRfmyC77AmmEIBg=
X-Received: by 2002:a17:906:1c8f:: with SMTP id g15mr19311864ejh.20.1619457416007;
 Mon, 26 Apr 2021 10:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAFt=RON+KYYf5yt9vM3TdOSn4zco+3XtFyi3VDRr1vbQUBPZ0g@mail.gmail.com>
 <YIWd7v1U/dGivmSE@zeniv-ca.linux.org.uk> <CAFt=RONcpvvk5=8GLTvG44=6wKwiYPH7oG4YULfcP+J=x8OW-w@mail.gmail.com>
 <YIWlOlss7usVnvme@zeniv-ca.linux.org.uk>
In-Reply-To: <YIWlOlss7usVnvme@zeniv-ca.linux.org.uk>
From:   haosdent <haosdent@gmail.com>
Date:   Tue, 27 Apr 2021 01:16:44 +0800
Message-ID: <CAFt=ROOi+bi_N4NEkDQxagNwnoqM0zYR+sxiag7r2poNVW9u+w@mail.gmail.com>
Subject: Re: NULL pointer dereference when access /proc/net
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengyu.duan@shopee.com, Haosong Huang <huangh@sea.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> really should not assume ->d_inode stable

Hi, Alexander, sorry to disturb you again. Today I try to check what
`dentry->d_inode` and `nd->link_inode` looks like when `dentry` is
already been killed in `__dentry_kill`.

```
nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
```

It looks like `dentry->d_inode` could be NULL while `nd->link_inode`
is always has value.
But this make me confuse, by right `nd->link_inode` is get from
`dentry->d_inode`, right?

For example, in `walk_component`, suppose we go into `lookup_slow`,

```
static int walk_component(struct nameidata *nd, int flags)
   if (unlikely(err <= 0)) {
    ...
    path.dentry = lookup_slow(&nd->last, nd->path.dentry, nd->flags);
    ...
    inode = d_backing_inode(path.dentry);     <=== get `inode` from
`dentry->d_inode`.
  }
  return step_into(nd, &path, flags, inode, seq);  <=== set `inode` to
`nd->link_inode`.
}

```

then in `step_into` -> `pick_link`

```
static int pick_link(struct nameidata *nd, struct path *link,
     struct inode *inode, unsigned seq)
{
  ...
  nd->link_inode = inode;  <=== set `inode` to `nd->link_inode`.
}
```

So for the mismatch of `nd->link_inode` and `dentry->d_inode` in
following output. Do it means in Thread 1,  `walk_component`
get a `dentry` from `d_lookup`, at the same time, in Thread 2,
`__dentry_kill` is run and set `dentry->d_inode` to NULL.

```
nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
nd->last.name: net/sockstat, dentry->d_lockref.count: -128,
dentry->d_inode: (nil), nd->link_inode: 0xffffffffab299966
```

If these concurrent operations in `dentry->d_inode` could happen, how
we ensure `nd->link_inode = inode` and `d_backing_inode` are always
run before
`__dentry_kill`? I still could not find the questions for this from
dcache's code, sorry for the stupid question.

On Mon, Apr 26, 2021 at 1:22 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Apr 26, 2021 at 01:04:46AM +0800, haosdent wrote:
> > Hi, Alexander, thanks a lot for your quick reply.
> >
> > > Not really - the crucial part is ->d_count == -128, i.e. it's already past
> > > __dentry_kill().
> >
> > Thanks a lot for your information, we would check this.
> >
> > > Which tree is that?
> > > If you have some patches applied on top of that...
> >
> > We use Ubuntu Linux Kernel "4.15.0-42.45~16.04.1" from launchpad directly
> > without any modification,  the mapping Linux Kernel should be
> > "4.15.18" according
> > to https://people.canonical.com/~kernel/info/kernel-version-map.html
>
> Umm...  OK, I don't have it Ubuntu source at hand, but the thing to look into
> would be
>         * nd->flags contains LOOKUP_RCU
>         * in the mainline from that period (i.e. back when __atime_needs_update()
> used to exist) we had atime_needs_update_rcu() called in get_link() under those
> conditions, with
> static inline bool atime_needs_update_rcu(const struct path *path,
>                                           struct inode *inode)
> {
>         return __atime_needs_update(path, inode, true);
> }
> and __atime_needs_update() passing its last argument (rcu:true in this case) to
> relatime_need_update() in
>         if (!relatime_need_update(path, inode, now, rcu))
> relatime_need_update() hitting
>         update_ovl_inode_times(path->dentry, inode, rcu);
> and update_ovl_inode_times() starting with
>         if (rcu || likely(!(dentry->d_flags & DCACHE_OP_REAL)))
>                 return;
> with subsequent accesses to ->d_inode.  Those obviously are *NOT* supposed
> to be reached in rcu mode, due to that check.
>
> Your oops looks like something similar to that call chain had been involved and
> somehow had managed to get through to those ->d_inode uses.
>
> Again, in RCU mode we really, really should not assume ->d_inode stable.  That's
> why atime_needs_update() gets inode as a separate argument and does *NOT* look
> at path->dentry at all.  In the kernels of 4.8..4.18 period there it used to do
> so, but only in non-RCU mode (which is the reason for explicit rcu argument passed
> through that callchain).



-- 
Best Regards,
Haosdent Huang
