Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006BA10557A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 16:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKUP00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 10:26:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51131 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726658AbfKUP00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574349985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1O8R3g+RY/ULKTfO6bXtG8ZXjTQs/NUP/a7VNwETFWY=;
        b=Q4XelS6LZRzlRVvX2Fx1YK70kph1XrRog8f+IlGeusVcRcn+gBFqzCMWRWxfoz5+3gv1Pn
        6FK+zun4/BDtSIzpwp8KTDoEl+i6POF7EK+rw1ySFA9E4XphNhX8NjUSuvU8yBFhHxL1GO
        ELCvHkBikoD5L/gkuT2WNXVIrcqkW2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-6mxCoIUlPAS30GEnpQ80Eg-1; Thu, 21 Nov 2019 10:26:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBCD7477;
        Thu, 21 Nov 2019 15:26:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-161.rdu2.redhat.com [10.10.120.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 720CE60C23;
        Thu, 21 Nov 2019 15:26:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix possible assert with callbacks from yfs servers
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Nov 2019 15:26:15 +0000
Message-ID: <157434997544.8060.6772407595047113730.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 6mxCoIUlPAS30GEnpQ80Eg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

Servers sending callback breaks to the YFS_CM_SERVICE service may
send up to YFSCBMAX (1024) fids in a single RPC.  Anything over
AFSCBMAX (50) will cause the assert in afs_break_callbacks to trigger.

Remove the assert, as the count has already been checked against
the appropriate max values in afs_deliver_cb_callback and
afs_deliver_yfs_cb_callback.

Fixes: 35dbfba3111a ("afs: Implement the YFS cache manager service")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/callback.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 6cdd7047c809..2dca8df1a18d 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -312,7 +312,6 @@ void afs_break_callbacks(struct afs_server *server, siz=
e_t count,
 =09_enter("%p,%zu,", server, count);
=20
 =09ASSERT(server !=3D NULL);
-=09ASSERTCMP(count, <=3D, AFSCBMAX);
=20
 =09/* TODO: Sort the callback break list by volume ID */
=20

