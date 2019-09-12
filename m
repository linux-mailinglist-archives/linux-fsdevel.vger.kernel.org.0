Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C906AB0C3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 12:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfILKGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 06:06:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:60306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730450AbfILKGI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:06:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCF56B634;
        Thu, 12 Sep 2019 10:06:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 79F3F1E47D4; Thu, 12 Sep 2019 12:06:10 +0200 (CEST)
Date:   Thu, 12 Sep 2019 12:06:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jan Kara <jack@suse.com>, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: fix wrong condition in is_quota_modification()
Message-ID: <20190912100610.GA14773@quack2.suse.cz>
References: <20190911093650.35329-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911093650.35329-1-yuchao0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 11-09-19 17:36:50, Chao Yu wrote:
> Quoted from
> commit 3da40c7b0898 ("ext4: only call ext4_truncate when size <= isize")
> 
> " At LSF we decided that if we truncate up from isize we shouldn't trim
>   fallocated blocks that were fallocated with KEEP_SIZE and are past the
>  new i_size.  This patch fixes ext4 to do this. "
> 
> And generic/092 of fstest have covered this case for long time, however
> is_quota_modification() didn't adjust based on that rule, so that in
> below condition, we will lose to quota block change:
> - fallocate blocks beyond EOF
> - remount
> - truncate(file_path, file_size)
> 
> Fix it.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  include/linux/quotaops.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
> index dc905a4ff8d7..bd30acad3a7f 100644
> --- a/include/linux/quotaops.h
> +++ b/include/linux/quotaops.h
> @@ -22,7 +22,7 @@ static inline struct quota_info *sb_dqopt(struct super_block *sb)
>  /* i_mutex must being held */
>  static inline bool is_quota_modification(struct inode *inode, struct iattr *ia)
>  {
> -	return (ia->ia_valid & ATTR_SIZE && ia->ia_size != inode->i_size) ||
> +	return (ia->ia_valid & ATTR_SIZE && ia->ia_size <= inode->i_size) ||
>  		(ia->ia_valid & ATTR_UID && !uid_eq(ia->ia_uid, inode->i_uid)) ||
>  		(ia->ia_valid & ATTR_GID && !gid_eq(ia->ia_gid, inode->i_gid));
>  }

OK, but your change makes i_size extension not to be quota modification
which is IMO wrong. So I think the condition should just be:

	return (ia->ia_valid & ATTR_SIZE) || ...

I'll fix the patch up and pull it into my tree.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
