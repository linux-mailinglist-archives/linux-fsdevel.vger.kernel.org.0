Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7DE41B4D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 19:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242017AbhI1RTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 13:19:51 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:35878 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242008AbhI1RTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:19:51 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id B5F99454;
        Tue, 28 Sep 2021 20:18:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632849489;
        bh=I6dxCXn0jNZZaFv7JKVRXPY3OVFbnaASgRPEVdZRV64=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=tmgfn5XZBuktnx7r+Z2I5Aih9gscWadHYr+f4C7XeJK1kpZrdqTTPL36+R5VPFkZY
         82dXSp3u4M7ELZCpP8E/E9Wc1aenVnm227WzX2iLlV0OZq69N6dI/qOjsjosheaAEY
         sNatroK63X7KjOshvde02fdUDVoeqF6Kd69LVl+Q=
Received: from [192.168.211.85] (192.168.211.85) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 28 Sep 2021 20:18:08 +0300
Message-ID: <228cbe20-87d6-4020-55fb-111d22e2b487@paragon-software.com>
Date:   Tue, 28 Sep 2021 20:18:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH v2 2/3] fs/ntfs3: Reject mount if boot's cluster size < media
 sector size
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kari.argillander@gmail.com>
References: <a7c2e6d3-68a1-25f7-232e-935ae9e5f6c8@paragon-software.com>
In-Reply-To: <a7c2e6d3-68a1-25f7-232e-935ae9e5f6c8@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.85]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we continue to work in this case, then we can corrupt fs.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/super.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index aff90f70e7bf..890c5d9d6d60 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -763,9 +763,20 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	sbi->mft.lbo = mlcn << sbi->cluster_bits;
 	sbi->mft.lbo2 = mlcn2 << sbi->cluster_bits;
 
-	if (sbi->cluster_size < sbi->sector_size)
+	/* Compare boot's cluster and sector. */
+	if (sbi->cluster_size < boot_sector_size)
 		goto out;
 
+	/* Compare boot's cluster and media sector. */
+	if (sbi->cluster_size < sector_size) {
+		/* No way to use ntfs_get_block in this case. */
+		ntfs_err(
+			sb,
+			"Failed to mount 'cause NTFS's cluster size (%u) is less than media sector size (%u)",
+			sbi->cluster_size, sector_size);
+		goto out;
+	}
+
 	sbi->cluster_mask = sbi->cluster_size - 1;
 	sbi->cluster_mask_inv = ~(u64)sbi->cluster_mask;
 	sbi->record_size = record_size = boot->record_size < 0
-- 
2.33.0


