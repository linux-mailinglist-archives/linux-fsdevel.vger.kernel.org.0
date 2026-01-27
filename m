Return-Path: <linux-fsdevel+bounces-75664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPy9ChJJeWmFwQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:24:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F0E9B60E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8843F301A29A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 23:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CE52EDD50;
	Tue, 27 Jan 2026 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="DTm9nSEE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9334F2D838B;
	Tue, 27 Jan 2026 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769556238; cv=none; b=qaJAZ3Lm0KLt3hVjnZt36oFNOgWoOtpCygUtJ/Bt2/rfXblwKtBC5NUZsyQ7ISZ0Qx6rd3QWr3VpEezbQfffYmZ0lXcx2E6i/zy4sJMsa9lquRDQqZmoScWBjHLsG9AGxL8EnnqdybCnS8XxBSrN8Tn9mdeEzb9ZrMn6NOLSNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769556238; c=relaxed/simple;
	bh=TQONOwCwGoKoCH0YlZm0ZAn7reau+7wsk8oVRd/iD0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3UDEZFEFnp0swttVPUJh5D23ROSWa8CFX5xLLvcJiKWbwaXx8a1lt2jQg9EOsOjuXlNDDoGRaeWYbHaKqeztnSbPUtAr7xS7EpxLNY1VJpFF7Z+q4RfCU7KrsGJoFR5RIGhHyiAKsda0XtNYEXbEy0BoPqUvLi1gpOSCoby21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=DTm9nSEE; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f11gV3Dftz9tRx;
	Wed, 28 Jan 2026 00:23:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1769556230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYBrNwGIq3I61Ink1JXpolpFCZQaFJ/2wC/59Sl1tBg=;
	b=DTm9nSEEBVVFM/vGb803r4Ldq7wGsR4PbJ6Xjksil6HwEwN5v3qd31CwEKRH4fgG0y5vKW
	Igsupn88o1argn/JdTTP1bn/3VNByfXnbRp9c0KQ+CBHY4HEpcJqo4S6TvHDkgY0tFahNb
	0OyVYJraMOQKkJtBVViwkFpO8/6AjAlUKo9DdiksxlAekUdSqz/UJs5yC5VuR7FRopCB8Y
	MfozbUbkQUcqMcnAPHg+PKLS8Vza3Pc1cgSfwJSrVj2K870G+5kaoAUor6Wuo3awMlB/1G
	YeNgVu5dO8YBLD9SG0dSZQ0qF/FXOpSfhIJYr6G5BkLlry0WqsV4dPAfOjjs0A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 28 Jan 2026 00:23:45 +0100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
Message-ID: <2026-01-27-awake-stony-flair-patrol-g4abX8@cyphar.com>
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
 <20260127180109.66691-2-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6di3bgb2h5z3bivc"
Content-Disposition: inline
In-Reply-To: <20260127180109.66691-2-dorjoychy111@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75664-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0F0E9B60E
X-Rspamd-Action: no action


--6di3bgb2h5z3bivc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
MIME-Version: 1.0

On 2026-01-27, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
> This flag indicates the path should be opened if it's a regular file.
> This is useful to write secure programs that want to avoid being tricked
> into opening device nodes with special semantics while thinking they
> operate on regular files.
>=20
> A corresponding error code ENOTREG has been introduced. For example, if
> open is called on path /dev/null with O_REGULAR in the flag param, it
> will return -ENOTREG.
>=20
> When used in combination with O_CREAT, either the regular file is
> created, or if the path already exists, it is opened if it's a regular
> file. Otherwise, -ENOTREG is returned.
>=20
> -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (not
> part of O_TMPFILE) because it doesn't make sense to open a path that
> is both a directory and a regular file.

As you mention in your cover letter, this is something that the UAPI
group has asked for in the past[1] and was even discussed at a recent
LPC (maybe LPC 2024?) -- thanks for the patch!

In the next posting of this patchset, I would suggest including this
information in the *commit message* with a link (commit messages end up
in the git history, cover letters are a little harder to search for when
doing "git blame").

[1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regular-f=
iles

>  #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
> -#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
> +#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | O=
_REGULAR)

It doesn't really make sense to use this flag with O_PATH -- O_PATH file
descriptors do not actually open the target inode and so there is no
risk to doing this.

In fact the method of safely opening files while avoiding device inodes
on Linux today is to open an O_PATH, then use fstat(2) to check whether
it is a regular file, and then re-open the file descriptor through
/proc/self/fd/$n. (This is totally race-safe.)

My main reason for pushing back against this it's really quite
preferable to avoid expanding the set of O_* flags which work with
O_PATH if they don't add much -- O_PATH has really unfortunate behaviour
with ignoring other flags and openat2(2) finally fixed that by blocking
ignored flag combinations.

>  inline struct open_how build_open_how(int flags, umode_t mode)
>  {
> @@ -1250,6 +1250,8 @@ inline int build_open_flags(const struct open_how *=
how, struct open_flags *op)
>  			return -EINVAL;
>  		if (!(acc_mode & MAY_WRITE))
>  			return -EINVAL;
> +	} else if ((flags & O_DIRECTORY) && (flags & O_REGULAR)) {
> +		return -EINVAL;
>  	}
>  	if (flags & O_PATH) {
>  		/* O_PATH only permits certain other flags to be set. */
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index a332e79b3207..4fd07b0e0a17 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -10,7 +10,7 @@
>  	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC |=
 \
>  	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
>  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> -	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> +	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_REGULAR)

Legacy open(2)/openat(2) do not reject invalid flag arguments, which
means that you cannot trivially add a new security-critical flag to them
for two reasons:

 * You cannot easily rely on them because old kernels will not return
   -EINVAL, meaning you cannot be sure that the flag is supported. You
   can try to test-run it, but the operation needs to be a non-dangerous
   operation to try (and caching this has its own issues, such as with
   programs that apply seccomp filters later).

   To be fair, since you reject O_DIRECTORY|O_REGULAR there is a
   relatively easy way to detect this, but the caveats about problems
   with caching still apply.

 * Old programs might pass garbage bits that have been ignored thus far,
   which means that making them have meaning can break userspace. Given
   the age of open(2) this is a very hard thing to guarantee and is one
   of many reasons I wrote openat2(2) and finally added proper flag
   checking.

   This is something your patch doesn't deal with and I don't think can
   be done in a satisfactory way (because the behaviour relies on more
   than just the arguments).

For reference, this is why O_TMPFILE includes O_DIRECTORY and requires
an O_ACCMODE with write bits -- this combination will fail on old
kernels, which allows you to rely on it and also guarantees that no
existing older programs passed that flag combination already and
happened to work on older kernels. This kind of trick won't work for
O_REGULAR, unfortunately.

In my view, this should be an openat2(2)-only API. In addition, I would
propose that (instead of burning another O_* flag bit for this as a
special-purpose API just for regular files) you could have a mask of
which S_IFMT bits should be rejected as a new field in "struct
open_how". This would let you reject sockets or device inodes but permit
FIFOs and regular files or directories, for instance. This could even be
done without a new O_* flag at all (the zero-value how->sfmt_mask would
allow everything and so would work well with extensible structs), but we
could add an O2_* flag anyway.

> +#define ENOTREG		134	/* Not a regular file */
> +

We are probably a little too reticent to add new errnos, but in this
case I think that there should be some description in the commit or
cover letter about why a new errno is needed. ENXIO or
EPROTONOSUPPORT/EPROTOTYPE is what you would typically use (yes, they
aren't a _perfect_ match but one of the common occurrences in syscall
design is to read through errno(7) and figure out what errnos kind of
fit what you need to express).

Then to be fair, the existence of ENOTBLK, ENOTDIR, ENOTSOCK, etc. kind
of justify the existence of ENOTREG too. Unfortunately, you won't be
able to use ENOTREG if you go with my idea of having mask bits in
open_how... (And what errno should we use then...? Hm.)

--=20
Aleksa Sarai
https://www.cyphar.com/

--6di3bgb2h5z3bivc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaXlI/RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/60wD/VvVaRBRhXMQy7cnSMS0M
uHfCA1iC9Y5yxeM1mMcSUOQA/AkGUpoUV2AvY/RFwOiqnGafkiVHT1T4iurwBQ+Z
o20F
=TCKu
-----END PGP SIGNATURE-----

--6di3bgb2h5z3bivc--

