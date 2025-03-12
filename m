Return-Path: <linux-fsdevel+bounces-43794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261BCA5DAFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 11:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A23717290D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9401323E349;
	Wed, 12 Mar 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3X9HiRBl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iJ+d0lOa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3X9HiRBl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iJ+d0lOa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84123DE80
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741777097; cv=none; b=fokEwfanFNl4qgqVYrBAlHwtDfDqPKyWqmmXXXmavTC0l2kIm0tJmf4c51EFRe5sToiEGqXA+/sdHzmqZV67ew4lorM2GLwFZ9wDsWgYQZSqPntVmfGnjtSc8uiAOXLMCFCfgVXaTrlNRK3IFerc/A7VqjvPpNCFa3GQ7lUZmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741777097; c=relaxed/simple;
	bh=mXV5OYfAFUQilviwt+OsHOkLq5LO7nYJj/htmMMPRos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDoUFVjB3Aixwhw0cZKH5PexchzPtRFY8W1Ev1fDyvWs5AZEhNo9doIHe6Qxk2Rs+HlRe8yO0xpHz3v0U72fvO8l46O1K7IVciIYKL2zenn5pdI2NA8PR927tJeUyaeRz72GdIDKFjSKsZz2idkHQq7Lvbj1FukXGn4mFk5vBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3X9HiRBl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iJ+d0lOa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3X9HiRBl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iJ+d0lOa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FD2F1F388;
	Wed, 12 Mar 2025 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741777092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+umskFxp6WnyrlSTt3Hx9vE8lHgvRaR9WZhhrughL4=;
	b=3X9HiRBlwpqcm/I5dDdyFbDKcHB/DGQL4m7L42vzESgDOwOwLuvVqqZSd23N0cLb4PTaVc
	24Ats9RK6o8dZPHZ8BTPIzR3go6Pw+tI+mFAMCNnGxh/+qJIAjGBdvJEzlXsWSau01vd2f
	AmutiHnYhJs2UoytghfWMDOFhmGT8uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741777092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+umskFxp6WnyrlSTt3Hx9vE8lHgvRaR9WZhhrughL4=;
	b=iJ+d0lOarwEkd2m+k/ix6vix9tIrSroThco19lAvqVyTDBiI+M95favbBMQPJ9bZUoKDVe
	bA8voWp1e9TChDDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3X9HiRBl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iJ+d0lOa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741777092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+umskFxp6WnyrlSTt3Hx9vE8lHgvRaR9WZhhrughL4=;
	b=3X9HiRBlwpqcm/I5dDdyFbDKcHB/DGQL4m7L42vzESgDOwOwLuvVqqZSd23N0cLb4PTaVc
	24Ats9RK6o8dZPHZ8BTPIzR3go6Pw+tI+mFAMCNnGxh/+qJIAjGBdvJEzlXsWSau01vd2f
	AmutiHnYhJs2UoytghfWMDOFhmGT8uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741777092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+umskFxp6WnyrlSTt3Hx9vE8lHgvRaR9WZhhrughL4=;
	b=iJ+d0lOarwEkd2m+k/ix6vix9tIrSroThco19lAvqVyTDBiI+M95favbBMQPJ9bZUoKDVe
	bA8voWp1e9TChDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79097132CB;
	Wed, 12 Mar 2025 10:58:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QAuHHcRo0WdsMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Mar 2025 10:58:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 30A48A08CF; Wed, 12 Mar 2025 11:58:12 +0100 (CET)
Date: Wed, 12 Mar 2025 11:58:12 +0100
From: Jan Kara <jack@suse.cz>
To: Tingmao Wang <m@maowtm.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Tycho Andersen <tycho@tycho.pizza>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Song Liu <song@kernel.org>
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
Message-ID: <zofgalxomiykhani3etqcynxm3lfr7632ott5oow2oqafb2cwp@h3vswipvzajm>
References: <cover.1741047969.git.m@maowtm.org>
 <20250304.Choo7foe2eoj@digikod.net>
 <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org>
 <CAOQ4uxjz4tGmW3DH3ecBvXEnacQexgM86giXKqoHFGzwzT33bA@mail.gmail.com>
 <1e009b28-1e6b-4b8c-9934-b768cde63c2b@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e009b28-1e6b-4b8c-9934-b768cde63c2b@maowtm.org>
X-Rspamd-Queue-Id: 8FD2F1F388
X-Spam-Level: 
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,digikod.net,google.com,suse.cz,vger.kernel.org,tycho.pizza,kernel.org,huawei-partners.com,linux.microsoft.com,buffet.re];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 11-03-25 00:42:05, Tingmao Wang wrote:
> On 3/6/25 17:07, Amir Goldstein wrote:
> [...]
> > 
> > w.r.t sharing infrastructure with fanotify, I only looked briefly at
> > your patches
> > and I have only a vague familiarity with landlock, so I cannot yet form an
> > opinion whether this is a good idea, but I wanted to give you a few more
> > data points about fanotify that seem relevant.
> > 
> > 1. There is already some intersection of fanotify and audit lsm via the
> > fanotify_response_info_audit_rule extension for permission
> > events, so it's kind of a precedent of using fanotify to aid an lsm
> > 
> > 2. See this fan_pre_modify-wip branch [1] and specifically commit
> >    "fanotify: introduce directory entry pre-modify permission events"
> > I do have an intention to add create/delete/rename permission events.
> > Note that the new fsnotify hooks are added in to do_ vfs helpers, not very
> > far from the security_path_ lsm hooks, but not exactly in the same place
> > because we want to fsnotify hooks to be before taking vfs locks, to allow
> > listener to write to filesystem from event context.
> > There are different semantics than just ALLOW/DENY that you need,
> > therefore, only if we move the security_path_ hooks outside the
> > vfs locks, our use cases could use the same hooks
> 
> Hi Amir,
> 
> (this is a slightly long message - feel free to respond at your convenience,
> thank you in advance!)
> 
> Thanks a lot for mentioning this branch, and for the explanation! I've had a
> look and realized that the changes you have there will be very useful for
> this patch, and in fact, I've already tried a worse attempt of this (not
> included in this patch series yet) to create some security_pathname_ hooks
> that takes the parent struct path + last name as char*, that will be called
> before locking the parent.  (We can't have an unprivileged supervisor cause
> a directory to be locked indefinitely, which will also block users outside
> of the landlock domain)

Well, but if you call the hook before locking the parent isn't your hook
prone to TOCTOU races? I mean you call the hook do your stuff in it and
then before the parent is locked, the whole directory hierarchy can get
reorganized (from another process) without you knowing... So I'm not sure
which guarantees you can provide for such hooks.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

