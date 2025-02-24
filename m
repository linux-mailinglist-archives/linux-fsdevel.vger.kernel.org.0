Return-Path: <linux-fsdevel+bounces-42400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 342D5A41BC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 11:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44EA21896D49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421BC257AE0;
	Mon, 24 Feb 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pLCojCI6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mI6wHxTt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pLCojCI6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mI6wHxTt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8625744C
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394480; cv=none; b=p78nACNxO1maMC9PstNrMBaoaKU+XBArHz3KdrjEpeah6oPklNahEL8BehOn9a63FCWnt9yrmzfLjbDzsow7idHow9chebhlaEed+E2GX8bEdpbI+BW32No3a7A606mFmM5RE/ue6o1vCKOcjo3pG4Mx1A8VUGqk8SmtguLWDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394480; c=relaxed/simple;
	bh=167yThDNvGov9fjYCXY74PYz0T9DVf+w6k4ikUM5BsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEwpRUml1UNzoSLuOlB3xR76so34sq4+fv22Akam2rM6qTkHNnFAQafzK7/dDvNCspNIm4MG+baIygC0+vU2bh0Oc9aIrApD8lXPbbEfpo28YYbDDkB9/SNtTNhOxXrmHwh+ACwXMY6+7x9ITB7L6sUjHED0IXs87oYtJiFY8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pLCojCI6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mI6wHxTt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pLCojCI6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mI6wHxTt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BA3E21181;
	Mon, 24 Feb 2025 10:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740394474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIYv0/Q/Zeq48EvvOMQm6hO5YrgVHHe1Ef648QzRuwU=;
	b=pLCojCI6Ndh8FwupTNlbbixAqjYHuxtVBB/wAhSI2CLqc5jJkopVnCJxSWHzaCKQwe2dH4
	3x617lQVv51ilS4EsCYxVNEOhnsZqBjQfoVAZgBN29x/s5kbOz/dlsanhZegKzfgyXT5VC
	cRDnBMZ9oK3wXeYa4tXtE7DdF72F96o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740394474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIYv0/Q/Zeq48EvvOMQm6hO5YrgVHHe1Ef648QzRuwU=;
	b=mI6wHxTt5f/7/t2PAluzL2HfiTQQw6hI/kg92M+8rMU6W15iP4rnG9oxLReHFFId8HEKpr
	LHlaPGLupEhmG0Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740394474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIYv0/Q/Zeq48EvvOMQm6hO5YrgVHHe1Ef648QzRuwU=;
	b=pLCojCI6Ndh8FwupTNlbbixAqjYHuxtVBB/wAhSI2CLqc5jJkopVnCJxSWHzaCKQwe2dH4
	3x617lQVv51ilS4EsCYxVNEOhnsZqBjQfoVAZgBN29x/s5kbOz/dlsanhZegKzfgyXT5VC
	cRDnBMZ9oK3wXeYa4tXtE7DdF72F96o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740394474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIYv0/Q/Zeq48EvvOMQm6hO5YrgVHHe1Ef648QzRuwU=;
	b=mI6wHxTt5f/7/t2PAluzL2HfiTQQw6hI/kg92M+8rMU6W15iP4rnG9oxLReHFFId8HEKpr
	LHlaPGLupEhmG0Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7247113929;
	Mon, 24 Feb 2025 10:54:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cgroG+pPvGddfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Feb 2025 10:54:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 202B0A090D; Mon, 24 Feb 2025 11:54:34 +0100 (CET)
Date: Mon, 24 Feb 2025 11:54:34 +0100
From: Jan Kara <jack@suse.cz>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <fyp7gcbeo3xlrh7zi7k6m5aa6h5otbufxq3kh5zvgr3sjdbxl3@4nkuwx46yajk>
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
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
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,linux-m68k.org,monstr.eu,alpha.franken.de,hansenpartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,csgroup.eu,users.sourceforge.jp,libc.org,physik.fu-berlin.de,davemloft.net,gaisler.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,zankel.net,zeniv.linux.org.uk,suse.cz,digikod.net,google.com,arndb.de,vger.kernel.org,lists.infradead.org,lists.linux-m68k.org,lists.ozlabs.org];
	R_RATELIMIT(0.00)[to_ip_from(RLyerg7kx5bdf6cnfzf33td54o)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[56];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 11-02-25 18:22:47, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> extended attributes/flags. The syscalls take parent directory fd and
> path to the child together with struct fsxattr.
> 
> This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> that file don't need to be open as we can reference it with a path
> instead of fd. By having this we can manipulated inode extended
> attributes not only on regular files but also on special ones. This
> is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> we can not call ioctl() directly on the filesystem inode using fd.
> 
> This patch adds two new syscalls which allows userspace to get/set
> extended inode attributes on special files by using parent directory
> and a path - *at() like syscall.
> 
> Also, as vfs_fileattr_set() is now will be called on special files
> too, let's forbid any other attributes except projid and nextents
> (symlink can have an extent).
> 
> CC: linux-api@vger.kernel.org
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-xfs@vger.kernel.org
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>

Some comments below:

> +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
> +		struct fsxattr __user *, fsx, unsigned int, at_flags)
> +{
> +	CLASS(fd, dir)(dfd);
> +	struct fileattr fa;
> +	struct path filepath;
> +	int error;
> +	unsigned int lookup_flags = 0;
> +
> +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> +		return -EINVAL;
> +
> +	if (at_flags & AT_SYMLINK_FOLLOW)
	    ^^ This should be !(at_flags & AT_SYMLINK_NOFOLLOW)?

In the check above you verify for AT_SYMLINK_NOFOLLOW and that also matches
what setxattrat() does...


> +		lookup_flags |= LOOKUP_FOLLOW;
> +
> +	if (at_flags & AT_EMPTY_PATH)
> +		lookup_flags |= LOOKUP_EMPTY;
> +
> +	if (fd_empty(dir))
> +		return -EBADF;

This check is wrong and in fact the whole dfd handling looks buggy.
openat(2) manpage describes the expected behavior:

       The dirfd argument is used in conjunction with the pathname argument as
       follows:

       •  If the pathname given in pathname is absolute,  then  dirfd  is  ig-
          nored.
	  ^^^^ This is what you break. If the pathname is absolute, you're
not expected to touch dirfd.

       •  If  the pathname given in pathname is relative and dirfd is the spe-
          cial value AT_FDCWD, then pathname is interpreted  relative  to  the
          current working directory of the calling process (like open()).
          ^^^ Also AT_FDCWD handling would be broken by the above check.

       •  If  the  pathname  given  in pathname is relative, then it is inter-
          preted relative to the directory referred to by the file  descriptor
          dirfd  (rather than relative to the current working directory of the
          calling process, as is done by open() for a relative pathname).   In
          this  case,  dirfd  must  be a directory that was opened for reading
          (O_RDONLY) or using the O_PATH flag.

       If the pathname given in pathname is relative, and dirfd is not a valid
       file descriptor, an error (EBADF) results.  (Specifying an invalid file
       descriptor number in dirfd can be used as a means to ensure that  path-
       name is absolute.)

> +
> +	error = user_path_at(dfd, filename, lookup_flags, &filepath);
		^^^ And user_path_at() isn't quite what you need either
because with AT_EMPTY_PATH we also want to allow for filename to be NULL
(not just empty string) and user_path_at() does not support that. That's
why I in my previous replies suggested you should follow what setxattrat()
does and that sadly it is more painful than it should be. You need
something like:

	name = getname_maybe_null(filename, at_flags);
	if (!name) {
		CLASS(fd, f)(dfd);

		if (fd_empty(f))
			return -EBADF;
		error = vfs_fileattr_get(file_dentry(fd_file(f)), &fa);
	} else {
		error = filename_lookup(dfd, filename, lookup_flags, &filepath,
					NULL);
		if (error)
			goto out;
		error = vfs_fileattr_get(filepath.dentry, &fa);
		path_put(&filepath);
	}
	if (!error)
		error = copy_fsxattr_to_user(&fa, fsx);
out:
	putname(name);
	return error;

Longer term, we need to provide user_path_maybe_null_at() for this but I
don't want to drag you into this cleanup :)

> +	if (error)
> +		return error;
> +
> +	error = vfs_fileattr_get(filepath.dentry, &fa);
> +	if (!error)
> +		error = copy_fsxattr_to_user(&fa, fsx);
> +
> +	path_put(&filepath);
> +	return error;
> +}
> +
> +SYSCALL_DEFINE4(setfsxattrat, int, dfd, const char __user *, filename,
> +		struct fsxattr __user *, fsx, unsigned int, at_flags)
> +{
> +	CLASS(fd, dir)(dfd);
> +	struct fileattr fa;
> +	struct path filepath;
> +	int error;
> +	unsigned int lookup_flags = 0;
> +
> +	if ((at_flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
> +		return -EINVAL;
> +
> +	if (at_flags & AT_SYMLINK_FOLLOW)
> +		lookup_flags |= LOOKUP_FOLLOW;

I think using AT_SYMLINK_NOFOLLOW is actually more traditional and thus
less surprising to users so I'd prefer that. Definitely this needs to be
consistent with getfsxattrat().

> +
> +	if (at_flags & AT_EMPTY_PATH)
> +		lookup_flags |= LOOKUP_EMPTY;
> +
> +	if (fd_empty(dir))
> +		return -EBADF;

Same comment regarding dfd handling as above.

> +
> +	if (copy_fsxattr_from_user(&fa, fsx))
> +		return -EFAULT;
> +
> +	error = user_path_at(dfd, filename, lookup_flags, &filepath);
> +	if (error)
> +		return error;
> +
> +	error = mnt_want_write(filepath.mnt);
> +	if (!error) {
> +		error = vfs_fileattr_set(file_mnt_idmap(fd_file(dir)),
> +					 filepath.dentry, &fa);
> +		mnt_drop_write(filepath.mnt);
> +	}
> +
> +	path_put(&filepath);
> +	return error;
> +}

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

