Return-Path: <linux-fsdevel+bounces-33110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5357E9B4642
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 10:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1A0B224FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA66A206944;
	Tue, 29 Oct 2024 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVZyy4lp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956F206060;
	Tue, 29 Oct 2024 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195768; cv=none; b=dilsaDtvBTJjujqlYvZ6npH1YDU//sAKe5B4unqfGuPKBJJumuh96NJSi0CIBaB6sB/+1/4mqpCbWMiWdJWxxDmVnzsxi7tiilmjxoVjxKk7Joe3VCc25iPuteMjRtqnsIIMY2RpRaOO6cxYepWz0Mz5rUG07BbSB2+1ASxBS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195768; c=relaxed/simple;
	bh=0qDi2xdK9Bl+aoU7bwhI+pp2VgVckudI2/bhOQR1Sac=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Ds3nL4B+6AD8cwVCzLxQjuTzDW/0LxC3v8ZaVmGu7gkBiAPDZWK9P87dHyr+oA5EyhceDYbwC44ig2TqLiGsgrZnDYnPNbFHOSeX277GtwXnDTMIZRxmf4bRvuCAAiJhWXjrMfmE5jy/oi3rFY/QIQUSVzaz26BCbBmt1gHe1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVZyy4lp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso3690573a12.3;
        Tue, 29 Oct 2024 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730195764; x=1730800564; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DiWvjOpVYfndALHTKNu3Vi9x1DoeaRp1k+8XzRgyG6s=;
        b=IVZyy4lpVpUX7bCSiaVHuwm/n19xRvPjUeAyzkOvjbGRHS6LetNQq8dd80KNMN7BS3
         Qj4aCVDdgi+mdGZkxhv5UhTSbMjDtmm+VgJcNIjNWw2C8cEMSiE/ndgeN8U2taMMr6Mv
         p+B11w0hdFNmsKWnH0tiQ1rHWOl4ns7qHR0roQdHcs24+ipxGPEABnjocU/qKLBSx5Lt
         3c46sIjQG/Bd9QVPCy2BxHE7696GOy7cf1M9ZM7aa4XzXv3PG/U3SyZ3eHgda/72MzMh
         bVRCnS6JRvcwJq+hMcn9RiQvJDhTA58j8Tar0HjMBOBAAnwijvV0iMN0EAywa0t+WWEz
         kqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730195764; x=1730800564;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DiWvjOpVYfndALHTKNu3Vi9x1DoeaRp1k+8XzRgyG6s=;
        b=YcnSLGSaj74vQolUCbkB80GLw9wz2p+ERpFIwQp1j6cfuHr51vUWh69xPyt2YliJul
         173IsVbVXshRoMDPkubKTg6anOhmqGb0P9zy8uq+OXIzrNizzDU6O4zNoDlYuGCr0Os8
         GdPTMKtsGbSt8p359XX3PY1p3IbxuaLKTFfziH/VseXHJzmWgNQP4B3gCLUGYD2b7Spu
         dZpHiI1m05lT1/W0nwZ5526p1l0b9/e40wuoM05z7rgtP4zNrOWfU9gBzktEIBihRzi5
         gKvlqrYknWp8nie21uR0XsVTvCRn7RaxDfHmNiXBQgVFGjqUTnI7YDCl2t08wqf9jPeE
         NxZg==
X-Forwarded-Encrypted: i=1; AJvYcCUT3Ndkdz1Wb6jCzfs2xzbfljG0o3ciMchLYFnCh/6/nUWT6okyEBaslNCSBPUArduqbnOYmWYy4kwk@vger.kernel.org, AJvYcCUZRz6rTGgPSHEu7vImpdC/NPkLDjhxsV9eqLg6vCnC6t0Ztq/SiXQi/JibMYTCchewpxe3qCA3dn/QmRrF@vger.kernel.org, AJvYcCVsZSsT5vNxB+W6zAqnRGeUdEEJmF/ap/vwbuVH43Bc8oBFHaD15GzdHsJ9IiUJ4kGArU6KdUBEwyTuNP1ikw==@vger.kernel.org, AJvYcCXqdBE/xVWLEwFz99NYjxCCDW6P/6bIxIUGfHotp/P7XfGlpFIQLDVRA/zeY4c0TSPCnG9YF0+EaFkH@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgIGthbgxZFrbxtfJUzit1pO8OOXwNu27KUCgEpO8eVuLrjvp
	J3p6Kve2Hr6IixQEIAKuoQyGACiX3RvnPSX8WlV5LSM+ReKcX4LNulHrvA==
X-Google-Smtp-Source: AGHT+IF8wKjEF16g/Z6wnKqiitoXbAGxywqBQXr4GKxI/5sWH6101yQQQlpr1QM+yR5VjSo4hSAKDw==
X-Received: by 2002:a17:90b:378c:b0:2e3:b168:70f5 with SMTP id 98e67ed59e1d1-2e8f1080170mr11955324a91.21.1730195764237;
        Tue, 29 Oct 2024 02:56:04 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48e4a2sm11155474a91.2.2024.10.29.02.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 02:56:03 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ext4: Add statx support for atomic writes
In-Reply-To: <39b6d2b2-77fd-4087-a495-c36d33b8c9d0@oracle.com>
Date: Tue, 29 Oct 2024 14:59:58 +0530
Message-ID: <874j4vmf3d.fsf@gmail.com>
References: <cover.1729944406.git.ritesh.list@gmail.com> <b61c4a50b4e3b97c4261eb45ea3a24057f54d61a.1729944406.git.ritesh.list@gmail.com> <39b6d2b2-77fd-4087-a495-c36d33b8c9d0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


Hi John,

John Garry <john.g.garry@oracle.com> writes:

> On 27/10/2024 18:17, Ritesh Harjani (IBM) wrote:
>> This patch adds base support for atomic writes via statx getattr.
>> On bs < ps systems, we can create FS with say bs of 16k. That means
>> both atomic write min and max unit can be set to 16k for supporting
>> atomic writes.
>> 
>> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   fs/ext4/ext4.h  |  9 +++++++++
>>   fs/ext4/inode.c | 14 ++++++++++++++
>>   fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
>>   3 files changed, 54 insertions(+)
>> 
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 44b0d418143c..6ee49aaacd2b 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -1729,6 +1729,10 @@ struct ext4_sb_info {
>>   	 */
>>   	struct work_struct s_sb_upd_work;
>>   
>> +	/* Atomic write unit values in bytes */
>> +	unsigned int s_awu_min;
>> +	unsigned int s_awu_max;
>> +
>>   	/* Ext4 fast commit sub transaction ID */
>>   	atomic_t s_fc_subtid;
>>   
>> @@ -3855,6 +3859,11 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>>   	return buffer_uptodate(bh);
>>   }
>>   
>> +static inline bool ext4_can_atomic_write(struct super_block *sb)
>> +{
>> +	return EXT4_SB(sb)->s_awu_min > 0;
>> +}
>> +
>>   extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>>   				  loff_t pos, unsigned len,
>>   				  get_block_t *get_block);
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 54bdd4884fe6..fcdee27b9aa2 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -5578,6 +5578,20 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
>>   		}
>>   	}
>>   
>> +	if (S_ISREG(inode->i_mode) && (request_mask & STATX_WRITE_ATOMIC)) {
>> +		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>> +		unsigned int awu_min, awu_max;
>> +
>> +		if (ext4_can_atomic_write(inode->i_sb)) {
>> +			awu_min = sbi->s_awu_min;
>> +			awu_max = sbi->s_awu_max;
>> +		} else {
>> +			awu_min = awu_max = 0;
>> +		}
>> +
>> +		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
>> +	}
>> +
>>   	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
>>   	if (flags & EXT4_APPEND_FL)
>>   		stat->attributes |= STATX_ATTR_APPEND;
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 16a4ce704460..d6e3201a48be 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -4425,6 +4425,36 @@ static int ext4_handle_clustersize(struct super_block *sb)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
>> + * @sb: super block
>> + * TODO: Later add support for bigalloc
>> + */
>> +static void ext4_atomic_write_init(struct super_block *sb)
>> +{
>> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> +	struct block_device *bdev = sb->s_bdev;
>> +
>> +	if (!bdev_can_atomic_write(bdev))
>
> this check is duplicated, since bdev_atomic_write_unit_{min, 
> max}_bytes() has this check
>

Right, yes. I can mention a comment and remove this check perhaps. 
Looks like XFS also got it duplicated then.


>> +		return;
>> +
>> +	if (!ext4_has_feature_extents(sb))
>> +		return;
>> +
>> +	sbi->s_awu_min = max(sb->s_blocksize,
>> +			      bdev_atomic_write_unit_min_bytes(bdev));
>> +	sbi->s_awu_max = min(sb->s_blocksize,
>> +			      bdev_atomic_write_unit_max_bytes(bdev));
>> +	if (sbi->s_awu_min && sbi->s_awu_max &&
>> +	    sbi->s_awu_min <= sbi->s_awu_max) {
>
> This looks a bit complicated. I would just follow the XFS example and 
> ensure bdev_atomic_write_unit_min_bytes() <=  sb->s_blocksize <= 
> bdev_atomic_write_unit_max_bytes() [which you are doing, but in a 
> complicated way]
>

In here we are checking for min and max supported units against fs
blocksize at one place during mount time itself and then caching the
supported atomic write unit. The supported atomic write unit can change
when bigalloc gets introduced. 

XFS caches the blockdevice min, max units and then defers these checks
against fs blocksize during file open time using xfs_inode_can_atomicwrite(). 

I just preferrd the 1st aproach in case of EXT4 here because it will be simpler
this way for when bigalloc also gets introduced.

BTW none of these are ondisk changes, so whenever extsize gets
introduced, we might still have to add something like
ext4_inode_can_atomic_write() (similar to XFS) based on inode extsize
value. But for now it was not needed in EXT4. 

I hope the reasoning is clear and make sense.


>> +		ext4_msg(sb, KERN_NOTICE, "Supports atomic writes awu_min: %u, awu_max: %u",
>> +			 sbi->s_awu_min, sbi->s_awu_max);

BTW - I was wondering if we should add "experimental" in above msg.

-ritesh

>> +	} else {
>> +		sbi->s_awu_min = 0;
>> +		sbi->s_awu_max = 0;
>> +	}
>> +}
>> +
>>   static void ext4_fast_commit_init(struct super_block *sb)
>>   {
>>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> @@ -5336,6 +5366,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>>   
>>   	spin_lock_init(&sbi->s_bdev_wb_lock);
>>   
>> +	ext4_atomic_write_init(sb);
>>   	ext4_fast_commit_init(sb);
>>   
>>   	sb->s_root = NULL;

