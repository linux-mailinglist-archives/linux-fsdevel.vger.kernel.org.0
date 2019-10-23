Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF38E2463
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407444AbfJWUSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 16:18:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23774 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2407430AbfJWUSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571861899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsICzw/12FA1ze+4AGSV0OSb28CD+mZ6S94YG04i4d8=;
        b=DzY/CDPuESKUdWEZda60BL/+fMCerqej3Xw0sB2sWAB2GYKNnE6Lm86N/apJXHuHpAS1v0
        LqoVGz75iPxb06rn3e++we18gXgVThojNXg7bUu7FnBEnWjb9umuMntO/g/RPu1kVoNfEW
        O/JQXeg+gyj2QP5lY3YYGep3eLO3MHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-GYEDDBkSPA-9sgTXCU1ilg-1; Wed, 23 Oct 2019 16:18:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 340FE107AD31;
        Wed, 23 Oct 2019 20:18:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 637C7600CC;
        Wed, 23 Oct 2019 20:18:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 07/10] pipe: Conditionalise wakeup in pipe_read() [ver
 #2]
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
Date:   Wed, 23 Oct 2019 21:18:10 +0100
Message-ID: <157186189069.3995.10292601951655075484.stgit@warthog.procyon.org.uk>
In-Reply-To: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GYEDDBkSPA-9sgTXCU1ilg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Only do a wakeup in pipe_read() if we made space in a completely full
buffer.  The producer shouldn't be waiting on pipe->wait otherwise.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 1274305772fb..e3a8f10750c9 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -327,11 +327,13 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 =09=09=09=09spin_lock_irq(&pipe->wait.lock);
 =09=09=09=09tail++;
 =09=09=09=09pipe_commit_read(pipe, tail);
-=09=09=09=09do_wakeup =3D 0;
-=09=09=09=09wake_up_interruptible_sync_poll_locked(
-=09=09=09=09=09&pipe->wait, EPOLLOUT | EPOLLWRNORM);
+=09=09=09=09do_wakeup =3D 1;
+=09=09=09=09if (head - (tail - 1) =3D=3D pipe->max_usage)
+=09=09=09=09=09wake_up_interruptible_sync_poll_locked(
+=09=09=09=09=09=09&pipe->wait, EPOLLOUT | EPOLLWRNORM);
 =09=09=09=09spin_unlock_irq(&pipe->wait.lock);
-=09=09=09=09kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
+=09=09=09=09if (head - (tail - 1) =3D=3D pipe->max_usage)
+=09=09=09=09=09kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 =09=09=09}
 =09=09=09total_len -=3D chars;
 =09=09=09if (!total_len)
@@ -360,11 +362,6 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 =09=09=09=09ret =3D -ERESTARTSYS;
 =09=09=09break;
 =09=09}
-=09=09if (do_wakeup) {
-=09=09=09wake_up_interruptible_sync_poll(&pipe->wait, EPOLLOUT | EPOLLWRNO=
RM);
- =09=09=09kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
-=09=09=09do_wakeup =3D 0;
-=09=09}
 =09=09pipe_wait(pipe);
 =09}
 =09__pipe_unlock(pipe);

