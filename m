Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F061E8AB6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgE2WCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:02:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24100 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728636AbgE2WB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emX2EPuaIRfL2JQ+lnt/FptoIqC63nhokt9pEyTTiDs=;
        b=V+h+Gvied3iBXIqaHo/Wlv66OjRF+rPbq+bXoCEBX8Nv9rhxt0fXvWp6Fjbh4/72/n718S
        guMLa0Or7y8Rn16a03OBkOvdPNy9njm9bQRK6mi3RQ2j5D3PIKPhqaY01X9v6rQhFQbSWT
        l+ZCLsx672hvcL47TvWOd3JcXPvi5+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-DipWKtBNN4OoX-h-v7OK3A-1; Fri, 29 May 2020 18:01:57 -0400
X-MC-Unique: DipWKtBNN4OoX-h-v7OK3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0280780183C;
        Fri, 29 May 2020 22:01:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D55660BF3;
        Fri, 29 May 2020 22:01:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/27] afs: Fix handling of CB.ProbeUuid cache manager op
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:01:54 +0100
Message-ID: <159078971446.679399.12954025261713723881.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The AFS filesystem driver is handling the CB.ProbeUuid request incorrectly.
The UUID presented in the request is that of the cache manager, not the
fileserver, so afs_deliver_cb_probe_uuid() shouldn't be using that UUID to
look up the server.

Fix this by looking up the server by address instead.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cmservice.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 954030ae7a0f..bef413818af7 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -464,7 +464,8 @@ static int afs_deliver_cb_probe(struct afs_call *call)
 }
 
 /*
- * allow the fileserver to quickly find out if the fileserver has been rebooted
+ * Allow the fileserver to quickly find out if the cache manager has been
+ * rebooted.
  */
 static void SRXAFSCB_ProbeUuid(struct work_struct *work)
 {
@@ -536,7 +537,7 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
 		return afs_io_error(call, afs_io_error_cm_reply);
-	return afs_find_cm_server_by_uuid(call, call->request);
+	return afs_find_cm_server_by_peer(call);
 }
 
 /*


