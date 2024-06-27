Return-Path: <linux-fsdevel+bounces-22633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A8991A8E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 16:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A28285B80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E2D198A01;
	Thu, 27 Jun 2024 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPwDBj2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C28195B33
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497519; cv=none; b=OTfnO8vUSG/UI4UJC6vGkfGzWA9zFrPYOtOrD+pVqlAh43tK69NSoDkB+cdXlp9HojeVm7BKCzR6R7X0PzUyuhsSxwcb/cIWLEffw1SKAHZr8S41kaitJT1zvEiGtvvbOr6Dn2GK1SmEcxb9wnT01q3nryFLtjOcFjdSXhYVSc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497519; c=relaxed/simple;
	bh=A7w7/irj2RmpEr99sp3WGnTDNScYARDxHYfDbPIBR14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gie8KB5bc7h1lWorDDYX7keCYydk8SzJjBVPdj7cOsgU/dmseTBtmcBXSaLrNmpRX/hsAjA8FerpQT7h0p+n9cMu35I0tzvyPKX+Jv8fN7oNNHmz7dmcPQv3qPaNdg+yF+yj34Q8HmsGZEis7tbybPXW7j8kPGe7sBdId2MP4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPwDBj2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEF2C4AF07;
	Thu, 27 Jun 2024 14:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719497518;
	bh=A7w7/irj2RmpEr99sp3WGnTDNScYARDxHYfDbPIBR14=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jPwDBj2IDZe2sJtjimDT//VKb6m1M+f1EzbiVSBXLaaVjJLjqzTRceqfzmRDCOfit
	 Svqc+g91yt7qrnJRZq8kNWH4Tho8c25tAF4zSxk+KMBTxM3TV52jt31+tl9Dwl8z5e
	 CQIiiQor30ziNX4ul+JbnpmCalpz3cbuq8WRdNYnzfDuyMxIktL6faJVIboEBJefFN
	 gyM0c6pxBRM6mvFAazda7XFgsJEWvHitaL22J/7t7gVgB20GnMC52k8Uj/ZTfrSshM
	 2Mchuf+2zUxHwSwdD/s2aF3CT4CAS5+rG6d0noqR3VHK3xaM33HYDMMnJ3xJ8BvuBn
	 OEjXl5P4nT0cQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 27 Jun 2024 16:11:39 +0200
Subject: [PATCH RFC 1/4] file: add take_fd() cleanup helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-work-pidfs-v1-1-7e9ab6cc3bb1@kernel.org>
References: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
In-Reply-To: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Seth Forshee <sforshee@kernel.org>, 
 Stephane Graber <stgraber@stgraber.org>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=brauner@kernel.org;
 h=from:subject:message-id; bh=A7w7/irj2RmpEr99sp3WGnTDNScYARDxHYfDbPIBR14=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTVFmuGu2maqU15enxlsHtMgk2wh0DX9dmT+u7dWdK6x
 VDwWXRTRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETiXjIyXNho0nzSdLlQUERq
 y8XP0hH6EzcrffhdFjZ1h/y1VGO9Ewz/zLZtnf+xScqsyux32pmoD/0brn83m5A1Pbg9piHc+ls
 NNwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a helper that returns the file descriptor and ensures that the old
variable contains a negative value. This makes it easy to rely on
CLASS(get_unused_fd).

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cleanup.h | 13 ++++++++-----
 include/linux/file.h    |  2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..80c4181e194a 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -63,17 +63,20 @@
 
 #define __free(_name)	__cleanup(__free_##_name)
 
-#define __get_and_null_ptr(p) \
-	({ __auto_type __ptr = &(p); \
-	   __auto_type __val = *__ptr; \
-	   *__ptr = NULL;  __val; })
+#define __get_and_null(p, nullvalue)   \
+	({                                  \
+		__auto_type __ptr = &(p);   \
+		__auto_type __val = *__ptr; \
+		*__ptr = nullvalue;         \
+		__val;                      \
+	})
 
 static inline __must_check
 const volatile void * __must_check_fn(const volatile void *val)
 { return val; }
 
 #define no_free_ptr(p) \
-	((typeof(p)) __must_check_fn(__get_and_null_ptr(p)))
+	((typeof(p)) __must_check_fn(__get_and_null(p, NULL)))
 
 #define return_ptr(p)	return no_free_ptr(p)
 
diff --git a/include/linux/file.h b/include/linux/file.h
index 45d0f4800abd..3ea7f2452f20 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -97,6 +97,8 @@ extern void put_unused_fd(unsigned int fd);
 DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
 	     get_unused_fd_flags(flags), unsigned flags)
 
+#define take_fd(fd) __get_and_null(fd, -EBADF)
+
 extern void fd_install(unsigned int fd, struct file *file);
 
 int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags);

-- 
2.43.0


