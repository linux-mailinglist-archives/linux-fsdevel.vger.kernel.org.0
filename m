Return-Path: <linux-fsdevel+bounces-45158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51375A73DF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 19:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A6F7A5901
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6901921ABC9;
	Thu, 27 Mar 2025 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eXCnCWX+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VjFdkMwF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eXCnCWX+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VjFdkMwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F61D21A45F
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743099662; cv=none; b=Ki+XMbnY0Vg0D0h/hxTFwuaHOos0HmJyMGft2mkGY/8+41RPCgLjVFuYX4ttmav8Cyx+20gpH0Dues2Mfe5gTm3eX2FK3OzsQOBM/9tOvKMCz2+bxA9ZOfW38bhIOLWfLYFpzpn1qXbfF4f0RXBCxCwGZCzDSnoPdd/2PRnBX7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743099662; c=relaxed/simple;
	bh=aBLV3Sn7z0xp0njCPyD7ONfmrZSIzPT22+6XnwAJ5II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyoJ5wKy/BVStuQr5PtBRfcmPQJ7f3GOOQ+NytUQNH88Cb/jblBAw66ogTu7Zdjqpa0ZLhmXkaiN1YNRjixEzQz/igfQweBcJdkflVnwtzpk9nONFWKmQxPFLx1pc5Dz5j3yrTvDFCwHf5MUYCQ+gvi+fDf5vhTPy6kDoJF8O08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eXCnCWX+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VjFdkMwF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eXCnCWX+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VjFdkMwF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F33D62119B;
	Thu, 27 Mar 2025 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743099659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1tx1jdQvYVz6iQ3XKAZ6sA3Iy0kGapu7x+JoDHx8HE=;
	b=eXCnCWX+M5poAwOACk1QBrI5K51h3oJWu/+TTMg3aeHXutxYPLRiM0MJS/2lM25cx3dG1Q
	IPlkr8s9HYaFY5I9s4KmUe0TC1Mm4x9clryxI4qmvViPPLdlhMjageOFzXPG5XQK5RtX8Y
	o7iv2UHek/aTvXMy9pJqkYWDlLhjF9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743099659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1tx1jdQvYVz6iQ3XKAZ6sA3Iy0kGapu7x+JoDHx8HE=;
	b=VjFdkMwFGBOw+g6GTSrdjWCoWA4CQFBPJmrHFwkofLd9HU185GAu3kB2d8F8pNftEWV2Py
	fPBOxzEf3aQuN8Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eXCnCWX+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VjFdkMwF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743099659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1tx1jdQvYVz6iQ3XKAZ6sA3Iy0kGapu7x+JoDHx8HE=;
	b=eXCnCWX+M5poAwOACk1QBrI5K51h3oJWu/+TTMg3aeHXutxYPLRiM0MJS/2lM25cx3dG1Q
	IPlkr8s9HYaFY5I9s4KmUe0TC1Mm4x9clryxI4qmvViPPLdlhMjageOFzXPG5XQK5RtX8Y
	o7iv2UHek/aTvXMy9pJqkYWDlLhjF9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743099659;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1tx1jdQvYVz6iQ3XKAZ6sA3Iy0kGapu7x+JoDHx8HE=;
	b=VjFdkMwFGBOw+g6GTSrdjWCoWA4CQFBPJmrHFwkofLd9HU185GAu3kB2d8F8pNftEWV2Py
	fPBOxzEf3aQuN8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E16D3139D4;
	Thu, 27 Mar 2025 18:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /QUDNwqX5WfDKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Mar 2025 18:20:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 89133A082A; Thu, 27 Mar 2025 19:20:58 +0100 (CET)
Date: Thu, 27 Mar 2025 19:20:58 +0100
From: Jan Kara <jack@suse.cz>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, jack@suse.cz, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [RFC PATCH 4/4] vfs: add filesystem freeze/thaw callbacks for
 power management
Message-ID: <zcxwcu2ty5fmkqt7dnpwdmohkp6pi7hfhltlxgpnx2xhsutgoc@gkixsx4map3o>
References: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
 <20250327140613.25178-5-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327140613.25178-5-James.Bottomley@HansenPartnership.com>
X-Rspamd-Queue-Id: F33D62119B
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,infradead.org,fromorbit.com,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,hansenpartnership.com:email,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Thu 27-03-25 10:06:13, James Bottomley wrote:
> Introduce a freeze function, which iterates superblocks in reverse
> order freezing filesystems.  The indicator a filesystem is freezable
> is either possessing a s_bdev or a freeze_super method.  So this can
> be used in efivarfs, whether the freeze is for hibernate is also
> passed in via the new FREEZE_FOR_HIBERNATE flag.
> 
> Thawing is done opposite to freezing (so superblock traversal in
> regular order) and the whole thing is plumbed into power management.
> The original ksys_sync() is preserved so the whole freezing step is
> optional (if it fails we're no worse off than we are today) so it
> doesn't inhibit suspend/hibernate if there's a failure.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

OK, I've seen you are setting the new FREEZE_FOR_HIBERNATE flag but I didn't
find anything using that flag. What do you plan to use it for? Does you
efivars usecase need it? I find passing down this detail about the caller
down to all filesystems a bit awkward. Isn't it possible to extract the
information "hibernate is ongoing" from PM subsystem?

> +/*
> + * Kernel freezing and thawing is only done in the power management
> + * subsystem and is thus single threaded (so we don't have to worry
> + * here about multiple calls to filesystems_freeze/thaw().
> + */
> +
> +static int freeze_flags;

Frankly, the global variable to propagate flags is pretty ugly... If we
really have to propagate some context into the iterator callback, rather do
it explicitly like iterate_supers() does it.

> +static void filesystems_freeze_callback(struct super_block *sb)
> +{
> +	/* errors don't fail suspend so ignore them */
> +	if (sb->s_op->freeze_super)
> +		sb->s_op->freeze_super(sb, FREEZE_MAY_NEST
> +				       | FREEZE_HOLDER_KERNEL
> +				       | freeze_flags);
> +	else if (sb->s_bdev)
> +		freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL
> +			     | freeze_flags);

Style nit - braces around above blocks would be IMHO appropriate.

> +	else {
> +		pr_info("Ignoring filesystem %s\n", sb->s_type->name);
> +		return;
> +	}
> +
> +	pr_info("frozen %s, now syncing block ...", sb->s_type->name);
> +	sync_blockdev(sb->s_bdev);
> +	pr_info("done.");
> +}

Generally this callback is not safe because it can race with filesystem
unmount and calling ->freeze_super() after the filesystem's ->put_super()
was called may have all sorts of interesting effects (freeze_super() itself
will just bail with a warning, which is better but not great either).

The cleanest way I see how to make the iteration safe is to grab active sb
reference (like grab_super() does it) for the duration of freeze_super()
calls. Another possibility would be to grab sb->s_umount rwsem exclusively
as Luis does it in his series but that requires a bit of locking surgery
and ->freeze_super() handlers make this particularly nasty these days so I
think active sb reference is going to be nicer these days.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

