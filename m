Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2166DFD0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 17:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfD3Pjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 11:39:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44519 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfD3Pjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:39:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id d24so12288606otl.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 08:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDm6QOW6C+ywZne3LW7Ypw7lAdQTfas17MrrXq3ecwo=;
        b=JhyTwIiyX2u/jRSdekO+wIAxQovstRQD/xzG58s1Bsqpyn96xy2XBJwUSpKFBOcOVx
         IjnEfuPLk4EG42spAVfvCnvNFMrA3MU2cxKXCv1snNd/9rZjy86PdMzkUGlysEakBtNo
         x5fEGGdyjRAEimpvpKfQSPE+156fej/5LF2csAIcnfk4P3qeUiHXa1GPvX7NvLmY0VNL
         Zm7yzm7+ZMoWug+NHfXXwuJYZNY1761JXHTnlCU9+v1Yok7wq+f5WvaDsZsILpY8d5AA
         lAe07Xpx2NUeG1ctqkeXOOySi5NU/3VDmr0tmOa8A+I4qSTw56Np6QwaxVGInQ1zHf0e
         LOCw==
X-Gm-Message-State: APjAAAWlQRPhocWTMXK8fKsYfHeBiBrKTy/f4SAWg6MMTad0F10/vi2p
        j1Q0tGvIK/Uwz3lNyYJNrMGUp7V0no3IT+AVTvDYTA==
X-Google-Smtp-Source: APXvYqw8N8JoFFbtJVwle+z88rtJCuTvvxvCdMMXpDMhyN036qx9KAapBJJNOssCOcuQfUZoHwNGv9RcjuZWCQxY7v4=
X-Received: by 2002:a9d:7d06:: with SMTP id v6mr15700460otn.187.1556638779909;
 Tue, 30 Apr 2019 08:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190429220934.10415-1-agruenba@redhat.com> <20190429220934.10415-6-agruenba@redhat.com>
 <20190430153256.GF5200@magnolia>
In-Reply-To: <20190430153256.GF5200@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 30 Apr 2019 17:39:28 +0200
Message-ID: <CAHc6FU5hHFWeGM8+fhfaNs22cSG+wtuTKZcMMKbfeetg1CK4BQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] gfs2: Fix iomap write page reclaim deadlock
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        =?UTF-8?B?RWR3aW4gVMO2csO2aw==?= <edvin.torok@citrix.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 30 Apr 2019 at 17:33, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> On Tue, Apr 30, 2019 at 12:09:34AM +0200, Andreas Gruenbacher wrote:
> > Since commit 64bc06bb32ee ("gfs2: iomap buffered write support"), gfs2 is doing
> > buffered writes by starting a transaction in iomap_begin, writing a range of
> > pages, and ending that transaction in iomap_end.  This approach suffers from
> > two problems:
> >
> >   (1) Any allocations necessary for the write are done in iomap_begin, so when
> >   the data aren't journaled, there is no need for keeping the transaction open
> >   until iomap_end.
> >
> >   (2) Transactions keep the gfs2 log flush lock held.  When
> >   iomap_file_buffered_write calls balance_dirty_pages, this can end up calling
> >   gfs2_write_inode, which will try to flush the log.  This requires taking the
> >   log flush lock which is already held, resulting in a deadlock.
>
> /me wonders how holding the log flush lock doesn't seriously limit
> performance, but gfs2 isn't my fight so I'll set that aside and assume
> that a patch S-o-B'd by both maintainers is ok. :)

This only affects inline and journaled data, not standard writes, so
it's not quite as bad as it looks.

> How should we merge this patch #5?  It doesn't touch fs/iomap.c itself,
> so do you want me to pull it into the iomap branch along with the
> previous four patches?  That would be fine with me (and easier than a
> multi-tree merge mess)...

I'd prefer to get this merged via the gfs2 tree once the iomap fixes
have been pulled.

Thanks,
Andreas
