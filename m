Return-Path: <linux-fsdevel+bounces-78225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOFoIyFinWksPQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 09:32:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0548E183BA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 09:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7E31310835F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 08:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F01C366834;
	Tue, 24 Feb 2026 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HCZ8CzsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A581624C5;
	Tue, 24 Feb 2026 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921820; cv=none; b=L4nES+Biz6LlejDdc7Aqnl09HOZD4wov28nzKJotlRRW2ZA5kmCgvr1+vyke122yaqnEuZNCgV1xmTAOtBBqI0psNLECs4b6WVxd9ve1Gsab5AfUOOD1mZJR6oeHYqYY+rf05fZ8bFMHvUcRZF19hwXQlsNPhEGu1cotGMo3LAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921820; c=relaxed/simple;
	bh=szVDuY7GJPvnC6hugGRtAPDV/4iTjGPe5s3FptJiKBA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NrGZnxVQIV5/5/S4DIKi2xY28jZbHA197wIi8kK73vSPQdyGQLaFWEmEKHoIye/0EyPVGwPoSlq3Di4cYphjlAbUQl+PPfaGfCx0ytkqDFbD2gsIi/baP8Vg2lTFuWWsp18yc5r2qMHz3e4Y0bC75kRtwWQXyNg1jiBEBInzcNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HCZ8CzsS; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771921813; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=NhRb6XgmNAApZVjwWI5Y73JZ9iS82fMN40mYUfOj5p4=;
	b=HCZ8CzsSOM7yuZaJw2oyMOrhuDEraO3SkB3xEN4Zl4yG421DF6F/f2OAkYV7Se0U+BPGgS/JHh4TnkPu8QHqbW2aDNzJmLbrR2tgb3/nlL333icBSLyihMcO18JDXjWsKcBHP1He1K6MqgcgBXtrHKtw09ZYhiyCrAjidFUyNyM=
Received: from 30.221.147.152(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wziu5dL_1771921812 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Feb 2026 16:30:13 +0800
Message-ID: <5a612ef9-0de6-43a2-a84c-eb8776235eef@linux.alibaba.com>
Date: Tue, 24 Feb 2026 16:30:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: invalidate the page cache after direct write
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
References: <20260111073701.6071-1-jefflexu@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20260111073701.6071-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78225-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email,ddn.com:email]
X-Rspamd-Queue-Id: 0548E183BA1
X-Rspamd-Action: no action

gentle ping

On 1/11/26 3:37 PM, Jingbo Xu wrote:
> This fixes xfstests generic/451 (for both O_DIRECT and FOPEN_DIRECT_IO
> direct write).
> 
> Commit b359af8275a9 ("fuse: Invalidate the page cache after
> FOPEN_DIRECT_IO write") tries to fix the similar issue for
> FOPEN_DIRECT_IO write, which can be reproduced by xfstests generic/209.
> It only fixes the issue for synchronous direct write, while omitting
> the case for asynchronous direct write (exactly targeted by
> generic/451).
> 
> While for O_DIRECT direct write, it's somewhat more complicated.  For
> synchronous direct write, generic_file_direct_write() will invalidate
> the page cache after the write, and thus it can pass generic/209.  While
> for asynchronous direct write, the invalidation in
> generic_file_direct_write() is bypassed since the invalidation shall be
> done when the asynchronous IO completes.  This is omitted in FUSE and
> generic/451 fails whereby.
> 
> Fix this by conveying the invalidation for both synchronous and
> asynchronous write.
> 
> - with FOPEN_DIRECT_IO
>   - sync write,  invalidate in fuse_send_write()
>   - async write, invalidate in fuse_aio_complete() with FUSE_ASYNC_DIO,
> 		 fuse_send_write() otherwise
> - without FOPEN_DIRECT_IO
>   - sync write,  invalidate in generic_file_direct_write()
>   - async write, invalidate in fuse_aio_complete() with FUSE_ASYNC_DIO,
> 		 generic_file_direct_write() otherwise
> 
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> changes:
> - drop "|| !ia->io->blocking" in fuse_send_write() (Bernd)
> ---
>  fs/fuse/file.c | 43 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..625d236b881b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -667,6 +667,18 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
>  			struct inode *inode = file_inode(io->iocb->ki_filp);
>  			struct fuse_conn *fc = get_fuse_conn(inode);
>  			struct fuse_inode *fi = get_fuse_inode(inode);
> +			struct address_space *mapping = io->iocb->ki_filp->f_mapping;
> +
> +			/*
> +			 * As in generic_file_direct_write(), invalidate after the
> +			 * write, to invalidate read-ahead cache that may have competed
> +			 * with the write.
> +			 */
> +			if (io->write && res && mapping->nrpages) {
> +				invalidate_inode_pages2_range(mapping,
> +						io->offset >> PAGE_SHIFT,
> +						(io->offset + res - 1) >> PAGE_SHIFT);
> +			}
>  
>  			spin_lock(&fi->lock);
>  			fi->attr_version = atomic64_inc_return(&fc->attr_version);
> @@ -1144,9 +1156,11 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
>  {
>  	struct kiocb *iocb = ia->io->iocb;
>  	struct file *file = iocb->ki_filp;
> +	struct address_space *mapping = file->f_mapping;
>  	struct fuse_file *ff = file->private_data;
>  	struct fuse_mount *fm = ff->fm;
>  	struct fuse_write_in *inarg = &ia->write.in;
> +	ssize_t written;
>  	ssize_t err;
>  
>  	fuse_write_args_fill(ia, ff, pos, count);
> @@ -1160,10 +1174,26 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
>  		return fuse_async_req_send(fm, ia, count);
>  
>  	err = fuse_simple_request(fm, &ia->ap.args);
> -	if (!err && ia->write.out.size > count)
> +	written = ia->write.out.size;
> +	if (!err && written > count)
>  		err = -EIO;
>  
> -	return err ?: ia->write.out.size;
> +	/*
> +	 * Without FOPEN_DIRECT_IO, generic_file_direct_write() does the
> +	 * invalidation for us.
> +	 */
> +	if (!err && written && mapping->nrpages &&
> +	    (ff->open_flags & FOPEN_DIRECT_IO)) {
> +		/*
> +		 * As in generic_file_direct_write(), invalidate after the
> +		 * write, to invalidate read-ahead cache that may have competed
> +		 * with the write.
> +		 */
> +		invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
> +					(pos + written - 1) >> PAGE_SHIFT);
> +	}
> +
> +	return err ?: written;
>  }
>  
>  bool fuse_write_update_attr(struct inode *inode, loff_t pos, ssize_t written)
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

-- 
Thanks,
Jingbo


