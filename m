Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE40D44EC6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 19:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhKLSJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 13:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbhKLSJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 13:09:22 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D742C061767
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 10:06:31 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id v138so25844531ybb.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 10:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ONqLJcSegCmnW02n/+1ACtsLFHO089WZ1+XLjCxNQXY=;
        b=wV4ygtfP318DuFc9B97ZgBHrHMQnrhu/bZhpq55ctMVsfRElIybfcWo+sOLp/p8m7w
         ZBdxx/9xvy5c5yZnVrW3SzAxlsLd72Wz0KJCMNey77acp/Lr0JGMrl18Zo040/1JJOML
         xMQO+5nrrztz1ZRy2ihZT1UDcuzWf84SSsODURgP7iIZQ7tLmx353j+aeS2sqiOL7A44
         sEgL0TY3npeScuigNLZxmAQsK5os3u+B8FImYfbRmhocXbz5w7Q/AnXlF5ylVmgPTCyn
         GYoOETft/VhtU2v0rLgNUMXuUpENF8Kr22kffPpeAhLtsVEgHBp9a5ckjvBRn2cExM/l
         RMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ONqLJcSegCmnW02n/+1ACtsLFHO089WZ1+XLjCxNQXY=;
        b=cexhPgZ27bijDbzRRGRpu3+uYb6CR9mZgCUjBVmJ2sKtQ+AF9vAtAev+8Bl9IYFhR0
         LdedsGmRN7ltSMIg1PVFDg9uEHNVZJ9lYRcfXrdp+ghLvcWfPapg6pN+izmGOzDxp2ea
         764K6ZoDa9ui/MuHa+SshaHoLvkcbXPGh0IyT5gsWx/DP2xbsNf40VPfKvH4vYUtEwaE
         +nvf99ksZlfjXEz65/rDCTPMBYIFu1C9rg+1H62ivOu6EKP7p0dak7cmmnq13xvSFJWJ
         E7NXaLnarAq3Il0NCm+YS8dW3IzLviQBrRnYcEq9rx8lyrV9RD5IdGvIhoZLqNYGRxgp
         03uA==
X-Gm-Message-State: AOAM531UoRSReIIkbdTgNI7jtekxD6YiqnYbex8apfhFMG+BkpP4fL/c
        kRG/WYCq3JDtOSV4+RVFsP+4N5/USdbTPkj5tmzBeA==
X-Google-Smtp-Source: ABdhPJyTAhBE6U322Rf3k6/p4R0QvhlBb/w/HHPxC9/GjNDsKeNrr/Vf+6mDt4uOuxeEkBHSwhz1BgkWBy94d7z9cF8=
X-Received: by 2002:a05:6902:1021:: with SMTP id x1mr18482709ybt.391.1636740390665;
 Fri, 12 Nov 2021 10:06:30 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSh2WT3fijK4sYEdfYpp09ehA+SA75rLyiJ6guUtyWjyw@mail.gmail.com>
 <CAJCQCtQ=JsO6bH=vJE2aZDS_7FDq+y-yHFVm4NTaf7QLArWGAw@mail.gmail.com> <9f7d7997-b1a1-9c4f-8e2f-56e28a54c8c6@suse.com>
In-Reply-To: <9f7d7997-b1a1-9c4f-8e2f-56e28a54c8c6@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 12 Nov 2021 13:06:14 -0500
Message-ID: <CAJCQCtQ4JwAD8Nw-mHWxoXtJT7m0d-d+gi23_JgU=C8dvTtEOA@mail.gmail.com>
Subject: Re: 5.15+, blocked tasks, folio_wait_bit_common
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 12, 2021 at 1:55 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 11.11.21 =D0=B3. 22:57, Chris Murphy wrote:
> > On Thu, Nov 11, 2021 at 3:24 PM Chris Murphy <lists@colorremedies.com> =
wrote:
> >>
> >> Soon after logging in and launching some apps, I get a hang. Although
> >> there's lots of btrfs stuff in the call traces, I think we're stuck in
> >> writeback so everything else just piles up and it all hangs
> >> indefinitely.
> >>
> >> Happening since at least
> >> 5.16.0-0.rc0.20211109gitd2f38a3c6507.9.fc36.x86_64 and is still happen=
ing with
> >> 5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64
> >>
> >> Full dmesg including sysrq+w when the journal becomes unresponsive and
> >> then a bunch of block tasks  > 120s roll in on their own.
> >>
> >> https://bugzilla-attachments.redhat.com/attachment.cgi?id=3D1841283
> >
>
>
> The btrfs traces in this one doesn't look interesting, what's
> interesting is you have a bunch of tasks, including btrfs transaction
> commit which are stuck waiting to get a tag from the underlying block
> device - blk_mq_get_tag function. This indicates something's going on
> with the underlying block device.

Well the hang doesn't ever happen with 5.14.x or 5.15.x kernels, only
the misc-next (Fedora rc0) kernels. And also I just discovered that
it's not happening (or not as quickly) with IO scheduler none. I've
been using kyber and when I switch back to it, the hang happens almost
immediately.




--=20
Chris Murphy
