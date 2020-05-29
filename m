Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582841E8AA3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgE2WBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:01:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42371 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728546AbgE2WBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CCXBrdRVsySd/WwGvg6OF0IE99GGjSbx68WGqJoAVXk=;
        b=avUL3+6P0k0g98UlZPGNoWJZb/nEinOCPtPkJwBc2TQNHEquAFZcMLW4TQ5q4mtYry8IyS
        qVtun0+RLLdHv9i7CkFwZTNG0UdXmdgaZdEj/mxTY33DyJghzfCF5rs2Zs5uLxlUJMO+5Q
        U8xj/N88PnqwW81ftlPRNmLoFLYKS9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-7PUdHhfHNaqkybyyzC2t0w-1; Fri, 29 May 2020 18:01:06 -0400
X-MC-Unique: 7PUdHhfHNaqkybyyzC2t0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B63D8107ACCD;
        Fri, 29 May 2020 22:01:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E80FB5C1B5;
        Fri, 29 May 2020 22:01:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/27] afs: Show more information in /proc/net/afs/servers
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:01:04 +0100
Message-ID: <159078966412.679399.3789522973273819502.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Show more information in /proc/net/afs/servers to make it easier to see
what's going on with the server probing.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/proc.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 9bce7898cd7d..1d21465a4108 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -378,21 +378,22 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 	int i;
 
 	if (v == SEQ_START_TOKEN) {
-		seq_puts(m, "UUID                                 REF ACT ADDR\n");
+		seq_puts(m, "UUID                                 REF ACT\n");
 		return 0;
 	}
 
 	server = list_entry(v, struct afs_server, proc_link);
 	alist = rcu_dereference(server->addresses);
-	seq_printf(m, "%pU %3d %3d %pISpc%s\n",
+	seq_printf(m, "%pU %3d %3d\n",
 		   &server->uuid,
 		   atomic_read(&server->ref),
-		   atomic_read(&server->active),
-		   &alist->addrs[0].transport,
-		   alist->preferred == 0 ? "*" : "");
-	for (i = 1; i < alist->nr_addrs; i++)
-		seq_printf(m, "                                             %pISpc%s\n",
-			   &alist->addrs[i].transport,
+		   atomic_read(&server->active));
+	seq_printf(m, "  - ALIST v=%u osp=%u r=%lx f=%lx\n",
+		   alist->version, atomic_read(&server->probe_outstanding),
+		   alist->responded, alist->failed);
+	for (i = 0; i < alist->nr_addrs; i++)
+		seq_printf(m, "    [%x] %pISpc%s\n",
+			   i, &alist->addrs[i].transport,
 			   alist->preferred == i ? "*" : "");
 	return 0;
 }


