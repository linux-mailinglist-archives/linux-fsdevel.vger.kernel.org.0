Return-Path: <linux-fsdevel+bounces-62391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6B5B91151
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 14:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998197B083E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 12:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266C62ED164;
	Mon, 22 Sep 2025 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QDFvADGU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0v4gCqqK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EyqrPxhn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHo0zY0n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0354F2571C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543377; cv=none; b=KLYlxwj/BKE7Hyia8WY9VZrFwLe2CI4xqd/TR6p5r0B4FrFQdZTGaqxJeDRGkGq+vUDEo+KdbP4cwh3l4I26TvckFntRzY6/JKVUQW+ymdoLLE5yWhxPnfG/8Pl0cWDKu4wwaAmOwxEGq00TsHHh3LqJDC1sx1Juxrqdj9vonn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543377; c=relaxed/simple;
	bh=XK9BZmTcdRR7b3Eal0nPeanWmWUJ4J0WKQ20LtEHP9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXGggoY4UDOTq5tGg/XamhXlWx7biJEaeZZKkXV3Yny3TcAJO8SJTsyuCpwcja+LU0Re9yB8vTRU31SwH6jMR5+7vEt4Y4ZAvRNCsh7QWh/KmFbJhuP4sxD2/qflQBm1ZhGPDXQblpDZtieyIpHk7vhu4Pkw0EI3F95ebxolbKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QDFvADGU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0v4gCqqK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EyqrPxhn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHo0zY0n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E75020D14;
	Mon, 22 Sep 2025 12:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758543374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nQfD4gpH0oPcT1XQTuam/BitvpM3QM8iaJC5N7AgbA=;
	b=QDFvADGUAovxZsUAJhva0UGpeitmpgUUb7eFWIPKgYWVYof2dBxgx2Fmq2vcbcZb6YmyAM
	cRpbVYEH4eOMEYoQNDKygavsQWam8S+Zv/Dz7R071DAkizJcTOoUVsNJKHHOc/WzN8UeYT
	r0D5j60rphaD151z4f5FHD0VYSzdsGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758543374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nQfD4gpH0oPcT1XQTuam/BitvpM3QM8iaJC5N7AgbA=;
	b=0v4gCqqKu8e991IhVBYhAX4MWXksqxs2YnXwcp1+iCUudJLsU5vwRC/MoGzvhijWMt1NTc
	JTneRKxKoFroEIBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758543373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nQfD4gpH0oPcT1XQTuam/BitvpM3QM8iaJC5N7AgbA=;
	b=EyqrPxhnUymeo0VdPbvhrwehXriwhSky0YYh5Fa7ZKM9eBBWH4qLHbhi2sl29veIafYB9O
	Z7Cod08uZfGrMhZB40lzrRbnLPv0JpaiMXteNdx5MWH8ZXs7IX87rIGAQY/qckAO9jbO/e
	cdKJml/deiilbG4r5GfewdLKJ96ohPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758543373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/nQfD4gpH0oPcT1XQTuam/BitvpM3QM8iaJC5N7AgbA=;
	b=HHo0zY0nibjv55Xg9VF2YckGzE/u7iX+oUOUydhO3xfJbjzVNySZRt/EGFQy2ubl0djPIY
	/3WlwA7laCGnZ4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02DC413A63;
	Mon, 22 Sep 2025 12:16:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wQyoAA0+0Wg1YQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Sep 2025 12:16:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A4BF0A07C4; Mon, 22 Sep 2025 14:16:08 +0200 (CEST)
Date: Mon, 22 Sep 2025 14:16:08 +0200
From: Jan Kara <jack@suse.cz>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH] fcntl: trim arguments
Message-ID: <r6oazl7ci7yg7tmbszzbuhl7fr5gb43c4ao6urzrfdl5ahlrim@n7pyc2sijkvo>
References: <CGME20250922113152epcas5p2d3aa052da211b541e0182c94b1ba510f@epcas5p2.samsung.com>
 <20250922113046.1037921-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922113046.1037921-1-joshi.k@samsung.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,samsung.com:email,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Mon 22-09-25 17:00:46, Kanchan Joshi wrote:
> Remove superfluous argument from fcntl_{get/set}_rw_hint.
> No functional change.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fcntl.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 5598e4d57422..72f8433d9109 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -355,8 +355,7 @@ static bool rw_hint_valid(u64 hint)
>  	}
>  }
>  
> -static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
> -			      unsigned long arg)
> +static long fcntl_get_rw_hint(struct file *file, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(file);
>  	u64 __user *argp = (u64 __user *)arg;
> @@ -367,8 +366,7 @@ static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
>  	return 0;
>  }
>  
> -static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
> -			      unsigned long arg)
> +static long fcntl_set_rw_hint(struct file *file, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(file);
>  	u64 __user *argp = (u64 __user *)arg;
> @@ -547,10 +545,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>  		err = memfd_fcntl(filp, cmd, argi);
>  		break;
>  	case F_GET_RW_HINT:
> -		err = fcntl_get_rw_hint(filp, cmd, arg);
> +		err = fcntl_get_rw_hint(filp, arg);
>  		break;
>  	case F_SET_RW_HINT:
> -		err = fcntl_set_rw_hint(filp, cmd, arg);
> +		err = fcntl_set_rw_hint(filp, arg);
>  		break;
>  	default:
>  		break;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

