Return-Path: <linux-fsdevel+bounces-17514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C903E8AE8AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B02C284805
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80E8136E00;
	Tue, 23 Apr 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rYatyu05";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kf/COY7l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3J4H+zWP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mIJh+WXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AEB135A5B;
	Tue, 23 Apr 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880351; cv=none; b=t6iIl307C+jmBOtLgBucIlT3cbMudJ50GBtCblFS5vLsZ6OekfDjRQSmcHBp47tSBptZPSP1t/TvYNbGv233ZvzehKK7s5CvguDsr1FqXIH4++UHyKDeR9ZokxTa6ImSuyAUzV44ZE947Y96zlE2jWzN0/lsHeuYVtvSVt+V5dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880351; c=relaxed/simple;
	bh=S7sUaoldK+ni+3c1FI6B0LC7MkbWSx7hrgafCzLBQh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1UJtZvvsmE1BSPocTDzg5/ZLtJybi9l5awT5SVldhlHQRPlfW1eWXHvEnKSuK21WpkDoVk3EsDe5/HjMbO7YFJM+cHBvcJ9ipT3Hd3Y3Uq5Kgviwi0EdmR1Iw/Nx0HxXguPZhz/XEZcWuN9lkKKH0YvWAP6/TQcB6jPsN33ZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rYatyu05; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kf/COY7l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3J4H+zWP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mIJh+WXZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9A0F5FFDE;
	Tue, 23 Apr 2024 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713880348;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7sUaoldK+ni+3c1FI6B0LC7MkbWSx7hrgafCzLBQh4=;
	b=rYatyu05UZ5WqfVfLxuNOAWMy4W+PCssPHr/5n3oIhVfFL64DgPd0Ay5HoUsqmLklmASk0
	8OoIuI8PnoWMfndsKm+RSUwVdQepQ49bCZ8MsoVBChreIEihIkL+k7BkuVrC0WLyJcDv/2
	PYh1rQcPsG4G/8bH57kDhgo00wpDexw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713880348;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7sUaoldK+ni+3c1FI6B0LC7MkbWSx7hrgafCzLBQh4=;
	b=kf/COY7lXjOGh1SP1uOSoH0J1Gjot3A704KY9ffiUAs2Q9LT1OtQP/LLG8z1DQ/KUbcggf
	k+kB89sdmk6QyhBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3J4H+zWP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mIJh+WXZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713880346;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7sUaoldK+ni+3c1FI6B0LC7MkbWSx7hrgafCzLBQh4=;
	b=3J4H+zWPsS0SxnmdTAdUwVpRt8QPEJyJ3CMqNJgNI9RTJl+zewqgIwzP0gHnvwZ/Ber77Q
	DjASXm6+Bth5b2VEPuO60a++OL/FD0xz5gMhozkpx3TvLat9EZZ8GZUzaei6kCoXPaeQbc
	LeWLXi8D2X69TJy6tz6Rwhn3J4zHpsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713880346;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7sUaoldK+ni+3c1FI6B0LC7MkbWSx7hrgafCzLBQh4=;
	b=mIJh+WXZjqUkXb04mduTycZiYg5xS5Z83Im/3aErIrKZzpAtF4UHO+ifGdWuor8OvXfQGn
	sDHMfHO6sAdNH/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BF7013929;
	Tue, 23 Apr 2024 13:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1BinHRq9J2aecAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 23 Apr 2024 13:52:26 +0000
Date: Tue, 23 Apr 2024 15:52:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Cyril Hrubis <chrubis@suse.cz>, lkp@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	ltp@lists.linux.it, linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [LTP] [linus:master] [pidfd]  cb12fd8e0d: ltp.readahead01.fail
Message-ID: <20240423135225.GA195737@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <202403151507.5540b773-oliver.sang@intel.com>
 <20240315-neufahrzeuge-kennt-317f2a903605@brauner>
 <ZfRf36u7CH7bIEZ7@yuki>
 <20240318-fegen-bezaubern-57b0a9c6f78b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-fegen-bezaubern-57b0a9c6f78b@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.68 / 50.00];
	BAYES_HAM(-2.97)[99.85%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_EQ_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B9A0F5FFDE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.68

Hi,

> On Fri, Mar 15, 2024 at 03:49:03PM +0100, Cyril Hrubis wrote:
> > Hi!
> > > So I'd just remove that test. It's meaningless for pseudo fses.

> > Wouldn't it make more sense to actually return EINVAL instead of
> > ignoring the request if readahead() is not implemented?

> It would change the return value for a whole bunch of stuff. I'm not
> sure that wouldn't cause regressions but is in any case a question for
> the readahead maintainers. For now I'd just remove that test for pidfds
> imho.

@Matthew, any input on Cyril's question please?

Kind regards,
Petr

