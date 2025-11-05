Return-Path: <linux-fsdevel+bounces-67083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DA1C34E5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 10:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A767E566264
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08371302CC7;
	Wed,  5 Nov 2025 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b/IzLKtj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+OGkLBWa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GPUxJ8E7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+kwgkb2s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D22FDC2C
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335187; cv=none; b=e0Hu3K5BUR8Y25J2ggO2H17RReAZazDkigs19B1SIK5oIrkD7lucravm78dmaedzg6tcJI25PRYkAwKYYk8dY2osTQ5iWPSebuax/62tTNuPKP3jk3EX0VpRxMfh3LmUgQh1uB8cu+lVFticx7/SqV7Sp7Yv8qMpZDvDTnvzQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335187; c=relaxed/simple;
	bh=aA2bXPltNT3imaXp7EnIRakEH7GhK3nJTc3gLVvHbtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvBowHsW+3ptqVYFkADDlfMPzZJfui5JUt7V8ebtPm+n/njcKR6gg1FQCHDL3JYkxtUw8vMxQlusK+/21DDLlfdoj1i5qqluBSDoD6ilymqpa8YjMLaIU1Fa8iKjEsWqKe5LpS3O+j//N7Dt9E5Cwn3ZeWLeSFlGBYtcLy00XoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b/IzLKtj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+OGkLBWa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GPUxJ8E7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+kwgkb2s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEE4221186;
	Wed,  5 Nov 2025 09:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762335184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=720QJ5QwK5/vr5g/qY55TBuX1V7STFt/v1biLS/zSUc=;
	b=b/IzLKtjV/0eAAbmf17eH6rNdv8R2um9sbE+sD+meEbCy7bs7qxejCiVOSCU/FsH1i+uzu
	ZDPf1HPEqFuJts7cR/HfGh/7BHZnLqHVbeNv/R6JGJZEg0KxrTMMfKkjoAnjtIB3jC7sqG
	z98+1sv+rG/5Llvi/1KwuZpo20EwvDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762335184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=720QJ5QwK5/vr5g/qY55TBuX1V7STFt/v1biLS/zSUc=;
	b=+OGkLBWaNbzrk+xAlP2+3LXX4So3KFAyvyUh0fDLObqSwVxEM+QzcRPG+7uC3p1ATeXm8x
	2U8BnIhsXul6TpBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762335182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=720QJ5QwK5/vr5g/qY55TBuX1V7STFt/v1biLS/zSUc=;
	b=GPUxJ8E7snsfPumu7Mni5yFht/9aqf9kvUjX9sQm5ZoryA4NYy5IzTkmEv+07lGkkgnV9C
	aCTgU+6szYKO5dDqLw88OM4FbleP/BdRG/cDHf1RUbGCLWhMXOqRBqlYvW+xblPeYXsa6P
	ffIBO9EKVaswdWZZBfLrcL+rFRthUFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762335182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=720QJ5QwK5/vr5g/qY55TBuX1V7STFt/v1biLS/zSUc=;
	b=+kwgkb2slUfC1ZEC2lfxhjoL8X0/ffjeTDP6GpQgeG354nOdxItk+VsF3iYCBdDhelPpWv
	vRkc8RY6KvvUrsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E37E7132DD;
	Wed,  5 Nov 2025 09:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hVCKN84ZC2nYHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 09:33:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A430CA083B; Wed,  5 Nov 2025 10:33:02 +0100 (CET)
Date: Wed, 5 Nov 2025 10:33:02 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 20/25] ext4: support large block size in
 __ext4_block_zero_page_range()
Message-ID: <cyj4y73fcmqykv5xnrixngivx6hfkhczdtuo5rxs6kwqcc4aao@vok4hhzzjbog>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-21-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-21-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30

On Sat 25-10-25 11:22:16, libaokun@huaweicloud.com wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> Use the EXT4_P_TO_LBLK() macro to convert folio indexes to blocks to avoid
> negative left shifts after supporting blocksize greater than PAGE_SIZE.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ce48cc6780a3..b3fa29923a1d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4066,7 +4066,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>  
>  	blocksize = inode->i_sb->s_blocksize;
>  
> -	iblock = folio->index << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
> +	iblock = EXT4_P_TO_LBLK(inode, folio->index);
>  
>  	bh = folio_buffers(folio);
>  	if (!bh)
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

