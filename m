Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB01A5D15
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 08:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgDLGrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Apr 2020 02:47:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42102 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgDLGrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Apr 2020 02:47:05 -0400
Received: by mail-io1-f67.google.com with SMTP id y17so6224292iow.9;
        Sat, 11 Apr 2020 23:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjGDxi5B3VXdAiZ5r2/e7JLSd3GB+0GVuORm4mGPP3c=;
        b=ZU62f04iXHvT06cgjyP1zhmCpdCijIeNT1rzkXBNyRaJY3eXtiU/8+DYL9aT2ZBidV
         RmNPfPFlKHh/s0iLo9tvqSG+eZHejjIE9g30UCPKlhCYwiF9o8ulStpudSsx/czde283
         ZEDGXLRaFBsJDSInam0s8urqqs8oTp8a+XefssaW7LmWQhxb0oM50uOPPC9YoRzIQCto
         J7C/73C9FfG2GQOXV/JALKqi3Yw9NHfVQ9HaqtlLTqKSEV4jOlNif+VwvswqtrIFmmkE
         nnI1ICwHBWAQSvhXDDjqIiIAn3G1+Ns8fxIww7AI0lDX3Y4Zy0q+CtsJoJuEyD8KJ2pR
         VaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjGDxi5B3VXdAiZ5r2/e7JLSd3GB+0GVuORm4mGPP3c=;
        b=RlJluQMCiwE2SWo0/uj2s8qT015iw0CCAg6ATm8n/M66ywmhWervoW7jgfXgKK2P2j
         A3d9PA06PbJcouVkpYF4hJw795ZOZjDFjEKDHybABdtpiUcxckA82kLRCmNUMx+6KLBa
         5nwyP/UWRC1pkt/JX3ofqovKYykV9eofZ2cJwCaQAAlZLU0OVOjjN5R+83bHWNQD6WHW
         3HU1zmr9dMNM2tKXe3/j2xsl/JHzelGBU9MWbtLx0It7Ett/rhZnog4lj37v/BncoKZj
         UdjXbfnDzaKXHajlQLvJUF/a0DTfODO8gKcNDPKiVjdBFCFMKpgeKt9tomqOHTYiqRYr
         WLMA==
X-Gm-Message-State: AGi0PuazWvZKLhHCug9RUTTdIySPt9+cre7PYWF9Qm7t4Qx9lFouPrLs
        8aTxukML/QxqOlUQ3A38S0mG0w1uDG9yNlG5PNn+wcq6
X-Google-Smtp-Source: APiQypLNtacdtAqj8zZFpCSgeQiPfEj/zpXMaKMK+FdRcT6C1vtRXKAII5Jeji8d4W2je5OX1xLz6j7ZzzyiPcRlvyY=
X-Received: by 2002:a02:c9cb:: with SMTP id c11mr10641464jap.93.1586674024515;
 Sat, 11 Apr 2020 23:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <158642098777.5635.10501704178160375549.stgit@buzz> <20200411222829.GO10737@dread.disaster.area>
In-Reply-To: <20200411222829.GO10737@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 12 Apr 2020 09:46:53 +0300
Message-ID: <CAOQ4uxgnSVctF5Kyh+RwW9zH00ctaA9UPS2cnW1roxho7pjf3g@mail.gmail.com>
Subject: Re: [PATCH] ovl: skip overlayfs superblocks at global sync
To:     Dave Chinner <david@fromorbit.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 12, 2020 at 1:29 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Apr 09, 2020 at 11:29:47AM +0300, Konstantin Khlebnikov wrote:
> > Stacked filesystems like overlayfs has no own writeback, but they have to
> > forward syncfs() requests to backend for keeping data integrity.
> >
> > During global sync() each overlayfs instance calls method ->sync_fs()
> > for backend although it itself is in global list of superblocks too.
> > As a result one syscall sync() could write one superblock several times
> > and send multiple disk barriers.
> >
> > This patch adds flag SB_I_SKIP_SYNC into sb->sb_iflags to avoid that.
>
> Why wouldn't you just remove the ->sync_fs method from overlay?
>
> I mean, if you don't need the filesystem to do anything special for
> one specific data integrity sync_fs call, you don't need it for any
> of them, yes?
>

No, but I understand the confusion.

Say you have 1000 overlay sb's all of them using upper directories
from a single xfs sb (quite common for containers).

syncfs(2) of each overlay, must call sync_fs of xfs (see ovl_sync_fs)
sync(2) will call xfs sync_fs anyway, so there is no point in calling
ovl_sync_fs => xfs sync_fs 1000 more times.

Thanks,
Amir.
