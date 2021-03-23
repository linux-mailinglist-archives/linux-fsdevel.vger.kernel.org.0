Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBCD346C2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhCWWTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233942AbhCWWSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616537916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92+RMyPSZb9UPiHHQXIcTR5pNhYSfMAZfLfhPp4UhXs=;
        b=U0uDoDaBLG4N9Vem5Fz1U0aV+Trvt3OCqUKa59ImhwbL/kw/JfeBq4SN7jYTQmbIg3CPH8
        8oTNnX6mCluTyfM/G8/CJRLBBl698mVcWcJds/AwAgIYxxqW0XfkWyKPkLYGUoDEFL1E0R
        pO994zd5yL5BCRaPSUzKrZcyVmp3irQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-cYdMFeqIM26tWgUriYMBcg-1; Tue, 23 Mar 2021 18:18:34 -0400
X-MC-Unique: cYdMFeqIM26tWgUriYMBcg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 753CF800D53;
        Tue, 23 Mar 2021 22:18:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F5205C1C5;
        Tue, 23 Mar 2021 22:18:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v5 05/28] netfs: Make a netfs helper module
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 22:18:23 +0000
Message-ID: <161653790328.2770958.6710423217716151549.stgit@warthog.procyon.org.uk>
In-Reply-To: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
References: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make a netfs helper module to manage read request segmentation, caching
support and transparent huge page support on behalf of a network
filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: v9fs-developer@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/160588496284.3465195.10102643717770106661.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161118135638.1232039.1622182202673126285.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161031028.2537118.1213974428943508753.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340391427.1303470.14884950716721956560.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539531569.286939.18317119181653706665.stgit@warthog.procyon.org.uk/ # v4
---

 fs/netfs/Kconfig |    8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 fs/netfs/Kconfig

diff --git a/fs/netfs/Kconfig b/fs/netfs/Kconfig
new file mode 100644
index 000000000000..2ebf90e6ca95
--- /dev/null
+++ b/fs/netfs/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config NETFS_SUPPORT
+	tristate "Support for network filesystem high-level I/O"
+	help
+	  This option enables support for network filesystems, including
+	  helpers for high-level buffered I/O, abstracting out read
+	  segmentation, local caching and transparent huge page support.


