Return-Path: <linux-fsdevel+bounces-73419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12825D1891E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 326E93008DF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF3138E5CA;
	Tue, 13 Jan 2026 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HFWDtQWN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z9fyN+ry";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HFWDtQWN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z9fyN+ry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570F538BF8E
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768305007; cv=none; b=O8dRpwKSXd2tGpfGUsZQtsgagtN0rTPTVX+WnFYK+2nNMy2TNygykJg2RRNilQFYkNtF0auWywfK043rEqcKqTZbLA5vdrp8mgCkv/uwwalD7Xt0b+gVDLdQHnLnaC31FAgqRTp4hMYlgHtFutndm4+9aTs53MgcvjxH6jFQXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768305007; c=relaxed/simple;
	bh=OtO0jE4naAWXf2Wdt7DmdCMu2wRulJnNPjrecxi4hOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGoJyfccOOyHzH60zn01giMbd9herNYGoQ61IVrgYjV7RFdTqLBVI1pwpUMKcGFUxu6BscpSwy0C2LSR9eI4ffPzXjaBa8V8QDz/der7VIrwTAi/01pQDIZOIC+f1xxTiOqfXwceAuTNuJ5Jx1KxCTuL1g1ZKBJ27AYfnSA6C+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HFWDtQWN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z9fyN+ry; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HFWDtQWN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z9fyN+ry; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3AE43369C;
	Tue, 13 Jan 2026 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768305003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pq18dDX5CD5Cfl6Kg/C+3Qqm2uB0qsR8mSpxweaSoKk=;
	b=HFWDtQWNDhgqTP0KhX+5b4+K+WXtGVY1eXfiN1AcRlFTZbbbVV31q1CYEh+MymB6fNrLV1
	Dj5lSbjieMfL+eZUAx1yjWgYo1DzcP5/r13ww8C9Bc4JcNTTDhfBx7kbCVtOH4knZNahYx
	9mgtwBtA8tmwHOa25zjTou/Aeon7xDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768305003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pq18dDX5CD5Cfl6Kg/C+3Qqm2uB0qsR8mSpxweaSoKk=;
	b=z9fyN+rybrZSueCvrEtV2qCDIVwQ4CRduAxZZ9TClZU32CDCuB3mNhSCAqctq3iTsPzwHB
	UzIq9YKoeXB06hAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768305003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pq18dDX5CD5Cfl6Kg/C+3Qqm2uB0qsR8mSpxweaSoKk=;
	b=HFWDtQWNDhgqTP0KhX+5b4+K+WXtGVY1eXfiN1AcRlFTZbbbVV31q1CYEh+MymB6fNrLV1
	Dj5lSbjieMfL+eZUAx1yjWgYo1DzcP5/r13ww8C9Bc4JcNTTDhfBx7kbCVtOH4knZNahYx
	9mgtwBtA8tmwHOa25zjTou/Aeon7xDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768305003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pq18dDX5CD5Cfl6Kg/C+3Qqm2uB0qsR8mSpxweaSoKk=;
	b=z9fyN+rybrZSueCvrEtV2qCDIVwQ4CRduAxZZ9TClZU32CDCuB3mNhSCAqctq3iTsPzwHB
	UzIq9YKoeXB06hAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9522D3EA63;
	Tue, 13 Jan 2026 11:50:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3ahmJGsxZmm7LgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 13 Jan 2026 11:50:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 41C37A08CF; Tue, 13 Jan 2026 12:50:03 +0100 (CET)
Date: Tue, 13 Jan 2026 12:50:03 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Cc: vira@imap.suse.de, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	sj1557.seo@samsung.com, yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, anna@kernel.org, 
	jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org, 
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 13/16] isofs: Implement fileattr_get for case
 sensitivity
Message-ID: <anny6rybowuoul5frpcurykpegeo6bcy64nzx2toduckzxvjye@wf2xukl5fcsu>
References: <20260112174629.3729358-1-cel@kernel.org>
 <20260112174629.3729358-14-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112174629.3729358-14-cel@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLmzfjx67n53eyz9asjm8u3pcw)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[imap.suse.de,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 12-01-26 12:46:26, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Upper layers such as NFSD need a way to query whether a
> filesystem handles filenames in a case-sensitive manner so
> they can provide correct semantics to remote clients. Without
> this information, NFS exports of ISO 9660 filesystems cannot
> properly advertise their filename case behavior.
> 
> Implement isofs_fileattr_get() to report ISO 9660 case
> handling behavior. The 'check=r' (relaxed) mount option
> enables case-insensitive lookups, and this setting determines
> the value reported through the file_kattr structure. By
> default, Joliet extensions operate in relaxed mode while plain
> ISO 9660 uses strict (case-sensitive) mode. All ISO 9660
> variants are case-preserving, meaning filenames are stored
> exactly as they appear on the disc.
> 
> The callback is registered only on isofs_dir_inode_operations
> because isofs has no custom inode_operations for regular
> files, and symlinks use the generic page_symlink_inode_operations.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/isofs/dir.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
> index 09df40b612fb..717cdf726e83 100644
> --- a/fs/isofs/dir.c
> +++ b/fs/isofs/dir.c
> @@ -12,6 +12,7 @@
>   *  isofs directory handling functions
>   */
>  #include <linux/gfp.h>
> +#include <linux/fileattr.h>
>  #include "isofs.h"
>  
>  int isofs_name_translate(struct iso_directory_record *de, char *new, struct inode *inode)
> @@ -266,6 +267,15 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
>  	return result;
>  }
>  
> +static int isofs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
> +{
> +	struct isofs_sb_info *sbi = ISOFS_SB(dentry->d_sb);
> +
> +	fa->case_insensitive = sbi->s_check == 'r';
> +	fa->case_preserving = true;
> +	return 0;
> +}
> +
>  const struct file_operations isofs_dir_operations =
>  {
>  	.llseek = generic_file_llseek,
> @@ -279,6 +289,7 @@ const struct file_operations isofs_dir_operations =
>  const struct inode_operations isofs_dir_inode_operations =
>  {
>  	.lookup = isofs_lookup,
> +	.fileattr_get = isofs_fileattr_get,
>  };
>  
>  
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

