Return-Path: <linux-fsdevel+bounces-21509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F121D904C66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 09:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695211F2231F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 07:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F62416B749;
	Wed, 12 Jun 2024 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aHEfu/9I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HntaK/XD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aHEfu/9I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HntaK/XD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6F12DD9B;
	Wed, 12 Jun 2024 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176144; cv=none; b=HQ0Op52gncfSRvFV7Aw6s5mdmZAurZ2eiPLoqKY0NjnmTYkejt0B8xsDfHcxvnxa8XJw1TbOY+Uqftm8HZODtnbJq3j5QqqdXB1Dhd7Ftx1OH6vZD7Hr9EDxnuXzGs2uAuDk0D8TYNplUFZy70AhDaxp1r98Ea/O9yJu9QAvQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176144; c=relaxed/simple;
	bh=cVu2TbN1bt8mwrJse0j92Z1I9fU2mSvB26dJ8/ydGOE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Y7HfelFTTdw6+iq2UW9hydCpXmrYx9oC+z9fktup697BkGKwUWUi4Dq7zF4xNG9PLmP/0oLztdYOWOB3nJX8Gb0zjJ8y5VWUE1zyIVSKpzTo/ftfMfblAuKxZqrwaWCbwsvMVymeogOqIOxPEA3CmCVXvXkxjr/brcFVvC5Ce4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aHEfu/9I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HntaK/XD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aHEfu/9I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HntaK/XD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 88FAA5BCFB;
	Wed, 12 Jun 2024 07:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718176141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XA6suEtJ1Wm6DTNcti+lUkN3qJPn424kTR0RHITUBCY=;
	b=aHEfu/9IM5Sw0UcPbnPtFScAmNS7/gxRq8y210X3UCVRfm+e5nFQR08yUoLcV5hd0K1E6t
	SUEogeiGMAmot87StL5zU+QHU/RgNTWNXv4HPXOqbKtfrl5qgJJW8Vbypk/Dy5oORTw+sj
	GYNtDHy5oXL69JVT1clfgXES79rb2aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718176141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XA6suEtJ1Wm6DTNcti+lUkN3qJPn424kTR0RHITUBCY=;
	b=HntaK/XD3nY2iLQWy9DJ3O1MRlPRTKTqhereJg0jBlyTNfW9PnJmt8RhSHT/47IW1ANDZk
	JgypLnQlpNmQKBBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="aHEfu/9I";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="HntaK/XD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718176141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XA6suEtJ1Wm6DTNcti+lUkN3qJPn424kTR0RHITUBCY=;
	b=aHEfu/9IM5Sw0UcPbnPtFScAmNS7/gxRq8y210X3UCVRfm+e5nFQR08yUoLcV5hd0K1E6t
	SUEogeiGMAmot87StL5zU+QHU/RgNTWNXv4HPXOqbKtfrl5qgJJW8Vbypk/Dy5oORTw+sj
	GYNtDHy5oXL69JVT1clfgXES79rb2aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718176141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XA6suEtJ1Wm6DTNcti+lUkN3qJPn424kTR0RHITUBCY=;
	b=HntaK/XD3nY2iLQWy9DJ3O1MRlPRTKTqhereJg0jBlyTNfW9PnJmt8RhSHT/47IW1ANDZk
	JgypLnQlpNmQKBBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB73B137DF;
	Wed, 12 Jun 2024 07:08:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 03rTG4lJaWaxRAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 07:08:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Amir Goldstein" <amir73il@gmail.com>, "James Clark" <james.clark@arm.com>,
 ltp@lists.linux.it, linux-nfs@vger.kernel.org,
 "LKML" <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH] VFS: generate FS_CREATE before FS_OPEN when ->atomic_open used.
In-reply-to: <20240612031404.GH1629371@ZenIV>
References: <>, <20240612031404.GH1629371@ZenIV>
Date: Wed, 12 Jun 2024 17:08:53 +1000
Message-id: <171817613375.14261.11854641862108370837@noble.neil.brown.name>
X-Rspamd-Queue-Id: 88FAA5BCFB
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,gmail.com,arm.com,lists.linux.it,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, 12 Jun 2024, Al Viro wrote:
> On Wed, Jun 12, 2024 at 12:55:40PM +1000, NeilBrown wrote:
> > > 	IF we don't care about that, we might as well take fsnotify_open()
> > > out of vfs_open() and, for do_open()/do_tmpfile()/do_o_path(), into
> > > path_openat() itself.  I mean, having
> > >         if (likely(!error)) {
> > >                 if (likely(file->f_mode & FMODE_OPENED)) {
> > > 			fsnotify_open(file);
> > >                         return file;
> > > 		}
> > > in there would be a lot easier to follow...  It would lose fsnotify_ope=
n()
> > > in a few more failure exits, but if we don't give a damn about having it
> > > paired with fsnotify_close()...
> > >=20
> >=20
> > Should we have fsnotify_open() set a new ->f_mode flag, and
> > fsnotify_close() abort if it isn't set (and clear it if it is)?
> > Then we would be guaranteed a balance - which does seem like a good
> > idea.
>=20
> Umm...  In that case, I would rather have FMODE_NONOTIFY set just before
> the fput() in path_openat() - no need to grab another flag from ->f_mode
> (not a lot of unused ones there) and no need to add any overhead on
> the fast path.
>=20

Unfortunately that gets messy if handle_truncate() fails.  We would need
to delay the fsnotify_open() until after truncate which means moving it
out of vfs_open() or maybe calling do_dentry_open() directly from
do_open() - neither of which I like.

I think it is best to stick with "if FMODE_OPENED is set, then we call
fsnotify_open() even if the open will fail", and only move the place
where fsnotify_open() is called.

BTW I was wrong about gfs.  Closer inspection of the code show that
finish_open() is only called in the ->atomic_open case.

Thanks,
NeilBrown

