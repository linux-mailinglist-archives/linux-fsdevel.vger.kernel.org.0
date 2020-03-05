Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A653617AD7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 18:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgCERnl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 12:43:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31776 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbgCERnk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583430219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+47MZRdP4eySwBBvI9Z4qJ2/RVGABmp0e90Oh4PvK+U=;
        b=XgmooqYoUn0eR0tGxYJB480Q95FJ+auru6PXqbXy2bnWunp4fMPSG1M2RIhKZhplpfADqM
        QTdtDnl44eKpESTEyYbOHHR52RxKO8w0ozk4jgotDqkGNsBhLqX4ceuvMQVimCMm6xT6BP
        4zE0BTv63ki4JEM0kiwthcK0beIacDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-NwK1P_MQO6-93JL8IGBKmQ-1; Thu, 05 Mar 2020 12:43:37 -0500
X-MC-Unique: NwK1P_MQO6-93JL8IGBKmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EDFE800D54;
        Thu,  5 Mar 2020 17:43:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE17460BE0;
        Thu,  5 Mar 2020 17:43:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     linux-api@vger.kernel.org
cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        dhowells@redhat.com, metze@samba.org, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Mark AT_* path flags as deprecated and add missing RESOLVE_ flags
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3774366.1583430213.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 05 Mar 2020 17:43:33 +0000
Message-ID: <3774367.1583430213@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Do we want to do this?  Or should we duplicate the RESOLVE_* flags to AT_*
flags so that existing *at() syscalls can make use of them?

David
---
commit 448731bf3b29f2b1f7c969d7efe1f0673ae13b5e
Author: David Howells <dhowells@redhat.com>
Date:   Thu Mar 5 17:40:02 2020 +0000

    Mark AT_* flags as deprecated and add missing RESOLVE_ flags
    =

    It has been suggested that new path-using system calls should use RESO=
LVE_*
    flags instead of AT_* flags, but the RESOLVE_* flag functions are not =
a
    superset of the AT_* flag functions.  So formalise this by:
    =

     (1) In linux/fcntl.h, add a comment noting that the AT_* flags are
         deprecated for new system calls and that RESOLVE_* flags should b=
e
         used instead.
    =

     (2) Add some missing flags:
    =

            RESOLVE_NO_TERMINAL_SYMLINKS    for AT_SYMLINK_NOFOLLOW
            RESOLVE_NO_TERMINAL_AUTOMOUNTS  for AT_NO_AUTOMOUNT
            RESOLVE_EMPTY_PATH              for AT_EMPTY_PATH
    =

     (3) Make openat2() support RESOLVE_NO_TERMINAL_SYMLINKS.  LOOKUP_OPEN
         internally implies LOOKUP_AUTOMOUNT, and AT_EMPTY_PATH is probabl=
y not
         worth supporting (maybe use dup2() instead?).
    =

    Reported-by: Stefan Metzmacher <metze@samba.org>
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Aleksa Sarai <cyphar@cyphar.com>

diff --git a/fs/open.c b/fs/open.c
index 0788b3715731..6946ad09b42b 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -977,7 +977,7 @@ inline struct open_how build_open_how(int flags, umode=
_t mode)
 inline int build_open_flags(const struct open_how *how, struct open_flags=
 *op)
 {
 	int flags =3D how->flags;
-	int lookup_flags =3D 0;
+	int lookup_flags =3D LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
 	int acc_mode =3D ACC_MODE(flags);
 =

 	/* Must never be set by userspace */
@@ -1055,8 +1055,8 @@ inline int build_open_flags(const struct open_how *h=
ow, struct open_flags *op)
 =

 	if (flags & O_DIRECTORY)
 		lookup_flags |=3D LOOKUP_DIRECTORY;
-	if (!(flags & O_NOFOLLOW))
-		lookup_flags |=3D LOOKUP_FOLLOW;
+	if (flags & O_NOFOLLOW)
+		lookup_flags &=3D ~LOOKUP_FOLLOW;
 =

 	if (how->resolve & RESOLVE_NO_XDEV)
 		lookup_flags |=3D LOOKUP_NO_XDEV;
@@ -1068,6 +1068,8 @@ inline int build_open_flags(const struct open_how *h=
ow, struct open_flags *op)
 		lookup_flags |=3D LOOKUP_BENEATH;
 	if (how->resolve & RESOLVE_IN_ROOT)
 		lookup_flags |=3D LOOKUP_IN_ROOT;
+	if (how->resolve & RESOLVE_NO_TERMINAL_SYMLINKS)
+		lookup_flags &=3D ~LOOKUP_FOLLOW;
 =

 	op->lookup_flags =3D lookup_flags;
 	return 0;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 7bcdcf4f6ab2..fd6ee34cce0f 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -19,7 +19,8 @@
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
-	 RESOLVE_BENEATH | RESOLVE_IN_ROOT)
+	 RESOLVE_BENEATH | RESOLVE_IN_ROOT | RESOLVE_NO_TERMINAL_SYMLINKS | \
+	 RESOLVE_NO_TERMINAL_AUTOMOUNTS | RESOLVE_EMPTY_PATH)
 =

 /* List of all open_how "versions". */
 #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index ca88b7bce553..9f5432dbd213 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -84,9 +84,20 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 =

-#define AT_FDCWD		-100    /* Special value used to indicate
-                                           openat should use the current
-                                           working directory. */
+
+/*
+ * Special dfd/dirfd file descriptor value used to indicate that *at() sy=
stem
+ * calls should use the current working directory for relative paths.
+ */
+#define AT_FDCWD		-100
+
+/*
+ * Pathwalk control flags, used for the *at() syscalls.  These should be
+ * considered deprecated and should not be used for new system calls.  Th=
e
+ * RESOLVE_* flags in <linux/openat2.h> should be used instead.
+ *
+ * There are also system call-specific flags here (REMOVEDIR, STATX, RECU=
RSIVE).
+ */
 #define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
 #define AT_REMOVEDIR		0x200   /* Remove directory instead of
                                            unlinking file.  */
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index 58b1eb711360..bb8d0a7f82c2 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -22,7 +22,10 @@ struct open_how {
 	__u64 resolve;
 };
 =

-/* how->resolve flags for openat2(2). */
+/*
+ * Path resolution paths to replace AT_* paths in all new syscalls that w=
ould
+ * use them.
+ */
 #define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
 					(includes bind-mounts). */
 #define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-styl=
e
@@ -35,5 +38,8 @@ struct open_how {
 #define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
 					be scoped inside the dirfd
 					(similar to chroot(2)). */
+#define RESOLVE_NO_TERMINAL_SYMLINKS	0x20 /* Don't follow terminal symlin=
ks in the path */
+#define RESOLVE_NO_TERMINAL_AUTOMOUNTS	0x40 /* Don't follow terminal auto=
mounts in the path */
+#define RESOLVE_EMPTY_PATH	0x80	/* Permit a path of "" to indicate the df=
d exactly */
 =

 #endif /* _UAPI_LINUX_OPENAT2_H */

