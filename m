Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A07E340995
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 17:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhCRQEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 12:04:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:38062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhCRQEN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:04:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0501AC1F;
        Thu, 18 Mar 2021 16:04:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A06151F2BBF; Thu, 18 Mar 2021 17:04:11 +0100 (CET)
Date:   Thu, 18 Mar 2021 17:04:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] quota: report warning limits for realtime space quotas
Message-ID: <20210318160411.GB21462@quack2.suse.cz>
References: <20210318041736.GB22094@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318041736.GB22094@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-03-21 21:17:36, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Report the number of warnings that a user will get for exceeding the
> soft limit of a realtime volume.  This plugs a gap needed before we
> can land a realtime quota implementation for XFS in the next cycle.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/quota/quota.c               |    1 +
>  include/uapi/linux/dqblk_xfs.h |    5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 6d16b2be5ac4..6ad06727e8ea 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -471,6 +471,7 @@ static int quota_getstatev(struct super_block *sb, int type,
>  	fqs->qs_rtbtimelimit = state.s_state[type].rt_spc_timelimit;
>  	fqs->qs_bwarnlimit = state.s_state[type].spc_warnlimit;
>  	fqs->qs_iwarnlimit = state.s_state[type].ino_warnlimit;
> +	fqs->qs_rtbwarnlimit = state.s_state[type].rt_spc_warnlimit;
>  
>  	/* Inodes may be allocated even if inactive; copy out if present */
>  	if (state.s_state[USRQUOTA].ino) {
> diff --git a/include/uapi/linux/dqblk_xfs.h b/include/uapi/linux/dqblk_xfs.h
> index c71d909addda..8cda3e62e0e7 100644
> --- a/include/uapi/linux/dqblk_xfs.h
> +++ b/include/uapi/linux/dqblk_xfs.h
> @@ -219,7 +219,10 @@ struct fs_quota_statv {
>  	__s32			qs_rtbtimelimit;/* limit for rt blks timer */
>  	__u16			qs_bwarnlimit;	/* limit for num warnings */
>  	__u16			qs_iwarnlimit;	/* limit for num warnings */
> -	__u64			qs_pad2[8];	/* for future proofing */
> +	__u16			qs_rtbwarnlimit;/* limit for rt blks warnings */
> +	__u16			qs_pad3;
> +	__u32			qs_pad4;
> +	__u64			qs_pad2[7];	/* for future proofing */
>  };
>  
>  #endif	/* _LINUX_DQBLK_XFS_H */
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
