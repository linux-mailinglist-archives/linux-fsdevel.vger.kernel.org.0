Return-Path: <linux-fsdevel+bounces-9866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C0684562B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 12:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4635285BB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E04B15CD74;
	Thu,  1 Feb 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OlJYy0dg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zrkSg7AV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OlJYy0dg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zrkSg7AV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12215B971;
	Thu,  1 Feb 2024 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786635; cv=none; b=CAJqyKq8XFzYoFQRDjFUQoDr/gNdB8xw//1X8ElW0eMLE69OeRGuJkBdlbUn2+8n+4LCtgpUzPiqTBEldQkOJvS+G0so3MWYXw7J0XBgJ/QhawXvSr0pIMuAAD4UzNonfC/XV1bj+1J6So7bNy5nbwNpdrxYDHcKlrNr0bSmAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786635; c=relaxed/simple;
	bh=4gLLee0IgkSlTcm3hehLbiZKeNVnk/ntZ7Qur7p4Bog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDbdbQLpENsb+qzKxzT1Yt3f9LDsFL24e4k3IEsECwVXY52/dcuKRI5pAMrMCoI4BQvD01/YPOlE1q9ii4/vYuZdDSN0NXFZ4QBYBKY/2MrjgpW8PwFN/zzdqB/tAoqN0ShpMA6CNWRwr+CPFZsyhusNrhwKNT74OF4bBckoI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OlJYy0dg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zrkSg7AV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OlJYy0dg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zrkSg7AV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B057221B3;
	Thu,  1 Feb 2024 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706786631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ORuVqEyWxZM3hdOiTtlUrAIEc3JWNUBItxymrAifwPE=;
	b=OlJYy0dgRDMem8XXRnAmUHkH5Ka4kySxA1oheaiBi9wmAjwYD7HPGrkKMnUP+S5Xiz+TiZ
	KifyyGD57xdr/jFv3zELZV8b6B74A1fnU2gh2eC0t0TlBQOSPpR2ArbBCNvV9UBPHsUqb/
	CGp+GDaWo7Jg60MMaxdUyt6nvuwnqG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706786631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ORuVqEyWxZM3hdOiTtlUrAIEc3JWNUBItxymrAifwPE=;
	b=zrkSg7AVP7PYC3NeZyP35DAyZihsN9UdCAlwyhSqSgd7Wjuz5mkcwfI2/P8E3UmL5lSIL1
	EL6P3BZ5afLtWNBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706786631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ORuVqEyWxZM3hdOiTtlUrAIEc3JWNUBItxymrAifwPE=;
	b=OlJYy0dgRDMem8XXRnAmUHkH5Ka4kySxA1oheaiBi9wmAjwYD7HPGrkKMnUP+S5Xiz+TiZ
	KifyyGD57xdr/jFv3zELZV8b6B74A1fnU2gh2eC0t0TlBQOSPpR2ArbBCNvV9UBPHsUqb/
	CGp+GDaWo7Jg60MMaxdUyt6nvuwnqG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706786631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ORuVqEyWxZM3hdOiTtlUrAIEc3JWNUBItxymrAifwPE=;
	b=zrkSg7AVP7PYC3NeZyP35DAyZihsN9UdCAlwyhSqSgd7Wjuz5mkcwfI2/P8E3UmL5lSIL1
	EL6P3BZ5afLtWNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CE33139B1;
	Thu,  1 Feb 2024 11:23:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aKpQGkd/u2VNIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 11:23:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 20048A0809; Thu,  1 Feb 2024 12:23:47 +0100 (CET)
Date: Thu, 1 Feb 2024 12:23:47 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 29/34] bdev: make struct bdev_handle private to the
 block layer
Message-ID: <20240201112347.jfpr26a5zhgvzmtu@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-29-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-29-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OlJYy0dg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zrkSg7AV
X-Spamd-Result: default: False [-2.35 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.54)[97.92%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7B057221B3
X-Spam-Level: 
X-Spam-Score: -2.35
X-Spam-Flag: NO

On Tue 23-01-24 14:26:46, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

One more thing I've noticed:

> -struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
> -				     const struct blk_holder_ops *hops)
> +int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
> +	      const struct blk_holder_ops *hops, struct file *bdev_file)
>  {
>  	struct bdev_handle *handle = kmalloc(sizeof(struct bdev_handle),
>  					     GFP_KERNEL);
> -	struct block_device *bdev;
>  	bool unblock_events = true;
> -	struct gendisk *disk;
> +	struct gendisk *disk = bdev->bd_disk;
>  	int ret;
>  
> +	handle = kmalloc(sizeof(struct bdev_handle), GFP_KERNEL);

You are leaking handle here. It gets fixed up later in the series but
still...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

