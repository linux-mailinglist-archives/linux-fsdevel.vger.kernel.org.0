Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5CB36939C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243174AbhDWNeh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243274AbhDWNeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619184805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mC6UZgZS53DsmrrUqoG1I9RIPtcyBTSv9JaZsSTUKak=;
        b=Yf6D/V/KN/LcOjFX5Ct0Ekm+XBEuZONX4fXOQPyvlk7t2qMAntgJ6xazoI27TNXB+5fWnV
        h0KH/80sZTgCclscKXZvKuFuUa3ZZzhGl8GfDhAPv8nq3MF/toRXu6U34zUdvtVyhPoqcv
        gBEZa61HRMCk7nuHGMiWyRtMPYXfGr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-QbdVqb4NM_mhErBz4MqBAA-1; Fri, 23 Apr 2021 09:33:23 -0400
X-MC-Unique: QbdVqb4NM_mhErBz4MqBAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9ED10100A91D;
        Fri, 23 Apr 2021 13:33:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 765175C1BB;
        Fri, 23 Apr 2021 13:33:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v7 23/31] afs: Log remote unmarshalling errors
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 23 Apr 2021 14:33:13 +0100
Message-ID: <161918479363.3145707.14161409689432175378.stgit@warthog.procyon.org.uk>
In-Reply-To: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
References: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Log unmarshalling errors reported by the peer (ie. it can't parse what we
sent it).  Limit the maximum number of messages to 3.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-By: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/159465826250.1377938.16372395422217583913.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/160588532584.3465195.15618385466614028590.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161118149739.1232039.208060911149801695.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161046033.2537118.7779717661044373273.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340409118.1303470.17812607349396199116.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539552964.286939.16503232687974398308.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/161653808989.2770958.11530765353025697860.stgit@warthog.procyon.org.uk/ # v5
Link: https://lore.kernel.org/r/161789092349.6155.8581594259882708631.stgit@warthog.procyon.org.uk/ # v6
---

 fs/afs/rxrpc.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 0ec38b758f29..ae68576f822f 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -500,6 +500,39 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	_leave(" = %d", ret);
 }
 
+/*
+ * Log remote abort codes that indicate that we have a protocol disagreement
+ * with the server.
+ */
+static void afs_log_error(struct afs_call *call, s32 remote_abort)
+{
+	static int max = 0;
+	const char *msg;
+	int m;
+
+	switch (remote_abort) {
+	case RX_EOF:		 msg = "unexpected EOF";	break;
+	case RXGEN_CC_MARSHAL:	 msg = "client marshalling";	break;
+	case RXGEN_CC_UNMARSHAL: msg = "client unmarshalling";	break;
+	case RXGEN_SS_MARSHAL:	 msg = "server marshalling";	break;
+	case RXGEN_SS_UNMARSHAL: msg = "server unmarshalling";	break;
+	case RXGEN_DECODE:	 msg = "opcode decode";		break;
+	case RXGEN_SS_XDRFREE:	 msg = "server XDR cleanup";	break;
+	case RXGEN_CC_XDRFREE:	 msg = "client XDR cleanup";	break;
+	case -32:		 msg = "insufficient data";	break;
+	default:
+		return;
+	}
+
+	m = max;
+	if (m < 3) {
+		max = m + 1;
+		pr_notice("kAFS: Peer reported %s failure on %s [%pISp]\n",
+			  msg, call->type->name,
+			  &call->alist->addrs[call->addr_ix].transport);
+	}
+}
+
 /*
  * deliver messages to a call
  */
@@ -563,6 +596,7 @@ static void afs_deliver_to_call(struct afs_call *call)
 			goto out;
 		case -ECONNABORTED:
 			ASSERTCMP(state, ==, AFS_CALL_COMPLETE);
+			afs_log_error(call, call->abort_code);
 			goto done;
 		case -ENOTSUPP:
 			abort_code = RXGEN_OPCODE;


