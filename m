Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1314CC97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 13:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfFTLE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 07:04:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:39158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbfFTLE6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:04:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F7BFAF92;
        Thu, 20 Jun 2019 11:04:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 021901E4241; Thu, 20 Jun 2019 13:04:54 +0200 (CEST)
Date:   Thu, 20 Jun 2019 13:04:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>
Subject: Re: [PATCH 2/3] jbd2: introduce jbd2_inode dirty range scoping
Message-ID: <20190620110454.GL13630@quack2.suse.cz>
References: <20190619172156.105508-1-zwisler@google.com>
 <20190619172156.105508-3-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619172156.105508-3-zwisler@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 19-06-19 11:21:55, Ross Zwisler wrote:
> Currently both journal_submit_inode_data_buffers() and
> journal_finish_inode_data_buffers() operate on the entire address space
> of each of the inodes associated with a given journal entry.  The
> consequence of this is that if we have an inode where we are constantly
> appending dirty pages we can end up waiting for an indefinite amount of
> time in journal_finish_inode_data_buffers() while we wait for all the
> pages under writeback to be written out.
> 
> The easiest way to cause this type of workload is do just dd from
> /dev/zero to a file until it fills the entire filesystem.  This can
> cause journal_finish_inode_data_buffers() to wait for the duration of
> the entire dd operation.
> 
> We can improve this situation by scoping each of the inode dirty ranges
> associated with a given transaction.  We do this via the jbd2_inode
> structure so that the scoping is contained within jbd2 and so that it
> follows the lifetime and locking rules for that structure.
> 
> This allows us to limit the writeback & wait in
> journal_submit_inode_data_buffers() and
> journal_finish_inode_data_buffers() respectively to the dirty range for
> a given struct jdb2_inode, keeping us from waiting forever if the inode
> in question is still being appended to.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>

The patch looks good to me. I was thinking whether we should not have
separate ranges for current and the next transaction but I guess it is not
worth it at least for now. So just one nit below. With that applied feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -257,15 +262,24 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
>  	/* For locking, see the comment in journal_submit_data_buffers() */
>  	spin_lock(&journal->j_list_lock);
>  	list_for_each_entry(jinode, &commit_transaction->t_inode_list, i_list) {
> +		loff_t dirty_start = jinode->i_dirty_start;
> +		loff_t dirty_end = jinode->i_dirty_end;
> +
>  		if (!(jinode->i_flags & JI_WAIT_DATA))
>  			continue;
>  		jinode->i_flags |= JI_COMMIT_RUNNING;
>  		spin_unlock(&journal->j_list_lock);
> -		err = filemap_fdatawait_keep_errors(
> -				jinode->i_vfs_inode->i_mapping);
> +		err = filemap_fdatawait_range_keep_errors(
> +				jinode->i_vfs_inode->i_mapping, dirty_start,
> +				dirty_end);
>  		if (!ret)
>  			ret = err;
>  		spin_lock(&journal->j_list_lock);
> +
> +		if (!jinode->i_next_transaction) {
> +			jinode->i_dirty_start = 0;
> +			jinode->i_dirty_end = 0;
> +		}

This would be more logical in the next loop that moves jinode into the next
transaction.

>  		jinode->i_flags &= ~JI_COMMIT_RUNNING;
>  		smp_mb();
>  		wake_up_bit(&jinode->i_flags, __JI_COMMIT_RUNNING);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
