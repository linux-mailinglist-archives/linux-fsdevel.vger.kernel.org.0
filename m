Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D49001498A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2020 05:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgAZEDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jan 2020 23:03:40 -0500
Received: from mout-p-102.mailbox.org ([80.241.56.152]:45724 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgAZEDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jan 2020 23:03:40 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 484zkw5BGZzKmmL;
        Sun, 26 Jan 2020 05:03:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id 5GIkHq8nVH0q; Sun, 26 Jan 2020 05:03:32 +0100 (CET)
Date:   Sun, 26 Jan 2020 15:03:25 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, christian.brauner@ubuntu.com
Subject: Re: [PATCH 3/4] seccomp: Add SECCOMP_USER_NOTIF_FLAG_PIDFD to get
 pidfd on listener trap
Message-ID: <20200126040325.5eimmm7hli5qcqrr@yavin.dot.cyphar.com>
References: <20200124091743.3357-1-sargun@sargun.me>
 <20200124091743.3357-4-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="agr6povy326nigo3"
Content-Disposition: inline
In-Reply-To: <20200124091743.3357-4-sargun@sargun.me>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--agr6povy326nigo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-24, Sargun Dhillon <sargun@sargun.me> wrote:
> This introduces the capability for users of seccomp's listener behaviour
> to be able to receive the pidfd of the process that triggered the event.
> Currently, this just opens the group leader of the thread that triggere
> the event, as pidfds (currently) are limited to group leaders.
>=20
> For actions which do not act on the process outside of the pidfd, there
> is then no need to check the cookie to ensure validity of the request
> throughout the listener's handling of it.
>=20
> This can be extended later on as well when pidfd capabilities are added
> to be able to have the listener imbue the pidfd with certain capabilities
> when it is delivered to userspace.
>=20
> It is the responsibility of the user to close the pidfd.
>=20
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  include/uapi/linux/seccomp.h |  4 +++
>  kernel/seccomp.c             | 68 ++++++++++++++++++++++++++++++++----
>  2 files changed, 66 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index be84d87f1f46..64f6fc5c95f1 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -69,11 +69,15 @@ struct seccomp_notif_sizes {
>  	__u16 seccomp_data;
>  };
> =20
> +/* Valid flags for struct seccomp_notif */
> +#define SECCOMP_USER_NOTIF_FLAG_PIDFD	(1UL << 0) /* populate pidfd */
> +
>  struct seccomp_notif {
>  	__u64 id;
>  	__u32 pid;
>  	__u32 flags;
>  	struct seccomp_data data;
> +	__u32 pidfd;
>  };
> =20
>  /*
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index b6ea3dcb57bf..93f9cf45ce07 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1019,21 +1019,61 @@ static int seccomp_notify_release(struct inode *i=
node, struct file *file)
>  	return 0;
>  }
> =20
> +
> +static long __seccomp_notify_recv_pidfd(void __user *buf,
> +					struct seccomp_notif *unotif,
> +					struct task_struct *group_leader)
> +{
> +	struct file *pidfd_file;
> +	struct pid *pid;
> +	int fd;
> +
> +	pid =3D get_task_pid(group_leader, PIDTYPE_PID);
> +	pidfd_file =3D pidfd_create_file(pid);
> +	put_pid(pid);
> +	if (IS_ERR(pidfd_file))
> +		return PTR_ERR(pidfd_file);
> +
> +	fd =3D get_unused_fd_flags(O_RDWR | O_CLOEXEC);

You don't need to pass O_RDWR -- only O_CLOEXEC is checked by
get_unused_fd_flags().

> +	if (fd < 0) {
> +		fput(pidfd_file);
> +		return fd;
> +	}
> +
> +	unotif->pidfd =3D fd;
> +
> +	if (copy_to_user(buf, unotif, sizeof(*unotif))) {
> +		put_unused_fd(fd);
> +		fput(pidfd_file);
> +		return -EFAULT;
> +	}
> +
> +	fd_install(fd, pidfd_file);
> +
> +	return 0;
> +}
> +
>  static long seccomp_notify_recv(struct seccomp_filter *filter,
>  				void __user *buf)
>  {
>  	struct seccomp_knotif *knotif =3D NULL, *cur;
>  	struct seccomp_notif unotif;
> +	struct task_struct *group_leader;
> +	bool send_pidfd;
>  	ssize_t ret;
> =20
> +	if (copy_from_user(&unotif, buf, sizeof(unotif)))
> +		return -EFAULT;
>  	/* Verify that we're not given garbage to keep struct extensible. */
> -	ret =3D check_zeroed_user(buf, sizeof(unotif));
> -	if (ret < 0)
> -		return ret;
> -	if (!ret)
> +	if (unotif.id ||
> +	    unotif.pid ||
> +	    memchr_inv(&unotif.data, 0, sizeof(unotif.data)) ||
> +	    unotif.pidfd)
> +		return -EINVAL;

IMHO this check is more confusing than the original check_zeroed_user().
Something like the following is simpler and less prone to forgetting to
add a new field in the future:

	if (memchr_inv(&unotif, 0, sizeof(unotif)))
		return -EINVAL;

> +	if (unotif.flags & ~(SECCOMP_USER_NOTIF_FLAG_PIDFD))
>  		return -EINVAL;
> =20
> -	memset(&unotif, 0, sizeof(unotif));
> +	send_pidfd =3D unotif.flags & SECCOMP_USER_NOTIF_FLAG_PIDFD;
> =20
>  	ret =3D down_interruptible(&filter->notif->request);
>  	if (ret < 0)
> @@ -1057,9 +1097,13 @@ static long seccomp_notify_recv(struct seccomp_fil=
ter *filter,
>  		goto out;
>  	}
> =20
> +	memset(&unotif, 0, sizeof(unotif));
> +
>  	unotif.id =3D knotif->id;
>  	unotif.pid =3D task_pid_vnr(knotif->task);
>  	unotif.data =3D *(knotif->data);
> +	if (send_pidfd)
> +		group_leader =3D get_task_struct(knotif->task->group_leader);
> =20
>  	knotif->state =3D SECCOMP_NOTIFY_SENT;
>  	wake_up_poll(&filter->notif->wqh, EPOLLOUT | EPOLLWRNORM);
> @@ -1067,9 +1111,21 @@ static long seccomp_notify_recv(struct seccomp_fil=
ter *filter,
>  out:
>  	mutex_unlock(&filter->notify_lock);
> =20
> -	if (ret =3D=3D 0 && copy_to_user(buf, &unotif, sizeof(unotif))) {
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * We've successfully received a notification, let's try to copy it to
> +	 * userspace.
> +	 */
> +	if (send_pidfd) {
> +		ret =3D __seccomp_notify_recv_pidfd(buf, &unotif, group_leader);
> +		put_task_struct(group_leader);
> +	} else if (copy_to_user(buf, &unotif, sizeof(unotif))) {
>  		ret =3D -EFAULT;
> +	}

To my eye, the way this helper is used is a bit ugly -- my first
question when reading this was "why aren't we doing a copy_to_user() for
pidfds?".

Something like the following might be a bit cleaner I think:

	struct file *pidfd_file =3D NULL;

	if (send_pidfd) {
		// helper allocates the pidfd_file and sets unotify->fd
		ret =3D __seccomp_notify_recv_pidfd(&unotify, &pidfd_file)
		if (ret)
			goto err; // or whatever
	}

	if (copy_to_user(buf, &unotif, sizeof(unotif))) {
		ret =3D -EFAULT;
		goto err; // or whatever
	}

	if (send_pidfd)
		fd_install(unotif.fd, pidfd_file)

But to be fair, this is also somewhat ugly too.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--agr6povy326nigo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXi0PigAKCRCdlLljIbnQ
EomfAQDluboSG8nfIYj8GB8Y2ZpECxaq+0rPYsy1fBipnRcdIQD9F7MsqSvwf1oL
IB6sETPcTLtpv1LXQe7sALgl4CnbKgE=
=WWGx
-----END PGP SIGNATURE-----

--agr6povy326nigo3--
