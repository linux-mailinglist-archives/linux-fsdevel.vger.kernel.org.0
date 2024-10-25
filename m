Return-Path: <linux-fsdevel+bounces-32875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D59889B002B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 12:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B231C224A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA451E47D8;
	Fri, 25 Oct 2024 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEm4Ei+M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29318F2F7;
	Fri, 25 Oct 2024 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852294; cv=none; b=GCovd1HUMVqUZK4bWgbQ52cSCCTJyd/56GQxM2gXM6AzJ+0EmtOn3zUkYJVD3zW5GcOqpsK9s59zoxKNdozDqc5DQNDefx+oqYafZqpp3v/1KdR+K4/NJWEmQYGKF0IyFjd/WQMKI/d195bE9iAuQ1n6xNooC/wY5Wo2uRTQRP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852294; c=relaxed/simple;
	bh=4zV7WJT4ELiuI5eDILdMat1X24qaMlG8dWwZ+Sv55JQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=l71uMXChvNqOuUs8NjpOLsoL+t3pwvoJixS8lQtSv+OtpPw+2xNrIPKlrAS5EzyInLYNBcSCwouc5IAowaqT6fY3b+i7AKBDnhQtBpTLFA97Ze8Yc5ug9Tjh1SsFMnuoDc0qhP5RWt6AexjhFp8rZdqb2OlioH3p4wIdet57QNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEm4Ei+M; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2c6bc4840so1405996a91.2;
        Fri, 25 Oct 2024 03:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729852291; x=1730457091; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M5FWy0HuR7v5dZxwHvlOpN27R8/7jfpqMcRsd5csqOk=;
        b=VEm4Ei+MVc90GVcIcnfLGty3AMDfjPdJEOyLtZOTpVsGt2T+LkHhowor1FmuTClIZl
         msZLs0YfWqB/asEnIBikITRKNl8m6u/FjPMlXFwvqy3oumZJiMB+tU8SQxVldCr8ySP5
         cDHyMmna7nk3stM24sa3bIiD8CFiwMVrixB5TNO5GxDnr/e42PMalKzT4I8JNU90XVXB
         dDr2MOyCCwubWqnEcpmDcAZKn74krCKcmvTGJGS/ANgU7r8+8UYH2PDAqwNE04bzl2fP
         DEZAz8Gxl+ZU0iDIZcoZHmSmpMV4S7yyaDZgehvZCJdw/xZmreFkwYn5Dehq7FjhFW3m
         HGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729852291; x=1730457091;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5FWy0HuR7v5dZxwHvlOpN27R8/7jfpqMcRsd5csqOk=;
        b=lvqNyN1syqu+PF0hzFoNjPYixko4BzBzyZlCp7GK47D2Q+XlHf0xbJ9SPcqgepdgbA
         59V2u7pSBDtuIZsvtTPfAm6RqtMnbyht9le5KGLgLTueb4x4f3EmcPhPSmt9w8ZzODvi
         iJwFeZTg/ZRvYdcWR440CzPrykWMgbwAyf8LfiKPT+GXhiwC/Yu8NtdSffLv/e0pMIyL
         P06iJ5lxpTf6cOMnhTANfs0dZjMweJEGlAkMxQjGvYXDWn6yH4nQe7Azhnle/dHTFW5h
         igiorn8TXZ6lmU4EErh1K+ZIwnX4wY2i8Vvj/bla5kPzKQQc8Z7O3VTnmmAU//k1nScH
         db6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT9XVUCvexpxIxIXtw0TJbIFiItQDCVE+RWHUFruQKYzHQCQrPK1GQZdszJeAbOrBb1zwmH0FvkV3u6XvVFw==@vger.kernel.org, AJvYcCVM0XVUnbxKJdtK7GMbBa2sBx7fCJlm2wVFdwx6bbADz/oRiJ7jukmTTcVeL2IL/iNv+87KzSSfGUgfQGuN@vger.kernel.org, AJvYcCWO2LI8k8Pp3Q5FkkQwqiJe735H2MqsDkWkcrr3YPRZWSfIfq0ytWEYEZpzHHgb6FxLMyX1WSeA5GAL@vger.kernel.org, AJvYcCWvGA63Q27heehhWkqU8FDo8J37BCNvPwAKnSujAeiESMqRx0IHkcfmwmBLFLCVPQ4oF+8tjvHMBijB@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZqhVZNNYypuKdTxabXvO6dwnHD9zxdvroxqw52diMhThJr//
	FFKHPFPd4OI9B1aoJzyuK1TUXcqoem6muPYw9NviFmhR5gOqE0+6p08Ybg==
X-Google-Smtp-Source: AGHT+IHe2Og/h4J/9K7wPAUbvNeMIUE/QeOXAGkhYIaERrZuTxDyFslREse4P/jzV6Q1na4nSSvx/Q==
X-Received: by 2002:a17:90a:9e2:b0:2c9:b72:7a1f with SMTP id 98e67ed59e1d1-2e76b6e21a9mr9885734a91.28.1729852290824;
        Fri, 25 Oct 2024 03:31:30 -0700 (PDT)
Received: from dw-tp ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3572d4esm1075097a91.15.2024.10.25.03.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:31:30 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] ext4: Add statx support for atomic writes
In-Reply-To: <314835ec-98bf-472c-8be7-0b26e50cfc9b@oracle.com>
Date: Fri, 25 Oct 2024 15:38:03 +0530
Message-ID: <87y12cmr5o.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <e6af669b237690491ecff0717039e28e949208c8.1729825985.git.ritesh.list@gmail.com> <314835ec-98bf-472c-8be7-0b26e50cfc9b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 25/10/2024 04:45, Ritesh Harjani (IBM) wrote:
>> This patch adds base support for atomic writes via statx getattr.
>> On bs < ps systems, we can create FS with say bs of 16k. That means
>> both atomic write min and max unit can be set to 16k for supporting
>> atomic writes.
>> 
>> Later patches adds support for bigalloc as well so that ext4 can also
>> support doing atomic writes for bs = ps systems.
>> 
>> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   fs/ext4/ext4.h  |  7 ++++++-
>>   fs/ext4/inode.c | 14 ++++++++++++++
>>   fs/ext4/super.c | 32 ++++++++++++++++++++++++++++++++
>>   3 files changed, 52 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 44b0d418143c..a41e56c2c628 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -1729,6 +1729,10 @@ struct ext4_sb_info {
>>   	 */
>>   	struct work_struct s_sb_upd_work;
>>   
>> +	/* Atomic write unit values */
>> +	unsigned int fs_awu_min;
>> +	unsigned int fs_awu_max;
>> +
>>   	/* Ext4 fast commit sub transaction ID */
>>   	atomic_t s_fc_subtid;
>>   
>> @@ -1820,7 +1824,8 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
>>    */
>>   enum {
>>   	EXT4_MF_MNTDIR_SAMPLED,
>> -	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
>> +	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
>> +	EXT4_MF_ATOMIC_WRITE	/* Supports atomic write */
>
> Does this flag really buy us much?
>

I felt it is cleaner this way than comparing non-zero values of
fs_awu_min and fs_awu_max.


Now that you pointed at it - Maybe a question for others who might have
the history of which one to use when - or do we think there is a scope
of merging the two into just one as a later cleanup?

I know that s_mount_flags was added for fastcommit and it needed the
state manipulations to be done in atomic way. Similarly s_ext4_flags
also was renamed from s_resize_flags for more general purpose use. Both
of these looks like could be merged isn't it?



>>   };
>>   
>>   static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 54bdd4884fe6..897c028d5bc9 100644
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
>> +		if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_ATOMIC_WRITE)) {
>
> I'd use ext4_inode_can_atomicwrite() here, similar to what is done for xfs
>

Sure since it is inode operation, we can check against ext4_inode_can_atomicwrite().


>> +			awu_min = sbi->fs_awu_min;
>> +			awu_max = sbi->fs_awu_max;
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
>> index 16a4ce704460..f5c075aff060 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -4425,6 +4425,37 @@ static int ext4_handle_clustersize(struct super_block *sb)
>>   	return 0;
>>   }
>>   
>> +/*

