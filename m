Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E08763B496
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 23:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiK1WEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 17:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiK1WED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:04:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D384205C4
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 14:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669672984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xPbpoVxrgjiZ1v3Q2JskuQaETCCbk7MGRQwhwRfymp0=;
        b=EFrROx1FBeaStuHExh3QbKR+jfhsG08c2R86lHCplRdbTXfpRS5HjLuyHIYXrHi35ZJRmH
        aNxGKg8mwnuwVY8I1hEbHcrR4T9FJXpm9K5QCgbfFpocWMyOmROoNAeGfb462rvdGDL+Lc
        4vM/cd9rBAoE3fmnwv7sraarKwybSe4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-R_KxuDuRMS6e_XWpvLpXFQ-1; Mon, 28 Nov 2022 17:03:00 -0500
X-MC-Unique: R_KxuDuRMS6e_XWpvLpXFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2A60811E81;
        Mon, 28 Nov 2022 22:02:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E08421415100;
        Mon, 28 Nov 2022 22:02:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix fileserver probe RTT handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3528468.1669672976.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 28 Nov 2022 22:02:56 +0000
Message-ID: <3528469.1669672976@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you apply this patch, please?

Thanks,
David
---
The fileserver probing code attempts to work out the best fileserver to us=
e
for a volume by retrieving the RTT calculated by AF_RXRPC for the probe
call sent to each server and comparing them.  Sometimes, however, no RTT
estimate is available and rxrpc_kernel_get_srtt() returns false, leading
good fileservers to be given an RTT of UINT_MAX and thus causing the
rotation algorithm to ignore them.

Fix afs_select_fileserver() to ignore rxrpc_kernel_get_srtt()'s return
value and just take the estimated RTT it provides - which will be capped a=
t
1 second.

Fixes: 1d4adfaf6574 ("rxrpc: Make rxrpc_kernel_get_srtt() indicate validit=
y")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/166965503999.3392585.13954054113218099395.=
stgit@warthog.procyon.org.uk/
---
 fs/afs/fs_probe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index c0031a3ab42f..3ac5fcf98d0d 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -167,8 +167,8 @@ void afs_fileserver_probe_result(struct afs_call *call=
)
 			clear_bit(AFS_SERVER_FL_HAS_FS64, &server->flags);
 	}
 =

-	if (rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us) &&
-	    rtt_us < server->probe.rtt) {
+	rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us);
+	if (rtt_us < server->probe.rtt) {
 		server->probe.rtt =3D rtt_us;
 		server->rtt =3D rtt_us;
 		alist->preferred =3D index;

