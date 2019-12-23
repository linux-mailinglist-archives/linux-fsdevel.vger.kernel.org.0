Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5471290FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 03:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfLWC6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Dec 2019 21:58:52 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39343 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLWC6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Dec 2019 21:58:52 -0500
Received: by mail-il1-f195.google.com with SMTP id x5so12876538ila.6;
        Sun, 22 Dec 2019 18:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+w2ujwtTsOWkI83RVcuh0HKQ9EYZPFgp7YsGnbR0nE=;
        b=DVRITJOWEbjo+6Psp9ojpolUzxBFRp7mcULKnfEDx6VRnOAP062q+94u6df7T+YzO4
         9n7BJNFxaQVGdJEoNF82WEmU3NfC3Y2xNJihkraXVQOLIyZbeYcIlsUGTDgt0TMB8RXj
         MxKHkmoE3PKFxXojaTgu6mN4uCcLgSuKnHtcbHbiVr4Y/RMe1HL4O2hF+ohJ7/DVp8Zq
         VSfoAk1WzHhn22/J5NufjAwufOaj7xvRRmZYJ4jDhnlxuJaA5scIqJymmhE70ZOLZQ8q
         KhWtVP4A6Ph6MB9lvhptr5/ilKLeg0wzowMA6fNd0/HXqNEbrzF1Ls8pm9jUTDQmrYEh
         FN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+w2ujwtTsOWkI83RVcuh0HKQ9EYZPFgp7YsGnbR0nE=;
        b=dRsIVeutLdlpdGnE8sQMY+J+h2AvPpz8h4jJM9d9y0c6rUcuaJ4+hWesHE3ujCeuJX
         78W/2eJ2u1TyzcBXZjS52RYaCldN039QsKYY2of44FxeXwTebOCIRsmZric0U48dGCxA
         fg2pHBOZZi7PfMgPpZcyb3EuAO1VMixGdnAoMgRjXueznR7DvDYQ00yc8KePBmpp8pz8
         IaAoeQFbt3bo8hMjRtpI2jPh+OmrQ0Dv8JlgVrZT1N09nVxJuHlwYoeCV/LgvNetkc68
         /pGlM4I0cjgTwL7CJI7LzI0qiG39d+0RgB1ynKZSyVj6KBRHVOATLhHgv6lDObppq/N7
         b+cg==
X-Gm-Message-State: APjAAAWg+LMQD2OQu9Ca9lm5NFlytVaR9IAwAE/cxfOORSn5EsbHUkM/
        DBj+KCsmzqeqLxezec78xIoyr2IpoTwTlg8d4iM=
X-Google-Smtp-Source: APXvYqxU5RtQsI6jEN0RjJp84qQmki1a6J02oVs4zymAhs0U8Nm2Iq8maUp45RLs6PFY/UF0Us2+WB7Qj4oNw6XrNuE=
X-Received: by 2002:a92:88d0:: with SMTP id m77mr24809191ilh.9.1577069931094;
 Sun, 22 Dec 2019 18:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20191222184528.32687-1-amir73il@gmail.com> <2f6dbf1777ae4b9870c077b8a34c79bf8ed8a554.camel@kernel.org>
In-Reply-To: <2f6dbf1777ae4b9870c077b8a34c79bf8ed8a554.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 23 Dec 2019 04:58:40 +0200
Message-ID: <CAOQ4uxgJZORnBoGe=UA3j=8sfBeccv07vQes0Q9RjSVXKGrKhw@mail.gmail.com>
Subject: Re: [PATCH] locks: print unsigned ino in /proc/locks
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 23, 2019 at 3:17 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sun, 2019-12-22 at 20:45 +0200, Amir Goldstein wrote:
> > An ino is unsigned so export it as such in /proc/locks.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Hi Jeff,
> >
> > Ran into this while writing tests to verify i_ino == d_ino == st_ino on
> > overlayfs. In some configurations (xino=on) overlayfs sets MSB on i_ino,
> > so /proc/locks reports negative ino values.
> >
> > BTW, the requirement for (i_ino == d_ino) came from nfsd v3 readdirplus.
> >
> > Thanks,
> > Amir.
> >
> >  fs/locks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/locks.c b/fs/locks.c
> > index 6970f55daf54..44b6da032842 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -2853,7 +2853,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
> >       }
> >       if (inode) {
> >               /* userspace relies on this representation of dev_t */
> > -             seq_printf(f, "%d %02x:%02x:%ld ", fl_pid,
> > +             seq_printf(f, "%d %02x:%02x:%lu ", fl_pid,
> >                               MAJOR(inode->i_sb->s_dev),
> >                               MINOR(inode->i_sb->s_dev), inode->i_ino);
> >       } else {
>
> My that is an old bug! I think that goes back to early v2.x days, if not
> v1.x. I'll queue it up, and maybe we can get this in for v5.6.

I suppose you meant for v5.5?
I'd be happy if we can also mark it for stable (sorry I did not).
Reason is that I have xfstests depending on it, which test overlay
fixes that are marked for stable.

Thanks,
Amir.
