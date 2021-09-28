Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C838941B519
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 19:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbhI1R1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 13:27:41 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:53587 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229869AbhI1R1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:27:41 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 70A3C821A0;
        Tue, 28 Sep 2021 20:26:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632849960;
        bh=qvcqL2FG70khkZ51nwyvBDfwfec88Co6gUQWcIUcQ84=;
        h=Date:To:CC:From:Subject;
        b=RocjXS3sXc9QhKnzyvnkqougWUjdqK0HBXA12+MtidnZ+5ZluG+suzly50YZMmXVa
         uINnhryhIqCsN7nio8NiPJ0rvtx7/hL3jokl5Rki+iLcF8t/BAuHTOkfqxTQU145kp
         yyVKCxoTSkxRZ7H3Gef23Kx4igxHQWQTOecfyqZk=
Received: from [192.168.211.85] (192.168.211.85) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 28 Sep 2021 20:25:59 +0300
Message-ID: <fad6f129-c53f-d751-be43-c403b1031449@paragon-software.com>
Date:   Tue, 28 Sep 2021 20:25:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Forbid FALLOC_FL_PUNCH_HOLE for normal files
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.85]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FALLOC_FL_PUNCH_HOLE isn't allowed with normal files.
Fixes xfstest generic/016 021 022

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 5fb3508e5422..02ca665baa5f 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -587,8 +587,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		truncate_pagecache(inode, vbo_down);
 
 		if (!is_sparsed(ni) && !is_compressed(ni)) {
-			/* Normal file. */
-			err = ntfs_zero_range(inode, vbo, end);
+			/* Normal file, can't make hole. */
+			err = -EOPNOTSUPP;
 			goto out;
 		}
 
-- 
2.33.0

