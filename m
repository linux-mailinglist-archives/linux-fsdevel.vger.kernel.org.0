Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E809151D73
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 16:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgBDPk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 10:40:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46644 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727305AbgBDPk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580830854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dXxOTLkEBtHgvJaBcMBJ+4ieNdzXZNDs1C5kycOcPMA=;
        b=SqnoFxp/o4zB9odm8/02CumIvYpxIXP0GywtQ0CjVaxYGwVCNKiQFMeev07q8N3WmMwuoy
        PFXgqDJHw2vLu2kSIsIG85XpFCxw/a/73V2hHgj7QS5WWX76iRxotI0itvdd9cH7U3ocGL
        FLFQf7HwI5FYidzutxZaRxhJhPResmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-Q-qBMgmKMIeLGuOpXZ5lxg-1; Tue, 04 Feb 2020 10:40:38 -0500
X-MC-Unique: Q-qBMgmKMIeLGuOpXZ5lxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2032286A066;
        Tue,  4 Feb 2020 15:40:37 +0000 (UTC)
Received: from localhost (ovpn-116-121.ams2.redhat.com [10.36.116.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A287587B2F;
        Tue,  4 Feb 2020 15:40:36 +0000 (UTC)
Date:   Tue, 4 Feb 2020 15:40:35 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avi Kivity <avi@scylladb.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masatake YAMATO <yamato@redhat.com>
Subject: Re: [RFC] eventfd: add EFD_AUTORESET flag
Message-ID: <20200204154035.GA47059@stefanha-x1.localdomain>
References: <20200129172010.162215-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200129172010.162215-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 05:20:10PM +0000, Stefan Hajnoczi wrote:
> Some applications simply use eventfd for inter-thread notifications
> without requiring counter or semaphore semantics.  They wait for the
> eventfd to become readable using poll(2)/select(2) and then call read(2)
> to reset the counter.
>=20
> This patch adds the EFD_AUTORESET flag to reset the counter when
> f_ops->poll() finds the eventfd is readable, eliminating the need to
> call read(2) to reset the counter.
>=20
> This results in a small but measurable 1% performance improvement with
> QEMU virtio-blk emulation.  Each read(2) takes 1 microsecond execution
> time in the event loop according to perf.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Does this look like a reasonable thing to do?  I'm not very familiar
> with f_ops->poll() or the eventfd internals, so maybe I'm overlooking a
> design flaw.

Ping?

> I've tested this with QEMU and it works fine:
> https://github.com/stefanha/qemu/commits/eventfd-autoreset
> ---
>  fs/eventfd.c            | 99 +++++++++++++++++++++++++----------------
>  include/linux/eventfd.h |  3 +-
>  2 files changed, 62 insertions(+), 40 deletions(-)
>=20
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index 8aa0ea8c55e8..208f6b9e2234 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -116,45 +116,62 @@ static __poll_t eventfd_poll(struct file *file, pol=
l_table *wait)
> =20
>  =09poll_wait(file, &ctx->wqh, wait);
> =20
> -=09/*
> -=09 * All writes to ctx->count occur within ctx->wqh.lock.  This read
> -=09 * can be done outside ctx->wqh.lock because we know that poll_wait
> -=09 * takes that lock (through add_wait_queue) if our caller will sleep.
> -=09 *
> -=09 * The read _can_ therefore seep into add_wait_queue's critical
> -=09 * section, but cannot move above it!  add_wait_queue's spin_lock act=
s
> -=09 * as an acquire barrier and ensures that the read be ordered properl=
y
> -=09 * against the writes.  The following CAN happen and is safe:
> -=09 *
> -=09 *     poll                               write
> -=09 *     -----------------                  ------------
> -=09 *     lock ctx->wqh.lock (in poll_wait)
> -=09 *     count =3D ctx->count
> -=09 *     __add_wait_queue
> -=09 *     unlock ctx->wqh.lock
> -=09 *                                        lock ctx->qwh.lock
> -=09 *                                        ctx->count +=3D n
> -=09 *                                        if (waitqueue_active)
> -=09 *                                          wake_up_locked_poll
> -=09 *                                        unlock ctx->qwh.lock
> -=09 *     eventfd_poll returns 0
> -=09 *
> -=09 * but the following, which would miss a wakeup, cannot happen:
> -=09 *
> -=09 *     poll                               write
> -=09 *     -----------------                  ------------
> -=09 *     count =3D ctx->count (INVALID!)
> -=09 *                                        lock ctx->qwh.lock
> -=09 *                                        ctx->count +=3D n
> -=09 *                                        **waitqueue_active is false=
**
> -=09 *                                        **no wake_up_locked_poll!**
> -=09 *                                        unlock ctx->qwh.lock
> -=09 *     lock ctx->wqh.lock (in poll_wait)
> -=09 *     __add_wait_queue
> -=09 *     unlock ctx->wqh.lock
> -=09 *     eventfd_poll returns 0
> -=09 */
> -=09count =3D READ_ONCE(ctx->count);
> +=09if (ctx->flags & EFD_AUTORESET) {
> +=09=09unsigned long flags;
> +=09=09__poll_t requested =3D poll_requested_events(wait);
> +
> +=09=09spin_lock_irqsave(&ctx->wqh.lock, flags);
> +=09=09count =3D ctx->count;
> +
> +=09=09/* Reset counter if caller is polling for read */
> +=09=09if (count !=3D 0 && (requested & EPOLLIN)) {
> +=09=09=09ctx->count =3D 0;
> +=09=09=09events |=3D EPOLLOUT;
> +=09=09=09/* TODO is a EPOLLOUT wakeup necessary here? */
> +=09=09}
> +
> +=09=09spin_unlock_irqrestore(&ctx->wqh.lock, flags);
> +=09} else {
> +=09=09/*
> +=09=09 * All writes to ctx->count occur within ctx->wqh.lock.  This read
> +=09=09 * can be done outside ctx->wqh.lock because we know that poll_wai=
t
> +=09=09 * takes that lock (through add_wait_queue) if our caller will sle=
ep.
> +=09=09 *
> +=09=09 * The read _can_ therefore seep into add_wait_queue's critical
> +=09=09 * section, but cannot move above it!  add_wait_queue's spin_lock =
acts
> +=09=09 * as an acquire barrier and ensures that the read be ordered prop=
erly
> +=09=09 * against the writes.  The following CAN happen and is safe:
> +=09=09 *
> +=09=09 *     poll                               write
> +=09=09 *     -----------------                  ------------
> +=09=09 *     lock ctx->wqh.lock (in poll_wait)
> +=09=09 *     count =3D ctx->count
> +=09=09 *     __add_wait_queue
> +=09=09 *     unlock ctx->wqh.lock
> +=09=09 *                                        lock ctx->qwh.lock
> +=09=09 *                                        ctx->count +=3D n
> +=09=09 *                                        if (waitqueue_active)
> +=09=09 *                                          wake_up_locked_poll
> +=09=09 *                                        unlock ctx->qwh.lock
> +=09=09 *     eventfd_poll returns 0
> +=09=09 *
> +=09=09 * but the following, which would miss a wakeup, cannot happen:
> +=09=09 *
> +=09=09 *     poll                               write
> +=09=09 *     -----------------                  ------------
> +=09=09 *     count =3D ctx->count (INVALID!)
> +=09=09 *                                        lock ctx->qwh.lock
> +=09=09 *                                        ctx->count +=3D n
> +=09=09 *                                        **waitqueue_active is fa=
lse**
> +=09=09 *                                        **no wake_up_locked_poll=
!**
> +=09=09 *                                        unlock ctx->qwh.lock
> +=09=09 *     lock ctx->wqh.lock (in poll_wait)
> +=09=09 *     __add_wait_queue
> +=09=09 *     unlock ctx->wqh.lock
> +=09=09 *     eventfd_poll returns 0
> +=09=09 */
> +=09=09count =3D READ_ONCE(ctx->count);
> +=09}
> =20
>  =09if (count > 0)
>  =09=09events |=3D EPOLLIN;
> @@ -400,6 +417,10 @@ static int do_eventfd(unsigned int count, int flags)
>  =09if (flags & ~EFD_FLAGS_SET)
>  =09=09return -EINVAL;
> =20
> +=09/* Semaphore semantics don't make sense when autoreset is enabled */
> +=09if ((flags & EFD_SEMAPHORE) && (flags & EFD_AUTORESET))
> +=09=09return -EINVAL;
> +
>  =09ctx =3D kmalloc(sizeof(*ctx), GFP_KERNEL);
>  =09if (!ctx)
>  =09=09return -ENOMEM;
> diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
> index ffcc7724ca21..27577fafc553 100644
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
> @@ -21,11 +21,12 @@
>   * shared O_* flags.
>   */
>  #define EFD_SEMAPHORE (1 << 0)
> +#define EFD_AUTORESET (1 << 6) /* aliases O_CREAT */
>  #define EFD_CLOEXEC O_CLOEXEC
>  #define EFD_NONBLOCK O_NONBLOCK
> =20
>  #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
> -#define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
> +#define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE | EFD_AUTO=
RESET)
> =20
>  struct eventfd_ctx;
>  struct file;
> --=20
> 2.24.1
>=20

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl45kHMACgkQnKSrs4Gr
c8iTNggApTLgc3Ziv/nmctwnk3zXZZrhBa6QLbwH2UE3fUhcF11wbp+cmfXojaT0
7doSdvRX6otXx6p8apCzWD0SEKKaiTgyuozpumNd8D1B9/mFOWBIH+CA12u5Hsfw
gy006bLnJ3e/p+3UDVdDcVkREAKAnwNEGtr73s8AWD0DyRe4ICqSMRUrHifDeFq3
sy6ecEG9qA5MsYMxG6rjSCbo2zzR1Q/owGYlYuCaLxkgy9XvySns33psZdoTDfPA
yG4pK4da6XFiPVx+uSePzGkdzHgrr4lTEzl3wjNcgtrzNEarLgEoNunh9wFUQaMI
vatzl5WuXU722nBmOXrB2fM29om7Jg==
=vzEC
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

