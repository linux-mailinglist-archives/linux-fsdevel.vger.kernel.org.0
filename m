Return-Path: <linux-fsdevel+bounces-17465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265438ADDA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 08:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13391F21FF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 06:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467444366;
	Tue, 23 Apr 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="BsQFDVPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452AC24211;
	Tue, 23 Apr 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854715; cv=none; b=F0R4TsgxT1FPJY7j6uCD1JvoDD9rl3kPLJN9a+CxGo01BCWFixycDTbClO8xwBxdK56JQqnwKafoF3/iv7W9pHSRJjCD/cwxbhZwwu2HRnpTNysUwvmk5Vbv7jfCm4Yp0DuUTt2jyxJYnqGfYJ3UJT23STTmeKFqbtTUx4Skzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854715; c=relaxed/simple;
	bh=1iM7oXzE1ltg9hNvhIPQzODPIU5RwsKJZsI0BBrzNYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nf3ewH9rvgTjP9nGbQ9vqn5GD+qIFxWvvX26pJgQVpNl0+Go/a8fPDrubSpcsrBIov8FG/t10mfrYWojX/A9yZfJngh0Nkc+7RSJEtO1O7NpXyjxJ97k6gafYC0fFMS4TeJnhGPKf+w8uv0yEi9rBtJXsvAVVnvui5+adP/UoDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=BsQFDVPS; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id AD8291F9F;
	Tue, 23 Apr 2024 06:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854260;
	bh=MIif7cGFVX2FHQK2yktmsLp80cdQAVR8pZsch5VO5bw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BsQFDVPSbcFoi+a743GvnWSDWS8DkCf8ZJXzlwzcqCiBGz+c7NNbdb8oCmbwQwl8J
	 PEzyemzfXamo/AhGxZzb5hBiQ9HDnkPgatK/QeFCIbTeyRdbJ0xkGTmAPTmAWvH9vG
	 A+Ko+iTLMZj8DXbh168wZluaX0jUhX4Fkf85wIWk=
Received: from ntfs3vm.paragon-software.com (192.168.211.160) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 09:45:12 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 4/9] fs/ntfs3: Check 'folio' pointer for NULL
Date: Tue, 23 Apr 2024 09:44:23 +0300
Message-ID: <20240423064428.8289-5-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423064428.8289-1-almaz.alexandrovich@paragon-software.com>
References: <20240423064428.8289-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

It can be NULL if bmap is called.

Fixes: 82cae269cfa95 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 05f169018c4e..502a527e51cd 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -571,13 +571,18 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 	clear_buffer_uptodate(bh);
 
 	if (is_resident(ni)) {
-		ni_lock(ni);
-		err = attr_data_read_resident(ni, &folio->page);
-		ni_unlock(ni);
-
-		if (!err)
-			set_buffer_uptodate(bh);
+		bh->b_blocknr = RESIDENT_LCN;
 		bh->b_size = block_size;
+		if (!folio) {
+			err = 0;
+		} else {
+			ni_lock(ni);
+			err = attr_data_read_resident(ni, &folio->page);
+			ni_unlock(ni);
+
+			if (!err)
+				set_buffer_uptodate(bh);
+		}
 		return err;
 	}
 
-- 
2.34.1


