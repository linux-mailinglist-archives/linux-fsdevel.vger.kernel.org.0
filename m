Return-Path: <linux-fsdevel+bounces-70008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A196C8E2C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 377D64E6E99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DCA329367;
	Thu, 27 Nov 2025 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NrYJB/T7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ovzNk96H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RsJ73QvS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qvMnU4Kg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2952302158
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764244974; cv=none; b=f5GY7DmCLZ82CJ/vpnKRqQTNlka9iaajFN2KTT6/DrirL8FkONSO+evqd1WUOXk4oSfSJPdpEJYR+f+N7rCXjZyX3UJzIY8yw9GJ/uwkR2uu9EhMOqTmSHHbOhA2R81tVLyhL80fnR9QkF+59Qj3PYFpDWMcKSi4T9W1uJWm6Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764244974; c=relaxed/simple;
	bh=9XhlumSxZrSglvh9PHtZZF4M003LbnikYYNnEj6rOaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiBvbwghOaTbpEH44Gr5z7k6fRl7IFNmOy+HkHDULuK3gQQKCe+pvTAOmCd1KrqplJQ4PdMkkqhD+QJNZOc2nHgIQrYLEpn+7J2b+eC+1C5jMfo0qNfFckOnhZTQyk4uutMoViXVjxhW+cSqq3VXGuvHKsIikJEpY9AhItgf9SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NrYJB/T7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ovzNk96H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RsJ73QvS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qvMnU4Kg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B68235BCF8;
	Thu, 27 Nov 2025 12:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764244971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myvyhD4X+NDWt68bgWonmP98CjgPrjfzkgUNoq6+d2c=;
	b=NrYJB/T7MU/Ta1lvnD+zQkWfvYuFPapV/ukSv0IOrMrvNjnwbOxx21mA2EM4V8R9c1rcFt
	U4Ei1ZgmDlVUrku2KOx44UD8CO/kV2+HtFiYlius/HjbW/hgOU0HhE6F4/yXcu1Y3obden
	UX8H5KZheGKp1gN8ClHOJfJpX/kguKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764244971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myvyhD4X+NDWt68bgWonmP98CjgPrjfzkgUNoq6+d2c=;
	b=ovzNk96H970Kch2AZc03hw17nJKxqrwohEA6ZrQ9Lx4sP3ocFd5ORoL+ipksPZj+OUT00q
	g+6H48hRmGAWqKAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764244970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myvyhD4X+NDWt68bgWonmP98CjgPrjfzkgUNoq6+d2c=;
	b=RsJ73QvSDDDc9Gbl6cWNQpnDYHVu+zDkq9Quhu0brDE8715ULNQ9LU7uC8D/TKudRU0XRm
	MI8VSauCEmxgIadMGO+t+c7TX/EhR0VUvApYR1UQn2HhVJ/aVI6mX2o+Cq3NSNnnSXUDWG
	x22G5+j8E9iVb6Wxz1zaRNvE3Q2zIck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764244970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myvyhD4X+NDWt68bgWonmP98CjgPrjfzkgUNoq6+d2c=;
	b=qvMnU4Kgk62OwZ28FjTzDEiA2hw10eh6FLrtTd4fmQY4Fr9FoMUzexDM9JZ+X9MwuflF3r
	nJFw6nC+YfFGJNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93F523EA63;
	Thu, 27 Nov 2025 12:02:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id goMaJOo9KGnwegAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 12:02:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 02916A0C94; Thu, 27 Nov 2025 13:02:49 +0100 (CET)
Date: Thu, 27 Nov 2025 13:02:49 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 01/13] ext4: cleanup zeroout in ext4_split_extent_at()
Message-ID: <msavgjqicoxnjloi53fa6stdurfqjxho5fwka7dusyrrjrdtep@spfzuymowwdd>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121060811.1685783-2-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,huawei.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 21-11-25 14:07:59, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> zero_ex is a temporary variable used only for writing zeros and
> inserting extent status entry, it will not be directly inserted into the
> tree. Therefore, it can be assigned values from the target extent in
> various scenarios, eliminating the need to explicitly assign values to
> each variable individually.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Nice simplification. I'd just note that the new method copies also the
unwritten state of the original extent to zero_ex (the old method didn't do
this). It doesn't matter in this case but it might still be nice to add a
comment about it before the code doing the copying. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 63 ++++++++++++++++++-----------------------------
>  1 file changed, 24 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c7d219e6c6d8..91682966597d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3278,46 +3278,31 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  	ex = path[depth].p_ext;
>  
>  	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
> -		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
> -			if (split_flag & EXT4_EXT_DATA_VALID1) {
> -				err = ext4_ext_zeroout(inode, ex2);
> -				zero_ex.ee_block = ex2->ee_block;
> -				zero_ex.ee_len = cpu_to_le16(
> -						ext4_ext_get_actual_len(ex2));
> -				ext4_ext_store_pblock(&zero_ex,
> -						      ext4_ext_pblock(ex2));
> -			} else {
> -				err = ext4_ext_zeroout(inode, ex);
> -				zero_ex.ee_block = ex->ee_block;
> -				zero_ex.ee_len = cpu_to_le16(
> -						ext4_ext_get_actual_len(ex));
> -				ext4_ext_store_pblock(&zero_ex,
> -						      ext4_ext_pblock(ex));
> -			}
> -		} else {
> -			err = ext4_ext_zeroout(inode, &orig_ex);
> -			zero_ex.ee_block = orig_ex.ee_block;
> -			zero_ex.ee_len = cpu_to_le16(
> -						ext4_ext_get_actual_len(&orig_ex));
> -			ext4_ext_store_pblock(&zero_ex,
> -					      ext4_ext_pblock(&orig_ex));
> -		}
> +		if (split_flag & EXT4_EXT_DATA_VALID1)
> +			memcpy(&zero_ex, ex2, sizeof(zero_ex));
> +		else if (split_flag & EXT4_EXT_DATA_VALID2)
> +			memcpy(&zero_ex, ex, sizeof(zero_ex));
> +		else
> +			memcpy(&zero_ex, &orig_ex, sizeof(zero_ex));
>  
> -		if (!err) {
> -			/* update the extent length and mark as initialized */
> -			ex->ee_len = cpu_to_le16(ee_len);
> -			ext4_ext_try_to_merge(handle, inode, path, ex);
> -			err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> -			if (!err)
> -				/* update extent status tree */
> -				ext4_zeroout_es(inode, &zero_ex);
> -			/* If we failed at this point, we don't know in which
> -			 * state the extent tree exactly is so don't try to fix
> -			 * length of the original extent as it may do even more
> -			 * damage.
> -			 */
> -			goto out;
> -		}
> +		err = ext4_ext_zeroout(inode, &zero_ex);
> +		if (err)
> +			goto fix_extent_len;
> +
> +		/* update the extent length and mark as initialized */
> +		ex->ee_len = cpu_to_le16(ee_len);
> +		ext4_ext_try_to_merge(handle, inode, path, ex);
> +		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> +		if (!err)
> +			/* update extent status tree */
> +			ext4_zeroout_es(inode, &zero_ex);
> +		/*
> +		 * If we failed at this point, we don't know in which
> +		 * state the extent tree exactly is so don't try to fix
> +		 * length of the original extent as it may do even more
> +		 * damage.
> +		 */
> +		goto out;
>  	}
>  
>  fix_extent_len:
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

