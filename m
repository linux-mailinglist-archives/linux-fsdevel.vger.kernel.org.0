Return-Path: <linux-fsdevel+bounces-54748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F68B0297E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 07:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA1497B6A07
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 05:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE6A1FE46D;
	Sat, 12 Jul 2025 05:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vrpDwps7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD66119A;
	Sat, 12 Jul 2025 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752298921; cv=none; b=eFJeo6X9auGFoAqTIZJnUVVxUToxoN58z5QBQvzHMY42RUkR2DzPKOqIMCbD9px2PhUWSsEsfczqmi+ASchNF/neZVDlA88K9rJtuI6pm8R4HE52K1tVRgP08lBcVM9uZnzaM2B3oK4F5hX78ROidpIoDYgY1rxYDOfEWGqypR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752298921; c=relaxed/simple;
	bh=T1c2/dN43JP2OKe8dN1976b0zw3tFRnjDJwCUjAcH3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sHVODgh/8T1DjhS1pkS2wb3eOqh+w4HYlwOe41Ft5c4OBrvqPJttaTQyNAyOC0/6d6g227AX58JNpkFaxgEP79JclCmr3QfIH+4V5KZr+apz3EiQk8Wj6gAb5+9+/cCdNgOVJbsyCOQvC2tE9Fkiga7neeJP/lEZXKzguPKMDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vrpDwps7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DNm/naG8d7qiQh4t0mryk0HQUPzdR9UxT6oCf/8NoDo=; b=vrpDwps7AwP3+pfNxfZ/Lasx18
	8qrhLs3a1BeBHknCsum9s5j09v6GrkP/8/BuPa+kFp4u992Lnt/FpASzVC5kmjmOZACEH+ZdBM5Pq
	alqG6lDrirCwpa6XFRZcWPmuVOoqEgF8r76HWudcrYYgnwJ9m9m3x/j68HOgcK09UZWv16zgS7eFX
	LyjR3eFngOPzhqMm7e+BY/r8f1Yr6HbjFOsdGYBFrcRubTFl3B4FNpCmUm+4TK56NzpeG1AEEXS77
	x25RHoBjWJsptT8YbSDyOoeGIp6KqqlA5ocNhDOx/bxkegwsuLTCXpkwWx/kuV52oMcJWKWwk2yLf
	W3vVlVsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaSzl-00000004pYp-1JCh;
	Sat, 12 Jul 2025 05:41:57 +0000
Date: Sat, 12 Jul 2025 06:41:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: netdev@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH][RFC] don't bother with path_get()/path_put() in
 unix_open_file()
Message-ID: <20250712054157.GZ1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Once unix_sock ->path is set, we are guaranteed that its ->path will remain
unchanged (and pinned) until the socket is closed.  OTOH, dentry_open()
does not modify the path passed to it.

IOW, there's no need to copy unix_sk(sk)->path in unix_open_file() - we
can just pass it to dentry_open() and be done with that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 52b155123985..019ba2609b66 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3191,7 +3191,6 @@ EXPORT_SYMBOL_GPL(unix_outq_len);
 
 static int unix_open_file(struct sock *sk)
 {
-	struct path path;
 	struct file *f;
 	int fd;
 
@@ -3201,27 +3200,20 @@ static int unix_open_file(struct sock *sk)
 	if (!smp_load_acquire(&unix_sk(sk)->addr))
 		return -ENOENT;
 
-	path = unix_sk(sk)->path;
-	if (!path.dentry)
+	if (!unix_sk(sk)->path.dentry)
 		return -ENOENT;
 
-	path_get(&path);
-
 	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0)
-		goto out;
+		return fd;
 
-	f = dentry_open(&path, O_PATH, current_cred());
+	f = dentry_open(&unix_sk(sk)->path, O_PATH, current_cred());
 	if (IS_ERR(f)) {
 		put_unused_fd(fd);
-		fd = PTR_ERR(f);
-		goto out;
+		return PTR_ERR(f);
 	}
 
 	fd_install(fd, f);
-out:
-	path_put(&path);
-
 	return fd;
 }
 

