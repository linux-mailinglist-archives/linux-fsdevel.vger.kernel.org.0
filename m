Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497E17A4BDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjIRPXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbjIRPXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8433B269D
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 08:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695050402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6KA4lTlnVdzbmyx5pVQ5ofjoQSRiAU3XEpYXJ1nkwrA=;
        b=ULhI9McajzvQI47X/5D2isYzY1ugCMRMWS6VDUaI6Z9+WJbswoGe0ZTIj0o/qlSEY4QPrv
        iQcjDUQjdObwjcLmtbP7/0g4ioOcSfbCg+np2EnQ2hh9Q3PBPF/Qi5REn5cwKQ1ncyaTHh
        dkn/UxAbOusShomum6jdRtWKay4qgOQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-PKA3tFlTMryOWIa3kWRgkg-1; Mon, 18 Sep 2023 09:17:13 -0400
X-MC-Unique: PKA3tFlTMryOWIa3kWRgkg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FEE929AA386;
        Mon, 18 Sep 2023 13:17:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96ADAC158BA;
        Mon, 18 Sep 2023 13:17:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Dave Wysochanski <dwysocha@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] netfs: Only call folio_start_fscache() one time for each folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3993456.1695043031.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 18 Sep 2023 14:17:11 +0100
Message-ID: <3993457.1695043031@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you apply this please?

Thanks,
David
---
From: Dave Wysochanski <dwysocha@redhat.com>

If a network filesystem using netfs implements a clamp_length()
function, it can set subrequest lengths smaller than a page size.
When we loop through the folios in netfs_rreq_unlock_folios() to
set any folios to be written back, we need to make sure we only
call folio_start_fscache() once for each folio.  Otherwise,
this simple testcase:

  mount -o fsc,rsize=3D1024,wsize=3D1024 127.0.0.1:/export /mnt/nfs
  dd if=3D/dev/zero of=3D/mnt/nfs/file.bin bs=3D4096 count=3D1
  1+0 records in
  1+0 records out
  4096 bytes (4.1 kB, 4.0 KiB) copied, 0.0126359 s, 324 kB/s
  echo 3 > /proc/sys/vm/drop_caches
  cat /mnt/nfs/file.bin > /dev/null

will trigger an oops similar to the following:

...
 page dumped because: VM_BUG_ON_FOLIO(folio_test_private_2(folio))
 ------------[ cut here ]------------
 kernel BUG at include/linux/netfs.h:44!
...
 CPU: 5 PID: 134 Comm: kworker/u16:5 Kdump: loaded Not tainted 6.4.0-rc5
...
 RIP: 0010:netfs_rreq_unlock_folios+0x68e/0x730 [netfs]
...
 Call Trace:
  <TASK>
  netfs_rreq_assess+0x497/0x660 [netfs]
  netfs_subreq_terminated+0x32b/0x610 [netfs]
  nfs_netfs_read_completion+0x14e/0x1a0 [nfs]
  nfs_read_completion+0x2f9/0x330 [nfs]
  rpc_free_task+0x72/0xa0 [sunrpc]
  rpc_async_release+0x46/0x70 [sunrpc]
  process_one_work+0x3bd/0x710
  worker_thread+0x89/0x610
  kthread+0x181/0x1c0
  ret_from_fork+0x29/0x50

Fixes: 3d3c95046742 ("netfs: Provide readahead and readpage netfs helpers"
Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2210612
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20230608214137.856006-1-dwysocha@redhat.co=
m/ # v1
Link: https://lore.kernel.org/r/20230915185704.1082982-1-dwysocha@redhat.c=
om/ # v2
---
 fs/netfs/buffered_read.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 3404707ddbe7..2cd3ccf4c439 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -47,12 +47,14 @@ void netfs_rreq_unlock_folios(struct netfs_io_request =
*rreq)
 	xas_for_each(&xas, folio, last_page) {
 		loff_t pg_end;
 		bool pg_failed =3D false;
+		bool folio_started;
 =

 		if (xas_retry(&xas, folio))
 			continue;
 =

 		pg_end =3D folio_pos(folio) + folio_size(folio) - 1;
 =

+		folio_started =3D false;
 		for (;;) {
 			loff_t sreq_end;
 =

@@ -60,8 +62,10 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *=
rreq)
 				pg_failed =3D true;
 				break;
 			}
-			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
+			if (!folio_started && test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flag=
s)) {
 				folio_start_fscache(folio);
+				folio_started =3D true;
+			}
 			pg_failed |=3D subreq_failed;
 			sreq_end =3D subreq->start + subreq->len - 1;
 			if (pg_end < sreq_end)

