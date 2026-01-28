Return-Path: <linux-fsdevel+bounces-75747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCHoL/syeml+4gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:02:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE94A4F46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9869031165BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1A530274D;
	Wed, 28 Jan 2026 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjcKc3vn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040627BF79;
	Wed, 28 Jan 2026 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615470; cv=none; b=nw142CFKUnD7sqwD9CxysJYp7wGkqSTboTHV1qsWGYxvKIQ4kze7N3RhjqIg+NEv6JBU4949VVac0uZJC35EmZcruqhfrQVFkqYQybhtjTHjTGJ+aPDmiApBBVYE3TmLsn/ts2l8QpFR13yifnLqXC8oW13DLjrf+qBVa8o/UlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615470; c=relaxed/simple;
	bh=LT3+aY8/Yh/m+9tAyh81m6D4X9BnZdkLSFnxg/3kHnU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wq/9UW981Ouxr60LtwPRfnstFKyEwR7tR9egAaCde17/h0ZqkboayOQbQOMZIUg75SihJaplBkqG6Y2nwyd9qd7tBkNX5GAsa6FIieFZ5UTOq0Wy/i4ZyUJSVNwWIxlIyybR8pL/do7ktsQvPHB2hn4FeRIlJMYr0zOtRWMgGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjcKc3vn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC104C4CEF1;
	Wed, 28 Jan 2026 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769615469;
	bh=LT3+aY8/Yh/m+9tAyh81m6D4X9BnZdkLSFnxg/3kHnU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kjcKc3vnUfuVg776w84RJMLRpzvvzT0JgKuLgFhY3LOCCLRqlucJePT3Kez7CGI0Y
	 GQl+ACCbW/FQNvukX1d+jXpUYIdVxGNEm2bgRNr3kKINND0vDtzRi8iNATy54C1spu
	 b6HbCpt1FlnkPgf/eO66QFRWWjQ7MPjk5eWCFIcOlx5xw83NjlyYOd0HhR7qhEklW/
	 HXHI4bbKGcjaTc495tPnQMnP2PVhWOwiVxmjMcPw6UUIMVM35UpAnOOT4r8n4fVMjW
	 ptJ0WQzUM7osnkvnywuxdZAfrrKz+2cVPLvych5sMerGXZ1eMmgikTlWFx/AV/Oxgv
	 vKQ5dwHm5IVow==
Message-ID: <b6749fa99a728189e745f1769140be3ac8950af5.camel@kernel.org>
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
From: Jeff Layton <jlayton@kernel.org>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 chuck.lever@oracle.com, 	alex.aring@gmail.com, arnd@arndb.de,
 adilger@dilger.ca
Date: Wed, 28 Jan 2026 10:51:07 -0500
In-Reply-To: <CAFfO_h5yrXR0-igVayH0ent1t12rm=6DUEGjUDW0zqfqy3=ZoQ@mail.gmail.com>
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
	 <20260127180109.66691-2-dorjoychy111@gmail.com>
	 <1c6cccc3e058ef16fa8b296ef6126b76a12db136.camel@kernel.org>
	 <CAFfO_h5yrXR0-igVayH0ent1t12rm=6DUEGjUDW0zqfqy3=ZoQ@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	TAGGED_FROM(0.00)[bounces-75747-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[jlayton.kernel.org:query timed out,dorjoychy111.gmail.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6CE94A4F46
X-Rspamd-Action: no action

On Wed, 2026-01-28 at 21:36 +0600, Dorjoy Chowdhury wrote:
> On Wed, Jan 28, 2026 at 5:52=E2=80=AFAM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Tue, 2026-01-27 at 23:58 +0600, Dorjoy Chowdhury wrote:
> > > This flag indicates the path should be opened if it's a regular file.
> > > This is useful to write secure programs that want to avoid being tric=
ked
> > > into opening device nodes with special semantics while thinking they
> > > operate on regular files.
> > >=20
> > > A corresponding error code ENOTREG has been introduced. For example, =
if
> > > open is called on path /dev/null with O_REGULAR in the flag param, it
> > > will return -ENOTREG.
> > >=20
> > > When used in combination with O_CREAT, either the regular file is
> > > created, or if the path already exists, it is opened if it's a regula=
r
> > > file. Otherwise, -ENOTREG is returned.
> > >=20
> > > -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (not
> > > part of O_TMPFILE) because it doesn't make sense to open a path that
> > > is both a directory and a regular file.
> > >=20
> > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > ---
> > >  arch/alpha/include/uapi/asm/errno.h        | 2 ++
> > >  arch/alpha/include/uapi/asm/fcntl.h        | 1 +
> > >  arch/mips/include/uapi/asm/errno.h         | 2 ++
> > >  arch/parisc/include/uapi/asm/errno.h       | 2 ++
> > >  arch/parisc/include/uapi/asm/fcntl.h       | 1 +
> > >  arch/sparc/include/uapi/asm/errno.h        | 2 ++
> > >  arch/sparc/include/uapi/asm/fcntl.h        | 1 +
> > >  fs/fcntl.c                                 | 2 +-
> > >  fs/namei.c                                 | 6 ++++++
> > >  fs/open.c                                  | 4 +++-
> > >  include/linux/fcntl.h                      | 2 +-
> > >  include/uapi/asm-generic/errno.h           | 2 ++
> > >  include/uapi/asm-generic/fcntl.h           | 4 ++++
> > >  tools/arch/alpha/include/uapi/asm/errno.h  | 2 ++
> > >  tools/arch/mips/include/uapi/asm/errno.h   | 2 ++
> > >  tools/arch/parisc/include/uapi/asm/errno.h | 2 ++
> > >  tools/arch/sparc/include/uapi/asm/errno.h  | 2 ++
> > >  tools/include/uapi/asm-generic/errno.h     | 2 ++
> > >  18 files changed, 38 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include=
/uapi/asm/errno.h
> > > index 6791f6508632..8bbcaa9024f9 100644
> > > --- a/arch/alpha/include/uapi/asm/errno.h
> > > +++ b/arch/alpha/include/uapi/asm/errno.h
> > > @@ -127,4 +127,6 @@
> > >=20
> > >  #define EHWPOISON    139     /* Memory page has hardware error */
> > >=20
> > > +#define ENOTREG              140     /* Not a regular file */
> > > +
> > >  #endif
> > > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include=
/uapi/asm/fcntl.h
> > > index 50bdc8e8a271..4da5a64c23bd 100644
> > > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > > @@ -34,6 +34,7 @@
> > >=20
> > >  #define O_PATH               040000000
> > >  #define __O_TMPFILE  0100000000
> > > +#define O_REGULAR    0200000000
> > >=20
> > >  #define F_GETLK              7
> > >  #define F_SETLK              8
> > > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/u=
api/asm/errno.h
> > > index c01ed91b1ef4..293c78777254 100644
> > > --- a/arch/mips/include/uapi/asm/errno.h
> > > +++ b/arch/mips/include/uapi/asm/errno.h
> > > @@ -126,6 +126,8 @@
> > >=20
> > >  #define EHWPOISON    168     /* Memory page has hardware error */
> > >=20
> > > +#define ENOTREG              169     /* Not a regular file */
> > > +
> > >  #define EDQUOT               1133    /* Quota exceeded */
> > >=20
> > >=20
> > > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/inclu=
de/uapi/asm/errno.h
> > > index 8cbc07c1903e..442917484f99 100644
> > > --- a/arch/parisc/include/uapi/asm/errno.h
> > > +++ b/arch/parisc/include/uapi/asm/errno.h
> > > @@ -124,4 +124,6 @@
> > >=20
> > >  #define EHWPOISON    257     /* Memory page has hardware error */
> > >=20
> > > +#define ENOTREG              258     /* Not a regular file */
> > > +
> > >  #endif
> > > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/inclu=
de/uapi/asm/fcntl.h
> > > index 03dee816cb13..0cc3320fe326 100644
> > > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > > @@ -19,6 +19,7 @@
> > >=20
> > >  #define O_PATH               020000000
> > >  #define __O_TMPFILE  040000000
> > > +#define O_REGULAR    0100000000
> > >=20
> > >  #define F_GETLK64    8
> > >  #define F_SETLK64    9
> > > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include=
/uapi/asm/errno.h
> > > index 4a41e7835fd5..8dce0bfeab74 100644
> > > --- a/arch/sparc/include/uapi/asm/errno.h
> > > +++ b/arch/sparc/include/uapi/asm/errno.h
> > > @@ -117,4 +117,6 @@
> > >=20
> > >  #define EHWPOISON    135     /* Memory page has hardware error */
> > >=20
> > > +#define ENOTREG              136     /* Not a regular file */
> > > +
> > >  #endif
> > > diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include=
/uapi/asm/fcntl.h
> > > index 67dae75e5274..a93d18d2c23e 100644
> > > --- a/arch/sparc/include/uapi/asm/fcntl.h
> > > +++ b/arch/sparc/include/uapi/asm/fcntl.h
> > > @@ -37,6 +37,7 @@
> > >=20
> > >  #define O_PATH               0x1000000
> > >  #define __O_TMPFILE  0x2000000
> > > +#define O_REGULAR    0x4000000
> > >=20
> > >  #define F_GETOWN     5       /*  for sockets. */
> > >  #define F_SETOWN     6       /*  for sockets. */
> > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > index f93dbca08435..62ab4ad2b6f5 100644
> > > --- a/fs/fcntl.c
> > > +++ b/fs/fcntl.c
> > > @@ -1169,7 +1169,7 @@ static int __init fcntl_init(void)
> > >        * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDEL=
AY
> > >        * is defined as O_NONBLOCK on some platforms and not on others=
.
> > >        */
> > > -     BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> > > +     BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> > >               HWEIGHT32(
> > >                       (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
> > >                       __FMODE_EXEC));
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index b28ecb699f32..f5504ae4b03c 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -4616,6 +4616,10 @@ static int do_open(struct nameidata *nd,
> > >               if (unlikely(error))
> > >                       return error;
> > >       }
> > > +
> > > +     if ((open_flag & O_REGULAR) && !d_is_reg(nd->path.dentry))
> > > +             return -ENOTREG;
> > > +
> > >       if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.de=
ntry))
> > >               return -ENOTDIR;
> > >=20
> > > @@ -4765,6 +4769,8 @@ static int do_o_path(struct nameidata *nd, unsi=
gned flags, struct file *file)
> > >       struct path path;
> > >       int error =3D path_lookupat(nd, flags, &path);
> > >       if (!error) {
> > > +             if ((file->f_flags & O_REGULAR) && !d_is_reg(path.dentr=
y))
> > > +                     return -ENOTREG;
> > >               audit_inode(nd->name, path.dentry, 0);
> > >               error =3D vfs_open(&path, file);
> > >               path_put(&path);
> > > diff --git a/fs/open.c b/fs/open.c
> > > index 74c4c1462b3e..82153e21907e 100644
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -1173,7 +1173,7 @@ struct file *kernel_file_open(const struct path=
 *path, int flags,
> > >  EXPORT_SYMBOL_GPL(kernel_file_open);
> > >=20
> > >  #define WILL_CREATE(flags)   (flags & (O_CREAT | __O_TMPFILE))
> > > -#define O_PATH_FLAGS         (O_DIRECTORY | O_NOFOLLOW | O_PATH | O_=
CLOEXEC)
> > > +#define O_PATH_FLAGS         (O_DIRECTORY | O_NOFOLLOW | O_PATH | O_=
CLOEXEC | O_REGULAR)
> > >=20
> > >  inline struct open_how build_open_how(int flags, umode_t mode)
> > >  {
> > > @@ -1250,6 +1250,8 @@ inline int build_open_flags(const struct open_h=
ow *how, struct open_flags *op)
> > >                       return -EINVAL;
> > >               if (!(acc_mode & MAY_WRITE))
> > >                       return -EINVAL;
> > > +     } else if ((flags & O_DIRECTORY) && (flags & O_REGULAR)) {
> > > +             return -EINVAL;
> > >       }
> > >       if (flags & O_PATH) {
> > >               /* O_PATH only permits certain other flags to be set. *=
/
> > > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > > index a332e79b3207..4fd07b0e0a17 100644
> > > --- a/include/linux/fcntl.h
> > > +++ b/include/linux/fcntl.h
> > > @@ -10,7 +10,7 @@
> > >       (O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O=
_TRUNC | \
> > >        O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
> > >        FASYNC | O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> > > -      O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> > > +      O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_REGULAR)
> > >=20
> > >  /* List of all valid flags for the how->resolve argument: */
> > >  #define VALID_RESOLVE_FLAGS \
> > > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-gene=
ric/errno.h
> > > index 92e7ae493ee3..2216ab9aa32e 100644
> > > --- a/include/uapi/asm-generic/errno.h
> > > +++ b/include/uapi/asm-generic/errno.h
> > > @@ -122,4 +122,6 @@
> > >=20
> > >  #define EHWPOISON    133     /* Memory page has hardware error */
> > >=20
> > > +#define ENOTREG              134     /* Not a regular file */
> > > +
> > >  #endif
> > > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-gene=
ric/fcntl.h
> > > index 613475285643..3468b352a575 100644
> > > --- a/include/uapi/asm-generic/fcntl.h
> > > +++ b/include/uapi/asm-generic/fcntl.h
> > > @@ -88,6 +88,10 @@
> > >  #define __O_TMPFILE  020000000
> > >  #endif
> > >=20
> > > +#ifndef O_REGULAR
> > > +#define O_REGULAR    040000000
> > > +#endif
> > > +
> > >  /* a horrid kludge trying to make sure that this will fail on old ke=
rnels */
> > >  #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
> > >=20
> > > diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/a=
lpha/include/uapi/asm/errno.h
> > > index 6791f6508632..8bbcaa9024f9 100644
> > > --- a/tools/arch/alpha/include/uapi/asm/errno.h
> > > +++ b/tools/arch/alpha/include/uapi/asm/errno.h
> > > @@ -127,4 +127,6 @@
> > >=20
> > >  #define EHWPOISON    139     /* Memory page has hardware error */
> > >=20
> > > +#define ENOTREG              140     /* Not a regular file */
> > > +
> > >  #endif
> > > diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mi=
ps/include/uapi/asm/errno.h
> > > index c01ed91b1ef4..293c78777254 100644
> > > --- a/tools/arch/mips/include/uapi/asm/errno.h
> > > +++ b/tools/arch/mips/include/uapi/asm/errno.h
> > > @@ -126,6 +126,8 @@
> > >=20
> > >  #define EHWPOISON    168     /* Memory page has hardware error */
> > >=20
> > > +#define ENOTREG              169     /* Not a regular file */
> > > +
> > >  #define EDQUOT               1133    /* Quota exceeded */
> > >=20
> > >=20
> > > diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/=
parisc/include/uapi/asm/errno.h
> > > index 8cbc07c1903e..442917484f99 100644
> > > --- a/tools/arch/parisc/include/uapi/asm/errno.h
> > > +++ b/tools/arch/parisc/include/uapi/asm/errno.h
> > > @@ -124,4 +124,6 @@
> > >=20
> > >  #define EHWPOISON    257     /* Memory page has hardware error */
> > >=20
> > > +#define ENOTREG              258     /* Not a regular file */
> > > +
> > >  #endif
> > > diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/s=
parc/include/uapi/asm/errno.h
> > > index 4a41e7835fd5..8dce0bfeab74 100644
> > > --- a/tools/arch/sparc/include/uapi/asm/errno.h
> > > +++ b/tools/arch/sparc/include/uapi/asm/errno.h
> > > @@ -117,4 +117,6 @@
> > >=20
> > >  #define EHWPOISON    135     /* Memory page has hardware error */
> > >=20
> > > +#define ENOTREG              136     /* Not a regular file */
> > > +
> > >  #endif
> > > diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/u=
api/asm-generic/errno.h
> > > index 92e7ae493ee3..2216ab9aa32e 100644
> > > --- a/tools/include/uapi/asm-generic/errno.h
> > > +++ b/tools/include/uapi/asm-generic/errno.h
> > > @@ -122,4 +122,6 @@
> > >=20
> > >  #define EHWPOISON    133     /* Memory page has hardware error */
> > >=20
> > > +#define ENOTREG              134     /* Not a regular file */
> > > +
> > >  #endif
> >=20
> > One thing this patch is missing is handling for ->atomic_open(). I
> > imagine most of the filesystems that provide that op can't support
> > O_REGULAR properly (maybe cifs can? idk). What you probably want to do
> > is add in some patches that make all of the atomic_open operations in
> > the kernel return -EINVAL if O_REGULAR is set.
> >=20
> > Then, once the basic support is in, you or someone else can go back and
> > implement support for O_REGULAR where possible.
>=20
> Thank you for the feedback. I don't quite understand what I need to
> fix. I thought open system calls always create regular files, so
> atomic_open probably always creates regular files? Can you please give
> me some more details as to where I need to fix this and what the
> actual bug here is that is related to atomic_open?  I think I had done
> some normal testing and when using O_CREAT | O_REGULAR, if the file
> doesn't exist, the file gets created and the file that gets created is
> a regular file, so it probably makes sense? Or should the behavior be
> that if file doesn't exist, -EINVAL is returned and if file exists it
> is opened if regular, otherwise -ENOTREG is returned?
>=20

atomic_open() is a combination lookup+open for when the dentry isn't
present in the dcache. The normal open codepath that you're patching
does not get called in this case when ->atomic_open is set for the
filesystem. It's mostly used by network filesystems that need to
optimize away the lookup since it's wasted round trip, and is often
racy anyway. Your patchset doesn't address those filesystems. They will
likely end up ignoring O_REGULAR in that case, which is not what you
want.

What I was suggesting is that, as an interim step, you find all of the
atomic_open operations in the kernel (there are maybe a dozen or so),
and just make them return -EINVAL if someone sets O_DIRECTORY. Later,
you or someone else can then go back and do a proper implementation of
O_REGULAR handling on those filesystems, at least on the ones where
it's possible. You will probably also need to similarly patch the
open() routines for those filesystems too. Otherwise you'll get
inconsistent behavior vs. when the dentry is in the cache.

One note: I think NFS probably can support O_DIRECTORY, since its OPEN
call only works on files. We'll need to change how we handle errors
from the server when it's set though.
--=20
Jeff Layton <jlayton@kernel.org>

