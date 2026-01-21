Return-Path: <linux-fsdevel+bounces-74756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALn0KRUZcGkEVwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:08:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B634E502
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31DE77858E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228011A724C;
	Wed, 21 Jan 2026 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcWaMcHm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8D92B2D7
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768953792; cv=none; b=Wroxs5qPnYb4grnL63RW5J+T8GeJ6iMa6EINahhYnZOf4bvTrNGStd496mnL8WkGPHff7sclLz5dQs57AhE8HDCfzgDOijLZeRjyFxyQ+I/jbHB2UXH3kMg7PEoWWAOZkMOuo3rCGoaRPLMxrk5x8CYjufJBCcvZAbYKPdkCbRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768953792; c=relaxed/simple;
	bh=Oc3jJBdUpYbrEYs7BmJNIlWNU66CM+4QTFcEiOQDx7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4A7Lkb12oHLOd23S2UewkouSqGQ1ZPPgCZ+A7xzUAToA+JlBMpUsX0MLleVVBUMe7EwZX0QJfDLeu0YcLOB2jFl9QFRzm82M0QSpBE8wo3XSNUZDmMoHri3HXOdwO96lErT2wqaq83PF7vdLdZFwTy/StWqg1/cXv2ihMTsycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcWaMcHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084BBC16AAE;
	Wed, 21 Jan 2026 00:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768953792;
	bh=Oc3jJBdUpYbrEYs7BmJNIlWNU66CM+4QTFcEiOQDx7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcWaMcHmIpc7hk6yBYplBzlU4Qgb79aLx9+M8OmRibMBJyc1uSBIxMYvfqAnz/NcL
	 cP1Yv7DMOG+tgERWOeTC8iIwQ4dzhyMFOHwgiKANbgrq14414nAa/dUeBs3pso5WdY
	 +WTB/YDOIt2dmWQJ/UANbXJwtDXNyLOnDUVHmMB7uBBRdaaePqcdUhsPT+ipZg3wEX
	 Z6XqjSUVaOaQ3d3uVTu6ugZJ6pTXkaamIHqpzgnb/tiasHvWZ7xxoXf8v/JOYgl0XB
	 DjBb6S1LZAHC9JK+jV/bBKmQ2RLozhJxMkcqi0XKgtXXuWzRVfxpQ42usxEYP5EPby
	 Mixqdo3y77/zA==
Date: Tue, 20 Jan 2026 16:03:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, jefflexu@linux.alibaba.com, luochunsheng@ustc.edu,
	horst@birthelmer.de, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] fuse: validate outarg offset and size in notify
 store/retrieve
Message-ID: <20260121000310.GF15532@frogsfrogsfrogs>
References: <20260120224449.1847176-1-joannelkoong@gmail.com>
 <20260120224449.1847176-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120224449.1847176-2-joannelkoong@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-74756-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 64B634E502
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 02:44:46PM -0800, Joanne Koong wrote:
> Add validation checking for outarg offset and outarg size values passed
> in by the server. MAX_LFS_FILESIZE is the maximum file size supported.
> The fuse_notify_store_out and fuse_notify_retrieve_out structs take in
> a uint64_t offset.
> 
> Add logic to ensure:
> * outarg.offset is less than MAX_LFS_FILESIZE
> * outarg.offset + outarg.size cannot exceed MAX_LFS_FILESIZE
> * potential uint64_t overflow is fixed when adding outarg.offset and
>   outarg.size.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 6d59cbc877c6..7558ff337413 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1781,7 +1781,11 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  	if (size - sizeof(outarg) != outarg.size)
>  		return -EINVAL;
>  
> +	if (outarg.offset >= MAX_LFS_FILESIZE)

Hrmm.  Normally I'd recommend generic_write_check_limits, but you don't
actually have a struct file.

Being pedantic, you might want to check this against
super_block::s_maxbytes, though the current fuse codebase doesn't
support any value other than MAX_LFS_FILESIZE.

(fuse-iomap will allow servers to lower s_maxbytes)

> +		return -EINVAL;
> +
>  	nodeid = outarg.nodeid;
> +	num = min(outarg.size, MAX_LFS_FILESIZE - outarg.offset);
>  
>  	down_read(&fc->killsb);
>  
> @@ -1794,13 +1798,12 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  	index = outarg.offset >> PAGE_SHIFT;
>  	offset = outarg.offset & ~PAGE_MASK;
>  	file_size = i_size_read(inode);
> -	end = outarg.offset + outarg.size;
> +	end = outarg.offset + num;
>  	if (end > file_size) {
>  		file_size = end;
> -		fuse_write_update_attr(inode, file_size, outarg.size);
> +		fuse_write_update_attr(inode, file_size, num);
>  	}
>  
> -	num = outarg.size;
>  	while (num) {
>  		struct folio *folio;
>  		unsigned int folio_offset;
> @@ -1880,7 +1883,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>  	num = min(outarg->size, fc->max_write);
>  	if (outarg->offset > file_size)
>  		num = 0;
> -	else if (outarg->offset + num > file_size)
> +	else if (num > file_size - outarg->offset)
>  		num = file_size - outarg->offset;
>  
>  	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
> @@ -1962,6 +1965,9 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
>  
>  	fuse_copy_finish(cs);
>  
> +	if (outarg.offset >= MAX_LFS_FILESIZE)

Can this actually happen?  It's strange to succeed at injecting data
into the pagecache but then fail anyway.

--D

> +		return -EINVAL;
> +
>  	down_read(&fc->killsb);
>  	err = -ENOENT;
>  	nodeid = outarg.nodeid;
> -- 
> 2.47.3
> 
> 

