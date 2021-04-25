Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C901536A883
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 19:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhDYRPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 13:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhDYRPu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 13:15:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEEBC061574;
        Sun, 25 Apr 2021 10:15:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n2so80872991ejy.7;
        Sun, 25 Apr 2021 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfP2I9jepPDnlqkn3NfoWQzbSs5S/A2AOeOXDz1aKn8=;
        b=csRdrK2OAg3bbpymrFRWx63b9IJgU9JhgIMaMtO0/xVkJ+aZU2nCTmn2JhCJyN+4xG
         76wmrbbfIAUFxUJS68GKrRcz0aFPO5S7QF0GP4MrdUWQrxq4xmDi9yAfirJPBIhbrLJ+
         v9m7UWsGL1ukRJCdiJdc78VxsgvuhBkpmNU0CoCyjqGFg3CGt2O1JEJGChmzMygYF9Ro
         uzOvJZItSIqmqIaIHQEHOTfH3SBfOOVot4Dg9cK8leteivXGg3lBD/8oCEyEN4ifB/mo
         GqOlpEPan4kIEI8qvGXPydZ1lWyT7kAwZM1Pc99FeQuTlEtqE8Q7uFWaavZDq5iJhRox
         /AFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfP2I9jepPDnlqkn3NfoWQzbSs5S/A2AOeOXDz1aKn8=;
        b=C2mlxnkInQfiMWj1XgqBK+/w7w5qQTZYc/c8693TbTldjeXYGb/OOVc1+jMsz2c1v9
         O9Qg1ADT6VEZeBIsZ0vQLPkE+3lCBalmsifHHma1j53UE4G0TLO90WJ7UB/gjemjMQ9N
         lXVCMpnxyHtCpzXd16VU3oabERmyFIbTnyJ1NJh3WOMxhFJPBukMt20zCxfv6axrsFI8
         79SqRpvEz2yqG+vDqSSp+oCKxE4qLyNtGOgUfjNFKNN1q25WtSr2OoFnr83N/Z3J+KVy
         MQ59adJ7b3V5ZvB/9wekiO/dtBNpWL/D1cN9a0vdbuq7PaI74Ewd4unfqcWAu23xjKSB
         HFSQ==
X-Gm-Message-State: AOAM533MPJ3yDzY/g1iBt9m8xw8EQPMaRI4Xdsm6eZNGAdv1g7GFEWMl
        578qCu1/h+VK0n+e+Ak3hQtL+zEgPPrDsUvMoMY=
X-Google-Smtp-Source: ABdhPJwmYSn/GHrNw4q99v1cCiswns9jpM6Hkh6R7LrSUHgeIhBVnMuRLyYSPHIOKPp2JJsfFn7fDxQgUEl+EBWrdy8=
X-Received: by 2002:a17:906:86da:: with SMTP id j26mr14262863ejy.187.1619370908741;
 Sun, 25 Apr 2021 10:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAFt=RON+KYYf5yt9vM3TdOSn4zco+3XtFyi3VDRr1vbQUBPZ0g@mail.gmail.com>
 <YIWd7v1U/dGivmSE@zeniv-ca.linux.org.uk> <CAFt=RONcpvvk5=8GLTvG44=6wKwiYPH7oG4YULfcP+J=x8OW-w@mail.gmail.com>
In-Reply-To: <CAFt=RONcpvvk5=8GLTvG44=6wKwiYPH7oG4YULfcP+J=x8OW-w@mail.gmail.com>
From:   haosdent <haosdent@gmail.com>
Date:   Mon, 26 Apr 2021 01:14:57 +0800
Message-ID: <CAFt=ROOw45_PBJmmPovr1zZMS3U99EW=xnHehNHYBcjuq1E+mA@mail.gmail.com>
Subject: Re: NULL pointer dereference when access /proc/net
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengyu.duan@shopee.com, Haosong Huang <huangh@sea.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Not really - the crucial part is ->d_count == -128, i.e. it's already past
> __dentry_kill().

Is it possible that dentry is garbage collected due to memory usage,
but it still is stored in the dentry cache.

Available memory is 5% when this crash happens, not sure if this helps.
```
crash> kmem -i
                 PAGES        TOTAL      PERCENTAGE
    TOTAL MEM  32795194     125.1 GB         ----
         FREE  1870573       7.1 GB    5% of TOTAL MEM
         USED  30924621       118 GB   94% of TOTAL MEM
       SHARED  14145523        54 GB   43% of TOTAL MEM
      BUFFERS   112953     441.2 MB    0% of TOTAL MEM
       CACHED  14362325      54.8 GB   43% of TOTAL MEM
         SLAB   664531       2.5 GB    2% of TOTAL MEM

   TOTAL HUGE        0            0         ----
    HUGE FREE        0            0    0% of TOTAL HUGE

   TOTAL SWAP        0            0         ----
    SWAP USED        0            0    0% of TOTAL SWAP
    SWAP FREE        0            0    0% of TOTAL SWAP

 COMMIT LIMIT  16397597      62.6 GB         ----
    COMMITTED  27786060       106 GB  169% of TOTAL LIMIT
```

On Mon, Apr 26, 2021 at 1:04 AM haosdent <haosdent@gmail.com> wrote:
>
> Hi, Alexander, thanks a lot for your quick reply.
>
> > Not really - the crucial part is ->d_count == -128, i.e. it's already past
> > __dentry_kill().
>
> Thanks a lot for your information, we would check this.
>
> > Which tree is that?
> > If you have some patches applied on top of that...
>
> We use Ubuntu Linux Kernel "4.15.0-42.45~16.04.1" from launchpad directly
> without any modification,  the mapping Linux Kernel should be
> "4.15.18" according
> to https://people.canonical.com/~kernel/info/kernel-version-map.html
>
> On Mon, Apr 26, 2021 at 12:50 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sun, Apr 25, 2021 at 11:22:15PM +0800, haosdent wrote:
> > > Hi, Alexander Viro and dear Linux Filesystems maintainers, recently we
> > > encounter a NULL pointer dereference Oops in our production.
> > >
> > > We have attempted to analyze the core dump and compare it with source code
> > > in the past few weeks, currently still could not understand why
> > > `dentry->d_inode` become NULL while other fields look normal.
> >
> > Not really - the crucial part is ->d_count == -128, i.e. it's already past
> > __dentry_kill().
> >
> > > [19521409.514784] RIP: 0010:__atime_needs_update+0x5/0x190
> >
> > Which tree is that?  __atime_needs_update() had been introduced in
> > 4.8 and disappeared in 4.18; anything of that age straight on mainline
> > would have a plenty of interesting problems.  If you have some patches
> > applied on top of that...  Depends on what those are, obviously.
>
>
>
> --
> Best Regards,
> Haosdent Huang



-- 
Best Regards,
Haosdent Huang
