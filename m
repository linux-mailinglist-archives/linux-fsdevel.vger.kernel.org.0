Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7466612ABAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 11:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLZKnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 05:43:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34887 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZKnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 05:43:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id k16so27567916otb.2;
        Thu, 26 Dec 2019 02:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CciSmY8mQmtaNJQQRD2CEzQF42UO9vxilmnwdC9yw6Y=;
        b=b74CcF25mImP66sBDSQR+v9dMkqvuhKKJpNN4CBLxTxEi4jAl17wNprjU840rniIxa
         kDi6a4QucEu2oCW8/fVIn7baEIW4m8UJvpYnqBsZmrx0+cFkEdcZG1/EnBGqpLIwVvtz
         8jUZ4bAOYnCA3uG27e6wnq6e5SQk24uZes3fUVPphRsd0+5Livy6AjWPjgvEotLlvS/9
         HRDGBBYVxrCPexHF/X33fMb1DP9w/II0CkZnfo12E8c4Lha1DGsU2hfaVQTFHXqM742U
         gylk4dQvh1j88xT+WJXd876F5OblFcr9oiqX4eQorWsJrA5jbr9N3Rsym0P8KAblFkph
         8aiw==
X-Gm-Message-State: APjAAAXVwVf7kZu2yE2NjusTGu2JwNaDY5PAEx/Y+i1RW0YgH1QvAGEe
        Ga55Z3GrEEPsjf340T/5eIyoTdHMpTFvXJvzLzk=
X-Google-Smtp-Source: APXvYqytesbdCSLGLFU6q/okcfGBQxgxfB9uJmiMZLPv6rJ8MjCWELPe7w54OoSpqXkcWdWMs6j1xnfDq8bZFtD2v0M=
X-Received: by 2002:a9d:8f1:: with SMTP id 104mr45680549otf.107.1577357029668;
 Thu, 26 Dec 2019 02:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20191223040020.109570-1-yuchao0@huawei.com> <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
 <1cc2d2a093ebb15a1fc6eb96d683e918a8d5a7d4.camel@dubeyko.com>
In-Reply-To: <1cc2d2a093ebb15a1fc6eb96d683e918a8d5a7d4.camel@dubeyko.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Dec 2019 11:43:38 +0100
Message-ID: <CAMuHMdV5VtR+vgYKcZtvcz16GPp9YLG_ecAeDsiNCreP4rYKjw@mail.gmail.com>
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

On Wed, Dec 25, 2019 at 10:58 AM Vyacheslav Dubeyko <slava@dubeyko.com> wrote:
> On Mon, 2019-12-23 at 09:41 +0100, Geert Uytterhoeven wrote:
> > On Mon, Dec 23, 2019 at 5:01 AM Chao Yu <yuchao0@huawei.com> wrote:
> > > As Geert Uytterhoeven reported:
> > >
> > > for parameter HZ/50 in congestion_wait(BLK_RW_ASYNC, HZ/50);
> > >
> > > On some platforms, HZ can be less than 50, then unexpected 0
> > > timeout
> > > jiffies will be set in congestion_wait().
>
> It looks like that HZ could have various value on diferent platforms.
> So, why does it need to divide HZ on 50? Does it really necessary?
> Could it be used HZ only without the division operation?

A timeout of HZ means 1 second.
HZ/50 means 20 ms, but has the risk of being zero, if HZ < 50.

If you want to use a timeout of 20 ms, you best use msecs_to_jiffies(20),
as that takes care of the special cases, and never returns 0.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
