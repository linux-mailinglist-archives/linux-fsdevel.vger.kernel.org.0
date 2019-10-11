Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9363FD3DC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 12:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfJKK4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 06:56:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfJKK4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8J3W7Cl2wMMFds+YArgYo/Ec7rccaeMMqNp79ldFNbA=; b=tH5aJV1DCcLN5MSOqhB7IT4W9
        PugdNc1CeS9C86mYRcE5qZDqSJc6pyLrOSX6Td0YZD1NbszrBVlNGOmpkj/C6c+WQbbUoQYf23kON
        0xvREbxALu2e0gjffR/qMQabpUwYPEhQr6bxJIvq3QWfNTzzaB9o57uKVItryoXEdIZviVhElvpzq
        yTkusDd6RoNr6Fu7pqRTeQzN4l75BR0Tqz6bHytcoIXBLGqiX2pKSw7lS/4IqLoNkiuBPooDWd5/W
        EJPlF07IrlpNIjUEKXNB5a06XdsW0LQrTXhUpUYSncC8A3RPq7Wj9sdpSdbihAxQx6XoNGmubrbKI
        xd+nviNHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsao-0004VY-CW; Fri, 11 Oct 2019 10:56:18 +0000
Date:   Fri, 11 Oct 2019 03:56:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 23/26] xfs: reclaim inodes from the LRU
Message-ID: <20191011105618.GE12811@infradead.org>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-24-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-24-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +++ b/fs/xfs/xfs_icache.c
> @@ -1193,7 +1193,7 @@ xfs_reclaim_inode(
>   *
>   * Return the number of inodes freed.
>   */
> -STATIC int
> +int
>  xfs_reclaim_inodes_ag(
>  	struct xfs_mount	*mp,
>  	int			flags,

This looks odd.  This function actually is unused now.  I think you
want to fold in the patch that removes it instead of this little hack
to make the compiler happy.

> -	xfs_reclaim_inodes_ag(mp, SYNC_WAIT, INT_MAX);
> +        struct xfs_ireclaim_args *ra = arg;
> +        struct inode		*inode = container_of(item, struct inode, i_lru);
> +        struct xfs_inode	*ip = XFS_I(inode);

Whitespace damage, and a line > 80 chars.

> +out_ifunlock:
> +	xfs_ifunlock(ip);

This error path will instantly deadlock, given that xfs_ifunlock takes
i_flags_lock through xfs_iflags_clear, and we already hold it here.

> +	/*
> +	 * Remove the inode from the per-AG radix tree.
> +	 *
> +	 * Because radix_tree_delete won't complain even if the item was never
> +	 * added to the tree assert that it's been there before to catch
> +	 * problems with the inode life time early on.
> +	 */
> +	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ino));
> +	spin_lock(&pag->pag_ici_lock);
> +	if (!radix_tree_delete(&pag->pag_ici_root, XFS_INO_TO_AGINO(mp, ino)))
> +		ASSERT(0);

Well, it "complains" by returning NULL instead of the entry.  So I think
that comment could use some updates or simply be removed.

> +void
> +xfs_dispose_inodes(
> +	struct list_head	*freeable)
> +{
> +	while (!list_empty(freeable)) {
> +		struct inode *inode;
> +
> +		inode = list_first_entry(freeable, struct inode, i_lru);

This could use list_first_entry_or_null in the while loop, or not.
Or list_pop_entry if we had it, but Linus hates that :)

> +xfs_reclaim_inodes(
> +	struct xfs_mount	*mp)
> +{
> +	while (list_lru_count(&mp->m_inode_lru)) {
> +		struct xfs_ireclaim_args ra;
> +		long freed, to_free;
> +
> +		INIT_LIST_HEAD(&ra.freeable);
> +		ra.lowest_lsn = NULLCOMMITLSN;
> +		to_free = list_lru_count(&mp->m_inode_lru);

Do we want a helper to initialize the xfs_ireclaim_args?  That would
solve the "issue" of not initializing dirty_skipped in a few users
and make it a little easier to use.

> +
> +		freed = list_lru_walk(&mp->m_inode_lru, xfs_inode_reclaim_isolate,

Line > 80 chars.

> +static inline int __xfs_iflock_nowait(struct xfs_inode *ip)
> +{
> +	if (ip->i_flags & XFS_IFLOCK)
> +		return false;
> +	ip->i_flags |= XFS_IFLOCK;
> +	return true;
> +}

I wonder if simply open coding this would be simpler, given how magic
xfs_inode_reclaim_isolate already is, and given that we really shouldn't
use this helper anywhere else.
