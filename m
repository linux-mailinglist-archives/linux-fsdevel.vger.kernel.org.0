Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01802F1398
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 11:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfKFKOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 05:14:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:58988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727239AbfKFKOa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:14:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40A73AC8B;
        Wed,  6 Nov 2019 10:14:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7D9481E47E5; Wed,  6 Nov 2019 11:14:28 +0100 (CET)
Date:   Wed, 6 Nov 2019 11:14:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>,
        kernel@pengutronix.de, Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 7/7] ubifs: Add quota support
Message-ID: <20191106101428.GD16085@quack2.suse.cz>
References: <20191106091537.32480-1-s.hauer@pengutronix.de>
 <20191106091537.32480-8-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106091537.32480-8-s.hauer@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 06-11-19 10:15:37, Sascha Hauer wrote:
> This introduces poor man's quota support for UBIFS. Unlike other
> implementations we never store anything on the flash. This has two
> big advantages:
> 
> - No possible regressions with a changed on-disk format
> - no quota files can get out of sync.
> 
> There are downsides as well:
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
> Signed-off-by: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Two small comments from a quick look:

> +/**
> + * ubifs_dqblk_find_next - find the next qid
> + * @c: UBIFS file-system description object
> + * @qid: The qid to look for
> + *
> + * Find the next dqblk entry with a qid that is bigger or equally big than the
> + * given qid. Returns the next dqblk entry if found or NULL if no dqblk exists
> + * with a qid that is at least equally big.
> + */
> +static struct ubifs_dqblk *ubifs_dqblk_find_next(struct ubifs_info *c,
> +						 struct kqid qid)
> +{
> +	struct rb_node *node = c->dqblk_tree[qid.type].rb_node;
> +	struct ubifs_dqblk *next = NULL;
> +
> +	while (node) {
> +		struct ubifs_dqblk *ud = rb_entry(node, struct ubifs_dqblk, rb);
> +
> +		if (qid_eq(qid, ud->kqid))
> +			return ud;
> +
> +		if (qid_lt(qid, ud->kqid)) {
> +			if (!next || qid_lt(ud->kqid, next->kqid))
> +				next = ud;
> +
> +			node = node->rb_left;
> +		} else {
> +			node = node->rb_right;
> +		}
> +	}
> +
> +	return next;
> +}

Why not use rb_next() here? It should do what you need, shouldn't it?


> @@ -435,6 +438,9 @@ static int ubifs_show_options(struct seq_file *s, struct dentry *root)
>  	else if (c->mount_opts.chk_data_crc == 1)
>  		seq_puts(s, ",no_chk_data_crc");
>  
> +	if (c->quota_enable)
> +		seq_puts(s, ",quota");
> +

I'd expect here to see 'usrquota', 'grpquota', 'prjquota' etc. to match
mount options user has used.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
