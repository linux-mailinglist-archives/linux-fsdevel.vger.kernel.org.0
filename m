Return-Path: <linux-fsdevel+bounces-47082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6DEA98687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 11:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E854C3B72F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FD9268FC2;
	Wed, 23 Apr 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MkBnnBgU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JV9vpkpW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MkBnnBgU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JV9vpkpW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F487269880
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402010; cv=none; b=GKBGI569WbB9AaT4OOUuiXlXzZYCg1iZAKlIhichzJzVSqYFNGMUQt7RTnjI/eIWDKgJVsRkdwBxWBB2myhYmtiWcsGDjjIRY5/i1crLvf7QHv2G9auUX4CIiGtxHjQTPLapEijoveECr5oCGKgqqAlJlbAD9GJv/CGLMwDtt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402010; c=relaxed/simple;
	bh=EUt9Pc3d/cQ830Ysfg1KDOqUA0z0jpWmWw3HLSWOSdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQ2gL7VTH1eXhmlIAj9UwV2OJxqXW0qFUAwpOTU6954mGQaQOHT5Z8IDTSuplm3VBGaZA8BNCg9txnYSzlyml6cPrG37IomiA7eYQNlaRI+W1Gkj9CQHQRhG+pu3e0zFKvJM9XUnBG+J26BZbsFrHvCZrBO5E2QbHqIqgQ+H/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MkBnnBgU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JV9vpkpW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MkBnnBgU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JV9vpkpW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 53EC121192;
	Wed, 23 Apr 2025 09:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745402006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bAMJg+22aX8wNXOVQU/q0Slu5K2ETQkFa+MaYS1q1Aw=;
	b=MkBnnBgUY4DejLxyqWELETbhQDSZbHRBCNcJ2SL2jANKjsmepr5ez71Lc+6XleLSZfpZrU
	TZVIrwAG2mGYIiL+u5itSCcJjvabGWmDlypht/2m5b4xnKMjA73DuYr+ZRRUAYxQRyrlLB
	7MnS/Z/KvF6Q+pV3yLCv4FTBynvtKsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745402006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bAMJg+22aX8wNXOVQU/q0Slu5K2ETQkFa+MaYS1q1Aw=;
	b=JV9vpkpWivR2j2l2iOWTdS74vSAmYn3ZCfrfQCySD6Ap21BM7ulYL6yd2KEBTFx0uVIzmS
	IUaaLaSNx/k8B8DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745402006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bAMJg+22aX8wNXOVQU/q0Slu5K2ETQkFa+MaYS1q1Aw=;
	b=MkBnnBgUY4DejLxyqWELETbhQDSZbHRBCNcJ2SL2jANKjsmepr5ez71Lc+6XleLSZfpZrU
	TZVIrwAG2mGYIiL+u5itSCcJjvabGWmDlypht/2m5b4xnKMjA73DuYr+ZRRUAYxQRyrlLB
	7MnS/Z/KvF6Q+pV3yLCv4FTBynvtKsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745402006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bAMJg+22aX8wNXOVQU/q0Slu5K2ETQkFa+MaYS1q1Aw=;
	b=JV9vpkpWivR2j2l2iOWTdS74vSAmYn3ZCfrfQCySD6Ap21BM7ulYL6yd2KEBTFx0uVIzmS
	IUaaLaSNx/k8B8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3548813A6A;
	Wed, 23 Apr 2025 09:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pUq5DJa4CGhWFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Apr 2025 09:53:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BEC8BA07A7; Wed, 23 Apr 2025 11:53:25 +0200 (CEST)
Date: Wed, 23 Apr 2025 11:53:25 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] fs: introduce getfsxattrat and setfsxattrat
 syscalls
Message-ID: <rbzlwvecvrp4xawwp5nywdq6wp5hgjhrtrabpszv74xmfqbj4f@x7v6eqfc5gcd>
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
 <20250321-xattrat-syscall-v4-3-3e82e6fb3264@kernel.org>
 <20250422-abbekommen-begierde-bcf48dd74a2e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422-abbekommen-begierde-bcf48dd74a2e@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,linux-m68k.org,monstr.eu,alpha.franken.de,hansenpartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,csgroup.eu,users.sourceforge.jp,libc.org,physik.fu-berlin.de,davemloft.net,gaisler.com,linutronix.de,alien8.de,linux.intel.com,zytor.com,zankel.net,zeniv.linux.org.uk,suse.cz,digikod.net,google.com,arndb.de,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,lists.infradead.org,lists.linux-m68k.org,lists.ozlabs.org];
	R_RATELIMIT(0.00)[to_ip_from(RLyerg7kx5bdf6cnfzf33td54o)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[60];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 22-04-25 16:59:02, Christian Brauner wrote:
> On Fri, Mar 21, 2025 at 08:48:42PM +0100, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> > extended attributes/flags. The syscalls take parent directory fd and
> > path to the child together with struct fsxattr.
> > 
> > This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> > that file don't need to be open as we can reference it with a path
> > instead of fd. By having this we can manipulated inode extended
> > attributes not only on regular files but also on special ones. This
> > is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> > we can not call ioctl() directly on the filesystem inode using fd.
> > 
> > This patch adds two new syscalls which allows userspace to get/set
> > extended inode attributes on special files by using parent directory
> > and a path - *at() like syscall.
> > 
> > CC: linux-api@vger.kernel.org
> > CC: linux-fsdevel@vger.kernel.org
> > CC: linux-xfs@vger.kernel.org
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
...
> > +		struct fsxattr __user *, ufsx, size_t, usize,
> > +		unsigned int, at_flags)
> > +{
> > +	struct fileattr fa = {};
> > +	struct path filepath;
> > +	int error;
> > +	unsigned int lookup_flags = 0;
> > +	struct filename *name;
> > +	struct fsxattr fsx = {};
> > +
> > +	BUILD_BUG_ON(sizeof(struct fsxattr) < FSXATTR_SIZE_VER0);
> > +	BUILD_BUG_ON(sizeof(struct fsxattr) != FSXATTR_SIZE_LATEST);
> > +
> > +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> > +		return -EINVAL;
> > +
> > +	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> > +		lookup_flags |= LOOKUP_FOLLOW;
> > +
> > +	if (at_flags & AT_EMPTY_PATH)
> > +		lookup_flags |= LOOKUP_EMPTY;
> > +
> > +	if (usize > PAGE_SIZE)
> > +		return -E2BIG;
> > +
> > +	if (usize < FSXATTR_SIZE_VER0)
> > +		return -EINVAL;
> > +
> > +	name = getname_maybe_null(filename, at_flags);
> > +	if (!name) {
> 
> This is broken as it doesn't handle AT_FDCWD correctly. You need:
> 
>         name = getname_maybe_null(filename, at_flags);
>         if (IS_ERR(name))
>                 return PTR_ERR(name);
> 
>         if (!name && dfd >= 0) {
> 		CLASS(fd, f)(dfd);

Ah, you're indeed right that if dfd == AT_FDCWD and filename == NULL, the
we should operate on cwd but we'd bail with error here. I've missed that
during my review. But as far as I've checked the same bug is there in
path_setxattrat() and path_getxattrat() so we should fix this there as
well?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

