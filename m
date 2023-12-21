Return-Path: <linux-fsdevel+bounces-6679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D1B81B5AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C9C1C21571
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC276E5A4;
	Thu, 21 Dec 2023 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IdbLX2uB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SzgI1Se/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pSeQnB7n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M6fYZpKD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0873170
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 448E31FDB0;
	Thu, 21 Dec 2023 12:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703161192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/6gC3bSpfZ1DOZmV91Mt0xoos/UHmqH7d6BhDSQb3c=;
	b=IdbLX2uBxa5zWuPkALRsuwBbBlFJsTKrukoXU1j7HGqEtYNXonOWZZ4bIpx+tcLqRBB2zb
	2g+NEfkoN3LlDBnHVl3VPz62pGGyO0CvH05yey8FdjTbh2CNYVnn0RcNYacut4ATwu6fgd
	JrsAhGVL/Ue7/RX4m2aNCi4HF99eH3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703161192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/6gC3bSpfZ1DOZmV91Mt0xoos/UHmqH7d6BhDSQb3c=;
	b=SzgI1Se/jEMFDpfBVgKRAzYw83yDigX9SK5xJRQOl5w1Xja4ivBRYsmzPXxqX6nZJefSI8
	yJc7NKEu0X37U2BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703161191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/6gC3bSpfZ1DOZmV91Mt0xoos/UHmqH7d6BhDSQb3c=;
	b=pSeQnB7nfFNu76s3TH8wx8h1KqTf8fQvECn/TfSIClS7A0GqouRMG+Kzb1O3kasPusveKa
	yRTKCTvh66Yegsfy1fbXSAJa5Stnqupci1KrFEYgJyexwPx477iD/E9aYDuRir35K49H5+
	rA+FUIGgGvL5RfV21C8N4uJ8twmMKA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703161191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/6gC3bSpfZ1DOZmV91Mt0xoos/UHmqH7d6BhDSQb3c=;
	b=M6fYZpKD+h8N4uqD6Jg7sLxyXV09wiEar96vHDQUomRxLjnzUZeG2cDVwN0AoOFGyAzmUi
	HXIEaQTIPFjRm9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38C5813AB5;
	Thu, 21 Dec 2023 12:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9DXVDWcthGWjbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 12:19:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D61C7A07E3; Thu, 21 Dec 2023 13:19:46 +0100 (CET)
Date: Thu, 21 Dec 2023 13:19:46 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 04/22] udf: d_splice_alias() will do the right thing on
 ERR_PTR() inode
Message-ID: <20231221121946.fx7u6b2zkqbulae7@quack3>
References: <20231220051348.GY1674809@ZenIV>
 <20231220051828.GC1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220051828.GC1674809@ZenIV>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.54
X-Spamd-Result: default: False [-3.54 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux.org.uk:email,suse.com:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.74)[98.86%]
X-Spam-Flag: NO

On Wed 20-12-23 05:18:28, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

I don't expect any conflicts in UDF tree so you can keep these patches in
VFS tree. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza	

> ---
>  fs/udf/namei.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index 3508ac484da3..92f25e540430 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -125,8 +125,6 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
>  		udf_fiiter_release(&iter);
>  
>  		inode = udf_iget(dir->i_sb, &loc);
> -		if (IS_ERR(inode))
> -			return ERR_CAST(inode);
>  	}
>  
>  	return d_splice_alias(inode, dentry);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

