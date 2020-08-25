Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ECC250E50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 03:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgHYBkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 21:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgHYBkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:40:01 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7352C061574;
        Mon, 24 Aug 2020 18:40:01 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id v2so9076045ilq.4;
        Mon, 24 Aug 2020 18:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoiR+v9rO+JXIM35TpzuNUweu/a+mWGhR08Sf+gYpoE=;
        b=qVYjfvfGCAzq+gxatqSrfaeQ96FYChxURcFFoBc5HXjiJqoVg5Tdqs/0vFBZ5YSE/2
         SE8aSLz2Cchy9al8OyFoMCAAgxuxkx/rG6U5R57KMI1JZK2vEb/CVOCC0c/VouiJsZST
         X9XuB47UsC4YojWP1A8+VcjPJs7w0c87sAn5iReaKh/H8eq0fGO0gLQI/VC33M61CDSN
         qKFLKg/JSDmdiYE4dp0TmJBQMd20UejWs28TkVjF5FpBTp6LAPeiJVEnxmLYkMioUVTP
         qWqHv22buV1/cxcPf+LLRnEBy48+coznSzonwcYoMeJbmVDpCWZc+KNd92zPM08/ihAy
         bI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoiR+v9rO+JXIM35TpzuNUweu/a+mWGhR08Sf+gYpoE=;
        b=KeceSB6E4/WxpjX68AdhFvfWbTSmaqvCFapDW2y+cwUSH8QNk9gdkKwSnWkh75CG4G
         pT+5jITmOih+bH3RCEJWA7MIBLQ/jIwommcYmHaMCo8vReClgG/kS1p8+HViUBXPHnjq
         DJtjhriQsvUr7dEwCNgA0SGk3Qt1tFL180QcZzQ1m7pLBIxmDJRMoWZpid6XBc95CpLV
         MR2nHkboW4m1FJ9pPK34ntXnrNBTjrDPvA2wA5MYn4tqxabSW/SwKyZGDtSsl+qvlrTc
         tKrPoacciet1R60e8z0q0f3PXBt+9GDBOutg1QRP2MCSogJfXaDETzWSpKnuh23YRy2h
         4rIg==
X-Gm-Message-State: AOAM530R6q67/XNMMQV79nsF+T9PEmgrPvCr31c9vuVngvh9iIwR6ZiI
        Us5IaMgTf2Vgu7dRZPmn6BwyQOrPmua99rNZ9sM=
X-Google-Smtp-Source: ABdhPJx0GCQd+VH/ciHeUEmZwX5OFuSMWk4a0K8nSG9UO2gwrrUAyTwcH+dYnw1X5Jf4O6U8fviHxbX6S9C4HsipWbk=
X-Received: by 2002:a92:108:: with SMTP id 8mr7376238ilb.142.1598319600842;
 Mon, 24 Aug 2020 18:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200824014234.7109-1-laoar.shao@gmail.com> <20200824014234.7109-3-laoar.shao@gmail.com>
 <20200824130925.a3d2d2b75ac3a6b4eba72fb9@linux-foundation.org> <20200824205647.GG17456@casper.infradead.org>
In-Reply-To: <20200824205647.GG17456@casper.infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 25 Aug 2020 09:39:25 +0800
Message-ID: <CALOAHbDzH21xgu7r1+h+VcZ=KbEHbxDypqAnVqVAzfTm1Jb-NQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] xfs: avoid transaction reservation recursion
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Michal Hocko <mhocko@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 4:56 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Aug 24, 2020 at 01:09:25PM -0700, Andrew Morton wrote:
> > On Mon, 24 Aug 2020 09:42:34 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > > --- a/include/linux/iomap.h
> > > +++ b/include/linux/iomap.h
> > > @@ -271,4 +271,11 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
> > >  # define iomap_swapfile_activate(sis, swapfile, pagespan, ops)     (-EIO)
> > >  #endif /* CONFIG_SWAP */
> > >
> > > +/* Use the journal_info to indicate current is in a transaction */
> > > +static inline bool
> > > +fstrans_context_active(void)
> > > +{
> > > +   return current->journal_info != NULL;
> > > +}
> >
> > Why choose iomap.h for this?
>
> Because it gets used in iomap/buffered-io.c
>
> I don't think this is necessarily a useful abstraction, to be honest.
> I'd just open-code 'if (current->journal_info)' or !current->journal_info,
> whichever way round the code is:
>
> fs/btrfs/delalloc-space.c:              if (current->journal_info)
> fs/ceph/xattr.c:                if (current->journal_info) {
> fs/gfs2/bmap.c:         if (current->journal_info) {
> fs/jbd2/transaction.c:  if (WARN_ON(current->journal_info)) {
> fs/reiserfs/super.c:    if (!current->journal_info) {
>
> (to pluck a few examples from existing filesystems)

Make sense to me.
I will update it in the next version.

-- 
Thanks
Yafang
