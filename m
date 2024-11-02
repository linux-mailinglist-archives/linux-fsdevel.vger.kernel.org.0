Return-Path: <linux-fsdevel+bounces-33517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D2D9B9CF3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9750B1F2213D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C879170A0B;
	Sat,  2 Nov 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="voqcZu8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F13149C42;
	Sat,  2 Nov 2024 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524112; cv=none; b=QG5EsmiXir0gLMDOkifgHf/y3g4+A5tgoXnRv+rX7gdHint60YdrX8ZSrskriJK8zXwB+8WztpajBKsQyaULHvrljcfS50W8DjchfaFybkALk968+RyyW2/PiKr+pw894PjlMtopdlSMly/WPgq6x/96KnLGWYEBAazYahskgoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524112; c=relaxed/simple;
	bh=Dh9e7AxHsyyfi545LBsdlV0w/bbRwzLpzS7Yg+Llekc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WO7U4YBZq2MTagbMpuidz7tdcRvgz+O4qWlMucGbghxqgBR+DHyMaghoI6Lyl8wMqM8S3lV+dgpVsu61apCwYMWELfxwdp6AZ/cYGWS20yDFmFlSBionMJgzEVFsyKwqeLOD4nWSzQKiv25A++BKpvgUbCQUnncOSwjb1tu6pko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=voqcZu8e; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jB1bnppaitR7n1LbM8UhVO7eyp11rxvqyeUnmfbn0Us=; b=voqcZu8ezWn0FOkIWksDOlcNZ+
	mso1G+JPkuimvDwTGVR4TxVsa10Qj88bjaRftB1HVGIn197krjQ1WkGd+kdKX/9tTlddK9bNf1/fk
	792d38R7v+Jd95ocqGLrz4hGDZCcdHn0LcJ0UCeOMfcJOafvUTltNRdZMVYvgJ0brjrcaYmkSKaXb
	ZWiip7z4qU6DMcIBZhOTMcSs4rqnuNHlKGeZs9f7jP1iMUeveqg7YJauvS+Zvg++1J6jUU3pethbO
	+qeSqnqqCTKMGSfwxJq4NrtkRMfTQasOuQJ71q4pLl07M4tkymf2+SO0ubtXdKyDcwd2Gx2pEV3E8
	7fXabjFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NA-0000000AHmz-3uTZ;
	Sat, 02 Nov 2024 05:08:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 13/28] privcmd_ioeventfd_assign(): don't open-code eventfd_ctx_fdget()
Date: Sat,  2 Nov 2024 05:08:11 +0000
Message-ID: <20241102050827.2451599-13-viro@zeniv.linux.org.uk>
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

just call it, same as privcmd_ioeventfd_deassign() does...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/xen/privcmd.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 3273cb8c2a66..79070494070d 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1352,7 +1352,6 @@ static int privcmd_ioeventfd_assign(struct privcmd_ioeventfd *ioeventfd)
 	struct privcmd_kernel_ioeventfd *kioeventfd;
 	struct privcmd_kernel_ioreq *kioreq;
 	unsigned long flags;
-	struct fd f;
 	int ret;
 
 	/* Check for range overflow */
@@ -1372,15 +1371,7 @@ static int privcmd_ioeventfd_assign(struct privcmd_ioeventfd *ioeventfd)
 	if (!kioeventfd)
 		return -ENOMEM;
 
-	f = fdget(ioeventfd->event_fd);
-	if (!fd_file(f)) {
-		ret = -EBADF;
-		goto error_kfree;
-	}
-
-	kioeventfd->eventfd = eventfd_ctx_fileget(fd_file(f));
-	fdput(f);
-
+	kioeventfd->eventfd = eventfd_ctx_fdget(ioeventfd->event_fd);
 	if (IS_ERR(kioeventfd->eventfd)) {
 		ret = PTR_ERR(kioeventfd->eventfd);
 		goto error_kfree;
-- 
2.39.5


