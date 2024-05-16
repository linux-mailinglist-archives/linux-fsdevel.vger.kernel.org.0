Return-Path: <linux-fsdevel+bounces-19578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D068C75E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 14:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929B928532B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 12:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C302145FE7;
	Thu, 16 May 2024 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="AO3xszRr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0F26AD0;
	Thu, 16 May 2024 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862058; cv=none; b=uHQvI+U67U1H8gIA/2z3OB1hBc2DZ0sQfRCmIXSjTWrhozC7E6DKajglVw2htcRlPsL6BNXOHQSAe2xQOKHTr4cfNbf4Yu37K700vemOIaXStp9mouWaHNMAX1ZKTvyY/FkXRRven2wcd3hP+vhrq7yvF3gG5VKO7byZpGt9NxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862058; c=relaxed/simple;
	bh=F9eh9r9r/qZd5F49xlN6/fKmFGQdqoJZjiCsTZHQf9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPQAZS+J1OV/4leNlmXpsO6oQ+R82rQv6fiLTmiPgBxjmaYI+RDEJz+q8y6CsXm+uX3/Y6t5tVDmAMieorAGcxxrn4rLkX9wobjXfz3L4zEVVr6DXfjMpsWAs6A9n7k+42bwW9tEfihPNi0W4V6vYP0Sw9o3WgYLm5iSd/oxHWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=AO3xszRr; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id CD4571F86;
	Thu, 16 May 2024 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1715861591;
	bh=138ZE/h5TNiCrz7tQ1X/Ht+h28eqyF8ISqvZy/ijiIs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AO3xszRrpn//tE5QGQZfFt7paqIrVePppoqB/v1/Gr88dJxUB2Uq0VurNp+bgqC5s
	 9XIrJFaIdNLPuB3dAzagT35Gzq80l9M/SGozoj5pxWzi+ChCFTDYZEkPSFxbce8hy4
	 o6s3X2ftvhxYQa/1bYZVTdb+1sl3lOwtt3HvbELA=
Received: from ntfs3vm.paragon-software.com (192.168.211.154) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 16 May 2024 15:20:54 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] fs/ntfs3: Break dir enumeration if directory contents error
Date: Thu, 16 May 2024 15:20:41 +0300
Message-ID: <20240516122041.5759-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423144155.10219-2-almaz.alexandrovich@paragon-software.com>
References:
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

If we somehow attempt to read beyond the directory size, an error
is supposed to be returned.

However, in some cases, read requests do not stop and instead enter
into a loop.

To avoid this, we set the position in the directory to the end.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: stable@vger.kernel.org
---
 fs/ntfs3/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 5cf3d9decf64..45e556fd7c54 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -475,6 +475,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 		vbo = (u64)bit << index_bits;
 		if (vbo >= i_size) {
 			ntfs_inode_err(dir, "Looks like your dir is corrupt");
+			ctx->pos = eod;
 			err = -EINVAL;
 			goto out;
 		}
-- 
2.34.1


