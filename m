Return-Path: <linux-fsdevel+bounces-27963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA68A965372
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 01:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7B7B221DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 23:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651A618E37D;
	Thu, 29 Aug 2024 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="YlUprDLC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bHUQxBVO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5F18A937
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724974249; cv=none; b=ZpjuYuQSNS76ghWTnJ3iBogHZ6z5h2WYmLk0HDDzSzDmMZaOkO7k10z9PC+sYZjEeYjFFYz67xyAIB7XeSExkZCjcSadcRoagObwqpoetvv73ogwTU2PUNUtBC58auMTk1xd6JQ5khvNAYVoYp9OJ+AJdFh4spkGvrT0ld85Irc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724974249; c=relaxed/simple;
	bh=86VShOii8NCJBfwmBq0FKr/kEpnG6CBhhtmM77u1C4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lPJF8N/+oYInx6KUpwLPxnffnoSQmnQAxdL6Mp3IxjL/1/wz4HDWGW5wSCDmnraJalJ3l0YiXH4Bx823PKmkCLZTuPeBvhCY8mOG5ZJibXl5kEU8tuwI+N8jhCd3Nkwz2rAMYiQnz0q3wj688S3YLSkRDaZ8xxUTW4KCk6Y97W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=YlUprDLC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bHUQxBVO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 48644138FC6E;
	Thu, 29 Aug 2024 19:30:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 29 Aug 2024 19:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724974246;
	 x=1725060646; bh=pTFlrR35IlGPyH0ZeIwt0GOeVFJAfBo04gwzII4JWVw=; b=
	YlUprDLCUllCB3yrG/Jmb1SQgkBT30j6snd/4ddJQfQZezY0HCoL6fzYeUYWRfWV
	H01yeHPI1TZaRSrf/M9ha1NAuPc2yCcA7RN17HdYPk5RlZ5cPeOdNIfxqGmi6Q8q
	7Dp+2QFYNkfUEVdNJAgoQncIYh/7R7HMZbomhdCC0ARgBhdPKw2MwxXisfrUXoVh
	Hatpfpjs7S6pXP+otkg8IdFcqy8o4kPiG+AwVUJon6S4n7/k1Ht561G5TOOKQ2BM
	c6Z/9tUBMqZNBhhKYAnW0gQQ7rFMXY5mZwlptC9rhVeON5EzcZF64l3VFNvVGDVi
	OT1bMqKq3lOY/8hDrOhnOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724974246; x=
	1725060646; bh=pTFlrR35IlGPyH0ZeIwt0GOeVFJAfBo04gwzII4JWVw=; b=b
	HUQxBVOTm9cSfmgi8fvrrWwiM/dFSlwLiVN+KCZjG5eD3ikZYFfp8kQB6oRsvniO
	+gx9xiDkI5xV6c0XREJc7yEhTx/xz3HyQ6RzZEnRFrWoqVmwn9yOvZT4XbLOdNvt
	0xTCyB5FEPl34ID8J2qkzdFayovbo/tkvLV8Mvhw+ba9eCWw7LsOQX4HhBguu4dl
	kJlgzzZ5TDFcc2A0YxuhZThvqLLnL/ln6qvofpBywVNk4k9mGPBMIZS3WibGNDd+
	yt2kcYeXZ5QLSfNWYEXcmj2Bj4L9IoMdvv3aus/l1OoUDs6B5QJZy4zMiQgLEqu3
	uYnmm1a8p3PXxeAF+QAUA==
X-ME-Sender: <xms:pQTRZg13uJstish1bPpxsQO6Kt6btNdnGasVZX-CchqSm7gZqwJHMQ>
    <xme:pQTRZrF6clb2G7m1sOo-GOIoSZQ3yQWDtccR80QJ33bqLm3_ZbBuORzDYz5_DU--j
    0KzNSrOOSoAa0u3>
X-ME-Received: <xmr:pQTRZo6bhTnr17dHBhxJ5LS8Vhv9IAIxapZdXDl3WbfC31SCT7_yxv1zouuqXOeTgZqPeuQ2-Onm7RWxyoiGNHhGknccKDSJbtrN_vj508KBCGPO8Y6N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefhedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrh
    htsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeekffevgfdttddukeei
    ffelheelfeehhfduleeiudehhfejhfeghedvfeekteefteenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthes
    fhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthht
    oheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehmihhklhho
    shesshiivghrvgguihdrhhhupdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgt
    phhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:pQTRZp07cFd7qXyGPgY26mOKoCilnUiKVvpevC0R8XthRB7CPHNsWw>
    <xmx:pgTRZjE0WGeJgXso11CGgdywGMMinJBDEtZTEHqTGYdu5kj4D8afrg>
    <xmx:pgTRZi_bhFuWj6OA4sjRdrM7fk1hR5Ktjsx7Wxe3hV1xBN19zaIFUQ>
    <xmx:pgTRZokeb5hDort93p8RSQTcT8Acu10iCbfvi_RMVovcuZXy21Q_sQ>
    <xmx:pgTRZi0TpML0UV40wx09KJasD0nXKLyIHAmtMQy-ywyECbnWmTksv2HD>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 19:30:44 -0400 (EDT)
Message-ID: <d245ed79-3cc5-4f9e-8417-1c2ff1669bd6@fastmail.fm>
Date: Fri, 30 Aug 2024 01:30:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] fuse: use iomap for writeback cache buffered
 writes
To: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
 amir73il@gmail.com, miklos@szeredi.hu, joannelkoong@gmail.com,
 bschubert@ddn.com, willy@infradead.org
References: <cover.1724879414.git.josef@toxicpanda.com>
 <dc1e8cd7300e1b76ae2fe77755acaf216571153b.1724879414.git.josef@toxicpanda.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <dc1e8cd7300e1b76ae2fe77755acaf216571153b.1724879414.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/28/24 23:13, Josef Bacik wrote:
> We're currently using the old ->write_begin()/->write_end() method of
> doing buffered writes.  This isn't a huge deal for fuse since we
> basically just want to copy the pages and move on, but the iomap
> infrastructure gives us access to having huge folios.  Rework the
> buffered write path when we have writeback cache to use the iomap
> buffered write code, the ->get_folio() callback now handles the work
> that we did in ->write_begin(), the rest of the work is handled inside
> of iomap so we don't need a replacement for ->write_end.
> 
> This does bring BLOCK as a dependency, as the buffered write part of
> iomap requires CONFIG_BLOCK.  This could be shed if we reworked the file
> write iter portion of the buffered write path was separated out to not
> need BLOCK.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fuse/Kconfig |   2 +
>  fs/fuse/file.c  | 154 +++++++++++++++++++++---------------------------
>  2 files changed, 68 insertions(+), 88 deletions(-)
> 
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 8674dbfbe59d..8a799324d7bd 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -1,7 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config FUSE_FS
>  	tristate "FUSE (Filesystem in Userspace) support"
> +	depends on BLOCK
>  	select FS_POSIX_ACL
> +	select FS_IOMAP
>  	help
>  	  With FUSE it is possible to implement a fully functional filesystem
>  	  in a userspace program.
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index ab531a4694b3..af91043b44d7 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -21,6 +21,7 @@
>  #include <linux/filelock.h>
>  #include <linux/splice.h>
>  #include <linux/task_io_accounting_ops.h>
> +#include <linux/iomap.h>
>  
>  static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
>  			  unsigned int open_flags, int opcode,
> @@ -1420,6 +1421,63 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
>  	}
>  }
>  
> +static struct folio *fuse_iomap_get_folio(struct iomap_iter *iter,
> +					  loff_t pos, unsigned len)
> +{
> +	struct file *file = (struct file *)iter->private;
> +	struct inode *inode = iter->inode;
> +	struct folio *folio;
> +	loff_t fsize;
> +
> +	folio = iomap_get_folio(iter, pos, len);
> +	if (IS_ERR(folio))
> +		return folio;
> +
> +	fuse_wait_on_folio_writeback(inode, folio);
> +
> +	if (folio_test_uptodate(folio))
> +		return folio;
> +
> +	/*
> +	 * If we're going to write past EOF then avoid the read, but zero the
> +	 * whole thing and mark it uptodate so that if we get a short write we
> +	 * don't try to re-read this page, we just carry on.
> +	 */
> +	fsize = i_size_read(inode);
> +	if (fsize <= folio_pos(folio)) {
> +		folio_zero_range(folio, 0, folio_size(folio));
> +	} else {
> +		int err = fuse_do_readpage(file, &folio->page);
> +		if (err) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			return ERR_PTR(err);
> +		}
> +	}


I wonder if we could optimize out the read when len == PAGE_SIZE (or 
folio_size(folio)). Maybe not in this series, but later. I see that the 
current page code also only acts on the file size, but I don't understand
why a page needs to be read when it gets completely overwritten.



> +
> +	return folio;
> +}
> +
> +static const struct iomap_folio_ops fuse_iomap_folio_ops = {
> +	.get_folio = fuse_iomap_get_folio,
> +};
> +
> +static int fuse_iomap_begin_write(struct inode *inode, loff_t pos, loff_t length,
> +				  unsigned flags, struct iomap *iomap,
> +				  struct iomap *srcmap)
> +{
> +	iomap->type = IOMAP_DELALLOC;
> +	iomap->addr = IOMAP_NULL_ADDR;
> +	iomap->offset = pos;
> +	iomap->length = length;
> +	iomap->folio_ops = &fuse_iomap_folio_ops;
> +	return 0;
> +}
> +
> +static const struct iomap_ops fuse_iomap_write_ops = {
> +	.iomap_begin = fuse_iomap_begin_write,
> +};
> +
>  static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct file *file = iocb->ki_filp;
> @@ -1428,6 +1486,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = mapping->host;
>  	ssize_t err, count;
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> +	bool writethrough = (fc->writeback_cache == 0);
>  
>  	if (fc->writeback_cache) {
>  		/* Update size (EOF optimization) and mode (SUID clearing) */
> @@ -1438,14 +1497,10 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  		if (fc->handle_killpriv_v2 &&
>  		    setattr_should_drop_suidgid(&nop_mnt_idmap,
> -						file_inode(file))) {
> -			goto writethrough;
> -		}
> -
> -		return generic_file_write_iter(iocb, from);
> +						file_inode(file)))
> +			writethrough = true;
>  	}
>  
> -writethrough:
>  	inode_lock(inode);
>  
>  	err = count = generic_write_checks(iocb, from);
> @@ -1464,8 +1519,12 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			goto out;
>  		written = direct_write_fallback(iocb, from, written,
>  				fuse_perform_write(iocb, from));
> -	} else {
> +	} else if (writethrough) {
>  		written = fuse_perform_write(iocb, from);
> +	} else {
> +		written = iomap_file_buffered_write(iocb, from,
> +						    &fuse_iomap_write_ops,
> +						    file);
>  	}
>  out:
>  	inode_unlock(inode);
> @@ -2408,85 +2467,6 @@ static int fuse_writepages(struct address_space *mapping,
>  	return err;
>  }
>  
> -/*
> - * It's worthy to make sure that space is reserved on disk for the write,
> - * but how to implement it without killing performance need more thinking.
> - */
> -static int fuse_write_begin(struct file *file, struct address_space *mapping,
> -		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
> -{
> -	pgoff_t index = pos >> PAGE_SHIFT;
> -	struct fuse_conn *fc = get_fuse_conn(file_inode(file));
> -	struct page *page;
> -	loff_t fsize;
> -	int err = -ENOMEM;
> -
> -	WARN_ON(!fc->writeback_cache);
> -
> -	page = grab_cache_page_write_begin(mapping, index);
> -	if (!page)
> -		goto error;
> -
> -	fuse_wait_on_page_writeback(mapping->host, page->index);
> -
> -	if (PageUptodate(page) || len == PAGE_SIZE)
> -		goto success;
> -	/*
> -	 * Check if the start this page comes after the end of file, in which
> -	 * case the readpage can be optimized away.
> -	 */
> -	fsize = i_size_read(mapping->host);
> -	if (fsize <= (pos & PAGE_MASK)) {
> -		size_t off = pos & ~PAGE_MASK;
> -		if (off)
> -			zero_user_segment(page, 0, off);
> -		goto success;
> -	}
> -	err = fuse_do_readpage(file, page);
> -	if (err)
> -		goto cleanup;

I mean here, I _think_ it could have additionally checked for
len == PAGE_SIZE.

> -success:
> -	*pagep = page;
> -	return 0;
> -
> -cleanup:
> -	unlock_page(page);
> -	put_page(page);
> -error:
> -	return err;
> -}
> -
> -static int fuse_write_end(struct file *file, struct address_space *mapping,
> -		loff_t pos, unsigned len, unsigned copied,
> -		struct page *page, void *fsdata)
> -{
> -	struct inode *inode = page->mapping->host;
> -
> -	/* Haven't copied anything?  Skip zeroing, size extending, dirtying. */
> -	if (!copied)
> -		goto unlock;
> -
> -	pos += copied;
> -	if (!PageUptodate(page)) {
> -		/* Zero any unwritten bytes at the end of the page */
> -		size_t endoff = pos & ~PAGE_MASK;
> -		if (endoff)
> -			zero_user_segment(page, endoff, PAGE_SIZE);
> -		SetPageUptodate(page);
> -	}
> -
> -	if (pos > inode->i_size)
> -		i_size_write(inode, pos);
> -
> -	set_page_dirty(page);
> -
> -unlock:
> -	unlock_page(page);
> -	put_page(page);
> -
> -	return copied;
> -}
> -
>  static int fuse_launder_folio(struct folio *folio)
>  {
>  	int err = 0;
> @@ -3352,8 +3332,6 @@ static const struct address_space_operations fuse_file_aops  = {
>  	.migrate_folio	= filemap_migrate_folio,
>  	.bmap		= fuse_bmap,
>  	.direct_IO	= fuse_direct_IO,
> -	.write_begin	= fuse_write_begin,
> -	.write_end	= fuse_write_end,
>  };
>  
>  void fuse_init_file_inode(struct inode *inode, unsigned int flags)

Thanks,
Bernd


