Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8879540369E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 11:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348630AbhIHJJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 05:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348674AbhIHJJd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:09:33 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892F9C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Sep 2021 02:08:25 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id a25so1396271vso.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Sep 2021 02:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PA8vAmdCswwPmH9JVz4rgkXlhppEfYY9FmgCfjE/RRA=;
        b=GhIrhaYgjAhuzYMjautu/yKd2CYeBoA0RM96QSa6E5IUONMMa5jRU9voFeJoo3qA2w
         OhvAhBOhdjiqopMsr8cBmsR7luN5khQc5D5aHmBDUvU66g4AyJ+SlTC7A7vD0QRS/S7F
         k7D/tVAm9Yb2wHJ5Iy6GwYy0i6gy1s01Bt6Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PA8vAmdCswwPmH9JVz4rgkXlhppEfYY9FmgCfjE/RRA=;
        b=SDrrP+dMq1ktsdcxIlcEyL+bUg/mg2TQYjE1dcasXLCHxmsal5WN6h3mgx75BghHQR
         VIAa9MHnCF06zl2OXaBgw/rkdm7sQQpa5yudoPxeKiAnLWe4XctyvDfuAsLc+n2tLpKo
         tZyF6KCaZtNVaDtGnQXNTzsrM0JO+CpwlrbAMlLYMWe7DSsCXt160cmCSPQ/jNcohYUw
         pFA1RzScuj3zEZNQ32bX4BcqFPaONNejhjcVO8ssKi5l3tdwbEBRzCgpohEoUNvR90oi
         fFd3m8T5VQDm+5b6cV7+9ejRI3PmoA6jTKsAtDqhwL4g67MU/mtkQAn0TyFD/OJxXYKg
         wkFA==
X-Gm-Message-State: AOAM532yCMPOnEal2saShBbWQbNMekPNz/LWDmoTjSqUC7FzdrkvlibY
        8GDEj53g2NzVhkkmCudS7SYvQVJKNZvWcRU08Ko6lA==
X-Google-Smtp-Source: ABdhPJxEWr8jIfBSKwQ8KosN+JTyMEKPOyqOgAqc047cGPX9+bDp5+AbQEunwEvxD1cQnhY3jWSxv2gIVjuFk9aR0AA=
X-Received: by 2002:a67:ed5a:: with SMTP id m26mr1273795vsp.59.1631092104778;
 Wed, 08 Sep 2021 02:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50a+j8UL9g3UwpRsye5e+a=M0Hy7Tf1FdfwOrUUBWMyosNg@mail.gmail.com>
 <CAJfpegtbdz-wzfiKXAaFYoW-Hqw6Wm17hhMgWMqpTCtNXgAnew@mail.gmail.com> <CAPm50aKJ4ckQJw=iYDOCqvm=VTYaEcfgNL52dsj+FX8pcVYNmw@mail.gmail.com>
In-Reply-To: <CAPm50aKJ4ckQJw=iYDOCqvm=VTYaEcfgNL52dsj+FX8pcVYNmw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 8 Sep 2021 11:08:14 +0200
Message-ID: <CAJfpegt9J75jAXWo=r+EOmextpSze0LFDUV1=TamxNoPchBSUQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add a dev ioctl for recovery
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 8 Sept 2021 at 04:25, Hao Peng <flyingpenghao@gmail.com> wrote:
>
> On Tue, Sep 7, 2021 at 5:34 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, 6 Sept 2021 at 14:36, Hao Peng <flyingpenghao@gmail.com> wrote:
> > >
> > > For a simple read-only file system, as long as the connection
> > > is not broken, the recovery of the user-mode read-only file
> > > system can be realized by putting the request of the processing
> > > list back into the pending list.
> >
> > Thanks for the patch.
> >
> > Do you have example userspace code for this?
> >
> Under development. When the fuse user-mode file system process is abnormal,
> the process does not terminate (/dev/fuse will not be closed), enter
> the reset procedure,
> and will not open /dev/fuse again during the reinitialization.
> Of course, this can only solve part of the abnormal problem.

Yes, that's what I'm mainly worried about.   Replaying the few
currently pending requests is easy, but does that really help in real
situations?

Much more information is needed about what you are trying to achieve
and how, as well as a working userspace implementation to be able to
judge this patch.

Thanks,
Miklos
