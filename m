Return-Path: <linux-fsdevel+bounces-33495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF2C9B970A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 19:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B30B21302
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3381CDFD2;
	Fri,  1 Nov 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAcbDBmd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47D1C687;
	Fri,  1 Nov 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484156; cv=none; b=N0ZWn+rZNirn98rldCR2RmKHpvhJJ0k+8ikWE1dgeeTZlgXKPbBbrljbt7y3KtcADmBCI0KUigcaWxO1XPynE4/su6CEjJVDzT0hVRYpmHMYCO8aY/njGp82yOCuRbzhhXWrs6SE1zK7ZuQh6WGfLdsJIJV3MT7DvmKmcMCgh2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484156; c=relaxed/simple;
	bh=FcFVMFA1lnGHpcm6MYuI23U8Olzx2/gJYOuGhGuBujg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=qeIsy3ILRHGxx8eP49o1hsTjJp3Ygt+6EW6JuZL8saPQqt0Ri57OM3y/d9BTSSm9TeHppV6aOYwbVxT18lipszz5HeMJh/fyX1VGj7qPZcrJRHUeMZZwSUKFfaDo8mukdFvs1iPDfVYS1S+oUY/8/BEpeKCjnsxObH1wHOM3Hv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAcbDBmd; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72097a5ca74so1989925b3a.3;
        Fri, 01 Nov 2024 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730484152; x=1731088952; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LhpDgh5o6hmtsMchkNYiiOk/LDTq+HmIoaJTC5fXcFY=;
        b=mAcbDBmdf4HUgklveXPMu/1CQHT5HBNBNmObdgx19Q0ii2j3oXzRKIsb6YKApvBwo8
         pA0x9uAcPhoVGOKt5OWpkCsBHgTi45IdVrpYIcYFCcu8fi4uJdAIbiC6DZDJ66e8TuZZ
         Ubf5p98ZHpsggyBfWE6xjBejzroI4Mnr2C7u9kn622vns50uGv9n5Gzs56ztNibly21R
         I8HweMzLw2qJ8MfxX22erZGVNVEGSBnoJ9CcSHdbivj1yE0g7a8qrW1bMOLbPorvbMuO
         0xoe3hF8azL5XbOH7kSekHTJ8QNPJtsagn5DymCHKAGBuUo4xN9/aJqHJIE5sY97p4Fz
         Xv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484152; x=1731088952;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhpDgh5o6hmtsMchkNYiiOk/LDTq+HmIoaJTC5fXcFY=;
        b=v+zf9Tb5SN05/cUzdgIq9C29KaRGUsSgFHVAEPRIg8Ypc7qdZblFEc4ZOanvpp8LuR
         7Rp7tQCFKNRAurYQPJkmbJ5q/yMuLX2lOBAv8C99IkqaInIOcESc+L5s1n1u8w24rTuY
         OYVy8EqTiIKSe5Yw053LlWaA81lgg3qMOqXPP4bKEwP3d+5NYtdM4VgMr2q3SOWmQ7Pt
         NX61x65zYn2T077nWYQmUrPxyfHV5NVTx7gMyTBHwXWPh7q4TEmVi8g8B5g4WzFAaI4m
         p43y8fMdXsJXj+6FLmgnKbV2aIPC9+EXTnd1NQ+daoF8XhJ2u4pGHQNYB7wujMWfCnVe
         UHlg==
X-Forwarded-Encrypted: i=1; AJvYcCUMue5zw6GWNlUgxA/PeCzGJtUWRsOHChGXVjTSOm7Sp4kML/6gGz1hsrh9RVpE5x+prsUmh1dIT72E@vger.kernel.org, AJvYcCUUTyAZQ6PGEo9Sjnm9AwK0ASiuQvLfe82cekKXNJA+yrxWhJXUvS+r4Gd5bW2AVrpvx4UOcttRW3sc@vger.kernel.org, AJvYcCUYdW5ico8L6BOZzt9hxG+oIfO84rgjL39wGvBlRJu7vCTnzhLx1JSm1hW/1jfPFza9izWmDHB9eglvh/3u@vger.kernel.org, AJvYcCWgVbTIPb+24VqfQLiLmTDFFeWuw16XJKaF9V6/QKL0CrsZ/lI/dCCAFjdAjyTFAdb2useD9MDVoF9C0+8ISQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/kWfzm88X6hASJ5Etin/aQHJaclKRZ2higEr+hAzHEI57K4a
	eu95jRAnFUF/KYW20jzu+Rl6BeDcxmHuqei/JvdZGbOIcYmjQIyx/qMpdw==
X-Google-Smtp-Source: AGHT+IFeCheQNf3wLwjpAi3LuJrAXXy2xOlmbQhIyLvFCcJdSpkKSq4QUMJDDTpgDiiTt2cKk3vpbA==
X-Received: by 2002:a05:6a21:9d83:b0:1d9:a785:6487 with SMTP id adf61e73a8af0-1dba5219700mr4891565637.1.1730484152449;
        Fri, 01 Nov 2024 11:02:32 -0700 (PDT)
Received: from dw-tp ([203.81.243.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ea695sm2923603b3a.73.2024.11.01.11.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 11:02:31 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] ext4: Add statx support for atomic writes
In-Reply-To: <4198772d-54c8-44b9-8e85-0ec089032514@oracle.com>
Date: Fri, 01 Nov 2024 22:53:03 +0530
Message-ID: <8734kazx54.fsf@gmail.com>
References: <cover.1730437365.git.ritesh.list@gmail.com> <0517cef1682fc1f344343c494ac769b963f94199.1730437365.git.ritesh.list@gmail.com> <4198772d-54c8-44b9-8e85-0ec089032514@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 01/11/2024 06:50, Ritesh Harjani (IBM) wrote:
>> This patch adds base support for atomic writes via statx getattr.
>> On bs < ps systems, we can create FS with say bs of 16k. That means
>> both atomic write min and max unit can be set to 16k for supporting
>> atomic writes.
>> 
>> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
> Regardless of nitpicks:
>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
>

Thanks John for the review!

Since as you too mentioned the remaining points are minor and not
critical review comments, I will address them next time in the
multi-fsblock variant. With all other aspects now finalized in this v4
version, this looks ready to be picked up for the merge window. 

-ritesh

>> ---
>>   fs/ext4/ext4.h  | 10 ++++++++++
>>   fs/ext4/inode.c | 12 ++++++++++++
>>   fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
>>   3 files changed, 53 insertions(+)
>> 
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 44b0d418143c..494d443e9fc9 100644
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
>> @@ -3855,6 +3859,12 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>>   	return buffer_uptodate(bh);
>>   }
>>   
>> +static inline bool ext4_inode_can_atomic_write(struct inode *inode)
>> +{
>> +
>
> nit: superfluous blank line
>

Sure.

>> +	return S_ISREG(inode->i_mode) && EXT4_SB(inode->i_sb)->s_awu_min > 0;
>
> I am not sure if the S_ISREG() check is required. Other callers also do 
> the check (like ext4_getattr() for when calling 
> ext4_inode_can_atomic_write()) or don't need it (ext4_file_open()). I 
> say ext4_file_open() doesn't need it as ext4_file_open() is only ever 
> called for regular files, right?
>

Yes. However I believe we might end up using this from other places when
we add support of extsize. So we might need S_ISREG check.
But sure let me re-think on that during the multi-fsblock variant time.

>> +}
>> +
>>   extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>>   				  loff_t pos, unsigned len,
>>   				  get_block_t *get_block);
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 54bdd4884fe6..3e827cfa762e 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -5578,6 +5578,18 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
>>   		}
>>   	}
>>   
>> +	if ((request_mask & STATX_WRITE_ATOMIC) && S_ISREG(inode->i_mode)) {
>
> nit: maybe you could have factored out the S_ISREG() check with 
> STATX_DIOALIGN
>

Sure.

>> +		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>> +		unsigned int awu_min = 0, awu_max = 0;
>> +
>> +		if (ext4_inode_can_atomic_write(inode)) {
>> +			awu_min = sbi->s_awu_min;
>> +			awu_max = sbi->s_awu_max;
>> +		}
>> +
>> +		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
>> +	}
>> +
>>   	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
>>   	if (flags & EXT4_APPEND_FL)
>>   		stat->attributes |= STATX_ATTR_APPEND;
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 16a4ce704460..ebe1660bd840 100644
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

