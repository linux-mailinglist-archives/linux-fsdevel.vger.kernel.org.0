Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2192052562A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 22:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358246AbiELUBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 16:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358248AbiELUBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 16:01:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11DA5372B
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 13:00:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 290DF1F45A26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652385658;
        bh=b3+dE4LjEy/hCttgKhBWHIec7JWtqji9E/yvHkJWrhI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=acG1EQAwkwmvpL/2D0/4NzniuKXwjQdOhjxjSVM98cLYgNJHE8vYycXt5RyNgy3JR
         UToXAzn9PPNcn9myH75Ub/vNOlyBlQ9YyXkl+YHueOSpcACig7VC5qRWTe/6gCkjEa
         wUti65sB4HKIBaUvD7f/7ZYF16fprOyX/18T58a7jpG9Uqo925AOzDHCbXmkP5AO4u
         +GGsFa4loDGApKt+EpKIVT8zJhdSsoJ7Jrmutd+xs9p3BpuLPdROopYQien7m87XS+
         RKUvmDMTB7T47wA3QgRTUzxQls7yYlb8sEbNxqfpvnBjJ+HqVtbOBTJ1l44tHgS2xI
         gzgtLRUGtNEkA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Khazhy Kumykov <khazhy@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel@collabora.com,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH v3 0/3] shmem: Allow userspace monitoring of tmpfs for
 lack of space.
Organization: Collabora
References: <20220418213713.273050-1-krisman@collabora.com>
        <20220418204204.0405eda0c506fd29e857e1e4@linux-foundation.org>
        <87h76pay87.fsf@collabora.com>
        <CAOQ4uxhjvwwEQo+u=TD-CJ0xwZ7A1NjkA5GRFOzqG7m1dN1E2Q@mail.gmail.com>
        <CACGdZY+KqPKaW3jM2SN4MA8_SUHSRiA2Dt43Q7NbK7BO2t_FVw@mail.gmail.com>
        <CAOQ4uxiTu1k9ngxquPwxTsEzF72U9jkBs69wjfgRY7E8w4bj4g@mail.gmail.com>
        <87r157n0j2.fsf@collabora.com>
Date:   Thu, 12 May 2022 16:00:55 -0400
In-Reply-To: <87r157n0j2.fsf@collabora.com> (Gabriel Krisman Bertazi's message
        of "Thu, 05 May 2022 17:16:01 -0400")
Message-ID: <87zgjmy0zs.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> Amir Goldstein <amir73il@gmail.com> writes:
>
>>> task a user could easily go from 0% to full, or OOM, rather quickly,
>>> so statfs polling would likely miss the event. The orchestrator can,
>>> when the task fails, easily (and reliably) look at this statistic to
>>> determine if a user exceeded the tmpfs limit.
>>>
>>> (I do see the parallel here to thin provisioned storage - "exceeded
>>> your individual budget" vs. "underlying overcommitted system ran out
>>> of bytes")
>>
>> Right, and in this case, the application gets a different error in case
>> of "underlying space overcommitted", usually EIO, that's why I think that
>> opting-in for this same behavior could make sense for tmpfs.
>
> Amir,
>
> If I understand correctly, that would allow the application to catch the
> lack of memory vs. lack of fs space, but it wouldn't facilitate life for
> an orchestrator trying to detect the condition.  Still it seems like a
> step in the right direction.  For the orchestrator, it seems necessary
> that we expose this is some out-of-band mechanism, a WB_ERROR
> notification or sysfs.

Amir,

Regarding allowing an orchestrator to catch this situation, I'd like to
go back to the original proposal and create a new tmpfs
"thin-provisioned" option that will return a different error code (as
the patch below, that I sent last week) and also issue a special
FAN_FS_ERROR/WB_ERROR to notify the orchestrator of this situation.
This would completely solve the use case, I believe.  Since this is
quite specific to tmpfs, it is reasonable to implement the notification
at FS level, similar to how other FS_ERRORs are implemented.

> As a first step:
>
>>8
> Subject: [PATCH] shmem: Differentiate overcommit failure from lack of fs space
>
> When provisioning user applications in cloud environments, it is common
> to allocate containers with very small tmpfs and little available
> memory.  In such scenarios, it is hard for an application to
> differentiate whether its tmpfs IO failed due do insufficient
> provisioned filesystem space, or due to running out of memory in the
> container, because both situations will return ENOSPC in shmem.
>
> This patch modifies the behavior of shmem failure due to overcommit to
> return EIO instead of ENOSPC in this scenario.  In order to preserve the
> existing interface, this feature must be enabled through a new
> shmem-specific mount option.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  Documentation/filesystems/tmpfs.rst | 16 +++++++++++++++
>  include/linux/shmem_fs.h            |  3 +++
>  mm/shmem.c                          | 30 ++++++++++++++++++++---------
>  3 files changed, 40 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> index 0408c245785e..83278d2b15a3 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -171,6 +171,22 @@ will give you tmpfs instance on /mytmpfs which can allocate 10GB
>  RAM/SWAP in 10240 inodes and it is only accessible by root.
>  
>  
> +When provisioning containerized applications, it is common to allocate
> +the system with a very small tmpfs and little total memory.  In such
> +scenarios, it is sometimes useful for an application to differentiate
> +whether an IO operation failed due to insufficient provisioned
> +filesystem space or due to running out of container memory.  tmpfs
> +includes a mount parameter to treat a memory overcommit limit error
> +differently from a lack of filesystem space error, allowing the
> +application to differentiate these two scenarios.  If the following
> +mount option is specified, surpassing memory overcommit limits on a
> +tmpfs will return EIO.  ENOSPC is then only used to report lack of
> +filesystem space.
> +
> +=================   ===================================================
> +report_overcommit   Report overcommit issues with EIO instead of ENOSPC
> +=================   ===================================================
> +
>  :Author:
>     Christoph Rohland <cr@sap.com>, 1.12.01
>  :Updated:
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index e65b80ed09e7..1be57531b257 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -44,6 +44,9 @@ struct shmem_sb_info {
>  	spinlock_t shrinklist_lock;   /* Protects shrinklist */
>  	struct list_head shrinklist;  /* List of shinkable inodes */
>  	unsigned long shrinklist_len; /* Length of shrinklist */
> +
> +	/* Assist userspace with detecting overcommit errors */
> +	bool report_overcommit;
>  };
>  
>  static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a09b29ec2b45..23f2780678df 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -112,6 +112,7 @@ struct shmem_options {
>  	kgid_t gid;
>  	umode_t mode;
>  	bool full_inums;
> +	bool report_overcommit;
>  	int huge;
>  	int seen;
>  #define SHMEM_SEEN_BLOCKS 1
> @@ -207,13 +208,16 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
>  		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
>  }
>  
> -static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
> +static inline int shmem_inode_acct_block(struct inode *inode, long pages)
>  {
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>  
> -	if (shmem_acct_block(info->flags, pages))
> -		return false;
> +	if (shmem_acct_block(info->flags, pages)) {
> +		if (sbinfo->report_overcommit)
> +			return -EIO;
> +		return -ENOSPC;
> +	}
>  
>  	if (sbinfo->max_blocks) {
>  		if (percpu_counter_compare(&sbinfo->used_blocks,
> @@ -222,11 +226,11 @@ static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
>  		percpu_counter_add(&sbinfo->used_blocks, pages);
>  	}
>  
> -	return true;
> +	return 0;
>  
>  unacct:
>  	shmem_unacct_blocks(info->flags, pages);
> -	return false;
> +	return -ENOSPC;
>  }
>  
>  static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
> @@ -372,7 +376,7 @@ bool shmem_charge(struct inode *inode, long pages)
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	unsigned long flags;
>  
> -	if (!shmem_inode_acct_block(inode, pages))
> +	if (shmem_inode_acct_block(inode, pages))
>  		return false;
>  
>  	/* nrpages adjustment first, then shmem_recalc_inode() when balanced */
> @@ -1555,13 +1559,14 @@ static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct page *page;
>  	int nr;
> -	int err = -ENOSPC;
> +	int err;
>  
>  	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>  		huge = false;
>  	nr = huge ? HPAGE_PMD_NR : 1;
>  
> -	if (!shmem_inode_acct_block(inode, nr))
> +	err = shmem_inode_acct_block(inode, nr);
> +	if (err)
>  		goto failed;
>  
>  	if (huge)
> @@ -2324,7 +2329,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  	int ret;
>  	pgoff_t max_off;
>  
> -	if (!shmem_inode_acct_block(inode, 1)) {
> +	if (shmem_inode_acct_block(inode, 1)) {
>  		/*
>  		 * We may have got a page, returned -ENOENT triggering a retry,
>  		 * and now we find ourselves with -ENOMEM. Release the page, to
> @@ -3301,6 +3306,7 @@ enum shmem_param {
>  	Opt_uid,
>  	Opt_inode32,
>  	Opt_inode64,
> +	Opt_report_overcommit,
>  };
>  
>  static const struct constant_table shmem_param_enums_huge[] = {
> @@ -3322,6 +3328,7 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
>  	fsparam_u32   ("uid",		Opt_uid),
>  	fsparam_flag  ("inode32",	Opt_inode32),
>  	fsparam_flag  ("inode64",	Opt_inode64),
> +	fsparam_flag  ("report_overcommit", Opt_report_overcommit),
>  	{}
>  };
>  
> @@ -3405,6 +3412,9 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->full_inums = true;
>  		ctx->seen |= SHMEM_SEEN_INUMS;
>  		break;
> +	case Opt_report_overcommit:
> +		ctx->report_overcommit = true;
> +		break;
>  	}
>  	return 0;
>  
> @@ -3513,6 +3523,7 @@ static int shmem_reconfigure(struct fs_context *fc)
>  		sbinfo->max_inodes  = ctx->inodes;
>  		sbinfo->free_inodes = ctx->inodes - inodes;
>  	}
> +	sbinfo->report_overcommit = ctx->report_overcommit;
>  
>  	/*
>  	 * Preserve previous mempolicy unless mpol remount option was specified.
> @@ -3640,6 +3651,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sbinfo->mode = ctx->mode;
>  	sbinfo->huge = ctx->huge;
>  	sbinfo->mpol = ctx->mpol;
> +	sbinfo->report_overcommit = ctx->report_overcommit;
>  	ctx->mpol = NULL;
>  
>  	raw_spin_lock_init(&sbinfo->stat_lock);

-- 
Gabriel Krisman Bertazi
