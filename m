Return-Path: <linux-fsdevel+bounces-16124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE720898B98
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 17:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF151F291CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D957512A16E;
	Thu,  4 Apr 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iBhBXtKo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oh2tPuYD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iBhBXtKo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oh2tPuYD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC73E224DE
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246023; cv=none; b=BZ1cK4k3OgSB6DOOaG87Taws0sTWRVYHSJzq7+3k6tbzgd+Q6JJpA9E/6BxV+tvyr1DnfLbH1+GOQ5OBfDQ1IOcfqpd5gWKc8LXT7C9vu646xo2OvrM4F96TNe0BG4MA5+/uhMCm/a3JdSdQXM5K1vX/m25v8GO3YOoCqBLz9yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246023; c=relaxed/simple;
	bh=rqMwYj5aZ2+h/0pV7D2ofJsNSPXbS/cEGyA7xxpFq7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdboET9UcfttOcVdE4mT4L4Z7iIHy7n2eAvaBs16DKSinc5gm2ks8bDJVF0vQOlDFuLJxNLrELHfLd67Kfq89IHyQVQn0pe2z0IpQ6uBPLgy7erc8BN/9oMYco0aaTF5mF+U0llu/EOIH2c8LAckoar6yvirKNEDNJIN913TTS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iBhBXtKo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oh2tPuYD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iBhBXtKo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oh2tPuYD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2FC537C11;
	Thu,  4 Apr 2024 15:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712246019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+kXKcELDyFTqgvbgBij86EfwfKoODFi5aovbryeGxs=;
	b=iBhBXtKobmNWwWQ7bwRe1jKtw883hFO9tg1OlQVvugM/MTonKdDTyefwi2U99WLh9Yyb3c
	KI2jL3bXSuEBbd46d5zZs+jY/u+2troo7gOhJtQTxvZpJYJo8T7cMBqTKWahuAd3gwZqwB
	tZ9kEJ0WbZH+sJYlM2mORpfs6QJ+8po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712246019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+kXKcELDyFTqgvbgBij86EfwfKoODFi5aovbryeGxs=;
	b=oh2tPuYDpCSkKGIEOgXC7ho/NnWpIk9cHKzl91G7CCyYCdliLvMVllWEKdO6GTQ9Ab25rM
	IMShc0eKZXS2qlBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iBhBXtKo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oh2tPuYD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712246019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+kXKcELDyFTqgvbgBij86EfwfKoODFi5aovbryeGxs=;
	b=iBhBXtKobmNWwWQ7bwRe1jKtw883hFO9tg1OlQVvugM/MTonKdDTyefwi2U99WLh9Yyb3c
	KI2jL3bXSuEBbd46d5zZs+jY/u+2troo7gOhJtQTxvZpJYJo8T7cMBqTKWahuAd3gwZqwB
	tZ9kEJ0WbZH+sJYlM2mORpfs6QJ+8po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712246019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+kXKcELDyFTqgvbgBij86EfwfKoODFi5aovbryeGxs=;
	b=oh2tPuYDpCSkKGIEOgXC7ho/NnWpIk9cHKzl91G7CCyYCdliLvMVllWEKdO6GTQ9Ab25rM
	IMShc0eKZXS2qlBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 90BA813298;
	Thu,  4 Apr 2024 15:53:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NiuuIgPNDmarJAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 04 Apr 2024 15:53:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 18408A0814; Thu,  4 Apr 2024 17:53:35 +0200 (CEST)
Date: Thu, 4 Apr 2024 17:53:35 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 00/10] Further reduce overhead of fsnotify permission
 hooks
Message-ID: <20240404155335.4n6jcucb7s6icatc@quack3>
References: <20240317184154.1200192-1-amir73il@gmail.com>
 <CAOQ4uxgssYK=vL3=0af6gh+AgSPx__UR2cU6gAu_1a3nVdYKLA@mail.gmail.com>
 <20240404143443.zfurlpe27m4mysrs@quack3>
 <CAOQ4uxiV1Y5ufSVqH4T0xbjwtxLA0ijM=kf9xQMSGZXBjTLFCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiV1Y5ufSVqH4T0xbjwtxLA0ijM=kf9xQMSGZXBjTLFCg@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A2FC537C11
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email]

On Thu 04-04-24 17:41:18, Amir Goldstein wrote:
> On Thu, Apr 4, 2024 at 5:34 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 19-03-24 11:59:11, Amir Goldstein wrote:
> > > On Sun, Mar 17, 2024 at 8:42 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > Jan,
> > > >
> > > > Commit 082fd1ea1f98 ("fsnotify: optimize the case of no parent watcher")
> > > > has reduced the CPU overhead of fsnotify hooks, but we can further
> > > > reduce the overhead of permission event hooks, by avoiding the call to
> > > > fsnotify() and fsnotify_parent() altogether when there are no permission
> > > > event watchers on the sb.
> > > >
> > > > The main motivation for this work was to avoid the overhead that was
> > > > reported by kernel test robot on the patch that adds the upcoming
> > > > per-content event hooks (i.e. FS_PRE_ACCESS/FS_PRE_MODIFY).
> > > >
> > > > Kernel test robot has confirmed that with this series, the addition of
> > > > pre-conent fsnotify hooks does not result in any regression [1].
> > > > Kernet test robot has also reported performance improvements in some
> > > > workloads compared to upstream on an earlier version of this series, but
> > > > still waiting for the final results.
> > >
> > > FYI, the results are back [1] and they show clear improvement in two
> > > workloads by this patch set as expected when the permission hooks
> > > are practically being disabled:
> >
> > Patches are now merged into my tree.
> 
> Yay!
> If possible, please also push fsnotify branch.

Done.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

