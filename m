Return-Path: <linux-fsdevel+bounces-28840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BF996F19E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 12:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D0B1F22C8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 10:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FBD1CB331;
	Fri,  6 Sep 2024 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VxIbWCSd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GzQRXWVu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VxIbWCSd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GzQRXWVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233FE1CB330;
	Fri,  6 Sep 2024 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618905; cv=none; b=Y+nF5OsN3OcyeHs1Xg0FIFLbydSWr97Q2qnvHh/7JI3BxAPbNJpib8pR3mkgs73/uPN3wcNBfMZcuEkLi1RQhFgdSTDGR5GxjwlHqvWIBwDXmqAgxlPwn7vfulF73slE+RBX1WAw0dKsyrVi1om4rqyEVTX/CmajwTfx610bugo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618905; c=relaxed/simple;
	bh=b56kdRsrB+JHLS7XL/+bGIvqGhbjDPYS1044NW96Caw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8pK4SGtlb3hSssf481qigCX5Rnrj8yaVCRxGdsx5W2LGbJo82siDJdH90VO5iM1Q9HCvnvavN5TOLSn3g/C28DvvRfwTsLG85Bi8nxWuWd6hr5tlV5n2KoJHloLTuj11znTCyZKLlr8lmygbmCa4Qp8csl+UwqYNB1d50BU2Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VxIbWCSd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GzQRXWVu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VxIbWCSd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GzQRXWVu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40CCB1F8AE;
	Fri,  6 Sep 2024 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725618901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFKWNo91PnrF9PUzgiavnn58GXarCN+rHFa74Ng0Amg=;
	b=VxIbWCSdqcsleZuCNb3nPkoGFkAdZz+Cw0E5GqFzSxFZruRjMztfut4dJjM8zOHhimCest
	W4MMljGYmC64BZEhvoYncJ784oc8M6x4NIHeejI7IEveiyJ57NbGFdzuTGJrpU8MOXBpKu
	7rIHSmP0OVP/pkZCy6MrHROZB/9eSto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725618901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFKWNo91PnrF9PUzgiavnn58GXarCN+rHFa74Ng0Amg=;
	b=GzQRXWVuokKn3GanI1End9tMtzn9IuWkqnac8GTIEje8F9R7n5FCWSZpajgzlzqO1OwwGl
	3MK/HHiZSxRbrxCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725618901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFKWNo91PnrF9PUzgiavnn58GXarCN+rHFa74Ng0Amg=;
	b=VxIbWCSdqcsleZuCNb3nPkoGFkAdZz+Cw0E5GqFzSxFZruRjMztfut4dJjM8zOHhimCest
	W4MMljGYmC64BZEhvoYncJ784oc8M6x4NIHeejI7IEveiyJ57NbGFdzuTGJrpU8MOXBpKu
	7rIHSmP0OVP/pkZCy6MrHROZB/9eSto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725618901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFKWNo91PnrF9PUzgiavnn58GXarCN+rHFa74Ng0Amg=;
	b=GzQRXWVuokKn3GanI1End9tMtzn9IuWkqnac8GTIEje8F9R7n5FCWSZpajgzlzqO1OwwGl
	3MK/HHiZSxRbrxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D208136A8;
	Fri,  6 Sep 2024 10:35:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qyd7BtXa2mbVbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Sep 2024 10:35:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BABA3A0962; Fri,  6 Sep 2024 12:34:45 +0200 (CEST)
Date: Fri, 6 Sep 2024 12:34:45 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -next] ext4: don't pass full mapping flags to
 ext4_es_insert_extent()
Message-ID: <20240906103445.pwdlkivrlqh3redb@quack3>
References: <20240906061401.2980330-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906061401.2980330-1-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Fri 06-09-24 14:14:01, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When converting a delalloc extent in ext4_es_insert_extent(), since we
> only want to pass the info of whether the quota has already been claimed
> if the allocation is a direct allocation from ext4_map_create_blocks(),
> there is no need to pass full mapping flags, so changes to just pass
> whether the EXT4_GET_BLOCKS_DELALLOC_RESERVE bit is set.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -863,8 +863,8 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> -	es_debug("add [%u/%u) %llu %x %x to extent status tree of inode %lu\n",
> -		 lblk, len, pblk, status, flags, inode->i_ino);
> +	es_debug("add [%u/%u) %llu %x %d to extent status tree of inode %lu\n",
> +		 lblk, len, pblk, status, delalloc_reserve_used, inode->i_ino);

Ah, I didn't know 'bool' gets automatically promoted to 'int' when passed
as variadic argument but it seems to be the case from what I've found. One
always learns :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

