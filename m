Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B978E8E9F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 13:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfHOLRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 07:17:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbfHOLRX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:17:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4536AFD4;
        Thu, 15 Aug 2019 11:17:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1A75F1E4200; Thu, 15 Aug 2019 13:17:21 +0200 (CEST)
Date:   Thu, 15 Aug 2019 13:17:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Dongsheng Yang <yangds.fnst@cn.fujitsu.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 11/11] ubifs: Add quota support
Message-ID: <20190815111721.GC14313@quack2.suse.cz>
References: <20190814121834.13983-1-s.hauer@pengutronix.de>
 <20190814121834.13983-12-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814121834.13983-12-s.hauer@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed 14-08-19 14:18:34, Sascha Hauer wrote:
> From: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
> 
> This introduces poor man's quota support for UBIFS. Unlike other
> implementations we never store anything on the flash. This has two
> big advantages:
> 
> - No possible regressions with a changed on-disk format
> - no quota files can get out of sync.
> 
> There are downsides aswell:
> 
> - During mount the whole index must be scanned which takes some time
> - The quota limits must be set manually each time a filesystem is mounted.
> 
> UBIFS is targetted for embedded systems and quota limits are likely not
> changed interactively, so having to restore the quota limits with a
> script shouldn't be a big deal. The mount time penalty is a price we
> must pay, but for that we get a simple and straight forward
> implementation for this rather rarely used feature.
> 
> The quota data itself is stored in a red-black tree in memory. It is
> implemented as a quota format. When enabled with the "quota" mount
> option all three quota types (user, group, project) are enabled.
> 
> The quota integration into UBIFS is taken from a series posted earlier
> by Dongsheng Yang. Like the earlier series we only account regular files
> for quota. All others are counted in the number of files, but do not
> require any quota space.
> 
> iSigned-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Missing Signed-off-by from Dongsheng? Also yours has 'i' there.

> +/**
> + * ubifs_enable_quotas - enable quota
> + * @c: UBIFS file-system description object
> + *
> + * Enable usage tracking for all quota types.
> + */
> +int ubifs_enable_quotas(struct ubifs_info *c)
> +{
> +	struct super_block *sb = c->vfs_sb;
> +	struct quota_info *dqopt = sb_dqopt(sb);
> +	int type;
> +
> +	if (!c->quota_enable)
> +		return 0;
> +
> +	dqopt->flags |= DQUOT_QUOTA_SYS_FILE | DQUOT_NOLIST_DIRTY;
> +
> +	for (type = 0; type < UBIFS_MAXQUOTAS; type++) {
> +		struct mem_dqinfo *info = sb_dqinfo(sb, type);
> +		unsigned int flags = DQUOT_USAGE_ENABLED | DQUOT_LIMITS_ENABLED;
> +
> +		dqopt->flags |= dquot_state_flag(flags, type);
> +		dqopt->info[type].dqi_flags |= DQF_SYS_FILE;
> +		dqopt->ops[type] = &ubifs_format_ops;
> +
> +		info->dqi_max_spc_limit = 0x7fffffffffffffffLL;
> +		info->dqi_max_ino_limit = 0x7fffffffffffffffLL;

This is wrong. You shouldn't mess with quota internals like that. You
should use dquot_enable() (and you even implemented ->read_file_info()
format operation to properly fill in info structure).  So you just need to
change dquot_enable() to cope with situation when inode is NULL. Probably
create a variant dquot_enable_sb() that gets superblock pointer instead of
inode and then factor out bits from vfs_load_quota_inode() that are needed
also for the case without quota inode.

> @@ -956,6 +970,7 @@ static const match_table_t tokens = {
>  	{Opt_ignore, "ubi=%s"},
>  	{Opt_ignore, "vol=%s"},
>  	{Opt_assert, "assert=%s"},
> +	{Opt_quota, "quota"},
>  	{Opt_err, NULL},
>  };

Usually, we have usrquota, grpquota, prjquota mount options to enable
individual quota types. It would seem better not to differ from these
unless you have a good reason.

							Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
