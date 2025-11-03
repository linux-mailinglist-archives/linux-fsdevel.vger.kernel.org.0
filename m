Return-Path: <linux-fsdevel+bounces-66716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE762C2A7FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 09:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1D8C4F2D7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 08:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38722D8DA3;
	Mon,  3 Nov 2025 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zi8CXFTc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TKVA5B8h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="018BWjI4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OUQNZkcn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D4229D280
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157205; cv=none; b=cT/t3evk01Z9Fk8Gr8S4zafZDpMIyPC/MwHYsQGZp7zmwOTdzXw2+MhEzoKq7kQQ++yMMnnrrZOzD+XBmF2rW60gJZ6/Q/XZfVKbvXj5uqJvkXyfZZmM7whTpEafi5FwsuexkOvqXuqbhhZDrhPqPl4+jvV+OtLizPnsQR317z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157205; c=relaxed/simple;
	bh=orVO1CjzazfzcM1r2PIirkigYX7G72QMN2kLOC6NvoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP3DApLC1/66bQx0R3tJQRjCig9ktCG0J/9LjycOjJF1Ls6Tmq0ImQ1I2DI3rwEro9NYKTfchjRdAZVd4a7iyk06s1bSSwdckIyQBV3qz0uHr3G5qFhHSWPZWOSjgDgs8zDgYx+3+kduQrob7S/eprZEgMhVgdKJCoS/taJwpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zi8CXFTc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TKVA5B8h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=018BWjI4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OUQNZkcn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9E9E218E8;
	Mon,  3 Nov 2025 08:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762157198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCkJf14wqV0F4XHGtpv6IsvGx/JTM7DNUNTENvxVbxU=;
	b=zi8CXFTcQaBKBEpxv7jW3Umveo7VgqtbjbyACZo1GbTjQwPDcorm1dOoX2Fkzlq0Le8W7Z
	btudHizqz5EvwlqXOQ/UDkPeQrzjIWq1c/nwBIaBQ3RAWu7RZYky7dzQmT0mOXdF3LVAKS
	fboMrOzYBm+sRlW2IjQOuDoi3rtNtNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762157198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCkJf14wqV0F4XHGtpv6IsvGx/JTM7DNUNTENvxVbxU=;
	b=TKVA5B8hPFYXxiy/uI/8Rk5SdCozQnbaYE7+LwVfmJ06p/Xb+Lcc3AAxwO6+v525r62EHA
	3xHAl02CyVW1tXAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=018BWjI4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OUQNZkcn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762157197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCkJf14wqV0F4XHGtpv6IsvGx/JTM7DNUNTENvxVbxU=;
	b=018BWjI4UciYupwdOCuccVBXRZ2XDz4ea6ZHTB/DxoByTkfFiQn9aVNlepUhZZZVL3TB3C
	hWx8qqKRjPqp/S72VAwSZxlLZF0Xp2V7sgAz3DYOkuw8nW7JorvnSi5rwKVh4mFeMylsPN
	X1E37pTBeIXIrj963W1YYXZBYaLdK5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762157197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCkJf14wqV0F4XHGtpv6IsvGx/JTM7DNUNTENvxVbxU=;
	b=OUQNZkcnZxVs3XQevIvUo8kEsC/6j+XzxjZ9NihmdZtp/sOAR2FXLvP18hvLA5VBsBmA4j
	gutiWwhxOU80b7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA6F91364F;
	Mon,  3 Nov 2025 08:06:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3gNSNY1iCGnNWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 08:06:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 58F69A2A61; Mon,  3 Nov 2025 09:06:33 +0100 (CET)
Date: Mon, 3 Nov 2025 09:06:33 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 05/25] ext4: enable DIOREAD_NOLOCK by default for BS > PS
 as well
Message-ID: <q7podhkdz5bnjif6tm2ldwkdvzafwqc37u67eepajoreu4x2zx@3zypdbhvmouk>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-6-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-6-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: E9E9E218E8
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,huaweicloud.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spamd-Bar: /

On Sat 25-10-25 11:22:01, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The dioread_nolock related processes already support large folio, so
> dioread_nolock is enabled by default regardless of whether the blocksize
> is less than, equal to, or greater than PAGE_SIZE.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 894529f9b0cc..aa5aee4d1b63 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4383,8 +4383,7 @@ static void ext4_set_def_opts(struct super_block *sb,
>  	    ((def_mount_opts & EXT4_DEFM_NODELALLOC) == 0))
>  		set_opt(sb, DELALLOC);
>  
> -	if (sb->s_blocksize <= PAGE_SIZE)
> -		set_opt(sb, DIOREAD_NOLOCK);
> +	set_opt(sb, DIOREAD_NOLOCK);
>  }
>  
>  static int ext4_handle_clustersize(struct super_block *sb)
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

