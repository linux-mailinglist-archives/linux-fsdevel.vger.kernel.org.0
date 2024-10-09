Return-Path: <linux-fsdevel+bounces-31428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789E39965DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 11:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4151C21253
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EBC18C91A;
	Wed,  9 Oct 2024 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j+mCq6vY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L+MgORri";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j+mCq6vY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L+MgORri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC92328EF;
	Wed,  9 Oct 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467350; cv=none; b=I7Eisqkjh4fUb277+4vjSkGeKgJ90HHSZjrTrEVtZUoDdj1qho4FgGWOKzB1h6Uyzsh8mGvA++LaQbYpmCTyJJMNEtFV/g+/99MYXtCxeREENzAwSEOmsQ6ut6vANrSkcAAYl15G3mYV9fJqaTTU2mYV060BZy8OQauWl94LA14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467350; c=relaxed/simple;
	bh=eh4BxI52PQAK5fm5qC88knwJADaCMCLFIaEWxNMBKoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roa6csdQkFxrEYpZDl7Y05Kb22zvB+k8I+DZ0ZDaczTHm+0GZZ/Y/hm8AQBLvYHnM1kSIQZco954UMd6SEr0Mb7Q4z8BMkcXNto3fwJ9m4OD943X8Dgfv/PIAuC0esPG1us2wmv23mMtvAgZ4y23iSKl/eUlxlIsmjoSfZj72q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j+mCq6vY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L+MgORri; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j+mCq6vY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L+MgORri; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 186DB1FB93;
	Wed,  9 Oct 2024 09:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728467347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i2qdj0Nc8sTi+dG8p4WXxx/mzAKRX5B8QIkHtbq6ptU=;
	b=j+mCq6vYSQXmGdJs1sZBPLyqdZvd0QBxNAJqW+0x87Qcgbt19i2gG+9A81/3++u6wRCU+9
	m7CB2sOSLYdz/Onx1ufSgH1PR8BMOu7rH82eksGdAao39CMrqX/NsylyMxb1XjYotyBv9/
	DTT6NEtE287SlTqaGbHpdLL5XCUMeEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728467347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i2qdj0Nc8sTi+dG8p4WXxx/mzAKRX5B8QIkHtbq6ptU=;
	b=L+MgORrigHEYPjH9RYa+KbOcnIOChPh03lkHOxD8n+7i9LfAQ0yCjEFp3Peds44o07gqtd
	XWVYh3K+gCbCmiCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728467347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i2qdj0Nc8sTi+dG8p4WXxx/mzAKRX5B8QIkHtbq6ptU=;
	b=j+mCq6vYSQXmGdJs1sZBPLyqdZvd0QBxNAJqW+0x87Qcgbt19i2gG+9A81/3++u6wRCU+9
	m7CB2sOSLYdz/Onx1ufSgH1PR8BMOu7rH82eksGdAao39CMrqX/NsylyMxb1XjYotyBv9/
	DTT6NEtE287SlTqaGbHpdLL5XCUMeEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728467347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i2qdj0Nc8sTi+dG8p4WXxx/mzAKRX5B8QIkHtbq6ptU=;
	b=L+MgORrigHEYPjH9RYa+KbOcnIOChPh03lkHOxD8n+7i9LfAQ0yCjEFp3Peds44o07gqtd
	XWVYh3K+gCbCmiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B7FB13A58;
	Wed,  9 Oct 2024 09:49:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ewvLApNRBmfwZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Oct 2024 09:49:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BA7A0A0851; Wed,  9 Oct 2024 11:49:06 +0200 (CEST)
Date: Wed, 9 Oct 2024 11:49:06 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <20241009094906.m3e2ye4oo7qhhbax@quack3>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area>
 <CAHk-=wi5ZpW73nLn5h46Jxcng6wn_bCUxj6JjxyyEMAGzF5KZg@mail.gmail.com>
 <CAHk-=wgW0RspdggU630JYUe5CyzNi5MHT4UEfx2+yZKoeezawg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgW0RspdggU630JYUe5CyzNi5MHT4UEfx2+yZKoeezawg@mail.gmail.com>
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
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fromorbit.com,suse.cz,infradead.org,vger.kernel.org,linux.dev,linux.microsoft.com,google.com,hallyn.com,chromium.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 07-10-24 17:54:16, Linus Torvalds wrote:
> On Mon, 7 Oct 2024 at 17:28, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And yes, this changes the timing on when fsnotify events happen, but
> > what I'm actually hoping for is that Jan will agree that it doesn't
> > actually matter semantically.
> 
> .. and yes, I realize it might actually matter. fsnotify does do
> 'ihold()' to hold an inode ref, and with this that would actually be
> more or less pointless, because the mark would be removed _despite_
> such a ref.
> 
> So maybe it's not an option to do what I suggested. I don't know the
> users well enough.

Yeah, we need to keep the notification mark alive either until the inode is
deleted or until the filesystem is unmounted to maintain behavior of
inotify and fanotify APIs.

That being said we could rework lifetime rules inside fsnotify subsystem as
Dave suggests so that fsnotify would not pin inodes, detach it's structures
from inodes on inode reclaim and associate notification marks with inodes
when they are loaded from disk.  But it's a relatively big overhaul.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

