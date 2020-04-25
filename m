Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163521B83F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 08:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgDYGmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 02:42:08 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:51245 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbgDYGmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 02:42:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TwaVxwH_1587796923;
Received: from 30.5.152.35(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TwaVxwH_1587796923)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 25 Apr 2020 14:42:03 +0800
Subject: Re: [PATCH 1/3] fs: Avoid leaving freed inode on dirty list
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Sandeen <sandeen@sandeen.net>
References: <20200421085445.5731-1-jack@suse.cz>
 <20200421085445.5731-2-jack@suse.cz>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <7ffc64ad-4741-27ca-ba9d-3d23af0a9216@linux.alibaba.com>
Date:   Sat, 25 Apr 2020 14:42:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421085445.5731-2-jack@suse.cz>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi,

> evict() can race with writeback_sb_inodes() and so
> list_empty(&inode->i_io_list) check can race with list_move() from
> redirty_tail() possibly resulting in list_empty() returning false and
                                                     ^^^^^^^^^^^^^^^
                                                     returning true?
if (!list_empty(&inode->i_io_list))
     inode_io_list_del(inode);
so "!list_empty(&inode->i_io_list)" returns false, and will not remove
inode for wb->b_dirty list.
> thus we end up leaving freed inode in wb->b_dirty list leading to
> use-after-free issues.
> 
> Fix the problem by using list_empty_careful() check and add assert that
> inode's i_io_list is empty in clear_inode() to catch the problem earlier
> in the future.
 From list_empty_careful()'s comments, using list_empty_careful() without
synchronization can only be safe if the only activity that can happen to the
list entry is list_del_init(), but list_move() does not use list_del_init().

static inline void list_move(struct list_head *list, struct list_head *head)
{
	__list_del_entry(list);
	list_add(list, head);
}

So I wonder whether list_empty(&inode->i_io_list) check in evict() can race with
list_move() from redirty_tail()?

Regards,
Xiaoguang Wang
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   fs/inode.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 93d9252a00ab..a73c8a7aa71a 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -534,6 +534,7 @@ void clear_inode(struct inode *inode)
>   	BUG_ON(!(inode->i_state & I_FREEING));
>   	BUG_ON(inode->i_state & I_CLEAR);
>   	BUG_ON(!list_empty(&inode->i_wb_list));
> +	BUG_ON(!list_empty(&inode->i_io_list));
>   	/* don't need i_lock here, no concurrent mods to i_state */
>   	inode->i_state = I_FREEING | I_CLEAR;
>   }
> @@ -559,7 +560,13 @@ static void evict(struct inode *inode)
>   	BUG_ON(!(inode->i_state & I_FREEING));
>   	BUG_ON(!list_empty(&inode->i_lru));
>   
> -	if (!list_empty(&inode->i_io_list))
> +	/*
> +	 * We are the only holder of the inode so it cannot be marked dirty.
> +	 * Flusher thread won't start new writeback but there can be still e.g.
> +	 * redirty_tail() running from writeback_sb_inodes(). So we have to be
> +	 * careful to remove inode from dirty/io list in all the cases.
> +	 */
> +	if (!list_empty_careful(&inode->i_io_list))
>   		inode_io_list_del(inode);
>   
>   	inode_sb_list_del(inode);
> 
