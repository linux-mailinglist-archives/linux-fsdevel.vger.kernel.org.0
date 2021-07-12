Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ACB3C5CC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 15:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhGLNAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 09:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230522AbhGLNAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626094652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3yaXGJzAbCuPSMZFDdC5GKfSG3W1ilqPRD4f2MbCTw=;
        b=e1Ac5437C+wFEcxEYbexmq9I1Y8KT65NAZLV63YY6k2ytdD/AeTAiYZXHqCnLYtkw9BfPX
        Q83sRinGgHgMuJw0nYTe7s0ujFOCwPo0xQkC43P7SqegN4HRiQyUmpkPK1H/9+LBggA6SS
        dwzudP+xnGcFVf9e+x0em2FuVu6/W7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563--QhOl9QMME-xEJe_fVmUgg-1; Mon, 12 Jul 2021 08:57:30 -0400
X-MC-Unique: -QhOl9QMME-xEJe_fVmUgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 334671023F40;
        Mon, 12 Jul 2021 12:57:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-19.rdu2.redhat.com [10.10.118.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 042D61971B;
        Mon, 12 Jul 2021 12:57:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/3] afs: check function return
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Tom Rix <trix@redhat.com>, dhowells@redhat.com,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Jul 2021 13:57:27 +0100
Message-ID: <162609464716.3133237.10354897554363093252.stgit@warthog.procyon.org.uk>
In-Reply-To: <162609463116.3133237.11899334298425929820.stgit@warthog.procyon.org.uk>
References: <162609463116.3133237.11899334298425929820.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem

write.c:773:29: warning: Assigned value is garbage or undefined
  mapping->writeback_index = next;
                           ^ ~~~~
The call to afs_writepages_region() can return without setting
next.  So check the function return before using next.

Fixes: e87b03f5830e ("afs: Prepare for use of THPs")
Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20210430155031.3287870-1-trix@redhat.com
---

 fs/afs/write.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 3104b62c2082..2794147f82ff 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -777,7 +777,7 @@ int afs_writepages(struct address_space *mapping,
 		mapping->writeback_index = next / PAGE_SIZE;
 	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
 		ret = afs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
-		if (wbc->nr_to_write > 0)
+		if (wbc->nr_to_write > 0 && ret == 0)
 			mapping->writeback_index = next;
 	} else {
 		ret = afs_writepages_region(mapping, wbc,


