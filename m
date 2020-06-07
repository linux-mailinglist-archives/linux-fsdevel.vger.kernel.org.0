Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C64B1F091B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 02:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgFGA0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 20:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbgFGA0n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 20:26:43 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 252912076D;
        Sun,  7 Jun 2020 00:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591489602;
        bh=qIUbI5zeE/C1ZTXPggkyBc1fxLlnFwNTP19Che9NOcI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=TmDUl1kGLPqokM3suDBbr9aVx+1V/jNkcm73d1ElCLhsRnleNwz6loQPO42+SPi1o
         n8i1SXxLQ/s2dpuSQKy0CpWBW+hRFXbZJLsIdXnGA/kvlRCE81f5J2Rd50oI9twyiI
         SCzjZsoH+IjCIXGnLza8Uos1NW/AnnsLI7m0baOo=
Received: by mail-ot1-f42.google.com with SMTP id h7so10772772otr.3;
        Sat, 06 Jun 2020 17:26:42 -0700 (PDT)
X-Gm-Message-State: AOAM531LVyQqL9moGn2qB5hXECa58baxHlQVkob4Y8aP0pQAh7lQeBdd
        7b1hX5fjRw6TZDtoMoe8X70LxyG+c0QvvC8W+5s=
X-Google-Smtp-Source: ABdhPJzKjOeavOklLSajpwk7GIiD0xYa37fKrSmh2KOG2dgWyCxNmYR2KdC0PhUxandwKwUo9mEffmFYBtPsKv5RXGc=
X-Received: by 2002:a9d:6c4c:: with SMTP id g12mr12557802otq.114.1591489601311;
 Sat, 06 Jun 2020 17:26:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:1d8:0:0:0:0:0 with HTTP; Sat, 6 Jun 2020 17:26:40 -0700 (PDT)
In-Reply-To: <229ab132-c5f1-051c-27c4-4f962ceff700@gmail.com>
References: <20200604084445.19205-1-kohada.t2@gmail.com> <CGME20200604084534epcas1p281a332cd6d556b5d6c0ae61ec816c5a4@epcas1p2.samsung.com>
 <20200604084445.19205-3-kohada.t2@gmail.com> <000401d63b0b$8664f290$932ed7b0$@samsung.com>
 <229ab132-c5f1-051c-27c4-4f962ceff700@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 7 Jun 2020 09:26:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8SqaMj6e9urqdKWCdaexgAoN78Pzh0NYQ35iRYA=2tiA@mail.gmail.com>
Message-ID: <CAKYAXd8SqaMj6e9urqdKWCdaexgAoN78Pzh0NYQ35iRYA=2tiA@mail.gmail.com>
Subject: Re: [PATCH 3/3] exfat: set EXFAT_SB_DIRTY and VOL_DIRTY at the same timing
To:     Tetsuhiro Kohada <kohada.t2@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-06-06 18:22 GMT+09:00, Tetsuhiro Kohada <kohada.t2@gmail.com>:
> On 2020/06/05 16:32, Namjae Jeon wrote:
>>> Set EXFAT_SB_DIRTY flag in exfat_put_super().
>>>
>>> In some cases, can't clear VOL_DIRTY with 'sync'.
>>> ex:
>>>
>>> VOL_DIRTY is set when rmdir starts, but when non-empty-dir is detected,
>>> return error without setting
>>> EXFAT_SB_DIRTY.
>>> If performe 'sync' in this state, VOL_DIRTY will not be cleared.
>> Good catch.
>>
>> Can you split this patch into two? (Don't set VOL_DIRTY on -ENOTEMPTY and
>> Setting EXFAT_SB_DIRTY is
>> merged into exfat_set_vol_flag). I need to check the second one more.
>
> Can't do that.
>
> exfat_set_vol_flag() is called when rmdir processing begins. When Not-empty
> is detected,
> VOL_DIRTY has already been written and synced to the media.
You can move it before calling exfat_remove_entries().
>
> This sequence is same as other write functions.
> <begin writing function>
>      set VOL_DIRTY (write to the media)
>          preparation/state analysis
>          update bh & set SB_DIRTY
>      clear VOL_DIRTY (cached)
> <end>
>
> SB_DIRTY is set when updating bh.
> However, in some cases SB_DIRTY is not set.
> If SB_DIRTY is not set, exfat_sync_fs() does nothing.
>
> I thought there was a problem with separating VOL_DIRTY and SB_DIRTY.
> So I investigated the timing when these are set. Attach the caller graph.
> The green box is a function that sets SB_DIRTY directly.
> The red box is a function that calls exfat_set_vol_flag() and sets
> VOL_DIRTY.
> VOL_DIRTY is set on all paths before setting SB_DIRTY.
>
> I think VOL_DIRTY and SB_DIRTY should be set at the same time.
> That way, It is not necessary to set SB_DIRTY when updating bh.
>
> <begin writing function>
>      set VOL_DIRTY (actually write on media), and set SB_DIRTY
>          preparation/state analysis
>          update data
>      clear VOL_DIRTY (cached)
> <end>
>
> By doing this, sync is guaranteed if VOL_DIRTY is set by calling
> exfat_set_vol_flag.
>
> This change may still have problems, but it's little better than before, I
> think.
I need to check more if it is the best or there is more better way.

Thanks!
>
> BR
> ---
> Tetsuhiro Kohada <kohada.t2@gmail.com>
>
>
>>
>> Thanks!
>>>
>>> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
>>> ---
>>>   fs/exfat/balloc.c   |  4 ++--
>>>   fs/exfat/dir.c      | 18 ++++++++----------
>>>   fs/exfat/exfat_fs.h |  2 +-
>>>   fs/exfat/fatent.c   |  6 +-----
>>>   fs/exfat/misc.c     |  3 +--
>>>   fs/exfat/namei.c    | 12 ++++++------
>>>   fs/exfat/super.c    |  3 +++
>>>   7 files changed, 22 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c index
>>> 4055eb00ea9b..a987919686c0 100644
>>> --- a/fs/exfat/balloc.c
>>> +++ b/fs/exfat/balloc.c
>>> @@ -158,7 +158,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned
>>> int clu)
>>>   	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
>>>
>>>   	set_bit_le(b, sbi->vol_amap[i]->b_data);
>>> -	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
>>> +	exfat_update_bh(sbi->vol_amap[i], IS_DIRSYNC(inode));
>>>   	return 0;
>>>   }
>>>
>>> @@ -180,7 +180,7 @@ void exfat_clear_bitmap(struct inode *inode, unsigned
>>> int clu)
>>>   	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
>>>
>>>   	clear_bit_le(b, sbi->vol_amap[i]->b_data);
>>> -	exfat_update_bh(sb, sbi->vol_amap[i], IS_DIRSYNC(inode));
>>> +	exfat_update_bh(sbi->vol_amap[i], IS_DIRSYNC(inode));
>>>
>>>   	if (opts->discard) {
>>>   		int ret_discard;
>>> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
>>> 3eb8386fb5f2..96c9a817d928 100644
>>> --- a/fs/exfat/dir.c
>>> +++ b/fs/exfat/dir.c
>>> @@ -468,7 +468,7 @@ int exfat_init_dir_entry(struct inode *inode, struct
>>> exfat_chain *p_dir,
>>>   			&ep->dentry.file.access_date,
>>>   			NULL);
>>>
>>> -	exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
>>> +	exfat_update_bh(bh, IS_DIRSYNC(inode));
>>>   	brelse(bh);
>>>
>>>   	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh, &sector); @@ -478,7
>>> +478,7 @@ int
>>> exfat_init_dir_entry(struct inode *inode, struct exfat_chain *p_dir,
>>>   	exfat_init_stream_entry(ep,
>>>   		(type == TYPE_FILE) ? ALLOC_FAT_CHAIN : ALLOC_NO_FAT_CHAIN,
>>>   		start_clu, size);
>>> -	exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
>>> +	exfat_update_bh(bh, IS_DIRSYNC(inode));
>>>   	brelse(bh);
>>>
>>>   	return 0;
>>> @@ -514,7 +514,7 @@ int exfat_update_dir_chksum(struct inode *inode,
>>> struct exfat_chain *p_dir,
>>>   	}
>>>
>>>   	fep->dentry.file.checksum = cpu_to_le16(chksum);
>>> -	exfat_update_bh(sb, fbh, IS_DIRSYNC(inode));
>>> +	exfat_update_bh(fbh, IS_DIRSYNC(inode));
>>>   release_fbh:
>>>   	brelse(fbh);
>>>   	return ret;
>>> @@ -536,7 +536,7 @@ int exfat_init_ext_entry(struct inode *inode, struct
>>> exfat_chain *p_dir,
>>>   		return -EIO;
>>>
>>>   	ep->dentry.file.num_ext = (unsigned char)(num_entries - 1);
>>> -	exfat_update_bh(sb, bh, sync);
>>> +	exfat_update_bh(bh, sync);
>>>   	brelse(bh);
>>>
>>>   	ep = exfat_get_dentry(sb, p_dir, entry + 1, &bh, &sector); @@ -545,7
>>> +545,7 @@ int
>>> exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
>>>
>>>   	ep->dentry.stream.name_len = p_uniname->name_len;
>>>   	ep->dentry.stream.name_hash = cpu_to_le16(p_uniname->name_hash);
>>> -	exfat_update_bh(sb, bh, sync);
>>> +	exfat_update_bh(bh, sync);
>>>   	brelse(bh);
>>>
>>>   	for (i = EXFAT_FIRST_CLUSTER; i < num_entries; i++) { @@ -554,7 +554,7
>>> @@ int
>>> exfat_init_ext_entry(struct inode *inode, struct exfat_chain *p_dir,
>>>   			return -EIO;
>>>
>>>   		exfat_init_name_entry(ep, uniname);
>>> -		exfat_update_bh(sb, bh, sync);
>>> +		exfat_update_bh(bh, sync);
>>>   		brelse(bh);
>>>   		uniname += EXFAT_FILE_NAME_LEN;
>>>   	}
>>> @@ -578,7 +578,7 @@ int exfat_remove_entries(struct inode *inode, struct
>>> exfat_chain *p_dir,
>>>   			return -EIO;
>>>
>>>   		exfat_set_entry_type(ep, TYPE_DELETED);
>>> -		exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
>>> +		exfat_update_bh(bh, IS_DIRSYNC(inode));
>>>   		brelse(bh);
>>>   	}
>>>
>>> @@ -606,10 +606,8 @@ int exfat_free_dentry_set(struct
>>> exfat_entry_set_cache *es, int sync)  {
>>>   	int i, err = 0;
>>>
>>> -	if (es->modified) {
>>> -		set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(es->sb)->s_state);
>>> +	if (es->modified)
>>>   		err = exfat_update_bhs(es->bh, es->num_bh, sync);
>>> -	}
>>>
>>>   	for (i = 0; i < es->num_bh; i++)
>>>   		err ? bforget(es->bh[i]):brelse(es->bh[i]);
>>> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h index
>>> f4fa0e833486..0e094d186612 100644
>>> --- a/fs/exfat/exfat_fs.h
>>> +++ b/fs/exfat/exfat_fs.h
>>> @@ -514,7 +514,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi,
>>> struct timespec64 *ts,
>>>   		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs);
>>>   u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
>>>   u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);
>>> -void exfat_update_bh(struct
>>> super_block *sb, struct buffer_head *bh, int sync);
>>> +void exfat_update_bh(struct buffer_head *bh, int sync);
>>>   int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync);
>>> void exfat_chain_set(struct
>>> exfat_chain *ec, unsigned int dir,
>>>   		unsigned int size, unsigned char flags); diff --git
>>> a/fs/exfat/fatent.c
>>> b/fs/exfat/fatent.c index 5d11bc2f1b68..f8171183b4c1 100644
>>> --- a/fs/exfat/fatent.c
>>> +++ b/fs/exfat/fatent.c
>>> @@ -75,7 +75,7 @@ int exfat_ent_set(struct super_block *sb, unsigned int
>>> loc,
>>>
>>>   	fat_entry = (__le32 *)&(bh->b_data[off]);
>>>   	*fat_entry = cpu_to_le32(content);
>>> -	exfat_update_bh(sb, bh, sb->s_flags & SB_SYNCHRONOUS);
>>> +	exfat_update_bh(bh, sb->s_flags & SB_SYNCHRONOUS);
>>>   	exfat_mirror_bh(sb, sec, bh);
>>>   	brelse(bh);
>>>   	return 0;
>>> @@ -174,7 +174,6 @@ int exfat_free_cluster(struct inode *inode, struct
>>> exfat_chain *p_chain)
>>>   		return -EIO;
>>>   	}
>>>
>>> -	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
>>>   	clu = p_chain->dir;
>>>
>>>   	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) { @@ -261,7 +260,6 @@ int
>>> exfat_zeroed_cluster(struct
>>> inode *dir, unsigned int clu)
>>>   			memset(bhs[n]->b_data, 0, sb->s_blocksize);
>>>   		}
>>>
>>> -		set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
>>>   		err = exfat_update_bhs(bhs, n, IS_DIRSYNC(dir));
>>>   		if (err)
>>>   			goto release_bhs;
>>> @@ -326,8 +324,6 @@ int exfat_alloc_cluster(struct inode *inode, unsigned
>>> int num_alloc,
>>>   		}
>>>   	}
>>>
>>> -	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
>>> -
>>>   	p_chain->dir = EXFAT_EOF_CLUSTER;
>>>
>>>   	while ((new_clu = exfat_find_free_bitmap(sb, hint_clu)) != diff --git
>>> a/fs/exfat/misc.c
>>> b/fs/exfat/misc.c index dc34968e99d3..564718747fb2 100644
>>> --- a/fs/exfat/misc.c
>>> +++ b/fs/exfat/misc.c
>>> @@ -163,9 +163,8 @@ u32 exfat_calc_chksum32(void *data, int len, u32
>>> chksum, int type)
>>>   	return chksum;
>>>   }
>>>
>>> -void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int
>>> sync)
>>> +void exfat_update_bh(struct buffer_head *bh, int sync)
>>>   {
>>> -	set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(sb)->s_state);
>>>   	set_buffer_uptodate(bh);
>>>   	mark_buffer_dirty(bh);
>>>
>>> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c index
>>> 5b0f35329d63..e36c9fc4a5d6 100644
>>> --- a/fs/exfat/namei.c
>>> +++ b/fs/exfat/namei.c
>>> @@ -387,7 +387,7 @@ static int exfat_find_empty_entry(struct inode
>>> *inode,
>>>   			ep->dentry.stream.valid_size = cpu_to_le64(size);
>>>   			ep->dentry.stream.size = ep->dentry.stream.valid_size;
>>>   			ep->dentry.stream.flags = p_dir->flags;
>>> -			exfat_update_bh(sb, bh, IS_DIRSYNC(inode));
>>> +			exfat_update_bh(bh, IS_DIRSYNC(inode));
>>>   			brelse(bh);
>>>   			if (exfat_update_dir_chksum(inode, &(ei->dir),
>>>   			    ei->entry))
>>> @@ -1071,7 +1071,7 @@ static int exfat_rename_file(struct inode *inode,
>>> struct exfat_chain *p_dir,
>>>   			epnew->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
>>>   			ei->attr |= ATTR_ARCHIVE;
>>>   		}
>>> -		exfat_update_bh(sb, new_bh, sync);
>>> +		exfat_update_bh(new_bh, sync);
>>>   		brelse(old_bh);
>>>   		brelse(new_bh);
>>>
>>> @@ -1083,7 +1083,7 @@ static int exfat_rename_file(struct inode *inode,
>>> struct exfat_chain *p_dir,
>>>   			return -EIO;
>>>
>>>   		memcpy(epnew, epold, DENTRY_SIZE);
>>> -		exfat_update_bh(sb, new_bh, sync);
>>> +		exfat_update_bh(new_bh, sync);
>>>   		brelse(old_bh);
>>>   		brelse(new_bh);
>>>
>>> @@ -1100,7 +1100,7 @@ static int exfat_rename_file(struct inode *inode,
>>> struct exfat_chain *p_dir,
>>>   			epold->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
>>>   			ei->attr |= ATTR_ARCHIVE;
>>>   		}
>>> -		exfat_update_bh(sb, old_bh, sync);
>>> +		exfat_update_bh(old_bh, sync);
>>>   		brelse(old_bh);
>>>   		ret = exfat_init_ext_entry(inode, p_dir, oldentry,
>>>   			num_new_entries, p_uniname);
>>> @@ -1155,7 +1155,7 @@ static int exfat_move_file(struct inode *inode,
>>> struct exfat_chain *p_olddir,
>>>   		epnew->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
>>>   		ei->attr |= ATTR_ARCHIVE;
>>>   	}
>>> -	exfat_update_bh(sb, new_bh, IS_DIRSYNC(inode));
>>> +	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
>>>   	brelse(mov_bh);
>>>   	brelse(new_bh);
>>>
>>> @@ -1167,7 +1167,7 @@ static int exfat_move_file(struct inode *inode,
>>> struct exfat_chain *p_olddir,
>>>   		return -EIO;
>>>
>>>   	memcpy(epnew, epmov, DENTRY_SIZE);
>>> -	exfat_update_bh(sb, new_bh, IS_DIRSYNC(inode));
>>> +	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
>>>   	brelse(mov_bh);
>>>   	brelse(new_bh);
>>>
>>> diff --git a/fs/exfat/super.c b/fs/exfat/super.c index
>>> e650e65536f8..199a1e78f9e5 100644
>>> --- a/fs/exfat/super.c
>>> +++ b/fs/exfat/super.c
>>> @@ -104,6 +104,9 @@ int exfat_set_vol_flags(struct super_block *sb,
>>> unsigned short new_flag)
>>>   	struct boot_sector *p_boot = (struct boot_sector
>>> *)sbi->boot_bh->b_data;
>>>   	bool sync;
>>>
>>> +	if (new_flag == VOL_DIRTY)
>>> +		set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
>>> +
>>>   	/* flags are not changed */
>>>   	if (sbi->vol_flag == new_flag)
>>>   		return 0;
>>> --
>>> 2.25.1
>>
>>
>
