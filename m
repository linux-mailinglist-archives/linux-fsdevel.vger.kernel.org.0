Return-Path: <linux-fsdevel+bounces-45744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07B6A7BA40
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 11:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00093B4C6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CFE1A0BE0;
	Fri,  4 Apr 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FmCEPqBS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KlboK5fQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FmCEPqBS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KlboK5fQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D411779B8
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743760434; cv=none; b=dORvr2HmDqOYjFO6F5N9n1FuohWbx2Dl+vi9pFI19Ux6hd448QXUUPi5TcKqcQu5yhlXKuRey632jc+prxsW/lKhbybPSb5zfnAP39zHRBKUG2e6aIjiDsXK2GSSzxP0x2epUakeHFfrKAP58/0W6pWerApPXVwJ8Az7VeneDEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743760434; c=relaxed/simple;
	bh=kJdaXERp78gwS4/JLbeMhM5jLnh1ezIjdSZC1VI9WCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2PNICdPysCRDdL6HWHj6y8nb5tdffYO8aglgdygGsflWo+CGi1BfWfOu4/jF+UaqFuDaVjxoOaKJ0+DXLD9G+6MTiuCk92oQ1eBmLj72tABTUBm5Ehpoj5RnUy5ttZvPDVTBXWZxr1EqRiMFIg3y7cdKyV1cvlvj3mDZnC6nEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FmCEPqBS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KlboK5fQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FmCEPqBS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KlboK5fQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CDDF2118C;
	Fri,  4 Apr 2025 09:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743760424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfPgyO/p9vIdak8Nyg79P02MnKeIGDepUMXlO8Avji8=;
	b=FmCEPqBSd1+RfGStOycKVQmQsou5zxgvZl8nR5vNCHmIRcyW2yZ+67DFNZKpV3EHXhz/Kk
	MgFOH3cmFy4yx3NCpMjnX+8GYrtWp5bY+q9qbat/+65AKlKvhGwlxAQzFnwFYSTk78M7V8
	IJdzUvo/kF5RyXA9gHzm9+1iVLGYVXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743760424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfPgyO/p9vIdak8Nyg79P02MnKeIGDepUMXlO8Avji8=;
	b=KlboK5fQY+2A5Dyiwbs+rd8Ej4fh8aX6+iTMoW3XCERkwjAdzi81ltEJbq770gXTN4UIHk
	SFowbcQGHyYBp4Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FmCEPqBS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KlboK5fQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743760424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfPgyO/p9vIdak8Nyg79P02MnKeIGDepUMXlO8Avji8=;
	b=FmCEPqBSd1+RfGStOycKVQmQsou5zxgvZl8nR5vNCHmIRcyW2yZ+67DFNZKpV3EHXhz/Kk
	MgFOH3cmFy4yx3NCpMjnX+8GYrtWp5bY+q9qbat/+65AKlKvhGwlxAQzFnwFYSTk78M7V8
	IJdzUvo/kF5RyXA9gHzm9+1iVLGYVXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743760424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfPgyO/p9vIdak8Nyg79P02MnKeIGDepUMXlO8Avji8=;
	b=KlboK5fQY+2A5Dyiwbs+rd8Ej4fh8aX6+iTMoW3XCERkwjAdzi81ltEJbq770gXTN4UIHk
	SFowbcQGHyYBp4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6188B1364F;
	Fri,  4 Apr 2025 09:53:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qdvLFyis72eYFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Apr 2025 09:53:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0D602A07E6; Fri,  4 Apr 2025 11:53:36 +0200 (CEST)
Date: Fri, 4 Apr 2025 11:53:36 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: allow creating FAN_PRE_ACCESS events on
 directories
Message-ID: <ba4cmwymyiived2xrxxlo5mi2hnnljkiy5mvlbzws2w2vpwwdm@pkekpc5d2apu>
References: <20250402062707.1637811-1-amir73il@gmail.com>
 <u3myluuaylejsfidkkajxni33w2ezwcfztlhjmavdmpcoir45o@ew32e4yra6xb>
 <CAOQ4uxh7JhGMjoMpFWvHyEZ0j2kJUgLf9PjyvLeNbSAzVbDyQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh7JhGMjoMpFWvHyEZ0j2kJUgLf9PjyvLeNbSAzVbDyQA@mail.gmail.com>
X-Rspamd-Queue-Id: 6CDDF2118C
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
	RCPT_COUNT_FIVE(0.00)[5];
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

On Thu 03-04-25 19:24:57, Amir Goldstein wrote:
> On Thu, Apr 3, 2025 at 7:10 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 02-04-25 08:27:07, Amir Goldstein wrote:
> > > Like files, a FAN_PRE_ACCESS event will be generated before every
> > > read access to directory, that is on readdir(3).
> > >
> > > Unlike files, there will be no range info record following a
> > > FAN_PRE_ACCESS event, because the range of access on a directory
> > > is not well defined.
> > >
> > > FAN_PRE_ACCESS events on readdir are only generated when user opts-in
> > > with FAN_ONDIR request in event mask and the FAN_PRE_ACCESS events on
> > > readdir report the FAN_ONDIR flag, so user can differentiate them from
> > > event on read.
> > >
> > > An HSM service is expected to use those events to populate directories
> > > from slower tier on first readdir access. Having to range info means
> > > that the entire directory will need to be populated on the first
> > > readdir() call.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Jan,
> > >
> > > IIRC, the reason we did not allow FAN_ONDIR with FAN_PRE_ACCESS event
> > > in initial API version was due to uncertainty around reporting range info.
> > >
> > > Circling back to this, I do not see any better options other than not
> > > reporting range info and reporting the FAN_ONDIR flag.
> > >
> > > HSM only option is to populate the entire directory on first access.
> > > Doing a partial range populate for directories does not seem practical
> > > with exising POSIX semantics.
> >
> > I agree that range info for directory events doesn't make sense (or better
> > there's no way to have a generic implementation since everything is pretty
> > fs specific). If I remember our past discussion, filling in directory
> > content on open has unnecessarily high overhead because the user may then
> > just do e.g. lookup in the opened directory and not full readdir. That's
> > why you want to generate it on readdir. Correct?
> >
> 
> Right.
> 
> > > If you accept this claim, please consider fast tracking this change into
> > > 6.14.y.
> >
> > Hum, why the rush? It is just additional feature to allow more efficient
> > filling in of directory entries...
> >
> 
> Well, no rush really.
> 
> My incentive is not having to confuse users with documentation that
> version X supports FAN_PRE_ACCESS but only version Y supports
> it with FAN_ONDIR.
> 
> It's not a big deal, but if we have no reason to delay this, I'd just
> treat it as a fix to the new api (removing unneeded limitations).

The patch is easy enough so I guess we may push it for rc2. When testing
it, I've noticed a lot of LTP test cases fail (e.g. fanotify02) because they
get unexpected event. So likely the patch actually breaks something in
reporting of other events. I don't have time to analyze it right now so I'm
just reporting it in case you have time to have a look...
 
> I would point out that FAN_ACCESS_PERM already works
> for directories and in effect provides (almost) the exact same
> functionality as FAN_PRE_ACCESS without range info.
> 
> But in order to get the FAN_ACCESS_PERM events on directories
> listener would also be forced to get FAN_ACCESS_PERM on
> special files and regular files
> and assuming that this user is an HSM, it cannot request
> FAN_ACCESS_PERM|FAN_ONDIR in the same mask as
> FAN_PRE_ACCESS (which it needs for files) so it will need to
> open another group for populating directories.
> 
> So that's why I would maybe consider this a last minute fix to the new API.

Yeah, this would be really a desperate way to get the functionality :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

