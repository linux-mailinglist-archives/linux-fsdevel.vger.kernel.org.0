Return-Path: <linux-fsdevel+bounces-13482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1100A8704F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 16:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDFE1F22F71
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6827346BA0;
	Mon,  4 Mar 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FajJMNLB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFF4653A;
	Mon,  4 Mar 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564980; cv=none; b=DzhecqJmiLkdTz5sasLecoh4rkiHMKpa3lTcFdTRJJKDDOwrcOQbYS9ROy34DcNvdGaPAk7hKZRpkXXlEacsa+I1tq7hSAm5N6VI1x+EBfNMmTwxkATkfD9haoV7EjwohujfsuFsM0SrloMkzgjaHnedgNyMCrNNGHgl/B0RuqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564980; c=relaxed/simple;
	bh=PG1rjx4LEmLpXKkJWVsoLf844fTdWjUTCPiDJTHujUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELp9MPaz0DREmnx7/huI5vfjZ9hOGMnDavbovYzyc61dX1qBxNPTG1nTvfqZxP92zZ8m9bjzDLBkiKNv4ZOpmt8DuypWMlwHK8LxdDdSu9kT3R2qwYk9CDQfNHfBxfQvK9Ofsj1r32M4U5Mk+oAIkO0PNc/yYs537tpcj8/+fjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FajJMNLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589F9C433F1;
	Mon,  4 Mar 2024 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709564980;
	bh=PG1rjx4LEmLpXKkJWVsoLf844fTdWjUTCPiDJTHujUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FajJMNLB8FhOgwdY0SLBjzpKMJ7Z6WUcT9sT4nuMru7X4cuw972O2vShcZHFAc7SW
	 3YFLAF6MJlwyndKH77x3EZl4lyo/iLPSDVZAIKSg7YXloTnkPq1MG5Wjr9FJ5eACVa
	 HCiXjVp9E28hdpvEY7mMoj6OjOOC8LgMvLMIh/nCrw+e9Ti+2iMcLvg80sCl+FX8/R
	 J4xNEpQgtt7+P2CwsIEqQQwCmOGbS3wPBThGKGtntvm/o/HEfsVZiixombXgjCrt2+
	 FO5HzNGAnfqGABc1QfN2ZFHzGRcwfxYTS/Vb3OspEqfu1jkOa6LJxd0Cix/HA6XQ1p
	 sOV1RhAG0H2iw==
Date: Mon, 4 Mar 2024 16:09:26 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Jan Engelhardt <jengelh@inai.de>, linux-man@vger.kernel.org
Subject: Undefined Behavior in rw_verify_area() (was: sendfile(2) erroneously
 yields EINVAL on too large counts)
Message-ID: <ZeXkLYExJHj98oaS@debian>
References: <38nr2286-1o9q-0004-2323-799587773o15@vanv.qr>
 <ZeXSNSxs68FrkLXu@debian>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4xVUwly8Klalbwgk"
Content-Disposition: inline
In-Reply-To: <ZeXSNSxs68FrkLXu@debian>


--4xVUwly8Klalbwgk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 4 Mar 2024 16:09:26 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Jan Engelhardt <jengelh@inai.de>, linux-man@vger.kernel.org
Subject: Undefined Behavior in rw_verify_area() (was: sendfile(2) erroneously
 yields EINVAL on too large counts)

Hi Al,

On Mon, Mar 04, 2024 at 02:52:46PM +0100, Alejandro Colomar wrote:
> (By inspecting the kernel code I'm not sure if it avoids UB; I think it
> might be triggering UB; let me debug that and come with an update.)

It does indeed invoke Undefined Behavior, in some platforms: in those
where 'loff_t' is wider than 'size_t'.

To find this, I applied the following change to the kernel, to make sure
that the program below triggers exactly that error:

	alx@debian:~/src/linux/linux/ub$ git diff
	diff --git a/fs/read_write.c b/fs/read_write.c
	index d4c036e82b6c..0cbc64829143 100644
	--- a/fs/read_write.c
	+++ b/fs/read_write.c
	@@ -370,7 +370,7 @@ int rw_verify_area(int read_write, struct file *file, =
const loff_t *ppos, size_t
					return -EOVERFLOW;
			} else if (unlikely((loff_t) (pos + count) < 0)) {
				if (!unsigned_offsets(file))
	-                               return -EINVAL;
	+                               return -EXFULL;
			}
		}
	=20


And to reproduce it, I used Jan's program:

	alx@debian:~/tmp$ uname -r
	6.8.0-rc7-alx-dirty
	alx@debian:~/tmp$ cat sf0.c=20
	#define _GNU_SOURCE 1
	#include <errno.h>
	#include <fcntl.h>
	#include <limits.h>
	#include <stdio.h>
	#include <string.h>
	#include <unistd.h>
	#include <sys/sendfile.h>

	int main(void)
	{
		int src =3D open(".", O_RDWR | O_TMPFILE, 0666);
		write(src, "1234", 4);
		int dst =3D open(".", O_RDWR | O_TMPFILE, 0666);
		write(src, "1234", 4);
		ssize_t ret =3D sendfile(dst, src, NULL, SSIZE_MAX);
		printf("%ld\n", (long)ret);
		if (ret < 0)
			printf("%s\n", strerror(errno));
		return 0;
	}

	alx@debian:~/tmp$ cc -Wall -Wextra sf0.c=20
	alx@debian:~/tmp$ ./a.out=20
	-1
	Exchange full

(BTW, Jan, you can use 'int main(void)' if you're not going to use argv.
ISO C allows it: <http://port70.net/~nsz/c/c11/n1570.html#5.1.2.2.1>.)

Here's the code invoking UB:

	alx@debian:~/src/linux/linux/ub$ find fs/ -type f \
				| grep '\.c$' \
				| xargs grepc -tfd rw_verify_area;
	fs/read_write.c:int rw_verify_area(int read_write, struct file *file, cons=
t loff_t *ppos, size_t count)
	{
		int mask =3D read_write =3D=3D READ ? MAY_READ : MAY_WRITE;
		int ret;

		if (unlikely((ssize_t) count < 0))
			return -EINVAL;

		if (ppos) {
			loff_t pos =3D *ppos;

			if (unlikely(pos < 0)) {
				if (!unsigned_offsets(file))
					return -EINVAL;
				if (count >=3D -pos) /* both values are in 0..LLONG_MAX */
					return -EOVERFLOW;
			} else if (unlikely((loff_t) (pos + count) < 0)) {
				if (!unsigned_offsets(file))
					return -EXFULL;
			}
		}

		ret =3D security_file_permission(file, mask);
		if (ret)
			return ret;

		return fsnotify_file_area_perm(file, mask, ppos, count);
	}


See that -EXFULL (originally it was -EINVAL; I modified it for
debugging).  'count' is positive, thanks to the first check.  'pos' is
also positive, since we're in the 'else' of 'pos < 0'.  So, let's
analyze the following line of code:

	if (unlikely((loff_t) (pos + count) < 0)) {

'pos' is of type 'loff_t', a signed type.
'count' is of type 'size_t', an unsigned type.

Depending on the width of those types, the sum may be performed as
'loff_t' if `sizeof(loff_t) > sizeof(size_t)`, or as 'size_t' if
`sizeof(loff_t) <=3D sizeof(size_t)`.  Since 'loff_t' is a 64-bit type,
but 'size_t' can be either 32-bit or 64-bit, the former is possible.

In those platforms in which loff_t is wider, the addends are promoted to
'loff_t' before the sum.  And a sum of positive signed values can never
be negative.  If the sum overflows (and the program above triggers
such an overflow), the behavior is undefined.

I suggest the following test:

	if (unlikely(pos > type_max(loff_t) - count)) {

What do you think?  If you agree, I'll send a patch.

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--4xVUwly8Klalbwgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXl5CYACgkQnowa+77/
2zKQHQ/+LXZnCRkEWzkCqdI1c8X4IyloV8XGltfyOO3OGIZdXeBg7s4saEXCqeay
B3mUoQn5wCuhyQUrb38tMO/+CBgRbVai280G0FwPoI8EX0B3X92seXizXSscqOq4
Wx1POaamKVBiZnJRPrUHi3O6EBSbtqAXFevyI85AjpRWmK8rqGqra0kchWYqwo8K
atCxMxOlS0/98QJ+H6qKnZf4XQ5xLxB4udeLdVvkN3hcSfJ3Ua7NNn6hj1qdJ1B9
r3+Jnx9PzxtB/dXkJUN7HMxLYUpoc2fJccVi8/jHOdt9hjey1pkUCwKM682eWDsC
Y6/Ht8+GDTWbzvFdWnC2p0XKyq25h5dKPwVoJMwJQGG1qhfC+nYfDPLVg9AeES2z
2zp882N+sD3XbRlvQFAgWQJuKGvVsCpu1gX8PXerboB+D91922SKN+6CpD7QT1rr
FCjhb+/MCTEcQqX3jCBKqAzT1Z6W8fq8yIu3kW1Gln2VGcJQyijuXqwIPlt4SXn/
GoMyWCE6GoWVjAv/OIMsWyNBGiwGxSu21CJJxj7inVZ1H9GAZr3NIfhHaxgsiaN9
LOiqr1eFCVncH7VdoqiN5zibuBLK6sJfje2CA+A0EBVvvZOeVLC1Y4b/l7vJ4A6k
GtC6RPXX89wjAWKCcD6oBE3kkmEvPrQXYjDmrEeYUkkMWIeIUQ0=
=FRaz
-----END PGP SIGNATURE-----

--4xVUwly8Klalbwgk--

