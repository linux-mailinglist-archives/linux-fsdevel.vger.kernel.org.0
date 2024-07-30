Return-Path: <linux-fsdevel+bounces-24558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E14FA94074B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD40B22C88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670A0199251;
	Tue, 30 Jul 2024 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX54VVef"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5033198E88;
	Tue, 30 Jul 2024 05:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316511; cv=none; b=hzoHZu9VsuWFQKcuXly3LiPEZBhpoO20cEL3RjG6Y+VtSMYyeS0mwfKcKdiheoiwLX+Gxdhn7UxA9wZ5zs/7eIRQZDl/gQ3hPFmPB0TFc6OUBXe4VFQw4fRrc87+Gt54F6wIv2aVLAYkzPrvo0vDY8yIn+uL6bze/f5NQBnpE9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316511; c=relaxed/simple;
	bh=MQ07H0ZAILProCM9bV2NMnuvM+aBTPLTa+6PE+IhOHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YSrMtnhNH9Maqwswq1BQZErtZvrBG9Dnf4dXtyRLdqlIUXrm7SlGAUiWZg+EkAiNEOuA3o180yfQSBYENIVnimkZy1Js3QSGPhHXkpE2GDmsZdQ3xg6+XtX+8Dv8feqgt1WPFEKxrxWmukmpcU4NzX0cDlhS9tl3cpxvKLeR9Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX54VVef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A55C4AF0A;
	Tue, 30 Jul 2024 05:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316511;
	bh=MQ07H0ZAILProCM9bV2NMnuvM+aBTPLTa+6PE+IhOHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gX54VVef/awpYGC+pMqKT3FjbfzgsklWm+km/zKQZ52Y0PfDbrO3tUmcByZgLpvNy
	 KEH8Gv+n4OgSh3L5r8/WFycq6LrDmUDSI6ZJdMYpe/ionDJMf2J7lI2fF0crnxvusX
	 sB+SvRtmlqoeggSVfTi7dFZnIclgik7TYypzKlKE3zBwsU3PB2+pN8WAX8B9tZOGzk
	 JnOBmPc386FA3iwOKs7z/j5u3O1LwDlPSbpPBCRjKHs+zDXQ/CnxCCw4ldxjimcepY
	 Y7wwHEnV76JtwIqJCp+EmOZWrKWYNnpyzhrt6R64qnISlJ9Y/qZ7wHAM46doxZMrrY
	 EAp6YY+WnbyWg==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 26/39] convert cachestat(2)
Date: Tue, 30 Jul 2024 01:16:12 -0400
Message-Id: <20240730051625.14349-26-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

fdput() can be transposed with copy_to_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/filemap.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0b5cbd644fdd..9ef41935b0a7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4387,31 +4387,25 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
 		struct cachestat_range __user *, cstat_range,
 		struct cachestat __user *, cstat, unsigned int, flags)
 {
-	struct fd f = fdget(fd);
+	CLASS(fd, f)(fd);
 	struct address_space *mapping;
 	struct cachestat_range csr;
 	struct cachestat cs;
 	pgoff_t first_index, last_index;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
 	if (copy_from_user(&csr, cstat_range,
-			sizeof(struct cachestat_range))) {
-		fdput(f);
+			sizeof(struct cachestat_range)))
 		return -EFAULT;
-	}
 
 	/* hugetlbfs is not supported */
-	if (is_file_hugepages(fd_file(f))) {
-		fdput(f);
+	if (is_file_hugepages(fd_file(f)))
 		return -EOPNOTSUPP;
-	}
 
-	if (flags != 0) {
-		fdput(f);
+	if (flags != 0)
 		return -EINVAL;
-	}
 
 	first_index = csr.off >> PAGE_SHIFT;
 	last_index =
@@ -4419,7 +4413,6 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
 	memset(&cs, 0, sizeof(struct cachestat));
 	mapping = fd_file(f)->f_mapping;
 	filemap_cachestat(mapping, first_index, last_index, &cs);
-	fdput(f);
 
 	if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
 		return -EFAULT;
-- 
2.39.2


