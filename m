Return-Path: <linux-fsdevel+bounces-66712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C1CC2A62C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 08:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914CF3B45F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 07:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB312C0F71;
	Mon,  3 Nov 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E2fj1xwv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6/uq2ziu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XuPUqwaR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eT2I3gKQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62842C08C5
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155739; cv=none; b=eedelMiH9RQmvHCOTtPkNmKDB1q7IUTzWIYZc7NgJqRXEHn8x4q+hOLGwX/uxbttmfo+lA/hb3o2m4QQ1xT7TeYppFPwdCl9RjWB/lzFJFauFuMGqQ9hvc9WdPOO6P2e9HIAXGgAzItF/ruCJ89GAUOtPDunVmgdXiJvtstPp4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155739; c=relaxed/simple;
	bh=crKHLDrv/tguAh340pk3PYsJ1AIDc7B11a5UgOyZew4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uERa2D3EGFvNF7RgNlJd+ZEJPVkpkrYafctU3fdwAALJ9sx5tFh5SpATdp5g3q4X6ohwEqp5SCq0723WhKn1PPnb+jsd5sCt2+d8ryID5lJqjkTwZCJLzmEMwjmweW2U4pWFQpcif3TGF4CZtaWgqLAo+RHq3h5DrNO9KnQ/eHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E2fj1xwv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6/uq2ziu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XuPUqwaR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eT2I3gKQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE18321D91;
	Mon,  3 Nov 2025 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762155736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UimfoG96X1jvnyXzTz1B//n6UQMpn5oIqKnAct0hN4c=;
	b=E2fj1xwv0B+gyuP6qYpBTM7md69BXYUOjZPxuF8JoWVgi0aazNVCDfJUHVCkh33CtLKcDm
	O+VA91snFtoUyK8xI2DGKenuFbYRqY+BcJlwAymb1AFkjpzGKEKYqObOy2CaOR3rqVp47I
	/r2oE0Hu/qj1um83dnXReFOZ788D3ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762155736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UimfoG96X1jvnyXzTz1B//n6UQMpn5oIqKnAct0hN4c=;
	b=6/uq2ziuGvsIQqpmyavnq9XJY80lnnyvGE/hhi5j5lKSzoqMg3PQL+RONXWLu5fgR5mJmM
	Jruvqcj5z3FxnRBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XuPUqwaR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eT2I3gKQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762155735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UimfoG96X1jvnyXzTz1B//n6UQMpn5oIqKnAct0hN4c=;
	b=XuPUqwaRNb67Fp//e+jApIHky15QPii6rtbOqLcACZLNreQUWESyexkWth3+7en734lgmO
	NPMXuAUyOzxKWGgpBtAeulhPQCJBLy2FV1ZBF1bF+5t0hgGSj2yMLQjE2ugcILEWy2vV7y
	8HVaw2zH2XZTYYRLZ/arwFBrb5qbRNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762155735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UimfoG96X1jvnyXzTz1B//n6UQMpn5oIqKnAct0hN4c=;
	b=eT2I3gKQkdHL7CAykIvAckQpPuJL/WThAe57YUPfXR6NW25GxkKuk50ag44Zh1SIAUdtMH
	2Crn0lgXnBsE1fAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC08E1364F;
	Mon,  3 Nov 2025 07:42:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I679KddcCGlyQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 07:42:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2DDE3A2A61; Mon,  3 Nov 2025 08:42:15 +0100 (CET)
Date: Mon, 3 Nov 2025 08:42:15 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 02/25] ext4: remove page offset calculation in
 ext4_block_truncate_page()
Message-ID: <bk6mmw6msixyg6boqodonkmyxrok2bkrhklosuwyxcipgmfdcw@3knvjhm4ggyb>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-3-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-3-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: BE18321D91
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.15
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.15 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.14)[-0.724];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,huaweicloud.com:email,suse.com:email]
X-Spamd-Bar: /

On Sat 25-10-25 11:21:58, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> For bs <= ps scenarios, calculating the offset within the block is
> sufficient. For bs > ps, an initial page offset calculation can lead to
> incorrect behavior. Thus this redundant calculation has been removed.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0742039c53a7..4c04af7e51c9 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4183,7 +4183,6 @@ static int ext4_block_zero_page_range(handle_t *handle,
>  static int ext4_block_truncate_page(handle_t *handle,
>  		struct address_space *mapping, loff_t from)
>  {
> -	unsigned offset = from & (PAGE_SIZE-1);
>  	unsigned length;
>  	unsigned blocksize;
>  	struct inode *inode = mapping->host;
> @@ -4192,8 +4191,8 @@ static int ext4_block_truncate_page(handle_t *handle,
>  	if (IS_ENCRYPTED(inode) && !fscrypt_has_encryption_key(inode))
>  		return 0;
>  
> -	blocksize = inode->i_sb->s_blocksize;
> -	length = blocksize - (offset & (blocksize - 1));
> +	blocksize = i_blocksize(inode);
> +	length = blocksize - (from & (blocksize - 1));
>  
>  	return ext4_block_zero_page_range(handle, mapping, from, length);
>  }
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

