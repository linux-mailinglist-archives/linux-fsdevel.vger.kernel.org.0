Return-Path: <linux-fsdevel+bounces-21180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC61900337
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871A528387E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7D4194ACA;
	Fri,  7 Jun 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="A/2JORl3";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="HemVv2k0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303D6194A6F;
	Fri,  7 Jun 2024 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762582; cv=none; b=F+SoCXKyE3BlqfbUe+pDqXuTfEC4YMroSattFfAnZiWgc40O0WyikGwfLGY2oBmc4UPa1o1versAiM7RnpgzSwRhZuvu21CjkuRlRTmbtpTIg8vV2sO28qvKvYOTEhS4ZSvAlnZQkUXSsRtOFgKDW+arKna+OYigWkGwCE37aqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762582; c=relaxed/simple;
	bh=+sh2942xg7otXAhEOsOddtY/dsAfg9v0H5F5AxFP6OI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VI4StMzVO5YRFolRMI9z1irvNEiN2FMqRIbUtV/pHp3tDCaE0VHiZAwiPQQn3gnEGoC+SQUXx0Z+G9szHevH5bi4KHnAKJg5PhU+Q5HOqRnd1zaxWFhU8GbuxfE4NZFYtoG7rCraenJRmsUnp5ZN0DU9j/C+tuauf2vJL0GkxCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=A/2JORl3; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=HemVv2k0; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 5392E2117;
	Fri,  7 Jun 2024 12:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762104;
	bh=5ovyOW9zK48E2EPge8I/zbgW83PBsM38/HIRGE3qOL0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=A/2JORl39FcVK4OEEMaucj9YsmfrMeAcUgWPUWnUTJ884uvPjqdB2w/on5LVlgP4A
	 6uda+AcdxRC3YoN2zvRSoM71RIn+bv7iw2gdRWZo9frRNipuFvo8ogxtRpw7Eg265+
	 1G5X4PDzt/r35SvKzxTrY34aV+YH+PocTkC1B7Io=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 3756F195;
	Fri,  7 Jun 2024 12:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762578;
	bh=5ovyOW9zK48E2EPge8I/zbgW83PBsM38/HIRGE3qOL0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HemVv2k0zeMaY109Ljfrfig1KjoWFhUcQW73o6fKzTpoHlR0HRfuBHee8Vdo3a4dU
	 JslCyqtIoAeOfyKG5SOuwBQmRPuIl28TR2HAoWVFM+5nG2sDwGG/nsKKAq1ieDktwu
	 MVlGpKKHTBUCTnmAeKh2S8UmoAtImOhtDJzEh+kk=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:17 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 11/18] fs/ntfs3: Correct undo if ntfs_create_inode failed
Date: Fri, 7 Jun 2024 15:15:41 +0300
Message-ID: <20240607121548.18818-12-almaz.alexandrovich@paragon-software.com>
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

Clusters allocated for Extended Attributes, must be freed
when rolling back inode creation.

Fixes: 82cae269cfa95 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index d43a87a79ff2..c9a2f0ee117e 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1666,7 +1666,9 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	 * The packed size of extended attribute is stored in direntry too.
 	 * 'fname' here points to inside new_de.
 	 */
-	ntfs_save_wsl_perm(inode, &fname->dup.ea_size);
+	err = ntfs_save_wsl_perm(inode, &fname->dup.ea_size);
+	if (err)
+		goto out6;
 
 	/*
 	 * update ea_size in file_name attribute too.
@@ -1710,6 +1712,12 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	goto out2;
 
 out6:
+	attr = ni_find_attr(ni, NULL, NULL, ATTR_EA, NULL, 0, NULL, NULL);
+	if (attr && attr->non_res) {
+		/* Delete ATTR_EA, if non-resident. */
+		attr_set_size(ni, ATTR_EA, NULL, 0, NULL, 0, NULL, false, NULL);
+	}
+
 	if (rp_inserted)
 		ntfs_remove_reparse(sbi, IO_REPARSE_TAG_SYMLINK, &new_de->ref);
 
-- 
2.34.1


