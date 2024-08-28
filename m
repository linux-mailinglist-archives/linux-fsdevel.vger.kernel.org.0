Return-Path: <linux-fsdevel+bounces-27608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A370F962D10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324401F28493
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9DE1A38CF;
	Wed, 28 Aug 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gOaCqSEU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JqFSIOyf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ptoR9JjD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OaqWcSQb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF3A18756D;
	Wed, 28 Aug 2024 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860536; cv=none; b=hIAzfXC81jXUHdMxD/fxnT+0Ir0MokTToTGejSM4NtFlMnlwdCB0jtF9XEX1nmfvQtI6/wpZIMyPzxmdze1HjyAncIojdKu+YGWJJWd8pc/Tkf4HtdWppGjxJ8Kzwkfcu3POxiWXbfaEehGnE+WujfqpHHveqtvPYXQw/k/PtUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860536; c=relaxed/simple;
	bh=g5KSb/rAq0wxYfLd4pbiTKSVctpoLfIw3vmFC/rsdEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PM1SAtAUa/axMbRPP6ar7/fUv9qM1l7wDbHWhU5rD8yHoV9IZk4NDtXlnhNqdZlBLpOANGwyA35SnybXWp0C4/SR2a1BTIeKw9WVwFlLpN4l4r6jbGyElzvjbPNrTChX63M51raoKW6L4WBfjejsJ7Kf1StsE5n6koghzc4bcoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gOaCqSEU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JqFSIOyf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ptoR9JjD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OaqWcSQb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EECD421B56;
	Wed, 28 Aug 2024 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724860533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OumT4LXhMNMvt3fvcVjKWF7rpEkQKRFBU4Qj7F/uB4=;
	b=gOaCqSEU3RFS9UL0qGE5CIcPeG+AB71y4Gnjp5FCgpghVzci3vtNS18QLAvkY0uSm5JkJb
	c/mGcpuqMXkr+gX89CdtR6+1EYBfUVotKRAtH8/cZst7lX1I8eke4hUr5K6JuYCwHO8vIB
	c0/dNW25cDZSvDF+kWkEf8QsRXvQTwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724860533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OumT4LXhMNMvt3fvcVjKWF7rpEkQKRFBU4Qj7F/uB4=;
	b=JqFSIOyfto9M1t4cmDZg7ECPeb/hc4kkVbEqGccLwRHc7q5/PK9mSgY27dpnsXYhn6Y9/H
	dKeEMwEAWWz4y4Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724860532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OumT4LXhMNMvt3fvcVjKWF7rpEkQKRFBU4Qj7F/uB4=;
	b=ptoR9JjDya/RUILLHbsej+hAF2Y46m/kiJo7IQ6Ccq39un92LA3/et2I+Ysv1lmFE0MrIv
	aIxjRewasJkMAfxnu1ZKyauHgHWR3hG5Gl3xSdX/TOwQg8jaBEvNO5ZK/nJfl+ldeOyMdh
	t3x/h1Zi3BXQ+Dg00Jd0uaG5wBVYAZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724860532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OumT4LXhMNMvt3fvcVjKWF7rpEkQKRFBU4Qj7F/uB4=;
	b=OaqWcSQb8JRM5jRBXXQCix0Dpw2RNu7u2/6U7CqFiDgCm3mCYLzQ2JOO6htlSPf1MTQYvW
	btUuKuBjRiVXgaDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6DDA138D2;
	Wed, 28 Aug 2024 15:55:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eApuNHRIz2a5WQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 15:55:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9155CA0965; Wed, 28 Aug 2024 17:55:28 +0200 (CEST)
Date: Wed, 28 Aug 2024 17:55:28 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>, jack@suse.cz,
	viro@zeniv.linux.org.uk, gnoack@google.com, mic@digikod.net,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <20240828155528.77lz5l7pmwj5sgsc@quack3>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
 <20240827021300.GK6043@frogsfrogsfrogs>
 <1183f4ae-4157-4cda-9a56-141708c128fe@huawei.com>
 <20240827053712.GL6043@frogsfrogsfrogs>
 <20240827-abmelden-erbarmen-775c12ce2ae5@brauner>
 <20240827171148.GN6043@frogsfrogsfrogs>
 <Zs636Wi+UKAEU2F4@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs636Wi+UKAEU2F4@dread.disaster.area>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 28-08-24 15:38:49, Dave Chinner wrote:
> On Tue, Aug 27, 2024 at 10:11:48AM -0700, Darrick J. Wong wrote:
> > On Tue, Aug 27, 2024 at 11:22:17AM +0200, Christian Brauner wrote:
> > > On Mon, Aug 26, 2024 at 10:37:12PM GMT, Darrick J. Wong wrote:
> > > > On Tue, Aug 27, 2024 at 10:32:38AM +0800, Hongbo Li wrote:
> > > > > 
> > > > > 
> > > > > On 2024/8/27 10:13, Darrick J. Wong wrote:
> > > > > > On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
> > > > > > > Many mainstream file systems already support the GETVERSION ioctl,
> > > > > > > and their implementations are completely the same, essentially
> > > > > > > just obtain the value of i_generation. We think this ioctl can be
> > > > > > > implemented at the VFS layer, so the file systems do not need to
> > > > > > > implement it individually.
> > > > > > 
> > > > > > What if a filesystem never touches i_generation?  Is it ok to advertise
> > > > > > a generation number of zero when that's really meaningless?  Or should
> > > > > > we gate the generic ioctl on (say) whether or not the fs implements file
> > > > > > handles and/or supports nfs?
> > > > > 
> > > > > This ioctl mainly returns the i_generation, and whether it has meaning is up
> > > > > to the specific file system. Some tools will invoke IOC_GETVERSION, such as
> > > > > `lsattr -v`(but if it's lattr, it won't), but users may not necessarily
> > > > > actually use this value.
> > > > 
> > > > That's not how that works.  If the kernel starts exporting a datum,
> > > > people will start using it, and then the expectation that it will
> > > > *continue* to work becomes ingrained in the userspace ABI forever.
> > > > Be careful about establishing new behaviors for vfat.
> > > 
> > > Is the meaning even the same across all filesystems? And what is the
> > > meaning of this anyway? Is this described/defined for userspace
> > > anywhere?
> > 
> > AFAICT there's no manpage so I guess we could return getrandom32() if we
> > wanted to. ;)
> > 
> > But in seriousness, the usual four filesystems return i_generation.
> 
> We do? 
> 
> I thought we didn't expose it except via bulkstat (which requires
> CAP_SYS_ADMIN in the initns).
> 
> /me goes looking
> 
> Ugh. Well, there you go. I've been living a lie for 20 years.
> 
> > That is changed every time an inumber gets reused so that anyone with an
> > old file handle cannot accidentally open the wrong file.  In theory one
> > could use GETVERSION to construct file handles
> 
> Not theory. We've been constructing XFS filehandles in -privileged-
> userspace applications since the late 90s. Both DMAPI applications
> (HSMs) and xfsdump do this in combination with bulkstat to retreive
> the generation to enable full filesystem access without directory
> traversal being necessary.
> 
> I was completely unaware that FS_IOC_GETVERSION was implemented by
> XFS and so this information is available to unprivileged users...
> 
> > (if you do, UHLHAND!)
> 
> Not familiar with that acronym.
> 
> > instead of using name_to_handle_at, which is why it's dangerous to
> > implement GETVERSION for everyone without checking if i_generation makes
> > sense.
> 
> Yup. If you have predictable generation numbers then it's trivial to
> guess filehandles once you know the inode number. Exposing
> generation numbers to unprivileged users allows them to determine if
> the generation numbers are predictable. Determining patterns is
> often as simple as a loop doing open(create); get inode number +
> generation; unlink().

As far as VFS goes, we have always assumed that a valid file handles can be
easily forged by unpriviledged userspace and hence all syscalls taking file
handle are gated by CAP_DAC_READ_SEARCH capability check. That means
userspace can indeed create a valid file handle but unless the process has
sufficient priviledges to crawl the whole filesystem, VFS will not allow it
to do anything special with it.

I don't know what XFS interfaces use file handles and what are the
permission requirements there but effectively relying on a 32-bit cookie
value for security seems like a rather weak security these days to me...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

