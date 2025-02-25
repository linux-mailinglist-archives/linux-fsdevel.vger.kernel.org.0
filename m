Return-Path: <linux-fsdevel+bounces-42618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4227A450EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 00:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADEB16BC19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 23:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5B7213235;
	Tue, 25 Feb 2025 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e5vm9Dko";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="euO0chB4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e5vm9Dko";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="euO0chB4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA5F25771
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526230; cv=none; b=ghwbhvdlPwvV4G/8cowejb5+MZjdsE3JwdYIUTIPc0q8m57ptrkK3ZZmFux2jnvu+2NrH3sE+BSw46zVNfGYOlQHWJw+xBjtfJJpcYujp+CYXKkDC1AGA94etocS/1NqFDkWE0fqlKDzW315xuuNvrT90FI9gOJ6ZpIbLOfBfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526230; c=relaxed/simple;
	bh=AMrqC0THAFLHIU+pxD/2/XkJSiuy36KPBkMdSEE8l04=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=a6aydeVxvzDg8KyHzXBJ2PnJ2huhOdLvxW1fnWoQPQHCRKrEqt/7qEIYEc0/18t/WZFQaeoQu6TNrUo/COCD+I0SQRTcsNAS8Wh0fQbMwMq7/jXulDGDzfvJ/hHomq0IwfQGExe7Fdvwka5AISVDXUC4lJ2/eGQwepjDNgZuWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e5vm9Dko; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=euO0chB4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e5vm9Dko; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=euO0chB4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 566A91F38A;
	Tue, 25 Feb 2025 23:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740526227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qx6Xlh4p5B0JkmRtt6n/AY0Q0QARqfII7RujOLQp900=;
	b=e5vm9Dko/3uUSm3pMg+//bSwy2quBmH83fnGxyn8r7BsB+D8zuP5A+eyf4AuB+DkRr9fJ3
	XM8Q0A2NrLP7HitTTjDEiz+z91UfQfNxEmllCXdbKwauSph86/Erpj7V8ILHq5/OB5r3gT
	skf8FiBVChXVGLR9SrAAhG2ZYb45dCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740526227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qx6Xlh4p5B0JkmRtt6n/AY0Q0QARqfII7RujOLQp900=;
	b=euO0chB4GUBqWApMXfGgh1oY59O1oS9NkPjhHJ7YkPpbF2/kxCkLjwcu3VhsUHVG6DJjp2
	Zl6rIQl1NlBtJdAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740526227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qx6Xlh4p5B0JkmRtt6n/AY0Q0QARqfII7RujOLQp900=;
	b=e5vm9Dko/3uUSm3pMg+//bSwy2quBmH83fnGxyn8r7BsB+D8zuP5A+eyf4AuB+DkRr9fJ3
	XM8Q0A2NrLP7HitTTjDEiz+z91UfQfNxEmllCXdbKwauSph86/Erpj7V8ILHq5/OB5r3gT
	skf8FiBVChXVGLR9SrAAhG2ZYb45dCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740526227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qx6Xlh4p5B0JkmRtt6n/AY0Q0QARqfII7RujOLQp900=;
	b=euO0chB4GUBqWApMXfGgh1oY59O1oS9NkPjhHJ7YkPpbF2/kxCkLjwcu3VhsUHVG6DJjp2
	Zl6rIQl1NlBtJdAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13AA813332;
	Tue, 25 Feb 2025 23:30:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tZl0K5BSvmc+MgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 25 Feb 2025 23:30:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jan Kara" <jack@suse.cz>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH 01/21] procfs: kill ->proc_dops
In-reply-to: <7xagwr27m3ygguz7nv53u5up2jnzjbuhqcadzwjz7jzmafp4ct@rgkubaqwpwah>
References:
 <>, <7xagwr27m3ygguz7nv53u5up2jnzjbuhqcadzwjz7jzmafp4ct@rgkubaqwpwah>
Date: Wed, 26 Feb 2025 10:30:21 +1100
Message-id: <174052622191.102979.9523419116370013917@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -8.30
X-Spam-Flag: NO

On Wed, 26 Feb 2025, Jan Kara wrote:
> On Mon 24-02-25 21:20:31, Al Viro wrote:
> > It has two possible values - one for "forced lookup" entries, another
> > for the normal ones.  We'd be better off with that as an explicit
> > flag anyway and in addition to that it opens some fun possibilities
> > with ->d_op and ->d_flags handling.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> FWIW I went through the patches and I like them. They look mostly
> straightforward enough to me and as good simplifications.
> 

Ditto.  Nice clean-up
It might be good to document s_d_flags and particularly the value of
setting DCACHE_DONTCACHE.  That flag is documented in the list of
DCACHE_ flags, but making the connection that it can usefully be put in
s_d_flags might be a step to far for many.

Thanks,
NeilBrown

