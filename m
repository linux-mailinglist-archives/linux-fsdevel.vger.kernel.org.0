Return-Path: <linux-fsdevel+bounces-31231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB0F99353D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5531F24622
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F421DDA1D;
	Mon,  7 Oct 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Drc87Zrl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7A81D6DCE
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323042; cv=none; b=O5FpR4IUxnr9y/HKEEEIySPZR6lfyRaLxm0qvWk7mjL8v3bTxgu8gfKySzClGn8OLJo+BgjpEDtCvDtsveVa6ZEtrX7gHxB9vHIQ/InlnzQPkcOyGf1uKuKeEAKyVOQkqJUDwk3jP4ALFwPiIw8D+RwPoSVuxjYZrkfoiMbesPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323042; c=relaxed/simple;
	bh=jUlabfArDXMWPDuLP8M4S+N4Edx7yGTflbl3JiVATwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYMoTwNPe3NHNCLiTLmdJYDa9T2SuJdiaRNgdz8qyDbq6m/LSnzz0gAns/Vesc6FCKCXFOqE1AXUK4ElTOf1rqUHD+SSXBJNjeAZBfVmNRQRIaBwSFFgAHPnWcfgO/f7uDqRRC3FICUiicuKbfdpvQwc8PfnvL+sMFE1fkrjWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Drc87Zrl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6WgnjBw8sZ5tl+/NlGFdlDvSdpQYO92YOk8Ep7NzYQ8=; b=Drc87ZrlZpcf615uIWofK6DN4b
	YRmw+XAAcf6m6h7iwkS/aYKZZrI/+x9GzmMSn8LOyn3mSyqZeF/9yvmMpgGul0DWv+r6GduovHv57
	v+XItZXvcNCccXyigZyMOjjkmANJW3D2VQnq3QUtjbW4njPb14RVKus1GHMNXOIdyrPl/D4zStdUv
	c9S33V16YUGLPkRG8KDnIadcNLuZZ8dZU6916gNJ6RFxmu+JfdTLBlVfHrKruQXxNdNMPxRs/yiJF
	POH5bNtV8KypsjkgVKuNcclSke/G1yQCYmNY2IMSsoxTNJX5CR4gt+lXABzI7p8IDsE8F0v10HUWE
	e5FkEv2w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxrm3-00000001f3m-3AkD;
	Mon, 07 Oct 2024 17:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH v3 10/11] make __set_open_fd() set cloexec state as well
Date: Mon,  7 Oct 2024 18:43:57 +0100
Message-ID: <20241007174358.396114-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007174358.396114-1-viro@zeniv.linux.org.uk>
References: <20241007173912.GR4017910@ZenIV>
 <20241007174358.396114-1-viro@zeniv.linux.org.uk>
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
index d8fccd4796a9..b63294ed85ec 100644
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
2.39.5


