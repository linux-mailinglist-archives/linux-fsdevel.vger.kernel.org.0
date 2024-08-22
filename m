Return-Path: <linux-fsdevel+bounces-26589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B195A8BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8D5282540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C228A10A3D;
	Thu, 22 Aug 2024 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vv29XECg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797A5684
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286175; cv=none; b=fyzHec/D2TXk5tSFaIU97E3i9o/tCuJDadwdnFHBkC1LIqAzCBe0eQTpJD2QpPnGx2PuTnqW0VympkOBynky8qEVrhQhMjONoXVPKLFLgudcwhU872+SEQho1TLCICjivlzV5yTOGka3pDZIi+LI5cCPM4Dm0zdCF50u5zYEb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286175; c=relaxed/simple;
	bh=03n1FXPp85Q4o6e3I0m/ac88izXlYUZZM4xSMvu58yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rbi8ltVCFMmUNSi9VSDqZIE1xtOJzX5M/xEecYsH2idPQvPPoo3mJJjuT7kjVTCw07kcKnODTOCKoB2YiIqkWQBqIMBTj0Gkgl+e0IFW1C5rRTCSn9OgD7W2Ou3UQQWC+fxsHXQQ+53FBbOkb+q9Y6Xtzv8t5DAT0Lu5Q1pSK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vv29XECg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+IVDfztFZ3s9X2TyGl/CGxJAgCNitALnXXZMH6xny9s=; b=vv29XECgMq9jTPXmKmDy9CvzUk
	Qe8G2w5PIQOeIcmkuIQppbkx76ovfjTtMb7jXsB5P9e6IWcyj5/bbclFwR186tlBAImbeDBQ2zqkY
	aS2XFMcicWIqn8KJVv0GPpvuxz3UAadTP5G0EJ7WHIhnIMu++sIWRqFVwyMPVne5B5nXlmdkAV0aQ
	WufhmuewmYNPds6RGbFDhKsBvmo8WnUk7jBdkFCuwmtFCY2nB4Gf3++EnBc8/sKIpGwU/3HzjJoqK
	Am9iLWijrrao8CgMD62vt6VecdZE8HAe/YuVTtDaBAKhCvEP6DwrV+vGQUklVqC10kzc8Je5b9FDJ
	HdkH3K2A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvbH-00000003w8P-2wwQ;
	Thu, 22 Aug 2024 00:22:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 11/12] make __set_open_fd() set cloexec state as well
Date: Thu, 22 Aug 2024 01:22:49 +0100
Message-ID: <20240822002250.938396-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822002250.938396-1-viro@zeniv.linux.org.uk>
References: <20240822002012.GM504335@ZenIV>
 <20240822002250.938396-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

->close_on_exec[] state is maintained only for opened descriptors;
as the result, anything that marks a descriptor opened has to
set its cloexec state explicitly.

As the result, all calls of __set_open_fd() are followed by
__set_close_on_exec(); might as well fold it into __set_open_fd()
so that cloexec state is defined as soon as the descriptor is
marked opened.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 61fb8994203f..411e658c3fa3 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -248,12 +248,13 @@ static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt,
 	}
 }
 
-static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
+static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt, bool set)
 {
 	__set_bit(fd, fdt->open_fds);
 	fd /= BITS_PER_LONG;
 	if (!~fdt->open_fds[fd])
 		__set_bit(fd, fdt->full_fds_bits);
+	__set_close_on_exec(fd, fdt, set);
 }
 
 static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
@@ -517,8 +518,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	if (start <= files->next_fd)
 		files->next_fd = fd + 1;
 
-	__set_open_fd(fd, fdt);
-	__set_close_on_exec(fd, fdt, flags & O_CLOEXEC);
+	__set_open_fd(fd, fdt, flags & O_CLOEXEC);
 	error = fd;
 
 out:
@@ -1186,8 +1186,7 @@ __releases(&files->file_lock)
 		goto Ebusy;
 	get_file(file);
 	rcu_assign_pointer(fdt->fd[fd], file);
-	__set_open_fd(fd, fdt);
-	__set_close_on_exec(fd, fdt, flags & O_CLOEXEC);
+	__set_open_fd(fd, fdt, flags & O_CLOEXEC);
 	spin_unlock(&files->file_lock);
 
 	if (tofree)
-- 
2.39.2


