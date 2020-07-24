Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF0722C69E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 15:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGXNfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 09:35:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32282 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727098AbgGXNfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595597749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5B7NRLNMJVGbU812ZltjTFTKIzdAhqkdhwjD/nwzlmY=;
        b=hEF46etQaz8uhYE+bMXtoyHkkgQls+wvgvxnecHf+CijFRBvY9Pm/0qx6gHla8bhoRMfEL
        h28R49uwCCIXDTqZAYlqTt6NKplceflWe9ayHw577WidtRrWkfPiipkWyx2aOkQ8DvvG9R
        ederNwZg5krUXGN0y6MneOBsf790BIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-6sAAWNFoMaqUKE2W65pvdA-1; Fri, 24 Jul 2020 09:35:45 -0400
X-MC-Unique: 6sAAWNFoMaqUKE2W65pvdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B79241009446;
        Fri, 24 Jul 2020 13:35:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 451382DE72;
        Fri, 24 Jul 2020 13:35:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/17] fsinfo: Add a uniquifier ID to struct mount [ver #20]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:35:40 +0100
Message-ID: <159559774044.2144584.14085699755046222864.stgit@warthog.procyon.org.uk>
In-Reply-To: <159559768062.2144584.13583793543173131929.stgit@warthog.procyon.org.uk>
References: <159559768062.2144584.13583793543173131929.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a uniquifier ID to struct mount that is effectively unique over the
kernel lifetime to deal around mnt_id values being reused.  This can then
be exported through fsinfo() to allow detection of replacement mounts that
happen to end up with the same mount ID.

The normal mount handle is still used for referring to a particular mount.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/mount.h     |    3 +++
 fs/namespace.c |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/fs/mount.h b/fs/mount.h
index 1c777f651446..c3e0bb6e5782 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -79,6 +79,9 @@ struct mount {
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
 	struct hlist_head mnt_stuck_children;
+#ifdef CONFIG_FSINFO
+	u64	mnt_unique_id;		/* ID unique over lifetime of kernel */
+#endif
 #ifdef CONFIG_MOUNT_NOTIFICATIONS
 	atomic_t mnt_topology_changes;	/* Number of topology changes applied */
 	atomic_t mnt_attr_changes;	/* Number of attribute changes applied */
diff --git a/fs/namespace.c b/fs/namespace.c
index b2b9920ffd3c..1db8a64cd76f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -115,6 +115,9 @@ static int mnt_alloc_id(struct mount *mnt)
 	if (res < 0)
 		return res;
 	mnt->mnt_id = res;
+#ifdef CONFIG_FSINFO
+	mnt->mnt_unique_id = atomic64_inc_return(&vfs_unique_counter);
+#endif
 	return 0;
 }
 


