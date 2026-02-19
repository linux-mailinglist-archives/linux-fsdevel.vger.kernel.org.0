Return-Path: <linux-fsdevel+bounces-77699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEuXDfD1lmndrQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 12:37:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB03415E539
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 12:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72F293025E6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 11:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70C302165;
	Thu, 19 Feb 2026 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ubKyI51S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rtQ0rrTA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ubKyI51S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rtQ0rrTA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE722F616B
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501035; cv=none; b=CE0v9tZPfiNTawhLax5uYnzr97fWRhYgNqQfIB4s3aLgBQxEQhfCmek2RKoHMdqnGhL1RQDN8coFqaXMv8vSiwoc7b6zMm/ta3eoOxchi3x5n4suZgZSLKgOMJRvXYQkJmim75uUb0EZkLrV0f8hizPPbUIxMZqVN3pKyZ15aAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501035; c=relaxed/simple;
	bh=l8+ojl5oXetejK53ULuINNTzE79lQy9y+gPSvgJyuJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiokp6N9sBergE6CigOxJSJAxjyNegukqzqi+lgOumuXVsfMzlBt3qz21g4m4P7obXqbB4Av2/466OEwwUfjgMeAu56x4X+BheMyV4jWmPp5h+9S82chJTg6MKs3V7Z6mh7dRdVkg5GtYl1p9JacqEbLnB7KIoab89kd1G0lLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ubKyI51S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rtQ0rrTA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ubKyI51S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rtQ0rrTA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E1365BCC1;
	Thu, 19 Feb 2026 11:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771501032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0MzLvpW/pA9/tSsUlsL7WlgoIs3adn6QIwB2d5LgHk=;
	b=ubKyI51SCe9/leF9G2/ltqYSk4h66r82XNIv3X6kyFxQJCr1nv+s+FcEOhp2tTdR3W0ZpB
	0pnAejDc606G0UTkWpEhdSou5ZuV1wSjZ4cZzSVuC1eM5kgTqeAVramA//9pB8PUABlhwI
	MNB63O8RS0D+Sy7K9G3hwyGdup6FMHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771501032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0MzLvpW/pA9/tSsUlsL7WlgoIs3adn6QIwB2d5LgHk=;
	b=rtQ0rrTA9Od4hiBSJj7Nq32NUf4cRn/wvKaJtq3G8VCy6QAvqjjRhBBnEGjP6tTt2etA60
	GPKHNu3rHUXVQOAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ubKyI51S;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rtQ0rrTA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771501032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0MzLvpW/pA9/tSsUlsL7WlgoIs3adn6QIwB2d5LgHk=;
	b=ubKyI51SCe9/leF9G2/ltqYSk4h66r82XNIv3X6kyFxQJCr1nv+s+FcEOhp2tTdR3W0ZpB
	0pnAejDc606G0UTkWpEhdSou5ZuV1wSjZ4cZzSVuC1eM5kgTqeAVramA//9pB8PUABlhwI
	MNB63O8RS0D+Sy7K9G3hwyGdup6FMHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771501032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0MzLvpW/pA9/tSsUlsL7WlgoIs3adn6QIwB2d5LgHk=;
	b=rtQ0rrTA9Od4hiBSJj7Nq32NUf4cRn/wvKaJtq3G8VCy6QAvqjjRhBBnEGjP6tTt2etA60
	GPKHNu3rHUXVQOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B1363EA65;
	Thu, 19 Feb 2026 11:37:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4lpREuj1lmmjOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Feb 2026 11:37:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0C2BBA06FE; Thu, 19 Feb 2026 12:37:08 +0100 (CET)
Date: Thu, 19 Feb 2026 12:37:08 +0100
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, amir73il@gmail.com, jack@suse.cz, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fsnotify: drop unused helper
Message-ID: <xph7ec77ivh5zjomcauj755luezm3uoexk54kc4xo2idqlhyoz@dip2w6valncl>
References: <177148129514.716249.10889194125495783768.stgit@frogsfrogsfrogs>
 <177148129543.716249.980530449513340111.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177148129543.716249.980530449513340111.stgit@frogsfrogsfrogs>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,suse.cz,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-77699-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AB03415E539
X-Rspamd-Action: no action

On Wed 18-02-26 22:09:21, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Remove this helper now that all users have been converted to
> fserror_report_metadata as of 7.0-rc1.
> 
> Cc: jack@suse.cz
> Cc: amir73il@gmail.com
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fsnotify.h |   13 -------------
>  1 file changed, 13 deletions(-)
> 
> 
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 28a9cb13fbfa38..079c18bcdbde68 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -495,19 +495,6 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
>  		fsnotify_dentry(dentry, mask);
>  }
>  
> -static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
> -				    int error)
> -{
> -	struct fs_error_report report = {
> -		.error = error,
> -		.inode = inode,
> -		.sb = sb,
> -	};
> -
> -	return fsnotify(FS_ERROR, &report, FSNOTIFY_EVENT_ERROR,
> -			NULL, NULL, NULL, 0);
> -}
> -
>  static inline void fsnotify_mnt_attach(struct mnt_namespace *ns, struct vfsmount *mnt)
>  {
>  	fsnotify_mnt(FS_MNT_ATTACH, ns, mnt);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

