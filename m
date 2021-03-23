Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B366346CB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhCWWYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233910AbhCWWVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616538104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14QFx/FhyE4y8I4n6Pzhb3Snk1RXVd111br2b+FjT1s=;
        b=JZQBG5JESQtm0A8idrQu6MCe01EJb4RGxWrTXVxndJcyPU3rrqrtTUOLqwKyGdQQEOHlhi
        ZBJZk5nASC9LdXyYDt7b7dsIG+pxQCvljdTwuYlqOsT1kTtQJflAlBZn5LiSOK9YnSmMx9
        VBv2Wzja/wD2q+GrsFxVW5o8DZGvdek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-mvL2ea7qMyu8H_up3g0McQ-1; Tue, 23 Mar 2021 18:21:42 -0400
X-MC-Unique: mvL2ea7qMyu8H_up3g0McQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BAB187A826;
        Tue, 23 Mar 2021 22:21:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B37FC10023B5;
        Tue, 23 Mar 2021 22:21:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v5 20/28] afs: Log remote unmarshalling errors
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 22:21:29 +0000
Message-ID: <161653808989.2770958.11530765353025697860.stgit@warthog.procyon.org.uk>
In-Reply-To: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
References: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Log unmarshalling errors reported by the peer (ie. it can't parse what we
sent it).  Limit the maximum number of messages to 3.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/159465826250.1377938.16372395422217583913.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/160588532584.3465195.15618385466614028590.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161118149739.1232039.208060911149801695.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161046033.2537118.7779717661044373273.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340409118.1303470.17812607349396199116.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539552964.286939.16503232687974398308.stgit@warthog.procyon.org.uk/ # v4
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


