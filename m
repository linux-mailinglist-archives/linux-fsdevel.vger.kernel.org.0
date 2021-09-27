Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EF341982D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 17:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhI0Psz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 11:48:55 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:44058 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235267AbhI0Psy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:48:54 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 1D441120;
        Mon, 27 Sep 2021 18:47:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632757635;
        bh=86+A0dlaB3OD0jgafY42oLWvRxOXrVtt6QKEtY6y2OM=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=b5QWAFUNx+bhCqDlYV0zB19EJb4/8auZPpgOJpHSl4rAkM35rpmASoyH+FDYuKa+T
         7UW8NsfY/3bgnx+SSTZBJfowyVnnMquv83FSVScMdyFa2ctS4lEXH2QUTb5xaTerVE
         QiXPfhSFzfuFGn3IU2wxtnx4OzU7J5684K5IHx90=
Received: from [192.168.211.27] (192.168.211.27) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 27 Sep 2021 18:47:14 +0300
Message-ID: <f34b8f25-96c7-16d6-1e1c-6bb6c5342edd@paragon-software.com>
Date:   Mon, 27 Sep 2021 18:47:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH 1/3] fs/ntfs3: Fix memory leak if fill_super failed
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <16cbff75-f705-37cb-ad3f-43d433352f6b@paragon-software.com>
In-Reply-To: <16cbff75-f705-37cb-ad3f-43d433352f6b@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.27]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Restore fc->s_fs_info to free memory allocated in ntfs_init_fs_context.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 800897777eb0..7099d9b1f3aa 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1308,6 +1308,9 @@ int ntfs_discard(struct ntfs_sb_info *sbi, CLST lcn, CLST len)
 	if (err == -EOPNOTSUPP)
 		sbi->flags |= NTFS_FLAGS_NODISCARD;
 
+	/* Restore fc->s_fs_info to free memory allocated in ntfs_init_fs_context. */
+	fc->s_fs_info = sbi;
+
 	return err;
 }
 
-- 
2.33.0


