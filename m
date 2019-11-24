Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A42E108514
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2019 22:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfKXVOS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 16:14:18 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41505 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfKXVOR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 16:14:17 -0500
Received: by mail-io1-f66.google.com with SMTP id z26so10410952iot.8;
        Sun, 24 Nov 2019 13:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0e1h0bmFBv4pGulW4oyFQcIH6yM8oTNM6xO610ks6Qo=;
        b=Y1D4bSLhHXiVhG1ezWmTDEQ0K4pBJIJ+JLL8YxU5szSurT4IInpJ2wfogUBy8sJbV4
         kb9VJY3DaeeUTxtRg8KyS80kkacxGky2v3v5FIMB7a7ieZnkQNwk2YEJJ+aErpJfX94z
         AISZgnbLzVzeSBM8gIeRt/4pDdQ4+1pONDYJmV/nztTPrsKK8UjSfn+Ca95nvffNPkxs
         Wx7oOSWeBtmyP1U83gDaYJcO7ymnhhjIekrZNReoiXXfnSkUGzOgK3sv5Ihc6E/9s7J8
         JSnColw98tP0Y2QspRZEMrkugeLy6KyN9rcQncW35noFGEL0ncGHeTsG8K8+mt7otIgt
         D3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0e1h0bmFBv4pGulW4oyFQcIH6yM8oTNM6xO610ks6Qo=;
        b=AblDzoEYCYuhHx3mgj6QcK9VHqkCcVCO0BBnDTtiqeEqrFv/bktrBWdHVscqSMcRpl
         e8OY64hzgionk1e5xQAMBWgM9A1KDfB4Y9RlOd4ID1LYwFzmPren+3og0JMjzp8mUX48
         iy5NP/P14ZVbY/wIVSEbSyk+3fmnsFhy8c174f2nwmZEgOCbwbkNrAI6Mixtww3XkCZY
         Q9bUzBbCOFhxo845nBCObenQoUv8hTfg1URHGbqk9KX5UAdl33t0gn5j7zr9QT1p99Cx
         nlhORwIwZP19/4EHhDshimg+x+LXnL/5QM3tStaaHYf8MjeKaVensb0LV+wkRrtTsaw4
         zEIQ==
X-Gm-Message-State: APjAAAWCL7IAlB/+UZBpbikJZ5NyDEnjdjTPNfEFwNpheRQzk2XV8/XO
        sDGFUyo3PFqjywzBuql2ws/P/hbUNY8iwiYOby0=
X-Google-Smtp-Source: APXvYqwzbZxJYV6JfYOYDA2sbuggdt1UO6BCHSrUH+SS4dLjTaiD0BVRe1zth55ZTUk9u2jUG+VJS7rxU7h36QyhKZo=
X-Received: by 2002:a5e:8d0b:: with SMTP id m11mr24630045ioj.81.1574630056408;
 Sun, 24 Nov 2019 13:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20191124193145.22945-1-amir73il@gmail.com> <20191124194934.GB4203@ZenIV.linux.org.uk>
 <CAOQ4uxjsOM+th1f4=wss4SCrwueUYuVT0FKX0GxtmHBG2juw+A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjsOM+th1f4=wss4SCrwueUYuVT0FKX0GxtmHBG2juw+A@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun, 24 Nov 2019 13:14:04 -0800
Message-ID: <CABeXuvr3Xm+++hpo38jJLY_ZpELURV5p=egyAN9X6RtoDsm2JQ@mail.gmail.com>
Subject: Re: [PATCH] utimes: Clamp the timestamps in notify_change()
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 24, 2019 at 12:50 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sun, Nov 24, 2019 at 9:49 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sun, Nov 24, 2019 at 09:31:45PM +0200, Amir Goldstein wrote:
> > > Push clamping timestamps down the call stack into notify_change(), so
> > > in-kernel callers like nfsd and overlayfs will get similar timestamp
> > > set behavior as utimes.
> >
> > Makes sense; said that, shouldn't we go through ->setattr() instances and
> > get rid of that there, now that notify_change() is made to do it?
> >
>
> Sounds reasonable. But I'd rather leave this cleanup to Deepa,
> who did all this work.

Thanks, I can post a patch for this.

-Deepa
