Return-Path: <linux-fsdevel+bounces-15024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FCD8860DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 20:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B791C21F9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABA6134404;
	Thu, 21 Mar 2024 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p9nSo6+x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HaNgX+nD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R99i+GAf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nP/x2L21"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13855CB5;
	Thu, 21 Mar 2024 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711047930; cv=none; b=ZjhhNvLJ8gPzqENhGXy5unOqBnJSDIGw6MdLHX2oMEBM6th/j9Vp96IpUg9BOF4zGjpxokuI68Wp9S2yf1B5Y8PnTSo6NKmzO3Sybc2cQcfz0Uze0V5RfaB+Of33a5sDH/aRawGTZ0QUGyWgffH4xymqSj2EsHvLKSerpdWft68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711047930; c=relaxed/simple;
	bh=iYSjuUOJa8DuLLmQDiLEHkhY5sqpF85A5G6lrPzxVIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlVDVlV7SxDoaidBCVkH7r1Y4JrA/pIJdxRnjyjT4kcE6LT8XtueQfE/kzlWXbIy3w6sWSiWz2aeQf0MxTHxJ8VjDbAoNtJQs2OQw9b8xvvQZG7r0RxQY0vZkCqobweSwGMONJRwYDBvjOPC21z5CsfTbGZo9uwm0uN3QT/gAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p9nSo6+x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HaNgX+nD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R99i+GAf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nP/x2L21; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C07711FE5E;
	Thu, 21 Mar 2024 19:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711047923;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ5nPVWJ8277+FaZetcWdUm2C7FpD6mS7J+tmecF20w=;
	b=p9nSo6+xKc7PB0tWfcTs9Cu59gcpu1hSj3JdKfJnP87c9axKoY0sNq/ShBDH3l+jYRVIR8
	3OIaVqY8/Rk8Sxo0ET2F71jEEOw5aRKF+SHrede3m9733eWiYV5m/j/ASWTHP+/PnnJkMT
	hXlcnNXmJRU7/syMePra6kgHa0P/Y4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711047923;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ5nPVWJ8277+FaZetcWdUm2C7FpD6mS7J+tmecF20w=;
	b=HaNgX+nD7nLjaAknAWqKzKa03R/U+5vamob+SpX5eSl2hXbk/Nq7APQ78OMzxjZorEbb6U
	R+2PcyOQCmGWxnDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711047922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ5nPVWJ8277+FaZetcWdUm2C7FpD6mS7J+tmecF20w=;
	b=R99i+GAfUcCxUU20+/j6JSVw2BavIydp1z0FgrXb6wLj6TmgBHxgTmgtRAAPiGTbeGi7E/
	ztO/fN7hYDTWf/4GWW5d8dijoF58yn2w7tdJisLaBEX/gOJ8t2nBSMWWV6GzCo4vyIpcMA
	3NdxHK/+3EKccMwtvmOeccY+tIblNHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711047922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQ5nPVWJ8277+FaZetcWdUm2C7FpD6mS7J+tmecF20w=;
	b=nP/x2L21n2C7JW+Oql9EWah1M4WRSJksb1TeUEtZS5ggHZuX1RrUar08atWoFbyYGdkJMM
	+8PjzzHpA9cfTNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E88F136AD;
	Thu, 21 Mar 2024 19:05:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T9GEJvKE/GXHSwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 21 Mar 2024 19:05:22 +0000
Date: Thu, 21 Mar 2024 19:58:03 +0100
From: David Sterba <dsterba@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, corbet@lwn.net,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, clm@meta.com, dsterba@suse.com,
	josef@toxicpanda.com, jbacik@toxicpanda.com, kernel-team@meta.com
Subject: Re: [PATCH 0/3] fiemap extension to add physical extent length
Message-ID: <20240321185803.GH14596@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1709918025.git.sweettea-kernel@dorminy.me>
 <20240315030334.GQ6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315030334.GQ6184@frogsfrogsfrogs>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R99i+GAf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="nP/x2L21"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[30.49%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: C07711FE5E
X-Spam-Flag: NO

On Thu, Mar 14, 2024 at 08:03:34PM -0700, Darrick J. Wong wrote:
> On Fri, Mar 08, 2024 at 01:03:17PM -0500, Sweet Tea Dorminy wrote:
> > For many years, various btrfs users have written programs to discover
> > the actual disk space used by files, using root-only interfaces.
> > However, this information is a great fit for fiemap: it is inherently
> > tied to extent information, all filesystems can use it, and the
> > capabilities required for FIEMAP make sense for this additional
> > information also.
> > 
> > Hence, this patchset adds physical extent length information to fiemap,
> > and extends btrfs to return it.  This uses some of the reserved padding
> > in the fiemap extent structure, so programs unaware of the new field
> > will be unaffected by its presence.
> > 
> > This is based on next-20240307. I've tested the btrfs part of this with
> > the standard btrfs testing matrix locally, and verified that the physical extent
> > information returned there is correct, but I'm still waiting on more
> > tests. Please let me know what you think of the general idea!
> 
> Seems useful!  Any chance you'd be willing to pick up this old proposal
> to report the dev_t through iomap?  iirc the iomap wrappers for fiemap
> can export that pretty easily.
> 
> https://lore.kernel.org/linux-fsdevel/20190211094306.fjr6gfehcstm7eqq@hades.usersys.redhat.com/

I think this is not too useful for btrfs (in general) due to the block
group profiles that store copies on multiple devices, we'd need more
than one device identifier per extent.

