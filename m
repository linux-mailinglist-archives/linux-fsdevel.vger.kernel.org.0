Return-Path: <linux-fsdevel+bounces-63586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E43BC49AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 13:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721913AB43B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 11:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC472F744C;
	Wed,  8 Oct 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PTXoeHLk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mLlIMfVE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qSCj7zrZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2P9SQZR7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD581DFE0B
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759923938; cv=none; b=K3pp/Th4Z/d/VsQlRcMrrOZ4fAd3Ow7s3ozrYD10J6ZkwZiAWFQt2/I1nDElzlO/z/L9k0DJFfaO3XC7ZQSpoXcCju8Qll4cKoLx5MJ6epfDQtTDk9z1Sh/bInzIJk85WRD8joO1pKUq7nbxIq1gIhue2Ppg+dT8Jc5/xUnln7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759923938; c=relaxed/simple;
	bh=0/azAbPvLQ2XUaX8sTpvxeT/nCvBFVBbNF3uz7RMwd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS3xAeCBJzxLp7eIrBq++PQDHfFKJBqxvOCGDhmiVNUF9BnlU+TPlVo+sc3kpghvMYHMhP6A/prfem240hLx4S7LLxuLuT+8CidprMOSc+7pOHvYuRuMkjuQHhjnXYnU4my2jmI7/k2yMst0gyoNSpXIM3LLskdb2v5xiLyvpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PTXoeHLk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mLlIMfVE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qSCj7zrZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2P9SQZR7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAC911F766;
	Wed,  8 Oct 2025 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759923935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJyU6dhaUD2vMVT9WUefQeJfTiVF1dSwL+eInA4vJoA=;
	b=PTXoeHLkFgAnzQEeS38cTt11p6f6VSzD/Rk4HsSLJXTGWA9O5UQ87JTrGXCpWbIXWqMAyd
	2MClUzrfdGz9KtwcdzxkBAdlltjXOs98VtpG0nBKVIlSYs/HOkPQYZcHYa3gzuBY5zQHmT
	K0rEqwPv9Sd6NsqwNUxaxHpBMj7/4JQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759923935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJyU6dhaUD2vMVT9WUefQeJfTiVF1dSwL+eInA4vJoA=;
	b=mLlIMfVE2F9NmPGSkzHt2Vsyl8y88FhKYVo2qqqej0eqVyoj48h31wrLPuS+cqhkLSQmvS
	Ud5fnCCiFEeKOICA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759923934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJyU6dhaUD2vMVT9WUefQeJfTiVF1dSwL+eInA4vJoA=;
	b=qSCj7zrZjbyySapgd6XKt/qa+x1mW7rjrYpUYOp7S+RrJ/trkUHG+SL+kGfOL71biXS0h+
	20ytkgANECvbu+OcSXvY55YvNt7AgdSQdq6UY0rWjETvvPRjUwvVN5GPps/15LgffjzIOZ
	vrTsn9LJ3mDwV3D7lUv4JdACoHRl9ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759923934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FJyU6dhaUD2vMVT9WUefQeJfTiVF1dSwL+eInA4vJoA=;
	b=2P9SQZR7t5BHZV+R01qgviL+Cng+GQvj4oIHbqdoilwVyFx7LUOEzhp16Mrf5z8yVFX47D
	zMGPmerNRsuJb2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DADF713A96;
	Wed,  8 Oct 2025 11:45:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P6BuNd5O5mgNLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 11:45:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 78AC6A0ACD; Wed,  8 Oct 2025 13:45:30 +0200 (CEST)
Date: Wed, 8 Oct 2025 13:45:30 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 06/13] ext4: use EXT4_B_TO_LBLK() in
 mext_check_arguments()
Message-ID: <iz4x2yurkqxd6fzqw3ppf6pevyrzfxg4z3wwbufdwb7vtj6ndt@tnh5k2yts4nv>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092610.1936929-7-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 25-09-25 17:26:02, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Switch to using EXT4_B_TO_LBLK() to calculate the EOF position of the
> origin and donor inodes, instead of using open-coded calculations.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/move_extent.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 0f4b7c89edd3..6175906c7119 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -461,12 +461,6 @@ mext_check_arguments(struct inode *orig_inode,
>  		     __u64 donor_start, __u64 *len)
>  {
>  	__u64 orig_eof, donor_eof;
> -	unsigned int blkbits = orig_inode->i_blkbits;
> -	unsigned int blocksize = 1 << blkbits;
> -
> -	orig_eof = (i_size_read(orig_inode) + blocksize - 1) >> blkbits;
> -	donor_eof = (i_size_read(donor_inode) + blocksize - 1) >> blkbits;
> -
>  
>  	if (donor_inode->i_mode & (S_ISUID|S_ISGID)) {
>  		ext4_debug("ext4 move extent: suid or sgid is set"
> @@ -526,6 +520,9 @@ mext_check_arguments(struct inode *orig_inode,
>  			orig_inode->i_ino, donor_inode->i_ino);
>  		return -EINVAL;
>  	}
> +
> +	orig_eof = EXT4_B_TO_LBLK(orig_inode, i_size_read(orig_inode));
> +	donor_eof = EXT4_B_TO_LBLK(donor_inode, i_size_read(donor_inode));
>  	if (orig_eof <= orig_start)
>  		*len = 0;
>  	else if (orig_eof < orig_start + *len - 1)
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

