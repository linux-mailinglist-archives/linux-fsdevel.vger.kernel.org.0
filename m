Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F84517E1E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 15:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCIOBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 10:01:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34554 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726759AbgCIOBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583762466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qNKh0fdBMDq9px7If3jTtquCU4PmuL5OeIUw4lVkYl4=;
        b=gIfV/D91lhceiMObCHUqgXUjnrz/54aKDw0hCDIMs2MSb0nCcCRKVk3wE47iAHWKmy/nNm
        xloF109G7yGAdhw2ZuzcIsWXqR6CsbrRAkYuWFOzzc/wo5slrlZ6aqUnt7yHyBWMxdmov+
        azZ8dvtl55Z5/1VYaWHr57GjpQNTfDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-ql6zw2YSMKWuXue31dqvEw-1; Mon, 09 Mar 2020 10:01:02 -0400
X-MC-Unique: ql6zw2YSMKWuXue31dqvEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C977CDB61;
        Mon,  9 Mar 2020 14:01:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF79F60C05;
        Mon,  9 Mar 2020 14:00:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     Stefan Metzmacher <metze@samba.org>,
        Aleksa Sarai <cyphar@cyphar.com>, dhowells@redhat.com,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 14:00:57 +0000
Message-ID: <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
In-Reply-To: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add additional RESOLVE_* flags to correspond to AT_* flags that aren't
currently implemented:

	RESOLVE_NO_TRAILING_SYMLINKS    for AT_SYMLINK_NOFOLLOW
	RESOLVE_NO_TRAILING_AUTOMOUNTS  for AT_NO_AUTOMOUNT
	RESOLVE_EMPTY_PATH              for AT_EMPTY_PATH

This is necessary for fsinfo() to use RESOLVE_* flags instead of AT_* flags
if the latter are to be considered deprecated for new system calls.

Also make openat2() handle RESOLVE_NO_TRAILING_SYMLINKS.

Automounting is currently forced by doing an open(), so adding support to
openat2() for RESOLVE_NO_TRAILING_AUTOMOUNTS is not trivial.

Reported-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Aleksa Sarai <cyphar@cyphar.com>
---

 fs/open.c                    |    8 +++++---
 include/linux/fcntl.h        |    3 ++-
 include/uapi/linux/openat2.h |    8 +++++++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 0788b3715731..7c38a7605c21 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -977,7 +977,7 @@ inline struct open_how build_open_how(int flags, umode_t mode)
 inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 {
 	int flags = how->flags;
-	int lookup_flags = 0;
+	int lookup_flags = LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
 	int acc_mode = ACC_MODE(flags);
 
 	/* Must never be set by userspace */
@@ -1055,8 +1055,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 
 	if (flags & O_DIRECTORY)
 		lookup_flags |= LOOKUP_DIRECTORY;
-	if (!(flags & O_NOFOLLOW))
-		lookup_flags |= LOOKUP_FOLLOW;
+	if (flags & O_NOFOLLOW)
+		lookup_flags &= ~LOOKUP_FOLLOW;
 
 	if (how->resolve & RESOLVE_NO_XDEV)
 		lookup_flags |= LOOKUP_NO_XDEV;
@@ -1068,6 +1068,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		lookup_flags |= LOOKUP_BENEATH;
 	if (how->resolve & RESOLVE_IN_ROOT)
 		lookup_flags |= LOOKUP_IN_ROOT;
+	if (how->resolve & RESOLVE_NO_TRAILING_SYMLINKS)
+		lookup_flags &= ~LOOKUP_FOLLOW;
 
 	op->lookup_flags = lookup_flags;
 	return 0;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 7bcdcf4f6ab2..eacf17a8ca34 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -19,7 +19,8 @@
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
-	 RESOLVE_BENEATH | RESOLVE_IN_ROOT)
+	 RESOLVE_BENEATH | RESOLVE_IN_ROOT | RESOLVE_NO_TRAILING_SYMLINKS | \
+	 RESOLVE_NO_TRAILING_AUTOMOUNTS | RESOLVE_EMPTY_PATH)
 
 /* List of all open_how "versions". */
 #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index 58b1eb711360..2647a108f116 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -22,7 +22,10 @@ struct open_how {
 	__u64 resolve;
 };
 
-/* how->resolve flags for openat2(2). */
+/*
+ * Path resolution paths to replace AT_* paths in all new syscalls that would
+ * use them.
+ */
 #define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
 					(includes bind-mounts). */
 #define RESOLVE_NO_MAGICLINKS	0x02 /* Block traversal through procfs-style
@@ -35,5 +38,8 @@ struct open_how {
 #define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
 					be scoped inside the dirfd
 					(similar to chroot(2)). */
+#define RESOLVE_NO_TRAILING_SYMLINKS	0x20 /* Don't follow trailing symlinks in the path */
+#define RESOLVE_NO_TRAILING_AUTOMOUNTS	0x40 /* Don't follow trailing automounts in the path */
+#define RESOLVE_EMPTY_PATH	0x80	/* Permit a path of "" to indicate the dfd exactly */
 
 #endif /* _UAPI_LINUX_OPENAT2_H */


