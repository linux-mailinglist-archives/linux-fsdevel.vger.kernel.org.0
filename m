Return-Path: <linux-fsdevel+bounces-66722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EE8C2A933
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 09:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E217E3A35DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 08:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B202DCF45;
	Mon,  3 Nov 2025 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xXvgWBWa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2BoyNGSZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="njdsz/S1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dGiRpTqG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E952C15B7
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158411; cv=none; b=bh9OsRefWYJDMutz144W0UPidChS1dElVVPCM4nRAQ3doMfmQ1iX4kZYXgaq+U89gGkzoKYLnXlUH44gXUUayEWe8cd+xwdFXC+tKaMuqr/RqWqGkWVxoa3ZA6Tm7lgao0iedtZKmdibaxhL67HRxWe4kkKYEXvLwZz7mfM1q3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158411; c=relaxed/simple;
	bh=Q8j8g1IDui0QHn+UDKOcIev96PqxCVJRKbXZw0iBdzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V13GZ/xU5wvwuaCDo47dWzoDYXdPUMHuZgQNQsto4qpwTXAoMOafZy4emTx9yBJSr37MHXLrzUa8DBhPN3KGUb9UOT2OGtDDnwrLdhcVEjiHKOTOwM4hTx7pXSzSCXhosOxrj92ot8t2baczBOOpJhnONWjumVGXvw0RYiSCqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xXvgWBWa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2BoyNGSZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=njdsz/S1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dGiRpTqG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0D582197D;
	Mon,  3 Nov 2025 08:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762158408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f2hFRJn2Kyi+oiGmF+GmQxzUb4rMnpUBXOo5howiaPk=;
	b=xXvgWBWaI0TcQXOZru6k0WqUinTS94hmPAx/q4qEy6gzlBs5pu5IscfKajV+wThWG6QVTp
	wVQaPkOlnPCqfOGHhrKflxQhjGULxzOhI4lMbuZBHanygTXaLcbJf1rQkspQfLld+On9ST
	ZEliQZ5dB/qkhpjERcClCXldBX0cF8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762158408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f2hFRJn2Kyi+oiGmF+GmQxzUb4rMnpUBXOo5howiaPk=;
	b=2BoyNGSZgTP0nCZtIsQ2EgFbD8osvf1aJ1+ONKPuuxNmX7dEB8kYgbFYBL/DJbWf816Npp
	+YVZIXnDJmIYHKAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762158407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f2hFRJn2Kyi+oiGmF+GmQxzUb4rMnpUBXOo5howiaPk=;
	b=njdsz/S1Ks3UNOM9LmJYFGUgDv0aboQSkK7JvAtUukyEPtFrLw+Mqt8YzaGau8v1OkMzeR
	4UZABYFAKe7utWKKR3HuRaJk1rpdUpjJBiy8kTUbCYbAo/NPdp6FHSFjIbDAvLNyRFGV0i
	43sWzAXW26wE5f1ZJEKZlj5xqHCk0qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762158407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f2hFRJn2Kyi+oiGmF+GmQxzUb4rMnpUBXOo5howiaPk=;
	b=dGiRpTqGuMsxwpcYYT+YJU5TZbLhUp7CZlcwQIQTmbw1++n+FywebiJETkByfopFU2wle0
	134baiDqb2hA4jDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDD86139A9;
	Mon,  3 Nov 2025 08:26:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WCEoNkdnCGnZbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 08:26:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 43236A2A64; Mon,  3 Nov 2025 09:26:47 +0100 (CET)
Date: Mon, 3 Nov 2025 09:26:47 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 10/25] ext4: add EXT4_LBLK_TO_P and EXT4_P_TO_LBLK for
 block/page conversion
Message-ID: <pgrk2x54egzxcvmfi4rra3exooxe3yxuvug6yvbtrgxm2oppym@fy52xh4weeww>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-11-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-11-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 

On Sat 25-10-25 11:22:06, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> As BS > PS support is coming, all block number to page index (and
> vice-versa) conversions must now go via bytes. Added EXT4_LBLK_TO_P()
> and EXT4_P_TO_LBLK() macros to simplify these conversions and handle
> both BS <= PS and BS > PS scenarios cleanly.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

'P' in the macro names seems too terse :). I'd probably use PG to give a
better hint this is about pages? So EXT4_LBLK_TO_PG() and
EXT4_PG_TO_LBLK(). BTW, patch 8 could already use these macros...

								Honza

> ---
>  fs/ext4/ext4.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9b236f620b3a..8223ed29b343 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -369,6 +369,12 @@ struct ext4_io_submit {
>  	(round_up((offset), i_blocksize(inode)) >> (inode)->i_blkbits)
>  #define EXT4_LBLK_TO_B(inode, lblk) ((loff_t)(lblk) << (inode)->i_blkbits)
>  
> +/* Translate a block number to a page index */
> +#define EXT4_LBLK_TO_P(inode, lblk)	(EXT4_LBLK_TO_B((inode), (lblk)) >> \
> +					 PAGE_SHIFT)
> +/* Translate a page index to a block number */
> +#define EXT4_P_TO_LBLK(inode, pnum)	(((loff_t)(pnum) << PAGE_SHIFT) >> \
> +					 (inode)->i_blkbits)
>  /* Translate a block number to a cluster number */
>  #define EXT4_B2C(sbi, blk)	((blk) >> (sbi)->s_cluster_bits)
>  /* Translate a cluster number to a block number */
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

