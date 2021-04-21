Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD323667F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 11:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbhDUJ1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 05:27:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:51114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhDUJ1T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:27:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8E0BAE06;
        Wed, 21 Apr 2021 09:26:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 80B9F1F2B69; Wed, 21 Apr 2021 11:26:45 +0200 (CEST)
Date:   Wed, 21 Apr 2021 11:26:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        jack@suse.cz, willy@infradead.org, virtio-fs@redhat.com,
        slp@redhat.com, miklos@szeredi.hu, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dax: Wake up all waiters after invalidating dax
 entry
Message-ID: <20210421092645.GO8706@quack2.suse.cz>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419213636.1514816-4-vgoyal@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 19-04-21 17:36:36, Vivek Goyal wrote:
> I am seeing missed wakeups which ultimately lead to a deadlock when I am
> using virtiofs with DAX enabled and running "make -j". I had to mount
> virtiofs as rootfs and also reduce to dax window size to 256M to reproduce
> the problem consistently.
> 
> So here is the problem. put_unlocked_entry() wakes up waiters only
> if entry is not null as well as !dax_is_conflict(entry). But if I
> call multiple instances of invalidate_inode_pages2() in parallel,
> then I can run into a situation where there are waiters on
> this index but nobody will wait these.
> 
> invalidate_inode_pages2()
>   invalidate_inode_pages2_range()
>     invalidate_exceptional_entry2()
>       dax_invalidate_mapping_entry_sync()
>         __dax_invalidate_entry() {
>                 xas_lock_irq(&xas);
>                 entry = get_unlocked_entry(&xas, 0);
>                 ...
>                 ...
>                 dax_disassociate_entry(entry, mapping, trunc);
>                 xas_store(&xas, NULL);
>                 ...
>                 ...
>                 put_unlocked_entry(&xas, entry);
>                 xas_unlock_irq(&xas);
>         }
> 
> Say a fault in in progress and it has locked entry at offset say "0x1c".
> Now say three instances of invalidate_inode_pages2() are in progress
> (A, B, C) and they all try to invalidate entry at offset "0x1c". Given
> dax entry is locked, all tree instances A, B, C will wait in wait queue.
> 
> When dax fault finishes, say A is woken up. It will store NULL entry
> at index "0x1c" and wake up B. When B comes along it will find "entry=0"
> at page offset 0x1c and it will call put_unlocked_entry(&xas, 0). And
> this means put_unlocked_entry() will not wake up next waiter, given
> the current code. And that means C continues to wait and is not woken
> up.
> 
> This patch fixes the issue by waking up all waiters when a dax entry
> has been invalidated. This seems to fix the deadlock I am facing
> and I can make forward progress.
> 
> Reported-by: Sergio Lopez <slp@redhat.com>
> Fixes: ac401cc78242 ("dax: New fault locking")
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Looks good to me. Thanks for fixing this! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index f19d76a6a493..cc497519be83 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -676,7 +676,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
>  	mapping->nrexceptional--;
>  	ret = 1;
>  out:
> -	put_unlocked_entry(&xas, entry, WAKE_NEXT);
> +	put_unlocked_entry(&xas, entry, WAKE_ALL);
>  	xas_unlock_irq(&xas);
>  	return ret;
>  }
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
