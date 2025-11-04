Return-Path: <linux-fsdevel+bounces-66902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87252C30251
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70621885964
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 08:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C16A2BD5BB;
	Tue,  4 Nov 2025 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eJPrZOpe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zZD60Nvn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eJPrZOpe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zZD60Nvn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458AC24290D
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246759; cv=none; b=Xa2ihYR0tIb2JYhhcA0FAWN6AQKG3rRV0+lFISixn6na09stSEpMkVg3vGzxVmsxFynQ3cXRhoUW8p016py4XNY1xUC/qZYMmi5AbC355azRD3XWgPV1U2dXPdh9xnCGqEucDLYa00WuF7QeUwQ8S6T00WDuEzOhfyP6uQXaxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246759; c=relaxed/simple;
	bh=5JMNWhwcNO8dRjYHih9/DdKYtWKpXKT/ZdkKaFVrUZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3fRwZJrTK+d7OU0m1RURdGujf5dGESTe1IlJefQYtSk+0DZ09XXYmSVSClMtYY5HPUmtDgmoLXP9llScPXfnirY4e94ppWdVnsb2/OQX5uZD1SNArrxCANVlg2c7tGr85CSv0bXlQkjd4bkrBJ0MscoYG3BEwot3fFS2kjmNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eJPrZOpe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zZD60Nvn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eJPrZOpe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zZD60Nvn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46D4821181;
	Tue,  4 Nov 2025 08:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762246755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYheQBRGcVqlTXI1JyYQyiIeOMV9/eRoJPBxMRYmLiw=;
	b=eJPrZOpeDwh2UQNXtYYYqgOaVT4Y8SZAdag42bF55AoMJNHro1CVT4rZ+NedKhPDWizk3e
	ws90OrlGFEo6CbBZt0zdQsHL/tT5FDeq6p5pbkC/tdAalESkWgwIoJaYoL03y2fM+uEQFS
	dhr5ySjzdS1+XdzBlbh9quKyPq2AE08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762246755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYheQBRGcVqlTXI1JyYQyiIeOMV9/eRoJPBxMRYmLiw=;
	b=zZD60Nvn11Ir61m8JDukAbMAKPj0ZET+tuQKJHK2hxYNj/tMeTnmmqE62QLu0qSCY/psRF
	6l5y6wYR10R0nSBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eJPrZOpe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zZD60Nvn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762246755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYheQBRGcVqlTXI1JyYQyiIeOMV9/eRoJPBxMRYmLiw=;
	b=eJPrZOpeDwh2UQNXtYYYqgOaVT4Y8SZAdag42bF55AoMJNHro1CVT4rZ+NedKhPDWizk3e
	ws90OrlGFEo6CbBZt0zdQsHL/tT5FDeq6p5pbkC/tdAalESkWgwIoJaYoL03y2fM+uEQFS
	dhr5ySjzdS1+XdzBlbh9quKyPq2AE08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762246755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYheQBRGcVqlTXI1JyYQyiIeOMV9/eRoJPBxMRYmLiw=;
	b=zZD60Nvn11Ir61m8JDukAbMAKPj0ZET+tuQKJHK2hxYNj/tMeTnmmqE62QLu0qSCY/psRF
	6l5y6wYR10R0nSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38493139A9;
	Tue,  4 Nov 2025 08:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O+S2DWPACWkzegAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 08:59:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EDCC7A2812; Tue,  4 Nov 2025 09:59:10 +0100 (CET)
Date: Tue, 4 Nov 2025 09:59:10 +0100
From: Jan Kara <jack@suse.cz>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [PATCH v4 5/5] block: add __must_check attribute to
 sb_min_blocksize()
Message-ID: <7tabta4e54yl3jsk7axwrs2kabefv236wc7ijrlogb222bxidp@oozpqae467ax>
References: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
 <20251103163617.151045-6-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251103163617.151045-6-yangyongpeng.storage@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 46D4821181
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -2.51

On Tue 04-11-25 00:36:18, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> When sb_min_blocksize() returns 0 and the return value is not checked,
> it may lead to a situation where sb->s_blocksize is 0 when
> accessing the filesystem super block. After commit a64e5a596067bd
> ("bdev: add back PAGE_SIZE block size validation for
> sb_set_blocksize()"), this becomes more likely to happen when the
> block device’s logical_block_size is larger than PAGE_SIZE and the
> filesystem is unformatted. Add the __must_check attribute to ensure
> callers always check the return value.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c       | 2 +-
>  include/linux/fs.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 810707cca970..638f0cd458ae 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -231,7 +231,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
>  
>  EXPORT_SYMBOL(sb_set_blocksize);
>  
> -int sb_min_blocksize(struct super_block *sb, int size)
> +int __must_check sb_min_blocksize(struct super_block *sb, int size)
>  {
>  	int minsize = bdev_logical_block_size(sb->s_bdev);
>  	if (size < minsize)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444..26d4ca0f859a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3424,7 +3424,7 @@ extern void inode_sb_list_add(struct inode *inode);
>  extern void inode_add_lru(struct inode *inode);
>  
>  extern int sb_set_blocksize(struct super_block *, int);
> -extern int sb_min_blocksize(struct super_block *, int);
> +extern int __must_check sb_min_blocksize(struct super_block *, int);
>  
>  int generic_file_mmap(struct file *, struct vm_area_struct *);
>  int generic_file_mmap_prepare(struct vm_area_desc *desc);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

