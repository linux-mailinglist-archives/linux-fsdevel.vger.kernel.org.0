Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F81A277535
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 17:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgIXPYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 11:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgIXPYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:24:31 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833AFC0613CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2020 08:24:31 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n61so3483310ota.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2020 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=m0/7orr2bqONgdfV3PvzDhTDv6jv4SQnoe7eILd/BxI=;
        b=vUsKFkjJb4QWZhQ5sT7fcyK2TC48cOLdhDF+dcUKkWMbAN2em6KOEen9co0cWR7cvH
         Pw8fX50z1plwhtU3OOqGO5We2H4k5OcBQ3w43r3Udu0zF0QtLZ5xTvkkwOn8Ow/Rd2WZ
         cecTHUDCVFpFbeD1ZVfYwS0etnkUZFZ5iY+9d0B4fc7hJeU26uj/V8JUWJzNQ4jgnAFS
         WYpmM/uGYhAfH3NTTXwT7o8jYQB4nVLJoSi6xord2je33F4yvUwPMDVt1O43dvqGcXYD
         uUzkROkGBzH6iMeve84cx8ERZgb1rJKlU163mGbTfHb9f7FMK1MWo/FyGRKaKhr/jIO+
         VjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=m0/7orr2bqONgdfV3PvzDhTDv6jv4SQnoe7eILd/BxI=;
        b=Xb72Hegc9SfUIapkwKi3PiwdK5T3EaEeah4Bi46kHHvcBabo2kpfeVBkkR0zsJlX43
         FUa/rukz+3LhnmAXKQsh0mUP+wbD0H5p3jj8pK3acc3xPAfc5+6xHPjFXYopXvgtmHht
         P/0BhbLEee+ROvNkUxTzOeUULicxy6hnlxc/t36Hnd/3GrQbU4f4lXaDHzhNjFs6hIPU
         71EKRzslwSuSWskKmxB3E3LJ9SawY5OFoRJmkqdfNu8qb3xhh0vb5DhAWWiXPoodSjwa
         2u14YbwkfpGQ28QifLiO4FuvryBNrYWsJiFfNnoeDLFASE6c7u7y/9kZ9ecRtFQMqfsO
         g0ZQ==
X-Gm-Message-State: AOAM530NHNtrwxhlrfITRlrAxFKlzaNkEP3K8tkFjZV3ZZXK9F9+ilFu
        0VfHokb0a7BgAity2SxyrO6y8JQmWgcaa8Bw4Khq/FqAkCTANOGO
X-Google-Smtp-Source: ABdhPJwhonkJ6PSgNpBNOERDXzczWFwVWtNBKh0PKFxqljtEhLx+IgiM8OC2c7zuh4f3oeB/HipxLvVbFYV51CBXm60=
X-Received: by 2002:a9d:785a:: with SMTP id c26mr140036otm.180.1600961070861;
 Thu, 24 Sep 2020 08:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200924065140.726436-1-hch@lst.de> <20200924065140.726436-6-hch@lst.de>
In-Reply-To: <20200924065140.726436-6-hch@lst.de>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 24 Sep 2020 11:24:19 -0400
Message-ID: <CAOg9mSRzpLvydt=eN19z0=PjsLZpiTGO5VMB+nr_ZKTutsG+eA@mail.gmail.com>
Subject: Re: [PATCH 05/13] bdi: initialize ->ra_pages and ->io_pages in bdi_init
To:     Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcapsc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since this patch set will affect orangefs, I was going to apply them to
Linux 5.9-rc6 and run my xfstests, but at least one of the patches
won't apply... I also tried Linux 5.9-rc3 since that's what the
bdi-cleanups branch in git.infradead.org/users/hch/block.git
is based on, but that won't go either...

I guess the patches depend upon some of the other patches
in block.git/bdi-cleanups?

I got the 13 patches with git-format-patch on block.git
rather than scraping them out of my gmail, I think they're
the same?

Anywho... was just going to try and add a helpful(?)
data point...

-Mike

On Thu, Sep 24, 2020 at 2:53 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Set up a readahead size by default, as very few users have a good
> reason to change it.  This means code, ecryptfs, and orangefs now
> set up the values while they were previously missing it, while ubifs,
> mtd and vboxsf manually set it to 0 to avoid readahead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: David Sterba <dsterba@suse.com> [btrfs]
> Acked-by: Richard Weinberger <richard@nod.at> [ubifs, mtd]
> ---
>  block/blk-core.c      | 2 --
>  drivers/mtd/mtdcore.c | 2 ++
>  fs/9p/vfs_super.c     | 6 ++++--
>  fs/afs/super.c        | 1 -
>  fs/btrfs/disk-io.c    | 1 -
>  fs/fuse/inode.c       | 1 -
>  fs/nfs/super.c        | 9 +--------
>  fs/ubifs/super.c      | 2 ++
>  fs/vboxsf/super.c     | 2 ++
>  mm/backing-dev.c      | 2 ++
>  10 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ca3f0f00c9435f..865d39e5be2b28 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -538,8 +538,6 @@ struct request_queue *blk_alloc_queue(int node_id)
>         if (!q->stats)
>                 goto fail_stats;
>
> -       q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
> -       q->backing_dev_info->io_pages = VM_READAHEAD_PAGES;
>         q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
>         q->node = node_id;
>
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 7d930569a7dfb7..b5e5d3140f578e 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -2196,6 +2196,8 @@ static struct backing_dev_info * __init mtd_bdi_init(char *name)
>         bdi = bdi_alloc(NUMA_NO_NODE);
>         if (!bdi)
>                 return ERR_PTR(-ENOMEM);
> +       bdi->ra_pages = 0;
> +       bdi->io_pages = 0;
>
>         /*
>          * We put '-0' suffix to the name to get the same name format as we
> diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
> index 74df32be4c6a52..e34fa20acf612e 100644
> --- a/fs/9p/vfs_super.c
> +++ b/fs/9p/vfs_super.c
> @@ -80,8 +80,10 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
>         if (ret)
>                 return ret;
>
> -       if (v9ses->cache)
> -               sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
> +       if (!v9ses->cache) {
> +               sb->s_bdi->ra_pages = 0;
> +               sb->s_bdi->io_pages = 0;
> +       }
>
>         sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
>         if (!v9ses->cache)
> diff --git a/fs/afs/super.c b/fs/afs/super.c
> index b552357b1d1379..3a40ee752c1e3f 100644
> --- a/fs/afs/super.c
> +++ b/fs/afs/super.c
> @@ -456,7 +456,6 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
>         ret = super_setup_bdi(sb);
>         if (ret)
>                 return ret;
> -       sb->s_bdi->ra_pages     = VM_READAHEAD_PAGES;
>
>         /* allocate the root inode and dentry */
>         if (as->dyn_root) {
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f6bba7eb1fa171..047934cea25efa 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3092,7 +3092,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>         }
>
>         sb->s_bdi->capabilities |= BDI_CAP_CGROUP_WRITEBACK;
> -       sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
>         sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
>         sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index bba747520e9b08..17b00670fb539e 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1049,7 +1049,6 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
>         if (err)
>                 return err;
>
> -       sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
>         /* fuse does it's own writeback accounting */
>         sb->s_bdi->capabilities = BDI_CAP_NO_ACCT_WB | BDI_CAP_STRICTLIMIT;
>
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 7a70287f21a2c1..f943e37853fa25 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1200,13 +1200,6 @@ static void nfs_get_cache_cookie(struct super_block *sb,
>  }
>  #endif
>
> -static void nfs_set_readahead(struct backing_dev_info *bdi,
> -                             unsigned long iomax_pages)
> -{
> -       bdi->ra_pages = VM_READAHEAD_PAGES;
> -       bdi->io_pages = iomax_pages;
> -}
> -
>  int nfs_get_tree_common(struct fs_context *fc)
>  {
>         struct nfs_fs_context *ctx = nfs_fc2context(fc);
> @@ -1251,7 +1244,7 @@ int nfs_get_tree_common(struct fs_context *fc)
>                                              MINOR(server->s_dev));
>                 if (error)
>                         goto error_splat_super;
> -               nfs_set_readahead(s->s_bdi, server->rpages);
> +               s->s_bdi->io_pages = server->rpages;
>                 server->super = s;
>         }
>
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index a2420c900275a8..fbddb2a1c03f5e 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -2177,6 +2177,8 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
>                                    c->vi.vol_id);
>         if (err)
>                 goto out_close;
> +       sb->s_bdi->ra_pages = 0;
> +       sb->s_bdi->io_pages = 0;
>
>         sb->s_fs_info = c;
>         sb->s_magic = UBIFS_SUPER_MAGIC;
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 8fe03b4a0d2b03..8e3792177a8523 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -167,6 +167,8 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>         err = super_setup_bdi_name(sb, "vboxsf-%d", sbi->bdi_id);
>         if (err)
>                 goto fail_free;
> +       sb->s_bdi->ra_pages = 0;
> +       sb->s_bdi->io_pages = 0;
>
>         /* Turn source into a shfl_string and map the folder */
>         size = strlen(fc->source) + 1;
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 8e8b00627bb2d8..2dac3be6127127 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -746,6 +746,8 @@ struct backing_dev_info *bdi_alloc(int node_id)
>                 kfree(bdi);
>                 return NULL;
>         }
> +       bdi->ra_pages = VM_READAHEAD_PAGES;
> +       bdi->io_pages = VM_READAHEAD_PAGES;
>         return bdi;
>  }
>  EXPORT_SYMBOL(bdi_alloc);
> --
> 2.28.0
>
