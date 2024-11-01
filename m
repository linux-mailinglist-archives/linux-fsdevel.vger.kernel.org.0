Return-Path: <linux-fsdevel+bounces-33401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD9B9B898F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 04:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2FA1F22664
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 03:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE813EFF3;
	Fri,  1 Nov 2024 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRO5gj/U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633174C79;
	Fri,  1 Nov 2024 03:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730430313; cv=none; b=RYVINlRrcTjns+KWJMn9gVs2fVHUxQ2WSGS6lrBIP/Wv9yVAC7zP4TeYX3KAfXcQC7luPGTJgbj7DFQgq466W44s0EUe5Egm04KyXZcQKQEtLsOR9E7QahIt0o855XGrPxVQQc10E3YFjjr035cTlX34aFuURu0zwEPh6j3FqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730430313; c=relaxed/simple;
	bh=UdhrT4YNWh+UcRqHvTV7LAj61T4pd/9NSbKBQjWqfuE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=nj6dBjPfIlM3KEqsyAtMc1J+Q3LWMEghoG6yMCCtYOEYrs0giav+HitQy3ihotFqHYNxFPjeCz2KcLztzGjHrj0Izy+DaEDBwfH8oksG9vaNZnXvqXPYpbfRZFgMOgGzpgVL+BK9u8IF0cydCENd3FQkg4jdguP0eQ3TLfDKy6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRO5gj/U; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso1249090b3a.3;
        Thu, 31 Oct 2024 20:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730430310; x=1731035110; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w45uyZKrLgmipuvMDWOUJMR9rU31osXEtfFA/wlaiOE=;
        b=YRO5gj/Uww1eDSkNL6KAmtzFRQhm9LO2kxigB7mHiLAQ9WnnZ4XpdIVW5vjdDYQzbI
         9Vgg7Jw7A9z9u7ilaGyKvsUhyqN0RVlPBzeLmLrRGeXtYiJUKxnY5ACmqKnNvgfn5UU6
         eUugfJYa1DSAIQVTLPxyPR5PKO+uKcJJuOmYbVaQgfU41GbvzOxThj+oRyMSgeQclOK/
         3+7Lsq8lOvQM91xJWprR6/tK+uBdWjLMS2GJPuzO+UT3R+bYHnmK0ywN6kMtR8XhdfcM
         fGK3LTkNfhfuLD+iZEwLlgmMfcF9uMBxNkqmFzxbmEtOhJYgg7OZerp4fdwTYwoOSYXI
         fp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730430310; x=1731035110;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w45uyZKrLgmipuvMDWOUJMR9rU31osXEtfFA/wlaiOE=;
        b=IOsBYw2xh6UUPqPsqWmc1vCC35FeCe90NOQnljvDysx2a2Mhgs5Z7aLkOOUpxuL7BU
         IA1IvGXqD5HbSJcQEazR9ILy39/VlGrDyyc/NDlWIIO4GH4Lh88lUK3BrEJu/dejzUbD
         3NRcKeP2OJrCyH++Cy1UvF4498dRvzSJLYr8mGjjd5MELijgVpvlqyyPJkv7QY57dx03
         WxzjFnFxpxQ2/4s7V4YUsGrs3QdPrq34y2ussnEWJ9CcwWb6rkrr3h2O5QwBCh8jSYvB
         gfzvoyvYgRRLSuIMaqAxOwMmd4fT8o910BSY+2Oot+w+or1pBgtzYdJrCc+Akotxdk2O
         xZTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs95md4WDLSiXcO+p5aNN2f86PZ3TenIQDNco+tesfOdmJn1kwrldbIwvvMWnVtQwNT/6FU/g3HlFDvMGV@vger.kernel.org, AJvYcCVWFGYNuGj+QYRATQ7zJ09OOco9sE6GEzC0FVPQwxogl5M/5PlN/rnAC4U+cvmYA82bbCNjr9REaVLr@vger.kernel.org, AJvYcCXlnZ/yaBQa3VEAEOwWNBX4go2ybODkR3q/u+SRjTfHnI5qzw2GXJO0o0My+5c8YZL8wQTOANx+G6uZ1qKG@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/tuwroR6pb2bM4dSZAI3Ho1xFmcF1BNNihg6+1i8z0Y8ppsS
	g8gPLuv5IMu4tUK2+Jo5GLAURgmryBQsWHUQpJ1HKsjaBsGGqa+o/3MBqw==
X-Google-Smtp-Source: AGHT+IFVEyhoWnM9QfiJ5pgVRvXz7o2l9Zpt5D8cTR8zEhpXHqSP5SAEl3x1l73lD1iv4NHbFLVIQQ==
X-Received: by 2002:a05:6a20:b598:b0:1d7:c4a:1cc5 with SMTP id adf61e73a8af0-1dba538e6f3mr2611114637.28.1730430309639;
        Thu, 31 Oct 2024 20:05:09 -0700 (PDT)
Received: from dw-tp ([203.81.243.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c5493sm1845243b3a.115.2024.10.31.20.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 20:05:09 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, John Garry <john.g.garry@oracle.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ext4: Add statx support for atomic writes
In-Reply-To: <20241031214204.GC21832@frogsfrogsfrogs>
Date: Fri, 01 Nov 2024 08:00:35 +0530
Message-ID: <875xp7znw4.fsf@gmail.com>
References: <cover.1730286164.git.ritesh.list@gmail.com> <3338514d98370498d49ebc297a9b6d48a55282b8.1730286164.git.ritesh.list@gmail.com> <20241031214204.GC21832@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


Hi John & Darrick,

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Wed, Oct 30, 2024 at 09:27:38PM +0530, Ritesh Harjani (IBM) wrote:
>> This patch adds base support for atomic writes via statx getattr.
>> On bs < ps systems, we can create FS with say bs of 16k. That means
>> both atomic write min and max unit can be set to 16k for supporting
>> atomic writes.
>> 
>> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/ext4/ext4.h  |  9 +++++++++
>>  fs/ext4/inode.c | 14 ++++++++++++++
>>  fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
>>  3 files changed, 54 insertions(+)
>> 
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 44b0d418143c..6ee49aaacd2b 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -1729,6 +1729,10 @@ struct ext4_sb_info {
>>  	 */
>>  	struct work_struct s_sb_upd_work;
>>  
>> +	/* Atomic write unit values in bytes */
>> +	unsigned int s_awu_min;
>> +	unsigned int s_awu_max;
>> +
>>  	/* Ext4 fast commit sub transaction ID */
>>  	atomic_t s_fc_subtid;
>>  
>> @@ -3855,6 +3859,11 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>>  	return buffer_uptodate(bh);
>>  }
>>  
>> +static inline bool ext4_can_atomic_write(struct super_block *sb)
>> +{
>> +	return EXT4_SB(sb)->s_awu_min > 0;
>
> Huh, I was expecting you to stick to passing in the struct inode,
> and then you end up with:
>
> static inline bool ext4_can_atomic_write(struct inode *inode)
> {
> 	return S_ISREG(inode->i_mode) &&
> 	       EXT4_SB(inode->i_sb)->s_awu_min > 0);
> }
>

Ok. John also had commented on the same thing before. 
We may only need this, when ext4 get extsize hint support. But for now
we mainly only need to check that EXT4 SB supports atomic write or not.
i.e. s_awu_min should be greater than 0. 

But sure I can make above suggested change to keep it consistent with XFS, along
with below discussed change (Please have a look)...

>> +}
>> +
>>  extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>>  				  loff_t pos, unsigned len,
>>  				  get_block_t *get_block);
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 54bdd4884fe6..fcdee27b9aa2 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -5578,6 +5578,20 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
>>  		}
>>  	}
>>  
>> +	if (S_ISREG(inode->i_mode) && (request_mask & STATX_WRITE_ATOMIC)) {
>
> ...and then the callsites become:
>
> 	if (request_mask & STATX_WRITE_ATOMIC) {
> 		unsigned int awu_min = 0, awu_max = 0;
>
> 		if (ext4_can_atomic_write(inode)) {
> 			awu_min = sbi->s_awu_min;
> 			awu_max = sbi->s_awu_max;
> 		}
>
> 		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
> 	}
>
> (I forget, is it bad if statx to a directory returns STATX_WRITE_ATOMIC
> even with awu_{min,max} set to zero?)

I mainly kept it consistent with XFS. But it's not a bad idea to do that. 
That will help applications check for atomic write support on the root
directory mount point rather than creating a regular file just for
verification. Because of below result_mask, which we only set within generic_fill_statx_atomic_writes() 

	stat->result_mask |= STATX_WRITE_ATOMIC;

If we make this change to ext4, XFS will have to fix it too, to keep
the behavior consistent for both.
Shall I go ahead and make the change in v4 for EXT4?

-ritesh

>
> Other than that nit, this looks good to me.
>
> --D
>
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
>>  	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
>>  	if (flags & EXT4_APPEND_FL)
>>  		stat->attributes |= STATX_ATTR_APPEND;
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 16a4ce704460..ebe1660bd840 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -4425,6 +4425,36 @@ static int ext4_handle_clustersize(struct super_block *sb)
>>  	return 0;
>>  }
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
>> +		ext4_msg(sb, KERN_NOTICE, "Supports (experimental) DIO atomic writes awu_min: %u, awu_max: %u",
>> +			 sbi->s_awu_min, sbi->s_awu_max);
>> +	} else {
>> +		sbi->s_awu_min = 0;
>> +		sbi->s_awu_max = 0;
>> +	}
>> +}
>> +
>>  static void ext4_fast_commit_init(struct super_block *sb)
>>  {
>>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> @@ -5336,6 +5366,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>>  
>>  	spin_lock_init(&sbi->s_bdev_wb_lock);
>>  
>> +	ext4_atomic_write_init(sb);
>>  	ext4_fast_commit_init(sb);
>>  
>>  	sb->s_root = NULL;
>> -- 
>> 2.46.0
>> 
>> 

