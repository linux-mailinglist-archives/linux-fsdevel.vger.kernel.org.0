Return-Path: <linux-fsdevel+bounces-13021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D82386A3DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 00:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609BE1C24C78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA66C5674B;
	Tue, 27 Feb 2024 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NlvI9rmn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uhn8s53X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NlvI9rmn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uhn8s53X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960555E48;
	Tue, 27 Feb 2024 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709077099; cv=none; b=Im3ZiFOPgf294GwoScKPhLMSY5f7lfMm0THr56DwxUhoTnLrmnpYBJ22OVf29vdq5FhBfb7pTn6Ttkq2/PlHIHbHQPqRpMhMohTzouI6b8VWm9aNOgJRPQnDAmWrqriCd/ZhCiz4xhIkPEXJPDb+huc66PlJ4Jf8auf6VrcDq3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709077099; c=relaxed/simple;
	bh=aLQZ8HS/XMEIR8wKVsfYExoeIYXeKU1TdW1WZqUS37g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=etQtLe3fun/qgmbUxstRXW6s2b1EEI+YQAnLr44IGTuimPuGzFEnwo+HtJLjCeS84ZsCCNFiflkPK5dYYnQdJHBVciR3HNjjT7jddhmbLqRzsol57X8Mw9Pk4mWBmYLe4Fa57lv+OIGjof8soRilg6jSo3LIJqpZ+fl+Toshc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NlvI9rmn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uhn8s53X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NlvI9rmn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uhn8s53X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76B301FB95;
	Tue, 27 Feb 2024 23:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709077095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9HVWC3SuhyxQFuKW/pPwGjCJddJjno4JKmEKNYaAYI8=;
	b=NlvI9rmnD0GZ3zkgHwP4FRNU9qk4/ZIqjudTcHZxjIf0mk/2GMLNB9lj81elQ/DSk9HOO5
	o+3w7/+R0E8dQCWokXUFbokQH/0c8hdlBUjTrT02S3wkeaUBZ6GxICz8yP/1orGD9o2KWw
	UOaXiUhzzvFbXYl329L/7FntOmoRdR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709077095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9HVWC3SuhyxQFuKW/pPwGjCJddJjno4JKmEKNYaAYI8=;
	b=uhn8s53X6Vqu9Rr4G+pFz7RHTq4g1jw20uNJpV6PLm6YnDoceU4jLiHNyXUt6+DUFE0cPq
	ZeQ2GIZC0nF5QADQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709077095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9HVWC3SuhyxQFuKW/pPwGjCJddJjno4JKmEKNYaAYI8=;
	b=NlvI9rmnD0GZ3zkgHwP4FRNU9qk4/ZIqjudTcHZxjIf0mk/2GMLNB9lj81elQ/DSk9HOO5
	o+3w7/+R0E8dQCWokXUFbokQH/0c8hdlBUjTrT02S3wkeaUBZ6GxICz8yP/1orGD9o2KWw
	UOaXiUhzzvFbXYl329L/7FntOmoRdR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709077095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9HVWC3SuhyxQFuKW/pPwGjCJddJjno4JKmEKNYaAYI8=;
	b=uhn8s53X6Vqu9Rr4G+pFz7RHTq4g1jw20uNJpV6PLm6YnDoceU4jLiHNyXUt6+DUFE0cPq
	ZeQ2GIZC0nF5QADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F63913ABA;
	Tue, 27 Feb 2024 23:38:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UTxmBWdy3mUPNwAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 27 Feb 2024 23:38:15 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,  Gabriel
 Krisman Bertazi <krisman@collabora.com>,  Eric Biggers
 <ebiggers@google.com>
Subject: Re: [PATCH v12 6/8] ext4: Log error when lookup of encoded dentry
 fails
In-Reply-To: <20240220085235.71132-7-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Tue, 20 Feb 2024 10:52:33 +0200")
Organization: SUSE
References: <20240220085235.71132-1-eugen.hristev@collabora.com>
	<20240220085235.71132-7-eugen.hristev@collabora.com>
Date: Tue, 27 Feb 2024 18:38:13 -0500
Message-ID: <87y1b54gwq.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NlvI9rmn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uhn8s53X
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.58 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.07)[95.47%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -3.58
X-Rspamd-Queue-Id: 76B301FB95
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> If the volume is in strict mode, ext4_ci_compare can report a broken
> encoding name.  This will not trigger on a bad lookup, which is caught
> earlier, only if the actual disk name is bad.
>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/ext4/namei.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 6e7af8dc4dde..7d357c417475 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1477,6 +1477,9 @@ static bool ext4_match(struct inode *parent,
>  			 * only case where it happens is on a disk
>  			 * corruption or ENOMEM.
>  			 */
> +			if (ret == -EINVAL)
> +				EXT4_ERROR_INODE(parent,
> +					"Directory contains filename that is invalid UTF-8");
>  			return false;
>  		}
>  		return ret;

Can you add a patch doing the same for f2fs?


-- 
Gabriel Krisman Bertazi

