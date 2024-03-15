Return-Path: <linux-fsdevel+bounces-14468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F7387CF61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DA81F235AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C0F3F8E4;
	Fri, 15 Mar 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="blfQOwHO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dE64STh8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="blfQOwHO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dE64STh8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CB03F9E1;
	Fri, 15 Mar 2024 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513958; cv=none; b=S7VU0+sHCONTwb6FyHQxjicIstfanA3/qz1sjsz0qewrZU2aUZza8SKeUTo5UWaoVbt80el7EUPPb/V9mc4kMl23OedW0L43rNtYEKFYNmxNaaoJEDECMJSpRHnlSzlUT7bgJwIxdGoGyDLgKhbVClrYuzbtOmYD1iMbTYKahIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513958; c=relaxed/simple;
	bh=uPN+YJ1HfQtqEoNdKcBycKuuUMyKYyYvvZ+w04xqK6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3fAsDiznZQHrJ1fPKfXwj6sSv9ZDuGiMJIqlhTPONrX28Y1ekpd1n+D7GRz6TWoxQLF9S+RMp0NjMETlt2Snav4imMreAmtgniZy6Mk4VUAvYkLEB8zkyP/r9TFYJkeAyGEsa6AiBr1IAjcJMEFeFt/MACwC/+TGOdbJ3dmiUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=blfQOwHO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dE64STh8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=blfQOwHO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dE64STh8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 366FA21DEC;
	Fri, 15 Mar 2024 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r5CyjYZmyVU0h/qdDobxmou5dXg3aGkSau0zyqO9cfc=;
	b=blfQOwHO7vB2qdL8LDQ7vGWr69RU/W+uCtae0vNSah2nSxMtJs5mZf7jsBdUu1vLFjih5b
	zAblxiVHZXD8k7avpDRcrPiMbZxWCCEHdVqA38HitWqAbAXnf/szvMMCPm2q1ZpvNuSY2P
	QgDGHuDC4dOIMhs+V4JGsq7r1neHx14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r5CyjYZmyVU0h/qdDobxmou5dXg3aGkSau0zyqO9cfc=;
	b=dE64STh8F2xGHLViUi01rg8vMLVZ2EARShfdYrnEDf/5qg9G5o1H8cnnxTpBxTrH23pUeS
	HVFtJcJxX4A+5xBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r5CyjYZmyVU0h/qdDobxmou5dXg3aGkSau0zyqO9cfc=;
	b=blfQOwHO7vB2qdL8LDQ7vGWr69RU/W+uCtae0vNSah2nSxMtJs5mZf7jsBdUu1vLFjih5b
	zAblxiVHZXD8k7avpDRcrPiMbZxWCCEHdVqA38HitWqAbAXnf/szvMMCPm2q1ZpvNuSY2P
	QgDGHuDC4dOIMhs+V4JGsq7r1neHx14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r5CyjYZmyVU0h/qdDobxmou5dXg3aGkSau0zyqO9cfc=;
	b=dE64STh8F2xGHLViUi01rg8vMLVZ2EARShfdYrnEDf/5qg9G5o1H8cnnxTpBxTrH23pUeS
	HVFtJcJxX4A+5xBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B1641368C;
	Fri, 15 Mar 2024 14:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hkCCCiNf9GUGRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 14:45:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C7A79A07D9; Fri, 15 Mar 2024 15:45:46 +0100 (CET)
Date: Fri, 15 Mar 2024 15:45:46 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 07/19] erofs: prevent direct access of
 bd_inode
Message-ID: <20240315144546.c7qwdiwzlcrpdweu@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-8-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-8-yukuai1@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.07
X-Spamd-Result: default: False [-2.07 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.27)[89.78%]
X-Spam-Flag: NO

On Thu 22-02-24 20:45:43, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that all filesystems stash the bdev file, it's ok to get inode
> for the file.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/erofs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 433fc39ba423..dc2d43abe8c5 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -70,7 +70,7 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>  	if (erofs_is_fscache_mode(sb))
>  		buf->inode = EROFS_SB(sb)->s_fscache->inode;
>  	else
> -		buf->inode = sb->s_bdev->bd_inode;
> +		buf->inode = file_inode(sb->s_bdev_file);
>  }
>  
>  void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

