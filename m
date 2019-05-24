Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4E129CC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 19:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbfEXRSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 13:18:17 -0400
Received: from mail-yw1-f47.google.com ([209.85.161.47]:46331 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfEXRSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 13:18:17 -0400
Received: by mail-yw1-f47.google.com with SMTP id a130so3896005ywe.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2019 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fjzoEk7VHLdIfi/lCjGQJd6xWD7AQcbop/UJoQp2cg=;
        b=a/c5aNCzXO7PLBa6Ssaqn9PV4rrkGxnsM1xHZvBruNhViUf57ByhvKw3LDYheK9AVn
         7xJweo6a0bX6nCiUyOF7CyQkSOrwCnrRYJodZ7ZURffExgzgfwIZtij7VsdWYDlFMm4J
         CeQpx3k3MuKNFnJsl8HBdrM9eCTBqU2bjRihv6CICpP+ObFN3uYNQbM08yATD9rZYezo
         piWyxLCsiAi33onCQZ2vc9k53xG1v6VSYYloF6+HRn+tDtjZuHI2YULEcjbfU8sP7s9a
         LQDhUD/jirMOuLBVgP1pGxJ/WeylORNTxm5AX/+Ce1SLL+O7QVCsp/KxF6araNp75DBt
         JthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fjzoEk7VHLdIfi/lCjGQJd6xWD7AQcbop/UJoQp2cg=;
        b=Tvgl6IwtCpjCPfXJWvWH7kJQp2WQyP/9hPHxsokVAtcOHN8p4uVLqi07JCS6AaosSB
         XzREidzcsRt3uv8Xg+cDmLsUDj7Fx6RJ5k9ufnsQPWjdYh5+uYSET3CCdPlSX7ICZEG4
         qhg3hEetrIXFdNJESJxF+6+Uih46tqpg8D0FouNrUsOxRD0fBIiRXqyZLDspkLWeRbs6
         GgRWPkTzb0w7k3GKAsOu0shm6bu5tBIXOZfJfVv1Ijo6LqxRJZ72BcphxenFQq8PzWf6
         Dtz7di8TyrdBgEuj3226wIau9Z4RTFc3myV69Cyy5B+61J0qsgYegnUE7y7246Pkk5GZ
         8s6w==
X-Gm-Message-State: APjAAAVkclJQeY2fuKDu6E9u07M65EVAqGlV8kfB7Znd3g53qCZBntdZ
        2gcEtYgBaSzdQmapR0X8ZVv3aV9ysx4xNVTLrPHI5g==
X-Google-Smtp-Source: APXvYqzyCi24bS0zt4t5z9+kM3048deoltYoGq6J2shC7KVjEfqjZWrRksXqNV+c9NbCgXa7Mb/kKqN3XyJrvZZBLfc=
X-Received: by 2002:a81:7cc2:: with SMTP id x185mr11843465ywc.10.1558718295643;
 Fri, 24 May 2019 10:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190523174349.GA10939@cmpxchg.org> <20190523183713.GA14517@bombadil.infradead.org>
 <CALvZod4o0sA8CM961ZCCp-Vv+i6awFY0U07oJfXFDiVfFiaZfg@mail.gmail.com>
 <20190523190032.GA7873@bombadil.infradead.org> <20190523192117.GA5723@cmpxchg.org>
 <20190523194130.GA4598@bombadil.infradead.org> <20190523195933.GA6404@cmpxchg.org>
 <20190524161146.GC1075@bombadil.infradead.org> <20190524170642.GA20546@cmpxchg.org>
In-Reply-To: <20190524170642.GA20546@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 24 May 2019 10:18:04 -0700
Message-ID: <CALvZod5=N_hwGLFzCZY=DG0RfwzSt2sjJDcPZtCRy-NcBsLL+w@mail.gmail.com>
Subject: Re: xarray breaks thrashing detection and cgroup isolation
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 24, 2019 at 10:06 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, May 24, 2019 at 09:11:46AM -0700, Matthew Wilcox wrote:
> > On Thu, May 23, 2019 at 03:59:33PM -0400, Johannes Weiner wrote:
> > > My point is that we cannot have random drivers' internal data
> > > structures charge to and pin cgroups indefinitely just because they
> > > happen to do the modprobing or otherwise interact with the driver.
> > >
> > > It makes no sense in terms of performance or cgroup semantics.
> >
> > But according to Roman, you already have that problem with the page
> > cache.
> > https://lore.kernel.org/linux-mm/20190522222254.GA5700@castle/T/
> >
> > So this argument doesn't make sense to me.
>
> You haven't addressed the rest of the argument though: why every user
> of the xarray, and data structures based on it, should incur the
> performance cost of charging memory to a cgroup, even when we have no
> interest in tracking those allocations on behalf of a cgroup.
>
> Which brings me to repeating the semantics argument: it doesn't make
> sense to charge e.g. driver memory, which is arguably a shared system
> resource, to whoever cgroup happens to do the modprobe / ioctl etc.
>
> Anyway, this seems like a fairly serious regression, and it would make
> sense to find a self-contained, backportable fix instead of something
> that has subtle implications for every user of the xarray / ida code.

Adding to Johannes point, one concrete example of xarray we don't want
to charge is swapper_spaces. Swap is a system level resource. It does
not make any sense to charge the swap overhead to a job and also it
will have negative consequences like pinning zombies.

Shakeel
