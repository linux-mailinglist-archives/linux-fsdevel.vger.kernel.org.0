Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C732FBB1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 16:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389176AbhASPZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 10:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391497AbhASPY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611069810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pLlOTYewySa5UzDkz6XU5UCl0TCKUz9NWuFvIdm5pKU=;
        b=Dmp4meC7Gb6AiOox02Vm3BcH0rN3NitEIcgCJXnlfWPmFXfjp+cIpe4qDDj90YFgiHx4yY
        Ja5BL/EAf26HzjjrWw066lwQyOGi0xdBYtU+b+XW73wE+Oiz3NtCPGiZ8xSVfejDmTfO0P
        4proiEv40TiLJy0p6OmqhQu/mcbi208=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-NnUVRFqiNQu1dIlEBFc-GA-1; Tue, 19 Jan 2021 10:23:28 -0500
X-MC-Unique: NnUVRFqiNQu1dIlEBFc-GA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D147835DE7;
        Tue, 19 Jan 2021 15:23:27 +0000 (UTC)
Received: from bfoster (ovpn-114-23.rdu2.redhat.com [10.10.114.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76FB25E1A7;
        Tue, 19 Jan 2021 15:23:26 +0000 (UTC)
Date:   Tue, 19 Jan 2021 10:23:24 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 05/11] xfs: simplify the read/write tracepoints
Message-ID: <20210119152324.GE1646807@bfoster>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-6-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:10PM +0100, Christoph Hellwig wrote:
> Pass the iocb and iov_iter to the tracepoints and leave decoding of
> actual arguments to the code only run when tracing is enabled.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_file.c  | 20 ++++++++------------
>  fs/xfs/xfs_trace.h | 18 +++++++++---------
>  2 files changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 97836ec53397d4..aa64e78fc3c467 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -220,12 +220,11 @@ xfs_file_dio_read(
>  	struct iov_iter		*to)
>  {
>  	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
> -	size_t			count = iov_iter_count(to);
>  	ssize_t			ret;
>  
> -	trace_xfs_file_direct_read(ip, count, iocb->ki_pos);
> +	trace_xfs_file_direct_read(iocb, to);
>  
> -	if (!count)
> +	if (!iov_iter_count(to))
>  		return 0; /* skip atime */
>  
>  	file_accessed(iocb->ki_filp);
> @@ -246,12 +245,11 @@ xfs_file_dax_read(
>  	struct iov_iter		*to)
>  {
>  	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> -	size_t			count = iov_iter_count(to);
>  	ssize_t			ret = 0;
>  
> -	trace_xfs_file_dax_read(ip, count, iocb->ki_pos);
> +	trace_xfs_file_dax_read(iocb, to);
>  
> -	if (!count)
> +	if (!iov_iter_count(to))
>  		return 0; /* skip atime */
>  
>  	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
> @@ -272,7 +270,7 @@ xfs_file_buffered_read(
>  	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
>  	ssize_t			ret;
>  
> -	trace_xfs_file_buffered_read(ip, iov_iter_count(to), iocb->ki_pos);
> +	trace_xfs_file_buffered_read(iocb, to);
>  
>  	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
>  	if (ret)
> @@ -599,7 +597,7 @@ xfs_file_dio_write(
>  		iolock = XFS_IOLOCK_SHARED;
>  	}
>  
> -	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
> +	trace_xfs_file_direct_write(iocb, from);
>  	/*
>  	 * If unaligned, this is the only IO in-flight. Wait on it before we
>  	 * release the iolock to prevent subsequent overlapping IO.
> @@ -622,7 +620,6 @@ xfs_file_dax_write(
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	int			iolock = XFS_IOLOCK_EXCL;
>  	ssize_t			ret, error = 0;
> -	size_t			count;
>  	loff_t			pos;
>  
>  	ret = xfs_ilock_iocb(iocb, iolock);
> @@ -633,9 +630,8 @@ xfs_file_dax_write(
>  		goto out;
>  
>  	pos = iocb->ki_pos;
> -	count = iov_iter_count(from);
>  
> -	trace_xfs_file_dax_write(ip, count, pos);
> +	trace_xfs_file_dax_write(iocb, from);
>  	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
>  	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
>  		i_size_write(inode, iocb->ki_pos);
> @@ -683,7 +679,7 @@ xfs_file_buffered_write(
>  	/* We can write back this queue in page reclaim */
>  	current->backing_dev_info = inode_to_bdi(inode);
>  
> -	trace_xfs_file_buffered_write(ip, iov_iter_count(from), iocb->ki_pos);
> +	trace_xfs_file_buffered_write(iocb, from);
>  	ret = iomap_file_buffered_write(iocb, from,
>  			&xfs_buffered_write_iomap_ops);
>  	if (likely(ret >= 0))
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 5a263ae3d4f008..a6d04d860a565e 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -1287,8 +1287,8 @@ TRACE_EVENT(xfs_log_assign_tail_lsn,
>  )
>  
>  DECLARE_EVENT_CLASS(xfs_file_class,
> -	TP_PROTO(struct xfs_inode *ip, size_t count, loff_t offset),
> -	TP_ARGS(ip, count, offset),
> +	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter),
> +	TP_ARGS(iocb, iter),
>  	TP_STRUCT__entry(
>  		__field(dev_t, dev)
>  		__field(xfs_ino_t, ino)
> @@ -1297,11 +1297,11 @@ DECLARE_EVENT_CLASS(xfs_file_class,
>  		__field(size_t, count)
>  	),
>  	TP_fast_assign(
> -		__entry->dev = VFS_I(ip)->i_sb->s_dev;
> -		__entry->ino = ip->i_ino;
> -		__entry->size = ip->i_d.di_size;
> -		__entry->offset = offset;
> -		__entry->count = count;
> +		__entry->dev = file_inode(iocb->ki_filp)->i_sb->s_dev;
> +		__entry->ino = XFS_I(file_inode(iocb->ki_filp))->i_ino;
> +		__entry->size = XFS_I(file_inode(iocb->ki_filp))->i_d.di_size;
> +		__entry->offset = iocb->ki_pos;
> +		__entry->count = iov_iter_count(iter);
>  	),
>  	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset 0x%llx count 0x%zx",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
> @@ -1313,8 +1313,8 @@ DECLARE_EVENT_CLASS(xfs_file_class,
>  
>  #define DEFINE_RW_EVENT(name)		\
>  DEFINE_EVENT(xfs_file_class, name,	\
> -	TP_PROTO(struct xfs_inode *ip, size_t count, loff_t offset),	\
> -	TP_ARGS(ip, count, offset))
> +	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter),		\
> +	TP_ARGS(iocb, iter))
>  DEFINE_RW_EVENT(xfs_file_buffered_read);
>  DEFINE_RW_EVENT(xfs_file_direct_read);
>  DEFINE_RW_EVENT(xfs_file_dax_read);
> -- 
> 2.29.2
> 

