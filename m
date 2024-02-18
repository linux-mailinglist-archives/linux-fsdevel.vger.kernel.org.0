Return-Path: <linux-fsdevel+bounces-11962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9B08599D1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 23:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785FF281777
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 22:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D11E745D7;
	Sun, 18 Feb 2024 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kkq8occd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vi14/Cxb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kkq8occd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vi14/Cxb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37D65BDB;
	Sun, 18 Feb 2024 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708295334; cv=none; b=C1Pr1sQVg24t/NtmNGhnXTG2xy5wt/Uhe8CkwkfUPyjOSXXMff789Ks5oHy3smOgwg2rtFd5xK7TkL6T7gCMnlfN8xgH8dU3U0ictJcm5I50cx6I6qrU33OSxaDpjHd0gpbGmTPAbz8+y6zlsfp7PjhZqfv93F1HbQuqzLiOL3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708295334; c=relaxed/simple;
	bh=Uj5Oy4S8z6qdzsmn9DPo/NQUyt0aNfVEjkLbHnv86dM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=urxBOPaUU92D4/KBPBFq3BHf7KNccH7bfb5MVda6JicDBps2MnKlkxwzgOJYdW1pUlsu+mdc79IQkLs6zsxsPb90fYoB8vbzfcTagwa2bRT1s/rD4k8plEnD3fGR1N6R8hVuGsYqVLmt0t1B/DPKuQjO1ierkpU7xVwSMsxhod0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kkq8occd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vi14/Cxb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kkq8occd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vi14/Cxb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51EFA1FCF8;
	Sun, 18 Feb 2024 22:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708295325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnG5SiORvKW2Xi5axh412GtTGevEmeL/8o5GMM3myBI=;
	b=Kkq8occdCxhc04PejF3VcThY0Xjlc9+DV81DPfSuD8rRyELJRYZpW+aJZT9wQ6E+TC1iL5
	CYVND63yT4HnZKXvuiHCQ0RKGoP+CQpu52aImZkdSdWj66TCNWaJV9foGeJ6cESxdBxIIu
	qSP9gYWFHEBmSX996wT2hQlquLyWvG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708295325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnG5SiORvKW2Xi5axh412GtTGevEmeL/8o5GMM3myBI=;
	b=vi14/CxbLmbDle4oFB4QTA2sCtb0zwUM8WI/A2jLwU2S9I/ZUzqpqWX0GWjWbZEWMi1T13
	EglzsjA0E5ydYSBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708295325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnG5SiORvKW2Xi5axh412GtTGevEmeL/8o5GMM3myBI=;
	b=Kkq8occdCxhc04PejF3VcThY0Xjlc9+DV81DPfSuD8rRyELJRYZpW+aJZT9wQ6E+TC1iL5
	CYVND63yT4HnZKXvuiHCQ0RKGoP+CQpu52aImZkdSdWj66TCNWaJV9foGeJ6cESxdBxIIu
	qSP9gYWFHEBmSX996wT2hQlquLyWvG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708295325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnG5SiORvKW2Xi5axh412GtTGevEmeL/8o5GMM3myBI=;
	b=vi14/CxbLmbDle4oFB4QTA2sCtb0zwUM8WI/A2jLwU2S9I/ZUzqpqWX0GWjWbZEWMi1T13
	EglzsjA0E5ydYSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B6E5139D8;
	Sun, 18 Feb 2024 22:28:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GIrSBJqE0mWeCAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 18 Feb 2024 22:28:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "kernel test robot" <oliver.sang@intel.com>,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH] filelock: fix deadlock detection in POSIX locking
In-reply-to: <20240218-flsplit4-v1-1-26454fc090f2@kernel.org>
References: <20240218-flsplit4-v1-1-26454fc090f2@kernel.org>
Date: Mon, 19 Feb 2024 09:28:39 +1100
Message-id: <170829531945.1530.2712558842533100280@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.65 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.75)[84.04%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,gmail.com,oracle.com,suse.cz,vger.kernel.org,intel.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.65

On Mon, 19 Feb 2024, Jeff Layton wrote:
> The FL_POSIX check in __locks_insert_block was inadvertantly broken
> recently and is now inserting only OFD locks instead of only legacy
> POSIX locks.
>=20
> This breaks deadlock detection in POSIX locks, and may also be the root
> cause of a performance regression noted by the kernel test robot.
> Restore the proper sense of the test.
>=20
> Fixes: b6be3714005c ("filelock: convert __locks_insert_block, conflict and =
deadlock checks to use file_lock_core")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202402181229.f8147f40-oliver.sang@in=
tel.com
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Disregard what I said earlier about this bug being harmless. It broke
> deadlock detection in POSIX locks (LTP fcntl17 shows the bug). This
> patch fixes it. It may be best to squash this into the patch that
> introduced the regression.
>=20
> I'm not certain if this fixes the performance regression that the KTR
> noticed recently in this patch, but that's what got me looking more
> closely, so I'll give it credit for reporting this. Hopefully it'll
> confirm that result for us.
> ---
>  fs/locks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 26d52ef5314a..90c8746874de 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -812,7 +812,7 @@ static void __locks_insert_block(struct file_lock_core =
*blocker,
>  	list_add_tail(&waiter->flc_blocked_member,
>  		      &blocker->flc_blocked_requests);
> =20
> -	if ((blocker->flc_flags & (FL_POSIX|FL_OFDLCK)) =3D=3D (FL_POSIX|FL_OFDLC=
K))
> +	if ((blocker->flc_flags & (FL_POSIX|FL_OFDLCK)) =3D=3D FL_POSIX)
>  		locks_insert_global_blocked(waiter);

I wonder how that happened... sorry I didn't notice it in my review.

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


> =20
>  	/* The requests in waiter->flc_blocked are known to conflict with
>=20
> ---
> base-commit: 292fcaa1f937345cb65f3af82a1ee6692c8df9eb
> change-id: 20240218-flsplit4-e843536f4c11
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


