Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0792569D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 21:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgH2TNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 15:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2TNk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 15:13:40 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05906C061236
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 12:13:39 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g11so812045ual.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTD0JSzaISIs2GS9auiXCcabYGD0Ro6Ps7s8yDZE/kI=;
        b=ZDk/DUsLGyJbV5BAIC6K2SlG1pb36lppuE7hQ1gXMrUH2CZFKJqEX5apLXam66P37F
         HHUAKBiwG68EDQ8UnjpjfREo+p5vUnjDzHrJre2tb9wmF8d+mRJ0drNuGIClGgOzcQyX
         6ncU6H/l1eFYthV45BCORJlzbV1naxbFS8lj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTD0JSzaISIs2GS9auiXCcabYGD0Ro6Ps7s8yDZE/kI=;
        b=uH5iGr8/EQ9bLBXwhsst7WSaiLLLl2DIuyRxvrZ/g8JYtPA4iHQ7qWyyzZup49Idut
         4wksuJfmvO2P+SeVJx6xmiwwnM5MnDTJAP3ULNGOgmbxfu78BrjRq/DyT11c5z9tNuOf
         jeyJib4K+SEY0p6sjjjA7NVuGO9k1ZHGo7oaXmcCFcCjm7XNpKdxAQU9KJ1bVbGkTpCv
         hQ2ON97yiA2SgrKMHYDSkHv/VU8yoGYfXjSdyjvLtjtjgN0x0Q6Fe2ggNnLlDv4e73xh
         Ez/GYiBrFmrMEWCtNjY08JloiLAH+91NV2VLVSlBMtSB5BrI++k2N9Im8yu2kNyhm4CK
         acJA==
X-Gm-Message-State: AOAM530yrGR5RSVq/c0KQmKuNKm3llVk+XLrQl7r8KM3H7E56O2hkaR/
        aQKRuMXPdL/uDnh+gYif0DGDptDnZfooLz+hZWCmsQ==
X-Google-Smtp-Source: ABdhPJzpzE5S+E9Bxv2KAWsrdevEoq8RZJQzJ4/Lyh82pvUHPtkJyJReOvFl0Ucj+IdwkSmdVF6nHn204S9xbbYjuxo=
X-Received: by 2002:ab0:32d:: with SMTP id 42mr1160976uat.107.1598728415705;
 Sat, 29 Aug 2020 12:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200812143323.GF2810@work-vm> <27541158.PQPtYaGs59@silver>
 <20200816225620.GA28218@dread.disaster.area> <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area> <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area> <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk> <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
 <20200829180448.GQ1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200829180448.GQ1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sat, 29 Aug 2020 21:13:24 +0200
Message-ID: <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
Subject: Re: xattr names for unprivileged stacking?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 8:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Aug 29, 2020 at 07:51:47PM +0200, Miklos Szeredi wrote:
> > On Sat, Aug 29, 2020 at 6:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Sat, Aug 29, 2020 at 05:07:17PM +0100, Matthew Wilcox wrote:
> > >
> >
> > > > > The fact that ADS inodes would not be in the dentry cache and hence
> > > > > not visible to pathwalks at all then means that all of the issues
> > > > > such as mounting over them, chroot, etc don't exist in the first
> > > > > place...
> > > >
> > > > Wait, you've now switched from "this is dentry cache infrastructure"
> > > > to "it should not be in the dentry cache".  So I don't understand what
> > > > you're arguing for.
> > >
> > > Bloody wonderful, that.  So now we have struct file instances with no dentry
> > > associated with them?  Which would have to be taken into account all over
> > > the place...
> >
> > It could have a temporary dentry allocated for the lifetime of the
> > file and dropped on last dput.  I.e. there's a dentry, but no cache.
> > Yeah, yeah, d_path() issues, however that one will have to be special
> > cased anyway.
>
> d_path() is the least of the problems, actually.  Directory tree structure on
> those, OTOH, is a serious problem.  If you want to have getdents(2) on that
> shite, you want an opened descriptor that looks like a directory.  And _that_
> opens a large can of worms.  Because now you have fchdir(2) to cope with,
> lookups going through /proc/self/fd/<n>/..., etc., etc.

Seriously, nobody wants fchdir().  And getdents() does not imply fchdir().

As for whether we'd need foobarat() on such a beast or let
/proc/self/fd/<n> be dereferenced, I think no.  So comes the argument:
 but then we'll break all those libraries and whatnot relying on these
constructs.  Well, sorry, so would we if we didn't introduce this in
the first place.  That's not really breaking anything, it's just
setting expectations.

Thanks,
Miklos
