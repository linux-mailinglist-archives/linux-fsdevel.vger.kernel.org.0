Return-Path: <linux-fsdevel+bounces-21179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10069900335
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA841C23BD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C998A194A63;
	Fri,  7 Jun 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="q6xixpP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC00193096;
	Fri,  7 Jun 2024 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762580; cv=none; b=t7uSqy59I0UcMMkkINsONGf9erbgNKfjB1UWBb6RS/qAuyaDMynwCB/fWX8lKMI/VCRLyvfPO+QWX0ecF1NiGnvbmnLgUSVT+ZAwWnAPO7syHxOowlPVKPX3I3ekR9L+U8+g0UfSFiBaDrvvHRXUT5lOXqeqAlr89P9FIO3h+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762580; c=relaxed/simple;
	bh=3Gx4jk1cpfnv09caCY1DKsrrDbFLhjDAp6lh7M4ByCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GX4WZPlJvg/LjRNY+E4cJyaewlHIkehJMLCTJivfmFteS+6iIM5/zMdVHflR2C8SXM28dUfHGApf58gUCQfRHGeNS3sl8pDJ8WQ7wiGhjqz/r5ur/PhADzPdD+SBhlYn59mdpCJ6VCHaKdesi9Ko+WB5vKauSgvrV/pL2KK6Sas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=q6xixpP0; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id EDD012113;
	Fri,  7 Jun 2024 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762103;
	bh=8u+Q76oxJF1clofIfbRfsd1y6ovFf5s500dJZxmChZs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=q6xixpP0SdxNTM4bdbMIfI8YdQwKzY7DaELnEp2Bjt81IaQgemLNsojm5BVDn8Gdq
	 iUxZgfE04IUbfrwMWgHpNOzs0IuMaFXYQlbG5vcGRwkO26Av8XD2CrXuPBbdTLRawg
	 zoMGgwbGadvLrnmAZDFIHILlWn1iSbVVlxUpL6ag=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:16 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 10/18] fs/ntfs3: One more reason to mark inode bad
Date: Fri, 7 Jun 2024 15:15:40 +0300
Message-ID: <20240607121548.18818-11-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
References: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
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

In addition to returning an error, mark the node as bad.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/frecord.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 0008670939a4..660a7cfba8f6 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1601,8 +1601,10 @@ int ni_delete_all(struct ntfs_inode *ni)
 		asize = le32_to_cpu(attr->size);
 		roff = le16_to_cpu(attr->nres.run_off);
 
-		if (roff > asize)
+		if (roff > asize) {
+			_ntfs_bad_inode(&ni->vfs_inode);
 			return -EINVAL;
+		}
 
 		/* run==1 means unpack and deallocate. */
 		run_unpack_ex(RUN_DEALLOCATE, sbi, ni->mi.rno, svcn, evcn, svcn,
-- 
2.34.1


