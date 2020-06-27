Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339BC20C079
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 11:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgF0JdT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 05:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgF0JdT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 05:33:19 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BA1C03E979;
        Sat, 27 Jun 2020 02:33:19 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id i25so12364987iog.0;
        Sat, 27 Jun 2020 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffLQuJygGbq4RaYKN898b4cD/qHH2O6tm/Zb6p2WV+4=;
        b=dLwG+3iUi4OZtTX3/qfZ9iPPiOZsMB5ZU3D7Cqg4ZmmBAkoL/jgX3MlqDeKCkj7VGv
         BOJ+Zrfw3AL2ECEaU8neH+nTTC7hIXDBOD+Mt0FE5+Gfc12cbAGQD+hpllFvb6EEYXO6
         ayr5LNsBY9ntu78FTOgPh6uRn6K2jFonK2IDRikVy/hbj1358XggNyM2bqAkaNO57nmI
         BwVlDNjphmD7dQuaV9bKlPLapFGE0hgyunvtO6IhtNImCPBVGrWgMl1lnyZXOWM2eQo4
         uYmS1nRErBrH455hElDvQ1o8XS0C1DvLBtTz/Ld9MG0ugFqa/tIjXjduxBuYpfQqwzSJ
         t1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffLQuJygGbq4RaYKN898b4cD/qHH2O6tm/Zb6p2WV+4=;
        b=pR/5kGEZhzaaETTHPmQ20VUQQtBgdXZ7c54DydVsypnq80nKXOJAS0npCusn93SOwV
         qi/nYYQkmDpPV3b8CSC0/KwU3jhAAcs7HoavZoo8e//t6XPjOwsaFVmI9BmG8czshjO3
         xJYsZrhnih19HyEiMajD5xGfb4C40MnDVtzIADyffyzJrBXhGl8SEQ9HtpVL5gWDkwih
         p6v2ZISXpYHLSK2IVdojpldmMLjtiWfK2td0eYRkHqh0KjM8Pa6VDo6m2RMi7iwX7ke4
         QyBv225VUszqSAluWcIDQyoTDQRsjN0ZYAF9MtMFQLfNNAbrZF8woMpOjthfj2B6LoFH
         mY/A==
X-Gm-Message-State: AOAM532z3Fi9FrflLSgLADXQeQwSPcuQjZP5gYT4tkoyx7c+aXDxQbXi
        zO1X6fLh4DjJhjnfIgsH3KwuXShseQWa7gsTCNZFHgHg
X-Google-Smtp-Source: ABdhPJwOotjqrBwXrGGAK19+x5rTZhFfEmNnDKCdzD15DVR1Uj4IPHoQ24FfPMq47bdkWhRaLtQgSX7481+BpJyrkQs=
X-Received: by 2002:a6b:780d:: with SMTP id j13mr7883984iom.66.1593250398101;
 Sat, 27 Jun 2020 02:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <1593011142-10209-1-git-send-email-laoar.shao@gmail.com> <20200626090250.GC30103@infradead.org>
In-Reply-To: <20200626090250.GC30103@infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 27 Jun 2020 17:32:42 +0800
Message-ID: <CALOAHbD+pwzq6Gs06mMXQdNo8zPZWk2OD_q199uyH8jOAyd77A@mail.gmail.com>
Subject: Re: [PATCH v2] xfs: reintroduce PF_FSTRANS for transaction
 reservation recursion protection
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster <bfoster@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 5:02 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jun 24, 2020 at 11:05:42AM -0400, Yafang Shao wrote:
> > PF_FSTRANS which is used to avoid transaction reservation recursion, is
> > dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
> > PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
> > memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
> > means to avoid filesystem reclaim recursion. That change is subtle.
> > Let's take the exmple of the check of WARN_ON_ONCE(current->flags &
> > PF_MEMALLOC_NOFS)) to explain why this abstraction from PF_FSTRANS to
> > PF_MEMALLOC_NOFS is not proper.
> >
> > Bellow comment is quoted from Dave,
> > > It wasn't for memory allocation recursion protection in XFS - it was for
> > > transaction reservation recursion protection by something trying to flush
> > > data pages while holding a transaction reservation. Doing
> > > this could deadlock the journal because the existing reservation
> > > could prevent the nested reservation for being able to reserve space
> > > in the journal and that is a self-deadlock vector.
> > > IOWs, this check is not protecting against memory reclaim recursion
> > > bugs at all (that's the previous check [1]). This check is
> > > protecting against the filesystem calling writepages directly from a
> > > context where it can self-deadlock.
> > > So what we are seeing here is that the PF_FSTRANS ->
> > > PF_MEMALLOC_NOFS abstraction lost all the actual useful information
> > > about what type of error this check was protecting against.
> >
> > [1]. Bellow check is to avoid memory reclaim recursion.
> > if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
> >       PF_MEMALLOC))
> >       goto redirty;
> >
> > Suggested-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
>
> This generally looks sane, but:
>
>  - adds a bunch of overly long lines for no good reason
>  - doesn't really hide this behind a useful informatin, e.g. a
>    xfs_trans_context_start/end helpers for the normal case, plus
>    an extra helper with kswapd in the name for that case.
>

Good point. I will try to think about it.

> The latter should also help to isolate a bit against the mm-area
> changes to the memalloc flags proposed.

I have read the patchset from Matthew.  Agree with you that we should
do it the same way.

[adding  Matthew to cc]

-- 
Thanks
Yafang
