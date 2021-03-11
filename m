Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ACE338114
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 00:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhCKXHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 18:07:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhCKXGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 18:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615504004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rCnlmIeSflhpUwVGM7LvbR15TVfTJn8RZlzhAMf0UMg=;
        b=NN4ER6mdBBjk1eTWPP6TCjCe8PhR53YaysmOG9exOe0uRBZVM6a2OsS/HcoZgycu9u2uId
        Hcsoh9GPkFzAcRxzOp+h44rYMv6e0cRTratzVrFmnvqXS2iyJSUoKG616WrLTXNyQIjFSS
        whGtFh8PRWQsLi6ZuGg0Se83IbqbY/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-XLKk4cgyPpKuQkbKD40uZQ-1; Thu, 11 Mar 2021 18:06:41 -0500
X-MC-Unique: XLKk4cgyPpKuQkbKD40uZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64D9BE5760;
        Thu, 11 Mar 2021 23:06:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 296155D742;
        Thu, 11 Mar 2021 23:06:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 2/2] afs: Stop listxattr() from listing "afs.*" attributes
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        dhowells@redhat.com,
        Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Mar 2021 23:06:38 +0000
Message-ID: <161550399833.1983424.16644306048746346626.stgit@warthog.procyon.org.uk>
In-Reply-To: <161550398415.1983424.4857046033308089813.stgit@warthog.procyon.org.uk>
References: <161550398415.1983424.4857046033308089813.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

afs_listxattr() lists all the available special afs xattrs (i.e. those in
the "afs.*" space), no matter what type of server we're dealing with.  But
OpenAFS servers, for example, cannot deal with some of the extra-capable
attributes that AuriStor (YFS) servers provide.  Unfortunately, the
presence of the afs.yfs.* attributes causes errors[1] for anything that
tries to read them if the server is of the wrong type.

Fix the problem by removing afs_listxattr() so that none of the special
xattrs are listed (AFS doesn't support xattrs).  It does mean, however,
that getfattr won't list them, though they can still be accessed with
getxattr() and setxattr().

This can be tested with something like:

	getfattr -d -m ".*" /afs/example.com/path/to/file

With this change, none of the afs.* attributes should be visible.

Changes:
ver #2:
 - Hide all of the afs.* xattrs, not just the ACL ones.

Fixes: ae46578b963f ("afs: Get YFS ACLs and information through xattrs")
Reported-by: Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003502.html [1]
Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003567.html # v1
---

 fs/afs/dir.c      |    1 -
 fs/afs/file.c     |    1 -
 fs/afs/inode.c    |    1 -
 fs/afs/internal.h |    1 -
 fs/afs/mntpt.c    |    1 -
 fs/afs/xattr.c    |   23 -----------------------
 6 files changed, 28 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 714fcca9af99..17548c1faf02 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -70,7 +70,6 @@ const struct inode_operations afs_dir_inode_operations = {
 	.permission	= afs_permission,
 	.getattr	= afs_getattr,
 	.setattr	= afs_setattr,
-	.listxattr	= afs_listxattr,
 };
 
 const struct address_space_operations afs_dir_aops = {
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 85f5adf21aa0..960b64268623 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -43,7 +43,6 @@ const struct inode_operations afs_file_inode_operations = {
 	.getattr	= afs_getattr,
 	.setattr	= afs_setattr,
 	.permission	= afs_permission,
-	.listxattr	= afs_listxattr,
 };
 
 const struct address_space_operations afs_fs_aops = {
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 1156b2df28d3..12be88716e4c 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -27,7 +27,6 @@
 
 static const struct inode_operations afs_symlink_inode_operations = {
 	.get_link	= page_get_link,
-	.listxattr	= afs_listxattr,
 };
 
 static noinline void dump_vnode(struct afs_vnode *vnode, struct afs_vnode *parent_vnode)
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index b626e38e9ab5..1627b1872812 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1509,7 +1509,6 @@ extern int afs_launder_page(struct page *);
  * xattr.c
  */
 extern const struct xattr_handler *afs_xattr_handlers[];
-extern ssize_t afs_listxattr(struct dentry *, char *, size_t);
 
 /*
  * yfsclient.c
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 052dab2f5c03..bbb2c210d139 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -32,7 +32,6 @@ const struct inode_operations afs_mntpt_inode_operations = {
 	.lookup		= afs_mntpt_lookup,
 	.readlink	= page_readlink,
 	.getattr	= afs_getattr,
-	.listxattr	= afs_listxattr,
 };
 
 const struct inode_operations afs_autocell_inode_operations = {
diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 4934e325a14a..7751b0b3f81d 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -11,29 +11,6 @@
 #include <linux/xattr.h>
 #include "internal.h"
 
-static const char afs_xattr_list[] =
-	"afs.acl\0"
-	"afs.cell\0"
-	"afs.fid\0"
-	"afs.volume\0"
-	"afs.yfs.acl\0"
-	"afs.yfs.acl_inherited\0"
-	"afs.yfs.acl_num_cleaned\0"
-	"afs.yfs.vol_acl";
-
-/*
- * Retrieve a list of the supported xattrs.
- */
-ssize_t afs_listxattr(struct dentry *dentry, char *buffer, size_t size)
-{
-	if (size == 0)
-		return sizeof(afs_xattr_list);
-	if (size < sizeof(afs_xattr_list))
-		return -ERANGE;
-	memcpy(buffer, afs_xattr_list, sizeof(afs_xattr_list));
-	return sizeof(afs_xattr_list);
-}
-
 /*
  * Deal with the result of a successful fetch ACL operation.
  */


