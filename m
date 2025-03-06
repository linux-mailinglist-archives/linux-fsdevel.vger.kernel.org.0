Return-Path: <linux-fsdevel+bounces-43384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6131DA55846
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 22:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932EF188F2B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0899127C17A;
	Thu,  6 Mar 2025 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YltvuVnM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3mhVIk2G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oBMmmfZ2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vC01rrix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30ED276D3A
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295099; cv=none; b=OIERAsvbXG9BsDneMZdOH3r3zPgSYcCTXNrR5Jg4AalFIBYp9QyPbVi7n1HDOvgjUvJ3fSnAPv0LQuV+hK9VjjmkDnu2ocwQHH6ml2+2SSJ0asOlRrcipLI/Gktpu8VYIE1qc5So1GOSVq+rF6SvwwUO8CtOjkfIvqK0QOfFung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295099; c=relaxed/simple;
	bh=Nj2QFBrpHz0Lh47urVE+cW9CIyWI1Nb2IUjO2CbnzX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3FOMCOaBMlO8ufzqhr8ymfwuy0kqsMtJTzzs3VOzry8/qH2DKuS210rcm45Esl7jfmOJ86dyASnaH9h0E8xUlT9cwA/kEoddh51N4XBh6QkGJBlm27H789vTiuIG/pDW8pgMHLRsX14SR5pOI62pYoMCLBtqkvsT3yq2D9kz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YltvuVnM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3mhVIk2G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oBMmmfZ2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vC01rrix; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0FEE211BA;
	Thu,  6 Mar 2025 21:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741295095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEfD/S78jblpj8bnba4wTWc+TRyowQZzkbMJH3ro3ZI=;
	b=YltvuVnMyv6clPiw2LKyB1vqb4NRm/buyOHJ+M0ehSsSsNnMAkFGHre1Wf5nZ82b+VT+a9
	+k2jVRsKtBfqzUHkLg+Gx4qO3JdA5u/e930w4otjJbEp98EFbVlN9impx2aqz/hktBh/9U
	WCGAMNEXx7qQljbwCtSKRAwSilIFBgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741295095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEfD/S78jblpj8bnba4wTWc+TRyowQZzkbMJH3ro3ZI=;
	b=3mhVIk2GiPU7Wpn9hRDbvyBCa72VApjPO6KGAnGGTh2/0on9dNXFH5HAwfEOowLJJM0yI5
	PnzGUXylwinDgXDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oBMmmfZ2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vC01rrix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741295094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEfD/S78jblpj8bnba4wTWc+TRyowQZzkbMJH3ro3ZI=;
	b=oBMmmfZ2BDwQtTsVdUdHw69utxB5tbGygBj9ZjmpWzAk7ayDzEX/trzJed5gMBJ7SZYGP1
	R0yjo07cdyrG/6RPL8qARDeK6Bw2AJZmQutlyUbvWlXjxufKK+z4J2Dnt/mIogwFMiddVe
	mNuc/pkzhso0Oji4Z9GPGi+dENyV1o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741295094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEfD/S78jblpj8bnba4wTWc+TRyowQZzkbMJH3ro3ZI=;
	b=vC01rrixjeoZjLKo30QbgWoYk7ksOvCdYW+k0SjkEVEIKqQGVjsYxpmZq9y1ZHDTPQoPmv
	yGoijhO99hIHUgBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9429E13676;
	Thu,  6 Mar 2025 21:04:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WAyoI/YNymfceAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Mar 2025 21:04:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4461FA087F; Thu,  6 Mar 2025 22:04:54 +0100 (CET)
Date: Thu, 6 Mar 2025 22:04:54 +0100
From: Jan Kara <jack@suse.cz>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
Message-ID: <7hpktxh4s6pho2cgoi6x7ptzimqrgflgbztrmtnamstpuefooj@orahctcwxqxm>
References: <cover.1741047969.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741047969.git.m@maowtm.org>
X-Rspamd-Queue-Id: A0FEE211BA
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[digikod.net,google.com,suse.cz,vger.kernel.org,gmail.com,tycho.pizza];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 04-03-25 01:12:56, Tingmao Wang wrote:
> Alternatives
> ------------
> 
> I have looked for existing ways to implement the proposed use cases (at
> least for FS access), and three main approaches stand out to me:
> 
> 1. Fanotify: there is already FAM_OPEN_PERM which waits for an allow/deny
> response from a fanotify listener.  However, it does not currently have
> the equivalent _PERM for file creation, deletion, rename and linking, and
> it is also not designed for unprivileged, process-scoped use (unlike
> landlock).

As Amir wrote, arbitration of creation / deletion / ... is not a principial
problem for fanotify and we plan to go in that direction anyway for HSM
usecase. However adjusting fanotify permission events for a per-process
scope and for unpriviledged users is a fundamental difference to how
fanotify is designed to work (it watches filesystem objects, not processes
and actions they do) and so I don't think that would be a great fit. Also I
don't see fanotify expanding in the networking area as the concepts are
rather different there :).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

