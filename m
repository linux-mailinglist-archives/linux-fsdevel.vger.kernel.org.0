Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16DF366CB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 15:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241855AbhDUNZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 09:25:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:34740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242963AbhDUNY3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:24:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65F22B1DE;
        Wed, 21 Apr 2021 13:23:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B14331F2B69; Wed, 21 Apr 2021 15:23:54 +0200 (CEST)
Date:   Wed, 21 Apr 2021 15:23:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH v2 3/7] jbd2: don't abort the journal when freeing
 buffers
Message-ID: <20210421132354.GS8706@quack2.suse.cz>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-4-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414134737.2366971-4-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-04-21 21:47:33, Zhang Yi wrote:
> Now, we can make sure to abort the journal once the original buffer was
  ^^ Now that we can be sure the journal is aborted once a buffer has
failed to be written back to disk, ...

> failed to write back to disk, we can remove the journal abort logic in
> jbd2_journal_try_to_free_buffers() which was introduced in
> <c044f3d8360d> ("jbd2: abort journal if free a async write error
> metadata buffer"), because it may costs and propably not safe.
				    ^^ cost	^^ probably is

> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/transaction.c | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 9396666b7314..3e0db4953fe4 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2118,7 +2118,6 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
>  {
>  	struct buffer_head *head;
>  	struct buffer_head *bh;
> -	bool has_write_io_error = false;
>  	int ret = 0;
>  
>  	J_ASSERT(PageLocked(page));
> @@ -2143,26 +2142,10 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
>  		jbd2_journal_put_journal_head(jh);
>  		if (buffer_jbd(bh))
>  			goto busy;
> -
> -		/*
> -		 * If we free a metadata buffer which has been failed to
> -		 * write out, the jbd2 checkpoint procedure will not detect
> -		 * this failure and may lead to filesystem inconsistency
> -		 * after cleanup journal tail.
> -		 */
> -		if (buffer_write_io_error(bh)) {
> -			pr_err("JBD2: Error while async write back metadata bh %llu.",
> -			       (unsigned long long)bh->b_blocknr);
> -			has_write_io_error = true;
> -		}
>  	} while ((bh = bh->b_this_page) != head);
>  
>  	ret = try_to_free_buffers(page);
> -
>  busy:
> -	if (has_write_io_error)
> -		jbd2_journal_abort(journal, -EIO);
> -
>  	return ret;
>  }
>  
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
