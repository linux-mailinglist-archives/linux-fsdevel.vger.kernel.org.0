Return-Path: <linux-fsdevel+bounces-39397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA37DA13956
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 12:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC921689B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 11:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A821DE3A5;
	Thu, 16 Jan 2025 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xiqg4eDd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YbWpakcO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wH/HICaz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="roD2IuhR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8F524A7F8;
	Thu, 16 Jan 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028014; cv=none; b=ZngJBGLHKeibnuurypDgyO8YDzldkH4/AU+RNYwsq173o17atgFTIkt2XkG8YOwY4ZPkduX4t0JDKhy/yt1XyotCbW3Tg3Esfforx1nRaW6pLDrXH8jRYww7kt0/rKTsPpKgt9PWBuKWx+nOZajpL6WBUUDls9DuBCVNdz9BlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028014; c=relaxed/simple;
	bh=dEHWPnhHge/K8LDMjsj16tdxkCK6s5APiBTjMYPTDps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX5zV6K4H0ULlylEUwM1B5b9cz1IO1a1YrpbD2TBHcwm2dBfGRC1oWXZdTuUjaZszx3hfRkAa0R/N9g9Bm/67BaQMFDRqf0n0j282n6/+DrbXNmHZ4+7XhT26oPPl/FunUdACFoUkINktX+7xwUqxS0R0e8HKwAxBLYNdk6WVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xiqg4eDd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YbWpakcO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wH/HICaz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=roD2IuhR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D124211D4;
	Thu, 16 Jan 2025 11:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737028010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogh113cq/WPGlb7UOtGm+MziHO1k8z8AfVc09O1E1hY=;
	b=xiqg4eDd6RNTnZsnOkSkE8blitm9HLu5IIZIdNcpmx8Y+Y9HVL+YrblpXOFokooZCNrUrx
	toyp4P0qlwMNrTWXHC84tGOmaXCzyjzj9k0yPVeXVayf2P6CUVQwvZwU3PZZQgQCOlNCU6
	/Jcnlji89MYwZicEETRx5Urk0HNmgek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737028010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogh113cq/WPGlb7UOtGm+MziHO1k8z8AfVc09O1E1hY=;
	b=YbWpakcO6J0KUQ7oFd+FBINEIS0MLTVou84MOlK1iH4DOXPJfwhm5uYTdlrfxidKUg8zsq
	/0RjruB5SpI+onBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737028009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogh113cq/WPGlb7UOtGm+MziHO1k8z8AfVc09O1E1hY=;
	b=wH/HICazrtMAW2YehRTivQT5mtYi0jWatZk8M7G3976254wMup7QhccDgXl5Rz4UQ27aKj
	G83kPGX9GWuH32a5aWlzgmEG0mhLP2LO/wzylvzspH5kHHjaBMAR4gAWsmPMss3LwM0EZx
	4yuT2dqGlD1TG7vZX7MxXKyt7fCbdqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737028009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogh113cq/WPGlb7UOtGm+MziHO1k8z8AfVc09O1E1hY=;
	b=roD2IuhR2yoa6CBiVMJMVy4/KkjM5hDP1dBofpWNHoy6XalAucoukvFD9/hKwmUFnD6+JC
	TuHQJGGVdzrypzAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90B4F13332;
	Thu, 16 Jan 2025 11:46:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5k5RI6nxiGf1BgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Jan 2025 11:46:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C610A08E0; Thu, 16 Jan 2025 12:46:49 +0100 (CET)
Date: Thu, 16 Jan 2025 12:46:49 +0100
From: Jan Kara <jack@suse.cz>
To: Song Liu <song@kernel.org>
Cc: Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] fanotify filter
Message-ID: <itmqbpdn3zpsuz3epmwq3lhjmxkzsmjyw4obizuxy63uo6rofz@pckf7rtngzm7>
References: <CAPhsuW4psFtCVqHe2wK4RO2boCbcyPtfsGzHzzNU_1D0gsVoaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4psFtCVqHe2wK4RO2boCbcyPtfsGzHzzNU_1D0gsVoaA@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi!

On Tue 14-01-25 11:41:06, Song Liu via Lsf-pc wrote:
> At LSF/MM/BPF 2025, I would like to continue the discussion on enabling
> in-kernel fanotify filter, with kernel modules or BPF programs.There are a
> few rounds of RFC/PATCH for this work:[1][2][3].
> 
> =============== Motivation =================
> 
> Currently, fanotify sends all events to user space, which is expensive. If the
> in-kernel filter can handle some events, it will be a clear win.
> 
> Tracing and LSM BPF programs are always global. For systems that use
> different rules on different files/directories, the complexity and overhead
> of these tracing/LSM programs may grow linearly with the number of
> rules. fanotify, on the other hand, only enters the actual handlers for
> matching fanotify marks. Therefore, fanotify-bpf has the potential to be a
> more scalable alternative to tracing/LSM BPF programs.
> 
> Monitoring of a sub-tree in the VFS has been a challenge for both fanotify
> [4] and BPF LSM [5]. One of the key motivations of this work is to provide a
> more efficient solution for sub-tree monitoring.
> 
> 
> =============== Challenge =================
> 
> The latest proposal for sub-tree monitoring is to have a per filesystem
> fanotify mark and use the filter function (in a kernel module or a BPF
> program) to filter events for the target sub-tree. This approach is not
> scalable for multiple rules within the same file system, and thus has
> little benefit over existing tracing/LSM BPF programs. A better approach
> would be use per directory fanotify marks. However, it is not yet clear
> how to manage these marks. A naive approach for this is to employ
> some directory walking mechanism to populate the marks to all sub
> directories in the sub-tree at the beginning; and then on mkdir, the
> child directory needs to inherit marks from the parent directory. I hope
> we can discuss the best solution for this in LSF/MM/BPF.

Obviously, I'm interested in this :). We'll see how many people are
interested in this topic but I'll be happy to discuss this also in some
break / over beer in a small circle.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

