Return-Path: <linux-fsdevel+bounces-15132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43878874BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 23:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0721F22438
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 22:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6948174F;
	Fri, 22 Mar 2024 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mlWXzpqS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BB6nITdG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mlWXzpqS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BB6nITdG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773C643AB5;
	Fri, 22 Mar 2024 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145487; cv=none; b=QlTLfAcLq0oNP7rKmNJHt2KialtG9C8MrLAVgCWnGXnUhHZDRTRTNezbaXnhNxacsfYIoe75anVa1CZz7n9FjX8dv9/FEonl+RjlonxMAfKHXNGnLtxY91t++cQcVzcsv70yjlw8OkV1RNHcHOu+s6IB8DfJBtyoETtNuasy2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145487; c=relaxed/simple;
	bh=cYEneCopJ0HyP2zaMTqZo4XpTAozfLYZRkf/OvnV79M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NcyRo4+H0XXXxT6qxDGk+v3OrZAuNyfnSOcMWFIgWI8yHmgV5k3i3Y88zs+ij5nvP3IbEWC/W67vWKqTQoH7JKQEh7tax1NA5mjXQ299csOBVgLGlbaGTltUSJ310d6CGOySGv4ppZZRVyP/8a18k9FyR7WrNJGHoE6P0B6sWM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mlWXzpqS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BB6nITdG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mlWXzpqS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BB6nITdG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B51738A8F;
	Fri, 22 Mar 2024 22:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711145483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTUdfRCQAps7aKrlDcH+625uZVzNEW70NMJGlSkqA9c=;
	b=mlWXzpqSp56PPijFJe6COkSKNB8a6IvOHhByz+nqzSZG5h2PFv+YYk8P1rVIJmGK3VZcrX
	YuvsbNrF3cbGhZRVLcyWV1y3NLOV62uIt8HYNLZDj940SiikmZ6fuVR4rErAofmi8IJ+Yq
	cSkoBC/3NqQMmwBH5SPgDa7BYUVpbFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711145483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTUdfRCQAps7aKrlDcH+625uZVzNEW70NMJGlSkqA9c=;
	b=BB6nITdGi/cLdIrnCnqtyuO9mnPFUZSVQksBaCdjk476VJtLYKazhreI6eyv4N4WYhvKO4
	MjYL0yxXVozUZ7Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711145483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTUdfRCQAps7aKrlDcH+625uZVzNEW70NMJGlSkqA9c=;
	b=mlWXzpqSp56PPijFJe6COkSKNB8a6IvOHhByz+nqzSZG5h2PFv+YYk8P1rVIJmGK3VZcrX
	YuvsbNrF3cbGhZRVLcyWV1y3NLOV62uIt8HYNLZDj940SiikmZ6fuVR4rErAofmi8IJ+Yq
	cSkoBC/3NqQMmwBH5SPgDa7BYUVpbFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711145483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTUdfRCQAps7aKrlDcH+625uZVzNEW70NMJGlSkqA9c=;
	b=BB6nITdGi/cLdIrnCnqtyuO9mnPFUZSVQksBaCdjk476VJtLYKazhreI6eyv4N4WYhvKO4
	MjYL0yxXVozUZ7Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28DE0132FF;
	Fri, 22 Mar 2024 22:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /ubiAwsC/mXxHQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 22 Mar 2024 22:11:23 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz
Subject: Re: [PATCH v14 7/9] f2fs: Log error when lookup of encoded dentry
 fails
In-Reply-To: <20240320084622.46643-8-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Wed, 20 Mar 2024 10:46:20 +0200")
Organization: SUSE
References: <20240320084622.46643-1-eugen.hristev@collabora.com>
	<20240320084622.46643-8-eugen.hristev@collabora.com>
Date: Fri, 22 Mar 2024 18:11:21 -0400
Message-ID: <87v85d9at2.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -3.76
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.76 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.25)[73.35%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mlWXzpqS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BB6nITdG
X-Rspamd-Queue-Id: 6B51738A8F

Eugen Hristev <eugen.hristev@collabora.com> writes:

> If the volume is in strict mode, generi c_ci_compare can report a broken
> encoding name.  This will not trigger on a bad lookup, which is caught
> earlier, only if the actual disk name is bad.
>
> Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/f2fs/dir.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 88b0045d0c4f..3b0003e8767a 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -192,11 +192,22 @@ static inline int f2fs_match_name(const struct inode *dir,
>  	struct fscrypt_name f;
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
> -	if (fname->cf_name.name)
> -		return generic_ci_match(dir, fname->usr_fname,
> -					&fname->cf_name,
> -					de_name, de_name_len);
> -
> +	if (fname->cf_name.name) {
> +		int ret = generic_ci_match(dir, fname->usr_fname,
> +					   &fname->cf_name,
> +					   de_name, de_name_len);
> +		if (ret < 0) {
> +			/*
> +			 * Treat comparison errors as not a match.  The
> +			 * only case where it happens is on a disk
> +			 * corruption or ENOMEM.
> +			 */
> +			if (ret == -EINVAL)
> +				f2fs_warn(F2FS_SB(dir->i_sb),
> +					"Directory contains filename that is invalid UTF-8");
> +		}
> +		return ret;

No point in checking ret < 0 and then ret == -EINVAL. just check for
-EINVAL.  That was ok in ext4 because we actually need to change ret to
false.

> +	}
>  #endif
>  	f.usr_fname = fname->usr_fname;
>  	f.disk_name = fname->disk_name;

-- 
Gabriel Krisman Bertazi

