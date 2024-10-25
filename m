Return-Path: <linux-fsdevel+bounces-32920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E2F9B0C23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140D7B22C5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A22320BB4F;
	Fri, 25 Oct 2024 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxVNGMeO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7389118452E;
	Fri, 25 Oct 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878607; cv=none; b=mDRJkt62KNFwyDrb3o1uFl+hz20J9GeqtH5MWupfuc9HQnRXxOWvpi9gGiUgggjqxoPYpxFf+cpHSModBu1elidVJiB57trNk4OnKKJGXY18WDA/135ds/091hMmsk9K4Svs5zVxX4DSlfZgvlP79+Ug8t+Kr19/uil1ncsDpuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878607; c=relaxed/simple;
	bh=V5FM+c7WNDBvhvHLthI/EB48NAmOrHnLnwoSw/yegAQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=QvIlhxq36WEJb2qd790yWd8v6tACijSAUucfGYTEU5IjTVr9tzk6V1QUkxMJnYU+HS6o0YpGQVV28RiKVZ3WWMzLvDOSKXS7SFFqDN/jBtMPfin3Ue2BBifqX7ACUWmE6JU2FpHwIDKlkKBRHjaaiR1j9kfiWSQmYQpgPuw/09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxVNGMeO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cb7139d9dso19925025ad.1;
        Fri, 25 Oct 2024 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729878604; x=1730483404; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i/KK5QLto1FiOLyb3xhyK+mUwfcmuzgexBLcrS8nrw4=;
        b=MxVNGMeOPI8VdTCq5fosIft7N5AflP7gvnfLcxEqDM+PVymvutXoUV2dYpRJKreZ5/
         BazdcWwWLa5aQk6UHXJZOtmGb79fIu8FGrpA2VyVyJRPiSccRL2Eks8KNsDtZB57rg1q
         sX54VEh2wxfHTRtsy5ke0pLjeuhULX6bs4xzqsY9T8B5e3nj1bIy2+bZ/2MtvoL8UJwh
         t67WGhNRk9HWO++flp0IltxBav1xZdu4v4yecY1GyTGPcDpoB47m+WMtWnmCWAqSeGpP
         frj9xxnCs1xBh+U50cIDkwSCFWTBVw91zIOOjgo14UcxINWupH89Z9c1OEqxuZREGIQq
         jAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729878604; x=1730483404;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/KK5QLto1FiOLyb3xhyK+mUwfcmuzgexBLcrS8nrw4=;
        b=OlYcY99jT2p8rnut/kQHsT6pOAmZV9HaKrnCJ4ZoE5iQz8LTse8wqHHmOKF/nBgu39
         6dhxr4EgiZrboQNpUaj7flgTD+u8g6kyBRM+pqAD5keGvDDC3Dz8lL7WwOwaiueRkKFB
         MX7RpHaGRTEjZfstwqcy/nWgS39tWxt0qZtSlE9NOz2+Cl6HM/tHYu6ANAzolXP5WHYe
         PO0bRXffTjZFDyGz4awll2tR9jUWLYzEDlb2y4FA96HXXXJ8cV1iZuyget85nguq/+rv
         qTzsf9VQhggJKHgj9NTBo/5HiufYH2N9Tka3Vvzs7FRGP0Z1n1fHflticbn1e7bv3veY
         zlQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFgHFpSpOOGAKOpHe/EMtUY8LyDa+qAAoVi7ZKSkN9XXWePpIA4HS4VgDaZn3oa/RxnuxeJIDl8weh@vger.kernel.org, AJvYcCVVSyhQFY6WP/qwDIEbSVbSKVtqEgtjahI8rUXW8XhY/lLoCaf3wrHC1xzbcE6Ix6MfMiZteV0iQj+mvZwNWg==@vger.kernel.org, AJvYcCWnPyQqAtpc/TDVbX3O5Zz2+OFeNlLuVPQ04U4aARNqXc3CZVThOE6jg/5d2rtg5xUH1GMKh8tj6BAd@vger.kernel.org, AJvYcCWtd42OXuqmmOBFGz2BWpKbPCU5CzREI/4ms2OQ8axnUWO13F26QgoouZjnsOrvzubay/+L/F5xXBCfzHJh@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPCOiKcCzr8fTDCSIiXOu6DzgB0Nuf6kgaYVV78SE2MMbWrcF
	SwVmN19qSEmcmEFjLSpbgV3043+T9yFy65OR1J8BKOdy9iKOgIcfQnM1Aw==
X-Google-Smtp-Source: AGHT+IFz7Yp1fLWW/5z7mu1Mw7Lgf0pQOdAc+0Y/WU9QcHDWcwRybp6SR7G3bWK8gWk4dN3ng8nYNA==
X-Received: by 2002:a17:90b:1c10:b0:2e2:cef9:8f68 with SMTP id 98e67ed59e1d1-2e8f1059571mr213139a91.4.1729878604144;
        Fri, 25 Oct 2024 10:50:04 -0700 (PDT)
Received: from dw-tp ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e534f09sm3762668a91.32.2024.10.25.10.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:50:03 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] ext4: Add statx support for atomic writes
In-Reply-To: <20241025160942.GJ2386201@frogsfrogsfrogs>
Date: Fri, 25 Oct 2024 23:15:55 +0530
Message-ID: <87o738m5yk.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <e6af669b237690491ecff0717039e28e949208c8.1729825985.git.ritesh.list@gmail.com> <314835ec-98bf-472c-8be7-0b26e50cfc9b@oracle.com> <87y12cmr5o.fsf@gmail.com> <20241025160942.GJ2386201@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Fri, Oct 25, 2024 at 03:38:03PM +0530, Ritesh Harjani wrote:
>> John Garry <john.g.garry@oracle.com> writes:
>> 
>> > On 25/10/2024 04:45, Ritesh Harjani (IBM) wrote:
>> >> This patch adds base support for atomic writes via statx getattr.
>> >> On bs < ps systems, we can create FS with say bs of 16k. That means
>> >> both atomic write min and max unit can be set to 16k for supporting
>> >> atomic writes.
>> >> 
>> >> Later patches adds support for bigalloc as well so that ext4 can also
>> >> support doing atomic writes for bs = ps systems.
>> >> 
>> >> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> >> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> >> ---
>> >>   fs/ext4/ext4.h  |  7 ++++++-
>> >>   fs/ext4/inode.c | 14 ++++++++++++++
>> >>   fs/ext4/super.c | 32 ++++++++++++++++++++++++++++++++
>> >>   3 files changed, 52 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> >> index 44b0d418143c..a41e56c2c628 100644
>> >> --- a/fs/ext4/ext4.h
>> >> +++ b/fs/ext4/ext4.h
>> >> @@ -1729,6 +1729,10 @@ struct ext4_sb_info {
>> >>   	 */
>> >>   	struct work_struct s_sb_upd_work;
>> >>   
>> >> +	/* Atomic write unit values */
>> >> +	unsigned int fs_awu_min;
>> >> +	unsigned int fs_awu_max;
>> >> +
>> >>   	/* Ext4 fast commit sub transaction ID */
>> >>   	atomic_t s_fc_subtid;
>> >>   
>> >> @@ -1820,7 +1824,8 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
>> >>    */
>> >>   enum {
>> >>   	EXT4_MF_MNTDIR_SAMPLED,
>> >> -	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
>> >> +	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
>> >> +	EXT4_MF_ATOMIC_WRITE	/* Supports atomic write */
>> >
>> > Does this flag really buy us much?
>> >
>> 
>> I felt it is cleaner this way than comparing non-zero values of
>> fs_awu_min and fs_awu_max.
>
> What does it mean when MF_ATOMIC_WRITE is set and fs_awu_* are zero?
> The awu values don't change at runtime, so I think you can save yourself
> an atomic test by checking (non-atomically) for awu_min>0.

Sure. I agree with the reasoning that we can just check for awu_min > 0.
I can write an inline helper for this.

>
> (I don't know anything about the flags, those came after my time iirc.)
>

Thanks for the review :) 

-ritesh

> --D
>
>> Now that you pointed at it - Maybe a question for others who might have
>> the history of which one to use when - or do we think there is a scope
>> of merging the two into just one as a later cleanup?
>> 
>> I know that s_mount_flags was added for fastcommit and it needed the
>> state manipulations to be done in atomic way. Similarly s_ext4_flags
>> also was renamed from s_resize_flags for more general purpose use. Both
>> of these looks like could be merged isn't it?
>> 
>> 
>> 
>> >>   };
>> >>   
>> >>   static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
>> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> >> index 54bdd4884fe6..897c028d5bc9 100644
>> >> --- a/fs/ext4/inode.c
>> >> +++ b/fs/ext4/inode.c
>> >> @@ -5578,6 +5578,20 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
>> >>   		}
>> >>   	}
>> >>   
>> >> +	if (S_ISREG(inode->i_mode) && (request_mask & STATX_WRITE_ATOMIC)) {
>> >> +		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>> >> +		unsigned int awu_min, awu_max;
>> >> +
>> >> +		if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_ATOMIC_WRITE)) {
>> >
>> > I'd use ext4_inode_can_atomicwrite() here, similar to what is done for xfs
>> >
>> 
>> Sure since it is inode operation, we can check against ext4_inode_can_atomicwrite().
>> 
>> 
>> >> +			awu_min = sbi->fs_awu_min;
>> >> +			awu_max = sbi->fs_awu_max;
>> >> +		} else {
>> >> +			awu_min = awu_max = 0;
>> >> +		}
>> >> +
>> >> +		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
>> >> +	}
>> >> +
>> >>   	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
>> >>   	if (flags & EXT4_APPEND_FL)
>> >>   		stat->attributes |= STATX_ATTR_APPEND;
>> >> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> >> index 16a4ce704460..f5c075aff060 100644
>> >> --- a/fs/ext4/super.c
>> >> +++ b/fs/ext4/super.c
>> >> @@ -4425,6 +4425,37 @@ static int ext4_handle_clustersize(struct super_block *sb)
>> >>   	return 0;
>> >>   }
>> >>   
>> >> +/*
>> 

