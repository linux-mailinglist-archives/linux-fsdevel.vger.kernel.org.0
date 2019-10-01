Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1EEC38D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389563AbfJAPXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 11:23:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfJAPXS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:23:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42167882EA;
        Tue,  1 Oct 2019 15:23:18 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05F7D60C5D;
        Tue,  1 Oct 2019 15:23:15 +0000 (UTC)
Date:   Tue, 1 Oct 2019 11:23:14 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] xfs: remove the readpage / readpages tracing code
Message-ID: <20191001152314.GB62608@bfoster>
References: <20191001071152.24403-1-hch@lst.de>
 <20191001071152.24403-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001071152.24403-7-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 01 Oct 2019 15:23:18 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 01, 2019 at 09:11:47AM +0200, Christoph Hellwig wrote:
> The actual iomap implementations now have equivalent trace points.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_aops.c  |  2 --
>  fs/xfs/xfs_trace.h | 26 --------------------------
>  2 files changed, 28 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index f16d5f196c6b..b6101673c8fb 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -1160,7 +1160,6 @@ xfs_vm_readpage(
>  	struct file		*unused,
>  	struct page		*page)
>  {
> -	trace_xfs_vm_readpage(page->mapping->host, 1);
>  	return iomap_readpage(page, &xfs_iomap_ops);
>  }
>  
> @@ -1171,7 +1170,6 @@ xfs_vm_readpages(
>  	struct list_head	*pages,
>  	unsigned		nr_pages)
>  {
> -	trace_xfs_vm_readpages(mapping->host, nr_pages);
>  	return iomap_readpages(mapping, pages, nr_pages, &xfs_iomap_ops);
>  }
>  
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index eaae275ed430..eae4b29c174e 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -1197,32 +1197,6 @@ DEFINE_PAGE_EVENT(xfs_writepage);
>  DEFINE_PAGE_EVENT(xfs_releasepage);
>  DEFINE_PAGE_EVENT(xfs_invalidatepage);
>  
> -DECLARE_EVENT_CLASS(xfs_readpage_class,
> -	TP_PROTO(struct inode *inode, int nr_pages),
> -	TP_ARGS(inode, nr_pages),
> -	TP_STRUCT__entry(
> -		__field(dev_t, dev)
> -		__field(xfs_ino_t, ino)
> -		__field(int, nr_pages)
> -	),
> -	TP_fast_assign(
> -		__entry->dev = inode->i_sb->s_dev;
> -		__entry->ino = inode->i_ino;
> -		__entry->nr_pages = nr_pages;
> -	),
> -	TP_printk("dev %d:%d ino 0x%llx nr_pages %d",
> -		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  __entry->ino,
> -		  __entry->nr_pages)
> -)
> -
> -#define DEFINE_READPAGE_EVENT(name)		\
> -DEFINE_EVENT(xfs_readpage_class, name,	\
> -	TP_PROTO(struct inode *inode, int nr_pages), \
> -	TP_ARGS(inode, nr_pages))
> -DEFINE_READPAGE_EVENT(xfs_vm_readpage);
> -DEFINE_READPAGE_EVENT(xfs_vm_readpages);
> -
>  DECLARE_EVENT_CLASS(xfs_imap_class,
>  	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
>  		 int whichfork, struct xfs_bmbt_irec *irec),
> -- 
> 2.20.1
> 
