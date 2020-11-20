Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27012BADBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgKTPJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:09:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728976AbgKTPJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wexTuI/PtT7fUvGjk4R2P120ewwYjL1xbhWNPGEK0jg=;
        b=BxBEp7F9b1y+zNcmuusAyGbujHPi9liNQLOIBr068mxYurlteGzTpuzfhZzhlolA9VTEra
        grRVm64mcdoyZKGjZ2RnxIirRnUBFg4ZHXjKRQee6YMYiemM93535FlZlshP2+lA9z/8kS
        1jNHQkzv6nkczxRFylHy6vwj/r3T61c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88--H_l0CVXN2Kshm0x_ShFYw-1; Fri, 20 Nov 2020 10:09:31 -0500
X-MC-Unique: -H_l0CVXN2Kshm0x_ShFYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3A05911E3;
        Fri, 20 Nov 2020 15:09:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91F815D9D0;
        Fri, 20 Nov 2020 15:09:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 32/76] netfs: Make a netfs helper module
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:09:22 +0000
Message-ID: <160588496284.3465195.10102643717770106661.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make a netfs helper module to manage read request segmentation, caching
support and transparent huge page support on behalf of a network
filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/Kconfig |    1 +
 fs/netfs/Kconfig   |    8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 fs/netfs/Kconfig

diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
index ce6f731065d0..b04f07160e5e 100644
--- a/fs/fscache/Kconfig
+++ b/fs/fscache/Kconfig
@@ -2,6 +2,7 @@
 
 config FSCACHE
 	tristate "General filesystem local caching manager"
+	depends on NETFS_SUPPORT
 	help
 	  This option enables a generic filesystem caching manager that can be
 	  used by various network and other filesystems to cache data locally.
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


