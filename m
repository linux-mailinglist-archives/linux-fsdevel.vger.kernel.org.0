Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B2D102DD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 22:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKSVAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 16:00:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51840 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726711AbfKSVAo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574197243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SfJF//RHUtnN8ZNiGvqInwcMiBwPOPwFchLayKBNSGc=;
        b=VVNEsJKcKuIVUxJpAHJEhJza+bvP3rN4e30VzUVEko4ZeEqn4LBsYX3iHmqvekzz3jZrmt
        kCcDcNyuIAUSskzOG7ykix3o24ST/iOuTmF6LDFPMrAa8tDbzjX58aNmy+edWGXCIYZFQ7
        vhHP9NTPkkyq1fjt1umaVTQO4a749/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-pV0OOeMxP9Sn97oUKzHXYA-1; Tue, 19 Nov 2019 16:00:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05D14477;
        Tue, 19 Nov 2019 21:00:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-161.rdu2.redhat.com [10.10.120.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8FB962926;
        Tue, 19 Nov 2019 21:00:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix missing timeout reset
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 19 Nov 2019 21:00:36 +0000
Message-ID: <157419723680.5784.6298499053943932392.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: pV0OOeMxP9Sn97oUKzHXYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In afs_wait_for_call_to_complete(), rather than immediately aborting an
operation if a signal occurs, the code attempts to wait for it to complete,
using a schedule timeout of 2*RTT (or min 2 jiffies) and a check that we're
still receiving relevant packets from the server before we consider
aborting the call.  We may even ping the server to check on the status of
the call.

However, there's a missing timeout reset in the event that we do actually
get a packet to process, such that if we then get a couple of short stalls,
we then time out when progress is actually being made.

Fix this by resetting the timeout any time we get something to process.  If
it's the failure of the call then the call state will get changed and we'll
exit the loop shortly thereafter.

A symptom of this is data fetches and stores failing with EINTR when they
really shouldn't.

Fixes: bc5e3a546d55 ("rxrpc: Use MSG_WAITALL to tell sendmsg() to temporari=
ly ignore signals")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
---

 fs/afs/rxrpc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 0e5269374ac1..61498d9f06ef 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -637,6 +637,7 @@ long afs_wait_for_call_to_complete(struct afs_call *cal=
l,
 =09=09=09call->need_attention =3D false;
 =09=09=09__set_current_state(TASK_RUNNING);
 =09=09=09afs_deliver_to_call(call);
+=09=09=09timeout =3D rtt2;
 =09=09=09continue;
 =09=09}
=20

