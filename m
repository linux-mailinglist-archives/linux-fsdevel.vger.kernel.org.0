Return-Path: <linux-fsdevel+bounces-32681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A290B9AD55E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 22:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3D128485B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 20:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C923A1E2617;
	Wed, 23 Oct 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ukx3JE/B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UTj7vNF0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ukx3JE/B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UTj7vNF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3356514EC62;
	Wed, 23 Oct 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714399; cv=none; b=UatWDJj16kgWWT3Y70zxhculQ413gg5LQ/JKnXeBB+bIlsCsZZmla5p+XLCHHkMZ4TeXRr2Oip75pdO1wpu1QCBa8J7VZ6j5LQaQgNOTTSlLqye9w98MLuRDjRPiH36T1vz/oZW3bNjlLs0NB9oQ9aZ+z2JPcYoM4r3URgEsjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714399; c=relaxed/simple;
	bh=MOFcW+D8LS7DPjrSrjeE2JumnTXMfNQ3k+4i1H6/E20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SePgyFnEAbUUsV8Le9UG3OZM7twKf3h+Xcz9W8X6of03ieTU7g3rLjQEDepTyXAcYfOKC2c+eO3F39DBnSGBEHaxlHPHoeqxvoxctQzM50D91Vc04dIP775mMjIIHA6cqpF4tQNVFIJrgcDN269ZyojPAA/eIwpvol8kzVubaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ukx3JE/B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UTj7vNF0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ukx3JE/B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UTj7vNF0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F4C31F444;
	Wed, 23 Oct 2024 20:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729714395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Aa5AfbGc6FVizVDuEwi0ZW+Rm+XqQ1T22HHPwHvWrQ=;
	b=ukx3JE/Bx0WdZGOG6aOyWH1TAeRGfj9YftSSN8xRnUK1GSe/mLTO6NHXOlp5hgXKpR3FSe
	EpBrnya4bDgB0ch1Emo99xa5DquTrmEOg7UveobFbnfooA+NsIYBS/6Cac8SqxnjHeODYr
	fICxuLKvjNOZ3fRp/XLLnbCeygZtBGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729714395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Aa5AfbGc6FVizVDuEwi0ZW+Rm+XqQ1T22HHPwHvWrQ=;
	b=UTj7vNF0zpibJYAldLL8ByqxRlMATcX5EMYwLNCTxsbUp00lHLEbLzVW9wpcDzBMOWkGQQ
	OFKLfhN6FON2wiBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ukx3JE/B";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UTj7vNF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729714395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Aa5AfbGc6FVizVDuEwi0ZW+Rm+XqQ1T22HHPwHvWrQ=;
	b=ukx3JE/Bx0WdZGOG6aOyWH1TAeRGfj9YftSSN8xRnUK1GSe/mLTO6NHXOlp5hgXKpR3FSe
	EpBrnya4bDgB0ch1Emo99xa5DquTrmEOg7UveobFbnfooA+NsIYBS/6Cac8SqxnjHeODYr
	fICxuLKvjNOZ3fRp/XLLnbCeygZtBGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729714395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Aa5AfbGc6FVizVDuEwi0ZW+Rm+XqQ1T22HHPwHvWrQ=;
	b=UTj7vNF0zpibJYAldLL8ByqxRlMATcX5EMYwLNCTxsbUp00lHLEbLzVW9wpcDzBMOWkGQQ
	OFKLfhN6FON2wiBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03E0F13AD3;
	Wed, 23 Oct 2024 20:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N03pANtYGWexeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Oct 2024 20:13:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A301FA08A2; Wed, 23 Oct 2024 22:13:14 +0200 (CEST)
Date: Wed, 23 Oct 2024 22:13:14 +0200
From: Jan Kara <jack@suse.cz>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: v6.12-rc workqueue lockups
Message-ID: <20241023201314.hqfewgr6lej6f7df@quack3>
References: <63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com>
X-Rspamd-Queue-Id: 0F4C31F444
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO


Hi!

On Wed 23-10-24 11:19:24, John Garry wrote:
> I have been seeing lockups reliably occur on v6.12-rc1, 3, 4 and linus'
> master branch:
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> Oct 22 09:07:15 ...
>  kernel:watchdog: BUG: soft lockup - CPU#12 stuck for 26s! [khugepaged:154]
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> Oct 22 09:08:07 ...
>  kernel:BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck
> for 44s!
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> Oct 22 09:08:07 ...
>  kernel:BUG: workqueue lockup - pool cpus=4 node=0 flags=0x0 nice=0 stuck
> for 35s!
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> Oct 22 09:08:07 ...
>  kernel:BUG: workqueue lockup - pool cpus=10 node=0 flags=0x0 nice=0 stuck
> for 33s!
> 
> This is while doing some server MySQL performance testing. v6.11 has no such
> issue.
> 
> I added some debug, and we seem to be spending a lot of time in FS
> writeback, specifically wb_workfn() -> wb_do_writeback() - ring any bells?

Thanks for report. This doesn't remind me of anything but checking the
writeback changes we have merged 532980cb1bf ("inode: port __I_SYNC to var
event") which could have odd consequences if we made mistake somewhere...
It probably won't be easy to revert but you could try whether the problem
reproduces before / after this commit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

