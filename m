Return-Path: <linux-fsdevel+bounces-33137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 896349B4E43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 309E3B23806
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0131957E9;
	Tue, 29 Oct 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps7Z5Wih"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A370191F7C;
	Tue, 29 Oct 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216442; cv=none; b=t2l2ymFpCbISI6xMmrueRD5B7I9st5Jr3jegiZgr8fr0T8Tf97lJdmGZC3Ew6ds83QwE/0CBeuj7oXWToTfnOzq/nOdN9REXYOazN2nufl3Ac6n0huaAfeENxHH8SYMkXmc7DVxnsgwubv9Gn96wXniqErkDtSwz5XevENOws9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216442; c=relaxed/simple;
	bh=CEolexB7eho5Rkm460bpUXV759CXoSUgqriY4t0+3Kg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=QrsfLfo5v4PEQma0T658RNaKThoxXajABCAtur5UkL4wXZtDo7yYQqzHruUZxFtnMsIHo3JFo4Ct9nRU2uSipvyaM+ppNHODICOblUmLp8PKUR1y4rpGrzIBSUgUio0sscrv1/UTXgjq/3BgsUoGorhJtQx4K5yV897lKqyvmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps7Z5Wih; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-208cf673b8dso52996395ad.3;
        Tue, 29 Oct 2024 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730216438; x=1730821238; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FTLcBN//lW8ntmjtlwuc2hZhu4DBdPyLpRHbp22liyo=;
        b=Ps7Z5WihwtzeKdz6UrKTiDcl263ItUpIgslmeWM7yEUnRKg1odPcSJQBQ0hO9+g3G8
         REVz1CmpF5tdN7xq21dC7U5XHuU1vVYE88/POJq/AG9XQas6770Y3F3pPHky7syBr09J
         mNnxiAWHvQ4DoSfXB7oqB6RUjbqx38cGXBH3zEl6M8X3inLE0+MiAZil6FQXy2iSp/xC
         chXeHsxAbwdhsP9cxBOfVYd+d8Uy2cva7ewyTd9eWjLRa95NiY+PmpIes67dqB7WNE8j
         2iYSiVNEUHGliSDJB7FZaUnvR/SmIy4Wg/KFRy+3kVHC8sagaWAm8hqrq+lK0W9+eQ4W
         k5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730216438; x=1730821238;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTLcBN//lW8ntmjtlwuc2hZhu4DBdPyLpRHbp22liyo=;
        b=l07Y6dtmslaea0ARuSkxC97aEMbtD6DqOtBTVtHrLeqDqY6qMHgSqXyhG94b+LxUUp
         IQJf52hXr2QIgK6EwbooNSi3jNNmW2ZPd9nlYlA76CbKgR/jNYc5i7E5YCtppsglkQKN
         f58B7v+d0UjQcsDYYzXwHhVVq9G1nvqCPy5VBWntSFErMSY1sKU0j+msYTqB1+0iymTd
         1onw3Iop+JDI7pc2LE5qj77nmaiB1HcYDqmwzB1QO7d+mbLKo/kTuD7gJS3mlR9dVP2w
         MAQC+HhnNXe74VZoirWRhS9VBed6MqhMP9D77nGCJN3UV0q928+21UtIXubv3VgwDFUJ
         ZCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUunFeiTLAkioWn7swPEA1eHIJNXugBLlUJr+skLLlR9HmBe0ROvAi2oPnUohw5hBATWhCHRfyLf53Q+SbE@vger.kernel.org, AJvYcCV8X305s7hzvCWAHvGtwjna3dIx8NW/hBcBzRIwY6YZtvw12JCeFbJxcCoTsNaXpdSyKnaTXx7pjHoH+EhRSA==@vger.kernel.org, AJvYcCWWPO/RsonuEpvdKynmZ97oUQKWtV9uhPqlOwMPODHcZV2j8QzSPaSbCcp8xsSqGQFlKAgjRMUq6Yth@vger.kernel.org, AJvYcCXigAQIwa3Za5gqM8455cI+dMPcFsocJ70qu06mKF0nz9PnNYCi7xBhUzs/UUzNkywyQANGPNHimKBG@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQEOMwy4lxJ/u5H+NZsfbQijtlkhdyZbeCC01KCDUaqsvZ0/j
	mXajtsN/TYD0YOIbxrIqfRhW/a6sxbYv/LvzCtI1yBvxj+1FZYFcM6Kiqw==
X-Google-Smtp-Source: AGHT+IGjTJhIS0YZhyEZ+yTyFV0RAq40ukItQgnMzxcCIEKO41JdItHqCJkdv4RvIQ4xkpmcNKpptA==
X-Received: by 2002:a17:903:41cc:b0:20c:8a91:3b43 with SMTP id d9443c01a7336-210c68d4396mr195017495ad.16.1730216438304;
        Tue, 29 Oct 2024 08:40:38 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0863b1sm67836275ad.300.2024.10.29.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:40:37 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ext4: Add statx support for atomic writes
In-Reply-To: <874j4vmf3d.fsf@gmail.com>
Date: Tue, 29 Oct 2024 20:57:31 +0530
Message-ID: <8734kflyjg.fsf@gmail.com>
References: <cover.1729944406.git.ritesh.list@gmail.com> <b61c4a50b4e3b97c4261eb45ea3a24057f54d61a.1729944406.git.ritesh.list@gmail.com> <39b6d2b2-77fd-4087-a495-c36d33b8c9d0@oracle.com> <874j4vmf3d.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Hi John,
>
> John Garry <john.g.garry@oracle.com> writes:
>
>> On 27/10/2024 18:17, Ritesh Harjani (IBM) wrote:
>>> This patch adds base support for atomic writes via statx getattr.
>>> On bs < ps systems, we can create FS with say bs of 16k. That means
>>> both atomic write min and max unit can be set to 16k for supporting
>>> atomic writes.
>>> 
>>> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> ---
>>>   fs/ext4/ext4.h  |  9 +++++++++
>>>   fs/ext4/inode.c | 14 ++++++++++++++
>>>   fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
>>>   3 files changed, 54 insertions(+)
>>> 
>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>> index 44b0d418143c..6ee49aaacd2b 100644
>>> --- a/fs/ext4/ext4.h
>>> +++ b/fs/ext4/ext4.h
>>> @@ -1729,6 +1729,10 @@ struct ext4_sb_info {
>>>   	 */
>>>   	struct work_struct s_sb_upd_work;
>>>   
>>> +	/* Atomic write unit values in bytes */
>>> +	unsigned int s_awu_min;
>>> +	unsigned int s_awu_max;
>>> +
>>>   	/* Ext4 fast commit sub transaction ID */
>>>   	atomic_t s_fc_subtid;
>>>   
>>> @@ -3855,6 +3859,11 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>>>   	return buffer_uptodate(bh);
>>>   }
>>>   
>>> +static inline bool ext4_can_atomic_write(struct super_block *sb)
>>> +{
>>> +	return EXT4_SB(sb)->s_awu_min > 0;
>>> +}
>>> +
>>>   extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>>>   				  loff_t pos, unsigned len,
>>>   				  get_block_t *get_block);
>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>> index 54bdd4884fe6..fcdee27b9aa2 100644
>>> --- a/fs/ext4/inode.c
>>> +++ b/fs/ext4/inode.c
>>> @@ -5578,6 +5578,20 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
>>>   		}
>>>   	}
>>>   
>>> +	if (S_ISREG(inode->i_mode) && (request_mask & STATX_WRITE_ATOMIC)) {
>>> +		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>>> +		unsigned int awu_min, awu_max;
>>> +
>>> +		if (ext4_can_atomic_write(inode->i_sb)) {
>>> +			awu_min = sbi->s_awu_min;
>>> +			awu_max = sbi->s_awu_max;
>>> +		} else {
>>> +			awu_min = awu_max = 0;
>>> +		}
>>> +
>>> +		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
>>> +	}
>>> +
>>>   	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
>>>   	if (flags & EXT4_APPEND_FL)
>>>   		stat->attributes |= STATX_ATTR_APPEND;
>>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>>> index 16a4ce704460..d6e3201a48be 100644
>>> --- a/fs/ext4/super.c
>>> +++ b/fs/ext4/super.c
>>> @@ -4425,6 +4425,36 @@ static int ext4_handle_clustersize(struct super_block *sb)
>>>   	return 0;
>>>   }
>>>   
>>> +/*
>>> + * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
>>> + * @sb: super block
>>> + * TODO: Later add support for bigalloc
>>> + */
>>> +static void ext4_atomic_write_init(struct super_block *sb)
>>> +{
>>> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>>> +	struct block_device *bdev = sb->s_bdev;
>>> +
>>> +	if (!bdev_can_atomic_write(bdev))
>>
>> this check is duplicated, since bdev_atomic_write_unit_{min, 
>> max}_bytes() has this check
>>
>
> Right, yes. I can mention a comment and remove this check perhaps. 
> Looks like XFS also got it duplicated then.
>
>

If we remove above bdev check logic, than we are relying on the min max
comparison in below code to decide whether we support atomic writes or
not. It's rather cleaner and straight forward to check if bdev supports
atomic write in the beginning itself. 

So I feel it's better to keep the above check as is since it's only once
during mount.
(Note - bdev_can_atomic_write() either ways gets called twice when
bdev_atomic_write_unit_min|max_bytes() is getting called).

So I would like to keep the check as is please.


Thanks for the review!
-ritesh

>>> +		return;
>>> +
>>> +	if (!ext4_has_feature_extents(sb))
>>> +		return;
>>> +
>>> +	sbi->s_awu_min = max(sb->s_blocksize,
>>> +			      bdev_atomic_write_unit_min_bytes(bdev));
>>> +	sbi->s_awu_max = min(sb->s_blocksize,
>>> +			      bdev_atomic_write_unit_max_bytes(bdev));
>>> +	if (sbi->s_awu_min && sbi->s_awu_max &&
>>> +	    sbi->s_awu_min <= sbi->s_awu_max) {
>>
>> This looks a bit complicated. I would just follow the XFS example and 
>> ensure bdev_atomic_write_unit_min_bytes() <=  sb->s_blocksize <= 
>> bdev_atomic_write_unit_max_bytes() [which you are doing, but in a 
>> complicated way]
>>
>
> In here we are checking for min and max supported units against fs
> blocksize at one place during mount time itself and then caching the
> supported atomic write unit. The supported atomic write unit can change
> when bigalloc gets introduced. 
>
> XFS caches the blockdevice min, max units and then defers these checks
> against fs blocksize during file open time using xfs_inode_can_atomicwrite(). 
>
> I just preferrd the 1st aproach in case of EXT4 here because it will be simpler
> this way for when bigalloc also gets introduced.
>
> BTW none of these are ondisk changes, so whenever extsize gets
> introduced, we might still have to add something like
> ext4_inode_can_atomic_write() (similar to XFS) based on inode extsize
> value. But for now it was not needed in EXT4. 
>
> I hope the reasoning is clear and make sense.
>
>
>>> +		ext4_msg(sb, KERN_NOTICE, "Supports atomic writes awu_min: %u, awu_max: %u",
>>> +			 sbi->s_awu_min, sbi->s_awu_max);
>
> BTW - I was wondering if we should add "experimental" in above msg.
>
> -ritesh
>
>>> +	} else {
>>> +		sbi->s_awu_min = 0;
>>> +		sbi->s_awu_max = 0;
>>> +	}
>>> +}
>>> +
>>>   static void ext4_fast_commit_init(struct super_block *sb)
>>>   {
>>>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
>>> @@ -5336,6 +5366,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>>>   
>>>   	spin_lock_init(&sbi->s_bdev_wb_lock);
>>>   
>>> +	ext4_atomic_write_init(sb);
>>>   	ext4_fast_commit_init(sb);
>>>   
>>>   	sb->s_root = NULL;

