Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D334A4006
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 11:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358105AbiAaKVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 05:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358075AbiAaKVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:21:35 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDEFC06173B
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 02:21:35 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id m131so7942636vkm.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 02:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Lm3cgz6DtmL9tpisEfrfuo7Wj8QCaI1ocVGLYB2Y2U=;
        b=Lind02/Njzrr7eWAupL32iIHm4GhlbxdTkXaEnTW2OV0dgNWX/rudjG6+pcPbPpIFq
         C69XJIFu0uAQHgKg9yzKqDEaKe2dTryF/XVS7u5Fs51eNy1ypgdGDsx2HWFQUKmKA/Qj
         gsFWvFnWm3m6cKgmcrNeOadSQiHcKT9p9vJ3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Lm3cgz6DtmL9tpisEfrfuo7Wj8QCaI1ocVGLYB2Y2U=;
        b=66iRhKsRgG1D/swubL9AJXPJVxFo9bb0B5/hoNZb+pjL1UwYV2ajadztMeXkGEMP2R
         texFa+cjg8XyEmQyabRJB/uRFGdx5Bhhmde7feu+Qb7AeqY/kFGs3giWFKVVbHEPJAbp
         gmvS9MztZgBlFBoRoRNL+hM7oN5hlIv/X9qJFMYk+L6HH0ymgFWJzqKslRMq9a7GUmI7
         qaDlu/cHZWC4iVcb3wB38QLsdMll4aNSmzp3NXvJCF/fiDY5Wvv4nezbZqnXMqft20wD
         Ys0tVjJko/1jhsizN3DOzh+IO4JldUMRwKWsu/QMbyC4ccUvPLw6PPAalvzrfTM3/pYb
         rurA==
X-Gm-Message-State: AOAM530Ox2wK7xCx7Uy5eiUXOU3GXltuciuBoAkjr4lZYBIRVQyhO4wz
        5d+chPvoLQbpu9GqnM4rLqEQnlFd8Fk4yeY6omlF9A==
X-Google-Smtp-Source: ABdhPJwOQtCABzU+9UXwt+UwQamDQBcR3aBXOuhKxfwoBl2Am0C/bqSbVLQ7zPuyDB0UYMDY2raQ+Hlv8DNEyXB5kK8=
X-Received: by 2002:a1f:a753:: with SMTP id q80mr8215440vke.1.1643624494313;
 Mon, 31 Jan 2022 02:21:34 -0800 (PST)
MIME-Version: 1.0
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>
 <164360183348.4233.761031466326833349.stgit@noble.brown> <YfdlbxezYSOSYmJf@casper.infradead.org>
 <164360446180.18996.6767388833611575467@noble.neil.brown.name>
In-Reply-To: <164360446180.18996.6767388833611575467@noble.neil.brown.name>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 31 Jan 2022 11:21:23 +0100
Message-ID: <CAJfpeguPJLpJcyC2_FU3pVNk0FhiKJvVuMdQR_wZAgY0Wnsqzg@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: remove reliance on bdi congestion
To:     NeilBrown <neilb@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 31 Jan 2022 at 05:47, NeilBrown <neilb@suse.de> wrote:

> > > +++ b/fs/fuse/file.c
> > > @@ -958,6 +958,8 @@ static void fuse_readahead(struct readahead_control *rac)
> > >
> > >     if (fuse_is_bad(inode))
> > >             return;
> > > +   if (fc->num_background >= fc->congestion_threshold)
> > > +           return;
> >
> > This seems like a bad idea to me.  If we don't even start reads on
> > readahead pages, they'll get ->readpage called on them one at a time
> > and the reading thread will block.  It's going to lead to some nasty
> > performance problems, exactly when you don't want them.  Better to
> > queue the reads internally and wait for congestion to ease before
> > submitting the read.
> >
>
> Isn't that exactly what happens now? page_cache_async_ra() sees that
> inode_read_congested() returns true, so it doesn't start readahead.
> ???

I agree.

Fuse throttles async requests even before allocating them, which
precludes placing them on any queue.  I guess it was done to limit the
amount of kernel memory pinned by a task (sync requests allow just one
request per task).

This has worked well, and I haven't heard complaints about performance
loss due to readahead throttling.

Thanks,
Miklos
