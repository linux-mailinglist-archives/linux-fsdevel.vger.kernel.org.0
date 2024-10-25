Return-Path: <linux-fsdevel+bounces-32907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1D59B0940
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 484B4B23F8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 16:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A2D185E50;
	Fri, 25 Oct 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVLfDdbv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2E17333D;
	Fri, 25 Oct 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872583; cv=none; b=MnEO2XHggvol/XytjMOzBlA77Mmg5lhamnb5qDGCVCnIj7kpDWGHg2so9zcXahaGjPIFynpE/kVkVKNG+lbGPW1XE6YqMozfd/HPlHuYF5o33FN300SUiQjIP4KdcCFcr5Ld6vgTrxbslx4UXZvJbkKMEzwp/he8joP7u05iSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872583; c=relaxed/simple;
	bh=MSN2XEY66f4jBsAT7ndKMBQc3NEOSQBib4x+RE82ioQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8s960DfQchuO3LBa0PPJMrjbWsvbyyounyGadjZsLEI+AWPrJD2ZohC20O86KVzYLpHhCpwUrAqUoKPM+BSzWjlX6Rn2ts9Pj1NEzYewFOPwdfI6r/RMe+Set/jUEfE2ksb0P7YfnN0+yzGhpmdvMuJUl4yPGEilaQyxIWH/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVLfDdbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E91C4CEC3;
	Fri, 25 Oct 2024 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729872583;
	bh=MSN2XEY66f4jBsAT7ndKMBQc3NEOSQBib4x+RE82ioQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVLfDdbvz//coRMXuJCKQp8z8K1FnHrgqCKHX6mR+O+7rGBOivv91o3dBNILvhnaz
	 /SZIHv7q6UaY5p3cmLusqEDCQhloTXJZpjs2e1DsoTEnp/AiRlpve64b2HWIf86wZv
	 pnQAmMyzUfoxRP91Djv7YCgPIIu3zAwS2X5lgjKbRyj1hI6JDk/4mWg5bMzwLTqMj2
	 E3osqnTBnehMbuXpIKGgCSjM2MXsFQKRIbNQscBlcHnPHv+u701L4juuSPFjpcPhhE
	 iX8NCktPET+9QxqPHmEKB13blpUszm3qC3qUuNpvN7T/Jz2tFNVXTeEJ2o8id3l358
	 WlE9ZcgUUa8mw==
Date: Fri, 25 Oct 2024 09:09:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] ext4: Add statx support for atomic writes
Message-ID: <20241025160942.GJ2386201@frogsfrogsfrogs>
References: <cover.1729825985.git.ritesh.list@gmail.com>
 <e6af669b237690491ecff0717039e28e949208c8.1729825985.git.ritesh.list@gmail.com>
 <314835ec-98bf-472c-8be7-0b26e50cfc9b@oracle.com>
 <87y12cmr5o.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y12cmr5o.fsf@gmail.com>

On Fri, Oct 25, 2024 at 03:38:03PM +0530, Ritesh Harjani wrote:
> John Garry <john.g.garry@oracle.com> writes:
> 
> > On 25/10/2024 04:45, Ritesh Harjani (IBM) wrote:
> >> This patch adds base support for atomic writes via statx getattr.
> >> On bs < ps systems, we can create FS with say bs of 16k. That means
> >> both atomic write min and max unit can be set to 16k for supporting
> >> atomic writes.
> >> 
> >> Later patches adds support for bigalloc as well so that ext4 can also
> >> support doing atomic writes for bs = ps systems.
> >> 
> >> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>   fs/ext4/ext4.h  |  7 ++++++-
> >>   fs/ext4/inode.c | 14 ++++++++++++++
> >>   fs/ext4/super.c | 32 ++++++++++++++++++++++++++++++++
> >>   3 files changed, 52 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> >> index 44b0d418143c..a41e56c2c628 100644
> >> --- a/fs/ext4/ext4.h
> >> +++ b/fs/ext4/ext4.h
> >> @@ -1729,6 +1729,10 @@ struct ext4_sb_info {
> >>   	 */
> >>   	struct work_struct s_sb_upd_work;
> >>   
> >> +	/* Atomic write unit values */
> >> +	unsigned int fs_awu_min;
> >> +	unsigned int fs_awu_max;
> >> +
> >>   	/* Ext4 fast commit sub transaction ID */
> >>   	atomic_t s_fc_subtid;
> >>   
> >> @@ -1820,7 +1824,8 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
> >>    */
> >>   enum {
> >>   	EXT4_MF_MNTDIR_SAMPLED,
> >> -	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
> >> +	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
> >> +	EXT4_MF_ATOMIC_WRITE	/* Supports atomic write */
> >
> > Does this flag really buy us much?
> >
> 
> I felt it is cleaner this way than comparing non-zero values of
> fs_awu_min and fs_awu_max.

What does it mean when MF_ATOMIC_WRITE is set and fs_awu_* are zero?
The awu values don't change at runtime, so I think you can save yourself
an atomic test by checking (non-atomically) for awu_min>0.

(I don't know anything about the flags, those came after my time iirc.)

--D

> Now that you pointed at it - Maybe a question for others who might have
> the history of which one to use when - or do we think there is a scope
> of merging the two into just one as a later cleanup?
> 
> I know that s_mount_flags was added for fastcommit and it needed the
> state manipulations to be done in atomic way. Similarly s_ext4_flags
> also was renamed from s_resize_flags for more general purpose use. Both
> of these looks like could be merged isn't it?
> 
> 
> 
> >>   };
> >>   
> >>   static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> >> index 54bdd4884fe6..897c028d5bc9 100644
> >> --- a/fs/ext4/inode.c
> >> +++ b/fs/ext4/inode.c
> >> @@ -5578,6 +5578,20 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
> >>   		}
> >>   	}
> >>   
> >> +	if (S_ISREG(inode->i_mode) && (request_mask & STATX_WRITE_ATOMIC)) {
> >> +		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> >> +		unsigned int awu_min, awu_max;
> >> +
> >> +		if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_ATOMIC_WRITE)) {
> >
> > I'd use ext4_inode_can_atomicwrite() here, similar to what is done for xfs
> >
> 
> Sure since it is inode operation, we can check against ext4_inode_can_atomicwrite().
> 
> 
> >> +			awu_min = sbi->fs_awu_min;
> >> +			awu_max = sbi->fs_awu_max;
> >> +		} else {
> >> +			awu_min = awu_max = 0;
> >> +		}
> >> +
> >> +		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
> >> +	}
> >> +
> >>   	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
> >>   	if (flags & EXT4_APPEND_FL)
> >>   		stat->attributes |= STATX_ATTR_APPEND;
> >> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> >> index 16a4ce704460..f5c075aff060 100644
> >> --- a/fs/ext4/super.c
> >> +++ b/fs/ext4/super.c
> >> @@ -4425,6 +4425,37 @@ static int ext4_handle_clustersize(struct super_block *sb)
> >>   	return 0;
> >>   }
> >>   
> >> +/*
> 

