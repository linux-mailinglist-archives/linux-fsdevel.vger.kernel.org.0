Return-Path: <linux-fsdevel+bounces-70023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D359C8E88A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4752C4E9855
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607203112BB;
	Thu, 27 Nov 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yg+7Sr38";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q7Y6jXw9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L3NlCFbo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8l5kt0Cq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D828751A
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250917; cv=none; b=b1aL7oqdEyzTR4M7BbztBjZ/AKbIrvcfeCykVNZZQkMH+B3O9MNq6jtreJxKMu6Dt/l7Atj2vBdFuJXpgah8sibfLI2iuiXZBKsdAgmMktUzSNNajPoSN5Vmkvv28ONXa6sLoQSTTcjJL/rdlmE8noSRun1OgV6ndCugt8DNMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250917; c=relaxed/simple;
	bh=MV0BHOeJD1L99W9asreQpa3ve7FjZn3Vylmvo2Ruwy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZsHp9k/dD6PacniARuNBWfese0mmSRhO3taWg992YK5117YG9YfLgnKxmk/oBbYtNccO6mB53HCzuCpZak3Rsf+OkjBHvMlb2CaU/guT2NDXa3q6JAyxR+1CWvH5ZLN1hyJzqq6G4YgkdJhXvRyYWTcKCrhgzHSZS+dy/QC1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yg+7Sr38; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q7Y6jXw9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L3NlCFbo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8l5kt0Cq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DDE733375B;
	Thu, 27 Nov 2025 13:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764250913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWTy6t6wvXbyh+PU3U976/oTq3zWWZcLnVQY8EQMt7g=;
	b=Yg+7Sr38INtU8YEl9cQqwWnfeGVaTEaokPG/3qBfloVpQ2IXxyFrkJ38ZxtX43dFBLxUKj
	rwYeN/NR+bZCS/bw5hn6D4fQgqhTbdVZ5ID2rXSUDqZxyy1zmEqHjdMCXlekOlO0x7qwTl
	FKroev8CPQZcqlH+MqvvWWMjTDr8uwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764250913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWTy6t6wvXbyh+PU3U976/oTq3zWWZcLnVQY8EQMt7g=;
	b=q7Y6jXw9HXC3u30gFuDYLb3u1055Ub8808itChpGW3a2Kbpy36K8+jmoJr0U4nmpPo/nzJ
	Wt0wGLqvqv1NLrBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L3NlCFbo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8l5kt0Cq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764250912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWTy6t6wvXbyh+PU3U976/oTq3zWWZcLnVQY8EQMt7g=;
	b=L3NlCFbocKqP3h+719e5YR8TdMZg9gA+5yQ9Ymzni6zzTtQ1uLqOMtGb5jBwHUyo/zwjxD
	lAa1jSx1BpixC5qhHOvG8XNpmTdFKFKkKDmJqiLqDAxu8luLNK3uF8pIS41BQuUHX/wf9d
	Ns0GEroIYI8nxIQnKnLPOUau4e71XIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764250912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWTy6t6wvXbyh+PU3U976/oTq3zWWZcLnVQY8EQMt7g=;
	b=8l5kt0CqgavzA7YL9ADXla8JR0voVMTGhAuUSd9sXH/tFIgBlNl7NkJp0xWK4NAQh+syPA
	3naSFKOd7aSk+WBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C601A3EA63;
	Thu, 27 Nov 2025 13:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h+1QMCBVKGkSWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 13:41:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 33C0CA0C94; Thu, 27 Nov 2025 14:41:52 +0100 (CET)
Date: Thu, 27 Nov 2025 14:41:52 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 03/13] ext4: don't zero the entire extent if
 EXT4_EXT_DATA_PARTIAL_VALID1
Message-ID: <yro4hwpttmy6e2zspvwjfdbpej6qvhlqjvlr5kp3nwffqgcnfd@z6qual55zhfq>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121060811.1685783-4-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,huawei.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Score: -4.01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DDE733375B
X-Rspamd-Action: no action
X-Spam-Flag: NO

On Fri 21-11-25 14:08:01, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When allocating initialized blocks from a large unwritten extent, or
> when splitting an unwritten extent during end I/O and converting it to
> initialized, there is currently a potential issue of stale data if the
> extent needs to be split in the middle.
> 
>        0  A      B  N
>        [UUUUUUUUUUUU]    U: unwritten extent
>        [--DDDDDDDD--]    D: valid data
>           |<-  ->| ----> this range needs to be initialized
> 
> ext4_split_extent() first try to split this extent at B with
> EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_MAY_ZEROOUT flag set, but
> ext4_split_extent_at() failed to split this extent due to temporary lack
> of space. It zeroout B to N and mark the entire extent from 0 to N
> as written.
> 
>        0  A      B  N
>        [WWWWWWWWWWWW]    W: written extent
>        [SSDDDDDDDDZZ]    Z: zeroed, S: stale data
> 
> ext4_split_extent() then try to split this extent at A with
> EXT4_EXT_DATA_VALID2 flag set. This time, it split successfully and left
> a stale written extent from 0 to A.
> 
>        0  A      B   N
>        [WW|WWWWWWWWWW]
>        [SS|DDDDDDDDZZ]
> 
> Fix this by pass EXT4_EXT_DATA_PARTIAL_VALID1 to ext4_split_extent_at()
> when splitting at B, don't convert the entire extent to written and left
> it as unwritten after zeroing out B to N. The remaining work is just
> like the standard two-part split. ext4_split_extent() will pass the
> EXT4_EXT_DATA_VALID2 flag when it calls ext4_split_extent_at() for the
> second time, allowing it to properly handle the split. If the split is
> successful, it will keep extent from 0 to A as unwritten.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Good catch on the data exposure issue! First I'd like to discuss whether
there isn't a way to fix these problems in a way that doesn't make the
already complex code even more complex. My observation is that
EXT4_EXT_MAY_ZEROOUT is only set in ext4_ext_convert_to_initialized() and
in ext4_split_convert_extents() which both call ext4_split_extent(). The
actual extent zeroing happens in ext4_split_extent_at() and in
ext4_ext_convert_to_initialized(). I think the code would be much clearer
if we just centralized all the zeroing in ext4_split_extent(). At that
place the situation is actually pretty simple:

1) 'ex' is unwritten, 'map' describes part with already written data which
we want to convert to initialized (generally IO completion situation) => we
can zero out boundaries if they are smaller than max_zeroout or if extent
split fails.

2) 'ex' is unwritten, 'map' describes part we are preparing for write (IO
submission) => the split is opportunistic here, if we cannot split due to
ENOSPC, just go on and deal with it at IO completion time. No zeroing
needed.

3) 'ex' is written, 'map' describes part that should be converted to
unwritten => we can zero out the 'map' part if smaller than max_zeroout or
if extent split fails.

This should all result in a relatively straightforward code where we can
distinguish the three cases based on 'ex' and passed flags, we should be
able to drop the 'EXT4_EXT_DATA_VALID*' flags and logic (possibly we could
drop the 'split_flag' argument of ext4_split_extent() altogether), and fix
the data exposure issues at the same time. What do you think? Am I missing
some case?

								Honza

> ---
>  fs/ext4/extents.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index f7aa497e5d6c..cafe66cb562f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3294,6 +3294,13 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  		err = ext4_ext_zeroout(inode, &zero_ex);
>  		if (err)
>  			goto fix_extent_len;
> +		/*
> +		 * The first half contains partially valid data, the splitting
> +		 * of this extent has not been completed, fix extent length
> +		 * and ext4_split_extent() split will the first half again.
> +		 */
> +		if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1)
> +			goto fix_extent_len;
>  
>  		/* update the extent length and mark as initialized */
>  		ex->ee_len = cpu_to_le16(ee_len);
> @@ -3364,7 +3371,9 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
>  				       EXT4_EXT_MARK_UNWRIT2;
>  		if (split_flag & EXT4_EXT_DATA_VALID2)
> -			split_flag1 |= EXT4_EXT_DATA_ENTIRE_VALID1;
> +			split_flag1 |= map->m_lblk > ee_block ?
> +				       EXT4_EXT_DATA_PARTIAL_VALID1 :
> +				       EXT4_EXT_DATA_ENTIRE_VALID1;
>  		path = ext4_split_extent_at(handle, inode, path,
>  				map->m_lblk + map->m_len, split_flag1, flags1);
>  		if (IS_ERR(path))
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

