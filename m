Return-Path: <linux-fsdevel+bounces-15247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E78A88B106
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 21:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D04BE2DF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635EC134B6;
	Mon, 25 Mar 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QIudOJ9I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S1J3EIl0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cj2ypcyX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x2SsD2Mn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133661773A;
	Mon, 25 Mar 2024 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394213; cv=none; b=VOryPVqdI0WRKTUOt0gF1u7Kb+yS1sTkobctd1ufseGJyVQOB3NH8XYfDVVYHADLwpX5M2132IJMYzJ6IspWaTpCsINghGxlqs6IARM/kGAa0I9K1V614KYZ9cEgOLa4Rl/75PUe441pBRw5j3ApUmV9Nyy4XM700GzZ58HLqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394213; c=relaxed/simple;
	bh=FS/JzakntYFsXIiZNXo/X5qSz+O9mZ/aKMbnCCtBXkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/OK8ApbVKYwveYQhHWMrRw8De4tG25vxCSlTrGBtUnhaENqhkzSJfbIG34VAAZQbLwGPeJisL/O1O2xpvG14SS26HO37LJh8q0CvcWdpE0ekb+ILlZx6dQ4spg2PZ7vxqJ9LdyGx3w4A95G0LYzjIJgvnBFOoLnzPe9mPAvxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QIudOJ9I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S1J3EIl0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cj2ypcyX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x2SsD2Mn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 166015CABF;
	Mon, 25 Mar 2024 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711394210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uEgl58apLNyzovccmMCRU9q170bGqNSFjc+5DQd8mo=;
	b=QIudOJ9IA5Gyl9TJng1RsA5V+AH0AQVVu8gB3SmTqRzaYk4hFUzwcHOSyvOlEJmTecbiuf
	qF23SN152RkBZ1ra7oFZlxsXEtC/0XazsSujTQwwIEH0/BkYZ4TJqWpEQIWyMUfLv+A2UZ
	CvFqdkAfphiN2HXM85I9uR/PnDOta08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711394210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uEgl58apLNyzovccmMCRU9q170bGqNSFjc+5DQd8mo=;
	b=S1J3EIl0sQI9g5hv1Ggc6IfxpR+2zSp9tAB+R/iVR7jliAskC/bjd6YBU3L4PgXaaHWvel
	DEphlMEDgNaNuUBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711394209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uEgl58apLNyzovccmMCRU9q170bGqNSFjc+5DQd8mo=;
	b=Cj2ypcyXMUs8QcS4hsS1TLkYl5BWPYmVxXdmS6JyA7i+8wQuTtWMybl0WvBl+zmPG3HEYe
	3eOeUhl2hPjh96Aq9XuNZO7Do9gDcvkMar9sJH/y4aJYK4IVSMK7o+Gxt2NwoFYAeOWi1p
	CLUqMuniDPrYHcq7/HclaTZ6rSkqvhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711394209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uEgl58apLNyzovccmMCRU9q170bGqNSFjc+5DQd8mo=;
	b=x2SsD2MnxX89ObKQ/1JOjZDAPzG2bLS9N4uzex3BYpgFo0cWyIHobMhooGiD5ftA/ELs1q
	kbww13Zq3d1DLSBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F1A9013A2E;
	Mon, 25 Mar 2024 19:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qVC7OqDNAWaLZwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 25 Mar 2024 19:16:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE0F1A0812; Mon, 25 Mar 2024 20:16:45 +0100 (CET)
Date: Mon, 25 Mar 2024 20:16:45 +0100
From: Jan Kara <jack@suse.cz>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] fanotify: remove unneeded sub-zero check for unsigned
 value
Message-ID: <20240325191645.viuo2f2zujx67ec6@quack3>
References: <>
 <d296ff1c-dcf7-4813-994b-3c4369debb7d@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d296ff1c-dcf7-4813-994b-3c4369debb7d@ancud.ru>
X-Spam-Score: -0.82
X-Spamd-Result: default: False [-0.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,suse.com:email,ancud.ru:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org,linuxtesting.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.71%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Thu 14-03-24 16:36:56, Nikita Kiryushin wrote:
> 
> Unsigned size_t len in copy_fid_info_to_user is checked
> for negative value. This check is redundant as it is
> always false.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 5e469c830fdb ("fanotify: copy event fid info to user")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>

Looks good. Added to my tree. Thanks!

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index fbdc63cc10d9..4201723357cf 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -502,7 +502,7 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>  	}
>  	/* Pad with 0's */
> -	WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
> +	WARN_ON_ONCE(len >= FANOTIFY_EVENT_ALIGN);
>  	if (len > 0 && clear_user(buf, len))
>  		return -EFAULT;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

