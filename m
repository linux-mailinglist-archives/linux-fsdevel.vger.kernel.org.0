Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C1813234B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 11:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgAGKMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 05:12:13 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44804 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGKMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:12:12 -0500
Received: by mail-io1-f68.google.com with SMTP id b10so51989466iof.11;
        Tue, 07 Jan 2020 02:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PbyQyZ9o+Ro7E6bXOC6SCrk7HuZRr+h0vUWe4gZ98uQ=;
        b=mE+vclw3cfYF8tFzCALd6ffjBbn9elwbyo2EMwffZsN59D8gkO888bX94L0BigDx7F
         v4pyG7hhBxC13kJmfR5Yx8yFLrRgTbf53DgRK+6BNulX4LVJ88/uqtPDurJ+IbRaAmKe
         8EWtlB5diKEI3JJzHIL8tmpDSqiLcfuZhHLn6DioccebewAhH/tDiUTWY3XPDQVBh5ZG
         rvl714eo8s/x6NhqpZbqD0JRkjrfe02kKiYkAiEV5zMYyvV91xk04MCXKgcpnnVq4paH
         LtkyG1gx+IMCw52HZAq5gzXbppsUW0ZEga4mS2tYjQn9/QgoxTukRxnnCE3/iT4jmU9B
         09xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbyQyZ9o+Ro7E6bXOC6SCrk7HuZRr+h0vUWe4gZ98uQ=;
        b=fNWl0PPULz+gTBaZQtSSdEY6kQW403O0mhiHGQplPgu4/CkIPagZzL6EpGywS1uXsQ
         tnZIpkZnQFCjNWxiuH7+iMFBSsYO9UsW0mNC/nBLYz41Ksw9z8SDmDrPiWO0VP4xLdy3
         shVqUd+98Z6FWtMdVoqLXdbn4dLmVp0nN7UHceccNE6Chfb6mEhHT5qmVn8HyJN3yvyb
         /kwtaonwNrVu8xr/6oVqv1iLKj9HikVGe1Ku5NW5TXdIKCeZR7bdWP8AZD6F7Pevm6L+
         7sXgt0DroheBEPCExPgkGilCSLji7gHnLCcch4195mk3CUkIe0LNAPniGxlRJ7xy/uYP
         r3jQ==
X-Gm-Message-State: APjAAAUfjhrMX3HbMOIzLc4sXmGuSK+SUWgbgYoHAJqKvFGJC2AlDmm0
        A6umI48uuI8oMhFPzbmgf8/gqwLFErumDDSfle1wgw==
X-Google-Smtp-Source: APXvYqx3r2qgxfq0fEj3TX01n99so2jqPkAzW5BeIfMPMxERNE6WNcSTMhTdDGboy4GGuyjRN9uytisFExuwcaccWaw=
X-Received: by 2002:a02:81cc:: with SMTP id r12mr80549653jag.93.1578391931918;
 Tue, 07 Jan 2020 02:12:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578225806.git.chris@chrisdown.name> <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name>
 <20200107001039.GM23195@dread.disaster.area> <20200107001643.GA485121@chrisdown.name>
 <20200107003944.GN23195@dread.disaster.area> <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com>
 <alpine.LSU.2.11.2001070002040.1496@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2001070002040.1496@eggly.anvils>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 7 Jan 2020 12:12:00 +0200
Message-ID: <CAOQ4uxiMQ3Oz4M0wKo5FA_uamkMpM1zg7ydD8FXv+sR9AH_eFA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
To:     Hugh Dickins <hughd@google.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Chris Down <chris@chrisdown.name>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 7, 2020 at 10:36 AM Hugh Dickins <hughd@google.com> wrote:
>
> On Tue, 7 Jan 2020, Amir Goldstein wrote:
> > On Tue, Jan 7, 2020 at 2:40 AM Dave Chinner <david@fromorbit.com> wrote:
> > > On Tue, Jan 07, 2020 at 12:16:43AM +0000, Chris Down wrote:
> > > > Dave Chinner writes:
> > > > > It took 15 years for us to be able to essentially deprecate
> > > > > inode32 (inode64 is the default behaviour), and we were very happy
> > > > > to get that albatross off our necks.  In reality, almost everything
> > > > > out there in the world handles 64 bit inodes correctly
> > > > > including 32 bit machines and 32bit binaries on 64 bit machines.
> > > > > And, IMNSHO, there no excuse these days for 32 bit binaries that
> > > > > don't using the *64() syscall variants directly and hence support
> > > > > 64 bit inodes correctlyi out of the box on all platforms.
>
> Interesting take on it.  I'd all along imagined we would have to resort
> to a mount option for safety, but Dave is right that I was too focused on
> avoiding tmpfs regressions, without properly realizing that people were
> very unlikely to have written such tools for tmpfs in particular, but
> written them for all filesystems, and already encountered and fixed
> such EOVERFLOWs for other filesystems.
>
> Hmm, though how readily does XFS actually reach the high inos on
> ordinary users' systems?
>

Define 'ordinary'
I my calculations are correct, with default mkfs.xfs any inode allocated
from logical offset > 2TB on a volume has high ino bits set.
Besides, a deployment with more than 4G inodes shouldn't be hard to find.

Thanks,
Amir.
