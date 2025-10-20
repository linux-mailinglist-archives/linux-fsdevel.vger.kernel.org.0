Return-Path: <linux-fsdevel+bounces-64722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D075BF26C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 18:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3161A18A78EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAE52882B2;
	Mon, 20 Oct 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lCKZQBdy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D30v6reH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2KMAP8rV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uMPT+Cfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486162882A9
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977669; cv=none; b=sSTCuyplTVlX8yDYN4QBuQf5T2+HchFLGWiHxj+hAEIQiA7WnRLoyPmW1AqKmayl0/i5E+p/IaiJU3e0WY5/F0jc3C0cqY/QeAuWvNGZ/x96YgdPfqSfhDAIDsNOtUFqosOl3f79MlPfo+j0QGWupTfG3Gk3dWTG3cW0Qb+t/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977669; c=relaxed/simple;
	bh=jEqUlTFEgQwjQGz9HVdsJPNRqOaKd3QO8l+ZwhUYrsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIEvAkaAPn2XSKjhmj0h/D805kgFwmJfa5H+3BJGKBySvR0QghqieAPm/eO1DxqfRn8mDRSXzAh+JPOTkQEeVG6LYQB+SfXrdkwC+EdTbgCNuAH95vLV1AegWaAQE3fmmpBAc8oYatUoHUA3RkH7/tn5ZvIySq6nHqkBn5JzJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lCKZQBdy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D30v6reH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2KMAP8rV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uMPT+Cfh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 127A91F397;
	Mon, 20 Oct 2025 16:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760977662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEEVfXbE5iBbrwruX82igScznCGOkYQiTk1hRD8kbII=;
	b=lCKZQBdy1z6QlSTYVcirOQpdDLCy3ABLdPJbq6wYrDy6Xlw6sQ806NXPATJp3KLRgld0An
	RYnGCH144jdAtjFwOnPRJQzpGw5p4M9UjITqvFKekdn4uUnTYxyDGhYx0JHnhYQHMn81r5
	IfBaPUI5Rl8UhkoBMg3yrBam+VzJYj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760977662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEEVfXbE5iBbrwruX82igScznCGOkYQiTk1hRD8kbII=;
	b=D30v6reH4pJDdqs9a5cHr02C/KHlJ3qPSN85A8x+klJ9XGv5Xu+feji2GaECxVHKj9Qv2m
	dgyBTi2eOJxzwWDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2KMAP8rV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uMPT+Cfh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760977658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEEVfXbE5iBbrwruX82igScznCGOkYQiTk1hRD8kbII=;
	b=2KMAP8rVcsJlU6slaurMoGNvm/w/bOQKh+jHhQzbvIa0aXMkt/s1YACOTxM3aWweNIhmKX
	6W03hFeVCdPSkX9i1j5BspWwGw7o2zz2/3/hMlGOJmhCdqD4IqSTC+dtcmT3rkiFy4exXC
	NMnW5HdKfWNJTEgU+CsI45oUW7Rhz8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760977658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEEVfXbE5iBbrwruX82igScznCGOkYQiTk1hRD8kbII=;
	b=uMPT+CfhM8QLtEbOmZnxvabhJXrBrIqg6QzGC+l07N26tBpFpI2HtWow3V9Xxck1bixRqd
	/QswlcQcOAgruTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0579E13A8E;
	Mon, 20 Oct 2025 16:27:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7btTAfpi9mheFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 16:27:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8A034A088E; Mon, 20 Oct 2025 18:27:37 +0200 (CEST)
Date: Mon, 20 Oct 2025 18:27:37 +0200
From: Jan Kara <jack@suse.cz>
To: abdulrahmannader.123@gmail.com
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz
Subject: Re: RFC: Request for guidance on VFS statistics consolidation
Message-ID: <k7lrs2stjgaa27pzbpvucpatnpxo6szdrkurtbdip6ekorkpka@kv637duwd56s>
References: <20251020155228.54769-1-abdulrahmannader.123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020155228.54769-1-abdulrahmannader.123@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 127A91F397
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -2.51

Hello!

On Mon 20-10-25 18:52:28, abdulrahmannader.123@gmail.com wrote:
> I'm a new contributor learning kernel development, and I would like
> some guidance before proceeding further.
> 
> Background
> ==========
> 
> I've been exploring VFS statistics collection. While doing so, I noticed
> that VFS statistics are currently exposed via several separate interfaces:
> 
>   - /proc/sys/fs/dentry-state
>   - /proc/sys/fs/inode-state
>   - /proc/sys/fs/inode-nr
>   - /proc/sys/fs/file-nr
>   - /proc/sys/fs/file-max

Correct.

> My Questions
> ============
> 
> Before investing more time in implementation, I wanted to understand
> the rationale behind the current design and get some feedback:
> 
> 1. Is the current multi-file approach intentional?
>    Are there specific benefits to keeping these statistics separate
>    that I might not be aware of?

Yes, it is pretty much intentional. Generally the file format can be
simpler and is easier to extend in a backward compatible way by adding more
entries when we have one sys file per object type. Also at this point we
cannot ever get rid of the current sys files because a lot of userspace
depends on them. So at this point the main benefit is probably that
everybody is used to the way things are currently done :)

> 2. Would a consolidated interface be useful?
>    Would there be interest in a single file that aggregates common VFS
>    metrics, or is the current approach preferred?

Well, it's your job to justify why a new aggregated interface would be
useful. I personally don't see a benefit, just added maintenance cost.

> 3. What's the recommended way to extend VFS observability?
>    If there are gaps in the current monitoring capabilities, which of
>    the following approaches is preferred:
>      - Extend existing interfaces?
>      - Add new specialized interfaces?
>      - Enhance debugfs entries?
>      - Something else?

I think the most important is to find some practical problem users are
facing and then try to solve it. Just extending interfaces for the sake of
more generality isn't going to go too far. Each added interface bears a
noticeable maintenance cost so there has to be appropriate benefit
justifying that cost.

> 4. Are there any existing efforts to improve this area?
>    I want to avoid duplicating work that might already be in progress.

I'm not aware of anything.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

