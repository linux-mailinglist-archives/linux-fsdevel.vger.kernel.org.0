Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11F525640F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 04:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgH2CAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 22:00:05 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:47890 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgH2CAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 22:00:03 -0400
Date:   Fri, 28 Aug 2020 22:00:02 -0400
From:   Rich Felker <dalias@libc.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [RESEND PATCH] vfs: add RWF_NOAPPEND flag for pwritev2
Message-ID: <20200829020002.GC3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pwrite function, originally defined by POSIX (thus the "p"), is
defined to ignore O_APPEND and write at the offset passed as its
argument. However, historically Linux honored O_APPEND if set and
ignored the offset. This cannot be changed due to stability policy,
but is documented in the man page as a bug.

Now that there's a pwritev2 syscall providing a superset of the pwrite
functionality that has a flags argument, the conforming behavior can
be offered to userspace via a new flag. Since pwritev2 checks flag
validity (in kiocb_set_rw_flags) and reports unknown ones with
EOPNOTSUPP, callers will not get wrong behavior on old kernels that
don't support the new flag; the error is reported and the caller can
decide how to handle it.

Signed-off-by: Rich Felker <dalias@libc.org>
---
 include/linux/fs.h      | 4 ++++
 include/uapi/linux/fs.h | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

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
-- 
2.21.0

