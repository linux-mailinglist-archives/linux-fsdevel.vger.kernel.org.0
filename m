Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707421685F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgBUSDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:03:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51876 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728907AbgBUSDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582308212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5J393Ux38mLI90fhyfC4Zp3RLoNyH3WwtQ6YbFOpwQ=;
        b=RgE+HdRJq//LkSUf7i9qwnZYMDXJtfCydnKRA9Gb9qutYr3bXwJ8vZO5Gy0VdrzNL6bR+e
        73ff+f2aVgWvv6xfzFw+hrt2YhimgNdQXpMTr18f5obpVAvFKPHsMfRhLY+ABXq9XPwadw
        NhiOHhtj42x46zEobpGze0u+frM09ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-JUnbB8tnOwyNZE6-RH-u4g-1; Fri, 21 Feb 2020 13:03:28 -0500
X-MC-Unique: JUnbB8tnOwyNZE6-RH-u4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 154BF108839B;
        Fri, 21 Feb 2020 18:03:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 310FA909E2;
        Fri, 21 Feb 2020 18:03:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/17] fsinfo: Allow the mount topology propogation flags to
 be retrieved [ver #17]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 18:03:24 +0000
Message-ID: <158230820446.2185128.17437159809665554655.stgit@warthog.procyon.org.uk>
In-Reply-To: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 samples/vfs/test-mntinfo.c  |    8 ++++----
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fc22aea18e2d..bbfd6cd5c501 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4142,15 +4142,20 @@ int fsinfo_generic_mount_info(struct path *path, struct fsinfo_context *ctx)
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
index 29940d110ce3..119c371697be 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -100,7 +100,7 @@ struct fsinfo_mount_info {
 	__u32		from_id;	/* Slave propagated from ID */
 	__u32		attr;		/* MOUNT_ATTR_* flags */
 	__u32		change_counter;	/* Number of changes applied. */
-	__u32		__reserved[1];
+	__u32		propagation;	/* MOUNT_PROPAGATION_* flags */
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
index f761ded6a52c..6a61f3426982 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -291,6 +291,7 @@ static void dump_fsinfo_generic_mount_info(void *reply, unsigned int size)
 	printf("\tmnt_id  : %x\n", f->mnt_id);
 	printf("\tparent  : %x\n", f->parent_id);
 	printf("\tgroup   : %x\n", f->group_id);
+	printf("\tpropag  : %x\n", f->propagation);
 	printf("\tattr    : %x\n", f->attr);
 	printf("\tchanges : %x\n", f->change_counter);
 }
diff --git a/samples/vfs/test-mntinfo.c b/samples/vfs/test-mntinfo.c
index f4d90d0671c5..5a3d6b917447 100644
--- a/samples/vfs/test-mntinfo.c
+++ b/samples/vfs/test-mntinfo.c
@@ -135,9 +135,9 @@ static void display_mount(unsigned int mnt_id, unsigned int depth, char *path)
 	printf("%*.*s", s, s, "");
 
 	sprintf(dev, "%x:%x", ids.f_dev_major, ids.f_dev_minor);
-	printf("%10u %8x %2x %5s %s",
+	printf("%10u %8x %2x %x %5s %s",
 	       info.mnt_id, info.change_counter,
-	       info.attr,
+	       info.attr, info.propagation,
 	       dev, ids.f_fs_name);
 	putchar('\n');
 
@@ -236,8 +236,8 @@ int main(int argc, char **argv)
 		exit(2);
 	}
 
-	printf("MOUNT                                 MOUNT ID   CHANGE#  AT DEV   TYPE\n");
-	printf("------------------------------------- ---------- -------- -- ----- --------\n");
+	printf("MOUNT                                 MOUNT ID   CHANGE#  AT P DEV   TYPE\n");
+	printf("------------------------------------- ---------- -------- -- - ----- --------\n");
 	display_mount(mnt_id, 0, path);
 	return 0;
 }


