Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFC34678FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 15:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381317AbhLCOEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 09:04:45 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:52038 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352843AbhLCOEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:04:42 -0500
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 64524CD725E;
        Fri,  3 Dec 2021 15:01:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1638540070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2nhD4zra9xotXQb3VuD0lCqOmyZLq0VjR4YeA+r1z2U=;
        b=p7usrMbkAXabAriuPUDQkjnERX7qsoPkVejZuXN+DdzWEpWdfyHLcO6qkUqkFMhnj5fWMK
        g66TAHWHFLc18LHnjInRbw7WyLAuSo/fnTveYakx8m58uVKZmWFIpcOnW8JY9Mr3uKhP+O
        Zs/RPt/7vIiOPfz0lzdddNeDYdZJLZA=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     ValdikSS <iam@valdikss.org.ru>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Avramov <hakavlad@inbox.lv>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, kernel@xanmod.org,
        aros@gmx.com, hakavlad@gmail.com, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working set
Date:   Fri, 03 Dec 2021 15:01:08 +0100
Message-ID: <4776971.31r3eYUQgx@natalenko.name>
In-Reply-To: <20211202135824.33d2421bf5116801cfa2040d@linux-foundation.org>
References: <20211130201652.2218636d@mail.inbox.lv> <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru> <20211202135824.33d2421bf5116801cfa2040d@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello.

On =C4=8Dtvrtek 2. prosince 2021 22:58:24 CET Andrew Morton wrote:
> On Thu, 2 Dec 2021 21:05:01 +0300 ValdikSS <iam@valdikss.org.ru> wrote:
> > This patchset is surprisingly effective and very useful for low-end PC
> > with slow HDD, single-board ARM boards with slow storage, cheap Android
> > smartphones with limited amount of memory. It almost completely prevents
> > thrashing condition and aids in fast OOM killer invocation.
> >=20
> > The similar file-locking patch is used in ChromeOS for nearly 10 years
> > but not on stock Linux or Android. It would be very beneficial for
> > lower-performance Android phones, SBCs, old PCs and other devices.
> >=20
> > With this patch, combined with zram, I'm able to run the following
> > software on an old office PC from 2007 with __only 2GB of RAM__
> >=20
> > simultaneously:
> >   * Firefox with 37 active tabs (all data in RAM, no tab unloading)
> >   * Discord
> >   * Skype
> >   * LibreOffice with the document opened
> >   * Two PDF files (14 and 47 megabytes in size)
> >=20
> > And the PC doesn't crawl like a snail, even with 2+ GB in zram!
> > Without the patch, this PC is barely usable.
> > Please watch the video:
> > https://notes.valdikss.org.ru/linux-for-old-pc-from-2007/en/
>=20
> This is quite a condemnation of the current VM.  It shouldn't crawl
> like a snail.
>=20
> The patch simply sets hard limits on page reclaim's malfunctioning.
> I'd prefer that reclaim not malfunction :(
>=20
> That being said, I can see that a blunt instrument like this would be
> useful.
>=20
> I don't think that the limits should be "N bytes on the current node".
> Nodes can have different amounts of memory so I expect it should scale
> the hard limits on a per-node basis.  And of course, the various zones
> have different size as well.

Probably not. To my understanding, the limits should roughly correspond to=
=20
what you see after executing this:

```
$ echo 1 | sudo tee /proc/sys/vm/drop_caches; grep -F 'Active(file)' /proc/
meminfo
```

IMO, this has nothing to do with the size of the node.

> We do already have a lot of sysctls for controlling these sort of
> things.  Was much work put into attempting to utilize the existing
> sysctls to overcome these issues?

=2D-=20
Oleksandr Natalenko (post-factum)


