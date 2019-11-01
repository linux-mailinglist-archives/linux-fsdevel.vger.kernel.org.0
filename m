Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187C8EC7ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 18:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfKARfm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 13:35:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30251 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729803AbfKARfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572629741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2gLZQTmOtfe94PwgELEjIRO8IuV3gWS7pjAAw1ld4Q=;
        b=LWU3p0ikQbApW8GBZRyNBYPVF1420EKSoUdelk9Miu/iTy9ZYUbluIznJOFlfw/1ci/zIU
        0ENhXrAnb8bacE/dvrEckrGiWvV+2bosOVF5lZAxgD1W6iIj4TCfbFZbFrJXDTOPRMmE4x
        2tcEzX2ofjsMExD0jwAVvz43RrOg50c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-c0mbb6TfPoiAsyuG_xveUQ-1; Fri, 01 Nov 2019 13:35:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B4502EDC;
        Fri,  1 Nov 2019 17:35:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C9B160C63;
        Fri,  1 Nov 2019 17:35:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 10/11] pipe: Check for ring full inside of the spinlock
 in pipe_write() [ver #3]
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
Date:   Fri, 01 Nov 2019 17:35:32 +0000
Message-ID: <157262973277.13142.11996381016183033698.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: c0mbb6TfPoiAsyuG_xveUQ-1
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
index d7b8d3f22987..aba2455caabe 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -463,6 +463,11 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 =09=09=09spin_lock_irq(&pipe->wait.lock);
=20
 =09=09=09head =3D pipe->head;
+=09=09=09if (pipe_full(head, pipe->tail, max_usage)) {
+=09=09=09=09spin_unlock_irq(&pipe->wait.lock);
+=09=09=09=09continue;
+=09=09=09}
+
 =09=09=09pipe->head =3D head + 1;
=20
 =09=09=09/* Always wake up, even if the copy fails. Otherwise

