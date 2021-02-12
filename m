Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D7C319954
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 05:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhBLEtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 23:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhBLEtu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:49:50 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232F1C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 20:49:10 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id z3so4224553vsn.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 20:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oT9pyCENAroqyQofR5rn6Lps4PvawUWgtEucTBqW7iw=;
        b=SBcCIGew+7NcUv9Rxp/TNTz7mifemsxhrM6e+hfhx5MYwXbz52Ck4QZR+r4jsLBJO2
         r+XRXX2Vsw7cQ5XjHme0SSRI6NrP72/VTYwoCEGyoWYu6uo/N76xzEO8dKY70/o/Y0eo
         IInnBbOrjCaaoLGRVVyDTdgc3DvVHgg4DZWGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oT9pyCENAroqyQofR5rn6Lps4PvawUWgtEucTBqW7iw=;
        b=fP0ZSBr8decoQJugGEXT7XIGm3KN1yc69Gc0FbYsOPOy3S6TRYaNLGq/VncWUi4L6L
         7WJqSlVl15Pq3IeV0cgVxohG5+A+4oKRsN5Mp5r+rpYzGfxxNJjV1lgWbvB2sUUksQ6G
         sHWePQbpM4pqTnWMa4i3Lz1iJ0sdqYtqYFhMePD+HXrv7lUYWi9PolKEa8ojbgQ8xafw
         dZLHT2wxV3deWDTowsfw6tlej/7eaqmgD3Di7v1RglOqTeVxDXJFPvoKrwnSxbYrCAOM
         p8b/tGoWBGeApyqqLaZxH6pPGnjL3mMAC4iPOQxkHazuiyDFy2SNxUqDhRUvufCg2d2c
         LCEw==
X-Gm-Message-State: AOAM531vHTNCivmX9dP8V1t+3Yj2gBUEydVkpDTd965jbYG3HmKjglj8
        hlAwM5a4T0UM2O6U6w5gPDrchk1cSKO7xcnOVYtrsg==
X-Google-Smtp-Source: ABdhPJyHoAlR6CMUlfGjiAWZc0NvZy9JCi9TYPUoslYua2PwM2zVdEd4SGjcOXxORuVffGnf+189/F+jN/EF996hdrs=
X-Received: by 2002:a67:8945:: with SMTP id l66mr530140vsd.48.1613105349219;
 Thu, 11 Feb 2021 20:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid>
 <20210126233840.GG4626@dread.disaster.area> <CANMq1KBcs+S02T=76V6YMwTprUx6ucTK8d+ZKG2VmekbXPBZnA@mail.gmail.com>
 <20210128055726.GF7695@magnolia>
In-Reply-To: <20210128055726.GF7695@magnolia>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 12 Feb 2021 12:48:58 +0800
Message-ID: <CANMq1KCcSZL=_CC2r2Yv8e_p7JY9RKgJ1kSVMrCAO0ZokSupeg@mail.gmail.com>
Subject: Re: [PATCH] fs: generic_copy_file_checks: Do not adjust count based
 on file size
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Luis Lozano <llozano@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 1:57 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Thu, Jan 28, 2021 at 08:46:04AM +0800, Nicolas Boichat wrote:
[snip]
> > Okay, so, based on this and Al's reply, I see 2 things we can do:
> >  1. Go should probably not use copy_file_range in a common library
> > function, as I don't see any easy way to detect this scenario
> > currently (detect 0 size? sure, but that won't work with the example
> > you provide above). And the man page should document this behaviour
> > more explicitly to prevent further incorrect usage.
> >  2. Can procfs/sysfs/debugfs and friends explicitly prevent usage of
> > copy_file_range? (based on Al's reply, there seems to be no way to
> > implement it correctly as seeking in such files will not work in case
> > of short writes)
>
> One /could/ make those three provide a phony CFR implementation that
> would return -EOPNOTSUPP, though like others have said, it's weird to
> have regular files that aren't quite regular.  Not sure where that
> leaves them, though...

Not that simple, as the issue happens on cross-filesystem operations
where file_operations->copy_file_range is not called (and also, that'd
require modifying operations for every single generated file...

Anyway, made an attempt here:
https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/T/#t

> --D
>
> >
> > Thanks,
> >
> > >
> > > Cheers,
> > >
> > > Dave.
> > > --
> > > Dave Chinner
> > > david@fromorbit.com
