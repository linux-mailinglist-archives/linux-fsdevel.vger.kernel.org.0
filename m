Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 645503A691
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2019 17:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfFIPJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jun 2019 11:09:16 -0400
Received: from mail177-30.suw61.mandrillapp.com ([198.2.177.30]:1459 "EHLO
        mail177-30.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728678AbfFIPJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jun 2019 11:09:16 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jun 2019 11:09:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=/BfBSryqLYb5jb5bpRRHljjnFOtlnTlngD5C6CvtqbY=;
 b=C4OtMu/GPLTz9vYUtl7SM5eBB+r58mjjiy8hlYRXeWyy8pc+3U0P/Dfs2z4Odxb6rUsY2NJR0okz
   WjASNNJGPe8Qzdlntgep+I1SZGq0AZae09vOxPj0w1cj332k9EZDntfM6aR6ZAfhTZtfEzINXxgH
   c6byd/yTwb3Z0oYkzQI=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-30.suw61.mandrillapp.com id hvkghm22rtkv for <linux-fsdevel@vger.kernel.org>; Sun, 9 Jun 2019 14:39:10 +0000 (envelope-from <bounce-md_31050260.5cfd1a0e.v1-bd496fd11b384500a69816183721fc52@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1560091150; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=/BfBSryqLYb5jb5bpRRHljjnFOtlnTlngD5C6CvtqbY=; 
 b=i4cYj4vhrG+8FWgUgvPLlhm5hjks+AA6/j7KkHLPY2eWPlCBEr+XzjCMOpfYvjRZxOmNGH
 aqZBd/Ny7ZYPD6U5HzlByKgRjwHC2l8B0cSSHvI0NrJXqZmtUeA2YzY2CSKEPC3HkS3db77K
 84bRm2JC9mZu0vN5sPb64+HOYC43w=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 4.4 2/2] fuse: Add FOPEN_STREAM to use stream_open()
Received: from [87.98.221.171] by mandrillapp.com id bd496fd11b384500a69816183721fc52; Sun, 09 Jun 2019 14:39:10 +0000
X-Mailer: git-send-email 2.20.1
To:     <stable@vger.kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Message-Id: <20190609132443.9420-3-kirr@nexedi.com>
In-Reply-To: <20190609132443.9420-1-kirr@nexedi.com>
References: <20190609132443.9420-1-kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.bd496fd11b384500a69816183721fc52
X-Mandrill-User: md_31050260
Date:   Sun, 09 Jun 2019 14:39:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit bbd84f33652f852ce5992d65db4d020aba21f882 upstream.

Starting from commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per
POSIX") files opened even via nonseekable_open gate read and write via lock
and do not allow them to be run simultaneously. This can create read vs
write deadlock if a filesystem is trying to implement a socket-like file
which is intended to be simultaneously used for both read and write from
filesystem client.  See commit 10dce8af3422 ("fs: stream_open - opener for
stream-like files so that read and write can run simultaneously without
deadlock") for details and e.g. commit 581d21a2d02a ("xenbus: fix deadlock
on writes to /proc/xen/xenbus") for a similar deadlock example on
/proc/xen/xenbus.

To avoid such deadlock it was tempting to adjust fuse_finish_open to use
stream_open instead of nonseekable_open on just FOPEN_NONSEEKABLE flags,
but grepping through Debian codesearch shows users of FOPEN_NONSEEKABLE,
and in particular GVFS which actually uses offset in its read and write
handlers

	https://codesearch.debian.net/search?q=-%3Enonseekable+%3D
	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1080
	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1247-1346
	https://gitlab.gnome.org/GNOME/gvfs/blob/1.40.0-6-gcbc54396/client/gvfsfusedaemon.c#L1399-1481

so if we would do such a change it will break a real user.

Add another flag (FOPEN_STREAM) for filesystem servers to indicate that the
opened handler is having stream-like semantics; does not use file position
and thus the kernel is free to issue simultaneous read and write request on
opened file handle.

This patch together with stream_open() should be added to stable kernels
starting from v3.14+. This will allow to patch OSSPD and other FUSE
filesystems that provide stream-like files to return FOPEN_STREAM |
FOPEN_NONSEEKABLE in open handler and this way avoid the deadlock on all
kernel versions. This should work because fuse_finish_open ignores unknown
open flags returned from a filesystem and so passing FOPEN_STREAM to a
kernel that is not aware of this flag cannot hurt. In turn the kernel that
is not aware of FOPEN_STREAM will be < v3.14 where just FOPEN_NONSEEKABLE
is sufficient to implement streams without read vs write deadlock.

Cc: stable@vger.kernel.org # v3.14+
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c            | 4 +++-
 include/uapi/linux/fuse.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d40c2451487c..cf50020f9f27 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -178,7 +178,9 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 		file->f_op = &fuse_direct_io_file_operations;
 	if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 		invalidate_inode_pages2(inode->i_mapping);
-	if (ff->open_flags & FOPEN_NONSEEKABLE)
+	if (ff->open_flags & FOPEN_STREAM)
+		stream_open(inode, file);
+	else if (ff->open_flags & FOPEN_NONSEEKABLE)
 		nonseekable_open(inode, file);
 	if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC)) {
 		struct fuse_inode *fi = get_fuse_inode(inode);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c9aca042e61d..d3a5cf3b5446 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -205,10 +205,12 @@ struct fuse_file_lock {
  * FOPEN_DIRECT_IO: bypass page cache for this open file
  * FOPEN_KEEP_CACHE: don't invalidate the data cache on open
  * FOPEN_NONSEEKABLE: the file is not seekable
+ * FOPEN_STREAM: the file is stream-like (no file position at all)
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
 #define FOPEN_NONSEEKABLE	(1 << 2)
+#define FOPEN_STREAM		(1 << 4)
 
 /**
  * INIT request/reply flags
-- 
2.20.1
