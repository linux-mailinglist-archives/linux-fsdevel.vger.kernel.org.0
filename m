Return-Path: <linux-fsdevel+bounces-61724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22946B59542
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 009187AD943
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 11:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A716C2F6567;
	Tue, 16 Sep 2025 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZzV0iWwc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ulsCkgJd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZzV0iWwc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ulsCkgJd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8E2D8DDA
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022468; cv=none; b=YRy6DDKLxOmWxjL4ObXv6wyuyTtcQYq57jhZoriszmpeozfDuFeUIA5T36qOeB92tttqoMgt8tHMhJ87B6gDYwVL6ZKJGUe8MGQqCSGMd7wmIh/xJSl4f6NXbLPYx0DnDtuLyFxlAd9iLWq9cFW7S6Xibv1Bdq8VufLEd89wF+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022468; c=relaxed/simple;
	bh=jwda/6LBG50JcQMwFvG4rqPYkyTWOkeUBQzc/cXs8fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTwvn5Vg/0Ij7ADHPJZTsuoq/CgIigpy7wDImzbEJ8KcKbPCFBy2/1TIe0fklQHhukJtgYQWUD7PB1nZPk9QDB8lu7bkLyHSSo3KzcWW1DIafwMinjZ9xGRKg6YQmvs22hgUG5r+DBsQchKGHjUgEGYitbYk/TvTwjiBMziFHoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZzV0iWwc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ulsCkgJd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZzV0iWwc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ulsCkgJd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C912C21FF4;
	Tue, 16 Sep 2025 11:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758022464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5fhBm9oRUq/7LCO1SyruLQVKq17cgO0pzPjr5cDTj58=;
	b=ZzV0iWwcoKjp7+Gy1ZV+BpXEIOt5ZcdiWXAkNVrrekCNUoUQRtlMWthaTgG7AW5SIYMyIJ
	317AnruR+qSDy65As8tGZpkm2ppMAo3fk3XAgCYhiVjvAYtctBlrf/ePO229N07lFi7kvd
	jbMC1jeu8KtHWZtmS2+giDlaxuporkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758022464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5fhBm9oRUq/7LCO1SyruLQVKq17cgO0pzPjr5cDTj58=;
	b=ulsCkgJdSXAE7/HZLZpLAjWF5RNEZoJwYRIavxhpzDtXVvVaeb9qbezCibJRGcaUUyXi9W
	rs5q+ynr7jQYN+Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758022464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5fhBm9oRUq/7LCO1SyruLQVKq17cgO0pzPjr5cDTj58=;
	b=ZzV0iWwcoKjp7+Gy1ZV+BpXEIOt5ZcdiWXAkNVrrekCNUoUQRtlMWthaTgG7AW5SIYMyIJ
	317AnruR+qSDy65As8tGZpkm2ppMAo3fk3XAgCYhiVjvAYtctBlrf/ePO229N07lFi7kvd
	jbMC1jeu8KtHWZtmS2+giDlaxuporkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758022464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5fhBm9oRUq/7LCO1SyruLQVKq17cgO0pzPjr5cDTj58=;
	b=ulsCkgJdSXAE7/HZLZpLAjWF5RNEZoJwYRIavxhpzDtXVvVaeb9qbezCibJRGcaUUyXi9W
	rs5q+ynr7jQYN+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB54613ACD;
	Tue, 16 Sep 2025 11:34:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kIS3LUBLyWgyZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Sep 2025 11:34:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 777E6A0A56; Tue, 16 Sep 2025 13:34:16 +0200 (CEST)
Date: Tue, 16 Sep 2025 13:34:16 +0200
From: Jan Kara <jack@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, LTP List <ltp@lists.linux.it>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Christian Brauner <brauner@kernel.org>, 
	chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250915: LTP chdir01 df01_sh stat04 tst_device.c:97:
 TBROK: Could not stat loop device 0
Message-ID: <h3ov4pformuvguwsxtziqui2alarqno37kdru4bjsppeok4sth@yb4iposv7okd>
References: <CA+G9fYuFdesVkgGOow7+uQpw-QA6hdqBBUye8CKMxGAiwHagOA@mail.gmail.com>
 <arfepejkmgi63wepbkfhl2jjbhleh5degel7i3o7htgwjsayqg@z3pjoszloxni>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arfepejkmgi63wepbkfhl2jjbhleh5degel7i3o7htgwjsayqg@z3pjoszloxni>
X-Spam-Level: 
X-Spamd-Result: default: False [-7.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.it,lists.linaro.org,lists.linux.dev,kernel.org,suse.cz,arndb.de,linaro.org,zeniv.linux.org.uk,gmail.com,oracle.com,samsung.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -7.80

On Tue 16-09-25 13:04:42, Jan Kara wrote:
> On Tue 16-09-25 12:57:26, Naresh Kamboju wrote:
> > The following LTP chdir01 df01_sh and stat04 tests failed on the rock-pi-4b
> > qemu-arm64 on the Linux next-20250915 tag build.
> > 
> > First seen on next-20250915
> > Good: next-20250912
> > Bad: next-20250915
> > 
> > Regression Analysis:
> > - New regression? yes
> > - Reproducibility? yes
> > 
> > * rk3399-rock-pi-4b, ltp-smoke
> > * qemu-arm64, ltp-smoke
> > * qemu-arm64-compat, ltp-smoke
> >  - chdir01
> >   - df01_sh
> >   - stat04
> > 
> > Test regression: next-20250915: LTP chdir01 df01_sh stat04
> > tst_device.c:97: TBROK: Could not stat loop device 0
> 
> This is really strange. Those failing tests all start to complain that
> /dev/loop0 doesn't exist (open gets ENOENT)... The fact that this is
> limited to only a few archs suggests it's some race somewhere but I don't
> see any relevant changes in linux-block in last three days...

Ha, Mark Brown tracked this [1] to changes in VFS tree in
extensible_ioctl_valid(). More discussion there I guess.

[1] https://lore.kernel.org/all/02da33e3-6583-4344-892f-a9784b9c5b1b@sirena.org.uk

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

