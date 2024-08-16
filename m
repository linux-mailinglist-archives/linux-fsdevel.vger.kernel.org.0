Return-Path: <linux-fsdevel+bounces-26095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C99541B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 08:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED1A1F2311A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 06:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380D278B4C;
	Fri, 16 Aug 2024 06:31:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E9564D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789914; cv=none; b=Y6TNDIBdo/x/tdBornIjQ+4HWYWhPNGyVvFEIEDsUlu4/N96lcwbtu5omhMhDXStXTNWg9ivXeuhOb6/Cijl+xDEGQzNbFnNgzbQlurmIlPaq8x9P6JzZHNZ8dw1yh/aDbKEXt0GUa0IjUTARMjy+4IfPXKY92zqX1JvWIrK+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789914; c=relaxed/simple;
	bh=Hs4xQi2MmRBF0e2n86kXZwddscpS/8221YrW8KeOgcM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MGGrkGxl3kYPPMQVjrqeLwwFQpW39QDpnXYbU9JtSGDeetWXK9RNTMSUyNBgtmn5VTRPT1pDRKD3dcnFSzHk0IuYc857+vlx5X2Qjd5/knYbIBDiwpj5SrSTa/xm6hPsqkNawv21RZTPd7t3sTwCuKRjNb+O1B1piJlOKWOpfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WlXFK5XFPz1T7Gl;
	Fri, 16 Aug 2024 14:31:17 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E7137140138;
	Fri, 16 Aug 2024 14:31:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 16 Aug
 2024 14:31:49 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
CC: <linux-fsdevel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] fs: Use in_group_or_capable() helper to simplify the code
Date: Fri, 16 Aug 2024 14:38:49 +0800
Message-ID: <20240816063849.1989856-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Since in_group_or_capable has been exported, we can use
it to simplify the code when check group and capable.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/posix_acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 3f87297dbfdb..6c66a37522d0 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -715,8 +715,8 @@ int posix_acl_update_mode(struct mnt_idmap *idmap,
 		return error;
 	if (error == 0)
 		*acl = NULL;
-	if (!vfsgid_in_group_p(i_gid_into_vfsgid(idmap, inode)) &&
-	    !capable_wrt_inode_uidgid(idmap, inode, CAP_FSETID))
+	if (!in_group_or_capable(idmap, inode,
+				 i_gid_into_vfsgid(idmap, inode)))
 		mode &= ~S_ISGID;
 	*mode_p = mode;
 	return 0;
-- 
2.34.1


