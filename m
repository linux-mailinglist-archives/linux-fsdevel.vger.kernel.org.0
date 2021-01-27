Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06781305493
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 08:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhA0HZj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 02:25:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233735AbhA0HXm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:23:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B9EF2074B;
        Wed, 27 Jan 2021 07:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611732179;
        bh=wys3sZM3KFLi7kSDIT+8OH9R8Mzfn9WfVwnN3287ktM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bec44/no8t56Z502LgnlM+Qg3a7iRfwb8LyhJ+o5g82IaOznb97Gk8xlDwtFm7y0Q
         4B+/tC5K9lGgUBiHyhE00pi36rFGRQbfNmoExpX38MvaaIEiIlo5Xpl02zb3d2+c9I
         6QT/NDPMg5Mj36lJBF9f+RFUcTIY2MmljvRbc0DiIULgDdoXmR4KXliM+gH3VlyPk6
         mHWoOAExmkNvS6m/z6G7b4ZdKBJLDixAbo/Wzlpm3cgdfJxA927Fy/aSbJhFzA/wq4
         2ciHhZnN+TzrdwTTB4DOYnCFwWnsw1IL4QMJJGrVzDQalyZsi3zFFnOCUMa/DMqtOX
         AkooKL+eqRW2g==
Received: by mail-lj1-f174.google.com with SMTP id 3so909613ljc.4;
        Tue, 26 Jan 2021 23:22:59 -0800 (PST)
X-Gm-Message-State: AOAM531YWoDEJpp8cDQgEYHd2BYi206VyMREUIK+5Ba7zozGspXdzCHp
        c+jh1CywFVUWO0gArFcLfSpkGUIVPc6m/ZhnXsY=
X-Google-Smtp-Source: ABdhPJwT4SgEWFQYI+aGplxcgngrqXZ09YVZXq+be6TcwdS2L0sd+F5PxgqsedykGzzK3GAh/e6zF7ilKInCLGcj5r0=
X-Received: by 2002:a2e:b8d3:: with SMTP id s19mr5116366ljp.97.1611732177533;
 Tue, 26 Jan 2021 23:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20210126145247.1964410-1-hch@lst.de> <20210126145247.1964410-14-hch@lst.de>
In-Reply-To: <20210126145247.1964410-14-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 26 Jan 2021 23:22:46 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4AViTNjq1mp6zvbEJ8zKdK7__BfXEsvATTBWraK2u1Jg@mail.gmail.com>
Message-ID: <CAPhsuW4AViTNjq1mp6zvbEJ8zKdK7__BfXEsvATTBWraK2u1Jg@mail.gmail.com>
Subject: Re: [PATCH 13/17] md: remove md_bio_alloc_sync
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 7:17 AM Christoph Hellwig <hch@lst.de> wrote:
>
> md_bio_alloc_sync is never called with a NULL mddev, and ->sync_set is
> initialized in md_run, so it always must be initialized as well.  Just
> open code the remaining call to bio_alloc_bioset.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/md.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 6a27f52007c871..399c81bddc1ae1 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -340,14 +340,6 @@ static int start_readonly;
>   */
>  static bool create_on_open = true;
>
> -static struct bio *md_bio_alloc_sync(struct mddev *mddev)
> -{
> -       if (!mddev || !bioset_initialized(&mddev->sync_set))
> -               return bio_alloc(GFP_NOIO, 1);
> -
> -       return bio_alloc_bioset(GFP_NOIO, 1, &mddev->sync_set);
> -}
> -
>  /*
>   * We have a system wide 'event count' that is incremented
>   * on any 'interesting' event, and readers of /proc/mdstat
> @@ -989,7 +981,7 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
>         if (test_bit(Faulty, &rdev->flags))
>                 return;
>
> -       bio = md_bio_alloc_sync(mddev);
> +       bio = bio_alloc_bioset(GFP_NOIO, 1, &mddev->sync_set);
>
>         atomic_inc(&rdev->nr_pending);
>
> --
> 2.29.2
>
