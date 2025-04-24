Return-Path: <linux-fsdevel+bounces-47220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D891A9AB85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 13:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F302C92105B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 11:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF07121FF58;
	Thu, 24 Apr 2025 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JhaoT3AY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7jRiJ5pI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VAIvQQzN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oBvIArm9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3A0433A8
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745493374; cv=none; b=ZTfKwQVwHZsGNKQHkHjaZ2EnBKHgbekZ9uIwsR1a3A89aDIwv081NaXfIxUrfncXLTJFOcly/Vd+iBXKg0pB/lt/H6KidDBxkQQzwZS7OOsCCT3ba5NHKrMaybja4eb1PCYyrauDAZiAY3FCNMXCKxMcq3TgdrIN9Oz5m5gz33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745493374; c=relaxed/simple;
	bh=ayeAItDMgm2fVO9ImQRk1guUbq8ElZT7w7tBa+q9EDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAUaj2zwOrqYzrJSZEaXK/aP0ol3V/PJYkCqjVJXbf8WP6sOObqNARnqQzEuj/KCSQ/076Qfjux7LaHRGuvCsyXdajmV9K7um7NKg1C85X0XrHeeZ+31JdYxbedKG1b9wMym7Hy8iaB3cQbfktrcW+HcWoytg7i5cBOtiXKXOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JhaoT3AY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7jRiJ5pI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VAIvQQzN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oBvIArm9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E49E821125;
	Thu, 24 Apr 2025 11:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745493370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6BNUfkJ06C5Dm6KY7AiHSAdOh0/flFOQtasObkqamk=;
	b=JhaoT3AYq12Rj1+bGRR5qMwwuSeHtPaCn+iLBluJGv6h47eJxGS8icsKiB4BFAN51E30w8
	mxUsjUkk/pGdBhw8JcKZy9KGrH5WqC5GsIezr0m8EW3S4VdP3aPavkw78zqV4TwX8EFt4T
	KNXDaHeEYbrT4Ve6LsmlgBtPzEOxiyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745493370;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6BNUfkJ06C5Dm6KY7AiHSAdOh0/flFOQtasObkqamk=;
	b=7jRiJ5pIlZmTukO3rTSRATar6S9V31p/uvM/0jaH0J0qBCXqa/vGNTE5fPhoVU+YxURpUd
	fs9/TEF2jzqB7KBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745493369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6BNUfkJ06C5Dm6KY7AiHSAdOh0/flFOQtasObkqamk=;
	b=VAIvQQzNrW34b1F6U0HXYEGEv4pTjOwYQ9HjIEW3sJQOwXg3CBgDF3X18IGi+a6RybZheK
	RrYPlFQBQo2ZlNvX/af8bDdaVrnLw8ioEY9GaOaZP+mNH5miXP6U7z5HTDR4RjohVbAy9T
	qzly1bdt2hY324T3m6t6d7PL4M1unX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745493369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6BNUfkJ06C5Dm6KY7AiHSAdOh0/flFOQtasObkqamk=;
	b=oBvIArm9HU2dv9tKqpU0ERehaix2Tk/+yJ4VSzwxPDMjRGvyOFTZ/J/17ZkMypUGs9aOOn
	ljtwZFNvNHWDHlAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC1951393C;
	Thu, 24 Apr 2025 11:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nnq5NXkdCmjjOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Apr 2025 11:16:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A9437A0921; Thu, 24 Apr 2025 13:16:05 +0200 (CEST)
Date: Thu, 24 Apr 2025 13:16:05 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] fanotify fixes for v6.15-rc3
Message-ID: <bn2ktlayemkxqgx4bqbymuhvaih47iaudmmcndkc7dpss53nsk@srxq4buohff2>
References: <20250418193903.2607617-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418193903.2607617-1-amir73il@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hi!

On Fri 18-04-25 21:39:01, Amir Goldstein wrote:
> I was working on adding support for FAN_MARK_MNTNS inside user ns
> and ran into this bug.
> 
> Unfortunately, this is Easter weekend and on Sunday I am going for
> two weeks vacation, so I won't be able to handle review comments on
> these patches until at least rc5.
> 
> If you are ok with the bug fix, you may fast track it and if the test
> needs fixing, I can do that when I get back, or feel free to fix it as
> you see fit.

Thanks for the patches. I've picked them up in my tree.

								Honza

> 
> Thanks,
> Amir.
> 
> Amir Goldstein (2):
>   fanotify: fix flush of mntns marks
>   selftests/fs/mount-notify: test also remove/flush of mntns marks
> 
>  fs/notify/fanotify/fanotify_user.c            |  7 +--
>  include/linux/fsnotify_backend.h              | 15 -----
>  .../mount-notify/mount-notify_test.c          | 57 +++++++++++++++----
>  3 files changed, 47 insertions(+), 32 deletions(-)
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

