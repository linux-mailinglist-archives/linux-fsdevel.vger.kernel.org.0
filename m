Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70721ECAB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 23:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfKAWFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 18:05:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41144 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726230AbfKAWFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572645935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8+rrZXvUsqeBEaW/X2CqD+QnPOx373OWvmJOxsDZMI=;
        b=CxRV7R5w1tFCKwkn2VITDPE7KNHlgmKWuJ+JSo/antl9wFd7qtfaTorApkuE4BvjGY04AK
        1Au6fQEBqqkE12C6PbksYWE6cT9VYqxfbGjUJNy76jULFBjsRI6RY3qO5RtM6rz1b4YDDV
        lQ7bf1rX3pPXUweE5tFk/E5c2/cjVcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-UyQR-pJ3NNi_-Rohn9Habw-1; Fri, 01 Nov 2019 18:05:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B3CA1005500;
        Fri,  1 Nov 2019 22:05:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 220DF60878;
        Fri,  1 Nov 2019 22:05:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjqx4j2vqg-tAwthNP1gcAcj1x4B7sq6Npbi8QJTUMd-A@mail.gmail.com>
References: <CAHk-=wjqx4j2vqg-tAwthNP1gcAcj1x4B7sq6Npbi8QJTUMd-A@mail.gmail.com> <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/11] pipe: Notification queue preparation [ver #3]
MIME-Version: 1.0
Content-ID: <13963.1572645926.1@warthog.procyon.org.uk>
Date:   Fri, 01 Nov 2019 22:05:26 +0000
Message-ID: <13964.1572645926@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UyQR-pJ3NNi_-Rohn9Habw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Side note: we have a couple of cases where I don't think we should use
> the "sync" version at all.
>=20
> Both pipe_read() and pipe_write() have that
>=20
>         if (do_wakeup) {
>                 wake_up_interruptible_sync_poll(&pipe->wait, ...
>=20
> code at the end, outside the loop. But those two wake-ups aren't
> actually synchronous.

Changing those to non-sync:

BENCHMARK       BEST            TOTAL BYTES     AVG BYTES       STDDEV
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
pipe                  305816126     36255936983       302132808         888=
0788
splice                282402106     27102249370       225852078       21003=
3443
vmsplice              440022611     48896995196       407474959        5990=
6438

Changing the others in pipe_read() and pipe_write() too:

pipe                  305609682     36285967942       302383066         741=
5744
splice                282475690     27891475073       232428958       20168=
7522
vmsplice              451458280     51949421503       432911845        3492=
5242

The cumulative patch is attached below.  I'm not sure how well this should
make a difference with my benchmark programs since each thread can run on i=
ts
own CPU.

David
---
diff --git a/fs/pipe.c b/fs/pipe.c
index 9cd5cbef9552..c5e3765465f0 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -332,7 +332,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 =09=09=09=09do_wakeup =3D 1;
 =09=09=09=09wake =3D head - (tail - 1) =3D=3D pipe->max_usage / 2;
 =09=09=09=09if (wake)
-=09=09=09=09=09wake_up_interruptible_sync_poll_locked(
+=09=09=09=09=09wake_up_locked_poll(
 =09=09=09=09=09=09&pipe->wait, EPOLLOUT | EPOLLWRNORM);
 =09=09=09=09spin_unlock_irq(&pipe->wait.lock);
 =09=09=09=09if (wake)
@@ -371,7 +371,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
=20
 =09/* Signal writers asynchronously that there is more room. */
 =09if (do_wakeup) {
-=09=09wake_up_interruptible_sync_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM)=
;
+=09=09wake_up_interruptible_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
 =09=09kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 =09}
 =09if (ret > 0)
@@ -477,7 +477,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 =09=09=09 * syscall merging.
 =09=09=09 * FIXME! Is this really true?
 =09=09=09 */
-=09=09=09wake_up_interruptible_sync_poll_locked(
+=09=09=09wake_up_locked_poll(
 =09=09=09=09&pipe->wait, EPOLLIN | EPOLLRDNORM);
=20
 =09=09=09spin_unlock_irq(&pipe->wait.lock);
@@ -531,7 +531,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 out:
 =09__pipe_unlock(pipe);
 =09if (do_wakeup) {
-=09=09wake_up_interruptible_sync_poll(&pipe->wait, EPOLLIN | EPOLLRDNORM);
+=09=09wake_up_interruptible_poll(&pipe->wait, EPOLLIN | EPOLLRDNORM);
 =09=09kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 =09}
 =09if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {

