Return-Path: <linux-fsdevel+bounces-34642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC779C7136
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CAF41F21BC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 13:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93062202650;
	Wed, 13 Nov 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Urv/H8j5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VNjXhKW/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Urv/H8j5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VNjXhKW/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7576200B88
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505387; cv=none; b=jsNiPZi/mCRt1MF206BYU5gjBMcOgkBIXSy47RLsWUgMtyeUQ2qtU0HAMnFeL9+b49kgg+bu1EdA6P/SkzFGNOVKE7VDPio+P3HCY8x+AfTlmuUBg3YzrQ6beDhwPgfxJRU9EsWJDB06vf3YPg1+g//KmeSrH7TFZU0Laqdiz1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505387; c=relaxed/simple;
	bh=6ixucvn5A66EQaj6dZcroGJBIfUCHhonoZXE2OWGK38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX++wtdjeibZzRS7FaMDJBLLAjbNNAWzgn9wX4oCnRi5iW1YJaJi1b1aN1VGDZElKnvL5yaAd+mBnRnD+TlUpL+Dq6gzE/uQzQfI77/RBpbaST0QIWsTJD5TocPagxY9dbGIlV4eYRYkSb9W3InUwGJgRDAjE1keO6CL5IevXHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Urv/H8j5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VNjXhKW/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Urv/H8j5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VNjXhKW/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2C522119F;
	Wed, 13 Nov 2024 13:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731505382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RtJsQk4IzhSywXDmTUj0TrOR3pKPp0UirR7QkTcztQs=;
	b=Urv/H8j5NI/Rke/lW1CnA/JhTA292kUE2JmFws5PDxrx1pZrlIsH9l+OnG3Y6o5KemhCKQ
	jqx3TXNXjK+s6evWKWj2G/R0Ek0mX8mNpudd3K7Reb+j2SqCYI6vcIf0DHT8HFtkLlJ6BA
	FTbqw4UOPzVVn0QaUXxgivJ0m/HaWmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731505382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RtJsQk4IzhSywXDmTUj0TrOR3pKPp0UirR7QkTcztQs=;
	b=VNjXhKW/NxPVwq9dHYHvRn2z8+uUdcgWDsNiZSYkGZrYyQm8r+AnEHUbkshzEgHKi3MdA+
	KYFq8HwyYW3SXJCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Urv/H8j5";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="VNjXhKW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731505382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RtJsQk4IzhSywXDmTUj0TrOR3pKPp0UirR7QkTcztQs=;
	b=Urv/H8j5NI/Rke/lW1CnA/JhTA292kUE2JmFws5PDxrx1pZrlIsH9l+OnG3Y6o5KemhCKQ
	jqx3TXNXjK+s6evWKWj2G/R0Ek0mX8mNpudd3K7Reb+j2SqCYI6vcIf0DHT8HFtkLlJ6BA
	FTbqw4UOPzVVn0QaUXxgivJ0m/HaWmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731505382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RtJsQk4IzhSywXDmTUj0TrOR3pKPp0UirR7QkTcztQs=;
	b=VNjXhKW/NxPVwq9dHYHvRn2z8+uUdcgWDsNiZSYkGZrYyQm8r+AnEHUbkshzEgHKi3MdA+
	KYFq8HwyYW3SXJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 978E013301;
	Wed, 13 Nov 2024 13:43:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 84/7JOasNGfVXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Nov 2024 13:43:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 331CFA08D0; Wed, 13 Nov 2024 14:42:58 +0100 (CET)
Date: Wed, 13 Nov 2024 14:42:58 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: fix sending inotify event with unexpected
 filename
Message-ID: <20241113134258.524nduvn3piqqkco@quack3>
References: <20241111201101.177412-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111201101.177412-1-amir73il@gmail.com>
X-Rspamd-Queue-Id: A2C522119F
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon 11-11-24 21:11:01, Amir Goldstein wrote:
> We got a report that adding a fanotify filsystem watch prevents tail -f
> from receiving events.
> 
> Reproducer:
> 
> 1. Create 3 windows / login sessions. Become root in each session.
> 2. Choose a mounted filesystem that is pretty quiet; I picked /boot.
> 3. In the first window, run: fsnotifywait -S -m /boot
> 4. In the second window, run: echo data >> /boot/foo
> 5. In the third window, run: tail -f /boot/foo
> 6. Go back to the second window and run: echo more data >> /boot/foo
> 7. Observe that the tail command doesn't show the new data.
> 8. In the first window, hit control-C to interrupt fsnotifywait.
> 9. In the second window, run: echo still more data >> /boot/foo
> 10. Observe that the tail command in the third window has now printed
> the missing data.
> 
> When stracing tail, we observed that when fanotify filesystem mark is
> set, tail does get the inotify event, but the event is receieved with
> the filename:
> 
> read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\20\0\0\0foo\0\0\0\0\0\0\0\0\0\0\0\0\0",
> 50) = 32
> 
> This is unexpected, because tail is watching the file itself and not its
> parent and is inconsistent with the inotify event received by tail when
> fanotify filesystem mark is not set:
> 
> read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0", 50) = 16
> 
> The inteference between different fsnotify groups was caused by the fact
> that the mark on the sb requires the filename, so the filename is passed
> to fsnotify().  Later on, fsnotify_handle_event() tries to take care of
> not passing the filename to groups (such as inotify) that are interested
> in the filename only when the parent is watching.
> 
> But the logic was incorrect for the case that no group is watching the
> parent, some groups are watching the sb and some watching the inode.
> 
> Reported-by: Miklos Szeredi <miklos@szeredi.hu>
> Fixes: 7372e79c9eb9 ("fanotify: fix logic of reporting name info with watched parent")
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks for analysis, Amir!

> @@ -333,12 +333,14 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
>  	if (!inode_mark)
>  		return 0;
>  
> -	if (mask & FS_EVENT_ON_CHILD) {
> +	if (mask & FS_EVENTS_POSS_ON_CHILD) {

So this is going to work but as far as I'm reading the code in
fsnotify_handle_event() I would be maybe calmer if we instead wrote the
condition as:

	if (!(mask & ALL_FSNOTIFY_DIRENT_EVENTS))

I.e., if the event on the inode is not expecting name & dir, clear them.
Instead of your variant which I understand as: "if we could have added name
& dir only for parent, clear it now". The bitwise difference between these
two checks is: FS_DELETE_SELF | FS_MOVE_SELF | FS_UNMOUNT | FS_Q_OVERFLOW |
FS_IN_IGNORED | FS_ERROR, none of which should matter. Maybe I'm paranoid
but we already had too many subtle bugs in this code so I'm striving for
maximum robustness :). What do you think?

								Honza

>  		/*
>  		 * Some events can be sent on both parent dir and child marks
>  		 * (e.g. FS_ATTRIB).  If both parent dir and child are
>  		 * watching, report the event once to parent dir with name (if
>  		 * interested) and once to child without name (if interested).
> +		 *
> +		 * In any case, whether the parent is watching or not watching,
>  		 * The child watcher is expecting an event without a file name
>  		 * and without the FS_EVENT_ON_CHILD flag.
>  		 */
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

