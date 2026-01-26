Return-Path: <linux-fsdevel+bounces-75512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JX+Hsa7d2lGkgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:08:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 973B98C5B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E5143002B75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 19:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9420DD51;
	Mon, 26 Jan 2026 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="0xZwOkHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C1C26C3B0
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769454525; cv=none; b=VW/1Ug+luVsJ3ks35Nt+4K0ufbL/0wQKOQpx4WXLLph5EKgXFtH4hfB9BiFGK/x/yH+4VA/Oi66102z6wyB4Ok0Ulyegd2ceIUW24IgLM69CwiRrAZfkQ0EkksnnJN6IwnJDaDMmQmMVLiYPRWISpOlsQcNc2PhfxHW5zmpquX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769454525; c=relaxed/simple;
	bh=X/6mIbCd/hZgayA3YHGtCBr1DEpZQ8mRrbzLdyXuAWA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rhEfmb/OKfICRBe+cUlYleUNzyvZi73lrRqTjCAS5dNxcUtQALt6LqsQN593eRJiHH/9u8WYnNxI9+TsppJq22Fv1+w3BZgTmq1A/KYs/3/lqss8reg9Ct7prWj8MKKimmP3sTFfmF8R6OkWOMxdCtbmWfXi189daf+NpE74UFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=0xZwOkHD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso175818b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 11:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1769454522; x=1770059322; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31PbyDaXGtn669nraBRhxePMI/YusUfNx34tt8TSfV8=;
        b=0xZwOkHDSHj+lqKjAQ+gvMKd5Mye/ORhjfwD0DUDpVk5WKuyN7bohBzICtns5VWitq
         plIBsvLRmyU8KOROzT2zxqsgBsW7GJ6IgKEOuE4yuYec9VyomnTsdnyhZJap3ZsbFBE4
         TWN6OhKOidScUjCUmNKWbmqQkawmWeSlwVUxxeHX4/+GsjJBkpbRO/O3tlb2jkp0+wby
         +nwcw5/A3cWYwwCn3Ehj0ku6w53Gs2z/pAlOOnRpgybINfYYo9gIe++3sHyxb5gvZQlq
         4P2ZZABcvpmHGtvOI+rrkl4VJs615p3vMRh4pR2iJVW6T/Ls0b0bslmyOaA1LXG4kXLm
         lCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769454522; x=1770059322;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31PbyDaXGtn669nraBRhxePMI/YusUfNx34tt8TSfV8=;
        b=UqPkcMaDg/vvu3mnKnBjiiW0dz2/FdiWIXyhCV/VxZ3lNz4/8EupnggXX/wNhcuNEB
         i0Hmm5Ffyh/7ds5apW7c1+eSNGsyDPT1j6hKrJKinKiaOv6WZpf6q1FR8KuBpo1leDbx
         6lxTaJD1rFrvwJ2kZskYahR3+uyrZ193NbJ2Tv9gGEJw3N8QjT2rVo/GOfpIsAuulyXn
         iwWwSVEERKnMlZrnGJ3ZWtexGWCC9HXQBqI2kKdnyrcgswYrg32DwqWAaxdsSEUfYP/Q
         TbF9B3Inb3tJnnOwueS3rTDDSxw+XTehVurZVmHqv0+0ev/vFJ7HbloY/BwGtatfn0bc
         NQ9A==
X-Gm-Message-State: AOJu0Yxuvy5+ZoPtpjxQu82UxQv6YwVewCdeeek58iUZW/7FOCHz5fvS
	BZ8xFrabY+YJMlcTdb4AaGvkdPRGh4tIPHNW3NT6aYoiQpwfE22chHhoXQQOYhWjQPitL77X6OJ
	RWNtlqvw=
X-Gm-Gg: AZuq6aL+uf3lDY85N5SEy3gYlIotgXIoqSMyym2uTBB7k684YQMOjJUpHUN9NffK/Q+
	ykzFmmQ74mKZhGXgI7uN4BXE4B3i65wSjY1oFbcBgncRrXr/UJR8nPv6GG2L+2pJ6dP0dRyxYgK
	L1z2n9Xb49n90CJoA36acxI97dypeFNft6uGDVey7TchpKIhg/YZN/msVFhHTFx/gQj07W8C1sq
	a6X7xBHARDgxYo1OMR4DknqVX81Vt0SQwsKmWEBF+ea4fFSn76BL1pv9vA/lWc5Zjk55s2MA22D
	kNj5nQ7WacNlEGyOcpXLmpn38FqGMOIexzrMBH5FQrF7r1OS0PsuKrqOsJkzS76TZThbW9oeCpb
	ktUo8Kl2j9tCgVGpF/Qk/5GjpJRXI4s5Ia6HcfCk+kkF3cg3c68v5KH2lVxdH2xSRhAzFqrwWvX
	/jvM7BoX0SxGWTsosYBV/s5S8DEEvjwv2dls2po9Z+JWzeFDVVU6OaeJg3IaYBfktndg==
X-Received: by 2002:a05:6a21:2d8c:b0:38d:f799:c4dd with SMTP id adf61e73a8af0-38e9f14f040mr4678260637.35.1769454522142;
        Mon, 26 Jan 2026 11:08:42 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a1309dfsm8758972a12.6.2026.01.26.11.08.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jan 2026 11:08:41 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v2 1/2] open: new O_REGULAR flag support
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260126154156.55723-2-dorjoychy111@gmail.com>
Date: Mon, 26 Jan 2026 12:08:29 -0700
Cc: linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk,
 brauner@kernel.org,
 jack@suse.cz,
 jlayton@kernel.org,
 chuck.lever@oracle.com,
 alex.aring@gmail.com,
 arnd@arndb.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CCEFA1A-7136-4E78-A0D2-DCA2EFC10C4B@dilger.ca>
References: <20260126154156.55723-1-dorjoychy111@gmail.com>
 <20260126154156.55723-2-dorjoychy111@gmail.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75512-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dilger-ca.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 973B98C5B1
X-Rspamd-Action: no action

On Jan 26, 2026, at 08:39, Dorjoy Chowdhury <dorjoychy111@gmail.com> =
wrote:
>=20
> This flag indicates the path should be opened if it's a regular file.
> A relevant error code ENOTREGULAR(35) has been introduced. For =
example,
> if open is called on path /dev/null with O_REGULAR in the flag param,
> it will return -ENOTREGULAR.

This appears to be ENOTREG in the actual patch?

It seems possible to use ENOTREG=3D140 to avoid collisions for _most_=20
of the architectures, leaving only parisc and mips with different
values (which are mostly obsolete anyway).

Similarly, it seems possible to use O_REGULAR 0400000000 to avoid
conflicts for most (all?) architectures as well, instead of having
a different value for several of them.

While it isn't _required_ to have the same values across architectures,
it doesn't hurt and makes human identification of these values easier.

Cheers, Andreas

> When used in combination with O_CREAT, either the regular file is
> created, or if the path already exists, it is opened if it's a regular
> file. Otherwise, -ENOTREGULAR is returned.
>=20
> -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (not
> part of O_TMPFILE) because it doesn't make sense to open a path that
> is both a directory and a regular file.
>=20
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
> arch/alpha/include/uapi/asm/errno.h        | 2 ++
> arch/alpha/include/uapi/asm/fcntl.h        | 1 +
> arch/mips/include/uapi/asm/errno.h         | 2 ++
> arch/parisc/include/uapi/asm/errno.h       | 2 ++
> arch/parisc/include/uapi/asm/fcntl.h       | 1 +
> arch/sparc/include/uapi/asm/errno.h        | 2 ++
> arch/sparc/include/uapi/asm/fcntl.h        | 1 +
> fs/fcntl.c                                 | 2 +-
> fs/namei.c                                 | 6 ++++++
> fs/open.c                                  | 4 +++-
> include/linux/fcntl.h                      | 2 +-
> include/uapi/asm-generic/errno.h           | 2 ++
> include/uapi/asm-generic/fcntl.h           | 4 ++++
> tools/arch/alpha/include/uapi/asm/errno.h  | 2 ++
> tools/arch/mips/include/uapi/asm/errno.h   | 2 ++
> tools/arch/parisc/include/uapi/asm/errno.h | 2 ++
> tools/arch/sparc/include/uapi/asm/errno.h  | 2 ++
> tools/include/uapi/asm-generic/errno.h     | 2 ++
> 18 files changed, 38 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/alpha/include/uapi/asm/errno.h =
b/arch/alpha/include/uapi/asm/errno.h
> index 6791f6508632..8bbcaa9024f9 100644
> --- a/arch/alpha/include/uapi/asm/errno.h
> +++ b/arch/alpha/include/uapi/asm/errno.h
> @@ -127,4 +127,6 @@
>=20
> #define EHWPOISON 139 /* Memory page has hardware error */
>=20
> +#define ENOTREG 140 /* Not a regular file */
> +
> #endif
> diff --git a/arch/alpha/include/uapi/asm/fcntl.h =
b/arch/alpha/include/uapi/asm/fcntl.h
> index 50bdc8e8a271..4da5a64c23bd 100644
> --- a/arch/alpha/include/uapi/asm/fcntl.h
> +++ b/arch/alpha/include/uapi/asm/fcntl.h
> @@ -34,6 +34,7 @@
>=20
> #define O_PATH 040000000
> #define __O_TMPFILE 0100000000
> +#define O_REGULAR 0200000000
>=20
> #define F_GETLK 7
> #define F_SETLK 8
> diff --git a/arch/mips/include/uapi/asm/errno.h =
b/arch/mips/include/uapi/asm/errno.h
> index c01ed91b1ef4..293c78777254 100644
> --- a/arch/mips/include/uapi/asm/errno.h
> +++ b/arch/mips/include/uapi/asm/errno.h
> @@ -126,6 +126,8 @@
>=20
> #define EHWPOISON 168 /* Memory page has hardware error */
>=20
> +#define ENOTREG 169 /* Not a regular file */
> +
> #define EDQUOT 1133 /* Quota exceeded */
>=20
>=20
> diff --git a/arch/parisc/include/uapi/asm/errno.h =
b/arch/parisc/include/uapi/asm/errno.h
> index 8cbc07c1903e..442917484f99 100644
> --- a/arch/parisc/include/uapi/asm/errno.h
> +++ b/arch/parisc/include/uapi/asm/errno.h
> @@ -124,4 +124,6 @@
>=20
> #define EHWPOISON 257 /* Memory page has hardware error */
>=20
> +#define ENOTREG 258 /* Not a regular file */
> +
> #endif
> diff --git a/arch/parisc/include/uapi/asm/fcntl.h =
b/arch/parisc/include/uapi/asm/fcntl.h
> index 03dee816cb13..efd763335ff7 100644
> --- a/arch/parisc/include/uapi/asm/fcntl.h
> +++ b/arch/parisc/include/uapi/asm/fcntl.h
> @@ -19,6 +19,7 @@
>=20
> #define O_PATH 020000000
> #define __O_TMPFILE 040000000
> +#define O_REGULAR 060000000
>=20
> #define F_GETLK64 8
> #define F_SETLK64 9
> diff --git a/arch/sparc/include/uapi/asm/errno.h =
b/arch/sparc/include/uapi/asm/errno.h
> index 4a41e7835fd5..8dce0bfeab74 100644
> --- a/arch/sparc/include/uapi/asm/errno.h
> +++ b/arch/sparc/include/uapi/asm/errno.h
> @@ -117,4 +117,6 @@
>=20
> #define EHWPOISON 135 /* Memory page has hardware error */
>=20
> +#define ENOTREG 136 /* Not a regular file */
> +
> #endif
> diff --git a/arch/sparc/include/uapi/asm/fcntl.h =
b/arch/sparc/include/uapi/asm/fcntl.h
> index 67dae75e5274..a93d18d2c23e 100644
> --- a/arch/sparc/include/uapi/asm/fcntl.h
> +++ b/arch/sparc/include/uapi/asm/fcntl.h
> @@ -37,6 +37,7 @@
>=20
> #define O_PATH 0x1000000
> #define __O_TMPFILE 0x2000000
> +#define O_REGULAR 0x4000000
>=20
> #define F_GETOWN 5 /*  for sockets. */
> #define F_SETOWN 6 /*  for sockets. */
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index f93dbca08435..62ab4ad2b6f5 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -1169,7 +1169,7 @@ static int __init fcntl_init(void)
> * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
> * is defined as O_NONBLOCK on some platforms and not on others.
> */
> - BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> + BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> HWEIGHT32(
> (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
> __FMODE_EXEC));
> diff --git a/fs/namei.c b/fs/namei.c
> index b28ecb699f32..f5504ae4b03c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4616,6 +4616,10 @@ static int do_open(struct nameidata *nd,
> if (unlikely(error))
> return error;
> }
> +
> + if ((open_flag & O_REGULAR) && !d_is_reg(nd->path.dentry))
> + return -ENOTREG;
> +
> if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
> return -ENOTDIR;
>=20
> @@ -4765,6 +4769,8 @@ static int do_o_path(struct nameidata *nd, =
unsigned flags, struct file *file)
> struct path path;
> int error =3D path_lookupat(nd, flags, &path);
> if (!error) {
> + if ((file->f_flags & O_REGULAR) && !d_is_reg(path.dentry))
> + return -ENOTREG;
> audit_inode(nd->name, path.dentry, 0);
> error =3D vfs_open(&path, file);
> path_put(&path);
> diff --git a/fs/open.c b/fs/open.c
> index 74c4c1462b3e..82153e21907e 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1173,7 +1173,7 @@ struct file *kernel_file_open(const struct path =
*path, int flags,
> EXPORT_SYMBOL_GPL(kernel_file_open);
>=20
> #define WILL_CREATE(flags) (flags & (O_CREAT | __O_TMPFILE))
> -#define O_PATH_FLAGS (O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
> +#define O_PATH_FLAGS (O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | =
O_REGULAR)
>=20
> inline struct open_how build_open_how(int flags, umode_t mode)
> {
> @@ -1250,6 +1250,8 @@ inline int build_open_flags(const struct =
open_how *how, struct open_flags *op)
> return -EINVAL;
> if (!(acc_mode & MAY_WRITE))
> return -EINVAL;
> + } else if ((flags & O_DIRECTORY) && (flags & O_REGULAR)) {
> + return -EINVAL;
> }
> if (flags & O_PATH) {
> /* O_PATH only permits certain other flags to be set. */
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index a332e79b3207..4fd07b0e0a17 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -10,7 +10,7 @@
> (O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC =
| \
> O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
> FASYNC | O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> - O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> + O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_REGULAR)
>=20
> /* List of all valid flags for the how->resolve argument: */
> #define VALID_RESOLVE_FLAGS \
> diff --git a/include/uapi/asm-generic/errno.h =
b/include/uapi/asm-generic/errno.h
> index 92e7ae493ee3..2216ab9aa32e 100644
> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -122,4 +122,6 @@
>=20
> #define EHWPOISON 133 /* Memory page has hardware error */
>=20
> +#define ENOTREG 134 /* Not a regular file */
> +
> #endif
> diff --git a/include/uapi/asm-generic/fcntl.h =
b/include/uapi/asm-generic/fcntl.h
> index 613475285643..3468b352a575 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -88,6 +88,10 @@
> #define __O_TMPFILE 020000000
> #endif
>=20
> +#ifndef O_REGULAR
> +#define O_REGULAR 040000000
> +#endif
> +
> /* a horrid kludge trying to make sure that this will fail on old =
kernels */
> #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
>=20
> diff --git a/tools/arch/alpha/include/uapi/asm/errno.h =
b/tools/arch/alpha/include/uapi/asm/errno.h
> index 6791f6508632..8bbcaa9024f9 100644
> --- a/tools/arch/alpha/include/uapi/asm/errno.h
> +++ b/tools/arch/alpha/include/uapi/asm/errno.h
> @@ -127,4 +127,6 @@
>=20
> #define EHWPOISON 139 /* Memory page has hardware error */
>=20
> +#define ENOTREG 140 /* Not a regular file */
> +
> #endif
> diff --git a/tools/arch/mips/include/uapi/asm/errno.h =
b/tools/arch/mips/include/uapi/asm/errno.h
> index c01ed91b1ef4..293c78777254 100644
> --- a/tools/arch/mips/include/uapi/asm/errno.h
> +++ b/tools/arch/mips/include/uapi/asm/errno.h
> @@ -126,6 +126,8 @@
>=20
> #define EHWPOISON 168 /* Memory page has hardware error */
>=20
> +#define ENOTREG 169 /* Not a regular file */
> +
> #define EDQUOT 1133 /* Quota exceeded */
>=20
>=20
> diff --git a/tools/arch/parisc/include/uapi/asm/errno.h =
b/tools/arch/parisc/include/uapi/asm/errno.h
> index 8cbc07c1903e..442917484f99 100644
> --- a/tools/arch/parisc/include/uapi/asm/errno.h
> +++ b/tools/arch/parisc/include/uapi/asm/errno.h
> @@ -124,4 +124,6 @@
>=20
> #define EHWPOISON 257 /* Memory page has hardware error */
>=20
> +#define ENOTREG 258 /* Not a regular file */
> +
> #endif
> diff --git a/tools/arch/sparc/include/uapi/asm/errno.h =
b/tools/arch/sparc/include/uapi/asm/errno.h
> index 4a41e7835fd5..8dce0bfeab74 100644
> --- a/tools/arch/sparc/include/uapi/asm/errno.h
> +++ b/tools/arch/sparc/include/uapi/asm/errno.h
> @@ -117,4 +117,6 @@
>=20
> #define EHWPOISON 135 /* Memory page has hardware error */
>=20
> +#define ENOTREG 136 /* Not a regular file */
> +
> #endif
> diff --git a/tools/include/uapi/asm-generic/errno.h =
b/tools/include/uapi/asm-generic/errno.h
> index 92e7ae493ee3..2216ab9aa32e 100644
> --- a/tools/include/uapi/asm-generic/errno.h
> +++ b/tools/include/uapi/asm-generic/errno.h
> @@ -122,4 +122,6 @@
>=20
> #define EHWPOISON 133 /* Memory page has hardware error */
>=20
> +#define ENOTREG 134 /* Not a regular file */
> +
> #endif
> --=20
> 2.52.0
>=20
>=20


Cheers, Andreas






