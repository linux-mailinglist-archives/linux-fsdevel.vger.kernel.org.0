Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3646C8A309
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfHLQJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:09:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40866 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLQJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:09:48 -0400
Received: by mail-ot1-f65.google.com with SMTP id c34so20791384otb.7;
        Mon, 12 Aug 2019 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcEZapTx9gb37JnflSbAgedavIW6EzyB7mIFw5JH/4I=;
        b=RL/zKcoR3eseiuX8sGv2LyrWC/b4WTVuwxOEti92mbge9n/+BZjWUN09bSaUd5Yetp
         QfeDIuKE0L/Qtb12fk/DKfF7rFMTqZhe+gqgdZIXL5tFIIfaPVftPBGAK4lo5N9ScW9I
         /KOsv515ZKyKzjzzNqo5izPIdyhkSr1y3JwZEmR1MX7hoIlVb2mMNDdNeuKrHKZ685T0
         gTkl9Lqr+rfY9q22jOqYUdw0SaUiGmNXHfG5uZ+0Vq4bOC1kWmMwzPYNQjQKOqxkgmj6
         S5KwLEgtNPFjM0ToQJCl9J7jpNRIjq98QVy5B81zDLKQmdsYYxIxMHJkbFQtGT4LFmC0
         OSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcEZapTx9gb37JnflSbAgedavIW6EzyB7mIFw5JH/4I=;
        b=GMLWA4XwvjrbSesDssIVSjGoTMrqfYFovuWqhZvcykMx74ngZd3AN4dbxOSjlmLrgP
         svT+eycdT9VnlgyzJSWrpzVIZyeUL1/lzJru7CCr78SmwYIFoqi1iIYXJogYHMpKUKLe
         kF+DROi2EC8GK1ZmYuOUtucZ2PswnkxNrbB0I3c6icvL7jZnf+7yhdOv4eFFyALvWTYm
         Wm8UnvRyMFQ6KBVsboqdIimCgVp4b6bu/nMmqlWvI8DerCk7FnD3Q8LPr5nMzS/Yppf1
         H7z5YANm7bl7892R0oBBCF72HkXFMusdIONBjlKAMvnP/csHzMgBwz+U+mS7gliWObh4
         2Ebw==
X-Gm-Message-State: APjAAAXp24v2oglm9OWR6GdDm7hp3uVDIppiqbP7Ys8fKsP6gCmP3GLg
        CK+NZQlW+M5HUplxAh0TGk8Ro9hLH7pd49Z5ovdG7u8O
X-Google-Smtp-Source: APXvYqzqWtEXtUQlBMqRX1uDe/YrNtqz5xPnjIc7b2b3dlEkqoGwt44wKdLkzm254HXxruY2qKjts8H3vyqtwIAme+E=
X-Received: by 2002:a02:c012:: with SMTP id y18mr27966443jai.85.1565626187318;
 Mon, 12 Aug 2019 09:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-5-deepa.kernel@gmail.com>
 <c508fe0116b77ff0496ebb17a69f756c47be62b7.camel@codethink.co.uk>
 <CABeXuvruROn7j1DiCDbP6MLBt9SB4Pp3HoKqcQbUNPDJgGWLgw@mail.gmail.com>
 <53df9d81bfb4ee7ec64fabf1089f91d80dceb491.camel@codethink.co.uk> <CAK8P3a0CADLUeXvsBHNAC8ekLoo0o0uYz2arBqZ=1N+Xp8HNvA@mail.gmail.com>
In-Reply-To: <CAK8P3a0CADLUeXvsBHNAC8ekLoo0o0uYz2arBqZ=1N+Xp8HNvA@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Mon, 12 Aug 2019 09:09:35 -0700
Message-ID: <CABeXuvpAPp98G2gCczB3n=izv4aM7vacdbPONiELrw-1ZOrd=g@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 04/20] mount: Add mount warning for impending
 timestamp expiry
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 7:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Aug 12, 2019 at 3:25 PM Ben Hutchings
> <ben.hutchings@codethink.co.uk> wrote:
> > On Sat, 2019-08-10 at 13:44 -0700, Deepa Dinamani wrote:
> > > On Mon, Aug 5, 2019 at 7:14 AM Ben Hutchings
> > > <ben.hutchings@codethink.co.uk> wrote:
> > > > On Mon, 2019-07-29 at 18:49 -0700, Deepa Dinamani wrote:
> > > > > The warning reuses the uptime max of 30 years used by the
> > > > > setitimeofday().
> > > > >
> > > > > Note that the warning is only added for new filesystem mounts
> > > > > through the mount syscall. Automounts do not have the same warning.
> > > > [...]
> > > >
> > > > Another thing - perhaps this warning should be suppressed for read-only
> > > > mounts?
> > >
> > > Many filesystems support read only mounts only. We do fill in right
> > > granularities and limits for these filesystems as well. In keeping
> > > with the trend, I have added the warning accordingly. I don't think I
> > > have a preference either way. But, not warning for the red only mounts
> > > adds another if case. If you have a strong preference, I could add it
> > > in.
> >
> > It seems to me that the warning is needed if there is a possibility of
> > data loss (incorrect timestamps, potentially leading to incorrect
> > decisions about which files are newer).  This can happen only when a
> > filesystem is mounted read-write, or when a filesystem image is
> > created.
> >
> > I think that warning for read-only mounts would be an annoyance to
> > users retrieving files from old filesystems.
>
> I agree, the warning is not helpful for read-only mounts. An earlier
> plan was to completely disallow writable mounts that might risk an
> overflow (in some configurations at least). The warning replaces that
> now, and I think it should also just warn for the cases that would
> otherwise have been dangerous.

Ok, I will make the change to exclude new read only mounts. I will use
__mnt_is_readonly() so that it also exculdes filesystems that are
readonly also.
The diff looks like below:

-       if (!error && sb->s_time_max &&
+       if (!error && !__mnt_is_readonly(mnt) &&
            (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {

Note that we can get rid of checking for non zero sb->s_time_max now.

-Deepa
