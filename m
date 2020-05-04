Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3CE1C4229
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbgEDRQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:16:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27789 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730517AbgEDRQa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TkzgIzFsWD6P4ojRbjtiWsS3WWTP7b7wyCXPHlCITv4=;
        b=JBL+urDcgTTtt3oKkEYDgLHE35SfN/a9jmN67/Ixlpb59gnmBaLjTz2z2R8Sy7VXOnCzpT
        lfFqDclX0cGIEgOmd4LY483Q6Ip2IWkCMOwam29mA6L5h9XewwIsFIeJ9AxYJtrEEia8GZ
        jbQVXiAGWoU4hYpHzTyFY9PNb2tbbuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365--GvVo-HKOQa55q1kK-7q2g-1; Mon, 04 May 2020 13:16:27 -0400
X-MC-Unique: -GvVo-HKOQa55q1kK-7q2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E218107B26F;
        Mon,  4 May 2020 17:16:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD206620AB;
        Mon,  4 May 2020 17:16:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 58/61] fscache: Rewrite the main document
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:16:22 +0100
Message-ID: <158861258200.340223.6420616682330887473.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rewrite the main document to reflect the new API.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/caching/fscache.txt |   51 ++++++++-----------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/Documentation/filesystems/caching/fscache.txt b/Documentation/filesystems/caching/fscache.txt
index 50f0a5757f48..dbfa0ece0ce8 100644
--- a/Documentation/filesystems/caching/fscache.txt
+++ b/Documentation/filesystems/caching/fscache.txt
@@ -83,9 +83,6 @@ then serving the pages out of that cache rather than the netfs inode because:
      one-off access of a small portion of it (such as might be done with the
      "file" program).
 
-It instead serves the cache out in PAGE_SIZE chunks as and when requested by
-the netfs('s) using it.
-
 
 FS-Cache provides the following facilities:
 
@@ -109,22 +106,22 @@ FS-Cache provides the following facilities:
      recursive, stack space is limited, and indices can only be children of
      indices.
 
- (7) Data I/O is done direct to and from the netfs's pages.  The netfs
-     indicates that page A is at index B of the data-file represented by cookie
-     C, and that it should be read or written.  The cache backend may or may
-     not start I/O on that page, but if it does, a netfs callback will be
-     invoked to indicate completion.  The I/O may be either synchronous or
-     asynchronous.
+ (7) The cache provides two basic I/O operations: write to the cache and read
+     from the cache.  These may be done synchronously or asynchronously and may
+     involve direct I/O.  The position and length of the request have to be
+     rounded to the I/O block size of the cache.
+
+ (8) The cache doesn't keep track of any of the netfs state and retains no
+     pointers back into the netfs.  The netfs is entirely responsible for
+     telling the cache what to do.  A number of helpers are provided to manage
+     the interaction.
 
  (8) Cookies can be "retired" upon release.  At this point FS-Cache will mark
      them as obsolete and the index hierarchy rooted at that point will get
      recycled.
 
- (9) The netfs provides a "match" function for index searches.  In addition to
-     saying whether a match was made or not, this can also specify that an
-     entry should be updated or deleted.
-
-(10) As much as possible is done asynchronously.
+ (9) Coherency data and index keys are stored in the cookie.  This is used by
+     the cache to determine whether the stored data is still valid.
 
 
 FS-Cache maintains a virtual indexing tree in which all indices, files, objects
@@ -144,33 +141,19 @@ caches.
      +------------+           +---------------+              +----------+
      |            |           |               |              |          |
    00001        00002       00007           00125        vol00001   vol00002
-     |            |           |               |                         |
- +---+---+     +-----+      +---+      +------+------+            +-----+----+
- |   |   |     |     |      |   |      |      |      |            |     |    |
-PG0 PG1 PG2   PG0  XATTR   PG0 PG1   DIRENT DIRENT DIRENT        R/W   R/O  Bak
-                     |                                            |
-                    PG0                                       +-------+
-                                                              |       |
-                                                            00001   00003
-                                                              |
-                                                          +---+---+
-                                                          |   |   |
-                                                         PG0 PG1 PG2
+                                                             |
+                                                         +-------+
+                                                         |       |
+                                                       00001   00003
 
 In the example above, you can see two netfs's being backed: NFS and AFS.  These
 have different index hierarchies:
 
  (*) The NFS primary index contains per-server indices.  Each server index is
-     indexed by NFS file handles to get data file objects.  Each data file
-     objects can have an array of pages, but may also have further child
-     objects, such as extended attributes and directory entries.  Extended
-     attribute objects themselves have page-array contents.
+     indexed by NFS file handles to get data objects.
 
  (*) The AFS primary index contains per-cell indices.  Each cell index contains
-     per-logical-volume indices.  Each of volume index contains up to three
-     indices for the read-write, read-only and backup mirrors of those volumes.
-     Each of these contains vnode data file objects, each of which contains an
-     array of pages.
+     logical volume indices and each of those contains vnode data file objects.
 
 The very top index is the FS-Cache master index in which individual netfs's
 have entries.


