Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33CCC14753D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 01:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgAXACp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 19:02:45 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:52738 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgAXACp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 19:02:45 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1iumQt-00039n-00; Fri, 24 Jan 2020 00:02:43 +0000
Date:   Thu, 23 Jan 2020 19:02:43 -0500
From:   Rich Felker <dalias@libc.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Proposal to fix pwrite with O_APPEND via pwritev2 flag
Message-ID: <20200124000243.GA12112@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's a longstanding unfixable (due to API stability) bug in the
pwrite syscall:

http://man7.org/linux/man-pages/man2/pwrite.2.html#BUGS

whereby it wrongly honors O_APPEND if set, ignoring the caller-passed
offset. Now that there's a pwritev2 syscall that takes a flags
argument, it's possible to fix this without breaking stability by
adding a new RWF_NOAPPEND flag, which callers that want the fixed
behavior can then pass.

I have a completely untested patch to add such a flag, but would like
to get a feel for whether the concept is acceptable before putting
time into testing it. If so, I'll submit this as a proper patch with
detailed commit message etc. Draft is below.

Rich



diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d35763..3a769a972f79 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3397,6 +3397,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 {
 	if (unlikely(flags & ~RWF_SUPPORTED))
 		return -EOPNOTSUPP;
+	if (unlikely((flags & RWF_APPEND) && (flags & RWF_NOAPPEND)))
+		return -EINVAL;
 
 	if (flags & RWF_NOWAIT) {
 		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
@@ -3411,6 +3413,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 		ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
 	if (flags & RWF_APPEND)
 		ki->ki_flags |= IOCB_APPEND;
+	if (flags & RWF_NOAPPEND)
+		ki->ki_flags &= ~IOCB_APPEND;
 	return 0;
 }
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 379a612f8f1d..591357d9b3c9 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -299,8 +299,11 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* per-IO negation of O_APPEND */
+#define RWF_NOAPPEND	((__force __kernel_rwf_t)0x00000020)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_NOAPPEND)
 
 #endif /* _UAPI_LINUX_FS_H */
