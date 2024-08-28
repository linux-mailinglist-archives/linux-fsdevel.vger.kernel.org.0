Return-Path: <linux-fsdevel+bounces-27603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968DC962C6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A27F1F25CA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2181A4B6F;
	Wed, 28 Aug 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y7rYdcRQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4u4aZXl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CFxc6WFe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8iehbQLw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5D1A3BA1;
	Wed, 28 Aug 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859079; cv=none; b=Vnp0yBPJYfWrXQFCo2R3pT0oAllLfkpR+yWl+vXi1ta7vk7H3Xx2Xh5QnUnojAolYAAxwVA7lrpdpTY6OIFQLwzvxVZZaNeTVCqHmzUkzXnrmOKncigOnbtzSjxv3FbgMdtIgy3R1S5fATl1680dBoDYWBKGYPhZVdOnBPBLVyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859079; c=relaxed/simple;
	bh=7+FvgUqMo200TNqjygfZfe6YbVbnUCy5WJkoyzFztZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUTcdRjKa7CygEXSOB3/OByr7mltuEDLEjngJmHyKwjYyzOnr7E7KxLENbfvN43CsD3Sf5Qx71Se1iAne9ihCCEAJBis7nRaMCAUMYRRRH1Gh3UVCgCqxN4oHl8Sro2z0Xjb07dnZr/iB/d9KkJG+VS1j5ah5g6PesLKoETWo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y7rYdcRQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4u4aZXl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CFxc6WFe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8iehbQLw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF6D921B27;
	Wed, 28 Aug 2024 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724859076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g47bOqualS+Xf14l46cXJeDn1Uj8OzVWMX9HkIH0YlU=;
	b=y7rYdcRQfkTtchLByLSjoN9oEJNBaLYTTpEGsm2cMqPQzvX5I7+srULk1XQwTHeEXB+5uJ
	P3f3x+b++/3anPZcXl8drF0MbmGW9SDl6aQ5+Rhd/XrFr/wWrmxexj5CBZAF7wNQoK516/
	e65/LIMgwzjb23PErzyNHkF4fNDUEys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724859076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g47bOqualS+Xf14l46cXJeDn1Uj8OzVWMX9HkIH0YlU=;
	b=N4u4aZXlHlsU2PfmH40oCmldtiNRg0fPGlc5To6gQ3pdch1ov0K+v6lP30HZXsjbcqFajz
	FPlqJSut+kBrzPCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CFxc6WFe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8iehbQLw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724859075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g47bOqualS+Xf14l46cXJeDn1Uj8OzVWMX9HkIH0YlU=;
	b=CFxc6WFeHM5MBrTmsNrdfYPed4zhrBaC3tC3E993wzyznA/Tv6Y+ZbEaRnLv/vlOMtsTyu
	5PozC8BxSG1jibRlGCa9vn1T0KoAR40652IXLHHexmesQ6MH0ZyBPyxs/V4+c8JpZHZ1lG
	U3HHD8okwhFSiD9lYJ0wpTpFMKw0z98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724859075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g47bOqualS+Xf14l46cXJeDn1Uj8OzVWMX9HkIH0YlU=;
	b=8iehbQLw/iCWJib7AUi7MRs3OeS2cX99Vkfx2Mbm39bcxSP53cwMnTBq+CeI+dlSolFO3s
	GIXlk+GgDqwCUeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E562A138D2;
	Wed, 28 Aug 2024 15:31:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RqL+N8NCz2bLUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 15:31:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C68EA0965; Wed, 28 Aug 2024 17:31:15 +0200 (CEST)
Date: Wed, 28 Aug 2024 17:31:15 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/6] block: remove checks for FALLOC_FL_NO_HIDE_STALE
Message-ID: <20240828153115.vhgsc7obs34b2bws@quack3>
References: <20240827065123.1762168-1-hch@lst.de>
 <20240827065123.1762168-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827065123.1762168-2-hch@lst.de>
X-Rspamd-Queue-Id: EF6D921B27
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 27-08-24 08:50:45, Christoph Hellwig wrote:
> While the FALLOC_FL_NO_HIDE_STALE value has been registered, it has
> always been rejected by vfs_fallocate before making it into
> blkdev_fallocate because it isn't in the supported mask.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/fops.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 9825c1713a49a9..7f48f03a62e9a8 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -771,7 +771,7 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  
>  #define	BLKDEV_FALLOC_FL_SUPPORTED					\
>  		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
> -		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
> +		 FALLOC_FL_ZERO_RANGE)
>  
>  static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  			     loff_t len)
> @@ -830,14 +830,6 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  					     len >> SECTOR_SHIFT, GFP_KERNEL,
>  					     BLKDEV_ZERO_NOFALLBACK);
>  		break;
> -	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
> -		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
> -		if (error)
> -			goto fail;
> -
> -		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> -					     len >> SECTOR_SHIFT, GFP_KERNEL);
> -		break;
>  	default:
>  		error = -EOPNOTSUPP;
>  	}
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

