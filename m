Return-Path: <linux-fsdevel+bounces-72877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51806D04603
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8585327ECBA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D36D2882BB;
	Thu,  8 Jan 2026 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="RGvqmhOl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjyo/5bO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7867D26F467;
	Thu,  8 Jan 2026 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888971; cv=none; b=sBlN7OCfZEGQxnZBQ8I8wj30r/xPgrNzGQeKLvgyknYjqxFyadqoEXNmPBYBfHhTB5udXGIaSSUOo3PElzLC1rQUU+tx43z9kLvTcPEd9DJpJsIibvUOjwR4zwedDUNMGhxC0R3LdxGFs1D0yGlT7YEThnoy7JBowmDOTqpRuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888971; c=relaxed/simple;
	bh=OrCqPVeuAIA6S1ldTYrMrCnjwAb+GD4024uXBOEUEJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=et/HwKz8njiD30mv/uXyGmhblwPastM6d+rXa9txcaxL0xpbKSBB0Ro8n4eTwwxAGyO+KJzor2s5Ktaxij3TA3oAj3QXnLObhTdmnTmQR4KDpC2yh0ZupyjmYxFJzcT8uNzdlrOzhvmHWPrmKpJopbA5rOQtJv5J152oAUG3R0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=RGvqmhOl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hjyo/5bO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97D4714000D5;
	Thu,  8 Jan 2026 11:16:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Jan 2026 11:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767888968;
	 x=1767975368; bh=N5b1e0phpU7qzKScgAmKLRNKDvC73O6FY0ZhaPjCP7g=; b=
	RGvqmhOlKFiYunhhb79qZaAlxJ4zNdWXF9gDlTh3bVSw3U7GikmpPA5AQXPbO+Z+
	HSoR7JwpMWtI7nGr4L9gwD9+kgJB469kfb2jlqHSNlAcOOweol0vKM7lA+0qccm3
	Mc8ZmEzsgQB1UN70LpwfKhiVSIPe9KFRs8fuv0or687kbWK8M4+UxRDuI1ZLDICr
	KMNuvvloEkU0upuDvFxT02f7hR5VnfuvVAzN9gkYNf8hHjZI0xYDpTzpAe2408Lh
	rDZXGaac01ICMoLlohuG36jrg55A89iqPL270lMTSU1vh5S35cesb0qjS4IPLQ2L
	wrPxnVVaFiukWgKbmq0RLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767888968; x=
	1767975368; bh=N5b1e0phpU7qzKScgAmKLRNKDvC73O6FY0ZhaPjCP7g=; b=h
	jyo/5bOjKVYVZi+0HOSy+d7hoOqLJV4RRqxil8S20crr27WIj0/EpbdccoqteB1v
	AZqfmlYMdZLrwUG+AqBB7wmQNmVk1iUAKajxpINgPgwU6b/ppGL8pecOkfyRuKHX
	V6ARWgFGTSLbHMqGMgoXlswtQGF3hDX288wJ+LvTaO6YM8EwXvWRmXxEV/m2bU9Q
	qusxyj6Ng01EiAg2sX0lAjiYAZK7EmVzyqQLF2mylzp6SDL3EnO7Hz7lJKUo/6TX
	Bzrvqzbr5eNSXFYnVMVnZlUrs00JU+acJvPGVn9D+IHEip+Djan0I2IzOvogK2BK
	yTf/jrKkwwjcQHk9JW7eg==
X-ME-Sender: <xms:SNhfaeP50uZOmZDutUMib-B8tqsEF9N1rFgdnyF5zL50f6fjonVliQ>
    <xme:SNhfaV6xlg8fNnhz62LG5S1e4aGobnoijWC6jRwPJcmdigfzKrnX24lS0RljBRCP2
    MrJ6NGiFxMnU-unOwQFoiSjDi2Ro08R69TSlU-Il2rgqgIzlcE>
X-ME-Received: <xmr:SNhfaQ1BZWPq_lD9kuqBQeJs8hoFmbGu8Qclo4FSSAPKTm9uzfHwRAxymJFxsGCuw-rSd9KDJZkn9YwgqgEwl0uUth4PbWoL4AOEmg_cGx2u_C_xyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeigeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejre
    dttddvjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghs
    sggvrhhnugdrtghomheqnecuggftrfgrthhtvghrnhephefhjeeujeelhedtheetfedvgf
    dtleffuedujefhheegudefvdfhheeuveduueegnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgvfhhf
    lhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepmhhikhhloh
    hssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghstghhuhgsvghrthesuggunh
    drtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:SNhfaeyh-3-Fosm_pj25IZapIZRBrrXyKqFUshz0a6rn0sVMUrFDzg>
    <xmx:SNhfaStU8cdM-JtmYZwnT0AURE_npTJ2QKeCVTAo8RmbhikZetls4Q>
    <xmx:SNhfaQzo8LhTEoLDAWQ9XPZxJywkvEYjtuHxwXGT5JOZrT7YyYY23w>
    <xmx:SNhfaVBkk-gOTy7yKZ2Uq6zQc0FrDRgqkMoXDWqzZlGEovFSa4vZiQ>
    <xmx:SNhfafRYRY-qArV9c9_up9CwCPm8UM3FK23qcv5wq9FTSg6mK3_n78GR>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 11:16:07 -0500 (EST)
Message-ID: <b6cfc411-8d2e-45c2-b237-e79f71016bbb@bsbernd.com>
Date: Thu, 8 Jan 2026 17:16:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: invalidate the page cache after direct write
To: Jingbo Xu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, bschubert@ddn.com
Cc: linux-kernel@vger.kernel.org
References: <20260106075234.63364-1-jefflexu@linux.alibaba.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260106075234.63364-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jingbo,

thanks a lot, I have an internal ticket assigned for that, but never
found the time to look into it.

On 1/6/26 08:52, Jingbo Xu wrote:
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
> Fix this by conveying the invalidation in both sync and async
> (FUSE_ASYNC_DIO) request submission.  The only side effect is that
> there's a redundant invalidation for synchronous direct write when
> FUSE_ASYNC_DIO is disabled (in fuse_send_write()), given the same
> range has been invalidated once in generic_file_direct_write().

The side effect should only come without FOPEN_DIRECT_IO. Could you add
this diff to avoid it?

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d6ae3b4652f8..c04296316a82 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1177,7 +1177,13 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
        written = ia->write.out.size;
        if (!err && written > count)
                err = -EIO;
-       if (!err && written && mapping->nrpages) {
+
+       /*
+        * without FOPEN_DIRECT_IO generic_file_direct_write() does the
+        * invalidation for us
+        */
+       if (!err && written && mapping->nrpages &&
+           (ff->open_flags & FOPEN_DIRECT_IO)) {
                /*
                 * As in generic_file_direct_write(), invalidate after the
                 * write, to invalidate read-ahead cache that may have competed


> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/file.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..d6ae3b4652f8 100644
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
> @@ -1160,10 +1174,20 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
>  		return fuse_async_req_send(fm, ia, count);
>  
>  	err = fuse_simple_request(fm, &ia->ap.args);
> -	if (!err && ia->write.out.size > count)
> +	written = ia->write.out.size;
> +	if (!err && written > count)
>  		err = -EIO;
> +	if (!err && written && mapping->nrpages) {
> +		/*
> +		 * As in generic_file_direct_write(), invalidate after the
> +		 * write, to invalidate read-ahead cache that may have competed
> +		 * with the write.
> +		 */
> +		invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
> +					(pos + written - 1) >> PAGE_SHIFT);
> +	}
>  
> -	return err ?: ia->write.out.size;
> +	return err ?: written;
>  }
>  
>  bool fuse_write_update_attr(struct inode *inode, loff_t pos, ssize_t written)
> @@ -1738,15 +1762,6 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
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

Assuming you apply the diff above, feel free to add for v2
Reviewed-by: Bernd Schubert <bschubert@ddn.com>


Thanks,
Bernd

