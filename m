Return-Path: <linux-fsdevel+bounces-73420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC5DD18945
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE28E303F7F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 11:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FD138BF6A;
	Tue, 13 Jan 2026 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybfTbTlO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WR78M5pV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybfTbTlO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WR78M5pV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EF82C026A
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768305021; cv=none; b=nrJaVxYM6NE5/n68blWm+sJJYxcMHIgAJd/7Nc+B2wjSJQgtR8cXiQ6YYqikgK6cwR1K6DF5vp98nF6Cy7kpDsvQyg+zKXgB0+hfoeOw1A+TYhmllW7YHMRLeLSEBcZmGZjjemiKSyGFCSs/XnHAIg0SGYsJe3QDnMBT8wCjMpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768305021; c=relaxed/simple;
	bh=64fWHMTVbg6ilRs9vJOrLHCWPXz1/YG17gH59/Gq9z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAO4fVeGFAWWt9ykF5Jdl2QZJR3KgjzcWud+yviKVunEv71IsDIzLn52+ng2N8h2qrBVvmP1R7hWk69/2rZng1/1uWiUGCR71mUeUGCSDVRRz97GkfgiqY0iO5lplucZncEdUTgAzRcw30AIe9EU4T8Owm4CcjeRiHR06/yyfwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybfTbTlO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WR78M5pV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybfTbTlO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WR78M5pV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C99E33684;
	Tue, 13 Jan 2026 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768305018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgNRi+aV6jB9u6bCyM5aaBQD8Pz1HwmkA+frhGt+2U8=;
	b=ybfTbTlOs0mjZYU+kOegPaJWwwsyWdZJFvh/IhjhtlM+NswaBFD0Tcq3sXMo6UKipzVpMG
	FOEApY0GPyhr2lPsXDFcfVvt5o0XanTfz9/NW6c8E+QvjvxXUjBcPOUbL1nx8qBShfURNv
	jgrkqpn6HBCaqCUIco8/Ufm4pyyN7Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768305018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgNRi+aV6jB9u6bCyM5aaBQD8Pz1HwmkA+frhGt+2U8=;
	b=WR78M5pVO0K7T2BZI6ht+0pgqH5o/ONc4tEDfRjHT2gRrEdfy2XRdboRvibOPeAsXlQzdJ
	lPGJ8C+NLCo8x1Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ybfTbTlO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WR78M5pV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768305018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgNRi+aV6jB9u6bCyM5aaBQD8Pz1HwmkA+frhGt+2U8=;
	b=ybfTbTlOs0mjZYU+kOegPaJWwwsyWdZJFvh/IhjhtlM+NswaBFD0Tcq3sXMo6UKipzVpMG
	FOEApY0GPyhr2lPsXDFcfVvt5o0XanTfz9/NW6c8E+QvjvxXUjBcPOUbL1nx8qBShfURNv
	jgrkqpn6HBCaqCUIco8/Ufm4pyyN7Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768305018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgNRi+aV6jB9u6bCyM5aaBQD8Pz1HwmkA+frhGt+2U8=;
	b=WR78M5pVO0K7T2BZI6ht+0pgqH5o/ONc4tEDfRjHT2gRrEdfy2XRdboRvibOPeAsXlQzdJ
	lPGJ8C+NLCo8x1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EC433EA63;
	Tue, 13 Jan 2026 11:50:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7oscF3oxZmnSLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 13 Jan 2026 11:50:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 27F84A08CF; Tue, 13 Jan 2026 12:50:18 +0100 (CET)
Date: Tue, 13 Jan 2026 12:50:18 +0100
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
Subject: Re: [PATCH v3 07/16] ext4: Report case sensitivity in fileattr_get
Message-ID: <76zoosya47hgvau4bajvpqupogjpbx5wtljtwltp7pzggkyj7m@lco5on2kmf7g>
References: <20260112174629.3729358-1-cel@kernel.org>
 <20260112174629.3729358-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112174629.3729358-8-cel@kernel.org>
X-Spam-Score: -4.01
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLa77mm4gi8mw7uppieotozii3)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[imap.suse.de,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.com:email]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6C99E33684
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Mon 12-01-26 12:46:20, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Report ext4's case sensitivity behavior via file_kattr boolean
> fields. ext4 always preserves case at rest.
> 
> Case sensitivity is a per-directory setting in ext4. If the queried
> inode is a casefolded directory, report case-insensitive; otherwise
> report case-sensitive (standard POSIX behavior).
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ioctl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 7ce0fc40aec2..653035017c7f 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -996,6 +996,14 @@ int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
>  	if (ext4_has_feature_project(inode->i_sb))
>  		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
>  
> +	/*
> +	 * ext4 always preserves case. If this inode is a casefolded
> +	 * directory, report case-insensitive; otherwise report
> +	 * case-sensitive (standard POSIX behavior).
> +	 */
> +	fa->case_insensitive = IS_CASEFOLDED(inode);
> +	fa->case_preserving = true;
> +
>  	return 0;
>  }
>  
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

