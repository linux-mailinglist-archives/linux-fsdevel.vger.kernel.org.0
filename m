Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609131F0920
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 02:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgFGAdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 20:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbgFGAdE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 20:33:04 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10822076D;
        Sun,  7 Jun 2020 00:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591489983;
        bh=HIuVf6Jp6wixSLdMCHSuH8+lkKzJzX0izXXDDgQlK4s=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=SDcw+jPbzJVBCYb223wJAnjhUhk68/+DY0HScyLs+oe0pehZ6B9YqGueYie01QlIL
         5adLcKH5Ca0Yrc4lCPHOPSax8MtGjPmJEdd/rEb2oQFXtIiv2eLyXf2n3MyWMaqjz2
         8MEfX5HwhQiuAjnGfb4UcxditRYAIjYk0G009Q54=
Received: by mail-oi1-f180.google.com with SMTP id a137so11881102oii.3;
        Sat, 06 Jun 2020 17:33:02 -0700 (PDT)
X-Gm-Message-State: AOAM530sEaFl0dwIy1335E95heWmfrMHN6RNeJ3CtQZaDwbnxcHOqJea
        IDC5+mTDlgKeuYAG8s0U4a5BypOfte73/Je1aGY=
X-Google-Smtp-Source: ABdhPJy5oJe9tiXT/DlDPVQi7zvBeXGBvAyQ9KTjY1yY9DQVousnocdoP9dNKADW8Zq4VjbdnLAglIeDpshOAUSRG5s=
X-Received: by 2002:aca:3c82:: with SMTP id j124mr6428361oia.62.1591489982177;
 Sat, 06 Jun 2020 17:33:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:1d8:0:0:0:0:0 with HTTP; Sat, 6 Jun 2020 17:33:01 -0700 (PDT)
In-Reply-To: <20200604084445.19205-1-kohada.t2@gmail.com>
References: <20200604084445.19205-1-kohada.t2@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 7 Jun 2020 09:33:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-1D4hr_VqPLV7qHD+Grp9sX=A6ThFg-k69xK66t_c3nA@mail.gmail.com>
Message-ID: <CAKYAXd-1D4hr_VqPLV7qHD+Grp9sX=A6ThFg-k69xK66t_c3nA@mail.gmail.com>
Subject: Re: [PATCH 1/3] exfat: add error check when updating dir-entries
To:     Tetsuhiro Kohada <kohada.t2@gmail.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-06-04 17:44 GMT+09:00, Tetsuhiro Kohada <kohada.t2@gmail.com>:
Hi Tetsuhiro,
> Add error check when synchronously updating dir-entries.
> Furthermore, add exfat_update_bhs(). It wait for write completion once
> instead of sector by sector.
This patch can be split into two also ?
>
> Suggested-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
> ---
>  fs/exfat/dir.c      | 15 +++++++++------
>  fs/exfat/exfat_fs.h |  3 ++-
>  fs/exfat/file.c     |  5 ++++-
>  fs/exfat/inode.c    |  8 +++++---
>  fs/exfat/misc.c     | 19 +++++++++++++++++++
>  5 files changed, 39 insertions(+), 11 deletions(-)
>
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index de43534aa299..3eb8386fb5f2 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -602,16 +602,19 @@ void exfat_update_dir_chksum_with_entry_set(struct
> exfat_entry_set_cache *es)
>  	es->modified = true;
>  }
>
> -void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
> +int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
>  {
> -	int i;
> +	int i, err = 0;
>
> -	for (i = 0; i < es->num_bh; i++) {
> -		if (es->modified)
> -			exfat_update_bh(es->sb, es->bh[i], sync);
> -		brelse(es->bh[i]);
> +	if (es->modified) {
> +		set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(es->sb)->s_state);
EXFAT_SB_DIRTY set can be merged into exfat_update_bhs() ?
> +		err = exfat_update_bhs(es->bh, es->num_bh, sync);
>  	}
> +
> +	for (i = 0; i < es->num_bh; i++)
> +		err ? bforget(es->bh[i]):brelse(es->bh[i]);
>  	kfree(es);
> +	return err;
>  }
>
>  static int exfat_walk_fat_chain(struct super_block *sb,
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 595f3117f492..f4fa0e833486 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -462,7 +462,7 @@ struct exfat_dentry *exfat_get_dentry_cached(struct
> exfat_entry_set_cache *es,
>  		int num);
>  struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
>  		struct exfat_chain *p_dir, int entry, unsigned int type);
> -void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync);
> +int exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync);
>  int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain
> *p_dir);
>
>  /* inode.c */
> @@ -515,6 +515,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi,
> struct timespec64 *ts,
>  u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
>  u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);
>  void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int
> sync);
> +int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync);
>  void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
>  		unsigned int size, unsigned char flags);
>  void exfat_chain_dup(struct exfat_chain *dup, struct exfat_chain *ec);
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index fce03f318787..37c8f04c1f8a 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -153,6 +153,7 @@ int __exfat_truncate(struct inode *inode, loff_t
> new_size)
>  		struct timespec64 ts;
>  		struct exfat_dentry *ep, *ep2;
>  		struct exfat_entry_set_cache *es;
> +		int err;
>
>  		es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
>  				ES_ALL_ENTRIES);
> @@ -187,7 +188,9 @@ int __exfat_truncate(struct inode *inode, loff_t
> new_size)
>  		}
>
>  		exfat_update_dir_chksum_with_entry_set(es);
> -		exfat_free_dentry_set(es, inode_needs_sync(inode));
> +		err = exfat_free_dentry_set(es, inode_needs_sync(inode));
> +		if (err)
> +			return err;
>  	}
>
>  	/* cut off from the FAT chain */
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> index ef7cf7a6d187..c0bfd1a586aa 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -77,8 +77,7 @@ static int __exfat_write_inode(struct inode *inode, int
> sync)
>  	ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
>
>  	exfat_update_dir_chksum_with_entry_set(es);
> -	exfat_free_dentry_set(es, sync);
> -	return 0;
> +	return exfat_free_dentry_set(es, sync);
>  }
>
>  int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
> @@ -222,6 +221,7 @@ static int exfat_map_cluster(struct inode *inode,
> unsigned int clu_offset,
>  		if (ei->dir.dir != DIR_DELETED && modified) {
>  			struct exfat_dentry *ep;
>  			struct exfat_entry_set_cache *es;
> +			int err;
>
>  			es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
>  				ES_ALL_ENTRIES);
> @@ -240,7 +240,9 @@ static int exfat_map_cluster(struct inode *inode,
> unsigned int clu_offset,
>  				ep->dentry.stream.valid_size;
>
>  			exfat_update_dir_chksum_with_entry_set(es);
> -			exfat_free_dentry_set(es, inode_needs_sync(inode));
> +			err = exfat_free_dentry_set(es, inode_needs_sync(inode));
> +			if (err)
> +				return err;
>
>  		} /* end of if != DIR_DELETED */
>
> diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
> index 17d41f3d3709..dc34968e99d3 100644
> --- a/fs/exfat/misc.c
> +++ b/fs/exfat/misc.c
> @@ -173,6 +173,25 @@ void exfat_update_bh(struct super_block *sb, struct
> buffer_head *bh, int sync)
>  		sync_dirty_buffer(bh);
>  }
>
> +int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync)
> +{
> +	int i, err = 0;
> +
> +	for (i = 0; i < nr_bhs; i++) {
> +		set_buffer_uptodate(bhs[i]);
> +		mark_buffer_dirty(bhs[i]);
> +		if (sync)
> +			write_dirty_buffer(bhs[i], 0);
> +	}
> +
> +	for (i = 0; i < nr_bhs && sync; i++) {
> +		wait_on_buffer(bhs[i]);
> +		if (!buffer_uptodate(bhs[i]))
> +			err = -EIO;
> +	}
> +	return err;
> +}
> +
>  void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
>  		unsigned int size, unsigned char flags)
>  {
> --
> 2.25.1
>
>
