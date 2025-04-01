Return-Path: <linux-fsdevel+bounces-45423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18208A77878
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17CE16BA94
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3321F0994;
	Tue,  1 Apr 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PYY8ydHB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LKmuADDT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PYY8ydHB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LKmuADDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39C1EFFB9
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502109; cv=none; b=GZ0/+93jDSD5HWGCuY5bqoXkxuJbF3Z69cuo3Y5zbm4mpI9tZsOaYWrng2kCqGDfjjT1a24jRRYyLtcOEQBOWYEr8Zm9P0mWqfOCa8KOHwTz9nMDSx639YdxUUBjspfuJfTqx5lxYSGmNXKoEatj49pZrkqcavlQBNvUjbPJqKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502109; c=relaxed/simple;
	bh=++urWKNC5cfWd08urLWmZ0ardJRYr+sbgQ55JmwHDrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCpMSWg1BpNdgaZj0yUdPltcF0DS2HuHXxJD4FMhJZucBwJ0aX6cIxf4J2W2bgG2pVNKX8ewIKBU/xloDRz6vftGd4rBWW+HkGZAfhtmjZU7befCWT43gfVJK9Jx5rvf7IpNTuZzIEyVOpW2Podi0xY8y0SZ0n0nyXhsoVODLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PYY8ydHB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LKmuADDT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PYY8ydHB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LKmuADDT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 15CEF1F38E;
	Tue,  1 Apr 2025 10:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743502105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=suSfpVgBId8IpI/9A13Qm+aO2xaK6bvk0WIrZ6mJqfA=;
	b=PYY8ydHB/BRKkb/f3uJZM9WIn6uy/Nfx8TSP6hkW5iebHUuThEl8ebraeZsLbQ6sE/aQ/a
	Q7OnyH7q+A2YF3dxvliPf9T0+yFPLqHXsNgc3h+o+p94GlxdiZDmy0LzB5RJmi0CsTqcqv
	hNOmIXk6ftY7zJWt39c1JHaPRMEFt0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743502105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=suSfpVgBId8IpI/9A13Qm+aO2xaK6bvk0WIrZ6mJqfA=;
	b=LKmuADDTSRI+wAfkOuD8IZKmzy14iQ//uKy8wxs4aZxgA3/E+p7wAEUCDZxwDoe5qKImX0
	wRx/yN98+xBVuFBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743502105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=suSfpVgBId8IpI/9A13Qm+aO2xaK6bvk0WIrZ6mJqfA=;
	b=PYY8ydHB/BRKkb/f3uJZM9WIn6uy/Nfx8TSP6hkW5iebHUuThEl8ebraeZsLbQ6sE/aQ/a
	Q7OnyH7q+A2YF3dxvliPf9T0+yFPLqHXsNgc3h+o+p94GlxdiZDmy0LzB5RJmi0CsTqcqv
	hNOmIXk6ftY7zJWt39c1JHaPRMEFt0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743502105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=suSfpVgBId8IpI/9A13Qm+aO2xaK6bvk0WIrZ6mJqfA=;
	b=LKmuADDTSRI+wAfkOuD8IZKmzy14iQ//uKy8wxs4aZxgA3/E+p7wAEUCDZxwDoe5qKImX0
	wRx/yN98+xBVuFBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 043E9138A5;
	Tue,  1 Apr 2025 10:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XomxABm762cjDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Apr 2025 10:08:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AAF3FA07E6; Tue,  1 Apr 2025 12:08:24 +0200 (CEST)
Date: Tue, 1 Apr 2025 12:08:24 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 1/6] ext4: replace kthread freezing with auto fs freezing
Message-ID: <2nqlkokmbkvamnrza3fpjjmye3w3fy7gf5bqpjt2cxeviks5ax@u4wqm4ldxuy6>
References: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <20250401-work-freeze-v1-1-d000611d4ab0@kernel.org>
 <z3zqumhqgzq3agjps4ufdcqqrgip7t7xtr6v5kymchkdjfnwhp@i76pwshkydig>
 <20250401-konsens-nahebringen-fa1c80956371@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401-konsens-nahebringen-fa1c80956371@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kernel.org,hansenpartnership.com,infradead.org,fromorbit.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Tue 01-04-25 11:35:56, Christian Brauner wrote:
> On Tue, Apr 01, 2025 at 11:16:18AM +0200, Jan Kara wrote:
> > > ---
> > >  fs/ext4/mballoc.c | 2 +-
> > >  fs/ext4/super.c   | 3 ---
> > >  2 files changed, 1 insertion(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > index 0d523e9fb3d5..ae235ec5ff3a 100644
> > > --- a/fs/ext4/mballoc.c
> > > +++ b/fs/ext4/mballoc.c
> > > @@ -6782,7 +6782,7 @@ static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
> > >  
> > >  static bool ext4_trim_interrupted(void)
> > >  {
> > > -	return fatal_signal_pending(current) || freezing(current);
> > > +	return fatal_signal_pending(current);
> > >  }
> > 
> > This change should not happen. ext4_trim_interrupted() makes sure FITRIM
> > ioctl doesn't cause hibernation failures and has nothing to do with kthread
> > freezing...
> > 
> > Otherwise the patch looks good.
> 
> Afaict, we don't have to do these changes now. Yes, once fsfreeze
> reliably works in the suspend/resume codepaths then we can switch all
> that off and remove the old freezer. But we should only do that once we
> have some experience with the new filesystem freezing during
> suspend/hibernate. So we should place this under a
> /sys/power/freeze_filesystems knob and wait a few kernel releases to see
> whether we see significant problems. How does that sound to you?

I agree that enabling this with some knob to allow easy way out if things
don't work makes sense. And the removal of kthread freezing can be done
somewhat later when we are more confident filesystem freezing on
hibernation is solid.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

