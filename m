Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E002E0E0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 19:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgLVSAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 13:00:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:39172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbgLVSAC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 13:00:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37BD0ACF1;
        Tue, 22 Dec 2020 17:59:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B56EA1E1364; Tue, 22 Dec 2020 18:59:19 +0100 (CET)
Date:   Tue, 22 Dec 2020 18:59:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yanjun Zhang <zhang.yanjuna@h3c.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: add warning messages for not registered bdi
Message-ID: <20201222175919.GE22832@quack2.suse.cz>
References: <20201217112801.22421-1-zhang.yanjuna@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217112801.22421-1-zhang.yanjuna@h3c.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-12-20 19:28:01, Yanjun Zhang wrote:
> The device name is only printed for the warning case, that bdi is not
> registered detected by the function __mark_inode_dirty. Besides, the
> device name returned by bdi_dev_name may be "(unknown)" in some cases.
> 
> This patch add printed messages about the inode and super block. Once
> trigging this warning, we could make more direct analysis.
> 
> Signed-off-by: Yanjun Zhang <zhang.yanjuna@h3c.com>

Thanks for the patch but I've just sent a patch to remove this warning from
the kernel a few days ago to Linus because it could result in false
positive... So your patch is not needed anymore.

								Honza

> ---
>  fs/fs-writeback.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e6005c78b..825160cf4 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2323,7 +2323,8 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  
>  			WARN((wb->bdi->capabilities & BDI_CAP_WRITEBACK) &&
>  			     !test_bit(WB_registered, &wb->state),
> -			     "bdi-%s not registered\n", bdi_dev_name(wb->bdi));
> +			     "bdi-%s not registered, dirtied inode %lu on %s\n",
> +			     bdi_dev_name(wb->bdi), inode->i_ino, sb->s_id);
>  
>  			inode->dirtied_when = jiffies;
>  			if (dirtytime)
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
