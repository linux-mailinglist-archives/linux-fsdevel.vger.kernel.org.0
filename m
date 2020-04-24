Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE4C1B7967
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgDXPUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 11:20:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49807 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728078AbgDXPUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587741634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HW22fB/dXdSStd4PHzy0rCqHbOznpDI7NjNK1X8I9CU=;
        b=ByWFFd4jiNyWAvRZXkUUJJBEudE/IEYqdv1i3w9MOUrDraONUMAugwALaai6+tuAOYb66d
        eX2RDsLXtIBqZtMjeyz7B/C/YmTPyOX0xnAdmXnowM7b+oXmGRU4DKMaqsVyVGm9uFy9p7
        HrKXOF7TGhZlbv1fkwWwW/FDqTmeuk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-u-eSmnE5NDem1rUY7OvFaw-1; Fri, 24 Apr 2020 11:20:30 -0400
X-MC-Unique: u-eSmnE5NDem1rUY7OvFaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52FCF100A614;
        Fri, 24 Apr 2020 15:20:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CD4A6084A;
        Fri, 24 Apr 2020 15:20:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/8] afs: Remove some unused bits
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Fri, 24 Apr 2020 16:20:22 +0100
Message-ID: <158774162288.3619859.1654560517330035101.stgit@warthog.procyon.org.uk>
In-Reply-To: <158774158625.3619859.10579201535876583842.stgit@warthog.procyon.org.uk>
References: <158774158625.3619859.10579201535876583842.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove three bits:

 (1) afs_server::no_epoch is neither set nor used.

 (2) afs_server::have_result is set and a wakeup is applied to it, but
     nothing looks at it or waits on it.

 (3) afs_vl_dump_edestaddrreq() prints afs_addr_list::probed, but nothing
     sets it for VL servers.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fs_probe.c  |    5 +----
 fs/afs/internal.h  |    2 --
 fs/afs/vl_rotate.c |    4 ++--
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index e1b9ed679045..a587767b6ae1 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -117,11 +117,8 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	       (unsigned int)rtt, ret);
 
 	have_result |= afs_fs_probe_done(server);
-	if (have_result) {
-		server->probe.have_result = true;
-		wake_up_var(&server->probe.have_result);
+	if (have_result)
 		wake_up_all(&server->probe_wq);
-	}
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 2d4e0c4e23a4..ee17c868ad2c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -534,12 +534,10 @@ struct afs_server {
 		u32		abort_code;
 		u32		cm_epoch;
 		short		error;
-		bool		have_result;
 		bool		responded:1;
 		bool		is_yfs:1;
 		bool		not_yfs:1;
 		bool		local_failure:1;
-		bool		no_epoch:1;
 		bool		cm_probed:1;
 		bool		said_rebooted:1;
 		bool		said_inconsistent:1;
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 9a5ce9687779..72eacc14e6e1 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -302,8 +302,8 @@ static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 				pr_notice("VC:  - nr=%u/%u/%u pf=%u\n",
 					  a->nr_ipv4, a->nr_addrs, a->max_addrs,
 					  a->preferred);
-				pr_notice("VC:  - pr=%lx R=%lx F=%lx\n",
-					  a->probed, a->responded, a->failed);
+				pr_notice("VC:  - R=%lx F=%lx\n",
+					  a->responded, a->failed);
 				if (a == vc->ac.alist)
 					pr_notice("VC:  - current\n");
 			}


