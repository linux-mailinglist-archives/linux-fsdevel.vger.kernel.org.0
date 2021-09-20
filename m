Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7FB412B84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 04:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347063AbhIUCTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 22:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbhIUBv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0F9C0DBA98;
        Mon, 20 Sep 2021 15:35:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eg28so44386645edb.1;
        Mon, 20 Sep 2021 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xBEjLn8neg2tRAMyWTbvXCFNduQWyte0Fp7znCoDD4=;
        b=prKje2XMyXXLq4tB6hSuSVp8msgpZmzcJdPnTSUaUBHBrzX5B5Tfk7YPfTa16cCn/c
         5xIkwNGf+OzVUmwvYi2NJUy4XgXJz2SeQYVjqjB/YJx+fAhCnh2oLBWbTk7F8zZjGUA/
         bzFLVRCdCqYoXNmp2JvKSkN4gQIkU4pvAbnAAo48DIoh2mYs9EwoRwSN8R+2a+aah5nk
         /JvkJpqKKJN5NIPIk9OKksghWlWZ0eCegP4kLCDVsrE/sWe9nMxx6rfwmZqWtniTBPFS
         OECNbfOTxS6a+/WDAOt8f4rUHDXRG28i1s7jI8HKRG+15RufUKBqda0IG2sRKBG4kAwI
         gDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xBEjLn8neg2tRAMyWTbvXCFNduQWyte0Fp7znCoDD4=;
        b=A9WmbLJCvAbzr++HFX3sAfgEE3g+OW9/EjTbUzcIeli9s1XOfnI7p93PRUwWp3ZBGm
         sI78XdDS9B/kkjOz5Zxst8qXdxDs9jFlPjkghxBDIBveCOarm3p7aAyLH16bhMrd1mqF
         /PryOsZUkIyXuZg/ek69z/7n+W58bsR6DwrRx3I/xAJpHEizAdMRTwYWUAIA6hlV56cC
         hlXAtzNX+36ijUA68TEmb7eflih5gGkKATKqzLO0GGOkNk+sSnb2YA9K4m0xd+Gxv3GJ
         5ZQOzT695BNDDChNa8nQPxw88LNgAvzCMD3WTWEZlnl+zCbVoga8a9LiRcrepwYDel2V
         dO+w==
X-Gm-Message-State: AOAM533E+XZzyuO8Wrb6W4MWS5Pp//Z5I1GAvyWlayNNiIh0r57zwh6I
        tFWPR5QTzZy2bJzLmb+xFxJQwwJOoyPqevG59rSmcNdh
X-Google-Smtp-Source: ABdhPJwfhME9ZoxsDvEJDmmg14thFBosztYbmAGLOAyehoP/iCEddlasfNhUJDfWfBLW+hQHkQtFJr1dCVBL4ueII4E=
X-Received: by 2002:a17:906:3854:: with SMTP id w20mr29819934ejc.537.1632177320456;
 Mon, 20 Sep 2021 15:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210917205731.262693-1-shy828301@gmail.com> <CAHbLzkqmooOJ0A6JmGD+y5w_BcFtSAJtKBXpXxYNcYrzbpCrNQ@mail.gmail.com>
 <YUdL3lFLFHzC80Wt@casper.infradead.org> <CAHbLzkrPDDoOsPXQD3Y3Kbmex4ptYH+Ad_P1Ds_ateWb+65Rng@mail.gmail.com>
 <YUkCI2I085Sos/64@casper.infradead.org>
In-Reply-To: <YUkCI2I085Sos/64@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 20 Sep 2021 15:35:08 -0700
Message-ID: <CAHbLzkoXrVJOfOrNhd8nQFRPHhRVYfVYSgLAO3DO7ZmvaZtDVw@mail.gmail.com>
Subject: Re: [PATCH] fs: buffer: check huge page size instead of single page
 for invalidatepage
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, cfijalkovich@google.com,
        song@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Hao Sun <sunhao.th@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 2:50 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Sep 20, 2021 at 02:23:41PM -0700, Yang Shi wrote:
> > On Sun, Sep 19, 2021 at 7:41 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Sep 17, 2021 at 05:07:03PM -0700, Yang Shi wrote:
> > > > > The debugging showed the page passed to invalidatepage is a huge page
> > > > > and the length is the size of huge page instead of single page due to
> > > > > read only FS THP support.  But block_invalidatepage() would throw BUG if
> > > > > the size is greater than single page.
> > >
> > > Things have already gone wrong before we get to this point.  See
> > > do_dentry_open().  You aren't supposed to be able to get a writable file
> > > descriptor on a file which has had huge pages added to the page cache
> > > without the filesystem's knowledge.  That's the problem that needs to
> > > be fixed.
> >
> > I don't quite understand your point here. Do you mean do_dentry_open()
> > should fail for such cases instead of truncating the page cache?
>
> No, do_dentry_open() should have truncated the page cache when it was
> called and found that there were THPs in the cache.  Then khugepaged
> should see that someone has the file open for write and decline to create
> new THPs.  So it shouldn't be possible to get here with THPs in the cache.

AFAICT, it does so.

In do_dentry_open():
/*
         * XXX: Huge page cache doesn't support writing yet. Drop all page
         * cache for this file before processing writes.
         */
        if (f->f_mode & FMODE_WRITE) {
                /*
                 * Paired with smp_mb() in collapse_file() to ensure nr_thps
                 * is up to date and the update to i_writecount by
                 * get_write_access() is visible. Ensures subsequent insertion
                 * of THPs into the page cache will fail.
                 */
                smp_mb();
                if (filemap_nr_thps(inode->i_mapping))
                        truncate_pagecache(inode, 0);
        }


In khugepaged:
filemap_nr_thps_inc(mapping);
                /*
                 * Paired with smp_mb() in do_dentry_open() to ensure
                 * i_writecount is up to date and the update to nr_thps is
                 * visible. Ensures the page cache will be truncated if the
                 * file is opened writable.
                 */
                smp_mb();
                if (inode_is_open_for_write(mapping->host)) {
                        result = SCAN_FAIL;
                        __mod_lruvec_page_state(new_page, NR_FILE_THPS, -nr);
                        filemap_nr_thps_dec(mapping);
                        goto xa_locked;
                }

But I'm not quite sure if there is any race condition.
