Return-Path: <linux-fsdevel+bounces-33532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 606B69B9D27
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 099F3B2315B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027F71AB6DA;
	Sat,  2 Nov 2024 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XHBop7Q0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C152149E17;
	Sat,  2 Nov 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524116; cv=none; b=sg2i16gGfQ4pLR3sLogW19aHJdCieoeosu7DFugpRLG2g59CJu7HyGvDUSIlNnkGINHbfehBHHfK2YBsC3gUYHPKopgJ6EWNNtpqIk0VTGHXCNQV7ZliKglPLBbW+8mHTaBkwjj9MMkyGBvgzk5jEkzAH2sx6X9kd/olmGbQayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524116; c=relaxed/simple;
	bh=D4OvnR7bvGfyffyPknd4OovPSuNubSSDGJpRJWw+NKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwO5BVUiqdIVzUMWuMjOzkPtrj7vUOCEbdlHgVrnYzHeaNZ9dUY83/XM4TbBptkVC/vR36rO5oZzscYyT3NBAMnE4Z3J1Egc7L8yH9jwJxU6UH0B5F2uxXn69hamfYwno+Z69T6TkFGo2dmiBM+UJHYN2CE1SXYAirzDJ7feYXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XHBop7Q0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=G3j2tuZKqezqznv2rlyENPKnz3THQjAkmHgi/G15VF0=; b=XHBop7Q07mCTMaITNn3hHCFzzX
	fzpUK3ioUAvZ5GA7KVFKlvCcbHHvcFBdWnND5IQn9nqPuDBdK1wg8Co3HB3SSdYh5eXnxW1Z5qfYt
	Gx+tretk9p1RKhcq3YqYwQW2U7ANMe7hgm7ts8b86t+gp+Mq8+Hruf2xqbSYbdQ7qlrMIJOgj34QS
	mYscVk4vOktrYweKh8Yb0xc5fRENMtL846Qn/uFXNOhEgpCQJzvCtYY5g3IlAVESx2Cta43OqIEEh
	GYjmK2Pdg9alNscCm31B11sPEH6xF/Px/WkQHH0cyV7CFhaMmtIKJTsZB5Fg21ai+aS9gzwlY1H6W
	nUE8jGIg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NB-0000000AHnK-1oxE;
	Sat, 02 Nov 2024 05:08:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 16/28] convert do_preadv()/do_pwritev()
Date: Sat,  2 Nov 2024 05:08:14 +0000
Message-ID: <20241102050827.2451599-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

fdput() can be transposed with add_{r,w}char() and inc_sysc{r,w}();
it's the same story as with do_readv()/do_writev(), only with
fdput() instead of fdput_pos().

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/read_write.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index deb87457aa76..f6e9232eacd8 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1113,18 +1113,16 @@ static inline loff_t pos_from_hilo(unsigned long high, unsigned long low)
 static ssize_t do_preadv(unsigned long fd, const struct iovec __user *vec,
 			 unsigned long vlen, loff_t pos, rwf_t flags)
 {
-	struct fd f;
 	ssize_t ret = -EBADF;
 
 	if (pos < 0)
 		return -EINVAL;
 
-	f = fdget(fd);
-	if (fd_file(f)) {
+	CLASS(fd, f)(fd);
+	if (!fd_empty(f)) {
 		ret = -ESPIPE;
 		if (fd_file(f)->f_mode & FMODE_PREAD)
 			ret = vfs_readv(fd_file(f), vec, vlen, &pos, flags);
-		fdput(f);
 	}
 
 	if (ret > 0)
@@ -1136,18 +1134,16 @@ static ssize_t do_preadv(unsigned long fd, const struct iovec __user *vec,
 static ssize_t do_pwritev(unsigned long fd, const struct iovec __user *vec,
 			  unsigned long vlen, loff_t pos, rwf_t flags)
 {
-	struct fd f;
 	ssize_t ret = -EBADF;
 
 	if (pos < 0)
 		return -EINVAL;
 
-	f = fdget(fd);
-	if (fd_file(f)) {
+	CLASS(fd, f)(fd);
+	if (!fd_empty(f)) {
 		ret = -ESPIPE;
 		if (fd_file(f)->f_mode & FMODE_PWRITE)
 			ret = vfs_writev(fd_file(f), vec, vlen, &pos, flags);
-		fdput(f);
 	}
 
 	if (ret > 0)
-- 
2.39.5


