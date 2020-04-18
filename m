Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308D71AECBF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgDRNhh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 09:37:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgDRNhh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 09:37:37 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 819EE2076A
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 13:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587217056;
        bh=13G9s0chXDhs/pukP0fqFJs5gVJuoTfj8nP/XBuQjL8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VoOga4i1vNeLrRf/ZQedKzXxLiKkNbMVBETKm6FhQdPwXD3hiKIRY2vyavr34UAJk
         y0ftGzf3x2CA4vAnQemz455nyG/xHf/GvUyqLfI6khlzGTX0eTgskvRO87Z/ZWIuIE
         z3fljRSs8cDeYGzRq1WtEj2km4xqA/DMvffIDB8g=
Received: by mail-ot1-f42.google.com with SMTP id j26so3932287ots.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 06:37:36 -0700 (PDT)
X-Gm-Message-State: AGi0PuaXrVDgHDHjhcrdoOfDawymML7AoCufBwsIQ3PB4HCqSfa2DK51
        gKfa/gcQL/h8UhQu1sQpiRLBC4uaxzb2JL+2vCQ=
X-Google-Smtp-Source: APiQypLj4UzOHbsx+JMSnowTzkngem1zLfrW4+oJU2FDepYyGG5tZgrnTHgDKj75WrS/k1pnOkw/gtpKXuXu0thUcB8=
X-Received: by 2002:a05:6830:1a:: with SMTP id c26mr3057011otp.282.1587217055731;
 Sat, 18 Apr 2020 06:37:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5744:0:0:0:0:0 with HTTP; Sat, 18 Apr 2020 06:37:35
 -0700 (PDT)
In-Reply-To: <CAKYAXd8f_4nodeTf8OHQvXCwzDSfGciw9FSd42dygeYK7A+5qw@mail.gmail.com>
References: <ef3cdac4-9967-a225-fb04-4dbb4c7037a9@sandeen.net>
 <abfc2cdf-0ff1-3334-da03-8fbcc6eda328@sandeen.net> <381e5327-618b-13ab-ebe5-175f99abf7db@sandeen.net>
 <CAKYAXd8f_4nodeTf8OHQvXCwzDSfGciw9FSd42dygeYK7A+5qw@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 18 Apr 2020 22:37:35 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_3_vwO6vaxh-wnNYnF9HrkgooBoU-wNsA_8-jbBpJd2Q@mail.gmail.com>
Message-ID: <CAKYAXd_3_vwO6vaxh-wnNYnF9HrkgooBoU-wNsA_8-jbBpJd2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2 V2] exfat: truncate atimes to 2s granularity
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-04-18 22:03 GMT+09:00, Namjae Jeon <linkinjeon@kernel.org>:
> 2020-04-16 13:11 GMT+09:00, Eric Sandeen <sandeen@sandeen.net>:
> Hi Eric,
>
>> exfat atimes are restricted to only 2s granularity so after
>> we set an atime, round it down to the nearest 2s and set the
>> sub-second component of the timestamp to 0.
> Is there any reason why only atime is truncated with 2s granularity ?
I will directly update description more.
Sorry to bother you!
>
> Thanks.
>>
>> Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
>> ---
>>
>> V2: don't just zero tv_nsec, must also round down tv_sec I think.
>>
>> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
>> index 67d4e46fb810..d67fb8a6f770 100644
>> --- a/fs/exfat/exfat_fs.h
>> +++ b/fs/exfat/exfat_fs.h
>> @@ -507,6 +507,7 @@ void exfat_msg(struct super_block *sb, const char
>> *lv,
>> const char *fmt, ...)
>>  		__printf(3, 4) __cold;
>>  void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64
>> *ts,
>>  		u8 tz, __le16 time, __le16 date, u8 time_ms);
>> +void exfat_truncate_atime(struct timespec64 *ts);
>>  void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64
>> *ts,
>>  		u8 *tz, __le16 *time, __le16 *date, u8 *time_ms);
>>  unsigned short exfat_calc_chksum_2byte(void *data, int len,
>> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
>> index 483f683757aa..4f76764165cf 100644
>> --- a/fs/exfat/file.c
>> +++ b/fs/exfat/file.c
>> @@ -273,6 +273,7 @@ int exfat_getattr(const struct path *path, struct
>> kstat
>> *stat,
>>  	struct exfat_inode_info *ei = EXFAT_I(inode);
>>
>>  	generic_fillattr(inode, stat);
>> +	exfat_truncate_atime(&stat->atime);
>>  	stat->result_mask |= STATX_BTIME;
>>  	stat->btime.tv_sec = ei->i_crtime.tv_sec;
>>  	stat->btime.tv_nsec = ei->i_crtime.tv_nsec;
>> @@ -339,6 +340,7 @@ int exfat_setattr(struct dentry *dentry, struct iattr
>> *attr)
>>  	}
>>
>>  	setattr_copy(inode, attr);
>> +	exfat_truncate_atime(&inode->i_atime);
>>  	mark_inode_dirty(inode);
>>
>>  out:
>> diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
>> index 14a3300848f6..c8b33278d474 100644
>> --- a/fs/exfat/misc.c
>> +++ b/fs/exfat/misc.c
>> @@ -88,7 +88,8 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi,
>> struct timespec64 *ts,
>>  	if (time_ms) {
>>  		ts->tv_sec += time_ms / 100;
>>  		ts->tv_nsec = (time_ms % 100) * 10 * NSEC_PER_MSEC;
>> -	}
>> +	} else
>> +		exfat_truncate_atime(ts);
>>
>>  	if (tz & EXFAT_TZ_VALID)
>>  		/* Adjust timezone to UTC0. */
>> @@ -124,6 +125,13 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi,
>> struct timespec64 *ts,
>>  	*tz = EXFAT_TZ_VALID;
>>  }
>>
>> +/* atime has only a 2-second resolution */
>> +void exfat_truncate_atime(struct timespec64 *ts)
>> +{
>> +	ts->tv_sec = round_down(ts->tv_sec, 2);
>> +	ts->tv_nsec = 0;
>> +}
>> +
>>  unsigned short exfat_calc_chksum_2byte(void *data, int len,
>>  		unsigned short chksum, int type)
>>  {
>> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
>> index a8681d91f569..b72d782568b8 100644
>> --- a/fs/exfat/namei.c
>> +++ b/fs/exfat/namei.c
>> @@ -595,6 +595,7 @@ static int exfat_create(struct inode *dir, struct
>> dentry
>> *dentry, umode_t mode,
>>  	inode_inc_iversion(inode);
>>  	inode->i_mtime = inode->i_atime = inode->i_ctime =
>>  		EXFAT_I(inode)->i_crtime = current_time(inode);
>> +	exfat_truncate_atime(&inode->i_atime);
>>  	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
>>
>>  	d_instantiate(dentry, inode);
>> @@ -854,6 +855,7 @@ static int exfat_unlink(struct inode *dir, struct
>> dentry
>> *dentry)
>>
>>  	inode_inc_iversion(dir);
>>  	dir->i_mtime = dir->i_atime = current_time(dir);
>> +	exfat_truncate_atime(&dir->i_atime);
>>  	if (IS_DIRSYNC(dir))
>>  		exfat_sync_inode(dir);
>>  	else
>> @@ -861,6 +863,7 @@ static int exfat_unlink(struct inode *dir, struct
>> dentry
>> *dentry)
>>
>>  	clear_nlink(inode);
>>  	inode->i_mtime = inode->i_atime = current_time(inode);
>> +	exfat_truncate_atime(&inode->i_atime);
>>  	exfat_unhash_inode(inode);
>>  	exfat_d_version_set(dentry, inode_query_iversion(dir));
>>  unlock:
>> @@ -903,6 +906,7 @@ static int exfat_mkdir(struct inode *dir, struct
>> dentry
>> *dentry, umode_t mode)
>>  	inode_inc_iversion(inode);
>>  	inode->i_mtime = inode->i_atime = inode->i_ctime =
>>  		EXFAT_I(inode)->i_crtime = current_time(inode);
>> +	exfat_truncate_atime(&inode->i_atime);
>>  	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
>>
>>  	d_instantiate(dentry, inode);
>> @@ -1019,6 +1023,7 @@ static int exfat_rmdir(struct inode *dir, struct
>> dentry *dentry)
>>
>>  	inode_inc_iversion(dir);
>>  	dir->i_mtime = dir->i_atime = current_time(dir);
>> +	exfat_truncate_atime(&dir->i_atime);
>>  	if (IS_DIRSYNC(dir))
>>  		exfat_sync_inode(dir);
>>  	else
>> @@ -1027,6 +1032,7 @@ static int exfat_rmdir(struct inode *dir, struct
>> dentry *dentry)
>>
>>  	clear_nlink(inode);
>>  	inode->i_mtime = inode->i_atime = current_time(inode);
>> +	exfat_truncate_atime(&inode->i_atime);
>>  	exfat_unhash_inode(inode);
>>  	exfat_d_version_set(dentry, inode_query_iversion(dir));
>>  unlock:
>> @@ -1387,6 +1393,7 @@ static int exfat_rename(struct inode *old_dir,
>> struct
>> dentry *old_dentry,
>>  	inode_inc_iversion(new_dir);
>>  	new_dir->i_ctime = new_dir->i_mtime = new_dir->i_atime =
>>  		EXFAT_I(new_dir)->i_crtime = current_time(new_dir);
>> +	exfat_truncate_atime(&new_dir->i_atime);
>>  	if (IS_DIRSYNC(new_dir))
>>  		exfat_sync_inode(new_dir);
>>  	else
>> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
>> index 16ed202ef527..aed62cafb0da 100644
>> --- a/fs/exfat/super.c
>> +++ b/fs/exfat/super.c
>> @@ -351,6 +351,7 @@ static int exfat_read_root(struct inode *inode)
>>  	exfat_save_attr(inode, ATTR_SUBDIR);
>>  	inode->i_mtime = inode->i_atime = inode->i_ctime = ei->i_crtime =
>>  		current_time(inode);
>> +	exfat_truncate_atime(&inode->i_atime);
>>  	exfat_cache_init_inode(inode);
>>  	return 0;
>>  }
>>
>>
>
