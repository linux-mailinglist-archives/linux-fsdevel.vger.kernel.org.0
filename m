Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652C2778812
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 09:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjHKHW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 03:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHKHW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:22:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267DF2738;
        Fri, 11 Aug 2023 00:22:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52327d63d7cso2080895a12.1;
        Fri, 11 Aug 2023 00:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691738543; x=1692343343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2/Dhx2gxR8oOqJPxSFxBD5vVQUgD8IwaDZIY1y0vYw=;
        b=L5gM0ipl2lSZB2bRPWfR1t486fTJPNVqn1iDfXU0vcHrCYOJFTDhW1t4lLVmQG8Ier
         4USCDpY9b3UEHdWHuTu6Pevk+o54W/ZJ2ZpancrJHb2/OpGlz32SSQRzJpHS7YaeDMku
         /+8AQZj/k8v2/5Jp+mDjUAo8w8lph7C5PsG+EJE7qZj3HM+FI6trV7wDSFMWUuRvJyL/
         xisf2Pdo+aHOf5Ejb9EcLM+3Ja3/BE3GaqY2ejWQlTW+XGyZRn71NVddeJp3CtonsFFE
         4E6hahsEGVLBBlKuC9Dn6CX45I2ez6Fb3lXGO3T0Xs0Nq1hiQoF+TlrR08ulJWa/BKPS
         eTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691738543; x=1692343343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2/Dhx2gxR8oOqJPxSFxBD5vVQUgD8IwaDZIY1y0vYw=;
        b=ENMSxKEDkcYvLlw83fwYfYrwkVL2PZ6JL0enKV0oGLkmTyvSzN6sxOS1aoO7pEfrAI
         MrAfDGvmchbf4PHdLjdEqUAqHeUreavlqcMuEYaJIRUVzuaH7x12TxfU+w4qX6AZN/A2
         dpb+aBy/QDnFPGpF51CJmUhepNgc29JtSjuWs6gA4/FgBVGdGj+t3yYAqooX5cBOMfxh
         Zh6ozJJBJ9dxAF00f9l3DUXHaXNj+JVQdQiqAxBGIakyse98nhLFQ7VFzCR+jll7mxtE
         1V7d1eHKpOpGlgOFMdEdGFkeadtE5UiYO4GoQJjt89zcqO1lgxzgCWwRkY7Jr1PG2Dz/
         hFtw==
X-Gm-Message-State: AOJu0YzVD9pvTfuUNGsWdezA1yWoZPBQn6ToMl3cUAPR9hx7vPmHvbr0
        IzdNXhmGM2fwEKY+J8XS4OjODFbDQ1Sj/3Mq3ls=
X-Google-Smtp-Source: AGHT+IG2s9orilCgPW8sIk765KX+5BJ6m6SiVSiSxYQQh82adrY6ayLCcBy68hJy5MkvwlBvUBwZPmoWP9Qz9k1uWP0=
X-Received: by 2002:aa7:dd54:0:b0:522:2711:863 with SMTP id
 o20-20020aa7dd54000000b0052227110863mr1141789edw.1.1691738543317; Fri, 11 Aug
 2023 00:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230811071519.1094-1-teawaterz@linux.alibaba.com>
In-Reply-To: <20230811071519.1094-1-teawaterz@linux.alibaba.com>
From:   Hui Zhu <teawater@gmail.com>
Date:   Fri, 11 Aug 2023 15:21:46 +0800
Message-ID: <CANFwon18AaMB4iTwC633=WhupfqJjxs0+U0F0MWNynXByDhcZA@mail.gmail.com>
Subject: Re: [PATCH] ext4_sb_breadahead_unmovable: Change to be no-blocking
To:     Hui Zhu <teawaterz@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, akpm@linux-foundation.org, jack@suse.cz,
        willy@infradead.org, yi.zhang@huawei.com, hare@suse.de,
        p.raghav@samsung.com, ritesh.list@gmail.com, mpatocka@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, teawater@antgroup.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oops, this is the version 2 of the patch.

Best,
Hui

Hui Zhu <teawaterz@linux.alibaba.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=BA=94 15:15=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Hui Zhu <teawater@antgroup.com>
>
> This version fix the gfp flags in the callers instead of working this
> new "bool" flag through the buffer head layers according to the comments
> from Matthew Wilcox.
>
> Encountered an issue where a large number of filesystem reads and writes
> occurred suddenly within a container.  At the same time, other tasks on
> the same host that were performing filesystem read and write operations
> became blocked.  It was observed that many of the blocked tasks were
> blocked on the ext4 journal lock. For example:
> PID: 171453 TASK: ffff926566c9440 CPU: 54 COMMAND: "Thread"
> 0 [] __schedule at xxxxxxxxxxxxxxx
> 1 [] schedule at xxxxxxxxxxxxxxx
> 2 [] wait_transaction_locked at xxxxxxxxxxxxxxx
> 3 [] add_transaction_credits at xxxxxxxxxxxxxxx
> 4 [] start_this_handle at xxxxxxxxxxxxxxx
> 5 [] jbd2__journal_start at xxxxxxxxxxxxxxx
> 6 [] ext4_journal_start_sb at xxxxxxxxxxxxxxx
> 7 [] ext4_dirty_inode at xxxxxxxxxxxxxxx
> 8 [] mark_inode_dirty at xxxxxxxxxxxxxxx
> 9 [] generic_update_time at xxxxxxxxxxxxxxx
>
> Meanwhile, it was observed that the task holding the ext4 journal lock
> was blocked for an extended period of time on "shrink_page_list" due to
> "ext4_sb_breadahead_unmovable".
> 0 [] __schedule at xxxxxxxxxxxxxxx
> 1 [] _cond_resched at xxxxxxxxxxxxxxx
> 2 [] shrink_page_list at xxxxxxxxxxxxxxx
> 3 [] shrink_inactive_list at xxxxxxxxxxxxxxx
> 4 [] shrink_lruvec at xxxxxxxxxxxxxxx
> 5 [] shrink_node_memcgs at xxxxxxxxxxxxxxx
> 6 [] shrink_node at xxxxxxxxxxxxxxx
> 7 [] shrink_zones at xxxxxxxxxxxxxxx
> 8 [] do_try_to_free_pages at xxxxxxxxxxxxxxx
> 9 [] try_to_free_mem_cgroup_pages at xxxxxxxxxxxxxxx
> 10 [] try_charge at xxxxxxxxxxxxxxx
> 11 [] mem_cgroup_charge at xxxxxxxxxxxxxxx
> 12 [] __add_to_page_cache_locked at xxxxxxxxxxxxxxx
> 13 [] add_to_page_cache_lru at xxxxxxxxxxxxxxx
> 14 [] pagecache_get_page at xxxxxxxxxxxxxxx
> 15 [] grow_dev_page at xxxxxxxxxxxxxxx
> 16 [] __getblk_slow at xxxxxxxxxxxxxxx
> 17 [] ext4_sb_breadahead_unmovable at xxxxxxxxxxxxxxx
> 18 [] __ext4_get_inode_loc at xxxxxxxxxxxxxxx
> 19 [] ext4_get_inode_loc at xxxxxxxxxxxxxxx
> 20 [] ext4_reserve_inode_write at xxxxxxxxxxxxxxx
> 21 [] __ext4_mark_inode_dirty at xxxxxxxxxxxxxxx
> 22 [] add_dirent_to_buf at xxxxxxxxxxxxxxx
> 23 [] ext4_add_entry at xxxxxxxxxxxxxxx
> 24 [] ext4_add_nondir at xxxxxxxxxxxxxxx
> 25 [] ext4_create at xxxxxxxxxxxxxxx
> 26 [] vfs_create at xxxxxxxxxxxxxxx
>
> The function "grow_dev_page" increased the gfp mask with "__GFP_NOFAIL",
> causing longer blocking times.
>         /*
>          * XXX: __getblk_slow() can not really deal with failure and
>          * will endlessly loop on improvised global reclaim.  Prefer
>          * looping in the allocator rather than here, at least that
>          * code knows what it's doing.
>          */
>         gfp_mask |=3D __GFP_NOFAIL;
> However, "ext4_sb_breadahead_unmovable" is a prefetch function and
> failures are acceptable.
>
> Therefore, this commit changes "ext4_sb_breadahead_unmovable" to be
> non-blocking.
> Change gfp to ~__GFP_DIRECT_RECLAIM when ext4_sb_breadahead_unmovable
> calls sb_getblk_gfp.
> Modify grow_dev_page to will not be blocked by the allocation of folio
> if gfp is ~__GFP_DIRECT_RECLAIM.
>
> Signed-off-by: Hui Zhu <teawater@antgroup.com>
> ---
>  fs/buffer.c     | 27 +++++++++++++++++++--------
>  fs/ext4/super.c |  3 ++-
>  2 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index bd091329026c..330cf19c77b1 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1038,6 +1038,7 @@ static sector_t folio_init_buffers(struct folio *fo=
lio,
>   * Create the page-cache page that contains the requested block.
>   *
>   * This is used purely for blockdev mappings.
> + * Will not blocking by allocate folio if gfp is ~__GFP_DIRECT_RECLAIM.
>   */
>  static int
>  grow_dev_page(struct block_device *bdev, sector_t block,
> @@ -1050,18 +1051,27 @@ grow_dev_page(struct block_device *bdev, sector_t=
 block,
>         int ret =3D 0;
>         gfp_t gfp_mask;
>
> -       gfp_mask =3D mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS) =
| gfp;
> +       gfp_mask =3D mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS);
> +       if (gfp =3D=3D ~__GFP_DIRECT_RECLAIM)
> +               gfp_mask &=3D ~__GFP_DIRECT_RECLAIM;
> +       else {
> +               gfp_mask |=3D gfp;
>
> -       /*
> -        * XXX: __getblk_slow() can not really deal with failure and
> -        * will endlessly loop on improvised global reclaim.  Prefer
> -        * looping in the allocator rather than here, at least that
> -        * code knows what it's doing.
> -        */
> -       gfp_mask |=3D __GFP_NOFAIL;
> +               /*
> +                * XXX: __getblk_slow() can not really deal with failure =
and
> +                * will endlessly loop on improvised global reclaim.  Pre=
fer
> +                * looping in the allocator rather than here, at least th=
at
> +                * code knows what it's doing.
> +                */
> +               gfp_mask |=3D __GFP_NOFAIL;
> +       }
>
>         folio =3D __filemap_get_folio(inode->i_mapping, index,
>                         FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp_mask);
> +       if (IS_ERR(folio)) {
> +               ret =3D PTR_ERR(folio);
> +               goto out;
> +       }
>
>         bh =3D folio_buffers(folio);
>         if (bh) {
> @@ -1091,6 +1101,7 @@ grow_dev_page(struct block_device *bdev, sector_t b=
lock,
>  failed:
>         folio_unlock(folio);
>         folio_put(folio);
> +out:
>         return ret;
>  }
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c94ebf704616..6a529509b83b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -254,7 +254,8 @@ struct buffer_head *ext4_sb_bread_unmovable(struct su=
per_block *sb,
>
>  void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block=
)
>  {
> -       struct buffer_head *bh =3D sb_getblk_gfp(sb, block, 0);
> +       struct buffer_head *bh =3D sb_getblk_gfp(sb, block,
> +                                              ~__GFP_DIRECT_RECLAIM);
>
>         if (likely(bh)) {
>                 if (trylock_buffer(bh))
> --
> 2.19.1.6.gb485710b
>
