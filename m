Return-Path: <linux-fsdevel+bounces-16018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53E5896E2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 13:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A2A1C262DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 11:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDA9143863;
	Wed,  3 Apr 2024 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V6ezk5Mn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oHe68Sjy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93782135A5F;
	Wed,  3 Apr 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143568; cv=none; b=W80qhDDO76VDR+N60i53ATVqyo2W4UeBto4H90QochrkoCSAcDgVZ7ZioRkntTUvHE2cRQmMmp6vUxYPK+VD5RPxOTPEyldzTROq3gMtPAFVjppqKjWXG4yDJ+I/xh7i2nHXdK3iK0uuY1REMGSKV/oaZVh2YE+AYIMIdAH8fEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143568; c=relaxed/simple;
	bh=B1D7E4BM5v4MwQPNkDEDRTd/yHE8sU0PvvLfbGkYHFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCPWCRvblYLrkO55KEVq2Ojgpdw/yLJWwtpZy8ki2WMBwZWY/qAuwb4yAccJdTgPaM4ahMp+ZOIz9E5vVeVGpB1Mucefa2Doibeea/sYE+XsRZeYkcAr2ZhGL+e68ixIklLATEevoS+FuRSxWT/We2Q/56QFm5jRSJMz3yyugUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V6ezk5Mn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oHe68Sjy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBCBE35299;
	Wed,  3 Apr 2024 11:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712143563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=54XuIdUwF3kNBca8B3d+4aw8AC5z3K/ax7Sw1nc33og=;
	b=V6ezk5MnIOqz3bzeAZk3jMav5NApJuUwfgsrdqb/bT5QyNgBI4m8t7INejzbjsNHs3YsLQ
	8Qh8+VrfFymHsI+c1Aj+fI2zL5ma1coKb03PCGQeABW2vQjs623sx+Zgj+joEAiHbGdMMO
	CRZiMBcYYNwKLhjdBZPhSlksKWWTe7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712143563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=54XuIdUwF3kNBca8B3d+4aw8AC5z3K/ax7Sw1nc33og=;
	b=oHe68SjyGtvEBCK+yhyWBnBmmLpoNa+Xyp4nigoxHletQHBaiGGyitBS8+Jv8W8+DuhYpP
	xPMLUCz5BgUl6uCg==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C04C81331E;
	Wed,  3 Apr 2024 11:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lIruLss8DWYiIgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 03 Apr 2024 11:26:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 81366A0814; Wed,  3 Apr 2024 13:25:55 +0200 (CEST)
Date: Wed, 3 Apr 2024 13:25:55 +0200
From: Jan Kara <jack@suse.cz>
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 10/13] ocfs2: fiemap: return correct extent physical
 length
Message-ID: <20240403112555.nj2l5jw2xjrsud3y@quack3>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <0b492e10a9034c8fb08ca654c06471575e8bb96d.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b492e10a9034c8fb08ca654c06471575e8bb96d.1712126039.git.sweettea-kernel@dorminy.me>
X-Spam-Score: -3.71
X-Spamd-Result: default: False [-3.71 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.91)[99.60%]
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 03-04-24 03:22:51, Sweet Tea Dorminy wrote:
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  fs/ocfs2/extent_map.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index eabdf97cd685..229ea45df37b 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -705,7 +705,9 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
>  	unsigned int id_count;
>  	struct ocfs2_dinode *di;
>  	u64 phys;
> -	u32 flags = FIEMAP_EXTENT_DATA_INLINE|FIEMAP_EXTENT_LAST;
> +	u32 flags = (FIEMAP_EXTENT_DATA_INLINE|
> +		     FIEMAP_EXTENT_HAS_PHYS_LEN|
> +		     FIEMAP_EXTENT_LAST);
>  	struct ocfs2_inode_info *oi = OCFS2_I(inode);
>  
>  	di = (struct ocfs2_dinode *)di_bh->b_data;
> @@ -782,7 +784,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  			continue;
>  		}
>  
> -		fe_flags = 0;
> +		fe_flags = FIEMAP_EXTENT_HAS_PHYS_LEN;
>  		if (rec.e_flags & OCFS2_EXT_UNWRITTEN)
>  			fe_flags |= FIEMAP_EXTENT_UNWRITTEN;
>  		if (rec.e_flags & OCFS2_EXT_REFCOUNTED)

Again, we should be passing non-zero phys_len if we set
FIEMAP_EXTENT_HAS_PHYS_LEN flag AFAIU.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

