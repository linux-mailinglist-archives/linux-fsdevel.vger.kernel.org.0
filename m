Return-Path: <linux-fsdevel+bounces-66441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83292C1F419
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DE7402E73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9232F6189;
	Thu, 30 Oct 2025 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yb70e5pX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bQYGv3cg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SENs5ZAR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D1Om1QgN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6810278E5D
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816094; cv=none; b=ZCb0YAdXc4NhdT19poFlvP8uQMt+DLnzNFkgHHDfXacLfIS4CDqBLWLYUn7OCWh91HIfv++atLTx14DgHhwaRX/W25RvMdu5QVcqmgPw4lobc7cid5ripboDhm0mKc2ne/x2smb2G1gxjzTTm7H9Jdzhv1bw/kFLZv4izkRhk0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816094; c=relaxed/simple;
	bh=mey37MteCDHBKJI5h/hOYw2OFoMf57tziUJBushSKbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poq/AnWcl7dnhosUEJsrb59J+IMTT9jLFNDPiF4yXoGG9dWrgmCuwOITpFxu3o7S31nGboqsjR4Ol3StZSkY6aio64cNHKP5eF0k+f4af0QC+oFADaDFcQL4DndiVHNFNMhRnlcvqrS8Ww8gOzWTT97TMXgPqjK8nUJkuT1KkX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yb70e5pX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bQYGv3cg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SENs5ZAR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D1Om1QgN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D475F1FB7D;
	Thu, 30 Oct 2025 09:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761816091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pvbv2sklXqmoaX+CK0LqtKadq+enVVZtpxET8db+orM=;
	b=yb70e5pXF1TSbHliSdhzU3Llt1VmZKKcDTNC/6CNt5y/+aUSCNMETsFWMGG9laeunI3zha
	6ZN56WI/iqRb8tBEfMEeOFE4VwVWdIaTyz5B13G2YEhtLjZ06FXu0aBnYsmCO467rBAAwB
	Sxdd6GMIjPYVrn43yhh5Lq+W49eVJf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761816091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pvbv2sklXqmoaX+CK0LqtKadq+enVVZtpxET8db+orM=;
	b=bQYGv3cg2BN0E3sU1leFaAdQKlZLzlu/pyNyDgR16feEWr5utq8wS6opSGpJuTyzzC5+xU
	2cQQ+JKPldVI+UAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761816090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pvbv2sklXqmoaX+CK0LqtKadq+enVVZtpxET8db+orM=;
	b=SENs5ZARRKtMsQstswlC6k3Ri9VRb3EQoLveYJ0c8Y/NMW9l6Cyp74VPaiVu8BkZgXY2gf
	oRMik1WzpSYZMrQ+zRn2vD9tVgdh+uGpqQHLUdfXZs3+xB8S4Ivj/tJjkCD8k3iuJvWru7
	rnJFC4OPjqd0wl2/e/xbb1+VUOc9P+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761816090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pvbv2sklXqmoaX+CK0LqtKadq+enVVZtpxET8db+orM=;
	b=D1Om1QgNI6GI/63fEoin48YVV1OZR8lOZM+Q8UGhBGL6D35c7ontH3sT7KTaT/igiKgyWR
	UscOSE/YMOHoHcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAD291396A;
	Thu, 30 Oct 2025 09:21:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IcR/MRouA2l8agAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 09:21:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6160CA0AD6; Thu, 30 Oct 2025 10:21:30 +0100 (CET)
Date: Thu, 30 Oct 2025 10:21:30 +0100
From: Jan Kara <jack@suse.cz>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] man/man2/flock.2: Mention non-atomicity w.r.t close
Message-ID: <xvwzokj7inyw4x2brbuprosk5i2w53p3qjerkcjfsy6lg43krm@gp65tt2tg4kw>
References: <181d561860e52955b29fe388ad089bde4f67241a.1760627023.git.amonakov@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181d561860e52955b29fe388ad089bde4f67241a.1760627023.git.amonakov@ispras.ru>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 16-10-25 18:22:36, Alexander Monakov wrote:
> Ideally one should be able to use flock to synchronize with another
> process (or thread) closing that file, for instance before attempting
> to execve it (as execve of a file open for writing fails with ETXTBSY).
> 
> Unfortunately, on Linux it is not reliable, because in the process of
> closing a file its locks are dropped before the refcounts of the file
> (as well as its underlying filesystem) are decremented, creating a race
> window where execve of the just-unlocked file sees it as if still open.
> 
> Linux developers have indicated that it is not easy to fix, and the
> appropriate course of action for now is to document this limitation.
> 
> Link: <https://lore.kernel.org/linux-fsdevel/68c99812-e933-ce93-17c0-3fe3ab01afb8@ispras.ru/>
> 
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>

The change looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  man/man2/flock.2 | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/man/man2/flock.2 b/man/man2/flock.2
> index b424b3267..793eaa3bd 100644
> --- a/man/man2/flock.2
> +++ b/man/man2/flock.2
> @@ -245,6 +245,21 @@ .SH NOTES
>  and occurs on many other implementations.)
>  .\" Kernel 2.5.21 changed things a little: during lock conversion
>  .\" it is now the highest priority process that will get the lock -- mtk
> +.P
> +Release of a lock when a file descriptor is closed
> +is not sequenced after all observable effects of
> +.BR close (2).
> +For example, if one process writes a file while holding an exclusive lock,
> +then closes that file, and another process blocks placing a shared lock
> +on that file to wait until it is closed, it may observe that subsequent
> +.BR execve (2)
> +of that file fails with
> +.BR ETXTBSY ,
> +and
> +.BR umount (2)
> +of its underlying filesystem fails with
> +.BR EBUSY ,
> +as if the file is still open in the first process.
>  .SH SEE ALSO
>  .BR flock (1),
>  .BR close (2),
> 
> Range-diff against v0:
> -:  --------- > 1:  181d56186 man/man2/flock.2: Mention non-atomicity w.r.t close
> -- 
> 2.49.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

