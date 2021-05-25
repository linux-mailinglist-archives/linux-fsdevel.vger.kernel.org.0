Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12285390428
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 16:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhEYOmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 10:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232939AbhEYOmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 10:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621953635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=njoB89ftAHN7n/O/lGgRgd4/0s+fvP1HkvXPNe11cV8=;
        b=NMwvaXIgUP7HoTzJTrVFdm6Zmjtw644vut7QuMiM0MGh1FKQzcf1jiYXJHDkKnN6mmD+ZW
        NEDaCxcEaEZHorxsq6uKX+nQQPjJz4BDV8xBKA5m1hiN5Rl3SRPIIrEHk6EP+FfjSyXUGM
        UoaTo7t405oirW371GJ/A6ySM4RWct0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-e7mfoCAQPNuClKFKU0Mv3A-1; Tue, 25 May 2021 10:40:30 -0400
X-MC-Unique: e7mfoCAQPNuClKFKU0Mv3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 247061926DA1;
        Tue, 25 May 2021 14:40:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 112AA2BFE6;
        Tue, 25 May 2021 14:40:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix fall-through warnings for Clang
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org, linux-hardening@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 May 2021 15:40:22 +0100
Message-ID: <162195362220.4082674.5166981803589803097.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gustavo A. R. Silva <gustavoars@kernel.org>

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding multiple fallthrough pseudo-keywords
in places where the code is intended to fall through to the next
case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-hardening@vger.kernel.org
Link: https://lore.kernel.org/r/51150b54e0b0431a2c401cd54f2c4e7f50e94601.1605896059.git.gustavoars@kernel.org/ # v1
Link: https://lore.kernel.org/r/20210420211615.GA51432@embeddedor/ # v2
---

 fs/afs/cmservice.c |    5 +++++
 fs/afs/fsclient.c  |    4 ++++
 fs/afs/vlclient.c  |    1 +
 3 files changed, 10 insertions(+)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index a4e9e6e07e93..d3c6bb22c5f4 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -322,6 +322,8 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 			return ret;
 
 		call->unmarshall++;
+		fallthrough;
+
 	case 5:
 		break;
 	}
@@ -418,6 +420,7 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 			r->node[loop] = ntohl(b[loop + 5]);
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 2:
 		break;
@@ -530,6 +533,7 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 			r->node[loop] = ntohl(b[loop + 5]);
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 2:
 		break;
@@ -663,6 +667,7 @@ static int afs_deliver_yfs_cb_callback(struct afs_call *call)
 
 		afs_extract_to_tmp(call);
 		call->unmarshall++;
+		fallthrough;
 
 	case 3:
 		break;
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 2f695a260442..dd3f45d906d2 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -388,6 +388,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		req->file_size = vp->scb.status.size;
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 5:
 		break;
@@ -1408,6 +1409,7 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		_debug("motd '%s'", p);
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 8:
 		break;
@@ -1845,6 +1847,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		xdr_decode_AFSVolSync(&bp, &op->volsync);
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 6:
 		break;
@@ -1979,6 +1982,7 @@ static int afs_deliver_fs_fetch_acl(struct afs_call *call)
 		xdr_decode_AFSVolSync(&bp, &op->volsync);
 
 		call->unmarshall++;
+		fallthrough;
 
 	case 4:
 		break;
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index dc9327332f06..00fca3c66ba6 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -593,6 +593,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		if (ret < 0)
 			return ret;
 		call->unmarshall = 6;
+		fallthrough;
 
 	case 6:
 		break;


