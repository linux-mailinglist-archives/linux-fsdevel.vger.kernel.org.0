Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF60D1B5F20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 17:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgDWP1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 11:27:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:56628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgDWP1J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:27:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2B68BABEA;
        Thu, 23 Apr 2020 15:27:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 049761E0E52; Thu, 23 Apr 2020 17:27:07 +0200 (CEST)
Date:   Thu, 23 Apr 2020 17:27:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     tj@kernel.org, linux-fsdevel@vger.kernel.org,
        joseph qi <joseph.qi@linux.alibaba.com>
Subject: Re: Does have race between __mark_inode_dirty() and evict()
Message-ID: <20200423152706.GA28707@quack2.suse.cz>
References: <fdf7f9da-4516-f5c3-c5c9-06a1a3f8e55a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdf7f9da-4516-f5c3-c5c9-06a1a3f8e55a@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Mon 20-04-20 14:23:19, Xiaoguang Wang wrote:
> Recently we run into a NULL pointer dereference panic in our internal 4.9
> kernel it panics because inode->i_wb has become zero in
> wbc_attach_and_unlock_inode(), and by crash tools analysis, inode's
> dirtied_when is zero, but dirtied_time_when is not zero, seems that this
> inode has been used after free. Looking into both 4.9 and upstream codes,
> seems that there maybe a race:
> 
> __mark_inode_dirty(...)
> {
>     spin_lock(&inode->i_lock);
>     ...
>     if (inode->i_state & I_FREEING)
>         goto out_unlock_inode;
>     ...
>     if (!was_dirty) {
>         struct bdi_writeback *wb;
>         struct list_head *dirty_list;
>         bool wakeup_bdi = false;
> 
>         wb = locked_inode_to_wb_and_lock_list(inode);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>        this function will unlock inode->i_ilock firstly and then relock,
>        but once the inode->i_ilock is unlocked, evict() may run in, set
>        I_FREEING flag, and free the inode, and later
>        locked_inode_to_wb_and_lock_list relocks inode->i_ilock again, but
>        will not check the I_FREEING flag again, so the use after free for
>        this inode would happen.

If someone is calling __mark_inode_dirty(), he should be holding inode
reference (either directly or indirectly through having dentry reference,
file open, ...) which prevents the scenario you suggest.

But I've just recently tracked down a very similarly looking issue reported
to me. I've submitted patches to fix it here [1].

[1] https://lore.kernel.org/linux-ext4/20200421085445.5731-1-jack@suse.cz

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
