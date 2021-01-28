Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AD530819B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 23:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhA1W6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 17:58:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:37572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbhA1W5S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:57:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 357B3AE56;
        Thu, 28 Jan 2021 22:56:26 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Xin Long <lucien.xin@gmail.com>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 29 Jan 2021 09:56:17 +1100
Cc:     NeilBrown <neilb@suse.com>
Subject: Re: [PATCH] seq_read: move count check against iov_iter_count after
 calling op show
In-Reply-To: <91568e002fed69425485c17de223bef0ff660f3a.1611313420.git.lucien.xin@gmail.com>
References: <91568e002fed69425485c17de223bef0ff660f3a.1611313420.git.lucien.xin@gmail.com>
Message-ID: <87r1m4fz72.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22 2021, Xin Long wrote:

> In commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code
> and interface"), it broke a behavior: op show() is always called when op
> next() returns an available obj.

Interesting.  I was not aware that some callers assumed this guarantee.
If we are going to support it (which seems reasonable) we should add a
statement of this guarantee to the documentation -
Documentation/filesystems/seq_file.rst.
Maybe a new paragraph after "Finally, the show() function ..."

   Note that show() will *always* be called after a successful start()
   or next() call, so that it can release any resources (such as
   ref-counts) that was acquired by those calls.


>
> This caused a refcnt leak in net/sctp/proc.c, as of the seq_operations
> sctp_assoc_ops, transport obj is held in op next() and released in op
> show().
>
> Here fix it by moving count check against iov_iter_count after calling
> op show() so that op show() can still be called when op next() returns
> an available obj.
>
> Note that m->index needs to increase so that op start() could go fetch
> the next obj in the next round.

This is certainly wrong.
As the introduction in my patch said:

    A large part of achieving this is to *always* call ->next after ->show
    has successfully stored all of an entry in the buffer.  Never just
    increment the index instead.

Incrementing ->index in common seq_file code is wrong.

As we are no longer calling ->next after a successful ->show, we need to
make that ->show appear unsuccessful so that it will be retried.  This
is done be setting "m->count =3D offs".
So the moved code below becomes

  if (m->count >=3D iov_iter_count(iter)) {
  	/* That record is more than we want, so discard it */
        m->count =3D offs;
        break;
  }

Possibly that can be merged into the preceding 'if'.

Also the traverse() function contains a call to ->next that is not
reliably followed by a call to ->show, even when successful.  That needs
to be fixed too.

Thanks,
NeilBrown

=20=20=20=20=20=20=20=20

>
> Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and=
 interface")
> Reported-by: Prijesh <prpatel@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  fs/seq_file.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 03a369c..da304f7 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -264,8 +264,6 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_=
iter *iter)
>  		}
>  		if (!p || IS_ERR(p))	// no next record for us
>  			break;
> -		if (m->count >=3D iov_iter_count(iter))
> -			break;
>  		err =3D m->op->show(m, p);
>  		if (err > 0) {		// ->show() says "skip it"
>  			m->count =3D offs;
> @@ -273,6 +271,10 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov=
_iter *iter)
>  			m->count =3D offs;
>  			break;
>  		}
> +		if (m->count >=3D iov_iter_count(iter)) {
> +			m->index++;
> +			break;
> +		}
>  	}
>  	m->op->stop(m, p);
>  	n =3D copy_to_iter(m->buf, m->count, iter);
> --=20
> 2.1.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmATQRQOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmBmw//ZgljgQEZM9tSIHvyHES5/JJuA6zPo/0DVbV5
/GZcGgGM/vXR1+4YcGp0eGXxm1WAq/3mcQvIAMwy6uQvWOHnU2G5qUOB2CO0SkdD
xR3Hta0I2atXXRErkVNL0/R8MAUAg54jMRe6yMQy6eSgm724Qml2+5/oP3hR4LwI
vZXGuZ5O9wZqIvz2VnAmEMe0w+MPWCeGZyYfPh3KlUL53/MNxAO4ePu+aZX0vUeE
NrGBi3D1sJp+8bLgDnVh5oX8GlLEpzZsozwFQdSQT2YS25gKArEmbOq5gIEV3FP9
U0Bz4C+gLwzzQn0ballrGjc6H+cHGdRgGBzLNPlh7wXgFaaPeaUA7MfZjDsTRoo9
QIffI3Haq39NfGY8kU8ii5uEL/1kbsg6Gb1/d1iRBxuM2hBuT0jXYRKi1exoNuXd
YGyes5UiOxocir30Kk9tHEl9E0EwvzyhMO0N8w1rCgSLKWlUTBdFNKtZgYaECtNh
6EzaX+3FkzFo2s8eE4EWPpQV02W8mVlwz7tUJ5jj2zj7TUYDQvldwDjlFlrB1BDL
1bhM8vPRAWLa4ZkE5WK3PsmMTpo6vcxekV+Aptfwvuk3FPSrLLlAHGqv1c0ssva1
luuuWAp+lO/cntSep6re5nQoBX3oAG/MJqtq5MC1eP9UHSheRq03J+fTb6HZFV3V
KOTVvc4=
=s/XX
-----END PGP SIGNATURE-----
--=-=-=--
