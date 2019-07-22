Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4126F961
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 08:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGVGQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 02:16:35 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34318 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfGVGQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 02:16:34 -0400
Received: by mail-yb1-f195.google.com with SMTP id q5so2447553ybp.1;
        Sun, 21 Jul 2019 23:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRiPNuu0IvHAFpeZVhrWYDUDjsfyID6dmrOBGytJQzY=;
        b=GiMkqHsb2C/Jw1o6Ub4DsiHZBxr6ZPjhjLrbLjNZ2yaaHCKmZJ1LRjvX1tmJbGD7Bi
         pKwqIfw1wbCFqysuExvOaGUzgDUJbvojSqnH4QGcuiaNSlyjpp5RKWyyR1HE1O2WkqZi
         yuolp/P4xNqjATF+LaZi/qhcLf+/MwAI5U2b185js89KVnQ6DBKBKZJAYx134EMcx6zs
         u2SEuK+hLnumxva+59nzjcpPKHmG1e17rGKrQ3hWlJllBtBmp/5XAu3LQAJRwL9QkU9F
         h1YP5naXIsNxpmacnONf4p6UavV3n5TqvxfKBQCc5d9fMO2tL1tdauivTwdVkM8E6QnX
         6NLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRiPNuu0IvHAFpeZVhrWYDUDjsfyID6dmrOBGytJQzY=;
        b=UvJ2h3vq1QZnXVPBWjQX83sg4jGAt3ddU9iy6KdUWzTz6HxfBIVtm18xGZ9qxGa6AM
         K6nLGyPZb9kOHkMOIu3qpjmDPOd3iMbh5K5Keu6g7yk+3z2c4UmthTGsvHh3Ry8yraX4
         e9DG5GpkG1a8Owa5CKFFO/htrvdV+Ls0pGNXP01iqn2r71pFlRa7piMpKw7xMCgJPGKZ
         OBGf//NjgPVQoQkuJBqOF4sZy7ia5WHtpXm62k9f6SY8Pk4OTCEtFFWKHRvU9Qfr1os6
         YbQAdjkf/HqNTVLNxjUBF2kW76HNac9I3scryjrLxlYZPEYWCMPBnB0iuXesJjR6NVxn
         lS5w==
X-Gm-Message-State: APjAAAWooo6IRUfshshHKmx3HhF0tTawlft1JfI3e5jYAqxihzju/pTL
        0nygIkLO8Ou8BG/BxTOj3wTJ+XPEQ38U/n1ZTeA=
X-Google-Smtp-Source: APXvYqzeP8dnmI9HUYEy65Jb64wblg41vjP3fcITilmmeXiO/XAUwrolXbZVlMRx1aCCChHAkomgV0wUhL20rNsxpvE=
X-Received: by 2002:a25:9a08:: with SMTP id x8mr40685653ybn.439.1563776193646;
 Sun, 21 Jul 2019 23:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-13-gaoxiang25@huawei.com> <CAOQ4uxh04gwbM4yFaVpWHVwmJ4BJo4bZaU8A4_NQh2bO_xCHJg@mail.gmail.com>
 <39fad3ab-c295-5f6f-0a18-324acab2f69e@huawei.com>
In-Reply-To: <39fad3ab-c295-5f6f-0a18-324acab2f69e@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 22 Jul 2019 09:16:22 +0300
Message-ID: <CAOQ4uxgo5kvgoEn7SbuwF9+B1W9Qg1-2jSUm5+iKZdT6-wDEog@mail.gmail.com>
Subject: Re: [PATCH v3 12/24] erofs: introduce tagged pointer
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 22, 2019 at 8:02 AM Gao Xiang <gaoxiang25@huawei.com> wrote:
>
> Hi Amir,
>
> On 2019/7/22 12:39, Amir Goldstein wrote:
> > On Mon, Jul 22, 2019 at 5:54 AM Gao Xiang <gaoxiang25@huawei.com> wrote:
> >>
> >> Currently kernel has scattered tagged pointer usages
> >> hacked by hand in plain code, without a unique and
> >> portable functionset to highlight the tagged pointer
> >> itself and wrap these hacked code in order to clean up
> >> all over meaningless magic masks.
> >>
> >> This patch introduces simple generic methods to fold
> >> tags into a pointer integer. Currently it supports
> >> the last n bits of the pointer for tags, which can be
> >> selected by users.
> >>
> >> In addition, it will also be used for the upcoming EROFS
> >> filesystem, which heavily uses tagged pointer pproach
> >>  to reduce extra memory allocation.
> >>
> >> Link: https://en.wikipedia.org/wiki/Tagged_pointer
> >
> > Well, it won't do much good for other kernel users in fs/erofs/ ;-)
>
> Thanks for your reply and interest in this patch.... :)
>
> Sigh... since I'm not sure kernel folks could have some interests in that stuffs.
>
> Actually at the time once I coded EROFS I found tagged pointer had 2 main advantages:
> 1) it saves an extra field;
> 2) it can keep the whole stuff atomicly...
> And I observed the current kernel uses tagged pointer all around but w/o a proper wrapper...
> and EROFS heavily uses tagged pointer... So I made a simple tagged pointer wrapper
> to avoid meaningless magic masks and type casts in the code...
>
> >
> > I think now would be a right time to promote this facility to
> > include/linux as you initially proposed.
> > I don't recall you got any objections. No ACKs either, but I think
> > that was the good kind of silence (?)
>
> Yes, no NAK no ACK...(it seems the ordinary state for all EROFS stuffs... :'( sigh...)
> Therefore I decided to leave it in fs/erofs/ in this series...
>
> >
> > You might want to post the __fdget conversion patch [1] as a
> > bonus patch on top of your series.
>
> I am not sure if another potential users could be quite happy with my ("sane?" or not)
> implementation...

Well, let's ask potential users then.

CC kernel/trace maintainers for RB_PAGE_HEAD/RB_PAGE_UPDATE
and kernel/locking maintainers for RT_MUTEX_HAS_WAITERS

> (Is there some use scenerios in overlayfs and fanotify?...)

We had one in overlayfs once. It is gone now.

>
> and I'm not sure Al could accept __fdget conversion (I just wanted to give a example then...)
>
> Therefore, I tend to keep silence and just promote EROFS... some better ideas?...
>

Writing example conversion patches to demonstrate cleaner code
and perhaps reduce LOC seems the best way.

Also pointing out that fixing potential bugs in one implementation is preferred
to having to patch all copied implementations.

I wonder if tagptr_unfold_tags() doesn't need READ_ONCE() as per:
1be5d4fa0af3 locking/rtmutex: Use READ_ONCE() in rt_mutex_owner()

rb_list_head() doesn't have READ_ONCE()
Nor does hlist_bl_first() and BPF_MAP_PTR().

Are those all safe due to safe call sites? or potentially broken?

Thanks,
Amir.
