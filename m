Return-Path: <linux-fsdevel+bounces-75852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEDrLNFTe2nRDwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 13:34:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1380DB0164
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 13:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4E0D3021716
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 12:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CF238757E;
	Thu, 29 Jan 2026 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEi2QULl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8661F3803CD;
	Thu, 29 Jan 2026 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769690039; cv=none; b=bj5eI8dNN9pAX0s+5x3z4FH5/ZKLhYwoorQufj8U6YqaYrCyOxNTKeMTF10HcBT5On2nliPaiJJ+KcoLXrpyb4MNsT6rHSEsDeCZnHvuOtlaKfIDh3tlqsfGCllhpIWBEx9+v+fBdUx2hHyY7vQ2duihgt3NMvWJumvfxUIjy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769690039; c=relaxed/simple;
	bh=T8LVKAlG2mPj51Ja7GkX2ymwn24dcWsRdg6iMR6aEpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZypCvGXuNzbhVm2nIjNqDGLnXgJ7NkqN4F44cexXXgoqMqCvFCIKXgIxlHRexvGvk1/D9jC4G/lCVQMXE9V3LjsojVmdAEOV45T53wplGBKQkYsE20QSFT0hFtWAEzBlkG0520pdQToru6KtI/kDdgyw4dKss59cgc+fGBPm+R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEi2QULl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C1FC4CEF7;
	Thu, 29 Jan 2026 12:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769690039;
	bh=T8LVKAlG2mPj51Ja7GkX2ymwn24dcWsRdg6iMR6aEpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rEi2QULlowEU+wI8AfywhHuJvH3ONnbnSAgBNe7kreU6GeEsNv0kgjc3AtF5Q+41W
	 IgQYqOpZnI5t/xYNE0DwlnijUPmtruFFPxVy6/rQSPW8EoFekSa+ks/X24DP5L09zM
	 yXCco1hr5M9o3eZSc90njSV01KOMsthGqkvEOHBSt/U2do/+lr2cExf76CcxjfKSrf
	 MUe38DjbYQkuh/3f+vjRv9IHz6TnPPdJquJ0OvVtXD+GMx4gXfCChIG9E5ECnNtzCV
	 vFRLZ57Px/rUodxoay3MA7o+HGkhfSZU746nqyYT9dS54dJctRgB0gNUmybUlGEHKi
	 8Jb//y6dOQadw==
Date: Thu, 29 Jan 2026 13:33:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
Message-ID: <20260129-tierwelt-wahlabend-2cb470bcb707@brauner>
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
 <20260127180109.66691-2-dorjoychy111@gmail.com>
 <1c6cccc3e058ef16fa8b296ef6126b76a12db136.camel@kernel.org>
 <CAFfO_h5yrXR0-igVayH0ent1t12rm=6DUEGjUDW0zqfqy3=ZoQ@mail.gmail.com>
 <b6749fa99a728189e745f1769140be3ac8950af5.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6749fa99a728189e745f1769140be3ac8950af5.camel@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75852-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,arndb.de,dilger.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1380DB0164
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:51:07AM -0500, Jeff Layton wrote:
> On Wed, 2026-01-28 at 21:36 +0600, Dorjoy Chowdhury wrote:
> > On Wed, Jan 28, 2026 at 5:52 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > 
> > > On Tue, 2026-01-27 at 23:58 +0600, Dorjoy Chowdhury wrote:
> > > > This flag indicates the path should be opened if it's a regular file.
> > > > This is useful to write secure programs that want to avoid being tricked
> > > > into opening device nodes with special semantics while thinking they
> > > > operate on regular files.
> > > > 
> > > > A corresponding error code ENOTREG has been introduced. For example, if
> > > > open is called on path /dev/null with O_REGULAR in the flag param, it
> > > > will return -ENOTREG.
> > > > 
> > > > When used in combination with O_CREAT, either the regular file is
> > > > created, or if the path already exists, it is opened if it's a regular
> > > > file. Otherwise, -ENOTREG is returned.
> > > > 
> > > > -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (not
> > > > part of O_TMPFILE) because it doesn't make sense to open a path that
> > > > is both a directory and a regular file.
> > > > 
> > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > ---
> > > >  arch/alpha/include/uapi/asm/errno.h        | 2 ++
> > > >  arch/alpha/include/uapi/asm/fcntl.h        | 1 +
> > > >  arch/mips/include/uapi/asm/errno.h         | 2 ++
> > > >  arch/parisc/include/uapi/asm/errno.h       | 2 ++
> > > >  arch/parisc/include/uapi/asm/fcntl.h       | 1 +
> > > >  arch/sparc/include/uapi/asm/errno.h        | 2 ++
> > > >  arch/sparc/include/uapi/asm/fcntl.h        | 1 +
> > > >  fs/fcntl.c                                 | 2 +-
> > > >  fs/namei.c                                 | 6 ++++++
> > > >  fs/open.c                                  | 4 +++-
> > > >  include/linux/fcntl.h                      | 2 +-
> > > >  include/uapi/asm-generic/errno.h           | 2 ++
> > > >  include/uapi/asm-generic/fcntl.h           | 4 ++++
> > > >  tools/arch/alpha/include/uapi/asm/errno.h  | 2 ++
> > > >  tools/arch/mips/include/uapi/asm/errno.h   | 2 ++
> > > >  tools/arch/parisc/include/uapi/asm/errno.h | 2 ++
> > > >  tools/arch/sparc/include/uapi/asm/errno.h  | 2 ++
> > > >  tools/include/uapi/asm-generic/errno.h     | 2 ++
> > > >  18 files changed, 38 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uapi/asm/errno.h
> > > > index 6791f6508632..8bbcaa9024f9 100644
> > > > --- a/arch/alpha/include/uapi/asm/errno.h
> > > > +++ b/arch/alpha/include/uapi/asm/errno.h
> > > > @@ -127,4 +127,6 @@
> > > > 
> > > >  #define EHWPOISON    139     /* Memory page has hardware error */
> > > > 
> > > > +#define ENOTREG              140     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
> > > > index 50bdc8e8a271..4da5a64c23bd 100644
> > > > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > > > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > > > @@ -34,6 +34,7 @@
> > > > 
> > > >  #define O_PATH               040000000
> > > >  #define __O_TMPFILE  0100000000
> > > > +#define O_REGULAR    0200000000
> > > > 
> > > >  #define F_GETLK              7
> > > >  #define F_SETLK              8
> > > > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/asm/errno.h
> > > > index c01ed91b1ef4..293c78777254 100644
> > > > --- a/arch/mips/include/uapi/asm/errno.h
> > > > +++ b/arch/mips/include/uapi/asm/errno.h
> > > > @@ -126,6 +126,8 @@
> > > > 
> > > >  #define EHWPOISON    168     /* Memory page has hardware error */
> > > > 
> > > > +#define ENOTREG              169     /* Not a regular file */
> > > > +
> > > >  #define EDQUOT               1133    /* Quota exceeded */
> > > > 
> > > > 
> > > > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
> > > > index 8cbc07c1903e..442917484f99 100644
> > > > --- a/arch/parisc/include/uapi/asm/errno.h
> > > > +++ b/arch/parisc/include/uapi/asm/errno.h
> > > > @@ -124,4 +124,6 @@
> > > > 
> > > >  #define EHWPOISON    257     /* Memory page has hardware error */
> > > > 
> > > > +#define ENOTREG              258     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
> > > > index 03dee816cb13..0cc3320fe326 100644
> > > > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > > > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > > > @@ -19,6 +19,7 @@
> > > > 
> > > >  #define O_PATH               020000000
> > > >  #define __O_TMPFILE  040000000
> > > > +#define O_REGULAR    0100000000
> > > > 
> > > >  #define F_GETLK64    8
> > > >  #define F_SETLK64    9
> > > > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uapi/asm/errno.h
> > > > index 4a41e7835fd5..8dce0bfeab74 100644
> > > > --- a/arch/sparc/include/uapi/asm/errno.h
> > > > +++ b/arch/sparc/include/uapi/asm/errno.h
> > > > @@ -117,4 +117,6 @@
> > > > 
> > > >  #define EHWPOISON    135     /* Memory page has hardware error */
> > > > 
> > > > +#define ENOTREG              136     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
> > > > index 67dae75e5274..a93d18d2c23e 100644
> > > > --- a/arch/sparc/include/uapi/asm/fcntl.h
> > > > +++ b/arch/sparc/include/uapi/asm/fcntl.h
> > > > @@ -37,6 +37,7 @@
> > > > 
> > > >  #define O_PATH               0x1000000
> > > >  #define __O_TMPFILE  0x2000000
> > > > +#define O_REGULAR    0x4000000
> > > > 
> > > >  #define F_GETOWN     5       /*  for sockets. */
> > > >  #define F_SETOWN     6       /*  for sockets. */
> > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > index f93dbca08435..62ab4ad2b6f5 100644
> > > > --- a/fs/fcntl.c
> > > > +++ b/fs/fcntl.c
> > > > @@ -1169,7 +1169,7 @@ static int __init fcntl_init(void)
> > > >        * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
> > > >        * is defined as O_NONBLOCK on some platforms and not on others.
> > > >        */
> > > > -     BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=
> > > > +     BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
> > > >               HWEIGHT32(
> > > >                       (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
> > > >                       __FMODE_EXEC));
> > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > index b28ecb699f32..f5504ae4b03c 100644
> > > > --- a/fs/namei.c
> > > > +++ b/fs/namei.c
> > > > @@ -4616,6 +4616,10 @@ static int do_open(struct nameidata *nd,
> > > >               if (unlikely(error))
> > > >                       return error;
> > > >       }
> > > > +
> > > > +     if ((open_flag & O_REGULAR) && !d_is_reg(nd->path.dentry))
> > > > +             return -ENOTREG;
> > > > +
> > > >       if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
> > > >               return -ENOTDIR;
> > > > 
> > > > @@ -4765,6 +4769,8 @@ static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
> > > >       struct path path;
> > > >       int error = path_lookupat(nd, flags, &path);
> > > >       if (!error) {
> > > > +             if ((file->f_flags & O_REGULAR) && !d_is_reg(path.dentry))
> > > > +                     return -ENOTREG;
> > > >               audit_inode(nd->name, path.dentry, 0);
> > > >               error = vfs_open(&path, file);
> > > >               path_put(&path);
> > > > diff --git a/fs/open.c b/fs/open.c
> > > > index 74c4c1462b3e..82153e21907e 100644
> > > > --- a/fs/open.c
> > > > +++ b/fs/open.c
> > > > @@ -1173,7 +1173,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
> > > >  EXPORT_SYMBOL_GPL(kernel_file_open);
> > > > 
> > > >  #define WILL_CREATE(flags)   (flags & (O_CREAT | __O_TMPFILE))
> > > > -#define O_PATH_FLAGS         (O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
> > > > +#define O_PATH_FLAGS         (O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | O_REGULAR)
> > > > 
> > > >  inline struct open_how build_open_how(int flags, umode_t mode)
> > > >  {
> > > > @@ -1250,6 +1250,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
> > > >                       return -EINVAL;
> > > >               if (!(acc_mode & MAY_WRITE))
> > > >                       return -EINVAL;
> > > > +     } else if ((flags & O_DIRECTORY) && (flags & O_REGULAR)) {
> > > > +             return -EINVAL;
> > > >       }
> > > >       if (flags & O_PATH) {
> > > >               /* O_PATH only permits certain other flags to be set. */
> > > > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > > > index a332e79b3207..4fd07b0e0a17 100644
> > > > --- a/include/linux/fcntl.h
> > > > +++ b/include/linux/fcntl.h
> > > > @@ -10,7 +10,7 @@
> > > >       (O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
> > > >        O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
> > > >        FASYNC | O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> > > > -      O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> > > > +      O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_REGULAR)
> > > > 
> > > >  /* List of all valid flags for the how->resolve argument: */
> > > >  #define VALID_RESOLVE_FLAGS \
> > > > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
> > > > index 92e7ae493ee3..2216ab9aa32e 100644
> > > > --- a/include/uapi/asm-generic/errno.h
> > > > +++ b/include/uapi/asm-generic/errno.h
> > > > @@ -122,4 +122,6 @@
> > > > 
> > > >  #define EHWPOISON    133     /* Memory page has hardware error */
> > > > 
> > > > +#define ENOTREG              134     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> > > > index 613475285643..3468b352a575 100644
> > > > --- a/include/uapi/asm-generic/fcntl.h
> > > > +++ b/include/uapi/asm-generic/fcntl.h
> > > > @@ -88,6 +88,10 @@
> > > >  #define __O_TMPFILE  020000000
> > > >  #endif
> > > > 
> > > > +#ifndef O_REGULAR
> > > > +#define O_REGULAR    040000000
> > > > +#endif
> > > > +
> > > >  /* a horrid kludge trying to make sure that this will fail on old kernels */
> > > >  #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
> > > > 
> > > > diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha/include/uapi/asm/errno.h
> > > > index 6791f6508632..8bbcaa9024f9 100644
> > > > --- a/tools/arch/alpha/include/uapi/asm/errno.h
> > > > +++ b/tools/arch/alpha/include/uapi/asm/errno.h
> > > > @@ -127,4 +127,6 @@
> > > > 
> > > >  #define EHWPOISON    139     /* Memory page has hardware error */
> > > > 
> > > > +#define ENOTREG              140     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/include/uapi/asm/errno.h
> > > > index c01ed91b1ef4..293c78777254 100644
> > > > --- a/tools/arch/mips/include/uapi/asm/errno.h
> > > > +++ b/tools/arch/mips/include/uapi/asm/errno.h
> > > > @@ -126,6 +126,8 @@
> > > > 
> > > >  #define EHWPOISON    168     /* Memory page has hardware error */
> > > > 
> > > > +#define ENOTREG              169     /* Not a regular file */
> > > > +
> > > >  #define EDQUOT               1133    /* Quota exceeded */
> > > > 
> > > > 
> > > > diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
> > > > index 8cbc07c1903e..442917484f99 100644
> > > > --- a/tools/arch/parisc/include/uapi/asm/errno.h
> > > > +++ b/tools/arch/parisc/include/uapi/asm/errno.h
> > > > @@ -124,4 +124,6 @@
> > > > 
> > > >  #define EHWPOISON    257     /* Memory page has hardware error */
> > > > 
> > > > +#define ENOTREG              258     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc/include/uapi/asm/errno.h
> > > > index 4a41e7835fd5..8dce0bfeab74 100644
> > > > --- a/tools/arch/sparc/include/uapi/asm/errno.h
> > > > +++ b/tools/arch/sparc/include/uapi/asm/errno.h
> > > > @@ -117,4 +117,6 @@
> > > > 
> > > >  #define EHWPOISON    135     /* Memory page has hardware error */
> > > > 
> > > > +#define ENOTREG              136     /* Not a regular file */
> > > > +
> > > >  #endif
> > > > diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/asm-generic/errno.h
> > > > index 92e7ae493ee3..2216ab9aa32e 100644
> > > > --- a/tools/include/uapi/asm-generic/errno.h
> > > > +++ b/tools/include/uapi/asm-generic/errno.h
> > > > @@ -122,4 +122,6 @@
> > > > 
> > > >  #define EHWPOISON    133     /* Memory page has hardware error */
> > > > 
> > > > +#define ENOTREG              134     /* Not a regular file */
> > > > +
> > > >  #endif
> > > 
> > > One thing this patch is missing is handling for ->atomic_open(). I
> > > imagine most of the filesystems that provide that op can't support
> > > O_REGULAR properly (maybe cifs can? idk). What you probably want to do
> > > is add in some patches that make all of the atomic_open operations in
> > > the kernel return -EINVAL if O_REGULAR is set.
> > > 
> > > Then, once the basic support is in, you or someone else can go back and
> > > implement support for O_REGULAR where possible.
> > 
> > Thank you for the feedback. I don't quite understand what I need to
> > fix. I thought open system calls always create regular files, so
> > atomic_open probably always creates regular files? Can you please give
> > me some more details as to where I need to fix this and what the
> > actual bug here is that is related to atomic_open?  I think I had done
> > some normal testing and when using O_CREAT | O_REGULAR, if the file
> > doesn't exist, the file gets created and the file that gets created is
> > a regular file, so it probably makes sense? Or should the behavior be
> > that if file doesn't exist, -EINVAL is returned and if file exists it
> > is opened if regular, otherwise -ENOTREG is returned?
> > 
> 
> atomic_open() is a combination lookup+open for when the dentry isn't
> present in the dcache. The normal open codepath that you're patching
> does not get called in this case when ->atomic_open is set for the
> filesystem. It's mostly used by network filesystems that need to
> optimize away the lookup since it's wasted round trip, and is often
> racy anyway. Your patchset doesn't address those filesystems. They will
> likely end up ignoring O_REGULAR in that case, which is not what you
> want.
> 
> What I was suggesting is that, as an interim step, you find all of the
> atomic_open operations in the kernel (there are maybe a dozen or so),
> and just make them return -EINVAL if someone sets O_DIRECTORY. Later,
> you or someone else can then go back and do a proper implementation of
> O_REGULAR handling on those filesystems, at least on the ones where
> it's possible. You will probably also need to similarly patch the
> open() routines for those filesystems too. Otherwise you'll get
> inconsistent behavior vs. when the dentry is in the cache.
> 
> One note: I think NFS probably can support O_DIRECTORY, since its OPEN
> call only works on files. We'll need to change how we handle errors
> from the server when it's set though.

So I think you're proposing two separate things or there's a typo:

(1) blocking O_DIRECTORY for ->atomic_open::
(2) blocking O_REGULAR for ->atomic_open::

The (1) point implies that O_DIRECTORY currently doesn't work correctly
with atomic open for all filesystems.

Ever since 43b450632676 ("open: return EINVAL for O_DIRECTORY |
O_CREAT") O_DIRECTORY with O_CREAT is blocked. It was accidently allowed
and completely broken before that.

For O_DIRECTORY without O_CREAT the kernel will pass that down through
->atomic_open:: to the filesystem.

The worry that I see is that a network filesystem via ->atomic_open::
somehow already called open on the server side on something that wasn't
a directory. At that point the damage such as side-effects from device
opening is already done.
                                    
But I suspect that every filesystem implementing ->atomic_open:: just
does finish_no_open() and punts to the VFS for the actual open. And the
VFS will catch it in do_open() for it actually opens the file. So the
only real worry for O_DIRECTORY I see is that there's an fs that handles
it wrong.

For (2) it is problematic as there surely are filesystems with
->atomic_open:: that do handle the ~O_CREAT case and return with
FMODE_OPENED. So that'll be problematic if the intention is to not
trigger an actual open on a non-regular file such as a
device/socket/fifo etc. before the VFS had a chance to validate what's
going on.

So I'm not excited about having this 70% working and punting on
->atomic_open:: waiting for someone to fix this. One option would be to
bypass ->atomic_open:: for OPENAT2_REGULAR without O_CREAT and fallback
to racy and pricy lookup + open for now. How problematic would that be?
If possible I'd prefer this a lot over merging something that works
half-way.

I guess to make that really work you'd need some protocol extension?

