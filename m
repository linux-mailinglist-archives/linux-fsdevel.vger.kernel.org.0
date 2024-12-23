Return-Path: <linux-fsdevel+bounces-38073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AAD9FB57A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 21:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B0A162760
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739D41D14FF;
	Mon, 23 Dec 2024 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wPUsqLrM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bE+PN5CC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wPUsqLrM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bE+PN5CC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DD91B6CFE;
	Mon, 23 Dec 2024 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734986454; cv=none; b=Dh0LzCtLoHOS3GrQyqNER0xxWmGsImH/2dVaG8MccFg9rHRyVvknqDF7PkdokX5D8+QwORyh0rpZAc08mYvtzwBKOpRSMj6ikoiJ0TwldIYtJKnYH3mxt5W7fZD92bpd0t9Lnh5V+thIdDuq3Cugbw32xJDn9jRinsOIb2eQMcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734986454; c=relaxed/simple;
	bh=zVijs5yhOahT9ztPvUNqujV911bZNoZaEh2SmtZwQnY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZagxX58bfExZ/jjK4sY1kcD303OokE+yBgIfbEdGRNiuV8GtWlu4GZAr8vs1jmdlb13vX7OVgnoEP7OiDF548/bAANgqavp1nAWAK3tFzntUEvcLq6G4vK0TwQl/zBJl7Wqu332yeGbXZA9bgcUgKq8hJO0QaUu+imHgKFtbC9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wPUsqLrM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bE+PN5CC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wPUsqLrM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bE+PN5CC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0EC231F399;
	Mon, 23 Dec 2024 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734986450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEhYcaukWkCZuXFB0KSDL5ySzwV5hYgQ3kD/WE5RN3M=;
	b=wPUsqLrMqm8bmisa3j0sshwZIM4Q9PdjFoYV0uUDdS4fXRbtl31u8qmtiwTHgHe+WccZwJ
	xEuw3CXtGiIvY2BPgCjcinmlIpF4oJiEgp68M3qK4cgMwUw2tFDDdsg9DsN7O9XJA0S5Xd
	4KUPanBNrcY2QamLHn3qDLwmpMJWhjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734986450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEhYcaukWkCZuXFB0KSDL5ySzwV5hYgQ3kD/WE5RN3M=;
	b=bE+PN5CCwyG0wFYQMQalD2qutU7gfecCicavPIJIB1GpFuIMM2j+YVv80StpmzHXgguS08
	UEvshM5tCIsqGZAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wPUsqLrM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bE+PN5CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734986450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEhYcaukWkCZuXFB0KSDL5ySzwV5hYgQ3kD/WE5RN3M=;
	b=wPUsqLrMqm8bmisa3j0sshwZIM4Q9PdjFoYV0uUDdS4fXRbtl31u8qmtiwTHgHe+WccZwJ
	xEuw3CXtGiIvY2BPgCjcinmlIpF4oJiEgp68M3qK4cgMwUw2tFDDdsg9DsN7O9XJA0S5Xd
	4KUPanBNrcY2QamLHn3qDLwmpMJWhjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734986450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEhYcaukWkCZuXFB0KSDL5ySzwV5hYgQ3kD/WE5RN3M=;
	b=bE+PN5CCwyG0wFYQMQalD2qutU7gfecCicavPIJIB1GpFuIMM2j+YVv80StpmzHXgguS08
	UEvshM5tCIsqGZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7114137DA;
	Mon, 23 Dec 2024 20:40:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IzuZJs/KaWf8fgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 23 Dec 2024 20:40:47 +0000
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
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] VFS: take a shared lock for create/remove directory
 operations.
In-reply-to: <20241223072655.GM1977892@ZenIV>
References: <>, <20241223072655.GM1977892@ZenIV>
Date: Tue, 24 Dec 2024 07:40:40 +1100
Message-id: <173498644096.11072.12807652552648634855@noble.neil.brown.name>
X-Rspamd-Queue-Id: 0EC231F399
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 23 Dec 2024, Al Viro wrote:
> On Mon, Dec 23, 2024 at 06:11:16PM +1100, NeilBrown wrote:
> > ... Yes, thanks.
> > 
> > So I need __d_unalias() to effectively do a "try_lock" of
> > DCACHE_PAR_UPDATE and hold the lock across __d_move().
> > I think that would address the concerned you raised.
> > 
> > Did you see anything else that might be problematic?
> 
> That might work with ->d_parent, but it won't help with ->d_name
> in same-parent case of __d_unalias()...
> 

Why would the same-parent case be any different?
Certainly it doesn't need s_vfs_rename_mutex and it there is no second
parent to get a shared lock on.  But we would still need to set
DCACHE_PAR_UPDATE under ->d_lock on "alias".  If we found that it was
already set and instead failed with -ESTALE, that would prevent
__d_unalias from changing anything including ->d_name after
lookup_and_lock has checked that the parent and d_name are unchanged
(until done_lookup_and_lock is called of course).

What am I missing?
Thanks,
NeilBrown

