Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C641723E687
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 06:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgHGEGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 00:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgHGEGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 00:06:03 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4696DC061574;
        Thu,  6 Aug 2020 21:06:03 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j9so681415ilc.11;
        Thu, 06 Aug 2020 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22pRHAFZJwrfnEhk4YQP203Cfv3TA8Rs89eV33L4ZBs=;
        b=YZgjSCHs6FSoDdnfZTJpYf8+Ul+BG9YRyrszbLuy5jGv0njvBGAFPQIl4LGPEB9CTv
         2ELzO2IKrmVSIfRwmOybhOGUnRJUWTflUkTVJ7vaXNU8S6qk6p8y7qN8y6PlmAQAavrm
         q7uUERJnYeRmaaFGXcjB9I9lhashK2rxsw0SZuBYVDwIvCqc2iwRZuNGStHSviBW4T+G
         zbajQPdAYsOsyFJ8a+bdDo0aEDaY+gqBTZok9uLM739OXX89M2L8Pp+ll8Em0C1qOQsj
         U6hTPxk6C4roxt8bztsgjELgxouakxenkNPGCkta7++R8Rw5ygGytcSuZivmCah06wpn
         V4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22pRHAFZJwrfnEhk4YQP203Cfv3TA8Rs89eV33L4ZBs=;
        b=QG2s84yvs68H44J07uf+GuQ5XRZ2Bu3oRdOb2kNY5G9ZBveaWJREzUZR0RmBL/80F2
         qELRKhX1mlK1hmQJXyzHiqgO509S3y0iKh+E9VJQbGeN9XXY0EjuNDHV/Ie9/AzMnpEF
         g0uaOOwJrBKI56kXoLtSPu/hql4WdWIe4WUM49Kh540BKwW3w28PAhTBV4J3Bgjj8BOA
         0eCWMIFCwLc7q4sU+iVvZbwyxXc8K75Vmh/EvnvpumIki/ksM0uVzh7Cz5MrMgsU7GQy
         S8aW8zQLXsJ3Z8rQy5mjruNvvWQHhhE2ffPRC138Q6cGHbGnob/xo1LjI6xm7x6bJJoU
         Cing==
X-Gm-Message-State: AOAM530k79RZ4WIO0neNaE0j/wgkOwlK0sDrl097oSADlZUhzj2nUXD7
        TdlUq/7QeFfgSdxp5gqgta6P5BFYINUR8IBENYLM2J0w
X-Google-Smtp-Source: ABdhPJzqnhnjlpDxMTDIaECEw3N7oTXu2H1Q6Mb/jsKJyoZd0/52AQHq7PgXUz1hCBSvhA+QtCVMkmynvQacvfEWxPA=
X-Received: by 2002:a92:9a4d:: with SMTP id t74mr2462379ili.203.1596773162081;
 Thu, 06 Aug 2020 21:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200801154632.866356-1-laoar.shao@gmail.com> <20200801154632.866356-2-laoar.shao@gmail.com>
 <20200804232005.GD2114@dread.disaster.area> <20200804235038.GL23808@casper.infradead.org>
 <20200805012809.GF2114@dread.disaster.area>
In-Reply-To: <20200805012809.GF2114@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 7 Aug 2020 12:05:26 +0800
Message-ID: <CALOAHbD4jVnMGgG1Gi1b8XqATexPipnUeVkHGN+n5xGbab0hOw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] xfs: avoid double restore PF_MEMALLOC_NOFS if
 transaction reservation fails
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Michal Hocko <mhocko@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Yafang Shao <shaoyafang@didiglobal.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 5, 2020 at 9:28 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Aug 05, 2020 at 12:50:38AM +0100, Matthew Wilcox wrote:
> > On Wed, Aug 05, 2020 at 09:20:05AM +1000, Dave Chinner wrote:
> > > Also, please convert these to memalloc_nofs_save()/restore() calls
> > > as that is the way we are supposed to mark these regions now.
> >
> > I have a patch for that!
>
> Did you compile test it? :)
>
> > ---
> >  fs/xfs/kmem.c      |  2 +-
> >  fs/xfs/xfs_aops.c  |  4 ++--
> >  fs/xfs/xfs_buf.c   |  2 +-
> >  fs/xfs/xfs_linux.h |  6 ------
> >  fs/xfs/xfs_trans.c | 14 +++++++-------
> >  fs/xfs/xfs_trans.h |  2 +-
> >  6 files changed, 12 insertions(+), 18 deletions(-)
>
> .....
>
> > diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> > index 9f70d2f68e05..e1daf242a53b 100644
> > --- a/fs/xfs/xfs_linux.h
> > +++ b/fs/xfs/xfs_linux.h
> > @@ -104,12 +104,6 @@ typedef __u32                    xfs_nlink_t;
> >  #define current_cpu()                (raw_smp_processor_id())
> >  #define current_pid()                (current->pid)
> >  #define current_test_flags(f)        (current->flags & (f))
> > -#define current_set_flags_nested(sp, f)              \
> > -             (*(sp) = current->flags, current->flags |= (f))
> > -#define current_clear_flags_nested(sp, f)    \
> > -             (*(sp) = current->flags, current->flags &= ~(f))
> > -#define current_restore_flags_nested(sp, f)  \
> > -             (current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
>
> current_set_flags_nested() and current_restore_flags_nested()
> are used in xfs_btree_split_worker() in fs/xfs/libxfs/xfs_btree.c
> and that's not a file you modified in this patch...
>

It is in Willy's another patch "mm: Add become_kswapd and
restore_kswapd"[1], which can be committed independently from
"Overhaul memalloc_no*" series. I will carry it in the next version.

[1] https://lore.kernel.org/linux-mm/20200625113122.7540-3-willy@infradead.org/#t
[2] https://lore.kernel.org/linux-mm/20200625113122.7540-1-willy@infradead.org/

-- 
Thanks
Yafang
