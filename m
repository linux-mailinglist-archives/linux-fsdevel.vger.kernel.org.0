Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6791E17E200
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 15:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCIOCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 10:02:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43501 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726515AbgCIOCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583762528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aeMjoxNI5G0uvYFeZnDxrzVLM7+YaYhNMQi7QT0P8ec=;
        b=eSnWEZptAx37ftHqOyRS27AK0LUjxrixqMDXvqeet5oDzgTjsonYFG8CEFnqk8L+ASpD37
        GN9sxDZNoTsRDBoHIug8QFc5G4KnJ+h+NkKZWNjnbESOirVGfV2ssS/zkqIRuKIHeIdhkg
        Bjtq1A94B5sXCkXzoV21kueQRTO2xEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-afBZgJD1MiK2V2E5tzk9sg-1; Mon, 09 Mar 2020 10:02:07 -0400
X-MC-Unique: afBZgJD1MiK2V2E5tzk9sg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4546A13FD;
        Mon,  9 Mar 2020 14:02:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83CED90F5B;
        Mon,  9 Mar 2020 14:02:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/14] fsinfo: Allow the mount topology propogation flags to
 be retrieved [ver #18]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 14:02:01 +0000
Message-ID: <158376252176.344135.11226418366508725745.stgit@warthog.procyon.org.uk>
In-Reply-To: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow the mount topology propogation flags to be retrieved as part of the
FSINFO_ATTR_MOUNT_INFO attributes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/namespace.c              |    7 ++++++-
 include/uapi/linux/fsinfo.h |    2 +-
 include/uapi/linux/mount.h  |   10 +++++++++-
 samples/vfs/test-fsinfo.c   |    1 +
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a6cb8c6b004f..88aef45bcfa8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4177,15 +4177,20 @@ int fsinfo_generic_mount_info(struct path *path, struct fsinfo_context *ctx)
 			p->parent_id = p->mnt_id;
 		rcu_read_unlock();
 	}
-	if (IS_MNT_SHARED(m))
+	if (IS_MNT_SHARED(m)) {
 		p->group_id = m->mnt_group_id;
+		p->propagation |= MOUNT_PROPAGATION_SHARED;
+	}
 	if (IS_MNT_SLAVE(m)) {
 		int master = m->mnt_master->mnt_group_id;
 		int dom = get_dominating_id(m, &root);
 		p->master_id = master;
 		if (dom && dom != master)
 			p->from_id = dom;
+		p->propagation |= MOUNT_PROPAGATION_SLAVE;
 	}
+	if (IS_MNT_UNBINDABLE(m))
+		p->propagation |= MOUNT_PROPAGATION_UNBINDABLE;
 	path_put(&root);
 
 	flags = READ_ONCE(m->mnt.mnt_flags);
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 7a8b577f54b7..909d6104933b 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -103,7 +103,7 @@ struct fsinfo_mount_info {
 	__u32	master_id;		/* Slave master group ID */
 	__u32	from_id;		/* Slave propagated from ID */
 	__u32	attr;			/* MOUNT_ATTR_* flags */
-	__u32	__padding[1];
+	__u32	propagation;		/* MOUNT_PROPAGATION_* flags */
 };
 
 #define FSINFO_ATTR_MOUNT_INFO__STRUCT struct fsinfo_mount_info
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 96a0240f23fe..39e50fe9d8d9 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -105,7 +105,7 @@ enum fsconfig_command {
 #define FSMOUNT_CLOEXEC		0x00000001
 
 /*
- * Mount attributes.
+ * Mount object attributes (these are separate to filesystem attributes).
  */
 #define MOUNT_ATTR_RDONLY	0x00000001 /* Mount read-only */
 #define MOUNT_ATTR_NOSUID	0x00000002 /* Ignore suid and sgid bits */
@@ -117,4 +117,12 @@ enum fsconfig_command {
 #define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
 #define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
 
+/*
+ * Mount object propogation attributes.
+ */
+#define MOUNT_PROPAGATION_UNBINDABLE	0x00000001 /* Mount is unbindable */
+#define MOUNT_PROPAGATION_SLAVE		0x00000002 /* Mount is slave */
+#define MOUNT_PROPAGATION_PRIVATE	0x00000000 /* Mount is private (ie. not shared) */
+#define MOUNT_PROPAGATION_SHARED	0x00000004 /* Mount is shared */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 2f9fe3b24bca..bdc7ea952630 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -299,6 +299,7 @@ static void dump_fsinfo_generic_mount_info(void *reply, unsigned int size)
 	printf("\tparent  : %x\n", r->parent_id);
 	printf("\tgroup   : %x\n", r->group_id);
 	printf("\tattr    : %x\n", r->attr);
+	printf("\tpropag  : %x\n", r->propagation);
 }
 
 static void dump_fsinfo_generic_mount_child(void *reply, unsigned int size)


