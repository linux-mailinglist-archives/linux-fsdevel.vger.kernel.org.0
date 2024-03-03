Return-Path: <linux-fsdevel+bounces-13396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB74086F699
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 19:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CFE2814F6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528B676C68;
	Sun,  3 Mar 2024 18:52:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA071EB2C;
	Sun,  3 Mar 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.24.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709491946; cv=none; b=A4UA50l0uATlSWGSL32bokp/26sgFQ9dUPX7wTW4DHfATpk5KQGuLk2ESBvulz8QHDCcYrGJyyXAqEgguum5TYohplSo7Xy4YvusGIC8LTkpuw0Uv3XDqK9YzX5ZdUiwvjPFYrAaClOaVRd28c/LviDV9WJCxpzhpp3t0soEX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709491946; c=relaxed/simple;
	bh=BEXKtQcTSH5pL96wieE7s8hzRl6MbWq3psRI7jxDZoI=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Cc:Subject:
	 In-Reply-To:References; b=a8dUBDk+2koYX4Yv/PuQeaDo2rZsVH9o+qLcZ0qM3O3zVUKVQl9xTvlPGwL/2ZHSr2/AiPqiBrOHy7kfM7cFpZ+Cj78OkPwAxEQfgraeqaplRO+KWNnD8Y156NSsjJzlnw+Hs8Ar4icoR51tkuR5N1adhWr7EPeqY9iAAVH/b9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org; spf=pass smtp.mailfrom=stoffel.org; arc=none smtp.client-ip=172.104.24.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoffel.org
Received: from quad.stoffel.org (097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id CF0301E731;
	Sun,  3 Mar 2024 13:52:21 -0500 (EST)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id 81A7BA0257; Sun,  3 Mar 2024 13:52:21 -0500 (EST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <26084.50917.505942.959325@quad.stoffel.home>
Date: Sun, 3 Mar 2024 13:52:21 -0500
From: "John Stoffel" <john@stoffel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Josef Bacik <josef@toxicpanda.com>,
    Miklos Szeredi <mszeredi@redhat.com>,
    Christian Brauner <brauner@kernel.org>,
    David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] statx: stx_vol
In-Reply-To: <20240302220203.623614-1-kent.overstreet@linux.dev>
References: <20240302220203.623614-1-kent.overstreet@linux.dev>
X-Mailer: VM 8.2.0b under 28.2 (x86_64-pc-linux-gnu)

>>>>> "Kent" == Kent Overstreet <kent.overstreet@linux.dev> writes:

> Add a new statx field for (sub)volume identifiers.
> This includes bcachefs support; we'll definitely want btrfs support as
> well.

> Link: https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq/
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: David Howells <dhowells@redhat.com>
> ---
>  fs/bcachefs/fs.c          | 3 +++
>  fs/stat.c                 | 1 +
>  include/linux/stat.h      | 1 +
>  include/uapi/linux/stat.h | 4 +++-
>  4 files changed, 8 insertions(+), 1 deletion(-)

> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 3f073845bbd7..d82f7f3f0670 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -840,6 +840,9 @@ static int bch2_getattr(struct mnt_idmap *idmap,
stat-> blksize	= block_bytes(c);
stat-> blocks	= inode->v.i_blocks;
 
> +	stat->vol	= inode->ei_subvol;
> +	stat->result_mask |= STATX_VOL;
> +
>  	if (request_mask & STATX_BTIME) {
stat-> result_mask |= STATX_BTIME;
stat-> btime = bch2_time_to_timespec(c, inode->ei_inode.bi_otime);
> diff --git a/fs/stat.c b/fs/stat.c
> index 77cdc69eb422..80d5f7502d99 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -658,6 +658,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>  	tmp.stx_mnt_id = stat->mnt_id;
>  	tmp.stx_dio_mem_align = stat->dio_mem_align;
>  	tmp.stx_dio_offset_align = stat->dio_offset_align;
> +	tmp.stx_vol = stat->vol;

So this bugs me that you use subvol and vol sorta interchangeably
here.  Shouldn't it always be 'subvol'?  It's not a seperate volume,
it's a snapshot/whatever that is a part of the parent volume, but
should be treated seperately. 
 
>  	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
>  }
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 52150570d37a..9dc1b493ef1f 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -53,6 +53,7 @@ struct kstat {
>  	u32		dio_mem_align;
>  	u32		dio_offset_align;
>  	u64		change_cookie;
> +	u64		vol;
>  };

Again, should this be subvol? And comments added for what it really means?
 
>  /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 2f2ee82d5517..ae090d67946d 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -126,8 +126,9 @@ struct statx {
>  	__u64	stx_mnt_id;
>  	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>  	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
> +	__u64	stx_vol;	/* Subvolume identifier */

Again, then call it 'stx_subvol' if that's what it is!

>  	/* 0xa0 */
> -	__u64	__spare3[12];	/* Spare space for future expansion */
> +	__u64	__spare3[11];	/* Spare space for future expansion */
>  	/* 0x100 */
>  };
 
> @@ -155,6 +156,7 @@ struct statx {
>  #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
>  #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
>  #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
> +#define STATX_VOL		0x00008000U	/* Want/got stx_vol */
 
>  #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
> -- 
> 2.43.0



