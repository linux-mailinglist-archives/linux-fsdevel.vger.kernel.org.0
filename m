Return-Path: <linux-fsdevel+bounces-58530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 309B7B2EA56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D471CC1CBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB61F463B;
	Thu, 21 Aug 2025 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCWj2YC6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915951EA65;
	Thu, 21 Aug 2025 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738942; cv=none; b=e/Bh3uboIJt50yRdXvMkQGPzUAEThj0dYY1R9cHnxldAGddwR8nDCv680n2qDvvhES/Qh2pGDivuUvozWAi/mDZm7gom/4oJuzW4Dh6faVuc8OkaI8NUbl+/yC2ruRZKlSjv1s1MEpGds60/CJ/u6kLJ2HkAkdwp42XCeTOo1Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738942; c=relaxed/simple;
	bh=eAfV3aLapzfXe+sJESIhMUvLCcCdC8AnGrCVoMagius=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gD+E2u/NlvRXDRhqMHzEKHXkUb0HIkurmLWqRG0ksaz/6TwbkPD2AIhQB6SCmxxhoD8Ys/JfIvhHtV7LcYZW+0uvRARxmIiJYvyZH+QzifiLuK3IdiBTBrzE0fmsugGvwq2KhXBcKQZwMbPLJ4ReuF3jSO2hF67ahfAxHiHQ7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCWj2YC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE6EC4CEE7;
	Thu, 21 Aug 2025 01:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738941;
	bh=eAfV3aLapzfXe+sJESIhMUvLCcCdC8AnGrCVoMagius=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KCWj2YC6XazB2S+JU+8PDzpDwSEwRmPHds0i/fpWszwMh94I4jqSvuueULSeecbSm
	 Bs2rp0H51SqjYChOk+e05JK/uKYikx/HqXA0i8SJA7x73j2J98Zhs4lFMNEI5RSl3X
	 uVqcmKZ83+pfsfeQ6yTq3Dxj1cLvK616pRQQdNxUE1Eaingfj5ubpHkXEoIs+c2qZj
	 FpOAc1mKS+CIeEBb73XoRJjbnqljjca09kFXZVRv55Ev7MDRi1PHERdgXDVQEGCXTe
	 /hJkRIY6DEu5xL1ZqJ2OD+edpuOU6uLNVJhSgP1413l7ic2mh2oLPNxnGjoNuXOmk0
	 1nTDLqkF4MqHw==
Date: Wed, 20 Aug 2025 18:15:41 -0700
Subject: [PATCH 10/10] libext2fs: add posix advisory locking to the unix IO
 manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713514.21546.6857949488665021428.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713292.21546.5820947765655770281.stgit@frogsfrogsfrogs>
References: <175573713292.21546.5820947765655770281.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add support for using flock() to protect the files opened by the Unix IO
manager so that we can't mount the same fs multiple times.  This also
prevents systemd and udev from accessing the device while e2fsprogs is
doing something with the device.

Link: https://systemd.io/BLOCK_DEVICE_LOCKING/
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 2ee61395e1275f..4a841f7f2133d4 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -65,6 +65,12 @@
 #include <pthread.h>
 #endif
 
+#if defined(HAVE_SYS_FILE_H) && defined(HAVE_SIGNAL_H)
+# include <sys/file.h>
+# include <signal.h>
+# define WANT_LOCK_UNIX_FD
+#endif
+
 #if defined(__linux__) && defined(_IO) && !defined(BLKROGET)
 #define BLKROGET   _IO(0x12, 94) /* Get read-only status (0 = read_write).  */
 #endif
@@ -149,6 +155,9 @@ struct unix_private_data {
 	pthread_mutex_t bounce_mutex;
 	pthread_mutex_t stats_mutex;
 #endif
+#ifdef WANT_LOCK_UNIX_FD
+	int	lock_flags;
+#endif
 };
 
 #define IS_ALIGNED(n, align) ((((uintptr_t) n) & \
@@ -897,6 +906,47 @@ int ext2fs_fstat(int fd, ext2fs_struct_stat *buf)
 #endif
 }
 
+#ifdef WANT_LOCK_UNIX_FD
+static void unix_lock_alarm_handler(int signal, siginfo_t *data, void *p)
+{
+	/* do nothing, the signal will abort the flock operation */
+}
+
+static int unix_lock_fd(int fd, int flags)
+{
+	struct sigaction newsa = {
+		.sa_flags = SA_SIGINFO,
+		.sa_sigaction = unix_lock_alarm_handler,
+	};
+	struct sigaction oldsa;
+	const int operation = (flags & IO_FLAG_EXCLUSIVE) ? LOCK_EX : LOCK_SH;
+	int ret;
+
+	/* wait five seconds for the lock */
+	ret = sigaction(SIGALRM, &newsa, &oldsa);
+	if (ret)
+		return ret;
+
+	alarm(5);
+
+	ret = flock(fd, operation);
+	if (ret == 0)
+		ret = operation;
+	else if (errno == EINTR) {
+		errno = EWOULDBLOCK;
+		ret = -1;
+	}
+
+	alarm(0);
+	sigaction(SIGALRM, &oldsa, NULL);
+	return ret;
+}
+
+static void unix_unlock_fd(int fd)
+{
+	flock(fd, LOCK_UN);
+}
+#endif
 
 static errcode_t unix_open_channel(const char *name, int fd,
 				   int flags, io_channel *channel,
@@ -935,6 +985,16 @@ static errcode_t unix_open_channel(const char *name, int fd,
 	if (retval)
 		goto cleanup;
 
+#ifdef WANT_LOCK_UNIX_FD
+	if (flags & IO_FLAG_RW) {
+		data->lock_flags = unix_lock_fd(fd, flags);
+		if (data->lock_flags < 0) {
+			retval = errno;
+			goto cleanup;
+		}
+	}
+#endif
+
 	strcpy(io->name, name);
 	io->private_data = data;
 	io->block_size = 1024;
@@ -1201,6 +1261,10 @@ static errcode_t unix_close(io_channel channel)
 	if (retval2 && !retval)
 		retval = retval2;
 
+#ifdef WANT_LOCK_UNIX_FD
+	if (data->lock_flags)
+		unix_unlock_fd(data->dev);
+#endif
 	if (close(data->dev) < 0 && !retval)
 		retval = errno;
 	free_cache(data);


