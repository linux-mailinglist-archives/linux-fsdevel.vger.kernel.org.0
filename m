Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D25AC74
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 18:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfF2QML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 12:12:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44315 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfF2QMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 12:12:10 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so19053646iob.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Jun 2019 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GmfA3jYBxBJnUAvD/8TjwaL9dXhdDrssQzH0v0aAD1I=;
        b=feoXS3IjQBvjAkZNj1rTzaxOgPZkD6QjChzhNgkVhIJqY3hY7dMhI4cK+gFDtyfFwY
         l2a2rhYA+fEojBxEj9AuFmfPB7pSj9/olc4wo/4q/PQ6ZSvI0IpTPGzA6EbrUFynzsyc
         eOnDKuufZL1M6cI2O56zjf202tHazGIx8W7D2gEra3UuEfuIJ0JGI3/8DrEBV/AGTnRt
         TAIQHKtBhBloHQpUmKRenUHFXMz9GjTVS5NjfVOejHaJ/dLrGAelDjC4JzmADfd1uPmh
         YmwHl+d+auuH0U4topF/wvVl5PJCoIEtwmK1YCoMlvRXnUYmVssQ5mRi3GDcxABMvdhE
         b0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GmfA3jYBxBJnUAvD/8TjwaL9dXhdDrssQzH0v0aAD1I=;
        b=RXuTsfp66+YMnm9Ntp2XVBrXhdZLdrL7o18wSwqumFOhSBI/rGyVyS3VemBGC7tWNR
         v0EpDIqUjv04tq0dzCndD/rZqCt9enoZpEbucVFxRIxC6h+JnVVM+95BImu4vcLe15Ed
         cA3PHNk89gzPSpdJLVKAFYkktr6vlnJNPVhMP0VkTLt9tfI94k3ZvGh4a7aU1uebcUeH
         8eYYOLZnHejfZIQE0lrRoHaQ9uO8fp/aYqDs2Cf6CgEjagoh8xa3X26sU8U8JkOCPEd/
         7RsSBhN5N7TKS6MsvvSLdsjKlqe2vlrmLXmfGJHShmUKj1tuOpCgsVKEVEe/mvhtogic
         +7tA==
X-Gm-Message-State: APjAAAXgKdNe82pFl8VRnWJPmMAybqIpJlUFmMfQYuyQo52OsfBGKBc7
        df20nyjfHXZhqet20w1gXxAtbzi0+6BdPQ==
X-Google-Smtp-Source: APXvYqynTF/R3n6jpMSbfSeELzl0LBuexHwF4iMWJj/LPlDWgdbwMmBAjRXdoyGwFmGZ8GMOhtbkCA==
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr17890640ion.239.1561824729404;
        Sat, 29 Jun 2019 09:12:09 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o5sm4743484iob.7.2019.06.29.09.12.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 09:12:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     davem@davemloft.net, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] io_uring: add support for sendmsg()
Date:   Sat, 29 Jun 2019 10:12:03 -0600
Message-Id: <20190629161204.27226-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629161204.27226-1-axboe@kernel.dk>
References: <20190629161204.27226-1-axboe@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is done through IORING_OP_SENDMSG. There's a new sqe->msg_flags
for the flags argument, and the msghdr struct is passed in the
sqe->addr field.

We use MSG_DONTWAIT to force an inline fast path if sendmsg() doesn't
block, and punt to async execution if it would have.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 40 +++++++++++++++++++++++++++++++++++
 include/linux/socket.h        |  4 ++++
 include/uapi/linux/io_uring.h |  2 ++
 net/socket.c                  |  7 ++++++
 4 files changed, 53 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9f0ef4956f87..5d4cd8c4132d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1390,6 +1390,43 @@ static int io_sync_file_range(struct io_kiocb *req,
 	return 0;
 }
 
+static int io_sendmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
+		      bool force_nonblock)
+{
+#if defined(CONFIG_NET)
+	struct socket *sock;
+	int ret;
+
+	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+
+	sock = sock_from_file(req->file, &ret);
+	if (sock) {
+		struct user_msghdr __user *msg;
+		unsigned flags;
+
+		flags = READ_ONCE(sqe->msg_flags);
+		if (flags & MSG_DONTWAIT)
+			req->flags |= REQ_F_NOWAIT;
+		else if (force_nonblock)
+			flags |= MSG_DONTWAIT;
+
+		msg = (struct user_msghdr __user *) (unsigned long)
+			READ_ONCE(sqe->addr);
+
+		ret = __sys_sendmsg_sock(sock, msg, flags);
+		if (force_nonblock && ret == -EAGAIN)
+			return ret;
+	}
+
+	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_put_req(req);
+	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
 static void io_poll_remove_one(struct io_kiocb *req)
 {
 	struct io_poll_iocb *poll = &req->poll;
@@ -1675,6 +1712,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_SYNC_FILE_RANGE:
 		ret = io_sync_file_range(req, s->sqe, force_nonblock);
 		break;
+	case IORING_OP_SENDMSG:
+		ret = io_sendmsg(req, s->sqe, force_nonblock);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/linux/socket.h b/include/linux/socket.h
index b57cd8bf96e2..9d770ef3ced5 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -12,6 +12,7 @@
 
 struct pid;
 struct cred;
+struct socket;
 
 #define __sockaddr_check_size(size)	\
 	BUILD_BUG_ON(((size) > sizeof(struct __kernel_sockaddr_storage)))
@@ -374,6 +375,9 @@ extern int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 extern int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg,
 			  unsigned int vlen, unsigned int flags,
 			  bool forbid_cmsg_compat);
+extern long __sys_sendmsg_sock(struct socket *sock,
+			       struct user_msghdr __user *msg,
+			       unsigned int flags);
 
 /* helpers which do the actual work for syscalls */
 extern int __sys_recvfrom(int fd, void __user *ubuf, size_t size,
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 10b7c45f6d57..d74742d6269f 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -27,6 +27,7 @@ struct io_uring_sqe {
 		__u32		fsync_flags;
 		__u16		poll_events;
 		__u32		sync_range_flags;
+		__u32		msg_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	union {
@@ -58,6 +59,7 @@ struct io_uring_sqe {
 #define IORING_OP_POLL_ADD	6
 #define IORING_OP_POLL_REMOVE	7
 #define IORING_OP_SYNC_FILE_RANGE	8
+#define IORING_OP_SENDMSG	9
 
 /*
  * sqe->fsync_flags
diff --git a/net/socket.c b/net/socket.c
index bffec466b4f1..b9536940255e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2313,6 +2313,13 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
 /*
  *	BSD sendmsg interface
  */
+long __sys_sendmsg_sock(struct socket *sock, struct user_msghdr __user *msg,
+			unsigned int flags)
+{
+	struct msghdr msg_sys;
+
+	return ___sys_sendmsg(sock, msg, &msg_sys, flags, NULL, 0);
+}
 
 long __sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
 		   bool forbid_cmsg_compat)
-- 
2.17.1

