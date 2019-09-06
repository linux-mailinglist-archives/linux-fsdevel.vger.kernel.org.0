Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D1FAB766
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 13:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391144AbfIFLwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 07:52:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38242 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391142AbfIFLwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:52:53 -0400
Received: by mail-io1-f66.google.com with SMTP id p12so12063606iog.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 04:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4lqVL9E8teUhvToTgEeuMgi3bTyCtYt4jpvCxfm54Q=;
        b=M6kMLhhrR1rSwxoyoRq92O56PaUv4DjhHtEi23Zna8X3y6GiVStVcgzJOPeB9P6X1d
         DdVtzL1OUc3LB71I/dqAOxlGGmrNQpZB504ocPjGN3JGQcl6Ax9TqTmWb1ESVc1DoXwK
         B46n8m+4HwmtG0XpBl9stwF9MkxMcUuN6wozQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4lqVL9E8teUhvToTgEeuMgi3bTyCtYt4jpvCxfm54Q=;
        b=f+aAWLs3o7+oPPbUEuH6HmkfZEuIoIFL4XYIkDlaIXfXLuWKt4wTu6vWus0M/jGNoJ
         ytxFkxNpTxfkUDfZ64i9lr4aSXUQa74NAEhqL15IjMrG+73bd9QDq13fxvyFduhFJOfc
         Rn8FSKARWMfjTvrt12Dpu7mvJaL/WLjuW8FhZk9Jmmb2YH5iOJMwi65qdY2MCygbkSYH
         iem/59+iWGdFu48CwWsuqlYIxmy9Cg3PBFDlL1qOo+tZ+R5Zn/vPTH7haQWwo0sBEpto
         jH2JRCdURoYdPtzwGcv2HDErwZ2s6EENmrv+SmWsIacOWCr3R/MnMnasch4BE+dVkHRN
         hVdg==
X-Gm-Message-State: APjAAAUPm8L7dLwqXZCoL2zzdJeiVyizHKmeGkY7ZHGygIkfNO/gFTRA
        ReydVsYAR2YckkpknsmDAwSvn4fa9A3PqDEIYdhuJw==
X-Google-Smtp-Source: APXvYqzDqDUnTf7efWqCw8eAeZPl2HmDPoN7CDauAbzjCHdo6rqOXrTSpwAa3PZ379dVg7Ek5PStHiGrSfwEhZLZgpo=
X-Received: by 2002:a5e:d70b:: with SMTP id v11mr701415iom.252.1567770772377;
 Fri, 06 Sep 2019 04:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190905194859.16219-1-vgoyal@redhat.com> <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
 <20190906103613.GH5900@stefanha-x1.localdomain>
In-Reply-To: <20190906103613.GH5900@stefanha-x1.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Sep 2019 13:52:41 +0200
Message-ID: <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 6, 2019 at 12:36 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Fri, Sep 06, 2019 at 10:15:14AM +0200, Miklos Szeredi wrote:
> > On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > Michael Tsirkin pointed out issues w.r.t various locking related TODO
> > > items and races w.r.t device removal.
> > >
> > > In this first round of cleanups, I have taken care of most pressing
> > > issues.
> > >
> > > These patches apply on top of following.
> > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
> > >
> > > I have tested these patches with mount/umount and device removal using
> > > qemu monitor. For example.
> >
> > Is device removal mandatory?  Can't this be made a non-removable
> > device?  Is there a good reason why removing the virtio-fs device
> > makes sense?
>
> Hot plugging and unplugging virtio PCI adapters is common.  I'd very
> much like removal to work from the beginning.

Can you give an example use case?

Thanks,
Miklos
