Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2621B24BF11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 15:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgHTNja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 09:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728285AbgHTNhV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597930640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vFj18jwFWtUN6hhoDL/QEtPCTvLXhKIQr7i8wJCO8RQ=;
        b=UuD1vwsFQ0V3tXeQM+ZLWfVocNJii0mCMX8iLwi8wNv9XrPARAMxbfBRWfFBuNr90t5JR3
        fFV+1EXLTR24wCOkwEjoTV9eY3RVjKL8F3nwJMS/9kEaLKzHOtTBteWEkPDxeJF8I3Prr1
        0vl2qKIL77Y9BVP0egCeVegBKT/UGoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-hqViGMAXP4u9y5q1I_038w-1; Thu, 20 Aug 2020 09:37:15 -0400
X-MC-Unique: hqViGMAXP4u9y5q1I_038w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E088100CA92;
        Thu, 20 Aug 2020 13:37:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40DEF100EBA5;
        Thu, 20 Aug 2020 13:37:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix key ref leak in afs_put_operation()
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Botsch <botsch@cnf.cornell.edu>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Aug 2020 14:37:12 +0100
Message-ID: <159793063245.3494970.902074379601812922.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The afs_put_operation() function needs to put the reference to the key
that's authenticating the operation.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Reported-by: Dave Botsch <botsch@cnf.cornell.edu>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fs_operation.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 24fd163c6323..97cab12b0a6c 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -235,6 +235,7 @@ int afs_put_operation(struct afs_operation *op)
 	afs_end_cursor(&op->ac);
 	afs_put_serverlist(op->net, op->server_list);
 	afs_put_volume(op->net, op->volume, afs_volume_trace_put_put_op);
+	key_put(op->key);
 	kfree(op);
 	return ret;
 }


