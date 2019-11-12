Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A059AF95FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 17:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKLQtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 11:49:50 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41464 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLQtu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:49:50 -0500
Received: by mail-yb1-f195.google.com with SMTP id d95so7359865ybi.8;
        Tue, 12 Nov 2019 08:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VH0IV8aGbrpTn0hoyKLYQ3iTl4xm1QD6SGJDZ8VJTMc=;
        b=HjWDyP1y/u/zH21bTZLss9k/xLG/MDVISvep+jdTwKml7Yh6Gp/0qDdZhwDAjv/i76
         9C+T5nlMKP2xQwcod1Ge/MB6auRbxvofix2DZ3fIc1eC8ZjMh2HInBAjGg/DsKETaAif
         g2Nhnql3QatPdYNfQaBKJ4Bedv6S8xS5sF8arFY2JzaS66Bd69yRSrzWkEhks96EQmM9
         1bNmbWQFbwfck5pQDGvC7u0Y8tb3sNoKPqyVbpdKQwxZjypiI7BwlYKB3MDZewBAzj2N
         q7S8JI258KZjNmK8/9/8TM/g7ULcPVvsoBiDdxSSYr+huMvERqUe9atg6Fjm2Wk2fi+B
         0g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VH0IV8aGbrpTn0hoyKLYQ3iTl4xm1QD6SGJDZ8VJTMc=;
        b=ic+qgzPWToQeRq7MjV6By0B6FO02NpfDyS/zxJORkLX2vGjrRgAxgG7kVB0pOTLIhy
         HS/Mma9jovJn4FgU+6gUC7X1yrOJ44ZbfdAl/e3irPQ1e6bNtbcaQ+ncaPK81j44+Q6t
         1hCJMq4OXxNHZLYjkr9oq49Idk/KriuPovChf8PdCYqJnPLWm0PqK6M3bi5Yhl6NHP6N
         uprrLVJkRiC4TkgSLu5aqtcRYzRMQrNAAjP9lp3mxt9n7F5HJsfAVVWbUn0i6QBID8F5
         eSXaNS0cqFxbIER4xKtBfmZ6mPZ+HjTk7urlMJL/HvAOV5nanGCrSrVu98GoCeWozsWc
         Ur1w==
X-Gm-Message-State: APjAAAUJon3zYhaya3YJyJ/EbsLOJstfuyAs96i5MtyUhnSf89droyMR
        RRA6WtbqLWZMH9v0r5T5ZHH0mpEiNdT210vfVf8=
X-Google-Smtp-Source: APXvYqyUylc/hgBQKJfoPaaTULDCLMKAoJPIizuIbhPGK+569S2aUOWdszOHroCTfUvlmmtO9JBLRAJR41h6chJPsjU=
X-Received: by 2002:a25:c50c:: with SMTP id v12mr22582916ybe.428.1573577389566;
 Tue, 12 Nov 2019 08:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20191111073000.2957-1-amir73il@gmail.com> <CAJfpegvASSszZoYOdX9dcffo0EUNGVe_b8RU3JTtn-tXr9O7eg@mail.gmail.com>
 <CAOQ4uxhMqYWYnXfXrzU7Qtv8xpR6k_tR9CFSo01NLZSvqBOxsw@mail.gmail.com> <CABeXuvreoQkM1A3JBONtfD7uVLvC5MQ0hDRKX5rEQ_VUFGER8w@mail.gmail.com>
In-Reply-To: <CABeXuvreoQkM1A3JBONtfD7uVLvC5MQ0hDRKX5rEQ_VUFGER8w@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 Nov 2019 18:49:38 +0200
Message-ID: <CAOQ4uxhH48Lso7ZLOngd904=YKFv8zbM=8oPfqYRPjD9fCzh7g@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix timestamp limits
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 6:45 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Tue, Nov 12, 2019 at 8:06 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Nov 12, 2019 at 5:48 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Mon, Nov 11, 2019 at 8:30 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > Overlayfs timestamp overflow limits should be inherrited from upper
> > > > filesystem.
> > > >
> > > > The current behavior, when overlayfs is over an underlying filesystem
> > > > that does not support post 2038 timestamps (e.g. xfs), is that overlayfs
> > > > overflows post 2038 timestamps instead of clamping them.
> > >
> > > How?  Isn't the clamping supposed to happen in the underlying filesystem anyway?
> > >
> >
> > Not sure if it is supposed to be it doesn't.
> > It happens in do_utimes() -> utimes_common()
>
> Clamping also happens as part of current_time(). If this is called on
> an inode belonging to the upper fs, then the timestamps are clamped to
> those limits.
>

OK, but from utimes syscall they do not get clamped inside filesystem
only in syscall itself. Right?

Thanks,
Amir.
