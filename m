Return-Path: <linux-fsdevel+bounces-24195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B6093B169
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 15:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83C61C2348D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 13:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EAD158D84;
	Wed, 24 Jul 2024 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k11e+Rnv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA468157A59
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826971; cv=none; b=rhx/Ba/DnpHHmB9t/jgA6CSeCwZuj5XQDbUN8UMY8k6fgJn7TYOpL7jbgKhxkmSmKXRZCBoo5kCYyuOU1Xp88aNRXoW1hqJzixHFsC7TTU8yGHv8JxE/TsD76jYJ4WcvbPCSwrJpO4UmLIBaR5zASCP9GOKG+gJhW0W9dV4jgls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826971; c=relaxed/simple;
	bh=4B62wSVZw2/r8Uqwl5MB2ZadlQhMD0gdG95BwmZtIqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3i/7yP2f/tFXQLvCgYWB/ujlTxmvJbJvVBsP9A1GoPR0C6hkg0I3UB4b2cgcGuvo+bIfZWYnSWwRQcHygP05OjQQCTYkHac0v1OZs9xnuDSssWo5PodYJj3sghK8u1UBQx+y6VhjMiIwkzShLP6X6VA1138vzsYhrWo4C4JvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k11e+Rnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CFBC4AF0C;
	Wed, 24 Jul 2024 13:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721826971;
	bh=4B62wSVZw2/r8Uqwl5MB2ZadlQhMD0gdG95BwmZtIqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k11e+Rnv0IceRRHAXSgBoSG4DYyqIkPdfh01i+z+24+ehMD7GAspH8YUcnze7Q6Y4
	 CMuZLSYJsWHPnMszwuOZmt96miDPWqPQ+IKmr5sOzvpYmGKkcl/OynxUBVq6tQ3pdn
	 BPkjVMx6lQ+12ToeTJG+Hh8GOYywUoUQm+A0qm61Z6F6cVKthwwYE0MfAete2xkr65
	 yO+KknEGA5zBU7rPydOhiIxVAPy8uGzOljUWzkIYkoRlcdQfO5Q12gcS9Ee92buFjc
	 66JTEJcUwx4CxBl8LksqwzezY64vg5f+K2WI2+fO5ZWjQ7Fi47w4fbRmwhKx++o6R+
	 XdBJ9o0eEIceg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 24 Jul 2024 15:15:35 +0200
Subject: [PATCH RFC 1/2] fcntl: add F_CREATED
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-work-fcntl-v1-1-e8153a2f1991@kernel.org>
References: <20240724-work-fcntl-v1-0-e8153a2f1991@kernel.org>
In-Reply-To: <20240724-work-fcntl-v1-0-e8153a2f1991@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=4534; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4B62wSVZw2/r8Uqwl5MB2ZadlQhMD0gdG95BwmZtIqU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQt+Dft9fKm07s3xyT/zP+WOJXrza0tTrNYfjco/bOZ0
 JahERoX2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR/UxGht3NUitl1rDuPfzD
 StD1pNFj0crVJ3tnnWrwPLGcI51NaQUjw+ucuODXmpXHJU4m7dqt+4D1/w/dtkNRPioPlv5M2Kq
 2lxMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Systemd has a helper called openat_report_new() that returns whether a
file was created anew or it already existed before for cases where
O_CREAT has to be used without O_EXCL (cf. [1]). That apparently isn't
something that's specific to systemd but it's where I noticed it.

The current logic is that it first attempts to open the file without
O_CREAT | O_EXCL and if it gets ENOENT the helper tries again with both
flags. If that succeeds all is well. If it now reports EEXIST it
retries.

That works fairly well but some corner cases make this more involved. If
this operates on a dangling symlink the first openat() without O_CREAT |
O_EXCL will return ENOENT but the second openat() with O_CREAT | O_EXCL
will fail with EEXIST. The reason is that openat() without O_CREAT |
O_EXCL follows the symlink while O_CREAT | O_EXCL doesn't for security
reasons. So it's not something we can really change unless we add an
explicit opt-in via O_FOLLOW which seems really ugly.

The caller could try and use fanotify() to register to listen for
creation events in the directory before calling openat(). The caller
could then compare the returned tid to its own tid to ensure that even
in threaded environments it actually created the file. That might work
but is a lot of work for something that should be fairly simple and I'm
uncertain about it's reliability.

The caller could use a bpf lsm hook to hook into security_file_open() to
figure out whether they created the file. That also seems a bit wild.

So let's add F_CREATED which allows the caller to check whether they
actually did create the file. That has caveats of course but I don't
think they are problematic:

* In multi-threaded environments a thread can only be sure that it did
  create the file if it calls openat() with O_CREAT. In other words,
  it's obviously not enough to just go through it's fdtable and check
  these fds because another thread could've created the file.

* If there's any codepaths where an openat() with O_CREAT would yield
  the same struct file as that of another thread it would obviously
  cause wrong results. I'm not aware of any such codepaths from openat()
  itself. Imho, that would be a bug.

* Related to the previous point, calling the new fcntl() on files created
  and opened via special-purpose system calls or ioctl()s would cause
  wrong results only if the affected subsystem a) raises FMODE_CREATED
  and b) may return the same struct file for two different calls. I'm
  not seeing anything outside of regular VFS code that raises
  FMODE_CREATED.

  There is code for b) in e.g., the drm layer where the same struct file
  is resurfaced but again FMODE_CREATED isn't used and it would be very
  misleading if it did.

Link: https://github.com/systemd/systemd/blob/11d5e2b5fbf9f6bfa5763fd45b56829ad4f0777f/src/basic/fs-util.c#L1078 [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fcntl.c                 | 10 ++++++++++
 include/uapi/linux/fcntl.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 300e5d9ad913..55a66ad9b432 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -343,6 +343,12 @@ static long f_dupfd_query(int fd, struct file *filp)
 	return f.file == filp;
 }
 
+/* Let the caller figure out whether a given file was just created. */
+static long f_created(const struct file *filp)
+{
+	return !!(filp->f_mode & FMODE_CREATED);
+}
+
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
@@ -352,6 +358,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	long err = -EINVAL;
 
 	switch (cmd) {
+	case F_CREATED:
+		err = f_created(filp);
+		break;
 	case F_DUPFD:
 		err = f_dupfd(argi, filp, 0);
 		break;
@@ -463,6 +472,7 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 static int check_fcntl_cmd(unsigned cmd)
 {
 	switch (cmd) {
+	case F_CREATED:
 	case F_DUPFD:
 	case F_DUPFD_CLOEXEC:
 	case F_DUPFD_QUERY:
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index c0bcc185fa48..d78a6c237688 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -16,6 +16,9 @@
 
 #define F_DUPFD_QUERY	(F_LINUX_SPECIFIC_BASE + 3)
 
+/* Was the file just created? */
+#define F_CREATED	(F_LINUX_SPECIFIC_BASE + 4)
+
 /*
  * Cancel a blocking posix lock; internal use only until we expose an
  * asynchronous lock api to userspace:

-- 
2.43.0


