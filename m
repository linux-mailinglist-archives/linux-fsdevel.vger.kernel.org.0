Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82C733B99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 23:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjFPVkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 17:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjFPVkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25F030F7
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 14:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686951585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=zJIOldJuy+fu1YXH3vSoQYSg40ebqezMIIE6YitueZk=;
        b=BHsY9DFQ+BailO9xUsPLorwBM9arz2HvZCqR0X7SKjejbYkpHxK6vJLdv6hRQe7bUSj2Or
        /RLChUpUylmQXHUTMXjxWIgXwnZ1LXdNKMtsgQ/588bxFISC/53Eo3cao3Ntdu2mBbra2A
        t+UWam4ug0wpQZD+YxX6PAWwH/nC+SI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-5SsXz7YIN9K9CA5JBJ3zRQ-1; Fri, 16 Jun 2023 17:39:41 -0400
X-MC-Unique: 5SsXz7YIN9K9CA5JBJ3zRQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A4F61C07266;
        Fri, 16 Jun 2023 21:39:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E283175AE;
        Fri, 16 Jun 2023 21:39:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix vlserver probe RTT handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <697563.1686951579.1@warthog.procyon.org.uk>
Date:   Fri, 16 Jun 2023 22:39:39 +0100
Message-ID: <697564.1686951579@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you apply this, please?

Thanks,
David
---

In the same spirit as commit ca57f02295f1 ("afs: Fix fileserver
probe RTT handling"), don't rule out using a vlserver just because
there haven't been enough packets yet to calculate a real rtt.
Always set the server's probe rtt from the estimate provided by
rxrpc_kernel_get_srtt, which is capped at 1 second.

This could lead to EDESTADDRREQ errors when accessing a cell for
the first time, even though the vl servers are known and have
responded to a probe.

Fixes: 1d4adfaf6574 ("rxrpc: Make rxrpc_kernel_get_srtt() indicate validity")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
Link: http://lists.infradead.org/pipermail/linux-afs/2023-June/006746.html
---
 fs/afs/vl_probe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index d1c7068b4346..58452b86e672 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -115,8 +115,8 @@ void afs_vlserver_probe_result(struct afs_call *call)
 		}
 	}
 
-	if (rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us) &&
-	    rtt_us < server->probe.rtt) {
+	rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us);
+	if (rtt_us < server->probe.rtt) {
 		server->probe.rtt = rtt_us;
 		server->rtt = rtt_us;
 		alist->preferred = index;

