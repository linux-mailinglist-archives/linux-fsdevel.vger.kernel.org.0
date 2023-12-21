Return-Path: <linux-fsdevel+bounces-6681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630CA81B5B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187431F24CF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8276E5B6;
	Thu, 21 Dec 2023 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cNKbMUvQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u6DYWr6v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cNKbMUvQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u6DYWr6v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B6729D08
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6BBF1FB78;
	Thu, 21 Dec 2023 12:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703161337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QuMGw1K2G5CuBrc7yr8BXOpBbHLV7QO10jPYg3DTUFc=;
	b=cNKbMUvQGY8ZEWzFfZWORXlJ3q6msSgSGp9vsxJjuOx8PmpExCHV2n8WSim6v91M13pOPB
	+xAgXk9eXiGi5uYtJ4PP+D1LrXUo7KFprNFBg1fYeOq02pzuLMlZMn2BOpVE5nNAdeG3hc
	ZHKnqYeWzVAbADYz3ky9UtNKJczq0C4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703161337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QuMGw1K2G5CuBrc7yr8BXOpBbHLV7QO10jPYg3DTUFc=;
	b=u6DYWr6v+9sZE7y4L/4NDsEd6THMN2Z/3DYYUv4ZmNMImj94udygZydFQCQ92G76PpXZ5Z
	omI1zSgBUrySKmAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703161337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QuMGw1K2G5CuBrc7yr8BXOpBbHLV7QO10jPYg3DTUFc=;
	b=cNKbMUvQGY8ZEWzFfZWORXlJ3q6msSgSGp9vsxJjuOx8PmpExCHV2n8WSim6v91M13pOPB
	+xAgXk9eXiGi5uYtJ4PP+D1LrXUo7KFprNFBg1fYeOq02pzuLMlZMn2BOpVE5nNAdeG3hc
	ZHKnqYeWzVAbADYz3ky9UtNKJczq0C4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703161337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QuMGw1K2G5CuBrc7yr8BXOpBbHLV7QO10jPYg3DTUFc=;
	b=u6DYWr6v+9sZE7y4L/4NDsEd6THMN2Z/3DYYUv4ZmNMImj94udygZydFQCQ92G76PpXZ5Z
	omI1zSgBUrySKmAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B04B13AB5;
	Thu, 21 Dec 2023 12:22:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wPTWJfkthGWvbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 12:22:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 406E2A07E3; Thu, 21 Dec 2023 13:22:17 +0100 (CET)
Date: Thu, 21 Dec 2023 13:22:17 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 16/22] udf_fiiter_add_entry(): check for zero
 ->d_name.len is bogus...
Message-ID: <20231221122217.nqztjeu3mzyv6bmx@quack3>
References: <20231220051348.GY1674809@ZenIV>
 <20231220052831.GO1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220052831.GO1674809@ZenIV>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-0.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,suse.com:email,suse.cz:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.08)[88.05%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -0.68
X-Spam-Flag: NO

On Wed 20-12-23 05:28:31, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Indeed.

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/udf/namei.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index a64102d63781..b1674e07d5a5 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -228,8 +228,6 @@ static int udf_fiiter_add_entry(struct inode *dir, struct dentry *dentry,
>  	char name[UDF_NAME_LEN_CS0];
>  
>  	if (dentry) {
> -		if (!dentry->d_name.len)
> -			return -EINVAL;
>  		namelen = udf_put_filename(dir->i_sb, dentry->d_name.name,
>  					   dentry->d_name.len,
>  					   name, UDF_NAME_LEN_CS0);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

