Return-Path: <linux-fsdevel+bounces-24805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D54945098
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BB51C2296F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6745013C9A3;
	Thu,  1 Aug 2024 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="flX18FAX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jk5Ndq2c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="flX18FAX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jk5Ndq2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424C1EB496
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529898; cv=none; b=tRHlCsnIN8hlGtnRxEawdwOx91YugFrM64QXytwlULonFS8Op6S7dnPXSZqJqSrIV4NpV2fi7Vql1sBuzX81zj8IMCTPLOl0cTYj8a4CdLiOwbs5GSMywROceLA+TGdmPPEpYhNqAGnK4Z7HQqLsKuvEMwtnrwYPtHHJ3/Ta1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529898; c=relaxed/simple;
	bh=uN6/4oOTovZppo8BsFss1fgbi5NkDZPcicNoie+xNOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mx5UIrTO3byHgS++zPg1yURQ/Y13xXHSH9bXO2Idw2dhrGO8/vUcZAFMFjuk82NKCigKxPYkT0Bvww6UKJ+qoZrImgG3BMNvzr3dgjLHV+X+osM7vR1IJugGKKLjMaxxD1PRflsjhOTxosMMfVLGLS/IfoDzyHfS9ypr/TsDjCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=flX18FAX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jk5Ndq2c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=flX18FAX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jk5Ndq2c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EC141FB64;
	Thu,  1 Aug 2024 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722529895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnlIBnoBefnsIl9FAN9h/SKeJRmuUxHN8XQN5ZOULYs=;
	b=flX18FAXLSzl5oxzlPvsdgzEv59rqdrK/GnJ6P9ldA5nOBTC9V7U0VS+W/NJzX2L2kQl0E
	yGs2CiwYu108RMxpVTuoQkCOeYnvxGuKJIZlMpFiyg5mjByFm/+bScqJ318gMSeM+Myn5U
	IyQ3Z3AwcZfJbvNWNibsmZVjkGWOeL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722529895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnlIBnoBefnsIl9FAN9h/SKeJRmuUxHN8XQN5ZOULYs=;
	b=Jk5Ndq2cGSRji9t7U+b7o+NlIC8CG6Ha0VyzvXPMZ3Mdq5zNDrgO6iX0EQpOh43gOhcpWc
	/rdnP//xv0Wu5nCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=flX18FAX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Jk5Ndq2c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722529895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnlIBnoBefnsIl9FAN9h/SKeJRmuUxHN8XQN5ZOULYs=;
	b=flX18FAXLSzl5oxzlPvsdgzEv59rqdrK/GnJ6P9ldA5nOBTC9V7U0VS+W/NJzX2L2kQl0E
	yGs2CiwYu108RMxpVTuoQkCOeYnvxGuKJIZlMpFiyg5mjByFm/+bScqJ318gMSeM+Myn5U
	IyQ3Z3AwcZfJbvNWNibsmZVjkGWOeL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722529895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnlIBnoBefnsIl9FAN9h/SKeJRmuUxHN8XQN5ZOULYs=;
	b=Jk5Ndq2cGSRji9t7U+b7o+NlIC8CG6Ha0VyzvXPMZ3Mdq5zNDrgO6iX0EQpOh43gOhcpWc
	/rdnP//xv0Wu5nCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F26A13946;
	Thu,  1 Aug 2024 16:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 65VhA2e4q2aLJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 16:31:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7538A08CB; Thu,  1 Aug 2024 18:31:34 +0200 (CEST)
Date: Thu, 1 Aug 2024 18:31:34 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 02/10] fsnotify: introduce pre-content permission event
Message-ID: <20240801163134.4rj7ogd5kthsnsps@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <a6010470b2d11f186cba89b9521940716fa66f3b.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6010470b2d11f186cba89b9521940716fa66f3b.1721931241.git.josef@toxicpanda.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.81 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 1EC141FB64
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.81

On Thu 25-07-24 14:19:39, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> The new FS_PRE_ACCESS permission event is similar to FS_ACCESS_PERM,
> but it meant for a different use case of filling file content before
> access to a file range, so it has slightly different semantics.
> 
> Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events, same as
> we did for FS_OPEN_PERM/FS_OPEN_EXEC_PERM.
> 
> FS_PRE_MODIFY is a new permission event, with similar semantics as
> FS_PRE_ACCESS, which is called before a file is modified.
> 
> FS_ACCESS_PERM is reported also on blockdev and pipes, but the new
> pre-content events are only reported for regular files and dirs.
> 
> The pre-content events are meant to be used by hierarchical storage
> managers that want to fill the content of files on first access.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

The patch looks good. Just out of curiosity:

> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 8be029bc50b1..21e72b837ec5 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -56,6 +56,9 @@
>  #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
>  #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
>  
> +#define FS_PRE_ACCESS		0x00100000	/* Pre-content access hook */
> +#define FS_PRE_MODIFY		0x00200000	/* Pre-content modify hook */

Why is a hole left here in the flag space?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

