Return-Path: <linux-fsdevel+bounces-6680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E82AC81B5AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260E41C2187E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398346E59E;
	Thu, 21 Dec 2023 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0NQRlSJR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JIsF6CdW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0NQRlSJR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JIsF6CdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8712206F
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5ECD721D86;
	Thu, 21 Dec 2023 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703161232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUqKssdkh84/W7CFQkJPx0b3pfzmIOb5NbfwKIrNUIk=;
	b=0NQRlSJRKhuz3pRM4U5h+URecqZW7wspB7heDBO/HeNWoKnPIrRau4Ui1daqgReJ4scxMo
	oh5BS6jpixhVKt34DiWdqv96Em7p5H8RUWJm5jSNnYXrLT6nQO1Mxhqo+mQG2wAsgWx95r
	de1f7oKezaoXL1KU10TQAccoN+FvBnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703161232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUqKssdkh84/W7CFQkJPx0b3pfzmIOb5NbfwKIrNUIk=;
	b=JIsF6CdW3rnikE5Un0hziPcLuqr7TbOve1T/YveegeRT9CwrTfEcRaoZi+fVfQK9EtNxPx
	cMPXmlFrdE5oWTDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703161232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUqKssdkh84/W7CFQkJPx0b3pfzmIOb5NbfwKIrNUIk=;
	b=0NQRlSJRKhuz3pRM4U5h+URecqZW7wspB7heDBO/HeNWoKnPIrRau4Ui1daqgReJ4scxMo
	oh5BS6jpixhVKt34DiWdqv96Em7p5H8RUWJm5jSNnYXrLT6nQO1Mxhqo+mQG2wAsgWx95r
	de1f7oKezaoXL1KU10TQAccoN+FvBnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703161232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUqKssdkh84/W7CFQkJPx0b3pfzmIOb5NbfwKIrNUIk=;
	b=JIsF6CdW3rnikE5Un0hziPcLuqr7TbOve1T/YveegeRT9CwrTfEcRaoZi+fVfQK9EtNxPx
	cMPXmlFrdE5oWTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48CA513AB5;
	Thu, 21 Dec 2023 12:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iR6+EZAthGXqbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 12:20:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D230FA07E3; Thu, 21 Dec 2023 13:20:27 +0100 (CET)
Date: Thu, 21 Dec 2023 13:20:27 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 11/22] udf: d_obtain_alias(ERR_PTR(...)) will do the
 right thing...
Message-ID: <20231221122027.endakmqct3jv2yjl@quack3>
References: <20231220051348.GY1674809@ZenIV>
 <20231220052359.GJ1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220052359.GJ1674809@ZenIV>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.67
X-Spamd-Result: default: False [-3.67 / 50.00];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linux.org.uk:email,suse.cz:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.87)[99.45%]
X-Spam-Flag: NO

On Wed 20-12-23 05:23:59, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good.

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/udf/namei.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index 92f25e540430..a64102d63781 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -897,7 +897,6 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  static struct dentry *udf_get_parent(struct dentry *child)
>  {
>  	struct kernel_lb_addr tloc;
> -	struct inode *inode = NULL;
>  	struct udf_fileident_iter iter;
>  	int err;
>  
> @@ -907,11 +906,7 @@ static struct dentry *udf_get_parent(struct dentry *child)
>  
>  	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
>  	udf_fiiter_release(&iter);
> -	inode = udf_iget(child->d_sb, &tloc);
> -	if (IS_ERR(inode))
> -		return ERR_CAST(inode);
> -
> -	return d_obtain_alias(inode);
> +	return d_obtain_alias(udf_iget(child->d_sb, &tloc));
>  }
>  
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

