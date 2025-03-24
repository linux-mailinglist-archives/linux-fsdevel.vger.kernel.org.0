Return-Path: <linux-fsdevel+bounces-44865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A129FA6D941
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 12:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AAE168D0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878341E0DB3;
	Mon, 24 Mar 2025 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NMzcS0d0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vlkbrFzq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NMzcS0d0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vlkbrFzq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABF1E5B95
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742816304; cv=none; b=XAXJqTQogi6bzLArJLEI5ZJvtpY/Hjrpk9Vbckplzj3KZRijGp0eMr0gQyzqsc23jVfr06qkAFhBqFFIsCL3/PWb2W1JQDVUvgp8w4nLEhVklP5feZsqGNHNghj+LV8mCXedH7TvhH8aznK99t3veoy6/7MFizyzgsnJ1eRn8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742816304; c=relaxed/simple;
	bh=65y7ROalBBStYZ/k3UJFvtBLjZT5xl3nBPhDTZ3PGnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6X6GXQV0KUlglSZcbjjjZV3/loIyl8jMBvV2UwegRQAqtYY+IhoyxGDm6l7zwFtU3K4BvE2YELPWW6MxTLmfHWnXU4Q4jscBZOdhU7OzMYL1MxT5aytfUFOGzzx6ak2aAJU/jmfxT4TgxcIgU5weRI+uZksp6Jb79UQQF8+MR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NMzcS0d0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vlkbrFzq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NMzcS0d0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vlkbrFzq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D8DF2117D;
	Mon, 24 Mar 2025 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742816300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14iO73jmtexEGQvspYl/bmufl1PRHA8ASQMCDBnBTjs=;
	b=NMzcS0d0vPEKsyNEtpRbTtyMCzSZ3oB5oA7La2GH0pkYXumqVljIZqzTPh9dCBr4hXNyvf
	1anR4IHk3WvgJNYgN6cYaAbgd6kdElTGpotJD8CWzf2IjxH8zTnbq+voNfkEDA7OjL13Fe
	zjhxKGDjJaszmb0+kaFCaGUVJeJ/OAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742816300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14iO73jmtexEGQvspYl/bmufl1PRHA8ASQMCDBnBTjs=;
	b=vlkbrFzquyDYDJnNvfjH9X072JgGjoNxqaXG0mpWBkj/jfSnXuncwSbegVXRGgnyCv97oO
	h8P5aBVlK3uTDGBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742816300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14iO73jmtexEGQvspYl/bmufl1PRHA8ASQMCDBnBTjs=;
	b=NMzcS0d0vPEKsyNEtpRbTtyMCzSZ3oB5oA7La2GH0pkYXumqVljIZqzTPh9dCBr4hXNyvf
	1anR4IHk3WvgJNYgN6cYaAbgd6kdElTGpotJD8CWzf2IjxH8zTnbq+voNfkEDA7OjL13Fe
	zjhxKGDjJaszmb0+kaFCaGUVJeJ/OAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742816300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14iO73jmtexEGQvspYl/bmufl1PRHA8ASQMCDBnBTjs=;
	b=vlkbrFzquyDYDJnNvfjH9X072JgGjoNxqaXG0mpWBkj/jfSnXuncwSbegVXRGgnyCv97oO
	h8P5aBVlK3uTDGBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90203137AC;
	Mon, 24 Mar 2025 11:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TmglIyxE4WdsDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Mar 2025 11:38:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 49376A076A; Mon, 24 Mar 2025 12:38:20 +0100 (CET)
Date: Mon, 24 Mar 2025 12:38:20 +0100
From: Jan Kara <jack@suse.cz>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
Message-ID: <vnb6flqo3hhijz4kb3yio5rxzaugvaxharocvtf4j4s5o5xynm@nbccfx5xqvnk>
References: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
 <Z9xG2l8lm7ha3Pf2@infradead.org>
 <acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
 <Z9z32X7k_eVLrYjR@infradead.org>
 <576418420308d2511a4c155cc57cf0b1420c273b.camel@HansenPartnership.com>
 <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 21-03-25 13:00:24, James Bottomley via Lsf-pc wrote:
> On Fri, 2025-03-21 at 08:34 -0400, James Bottomley wrote:
> [...]
> > Let me digest all that and see if we have more hope this time around.
> 
> OK, I think I've gone over it all.  The biggest problem with
> resurrecting the patch was bugs in ext3, which isn't a problem now. 
> Most of the suspend system has been rearchitected to separate
> suspending user space processes from kernel ones.  The sync it
> currently does occurs before even user processes are frozen.  I think
> (as most of the original proposals did) that we just do freeze all
> supers (using the reverse list) after user processes are frozen but
> just before kernel threads are (this shouldn't perturb the image
> allocation in hibernate, which was another source of bugs in xfs).

So as far as my memory serves the fundamental problem with this approach
was FUSE - once userspace is frozen, you cannot write to FUSE filesystems
so filesystem freezing of FUSE would block if userspace is already
suspended. You may even have a setup like:

bdev <- fs <- FUSE filesystem <- loopback file <- loop device <- another fs

So you really have to be careful to freeze this stack without causing
deadlocks. So you need to be freezing userspace after filesystems are
frozen but then you have to deal with the fact that parts of your userspace
will be blocked in the kernel (trying to do some write) waiting for the
filesystem to thaw. But it might be tractable these days since I have a
vague recollection that system suspend is now able to gracefully handle
even tasks in uninterruptible sleep.

> There's a final wrinkle in that if I plumb efivarfs into all this, it
> needs to know whether it was a hibernate or suspend, but I can add that
> as an extra freeze_holder flag.
> 
> This looked like such a tiny can of worms when I opened it; now it
> seems to be a lot bigger on the inside than it was on the outside,
> sigh.

Never underestimate the amount of worms in a can ;)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

