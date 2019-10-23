Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038F1E2478
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 22:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407484AbfJWUSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 16:18:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57973 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406050AbfJWUSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571861923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pfelg5hi6R03mZ1vLzjmM92WqqQzhNWSQkGO0kPCCJs=;
        b=B0eUpqt2EP8NXF/ly/xVUVebv1FWnyl2Vy6lx0e3fcL/+dUTZfhaatQi0zvCxonmQI15d5
        cc1uO+oipRATEB9dODS34rRJBC2CuxLvyVnhKKi3BF0J3c3IaePmj+OpvDRMSP0Vdeundk
        +VKtlWglqCHQvUOyNdzOcpaQwTD3oYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-jlueH4OLP0adVaz8-ap9CA-1; Wed, 23 Oct 2019 16:18:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04489100551A;
        Wed, 23 Oct 2019 20:18:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F5615DC18;
        Wed, 23 Oct 2019 20:18:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 10/10] pipe: Check for ring full inside of the spinlock
 in pipe_write() [ver #2]
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
Date:   Wed, 23 Oct 2019 21:18:36 +0100
Message-ID: <157186191654.3995.6474781916564747415.stgit@warthog.procyon.org.uk>
In-Reply-To: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: jlueH4OLP0adVaz8-ap9CA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make pipe_write() check to see if the ring has become full between it
taking the pipe mutex, checking the ring status and then taking the
spinlock.

This can happen if a notification is written into the pipe as that happens
without the pipe mutex.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index 3df93990dd9d..6a982a88f658 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -462,6 +462,11 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 =09=09=09spin_lock_irq(&pipe->wait.lock);
=20
 =09=09=09head =3D pipe->head;
+=09=09=09if (pipe_full(head, pipe->tail, max_usage)) {
+=09=09=09=09spin_unlock_irq(&pipe->wait.lock);
+=09=09=09=09continue;
+=09=09=09}
+
 =09=09=09pipe_commit_write(pipe, head + 1);
=20
 =09=09=09/* Always wake up, even if the copy fails. Otherwise

