Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3649678EAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 04:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjAXDD1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 22:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAXDD1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:03:27 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E530A2CC76;
        Mon, 23 Jan 2023 19:03:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so11913388wmb.2;
        Mon, 23 Jan 2023 19:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9cr2+HYkZKAIs6xUnuPR3A6wUCkJGuGrotCVYvfqXxQ=;
        b=fxmnkfZUsxInWzE/64k2u+VfdynmkcSF6oZEXV4qdky5gv3oAMgmHClDGkjhqdh7HZ
         Sb40nJvIVJQGEeegj03qHn4Rasd5KCRUA0YcLUsT3qZrLICIahOxMPDIEz9lLGf3n8c9
         bi67GKY+xJWboqdHkEx4s0QWd6vLIa8o6zLpbMNy6OZlqbV7+FNsC/DhdgoonCcAB8yz
         6ThDwniT7GGFOTSLjmqXfAyC5lCXPcsULHSnUaYTrb1yYIi5HK3YqC9o+VQDzbfEQD2E
         QpkOPH13/rZkW3M3ZETcrDlPBbnlYaaep7QkC7w45QpM3hU+0sMlWy8Biici+1RgAfLm
         kd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cr2+HYkZKAIs6xUnuPR3A6wUCkJGuGrotCVYvfqXxQ=;
        b=XDtV4z1sgNIqH1ekv2f3fPxtw4B++Bo1Jz/4c7c21OH8imq0bcrmbX8cbZiLocKZCq
         wAfuRzRxnfbrngQ9VicDvERqH45vYFxVE2De9Kc3PSozU+hXBlqk3ZhJvwQxf/bc07IA
         dHcZxBvR6oplhB48GkrkHCKv7Sj8gpqKRi2TnMHH2HtJTdean2VEO2JFZ39wn7r+0VEI
         R9zn+6jOEFYHd67z+Cgx7ArPGERhsVDWxzBZMmgqGM38KL7j8B9Es6d+Bb2yDhPrANzB
         WXEI0iol49PD7DAjLv3GLEe319P8MOCK9FM5LxsALaIY5S9WDiqXeTaXMA+Ogx7dRkwy
         fxlg==
X-Gm-Message-State: AFqh2kr/HPrk3ddz/k38sSQThOJx7DR5FxYe7SpiXg+/M8kljbJn6HEY
        UKOu2WxJ5yfklcDTVTwEm1PNACy3UXK4pEXMogQ=
X-Google-Smtp-Source: AMrXdXuwns0uxegKxviecx2ooxn/PVxnDy6TnGtz1Znqv3nlS17ApR/sT8NbwL7bAf8Yw/Ryq6KQoDRQiHHKvmdC6CM=
X-Received: by 2002:a1c:f711:0:b0:3d1:e3ba:3bb6 with SMTP id
 v17-20020a1cf711000000b003d1e3ba3bb6mr1550348wmh.29.1674529404009; Mon, 23
 Jan 2023 19:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20221217183142.1425132-1-evanhensbergen@icloud.com>
 <20221218232217.1713283-1-evanhensbergen@icloud.com> <20221218232217.1713283-4-evanhensbergen@icloud.com>
 <Y89F0KGdEBcwu39Y@codewreck.org>
In-Reply-To: <Y89F0KGdEBcwu39Y@codewreck.org>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Mon, 23 Jan 2023 21:03:12 -0600
Message-ID: <CAFkjPTn9nvFB3=iGaKA7WrXvkQwASqr8G1HvB4GBDZFT-2aGsQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] Consolidate file operations and add readahead
 and writeback
To:     asmadeus@codewreck.org
Cc:     Eric Van Hensbergen <evanhensbergen@icloud.com>,
        v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yeah - the dir_release of a regular file is...interesting.
In any case, IIRC the file_write_and_wait_range is effectively a
cache-flush if we are holding a write-buffer and is required for
getting rid of the writeback_fid so it is actually related to the
cache restructuring.

     -eric



On Mon, Jan 23, 2023 at 8:45 PM <asmadeus@codewreck.org> wrote:
>
> Eric Van Hensbergen wrote on Sun, Dec 18, 2022 at 11:22:13PM +0000:
> > We had 3 different sets of file operations across 2 different protocol
> > variants differentiated by cache which really only changed 3
> > functions.  But the real problem is that certain file modes, mount
> > options, and other factors weren't being considered when we
> > decided whether or not to use caches.
> >
> > This consolidates all the operations and switches
> > to conditionals within a common set to decide whether or not
> > to do different aspects of caching.
> >
> > Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>
> > ---
> >  fs/9p/v9fs.c           |  30 ++++------
> >  fs/9p/v9fs.h           |   2 +
> >  fs/9p/v9fs_vfs.h       |   4 --
> >  fs/9p/vfs_dir.c        |   9 +++
> >  fs/9p/vfs_file.c       | 123 +++++++----------------------------------
> >  fs/9p/vfs_inode.c      |  31 ++++-------
> >  fs/9p/vfs_inode_dotl.c |  19 ++++++-
> >  7 files changed, 71 insertions(+), 147 deletions(-)
> >
> > diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> > index 1675a196c2ba..536769cdf7c8 100644
> > --- a/fs/9p/vfs_dir.c
> > +++ b/fs/9p/vfs_dir.c
> > @@ -214,6 +214,15 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
> >       p9_debug(P9_DEBUG_VFS, "inode: %p filp: %p fid: %d\n",
> >                inode, filp, fid ? fid->fid : -1);
> >       if (fid) {
> > +             if ((fid->qid.type == P9_QTFILE) && (filp->f_mode & FMODE_WRITE)) {
>
> dir release, but the fid is of type regular file ?
>
> Either way this doesn't look directly related to cache level
> consodilations, probably better in another commit.
>
> > +                     int retval = file_write_and_wait_range(filp, 0, -1);
> > +
> > +                     if (retval != 0) {
> > +                             p9_debug(P9_DEBUG_ERROR,
> > +                                     "trying to flush filp %p failed with error code %d\n",
> > +                                     filp, retval);
> > +                     }
> > +             }
> >               spin_lock(&inode->i_lock);
> >               hlist_del(&fid->ilist);
> >               spin_unlock(&inode->i_lock);
> --
> Dominique
