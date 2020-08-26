Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56F825264F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 06:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgHZEbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 00:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgHZEbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 00:31:22 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED89C061574;
        Tue, 25 Aug 2020 21:31:21 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e11so648066ils.10;
        Tue, 25 Aug 2020 21:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBuaD5BaR2/EGCVaGN6hCXlzR5PN4Ki6fYU4xrxHw9g=;
        b=lZaJYGuD+p/YHplr4Xk5CjSZ0k84/MWoewzFEgD+aOYtajQgoPeut3P7h7u3dhHhXI
         rCRscD0nO5cH7i4+gc4zY4MwXibsEXyDfH32lEp/5yzavUulAWdHf6/tKPcuUyu4yM4f
         pMA7l6Tmab7UBMMFjyNX+QlhPxOVzw4rft2pswOXkNGz+xw6ZtpG/aqEipFbs0OW8MSs
         MHUF2TcPKV99jBZAAnJO4q398hJ2IFWRi8BJHLh3U9TpKsQyOrl5964FqY9qZwWf/z0k
         wsgoWhx7qMr6yiAVoerN38NtXijWJc03tUuOHtC6bwlnE40ZTv2oJSOusG+yyUxifH/S
         aezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBuaD5BaR2/EGCVaGN6hCXlzR5PN4Ki6fYU4xrxHw9g=;
        b=RWh9sMvdYHk9PN6gqbDgATLjD3leHSOuq7q+Y3T94zhZEh55DIWMsJjpHpa6ud+1Aw
         N/ewCR0iW0WLetkPTA/50rrfERQqxTpKkV+K43iNsfMLb5GwU2UdsIKtMR7ogc82rGKb
         /JkNa62vrmM8Jb1592rApcDsdIJ0EsPmnfYPwaGoeYH8uGYViA5b+KAUkwksEjcPsYxB
         SKIeEruR8e6zv5lWAhF1dIRbRoaJQ/TD48Jqd9NkdmFqzTgU2aOYggbqBdiQLyQM1f9f
         +ONtbGEIcvmOXki0JbIho7avXdgCODq2O+Xs3tjGdlrlhjEE9Q7dd32q0rs2nc40r6FX
         xgUw==
X-Gm-Message-State: AOAM53343aF+RUfvqy3QH1L1ATh60DZkE+8JxedWATbCDpBufDip215y
        r7cvcwCo/heOehJVOPNSDNidxG1krlcIPxEQaXk=
X-Google-Smtp-Source: ABdhPJzPmiF6ccG2bMScN7vxr3mxxWPakKUF3i3sOXSNmnGAOYWqsZ2IP5cQwHbO/ltvKRTafUPNXuCviBqi0o5RLJI=
X-Received: by 2002:a92:c849:: with SMTP id b9mr12556382ilq.168.1598416281120;
 Tue, 25 Aug 2020 21:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200824014234.7109-1-laoar.shao@gmail.com> <20200824014234.7109-3-laoar.shao@gmail.com>
 <20200824130925.a3d2d2b75ac3a6b4eba72fb9@linux-foundation.org>
 <20200824205647.GG17456@casper.infradead.org> <20200825053233.GN12131@dread.disaster.area>
 <CALOAHbAhhGXn3N7BTBqh336q0_P1WJH5xXtnBhdsBdS516NAvA@mail.gmail.com> <20200825224721.GU12131@dread.disaster.area>
In-Reply-To: <20200825224721.GU12131@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 26 Aug 2020 12:30:45 +0800
Message-ID: <CALOAHbA1h1nmJrkFzb3FdyF3JL9Tws6=73vJ=v-ajzWoHsp7vQ@mail.gmail.com>
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

On Wed, Aug 26, 2020 at 6:47 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Aug 25, 2020 at 02:22:08PM +0800, Yafang Shao wrote:
> > On Tue, Aug 25, 2020 at 1:32 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Mon, Aug 24, 2020 at 09:56:47PM +0100, Matthew Wilcox wrote:
> > > > On Mon, Aug 24, 2020 at 01:09:25PM -0700, Andrew Morton wrote:
> > > > > On Mon, 24 Aug 2020 09:42:34 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > >
> > > > > > --- a/include/linux/iomap.h
> > > > > > +++ b/include/linux/iomap.h
> > > > > > @@ -271,4 +271,11 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
> > > > > >  # define iomap_swapfile_activate(sis, swapfile, pagespan, ops)   (-EIO)
> > > > > >  #endif /* CONFIG_SWAP */
> > > > > >
> > > > > > +/* Use the journal_info to indicate current is in a transaction */
> > > > > > +static inline bool
> > > > > > +fstrans_context_active(void)
> > > > > > +{
> > > > > > + return current->journal_info != NULL;
> > > > > > +}
> > > > >
> > > > > Why choose iomap.h for this?
> > > >
> > > > Because it gets used in iomap/buffered-io.c
> > > >
> > > > I don't think this is necessarily a useful abstraction, to be honest.
> > > > I'd just open-code 'if (current->journal_info)' or !current->journal_info,
> > > > whichever way round the code is:
> > > >
> > > > fs/btrfs/delalloc-space.c:              if (current->journal_info)
> > > > fs/ceph/xattr.c:                if (current->journal_info) {
> > > > fs/gfs2/bmap.c:         if (current->journal_info) {
> > > > fs/jbd2/transaction.c:  if (WARN_ON(current->journal_info)) {
> > > > fs/reiserfs/super.c:    if (!current->journal_info) {
> > >
> > > /me wonders idly if any of the other filesystems that use
> > > current->journal_info can have an active transaction while calling
> > > ->writepages...
> > >
> > > .... and if so, whether this patchset has taken the wrong path in
> > > trying to use current->journal_info for XFS to re-implement this
> > > warning.....
> > >
> > > .... so we'll have to remove or rework this yet again when other
> > > filesystems are converted to use iomap....
> > >
> > > /me suspects the btrfs_write_and_wait_transaction() is a path where
> > > this can actually happen...
> > >
> >
> > How about adding a flag in struct writeback_control ?
> > struct writeback_control {
> >     ...
> >     unsigned fstrans_check:1; /* Whether to check the current is in fstrans */
> > };
> >
> > Then we can set it in xfs_vm_writepage(s), for example,
> >
> > xfs_vm_writepage
> > {
> >     wbc->fstrans_check = 1;  // set it for XFS only.
> >     return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
> > }
>
> Yeah, but if we are doing that then I think we should just remove
> the check completely from iomap_writepage() and move it up into
> xfs_vm_writepage() and xfs_vm_writepages().
>

Sure.

-- 
Thanks
Yafang
