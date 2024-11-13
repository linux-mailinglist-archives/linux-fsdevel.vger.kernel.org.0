Return-Path: <linux-fsdevel+bounces-34646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCBE9C7470
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC85B2B507
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5088200B98;
	Wed, 13 Nov 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AM7F/WHH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qUDP9Ff+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AM7F/WHH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qUDP9Ff+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551ED2003B3
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506694; cv=none; b=pF+UP/3xDOaR6ybY93Mz71eNOIbxvDLP3mHejhfnjq1b05HFjbn029fBGipfmm45TkHNTUg0oRi0TAA68gQoKIICBrG5kCcz8/JpIPEnzqCcTmK1tDF7xHetjL/yt/KOS8KdNLfbbVKiScgRLJS7pMud4t7XB2kzGQc0zg0Vw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506694; c=relaxed/simple;
	bh=qDx7ZyOFWMK4bIt2JVEIjVDiOtbdmh6kf9F5SKHnFb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frYYWvCSkyUAtcAx2aV7vQkDTf4G3P0hDDEBlOK74jsRzxkbWgBVcT9zWJT4RRkO6VvSYTiunvvXlSIZEbQ4MNUztNOT8QmqxRbWlQ8PkqNH5QReNoKpAzOIR11PnfGNCYICa+nzYZvfwbzcRwnCCScrOUzpNVPTyoHC5pBLHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AM7F/WHH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qUDP9Ff+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AM7F/WHH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qUDP9Ff+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D19B211A5;
	Wed, 13 Nov 2024 14:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731506690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swY7n1EhmzyWXGjekJZDeyIL5xedigIdnKVoy+7Ee4c=;
	b=AM7F/WHHuuUjDkI3otrCjGwLTuB4zLBXlf2RCYJcfS3bH6jDiztdjj8U6PcADGzoADMuaL
	5Xzhw3Qs/4gpGEEc2kGXVRIpZg7+6SiCwWVOuchukiuYI68ODYQLYi/0zwJ32z9bK78690
	eMtcw+Hydu3EbonXnlfgjUpi+FlrtJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731506690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swY7n1EhmzyWXGjekJZDeyIL5xedigIdnKVoy+7Ee4c=;
	b=qUDP9Ff+OxFCFnb6EeetD84sqDe3Bia/VV6yhOjEUByxptTA4aPmYmSbTpAq4mg9ug1uSn
	ZwWCiBeOTCmYqjAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="AM7F/WHH";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qUDP9Ff+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731506690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swY7n1EhmzyWXGjekJZDeyIL5xedigIdnKVoy+7Ee4c=;
	b=AM7F/WHHuuUjDkI3otrCjGwLTuB4zLBXlf2RCYJcfS3bH6jDiztdjj8U6PcADGzoADMuaL
	5Xzhw3Qs/4gpGEEc2kGXVRIpZg7+6SiCwWVOuchukiuYI68ODYQLYi/0zwJ32z9bK78690
	eMtcw+Hydu3EbonXnlfgjUpi+FlrtJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731506690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swY7n1EhmzyWXGjekJZDeyIL5xedigIdnKVoy+7Ee4c=;
	b=qUDP9Ff+OxFCFnb6EeetD84sqDe3Bia/VV6yhOjEUByxptTA4aPmYmSbTpAq4mg9ug1uSn
	ZwWCiBeOTCmYqjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52DE313A6E;
	Wed, 13 Nov 2024 14:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YkwzFAKyNGeHaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Nov 2024 14:04:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E6A14A08D0; Wed, 13 Nov 2024 15:04:49 +0100 (CET)
Date: Wed, 13 Nov 2024 15:04:49 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: fix sending inotify event with unexpected
 filename
Message-ID: <20241113140449.h6alr7opnzcjvjez@quack3>
References: <20241111201101.177412-1-amir73il@gmail.com>
 <20241113134258.524nduvn3piqqkco@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113134258.524nduvn3piqqkco@quack3>
X-Rspamd-Queue-Id: 5D19B211A5
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,szeredi.hu:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 13-11-24 14:42:58, Jan Kara wrote:
> On Mon 11-11-24 21:11:01, Amir Goldstein wrote:
> > We got a report that adding a fanotify filsystem watch prevents tail -f
> > from receiving events.
> > 
> > Reproducer:
> > 
> > 1. Create 3 windows / login sessions. Become root in each session.
> > 2. Choose a mounted filesystem that is pretty quiet; I picked /boot.
> > 3. In the first window, run: fsnotifywait -S -m /boot
> > 4. In the second window, run: echo data >> /boot/foo
> > 5. In the third window, run: tail -f /boot/foo
> > 6. Go back to the second window and run: echo more data >> /boot/foo
> > 7. Observe that the tail command doesn't show the new data.
> > 8. In the first window, hit control-C to interrupt fsnotifywait.
> > 9. In the second window, run: echo still more data >> /boot/foo
> > 10. Observe that the tail command in the third window has now printed
> > the missing data.
> > 
> > When stracing tail, we observed that when fanotify filesystem mark is
> > set, tail does get the inotify event, but the event is receieved with
> > the filename:
> > 
> > read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\20\0\0\0foo\0\0\0\0\0\0\0\0\0\0\0\0\0",
> > 50) = 32
> > 
> > This is unexpected, because tail is watching the file itself and not its
> > parent and is inconsistent with the inotify event received by tail when
> > fanotify filesystem mark is not set:
> > 
> > read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0", 50) = 16
> > 
> > The inteference between different fsnotify groups was caused by the fact
> > that the mark on the sb requires the filename, so the filename is passed
> > to fsnotify().  Later on, fsnotify_handle_event() tries to take care of
> > not passing the filename to groups (such as inotify) that are interested
> > in the filename only when the parent is watching.
> > 
> > But the logic was incorrect for the case that no group is watching the
> > parent, some groups are watching the sb and some watching the inode.
> > 
> > Reported-by: Miklos Szeredi <miklos@szeredi.hu>
> > Fixes: 7372e79c9eb9 ("fanotify: fix logic of reporting name info with watched parent")
> > Cc: stable@vger.kernel.org # 5.10+
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> 
> Thanks for analysis, Amir!
> 
> > @@ -333,12 +333,14 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
> >  	if (!inode_mark)
> >  		return 0;
> >  
> > -	if (mask & FS_EVENT_ON_CHILD) {
> > +	if (mask & FS_EVENTS_POSS_ON_CHILD) {
> 
> So this is going to work but as far as I'm reading the code in
> fsnotify_handle_event() I would be maybe calmer if we instead wrote the
> condition as:
> 
> 	if (!(mask & ALL_FSNOTIFY_DIRENT_EVENTS))
> 
> I.e., if the event on the inode is not expecting name & dir, clear them.
> Instead of your variant which I understand as: "if we could have added name
> & dir only for parent, clear it now". The bitwise difference between these
> two checks is: FS_DELETE_SELF | FS_MOVE_SELF | FS_UNMOUNT | FS_Q_OVERFLOW |
> FS_IN_IGNORED | FS_ERROR, none of which should matter. Maybe I'm paranoid
> but we already had too many subtle bugs in this code so I'm striving for
> maximum robustness :). What do you think?

BTW, I can just massage the patch on commit since you're now busy with HSM
stuff but I wanted to check what's your opinion on the change.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

