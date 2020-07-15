Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5A8221838
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 01:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgGOXGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 19:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgGOXGj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:06:39 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F14BC061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 16:06:39 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x9so3495630ila.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 16:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=YivRthLAfKaEua7h8UdGQzIfshdVmHiPDyDk24Sle/k=;
        b=SxDJAyJ/uBrBF/9KERYwiMyUJ5FqNFrDn+Qd1wWl4G7QnsxYtshRKwdYRX3I7W+Kgw
         41qCwTQW2EIruH/VSxg4eptKZfmg4nIvCzvNALRZyPjwcGhqfcGuZKuRltmeirnEj8dE
         VlhxiKTjpSchFhPrkpBCP//aRDFF3kLf467xLcyATlq335l5qs0iaW+akgKoqm3ushNP
         l1xuZRqF14HDvh5Cf0hHXsDXXSYh39gPILQp0S8753BrCZQ5wlaEehsA2h8UM95hHUqN
         CSd7QJOMZivGyEHotwnZ2z0x02oFjhvnJL+LqmYU/ctfW2gVNGJXdQ7k+OUvT5H717qn
         lQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=YivRthLAfKaEua7h8UdGQzIfshdVmHiPDyDk24Sle/k=;
        b=qr9QAxHRi2NMXiG+ba+E5v8UltjaHXtcNBOO+nzzNpnv6WJADcZjbMvpLWeJr95cS2
         EjJ4CPNtWXVCkm1pxNlshT7b7wt9qMiLeXth3cyMMnX6fzRJ5RX6sLp4ekDsLgX+78Wp
         W1aHUK408v2+BjrU7+30ir89GljISHESwHpBaZpHot8gao2sRPNtrllO41TzDNX63I6H
         e5NocLYAObFp1LWVUrLQaoDih5PZ6mYQt/7XfE8Uf9cMoG10X4O0IfAAaeLf0svT0xxr
         v2F5UQwbgCgYF/herEUCY1bRtXqiXStxJh76KwncRBMybLeZ5/jO82/MjPDhb7TqyyhE
         twag==
X-Gm-Message-State: AOAM530goN52WR/AUcV980RUpYiit3r8Rjn8MRH0w83yt4WG/X6u7LGg
        9P7Ukm5Veh4W7rUHT56SJPK5QbLUWuea7PSCqqM=
X-Google-Smtp-Source: ABdhPJy4KBQtzqEjJ5WQgACzVOpPMJPx5HRgGlWjzXMlZb0j5q5SZVTi4kyWgHCNvqFE0qjnHu4mm91G6jUyABdp4B0=
X-Received: by 2002:a92:dc09:: with SMTP id t9mr1887425iln.226.1594854398480;
 Wed, 15 Jul 2020 16:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200714102639.662048-1-chirantan@chromium.org> <CAJfpegvd3nHWLtxjeC8BfW8JTHKRmX5iNgdWYYFj+MEK-ogiFw@mail.gmail.com>
In-Reply-To: <CAJfpegvd3nHWLtxjeC8BfW8JTHKRmX5iNgdWYYFj+MEK-ogiFw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 16 Jul 2020 01:06:27 +0200
Message-ID: <CA+icZUWDtOHpgTCEhPatYfR+zJAbOBK2ihtf7G=zzCKAxiVmsQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: Fix parameter for FS_IOC_{GET,SET}FLAGS
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chirantan Ekbote <chirantan@chromium.org>,
        linux-fsdevel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 5:05 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, Jul 14, 2020 at 12:26 PM Chirantan Ekbote
> <chirantan@chromium.org> wrote:
> >
> > The ioctl encoding for this parameter is a long but the documentation
> > says it should be an int and the kernel drivers expect it to be an int.
> > If the fuse driver treats this as a long it might end up scribbling over
> > the stack of a userspace process that only allocated enough space for an
> > int.
> >
> > This was previously discussed in [1] and a patch for fuse was proposed
> > in [2].  From what I can tell the patch in [2] was nacked in favor of
> > adding new, "fixed" ioctls and using those from userspace.  However
> > there is still no "fixed" version of these ioctls and the fact is that
> > it's sometimes infeasible to change all userspace to use the new one.
>
> Okay, applied.
>

...and pushed? I do not see in in fuse.git.

- Sedat -

> Funny that no one came back with this issue for 7 years.
>
> Thanks,
> Miklos
