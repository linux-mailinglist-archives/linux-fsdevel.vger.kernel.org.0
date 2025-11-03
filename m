Return-Path: <linux-fsdevel+bounces-66713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07953C2A623
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 08:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3955A4ED9BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 07:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91F52C11E5;
	Mon,  3 Nov 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oHXNX1Pa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pHLY+Hy/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oHXNX1Pa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pHLY+Hy/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15421883E
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155812; cv=none; b=atAmRlh86wq6I2TFmGdgnbFBcDPlXNOOys5QFNQ/HlWDCDPagj4L36DnHZaeX19P0gL9HwzDz4PqMseTj22sv2DIK1KCjHy8Qxy/zU0KgyRfyix39wq/pD6SiiMVhasdQN5pkDkB2TtDzkvLJ8b98EYEbmd0X4+Ogt49o1Qv9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155812; c=relaxed/simple;
	bh=/m7el7qiOG+uRtgB+hXS9l/zlSwOEIYXKrdWDa7gS7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HT+2SZ8NmO8ghi3rXaM5f4NWjtTIoZ26SL0tr8fBKS0XqMyDSExoJi368WO52zjMMPBay6JBO5VUQiIgMR5cO/JjYrsJJFgQGWx7HWQLn3hht53Ua3q9dzO7wGnLVMzWAuuEan6ccZCNziSlFpNjHPAcI+0LCPKycdR8vM3efP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oHXNX1Pa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pHLY+Hy/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oHXNX1Pa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pHLY+Hy/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4614521D9C;
	Mon,  3 Nov 2025 07:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762155809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i1+B9zt2AEIIJkaGtGDVUCOE0R3A1Xscg4L+TVTph6g=;
	b=oHXNX1PazznzOv0TdsXLeV+LALADhxuXwcl6Pm+0iogwUrpycWJY2psgvRUOkUYIw+4bQi
	E1QgV5Ti42OEP1ubrzQSTkseczV7hrSyj+26FA64EZUtTl5DrK1UHVvOY+dZ0DsJDh8akK
	qxzC9dr10socnAM0T/eRTQ+/HWKZg2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762155809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i1+B9zt2AEIIJkaGtGDVUCOE0R3A1Xscg4L+TVTph6g=;
	b=pHLY+Hy/4YS85jrJAA0r7KCCBCWUAEHh1Wyp9LD+wkgdqHNSTY/RTBmx4yG+nRWxbOgD+0
	Buizniao6Vt33TBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762155809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i1+B9zt2AEIIJkaGtGDVUCOE0R3A1Xscg4L+TVTph6g=;
	b=oHXNX1PazznzOv0TdsXLeV+LALADhxuXwcl6Pm+0iogwUrpycWJY2psgvRUOkUYIw+4bQi
	E1QgV5Ti42OEP1ubrzQSTkseczV7hrSyj+26FA64EZUtTl5DrK1UHVvOY+dZ0DsJDh8akK
	qxzC9dr10socnAM0T/eRTQ+/HWKZg2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762155809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i1+B9zt2AEIIJkaGtGDVUCOE0R3A1Xscg4L+TVTph6g=;
	b=pHLY+Hy/4YS85jrJAA0r7KCCBCWUAEHh1Wyp9LD+wkgdqHNSTY/RTBmx4yG+nRWxbOgD+0
	Buizniao6Vt33TBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 346C91364F;
	Mon,  3 Nov 2025 07:43:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TT3MDCFdCGnNQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 07:43:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9AE38A2A61; Mon,  3 Nov 2025 08:43:28 +0100 (CET)
Date: Mon, 3 Nov 2025 08:43:28 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 03/25] ext4: remove PAGE_SIZE checks for rec_len
 conversion
Message-ID: <n7vgicrsj4soriob45vd2pwqtm77jt6wnsk3ie5g66am2oqvji@k2ayujwhxcrx>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-4-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-4-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,huaweicloud.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30

On Sat 25-10-25 11:21:59, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Previously, ext4_rec_len_(to|from)_disk only performed complex rec_len
> conversions when PAGE_SIZE >= 65536 to reduce complexity.
> 
> However, we are soon to support file system block sizes greater than
> page size, which makes these conditional checks unnecessary. Thus, these
> checks are now removed.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 24c414605b08..93c2bf4d125a 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2464,28 +2464,19 @@ static inline unsigned int ext4_dir_rec_len(__u8 name_len,
>  	return (rec_len & ~EXT4_DIR_ROUND);
>  }
>  
> -/*
> - * If we ever get support for fs block sizes > page_size, we'll need
> - * to remove the #if statements in the next two functions...
> - */
>  static inline unsigned int
>  ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
>  {
>  	unsigned len = le16_to_cpu(dlen);
>  
> -#if (PAGE_SIZE >= 65536)
>  	if (len == EXT4_MAX_REC_LEN || len == 0)
>  		return blocksize;
>  	return (len & 65532) | ((len & 3) << 16);
> -#else
> -	return len;
> -#endif
>  }
>  
>  static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
>  {
>  	BUG_ON((len > blocksize) || (blocksize > (1 << 18)) || (len & 3));
> -#if (PAGE_SIZE >= 65536)
>  	if (len < 65536)
>  		return cpu_to_le16(len);
>  	if (len == blocksize) {
> @@ -2495,9 +2486,6 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
>  			return cpu_to_le16(0);
>  	}
>  	return cpu_to_le16((len & 65532) | ((len >> 16) & 3));
> -#else
> -	return cpu_to_le16(len);
> -#endif
>  }
>  
>  /*
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

