Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF56250AE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 23:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHXVaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 17:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHXVaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:30:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B848C061755
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 14:30:13 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i13so119755pjv.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 14:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gs/g6tI7n6jveMUW/ARDtq6zG28DxJdOSIVeqCko6II=;
        b=MNVTc6y95JMkz4r9Mb7sIuk5fAy+ivHNAKpuMYgc/WXDvdJfYuBpcFqWJPhg2OxuZ5
         7KeA/dxyz3Ur+YIZvtXrGay3nIKcKaFoTnEMoc6NuCDu8nJQDzzesFra4USnCvcFv584
         nWyO611mw7Zj0w7pwbUyufEizSS8jjoBohbRUakVsTGXvCiEPoJkG4Q2nYNuaNBQQ5OL
         HmyCS+faIeFb/VKgwTvZE5tRNiyuG/tPRmsibybZeB94FVUbK3gck2LM4Al23hzisSyM
         CxnmQfsb/atcIUb3bAktdquYu0IkVQCqgnf2c93HlRY5K9o0sXUgNu6HwI5OC504PAik
         Lnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gs/g6tI7n6jveMUW/ARDtq6zG28DxJdOSIVeqCko6II=;
        b=GItCDXhD1Lr8K+MzJoqstsbKn8PV+s2BLVUiL7b4xU41u1B56pSJUVKn/V2ZgroF/W
         +8A9Epza0z+h1qCbRoGjVoZW1h3sSKeOj60xKLdiYopRQNayxGvG+ARrzteGnt3NFmVu
         7gCA4K/vbFj2C9u9AkWWv07nbjVIySGQgPQq6tCrSnDFZJJYlRQ4XrLT7yyC5jWM+PXM
         eAQf1Yun58RXn/0i2llDyvzFY6cVlFzV5uN2TXKgj7ozL6UbWJ3nKfDD03WTcFyJMJ7v
         iiXSkgpNV+ADARhl9nQ65P5MAKsgbO5TInDsUjFKtMqKT/W2Y5lR/zu8jNC8j7PJhBYs
         WY7w==
X-Gm-Message-State: AOAM530T5ICZ3AqZ3MvndI04k2xaxWw9E+izxiaQzUC8dMwUfuEz/caq
        kkpwa5ZGPUpo7QBIdmvnDk7cYg==
X-Google-Smtp-Source: ABdhPJxPUkgg6LPO+7HYML7jTDyeaEsCV6pQN9aPlzRet61yflYau5fC/ARBI+Xdn1VJHPQNx+waOw==
X-Received: by 2002:a17:90a:ce94:: with SMTP id g20mr934631pju.61.1598304612930;
        Mon, 24 Aug 2020 14:30:12 -0700 (PDT)
Received: from exodia.localdomain ([2620:10d:c090:400::5:8d5d])
        by smtp.gmail.com with ESMTPSA id z126sm12516513pfc.94.2020.08.24.14.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:30:11 -0700 (PDT)
Date:   Mon, 24 Aug 2020 14:30:10 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v5 9/9] btrfs: implement RWF_ENCODED writes
Message-ID: <20200824213010.GD197795@exodia.localdomain>
References: <cover.1597993855.git.osandov@osandov.com>
 <07a61c2f9a07497c165c05106dd0f9ced5bbc4fc.1597993855.git.osandov@osandov.com>
 <83d564d8-234c-a2b5-e261-80ea3b96f6d1@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d564d8-234c-a2b5-e261-80ea3b96f6d1@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 04:30:52PM -0400, Josef Bacik wrote:
> On 8/21/20 3:38 AM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > The implementation resembles direct I/O: we have to flush any ordered
> > extents, invalidate the page cache, and do the io tree/delalloc/extent
> > map/ordered extent dance. From there, we can reuse the compression code
> > with a minor modification to distinguish the write from writeback. This
> > also creates inline extents when possible.
> > 
> > Now that read and write are implemented, this also sets the
> > FMODE_ENCODED_IO flag in btrfs_file_open().
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >   fs/btrfs/compression.c  |   7 +-
> >   fs/btrfs/compression.h  |   6 +-
> >   fs/btrfs/ctree.h        |   2 +
> >   fs/btrfs/file.c         |  40 +++++--
> >   fs/btrfs/inode.c        | 246 +++++++++++++++++++++++++++++++++++++++-
> >   fs/btrfs/ordered-data.c |  12 +-
> >   fs/btrfs/ordered-data.h |   2 +
> >   7 files changed, 298 insertions(+), 17 deletions(-)
> > 
> 
> <snip>
> 
> > +
> > +	ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode), disk_num_bytes);
> > +	if (ret)
> > +		goto out_unlock;
> > +	ret = btrfs_qgroup_reserve_data(BTRFS_I(inode), &data_reserved, start,
> > +					num_bytes);
> > +	if (ret)
> > +		goto out_free_data_space;
> > +	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), num_bytes,
> > +					      disk_num_bytes);
> > +	if (ret)
> > +		goto out_qgroup_free_data;
> 
> This can just be btrfs_delalloc_reserve_space() and that way the error
> handling is much cleaner.
> 
> <snip>
> > +
> > +out_free_reserved:
> > +	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> > +	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
> > +out_delalloc_release:
> > +	btrfs_delalloc_release_extents(BTRFS_I(inode), num_bytes);
> > +	btrfs_delalloc_release_metadata(BTRFS_I(inode), disk_num_bytes,
> > +					ret < 0);
> 
> Likewise this can all just be btrfs_free_reserved_data_space().  Thanks,
> 
> Josef

btrfs_delalloc_reserve_space() and btrfs_free_reserved_data_space()
assume that num_bytes == disk_num_bytes, which isn't true for
RWF_ENCODED.

I figured it'd be cleaner to open-code this special case in the one
place that it's needed, but I could also add explicit num_bytes and
disk_num_bytes arguments to btrfs_delalloc_reserve_space() and
btrfs_free_reserved_data_space(). They'd just be equal everywhere except
for here.

If you're fine with keeping it this way, I'll add a comment explaining
why we can't use the higher-level helpers.
