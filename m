Return-Path: <linux-fsdevel+bounces-66577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EABC24A5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 11:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F4134F3832
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B879E343D9C;
	Fri, 31 Oct 2025 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PyloNNZJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FrhQxKFc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="glSWuGlw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9WLcGcjd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E69343215
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908184; cv=none; b=vAAOomzav61lBBOkn7mD5gsKff9isEigSC2lN//76TQ85Cor6ZXVXgxvZzuXJMoTA/h6ApjubsLwJc8/vnDsJbl/x+/nx8zu3M8G4Fv5wVaE7xslRb3XiOYkegrJ4Q8lp3OBw9Y+3c6QRSRJPL8fCWtY3Ro+CPmbaVKP5rCJQxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908184; c=relaxed/simple;
	bh=aqkpk0907gEDrYjyh4dD1xSFwNhInymF3m35Jw9GX0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8rSGdF4RRmO8JdGc9Pzae8LYY40r8Jmw/alOrhtxeAX07befYrOkpsW2fUZZjf29G1MtYyrttvwAwWs9ovARceR+yaZt570YeFbyTNSJS9zIIhX871GCPs8bMXVMbZ7aSxVGShVDEi8wvJKS5Je5LYNsVd8KK7HqFUZqxTsS4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PyloNNZJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FrhQxKFc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=glSWuGlw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9WLcGcjd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 713CF1F393;
	Fri, 31 Oct 2025 10:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761908180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSEMlsb3tkCNMcLOu6HJBLyWi0YFWFFKd1FmBNJkS5U=;
	b=PyloNNZJYCNL7Yuib0j1FegxqXXEuzAFJpvEQvX+qTcEJ1iHS+iClzSRgzkgzSKM5wG345
	N3EYhb6MSJ3HWSgXc/QmEisMHk90qMbhlAZbpkzEN1ExgrILFHHMFprw9IioewCtSRD/Dt
	fUz8RHrHXHW+oMyAORPo4k/MQJswtcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761908180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSEMlsb3tkCNMcLOu6HJBLyWi0YFWFFKd1FmBNJkS5U=;
	b=FrhQxKFcYslh699+bjSuN4o1uBDLuUNFp8xYTXSXqdqaYRWvFz/UFZ5gclC5yST8C95NrO
	ryuZ3fJp/zsnQyAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=glSWuGlw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9WLcGcjd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761908179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSEMlsb3tkCNMcLOu6HJBLyWi0YFWFFKd1FmBNJkS5U=;
	b=glSWuGlwDPtoDlVb7tNvY/iLJgmj+VGK3/Qez2PFe7YrTcHEpb6eoKj8uWrQqUNntJxyhT
	PO+ONwxqQHyyfQtmeuGSFR0KO5I52dvMN0VPMu6SIFoMWwjZKVBvSanZ1ujcEAqw6Td12j
	mfLKpRQyUfjTI/x2dFL1v1NVCMgZgjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761908179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSEMlsb3tkCNMcLOu6HJBLyWi0YFWFFKd1FmBNJkS5U=;
	b=9WLcGcjdYIEn6WTkPdz643Cb8uOaMqDTvQAumY+K9pcDsMng+COjDl6y81oBVonjDmQ8p3
	lttl3DAS68DNY6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 678F413393;
	Fri, 31 Oct 2025 10:56:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QdVCGdOVBGnaMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 31 Oct 2025 10:56:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 23A65A0A77; Fri, 31 Oct 2025 11:56:19 +0100 (CET)
Date: Fri, 31 Oct 2025 11:56:19 +0100
From: Jan Kara <jack@suse.cz>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <branden@debian.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
Message-ID: <75ug4vsltx6tiwmt7m4rquh7uxsbpqqgopxjj7ethfkkdsmt7v@ycgd272ybqto>
References: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>
 <bfa7e72ea17ed369a1cf7589675c35728bb53ae4.1761907223.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfa7e72ea17ed369a1cf7589675c35728bb53ae4.1761907223.git.alx@kernel.org>
X-Rspamd-Queue-Id: 713CF1F393
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Fri 31-10-25 11:44:14, Alejandro Colomar wrote:
> Suggested-by: Pali Rohár <pali@kernel.org>
> Co-authored-by: Pali Rohár <pali@kernel.org>
> Co-authored-by: Jan Kara <jack@suse.cz>
> Cc: "G. Branden Robinson" <branden@debian.org>
> Cc: <linux-fsdevel@vger.kernel.org>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
> 
> Hi Jan,
> 
> I've put your suggestions into the patch.  I've also removed the
> sentence about POSIX, as Pali discussed with Branden.
> 
> At the bottom of the email is the range-diff against the previous
> version.

Thanks! The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> 
> Have a lovely day!
> Alex
> 
>  man/man3/readdir.3      | 19 ++++++++++++++++++-
>  man/man3type/stat.3type | 20 +++++++++++++++++++-
>  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/man/man3/readdir.3 b/man/man3/readdir.3
> index e1c7d2a6a..220643795 100644
> --- a/man/man3/readdir.3
> +++ b/man/man3/readdir.3
> @@ -58,7 +58,24 @@ .SH DESCRIPTION
>  structure are as follows:
>  .TP
>  .I .d_ino
> -This is the inode number of the file.
> +This is the inode number of the file
> +in the filesystem containing
> +the directory on which
> +.BR readdir ()
> +was called.
> +If the directory entry is the mount point,
> +then
> +.I .d_ino
> +differs from
> +.I .st_ino
> +returned by
> +.BR stat (2)
> +on this file:
> +.I .d_ino
> +is the inode number of the mount point,
> +while
> +.I .st_ino
> +is the inode number of the root directory of the mounted filesystem.
>  .TP
>  .I .d_off
>  The value returned in
> diff --git a/man/man3type/stat.3type b/man/man3type/stat.3type
> index 76ee3765d..ea9acc5ec 100644
> --- a/man/man3type/stat.3type
> +++ b/man/man3type/stat.3type
> @@ -66,7 +66,25 @@ .SH DESCRIPTION
>  macros may be useful to decompose the device ID in this field.)
>  .TP
>  .I .st_ino
> -This field contains the file's inode number.
> +This field contains the file's inode number
> +in the filesystem on
> +.IR .st_dev .
> +If
> +.BR stat (2)
> +was called on the mount point,
> +then
> +.I .st_ino
> +differs from
> +.I .d_ino
> +returned by
> +.BR readdir (3)
> +for the corresponding directory entry in the parent directory.
> +In this case,
> +.I .st_ino
> +is the inode number of the root directory of the mounted filesystem,
> +while
> +.I .d_ino
> +is the inode number of the mount point in the parent filesystem.
>  .TP
>  .I .st_mode
>  This field contains the file type and mode.
> 
> Range-diff against v2:
> 1:  d3eeebe81 ! 1:  bfa7e72ea man/man3/readdir.3, man/man3type/stat.3type: Improve documentation about .d_ino and .st_ino
>     @@ Commit message
>      
>          Suggested-by: Pali Rohár <pali@kernel.org>
>          Co-authored-by: Pali Rohár <pali@kernel.org>
>     +    Co-authored-by: Jan Kara <jack@suse.cz>
>          Cc: "G. Branden Robinson" <branden@debian.org>
>          Cc: <linux-fsdevel@vger.kernel.org>
>          Signed-off-by: Alejandro Colomar <alx@kernel.org>
>     @@ man/man3/readdir.3: .SH DESCRIPTION
>       .TP
>       .I .d_ino
>      -This is the inode number of the file.
>     -+This is the inode number of the file,
>     -+which belongs to the filesystem
>     -+.I .st_dev
>     -+(see
>     -+.BR stat (3type))
>     -+of the directory on which
>     ++This is the inode number of the file
>     ++in the filesystem containing
>     ++the directory on which
>      +.BR readdir ()
>      +was called.
>      +If the directory entry is the mount point,
>      +then
>      +.I .d_ino
>      +differs from
>     -+.IR .st_ino :
>     ++.I .st_ino
>     ++returned by
>     ++.BR stat (2)
>     ++on this file:
>      +.I .d_ino
>     -+is the inode number of the underlying mount point,
>     ++is the inode number of the mount point,
>      +while
>      +.I .st_ino
>     -+is the inode number of the mounted file system.
>     -+According to POSIX,
>     -+this Linux behavior is considered to be a bug,
>     -+but is nevertheless conforming.
>     ++is the inode number of the root directory of the mounted filesystem.
>       .TP
>       .I .d_off
>       The value returned in
>     @@ man/man3type/stat.3type: .SH DESCRIPTION
>       .TP
>       .I .st_ino
>      -This field contains the file's inode number.
>     -+This field contains the file's inode number,
>     -+which belongs to the
>     ++This field contains the file's inode number
>     ++in the filesystem on
>      +.IR .st_dev .
>      +If
>      +.BR stat (2)
>      +was called on the mount point,
>      +then
>     -+.I .d_ino
>     -+differs from
>     -+.IR .st_ino :
>     -+.I .d_ino
>     -+is the inode number of the underlying mount point,
>     -+while
>      +.I .st_ino
>     -+is the inode number of the mounted file system.
>     ++differs from
>     ++.I .d_ino
>     ++returned by
>     ++.BR readdir (3)
>     ++for the corresponding directory entry in the parent directory.
>     ++In this case,
>     ++.I .st_ino
>     ++is the inode number of the root directory of the mounted filesystem,
>     ++while
>     ++.I .d_ino
>     ++is the inode number of the mount point in the parent filesystem.
>       .TP
>       .I .st_mode
>       This field contains the file type and mode.
> 
> base-commit: f305f7647d5cf62e7e764fb7a25c4926160c594f
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

