Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5AC12AC58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 14:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfLZNQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 08:16:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41600 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLZNQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 08:16:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so32509003otc.8;
        Thu, 26 Dec 2019 05:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXEQfNaH8VgTuSjnmguZGyC11qEHXS5tzAGI8RrbPY8=;
        b=GF4b3ctqjMVQ3Jb+e46vQOkSONVLZM3KfdYhX1urh4bwGFznUnLyqDfv/lU4OUuZXv
         z/YUjzsd6ag4gY/reT8TJEd11yEJLqFLMQ3CAB447vVWlcIk4g4SZ0JuHWcxsBU7d0Hf
         kXKC5BPxvuCrJFIHlOFs5j/UJ4/CWLaJ+0mqIIHoZmABDimhlvS2NXLB1pUGQ21MFwtT
         odAKwTFtE3s6E5cR2og1ncJHV3aVuPgAsGV10eSL6Pmzw/NmCl6prTibmP06QwwGPV6C
         wo3RDRIOxZ8lbE6ppWHVhgWeB55g+mkejbZxtuxXRc5+qOp5UmT4a4ckB2IbaYqghoUm
         KVhg==
X-Gm-Message-State: APjAAAUXbrfw1/GHX/YeJISltDc3BdCWwSuPxYMJ1wICqozjgX2cmffE
        mm/1dIe2u2OWzwfuiMmdDcMHYiNHShUL4MrW9T8=
X-Google-Smtp-Source: APXvYqzjoOLS5EFKuY6BxQdWOZeUmiXoP4FsqbIxt6z03pBr9RBXWa7jFuBPKeZecz30modR1jUa5VsfvEbdjxPsOaY=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr51311676otm.297.1577366195614;
 Thu, 26 Dec 2019 05:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20191223040020.109570-1-yuchao0@huawei.com> <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
 <1cc2d2a093ebb15a1fc6eb96d683e918a8d5a7d4.camel@dubeyko.com>
 <CAMuHMdV5VtR+vgYKcZtvcz16GPp9YLG_ecAeDsiNCreP4rYKjw@mail.gmail.com> <61e43dcb781c9e880fac95b525830fd384de122a.camel@dubeyko.com>
In-Reply-To: <61e43dcb781c9e880fac95b525830fd384de122a.camel@dubeyko.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Dec 2019 14:16:24 +0100
Message-ID: <CAMuHMdU+_RCp6JWsFm7kw4ce2vBimr=4_oEug=R0Jyr9f0L9Tg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: introduce DEFAULT_IO_TIMEOUT_JIFFIES
To:     Vyacheslav Dubeyko <slava@dubeyko.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Vyacheslav,

On Thu, Dec 26, 2019 at 2:08 PM Vyacheslav Dubeyko <slava@dubeyko.com> wrote:
> On Thu, 2019-12-26 at 11:43 +0100, Geert Uytterhoeven wrote:
> > On Wed, Dec 25, 2019 at 10:58 AM Vyacheslav Dubeyko <
> > slava@dubeyko.com> wrote:
> > > On Mon, 2019-12-23 at 09:41 +0100, Geert Uytterhoeven wrote:
> > > > On Mon, Dec 23, 2019 at 5:01 AM Chao Yu <yuchao0@huawei.com>
> > > > wrote:
> > > > > As Geert Uytterhoeven reported:
> > > > >
> > > > > for parameter HZ/50 in congestion_wait(BLK_RW_ASYNC, HZ/50);
> > > > >
> > > > > On some platforms, HZ can be less than 50, then unexpected 0
> > > > > timeout
> > > > > jiffies will be set in congestion_wait().
> > >
> > > It looks like that HZ could have various value on diferent
> > > platforms.
> > > So, why does it need to divide HZ on 50? Does it really necessary?
> > > Could it be used HZ only without the division operation?
> >
> > A timeout of HZ means 1 second.
> > HZ/50 means 20 ms, but has the risk of being zero, if HZ < 50.
> >
> > If you want to use a timeout of 20 ms, you best use
> > msecs_to_jiffies(20),
> > as that takes care of the special cases, and never returns 0.
> >
>
> The msecs_to_jiffies(20) looks much better for my taste. Maybe, we
> could use this as solution of the issue?

Thanks, sounds good to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
