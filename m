Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C609751804
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 18:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbfFXQG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 12:06:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:47560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbfFXQG0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:06:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85038AE21;
        Mon, 24 Jun 2019 16:06:24 +0000 (UTC)
Subject: Re: [PATCH 09/12] xfs: refactor the ioend merging code
To:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-10-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e42c54c4-4c64-8185-8ac3-cca38ad8e8a4@suse.com>
Date:   Mon, 24 Jun 2019 19:06:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624055253.31183-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 24.06.19 г. 8:52 ч., Christoph Hellwig wrote:
> Introduce two nicely abstracted helper, which can be moved to the
> iomap code later.  Also use list_pop and list_first_entry_or_null
> to simplify the code a bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_aops.c | 66 ++++++++++++++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index acbd73976067..5d302ebe2a33 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -121,6 +121,19 @@ xfs_destroy_ioend(
>  	}
>  }
>  
> +static void
> +xfs_destroy_ioends(
> +	struct xfs_ioend	*ioend,
> +	int			error)
> +{
> +	struct list_head	tmp;
> +
> +	list_replace_init(&ioend->io_list, &tmp);
> +	xfs_destroy_ioend(ioend, error);
> +	while ((ioend = list_pop(&tmp, struct xfs_ioend, io_list)))
> +		xfs_destroy_ioend(ioend, error);

nit: I'd prefer if the list_pop patch is right before this one since
this is the first user of it. Additionally, I don't think list_pop is
really a net-negative win in comparison to list_for_each_entry_safe
here. In fact this "delete the list" would seems more idiomatic if
implemented via list_for_each_entry_safe

> +}
> +
>  /*
>   * Fast and loose check if this write could update the on-disk inode size.
>   */
> @@ -173,7 +186,6 @@ xfs_end_ioend(
>  	struct xfs_ioend	*ioend)
>  {
>  	unsigned int		nofs_flag = memalloc_nofs_save();
> -	struct list_head	ioend_list;
>  	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
>  	xfs_off_t		offset = ioend->io_offset;
>  	size_t			size = ioend->io_size;
> @@ -207,16 +219,7 @@ xfs_end_ioend(
>  	if (!error && xfs_ioend_is_append(ioend))
>  		error = xfs_setfilesize(ip, offset, size);
>  done:
> -	list_replace_init(&ioend->io_list, &ioend_list);
> -	xfs_destroy_ioend(ioend, error);
> -
> -	while (!list_empty(&ioend_list)) {
> -		ioend = list_first_entry(&ioend_list, struct xfs_ioend,
> -				io_list);
> -		list_del_init(&ioend->io_list);
> -		xfs_destroy_ioend(ioend, error);
> -	}
> -
> +	xfs_destroy_ioends(ioend, error);
>  	memalloc_nofs_restore(nofs_flag);
>  }
>  
> @@ -246,15 +249,16 @@ xfs_ioend_try_merge(
>  	struct xfs_ioend	*ioend,
>  	struct list_head	*more_ioends)
>  {
> -	struct xfs_ioend	*next_ioend;
> +	struct xfs_ioend	*next;
>  
> -	while (!list_empty(more_ioends)) {
> -		next_ioend = list_first_entry(more_ioends, struct xfs_ioend,
> -				io_list);
> -		if (!xfs_ioend_can_merge(ioend, next_ioend))
> +	INIT_LIST_HEAD(&ioend->io_list);
> +
> +	while ((next = list_first_entry_or_null(more_ioends, struct xfs_ioend,
> +			io_list))) {
> +		if (!xfs_ioend_can_merge(ioend, next))
>  			break;
> -		list_move_tail(&next_ioend->io_list, &ioend->io_list);
> -		ioend->io_size += next_ioend->io_size;
> +		list_move_tail(&next->io_list, &ioend->io_list);
> +		ioend->io_size += next->io_size;
>  	}
>  }
>  
> @@ -277,29 +281,31 @@ xfs_ioend_compare(
>  	return 0;
>  }
>  
> +static void
> +xfs_sort_ioends(
> +	struct list_head	*ioend_list)
> +{
> +	list_sort(NULL, ioend_list, xfs_ioend_compare);
> +}
> +
>  /* Finish all pending io completions. */
>  void
>  xfs_end_io(
>  	struct work_struct	*work)
>  {
> -	struct xfs_inode	*ip;
> +	struct xfs_inode	*ip =
> +		container_of(work, struct xfs_inode, i_ioend_work);
>  	struct xfs_ioend	*ioend;
> -	struct list_head	completion_list;
> +	struct list_head	tmp;
>  	unsigned long		flags;
>  
> -	ip = container_of(work, struct xfs_inode, i_ioend_work);
> -
>  	spin_lock_irqsave(&ip->i_ioend_lock, flags);
> -	list_replace_init(&ip->i_ioend_list, &completion_list);
> +	list_replace_init(&ip->i_ioend_list, &tmp);
>  	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
>  
> -	list_sort(NULL, &completion_list, xfs_ioend_compare);
> -
> -	while (!list_empty(&completion_list)) {
> -		ioend = list_first_entry(&completion_list, struct xfs_ioend,
> -				io_list);
> -		list_del_init(&ioend->io_list);
> -		xfs_ioend_try_merge(ioend, &completion_list);
> +	xfs_sort_ioends(&tmp);
> +	while ((ioend = list_pop(&tmp, struct xfs_ioend, io_list))) {
> +		xfs_ioend_try_merge(ioend, &tmp);
>  		xfs_end_ioend(ioend);

Here again, tmp is a local copy that is immutable so using while()
instead of list_for_each_entry_safe doesn't seem to be providing much.

>  	}
>  }
> 
