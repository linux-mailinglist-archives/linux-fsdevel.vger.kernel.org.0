Return-Path: <linux-fsdevel+bounces-63503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A7ABBE834
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 17:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACDD3BDC60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8492D877B;
	Mon,  6 Oct 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j5sZlXBu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ofk75a3B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j5sZlXBu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ofk75a3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A12D73BB
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765196; cv=none; b=B0OYFMXeBZc4ftzJOPGm4lPIWpTYww9PLLRWo5kdCZsfauRzXOf02fp4H5PHPlyqu3W7YIib2xUxQnFNwP2ROy1eZl1eIU1yoJD4ty2HiehLcf33T4u9KNtmjTYYlQA3q8F0VYXTP+7IqzbsyNRbbtFKvpziXtMYNIpwmA8hkDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765196; c=relaxed/simple;
	bh=ama3Wf+FzOOqL29SQs0q73QNhx/M/49ONwjiktce0FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7XFpdzXVC3UHzPesarEI5ci+hmJKpKvRN9lpBBuFQJKBj1KKUDjUyG9Bf8SpavDMOh4qR9zWdak/pBGcBmR7mgptgUfh0R78t+NLTT9MceWOCUgeA/L5kizuZ1SadIj1IwFaCZ11gY+P+m8VPTexgQQUyf0O30syBStByoJsho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j5sZlXBu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ofk75a3B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j5sZlXBu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ofk75a3B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B08D33685;
	Mon,  6 Oct 2025 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759765191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5cMrfe4Mswv5iwXTNR0nUU42XbqIMSeF700oVgdzRc=;
	b=j5sZlXBuD6ENssugkER28jdA3cQMT/Eei5cvymv1Yj92NcY6u7ZIzPLPO27eDrePR9smTr
	ePHuOVfMhhkPFmRjv+ruIXQBup4bQKmoJS9/U6mUN8aWHXHNcqPRSDtPo2fRKU0iJ1qWSq
	s+dFB6JBO5DjU7kNQLuwq6d7sx63Y4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759765191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5cMrfe4Mswv5iwXTNR0nUU42XbqIMSeF700oVgdzRc=;
	b=ofk75a3BSTxpC0Uc3RKJT56aKe7FVin4gtK9DyKLxxi/Euw+xAkPV83GgZdZq7nkHA7t5x
	H2XcbDgY9KOIdTBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759765191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5cMrfe4Mswv5iwXTNR0nUU42XbqIMSeF700oVgdzRc=;
	b=j5sZlXBuD6ENssugkER28jdA3cQMT/Eei5cvymv1Yj92NcY6u7ZIzPLPO27eDrePR9smTr
	ePHuOVfMhhkPFmRjv+ruIXQBup4bQKmoJS9/U6mUN8aWHXHNcqPRSDtPo2fRKU0iJ1qWSq
	s+dFB6JBO5DjU7kNQLuwq6d7sx63Y4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759765191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5cMrfe4Mswv5iwXTNR0nUU42XbqIMSeF700oVgdzRc=;
	b=ofk75a3BSTxpC0Uc3RKJT56aKe7FVin4gtK9DyKLxxi/Euw+xAkPV83GgZdZq7nkHA7t5x
	H2XcbDgY9KOIdTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73B5113700;
	Mon,  6 Oct 2025 15:39:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cl08HMfi42h2MgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Oct 2025 15:39:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 03E7EA0ABF; Mon,  6 Oct 2025 17:39:46 +0200 (CEST)
Date: Mon, 6 Oct 2025 17:39:46 +0200
From: Jan Kara <jack@suse.cz>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 4/6] fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
Message-ID: <jp3vopwtpik7bj77aejuknaziecuml6x2l2dr3oe2xoats6tls@yskzvehakmkv>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org>
 <a622643f-1585-40b0-9441-cf7ece176e83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a622643f-1585-40b0-9441-cf7ece176e83@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,arndb.de,schaufler-ca.com,kernel.org,suse.cz,paul-moore.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 06-10-25 13:09:05, Jiri Slaby wrote:
> On 30. 06. 25, 18:20, Andrey Albershteyn wrote:
> > Future patches will add new syscalls which use these functions. As
> > this interface won't be used for ioctls only, the EOPNOSUPP is more
> > appropriate return code.
> > 
> > This patch converts return code from ENOIOCTLCMD to EOPNOSUPP for
> > vfs_fileattr_get and vfs_fileattr_set. To save old behavior translate
> > EOPNOSUPP back for current users - overlayfs, encryptfs and fs/ioctl.c.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ...
> > @@ -292,6 +294,8 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
> >   			fileattr_fill_flags(&fa, flags);
> >   			err = vfs_fileattr_set(idmap, dentry, &fa);
> >   			mnt_drop_write_file(file);
> > +			if (err == -EOPNOTSUPP)
> > +				err = -ENOIOCTLCMD;
> 
> This breaks borg code (unit tests already) as it expects EOPNOTSUPP, not
> ENOIOCTLCMD/ENOTTY:
> https://github.com/borgbackup/borg/blob/1c6ef7a200c7f72f8d1204d727fea32168616ceb/src/borg/platform/linux.pyx#L147
> 
> I.e. setflags now returns ENOIOCTLCMD/ENOTTY for cases where 6.16 used to
> return EOPNOTSUPP.
> 
> This minimal testcase program doing ioctl(fd2, FS_IOC_SETFLAGS,
> &FS_NODUMP_FL):
> https://github.com/jirislaby/collected_sources/tree/master/ioctl_setflags
> 
> dumps in 6.16:
> sf: ioctl: Operation not supported
> 
> with the above patch:
> sf: ioctl: Inappropriate ioctl for device
> 
> Is this expected?

No, that's a bug and a clear userspace regression so we need to fix it. I
think we need to revert this commit and instead convert ENOIOCTLCMD from
vfs_fileattr_get/set() to EOPNOTSUPP in appropriate places. Andrey?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

