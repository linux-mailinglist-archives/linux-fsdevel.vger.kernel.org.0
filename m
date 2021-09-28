Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE83441B4D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241984AbhI1RTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 13:19:14 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:51627 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233219AbhI1RTN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:19:13 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id C6EFF81FE6;
        Tue, 28 Sep 2021 20:17:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632849451;
        bh=Qv4CDeHYjjOUMFCGMiQN+LeUoFSnLzhnAn/G99wvURI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=dH3nwHDwDKkLkTvb3LixHQgCxrcGSBJolBVu/49HzQwXRb2BOWG2pqJ1Ihlx00Ul5
         hydZQtV/wdT6ULBDaOwhtt8mzGNwX1Anmbb9XvrqmEOCa9i2Ua1zaLxqECP1Ko1gU0
         Rk8F3Y9QgXGaIvKgghhJSJCE9mqpBorQsitGil/0=
Received: from [192.168.211.85] (192.168.211.85) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 28 Sep 2021 20:17:31 +0300
Message-ID: <5ee2a090-1709-5ca0-1e78-8db1f3ded973@paragon-software.com>
Date:   Tue, 28 Sep 2021 20:17:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH v2 1/3] fs/ntfs3: Fix memory leak if fill_super failed
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

Restore fc->s_fs_info to free memory allocated in ntfs_init_fs_context.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 800897777eb0..aff90f70e7bf 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1242,6 +1242,10 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	return 0;
 out:
 	iput(inode);
+
+	/* Restore fc->s_fs_info to free memory allocated in ntfs_init_fs_context. */
+	fc->s_fs_info = sbi;
+
 	return err;
 }
 
-- 
2.33.0


