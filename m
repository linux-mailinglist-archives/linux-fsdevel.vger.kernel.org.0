Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97F5EC7EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 18:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfKARfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 13:35:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60065 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729939AbfKARfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572629750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vi11bsC86DIjvR3JukBeRWivqFrcNqVuRmOTzZJ3x6E=;
        b=ATN+ZACaQxhHrOMEJVgoBf/W41sr40yN4v97GH3Rg+f+WQpJQ3GBSyVpmV7SPsN2oGJUu1
        rMQKwXsB2O5IZuD/AS71e84Pj5W4ULhJvHt0QRudHeJG55oDwnzAo9nU5LZs5MfnKE0YYY
        V3/A2wvJnA3RpXYpr7yOyVXwgan8iGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-jObNGFxmMiqYnw6I3pTN-A-1; Fri, 01 Nov 2019 13:35:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03A9A800D49;
        Fri,  1 Nov 2019 17:35:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C6B45D6B7;
        Fri,  1 Nov 2019 17:35:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 11/11] pipe: Increase the writer-wakeup threshold to
 reduce context-switch count [ver #3]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 01 Nov 2019 17:35:41 +0000
Message-ID: <157262974145.13142.5910403713310791673.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: jObNGFxmMiqYnw6I3pTN-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Increase the threshold at which the reader sends a wake event to the
writers in the queue such that the queue must be half empty before the wake
is issued rather than the wake being issued when just a single slot
available.

This reduces the number of context switches in the tests significantly,
without altering the amount of work achieved.  With my pipe-bench program,
there's a 20% reduction versus an unpatched kernel.

Suggested-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index aba2455caabe..9cd5cbef9552 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -324,16 +324,18 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 =09=09=09}
=20
 =09=09=09if (!buf->len) {
+=09=09=09=09bool wake;
 =09=09=09=09pipe_buf_release(pipe, buf);
 =09=09=09=09spin_lock_irq(&pipe->wait.lock);
 =09=09=09=09tail++;
 =09=09=09=09pipe->tail =3D tail;
 =09=09=09=09do_wakeup =3D 1;
-=09=09=09=09if (head - (tail - 1) =3D=3D pipe->max_usage)
+=09=09=09=09wake =3D head - (tail - 1) =3D=3D pipe->max_usage / 2;
+=09=09=09=09if (wake)
 =09=09=09=09=09wake_up_interruptible_sync_poll_locked(
 =09=09=09=09=09=09&pipe->wait, EPOLLOUT | EPOLLWRNORM);
 =09=09=09=09spin_unlock_irq(&pipe->wait.lock);
-=09=09=09=09if (head - (tail - 1) =3D=3D pipe->max_usage)
+=09=09=09=09if (wake)
 =09=09=09=09=09kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 =09=09=09}
 =09=09=09total_len -=3D chars;

