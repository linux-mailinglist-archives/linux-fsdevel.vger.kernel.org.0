Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32AE251200
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 08:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgHYGWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 02:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgHYGWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:22:44 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BF9C061574;
        Mon, 24 Aug 2020 23:22:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k4so9451129ilr.12;
        Mon, 24 Aug 2020 23:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJnF6NzmSch03bI5+ZVNRt+pUANjQezLXGWDqR64ZyE=;
        b=q+m2Hw1SeiQXjmCeL5sOpmQ/Q7e7rxTjM9Crx/jDVjVDNid8RGwY33P8onK0iNDsnX
         neuwYqxm2KrM/aBS0s91yNN/YO86OAaA8/dtY2Mq4Wp0y3bv62ipQH9IKOKmps3C3K74
         z7qvnaQaLqYPg1hdb8aAdoSw53YI66Ixvrxf3TWgzNiL9xmoOHKTZxiS10D+oz0WppPB
         vzMVfTV7+HNlMrAZdu4P0SyXScJdKuCYsgkrBdQyOESpxpmcZDLtiskzzt56UPoNfEXI
         FfDdvPSoDnjiF8Dz/xxGoJXTPFVoTKXmqesRBj0WDx1hyL8DYn5wabA8IP9KLXLRI9OL
         uPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJnF6NzmSch03bI5+ZVNRt+pUANjQezLXGWDqR64ZyE=;
        b=kFwuQznf29BTHeLvXDK4ilG1TCOr6sNR5PhvniLxeCsPpF7LlQNm/jrMrhM1kAFYfl
         isTuZKoJAZ8mmfvYaar5y08MC7MwAHbA2+FRa1i50Yl07k8t6h5WumPd4Lyv3pnw/AtR
         SICvafoV8QF6lJp78hsijGFinsSXhSizfPnsbxuSrT1BjtR+H9VZSi7IFbs4e7sChuXR
         4R1+wPSSShf2QvPQT75GjMU9Oj/HzaChJWDlJwn5l7mjzy5wQe9xlsmPQJGrRkpAKPPI
         5JpUM4THVXTxoG+VV2G+vfNd1duEQLJjQRYhnm0cgbTAXvPWgRqe5wHZQhzpTFgPXUbK
         9Mog==
X-Gm-Message-State: AOAM530MpQycEZKw06Hlg/brkaUBk1DsvH5/2/WyjdCQsvyIEtPXaVDj
        Ol2aJZzy23050B0WC2kcrzOETS4El8hvvsatDsM=
X-Google-Smtp-Source: ABdhPJzQfbaRyHzQbR9fyU0qXLrO4Y2S+GlY4XMCXjt/Xr0ZQ+i+TOlj55R6o1mM/ROaK6ZHgSzas1SCwe69FKAmeqk=
X-Received: by 2002:a92:9f57:: with SMTP id u84mr8100793ili.203.1598336564033;
 Mon, 24 Aug 2020 23:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200824014234.7109-1-laoar.shao@gmail.com> <20200824014234.7109-3-laoar.shao@gmail.com>
 <20200824130925.a3d2d2b75ac3a6b4eba72fb9@linux-foundation.org>
 <20200824205647.GG17456@casper.infradead.org> <20200825053233.GN12131@dread.disaster.area>
In-Reply-To: <20200825053233.GN12131@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 25 Aug 2020 14:22:08 +0800
Message-ID: <CALOAHbAhhGXn3N7BTBqh336q0_P1WJH5xXtnBhdsBdS516NAvA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] xfs: avoid transaction reservation recursion
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Michal Hocko <mhocko@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 1:32 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Aug 24, 2020 at 09:56:47PM +0100, Matthew Wilcox wrote:
> > On Mon, Aug 24, 2020 at 01:09:25PM -0700, Andrew Morton wrote:
> > > On Mon, 24 Aug 2020 09:42:34 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > > --- a/include/linux/iomap.h
> > > > +++ b/include/linux/iomap.h
> > > > @@ -271,4 +271,11 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
> > > >  # define iomap_swapfile_activate(sis, swapfile, pagespan, ops)   (-EIO)
> > > >  #endif /* CONFIG_SWAP */
> > > >
> > > > +/* Use the journal_info to indicate current is in a transaction */
> > > > +static inline bool
> > > > +fstrans_context_active(void)
> > > > +{
> > > > + return current->journal_info != NULL;
> > > > +}
> > >
> > > Why choose iomap.h for this?
> >
> > Because it gets used in iomap/buffered-io.c
> >
> > I don't think this is necessarily a useful abstraction, to be honest.
> > I'd just open-code 'if (current->journal_info)' or !current->journal_info,
> > whichever way round the code is:
> >
> > fs/btrfs/delalloc-space.c:              if (current->journal_info)
> > fs/ceph/xattr.c:                if (current->journal_info) {
> > fs/gfs2/bmap.c:         if (current->journal_info) {
> > fs/jbd2/transaction.c:  if (WARN_ON(current->journal_info)) {
> > fs/reiserfs/super.c:    if (!current->journal_info) {
>
> /me wonders idly if any of the other filesystems that use
> current->journal_info can have an active transaction while calling
> ->writepages...
>
> .... and if so, whether this patchset has taken the wrong path in
> trying to use current->journal_info for XFS to re-implement this
> warning.....
>
> .... so we'll have to remove or rework this yet again when other
> filesystems are converted to use iomap....
>
> /me suspects the btrfs_write_and_wait_transaction() is a path where
> this can actually happen...
>

How about adding a flag in struct writeback_control ?
struct writeback_control {
    ...
    unsigned fstrans_check:1; /* Whether to check the current is in fstrans */
};

Then we can set it in xfs_vm_writepage(s), for example,

xfs_vm_writepage
{
    wbc->fstrans_check = 1;  // set it for XFS only.
    return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
}

And then we check this flag in iomap_do_writepage():
iomap_do_writepage
    if (WARN_ON_ONCE(wbc->fstrans_check && current->journal_info))
        goto redirty;


-- 
Thanks
Yafang
