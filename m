Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8846535B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 18:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiLUR6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 12:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLUR6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:58:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D67E24BCB
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 09:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671645454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2gEJyusN5Ipvt3Iad06WmA0oIA7Da8xXQiWmsnP9s38=;
        b=IiCISb/U6htcI5gYbekBvO3orQ/4Q/Z7IZnByAvbu4TtWlKWHMG2lyMfcI78MEiJDwuilE
        C6FDUhmZgsP2lnV5yyCbQ56qfkCIw45sNTOkuLZPCDW4uGxNpG0kQvGe0eW2Nk6Adl57bt
        N2VOvAAzQTfbN4DSnNcpdc0ybkHy9vA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-zvXOLrfzOgCyzTtW8SAZWA-1; Wed, 21 Dec 2022 12:57:31 -0500
X-MC-Unique: zvXOLrfzOgCyzTtW8SAZWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EC84811E6E;
        Wed, 21 Dec 2022 17:57:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEC82112132C;
        Wed, 21 Dec 2022 17:57:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix lost servers_outstanding count
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 21 Dec 2022 17:57:29 +0000
Message-ID: <167164544917.2072364.3759519569649459359.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The afs_fs_probe_dispatcher() work function is passed a count on
net->servers_outstanding when it is scheduled (which may come via its
timer).  This is passed back to the work_item, passed to the timer or
dropped at the end of the dispatcher function.

But, at the top of the dispatcher function, there are two checks which
skip the rest of the function: if the network namespace is being destroyed
or if there are no fileservers to probe.  These two return paths, however,
do not drop the count passed to the dispatcher, and so, sometimes, the
destruction of a network namespace, such as induced by rmmod of the kafs
module, may get stuck in afs_purge_servers(), waiting for
net->servers_outstanding to become zero.

Fix this by adding the missing decrements in afs_fs_probe_dispatcher().

Fixes: f6cbb368bcb0 ("afs: Actively poll fileservers to maintain NAT or firewall openings")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/fs_probe.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 3ac5fcf98d0d..daaf3810cc92 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -366,12 +366,15 @@ void afs_fs_probe_dispatcher(struct work_struct *work)
 	unsigned long nowj, timer_at, poll_at;
 	bool first_pass = true, set_timer = false;
 
-	if (!net->live)
+	if (!net->live) {
+		afs_dec_servers_outstanding(net);
 		return;
+	}
 
 	_enter("");
 
 	if (list_empty(&net->fs_probe_fast) && list_empty(&net->fs_probe_slow)) {
+		afs_dec_servers_outstanding(net);
 		_leave(" [none]");
 		return;
 	}


