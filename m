Return-Path: <linux-fsdevel+bounces-61622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D671CB58A60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE4D17D9A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7131DE8AF;
	Tue, 16 Sep 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW9rh5Cp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AE3D2FB;
	Tue, 16 Sep 2025 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984324; cv=none; b=GgsN23Z7U/bozKlTdnL3ZLq5rTi1b8JarLewaAioo3YdG4xhiaJCUJYY/z2/jQvoqLMNKTj2zVnyzQS0puklprCJsbVqAROuN6hKAYtx6ca2HV/wW3s+vQ5oOQXdpEsj28UcrD4Yx/a8Y+bx1+kJCLM8Nm3GBazJlXbc6TWoKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984324; c=relaxed/simple;
	bh=7rW1rGQbbbJuG2g2uwBNXcIrzw1F0UjmZsC+E7IdHHk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQ3CEHS6alWhvJFPQCNHplJlnzVUH/x7wFgzltlN/Y/buCD+Ukql9Giw8bkvok6w30E5+SNUfikYoHc0qie7GwUliepfGTLvpt34/gwfFh+kYneYkaSJuJJDKZI8DRCqTF6/xMNhBVAiuktwcS2i+QYHDDI+jE6zkqIuNPRtpPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW9rh5Cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA70CC4CEF1;
	Tue, 16 Sep 2025 00:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984324;
	bh=7rW1rGQbbbJuG2g2uwBNXcIrzw1F0UjmZsC+E7IdHHk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GW9rh5CpIq0rqm85spHDTybUZoMBOiHcrtFC1vh2lkkBnwf+NYRgZ69sERRv7wreM
	 G4fpY/agO29Qg6WYamvTYr8xvaU5lR6weBynlvxilLXQJh0oIGKCoPi0k3hO5/pjfi
	 eWoZp3DEZgxi1RXVmMzV375Q8kuEnDt1AvH50zW23Xu3dgXKZ2HrkJELqaXV5t8TGr
	 FAufpl12VQCB5yoKCJCilePOShGYprMnx3wBbFMl859KDvJ6deSXeJaWSOv7SsYBxG
	 Zz93/ixiQ5E8jpclAOAEdXY84fIDRILaf9MlsW7Ltz0CFJkn7vm6SgXKR2Ju5YNFFR
	 ZyZOV2TDD0bGg==
Date: Mon, 15 Sep 2025 17:58:43 -0700
Subject: [PATCH 10/10] libext2fs: add posix advisory locking to the unix IO
 manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161504.390072.1450648323017490117.stgit@frogsfrogsfrogs>
In-Reply-To: <175798161283.390072.8565583077948994821.stgit@frogsfrogsfrogs>
References: <175798161283.390072.8565583077948994821.stgit@frogsfrogsfrogs>
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
index 068be689326443..55007ad7d2ae15 100644
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
@@ -1200,6 +1260,10 @@ static errcode_t unix_close(io_channel channel)
 	if (retval2 && !retval)
 		retval = retval2;
 
+#ifdef WANT_LOCK_UNIX_FD
+	if (data->lock_flags)
+		unix_unlock_fd(data->dev);
+#endif
 	if (close(data->dev) < 0 && !retval)
 		retval = errno;
 	free_cache(data);


