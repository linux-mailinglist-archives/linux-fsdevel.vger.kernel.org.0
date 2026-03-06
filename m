Return-Path: <linux-fsdevel+bounces-79617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLRsLlvhqmlqXwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:14:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5231122268B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 259DB30488A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF093A7F5E;
	Fri,  6 Mar 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ElAlWZa6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C7A369964;
	Fri,  6 Mar 2026 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806321; cv=none; b=o3bRL4DuWefvbSq1eWb0xWDD7V7qLEhV21kT0kUomyenHrsrxh3IWXI56SjNQlkLZawnIqpvuT15M0LgrmSO6b2+tnFuDU+kFqrNQT66LPeOxn4FhlGowbIGwaWoHFd4Rqegh0CUtDkBP6faDgQ8C+4HQgJuxEAaz2ruzfI/ofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806321; c=relaxed/simple;
	bh=h3Lm52l+7/idma2QNKBM7GP1Bggin/M9oaP4AreY4Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mS9SKTgSEW65+N9G+MhM8SrIIDelKBsSIeJv2aDeZsk3ySuAcOnqY1JVOqxvXae/dp7FdJwsv/+tn3/UKTcFBRpdQVneWiRBWd1nhzNGsyd6agebgJUF9lA/zzisBRSy+SlEGGNT+4uQjdKURPyoqxCMUjXHu1SIR1oEDBM5T5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ElAlWZa6; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772806308; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CXK07pFtoXteMadCiIrbHuNzcIaOfy1sUm56W5A733Y=;
	b=ElAlWZa6KKhoXsn+y8vEK9pqjCRBs3v5Px2BnhixX7nTXqVMvpOeRZvHy8dBRG+WJzJ8UBFSh0ZzqiocyW2ojCjCCaN/4ymD4yit6O6uLCy9/yBG6cgH5kQfjqFG+we/cVtelNtb6lLV7GzSqlgDURV18HihngMf1vo6Ihu7h1s=
Received: from 30.171.201.59(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X-NRVuX_1772806307 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Mar 2026 22:11:48 +0800
Message-ID: <43b45f47-8a0b-4dc3-9f13-44dacd1c6462@linux.alibaba.com>
Date: Fri, 6 Mar 2026 22:11:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: invalidate page cache after sync and async
 direct writes
To: cding@ddn.com, Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260306-xfstests-generic-451-v2-1-93b2d540304b@ddn.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260306-xfstests-generic-451-v2-1-93b2d540304b@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5231122268B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79617-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ddn.com:email]
X-Rspamd-Action: no action



On 3/6/26 6:12 PM, Cheng Ding via B4 Relay wrote:
> From: Cheng Ding <cding@ddn.com>
> 
> Fixes xfstests generic/451, similar to how commit b359af8275a9 ("fuse:
> Invalidate the page cache after FOPEN_DIRECT_IO write") fixes xfstests
> generic/209.
> 
> Signed-off-by: Cheng Ding <cding@ddn.com>
> ---
> Changes in v2:
> - Address review comments: move invalidation from fuse_direct_io() to
>   fuse_direct_write_iter()
> - Link to v1: https://lore.kernel.org/r/20260303-async-dio-aio-cache-invalidation-v1-1-fba0fd0426c3@ddn.com
> ---
>  fs/fuse/file.c   | 53 +++++++++++++++++++++++++++++++++++++++++++----------
>  fs/fuse/fuse_i.h |  1 +
>  2 files changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index b1bb7153cb78..dc92da9973ae 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -23,6 +23,8 @@
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/iomap.h>
>  
> +int sb_init_dio_done_wq(struct super_block *sb);
> +
>  static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
>  			  unsigned int open_flags, int opcode,
>  			  struct fuse_open_out *outargp)
> @@ -629,6 +631,19 @@ static ssize_t fuse_get_res_by_io(struct fuse_io_priv *io)
>  	return io->bytes < 0 ? io->size : io->bytes;
>  }
>  
> +static void fuse_aio_invalidate_worker(struct work_struct *work)
> +{
> +	struct fuse_io_priv *io = container_of(work, struct fuse_io_priv, work);
> +	struct address_space *mapping = io->iocb->ki_filp->f_mapping;
> +	ssize_t res = fuse_get_res_by_io(io);
> +	pgoff_t start = io->offset >> PAGE_SHIFT;
> +	pgoff_t end = (io->offset + res - 1) >> PAGE_SHIFT;
> +
> +	invalidate_inode_pages2_range(mapping, start, end);
> +	io->iocb->ki_complete(io->iocb, res);
> +	kref_put(&io->refcnt, fuse_io_release);
> +}
> +
>  /*
>   * In case of short read, the caller sets 'pos' to the position of
>   * actual end of fuse request in IO request. Otherwise, if bytes_requested
> @@ -661,10 +676,11 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
>  	spin_unlock(&io->lock);
>  
>  	if (!left && !io->blocking) {
> +		struct inode *inode = file_inode(io->iocb->ki_filp);
> +		struct address_space *mapping = io->iocb->ki_filp->f_mapping;
>  		ssize_t res = fuse_get_res_by_io(io);
>  
>  		if (res >= 0) {
> -			struct inode *inode = file_inode(io->iocb->ki_filp);
>  			struct fuse_conn *fc = get_fuse_conn(inode);
>  			struct fuse_inode *fi = get_fuse_inode(inode);
>  
> @@ -673,6 +689,20 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
>  			spin_unlock(&fi->lock);
>  		}
>  
> +		if (io->write && res >= 0 && mapping->nrpages) {

if (io->write && res > 0 && mapping->nrpages) {...}

The other part looks good to me.

> +			/*
> +			 * As in generic_file_direct_write(), invalidate after the
> +			 * write, to invalidate read-ahead cache that may have competed
> +			 * with the write.
> +			 */
> +			if (!inode->i_sb->s_dio_done_wq)
> +				res = sb_init_dio_done_wq(inode->i_sb);
> +			if (res >= 0) {
> +				INIT_WORK(&io->work, fuse_aio_invalidate_worker);
> +				queue_work(inode->i_sb->s_dio_done_wq, &io->work);
> +				return;
> +			}
> +		}
>  		io->iocb->ki_complete(io->iocb, res);
>  	}
>  
> @@ -1738,15 +1768,6 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>  	if (res > 0)
>  		*ppos = pos;
>  
> -	if (res > 0 && write && fopen_direct_io) {
> -		/*
> -		 * As in generic_file_direct_write(), invalidate after the
> -		 * write, to invalidate read-ahead cache that may have competed
> -		 * with the write.
> -		 */
> -		invalidate_inode_pages2_range(mapping, idx_from, idx_to);
> -	}
> -
>  	return res > 0 ? res : err;
>  }
>  EXPORT_SYMBOL_GPL(fuse_direct_io);
> @@ -1785,6 +1806,8 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct address_space *mapping = inode->i_mapping;
> +	loff_t pos = iocb->ki_pos;
>  	ssize_t res;
>  	bool exclusive;
>  
> @@ -1801,6 +1824,16 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  					     FUSE_DIO_WRITE);
>  			fuse_write_update_attr(inode, iocb->ki_pos, res);
>  		}
> +		if (res > 0 && mapping->nrpages) {
> +			/*
> +			 * As in generic_file_direct_write(), invalidate after
> +			 * write, to invalidate read-ahead cache that may have
> +			 * with the write.
> +			 */
> +			invalidate_inode_pages2_range(mapping,
> +				pos >> PAGE_SHIFT,
> +				(pos + res - 1) >> PAGE_SHIFT);
> +		}
>  	}
>  	fuse_dio_unlock(iocb, exclusive);
>  
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d1..6e8c8cf6b2c8 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -377,6 +377,7 @@ union fuse_file_args {
>  /** The request IO state (for asynchronous processing) */
>  struct fuse_io_priv {
>  	struct kref refcnt;
> +	struct work_struct work;
>  	int async;
>  	spinlock_t lock;
>  	unsigned reqs;
> 
> ---
> base-commit: 3c9332f821aa11552f19c331c5aa5299c78c7c94
> change-id: 20260306-xfstests-generic-451-fed0f9d5a095
> 
> Best regards,

-- 
Thanks,
Jingbo


