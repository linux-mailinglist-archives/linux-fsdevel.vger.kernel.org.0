Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52D6257CF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 17:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgHaPcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 11:32:18 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:48522 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgHaPcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:32:12 -0400
Date:   Mon, 31 Aug 2020 11:32:08 -0400
From:   Rich Felker <dalias@libc.org>
To:     Jann Horn <jannh@google.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2] vfs: add RWF_NOAPPEND flag for pwritev2
Message-ID: <20200831153207.GO3265@brightrain.aerifal.cx>
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

Changes in v2: I've added a check to ensure that RWF_NOAPPEND does not
override O_APPEND for S_APPEND (chattr +a) inodes, and fixed conflicts
with 1752f0adea98ef85, which optimized kiocb_set_rw_flags to work with
a local copy of flags. Unfortunately the same optimization does not
work for RWF_NOAPPEND since it needs to remove flags from the original
set at function entry.

If desired, I could further change this so that kiocb_flags is
initialized to ki->ki_flags, with assignment-back in place of |= at
the end of the function. This would allow the same local variable
pattern in the RWF_NOAPPEND code path, which might be more elegant,
but I'm not sure if the emitted code would improve or get worse.


 include/linux/fs.h      | 7 +++++++
 include/uapi/linux/fs.h | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7519ae003a08..924e17ac8e7e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3321,6 +3321,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 		return 0;
 	if (unlikely(flags & ~RWF_SUPPORTED))
 		return -EOPNOTSUPP;
+	if (unlikely((flags & RWF_APPEND) && (flags & RWF_NOAPPEND)))
+		return -EINVAL;
 
 	if (flags & RWF_NOWAIT) {
 		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
@@ -3335,6 +3337,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 		kiocb_flags |= (IOCB_DSYNC | IOCB_SYNC);
 	if (flags & RWF_APPEND)
 		kiocb_flags |= IOCB_APPEND;
+	if ((flags & RWF_NOAPPEND) && (ki->ki_flags & IOCB_APPEND)) {
+		if (IS_APPEND(file_inode(ki->ki_filp)))
+			return -EPERM;
+		ki->ki_flags &= ~IOCB_APPEND;
+	}
 
 	ki->ki_flags |= kiocb_flags;
 	return 0;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index f44eb0a04afd..d5e54e0742cf 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -300,8 +300,11 @@ typedef int __bitwise __kernel_rwf_t;
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

