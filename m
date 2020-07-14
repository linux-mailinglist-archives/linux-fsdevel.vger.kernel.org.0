Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FD521EAF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 10:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGNIHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 04:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGNIHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:07:15 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58F5C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 01:07:14 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h28so16214052edz.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 01:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxG136uE7k/7DQKw2dWH82lAeA2t/fDkcPS0g4RMW9A=;
        b=El1qSrVlx5j8OzqWY+jAkGIyxjaAfYH+cAXX/jS9K9Nm7LDsD7Ow20X6ZI/9L4i34m
         i6WsR0CtSO9QTmeXYDIWsjH1tlcEOcfyjR+Yn6OuRbJMAlEjvHkjEtfJJvDtJKZFb57q
         UXgWM5FxsZRScs6IL4dz92fo4cR62DnQk6wXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxG136uE7k/7DQKw2dWH82lAeA2t/fDkcPS0g4RMW9A=;
        b=YCNEE+Ln8fj0B7MUe5gB1WZZzw4ZxZf9jOKUEkmKXD5MoyGAq8tSYqlzMsbNlDImPP
         xGfsJs6FogFlsa416eg9dzhgWaisrrnULGUuAwVLbG3d9Aw3V2YkqoS0nlNpWpJzUpkZ
         KXP3jHoyN3jLVctQvqPt6EqnfsFJjAV/hS3nGBd1je6/MvjglSEjBkEQRX4kqyo6dUgO
         E+k2lLRB7Gr1PM1q4ZM4jAOFVign81TXgIhlCdeST847vRwb5w2rF4Exr8U5/u1e2c4I
         gveB5WCuGnXvaMP8p7lSdPAgyZihy+DD162blz9Pq0pcCcXGSbdSpIQ3qvShK60KZwg9
         XSAA==
X-Gm-Message-State: AOAM531k/qbT+BUSXPQJBTug7RTQKl3UwQrHenUR1mdrbfgqIumwiXxB
        hIPJjalkRRKux6sW0nAO0RCTyNxo/ZSvdmtdqXjSgA==
X-Google-Smtp-Source: ABdhPJzWasYoseKAcvHkcWBtEYPiZDeYidABizN8Y9lJDS4GoTapol5Yea6vIlDc4ozwIskC2c/AS3sLTWFc+1jaNwk=
X-Received: by 2002:a05:6402:1687:: with SMTP id a7mr3263957edv.358.1594714033497;
 Tue, 14 Jul 2020 01:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705115021.GA1227929@kroah.com> <20200714065110.GA8047@amd>
In-Reply-To: <20200714065110.GA8047@amd>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 14 Jul 2020 10:07:02 +0200
Message-ID: <CAJfpegu8AXZWQh3W39PriqxVna+t3D2pz23t_4xEVxGcNf1AUA@mail.gmail.com>
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close faster
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>, shuah@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 8:51 AM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > > At first, I thought that the proposed system call is capable of
> > > reading *multiple* small files using a single system call - which
> > > would help increase HDD/SSD queue utilization and increase IOPS (I/O
> > > operations per second) - but that isn't the case and the proposed
> > > system call can read just a single file.
> >
> > If you want to do this for multple files, use io_ring, that's what it
> > was designed for.  I think Jens was going to be adding support for the
> > open/read/close pattern to it as well, after some other more pressing
> > features/fixes were finished.
>
> What about... just using io_uring for single file, too? I'm pretty
> sure it can be wrapped in a library that is simple to use, avoiding
> need for new syscall.

Just wondering:  is there a plan to add strace support to io_uring?
And I don't just mean the syscalls associated with io_uring, but
tracing the ring itself.

I think that's quite important as io_uring becomes mainstream.

Thanks,
Miklos
