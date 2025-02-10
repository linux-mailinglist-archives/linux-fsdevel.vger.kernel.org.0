Return-Path: <linux-fsdevel+bounces-41354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C02A2E34B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70EC1887F0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 04:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536C315A864;
	Mon, 10 Feb 2025 04:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gYJ2J9vb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/T9LWViJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gYJ2J9vb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/T9LWViJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BAF2F2E;
	Mon, 10 Feb 2025 04:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739163491; cv=none; b=gzXs+waOw1XvUhyfDnSBzWwtt5HjLQY+YpU90gcp8uGqqr609EwaM562L6FzN9A6AhzVsII4MpMjBNld/cYRiLTny8HaByYHPL6AegYXOXO4rG8ouyuurhxqPvtVJX6M0o5TCVccBjjqlivRfFiWc9LHxbVFosV0bCwWjCra2Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739163491; c=relaxed/simple;
	bh=TnRrt+hQEk2SZeUr/akpqwUhJzbied5BUdTybKmiRL8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SR8cQKY9grJ+QGVs2NzsUfK1Hiw/J7GTUvk+X9UhWq/JbOpxV2W9X8VqKAbDr1kMtdqbbuJZgEJE8gQaWKIx/y8TvXY1l4CI52UWrFb/DHC7H0J/N/c6/0WXyqHpRfmiS5FB+cuTE9hAGETj/Fm7QS3+yF/q1VP9IFiworFOJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gYJ2J9vb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/T9LWViJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gYJ2J9vb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/T9LWViJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4208121137;
	Mon, 10 Feb 2025 04:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739163488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCk4jcQLudkeoeTgh4xyRKMcUfnyM1cRiI/u8rggCzE=;
	b=gYJ2J9vbnOuchXvJJauaVg4GIKYFH+a6jlKE3D0fA2LwLnq1hIkmSpbrdlDntBrvr3w5kD
	zUrBribfqbqEg3oc9plfTWjbK6Y/ajVSoKDnzl1rsnvsHxDIGn93C1pSBto7K/d7b4B4GN
	jEVCt2XWvbx/L9dq14bPWw9hHYQf6FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739163488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCk4jcQLudkeoeTgh4xyRKMcUfnyM1cRiI/u8rggCzE=;
	b=/T9LWViJyznEdqKEAZGaoQYWiHMPzWHpp4bGcm74/WjgqBDhUmS0oMC/+T9OXBFcL+sUfm
	HIXf3adsXnnqu8Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739163488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCk4jcQLudkeoeTgh4xyRKMcUfnyM1cRiI/u8rggCzE=;
	b=gYJ2J9vbnOuchXvJJauaVg4GIKYFH+a6jlKE3D0fA2LwLnq1hIkmSpbrdlDntBrvr3w5kD
	zUrBribfqbqEg3oc9plfTWjbK6Y/ajVSoKDnzl1rsnvsHxDIGn93C1pSBto7K/d7b4B4GN
	jEVCt2XWvbx/L9dq14bPWw9hHYQf6FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739163488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCk4jcQLudkeoeTgh4xyRKMcUfnyM1cRiI/u8rggCzE=;
	b=/T9LWViJyznEdqKEAZGaoQYWiHMPzWHpp4bGcm74/WjgqBDhUmS0oMC/+T9OXBFcL+sUfm
	HIXf3adsXnnqu8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8317C13707;
	Mon, 10 Feb 2025 04:58:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fbyaDV2HqWeAaAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 10 Feb 2025 04:58:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Dave Chinner" <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 02/19] VFS: use global wait-queue table for d_alloc_parallel()
In-reply-to: <20250207193215.GD1977892@ZenIV>
References: <>, <20250207193215.GD1977892@ZenIV>
Date: Mon, 10 Feb 2025 15:58:02 +1100
Message-id: <173916348251.22054.1170999043107860979@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sat, 08 Feb 2025, Al Viro wrote:
> 1) what's wrong with using middle bits of dentry as index?  What the hell
> is that thing about pid for?

That does "hell" have to do with it?

All we need here is a random number.  Preferably a cheap random number.
pid is cheap and quite random.
The dentry pointer would be even cheaper (no mem access) providing it
doesn't cost much to get the randomness out.  I considered hash_ptr()
but thought that was more code that it was worth.

Do you have a formula for selecting the "middle" bits in a way that is
expected to still give good randomness?

> 
> 2) part in d_add_ci() might be worth a comment re d_lookup_done() coming
> for the original dentry, no matter what.

I think the previous code deserved explanation more than the new, but
maybe I missed something.
In each case, d_wait_lookup() will wait for the given dentry to no
longer be d_in_lookup() which means waiting for DCACHE_PAR_LOOKUP to be
cleared.  The only place which clears DCACHE_PAR_LOOKUP is
__d_lookup_unhash_wake(). which always wakes the target.
In the previous code it would wake both the non-case-exact dentry and
the case-exact dentry waiters but they would go back to sleep if their
DCACHE_PAR_LOOKUP hadn't been cleared, so no interesting behaviour.
Reusing the wq from one to the other is a sensible simplification, but
not something we need any reminder of once it is no longer needed.

Would sort of comment would you add?

> 
> 3) the dance with conditional __wake_up() is worth a helper, IMO.
> 

I tried to explain that in the commit message bug I agree it deserves to
be in the code too.
I have added:

	/* ->d_wait is only set if some thread is actually waiting.
	 * If we find it is NULL - the common case - then there was no
	 * contention and there are no waiters to be woken.
	 */

and 
	/* Don't set a wait_queue until someone is actually waiting */
before
	new->d_wait = NULL;
in d_alloc_parallel().

Thanks,
NeilBrown



