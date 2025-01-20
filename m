Return-Path: <linux-fsdevel+bounces-39701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2BAA1711B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE627A26F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019C51547E7;
	Mon, 20 Jan 2025 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cfHj75mG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UdQ6TOZy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cfHj75mG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UdQ6TOZy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0E364D6;
	Mon, 20 Jan 2025 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393321; cv=none; b=etCdBFyH5/Ct/R2QzdQMJythsAt4IAEIvFVdnSWsfpPCy1xJFrv+hEMLwsnU41tFhHsJTHniDyUGUZrmtCxOr0ShhkqxvVb7txSKNAl2VGcBwGNWKZeJRD7vp2FTEUb+A0ZQFI2Qhr/CeAoTrk/MEG7lYNF0loev5UeYwg30Mag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393321; c=relaxed/simple;
	bh=fbC1PFvhqubQfC5Hnm7i9eoVkKrHBdiVHYIEyTCwvUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5mfe+oRh2BO1uc0+B45ED5g7S+5vdOJ5lfXaTyrsE4qx+kdQg3+op+PH1ZHaNP8WzlXq3pLxnhcwEWhrIQLAlglHRvphi563WuiXWLl4As3kPMrtjNBJ2lFsj4WcybMPmA3iZHKSz7vBu/PFJaq8Up9NFv2m6sRUbAjF+wnf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cfHj75mG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UdQ6TOZy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cfHj75mG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UdQ6TOZy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 531C61F7BE;
	Mon, 20 Jan 2025 17:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737393317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qpOvctJ7XHAbcoxhTgY+9cD7w5RAqJtPknriZ4mVY0=;
	b=cfHj75mGUeM3/xcgL4F2Y5KSHJ0ifBnrqyFD5COOy7bc1q164z8qSBU4YrXlbWDJtavzcG
	ZcNmlZV+UTTFPesOOmIMJlthYKub4FZqjgaNsnKt5DMKpUDbxfRrgGcl2E5Yo8TLZ0Uw58
	Wg3qq+09ZRbm8Sa4ve+Niit/IQuZEcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737393317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qpOvctJ7XHAbcoxhTgY+9cD7w5RAqJtPknriZ4mVY0=;
	b=UdQ6TOZyO/PZ7sztAZWutPSo+Co52ihcXRec1CQ6g0h7/3NmYeCf0Zb7suAYQeBCaYQlgg
	sxXY3CS8bFcsxFCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737393317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qpOvctJ7XHAbcoxhTgY+9cD7w5RAqJtPknriZ4mVY0=;
	b=cfHj75mGUeM3/xcgL4F2Y5KSHJ0ifBnrqyFD5COOy7bc1q164z8qSBU4YrXlbWDJtavzcG
	ZcNmlZV+UTTFPesOOmIMJlthYKub4FZqjgaNsnKt5DMKpUDbxfRrgGcl2E5Yo8TLZ0Uw58
	Wg3qq+09ZRbm8Sa4ve+Niit/IQuZEcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737393317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qpOvctJ7XHAbcoxhTgY+9cD7w5RAqJtPknriZ4mVY0=;
	b=UdQ6TOZyO/PZ7sztAZWutPSo+Co52ihcXRec1CQ6g0h7/3NmYeCf0Zb7suAYQeBCaYQlgg
	sxXY3CS8bFcsxFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4886A1393E;
	Mon, 20 Jan 2025 17:15:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hY+vEaWEjme1CgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Jan 2025 17:15:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CB04BA081E; Mon, 20 Jan 2025 18:15:16 +0100 (CET)
Date: Mon, 20 Jan 2025 18:15:16 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
	lsf-pc@lists.linux-foundation.org, 
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] time to reconsider tracepoints in
 the vfs?
Message-ID: <ok7tgrzlxxsgrv5sa7tpx6mnj2fl2phonplzdd3vlt24dyxira@hn6fkk6fosu4>
References: <20250116124949.GA2446417@mit.edu>
 <t46oippyv2ngyndiprssjxnw3s76gd47qt2djruonbaxjypwjn@epxwtyrqjdya>
 <20250120-heilkraft-unzufrieden-a342c84a4174@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120-heilkraft-unzufrieden-a342c84a4174@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On Mon 20-01-25 16:43:31, Christian Brauner wrote:
> > that it's not a big deal.  I'm watching with a bit of concern developments
> > like BTF which try to provide some illusion of stability where there isn't
> > much of it. So some tool could spread wide enough without getting regularly
> > broken that breaking it will become a problem. But that is not really the
> > topic of this discussion.
> 
> We've stated over and over and will document that we give no stability
> guarantees in that regard.

I'm fully in support of stating that and documenting that because setting
the expectation is important. And I'm also in support of adding tracepoints
to VFS. As Ted wrote, so far both kernel and userspace parts of tracing
were able live along together smoothly (at least from the kernel side ;)).
But I've also heard Linus explicitely saying something along the lines that
if a change in a trace point breaks real users, he's going to revert that
change no matter what you've documented. So we have to take that
possibility into account as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

