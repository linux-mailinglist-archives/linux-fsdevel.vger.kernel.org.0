Return-Path: <linux-fsdevel+bounces-4381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1890A7FF298
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E392819BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8072E51007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlROJCmT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287C2B9DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 12:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656B9C433C8;
	Thu, 30 Nov 2023 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701348576;
	bh=ZlCxoHM6aTXEK+7SoLSKlNAfXLIHJkuaGDjxE+FfjAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NlROJCmTJs1DzaYNrxcVW5TNFvjnRcBA2lPDUXZwgg5Fyx2oEuoUwjpCb1PWBIqNP
	 pbnk31MzsfhE8FLIbl6e6HH1Pf4rNcM2SQm3NaHilx428hHcpMOcquGTGN3WhsFgCb
	 KtJGv7wnxEdpUTl/6Ol1jpWOUhRhmHGoytFzTB6R1E58QO4Vi2trIqlEzAkk+B36vE
	 EqR5LAAUEPxrrBN1C6We5kuQkzEk4NrS0iLN0JCBRMgURdL1REqgH2+vnnX9RGcXaI
	 NO3E5gMAb05xsGLNfzr6Zs8r5y+w3brtLdcA342bfmc8PO8y7lnU9uOdal5ry9Vahh
	 K0H7/9MdwpQ4A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 30 Nov 2023 13:49:10 +0100
Subject: [PATCH RFC 4/5] file: stop exposing receive_fd_user()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-vfs-files-fixes-v1-4-e73ca6f4ea83@kernel.org>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
In-Reply-To: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>, 
 Carlos Llamas <cmllamas@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-7edf1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2546; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZlCxoHM6aTXEK+7SoLSKlNAfXLIHJkuaGDjxE+FfjAc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRmtFy1johwarV7PWPfCUmjxTVdyw+by1jbBAVa2O/d3
 DJlBr9QRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERscxkZ3rkVvznAcSzAb4Vx
 4hKRx/O++T+9Fu7884Bh3uYfscaFvYwMS7MfXRIMOZGmUxNyhC+O3f1Xo5KHuMsB+buscYcYmfX
 5AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Not every subsystem needs to have their own specialized helper.
Just us the __receive_fd() helper.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/file.h | 7 -------
 include/net/scm.h    | 9 +++++++++
 net/compat.c         | 2 +-
 net/core/scm.c       | 2 +-
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index 6e9099d29343..c0d5219c2852 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -101,13 +101,6 @@ extern int __receive_fd(struct file *file, int __user *ufd,
 
 extern int receive_fd(struct file *file, unsigned int o_flags);
 
-static inline int receive_fd_user(struct file *file, int __user *ufd,
-				  unsigned int o_flags)
-{
-	if (ufd == NULL)
-		return -EFAULT;
-	return __receive_fd(file, ufd, o_flags);
-}
 int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
 
 extern void flush_delayed_fput(void);
diff --git a/include/net/scm.h b/include/net/scm.h
index e8c76b4be2fe..8aae2468bae0 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -5,6 +5,7 @@
 #include <linux/limits.h>
 #include <linux/net.h>
 #include <linux/cred.h>
+#include <linux/file.h>
 #include <linux/security.h>
 #include <linux/pid.h>
 #include <linux/nsproxy.h>
@@ -208,5 +209,13 @@ static inline void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 	scm_destroy_cred(scm);
 }
 
+static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
+				  unsigned int flags)
+{
+	if (!ufd)
+		return -EFAULT;
+	return __receive_fd(f, ufd, flags);
+}
+
 #endif /* __LINUX_NET_SCM_H */
 
diff --git a/net/compat.c b/net/compat.c
index 6564720f32b7..485db8ee9b28 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -297,7 +297,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
 	int err = 0, i;
 
 	for (i = 0; i < fdmax; i++) {
-		err = receive_fd_user(scm->fp->fp[i], cmsg_data + i, o_flags);
+		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
 		if (err < 0)
 			break;
 	}
diff --git a/net/core/scm.c b/net/core/scm.c
index 880027ecf516..eec78e312550 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -319,7 +319,7 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
 	}
 
 	for (i = 0; i < fdmax; i++) {
-		err = receive_fd_user(scm->fp->fp[i], cmsg_data + i, o_flags);
+		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
 		if (err < 0)
 			break;
 	}

-- 
2.42.0


