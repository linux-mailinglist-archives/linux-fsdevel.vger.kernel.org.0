Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1347241CA53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 18:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345965AbhI2QkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 12:40:12 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:54762 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344376AbhI2QkL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:40:11 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 76B81439;
        Wed, 29 Sep 2021 19:38:29 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632933509;
        bh=MOpyRoXmge+JfHU9g9lKQjhfkbKwMhFfVOywlLhqglg=;
        h=Date:To:CC:From:Subject;
        b=NHuYb3m3ZCD9OoE1y2sc/3H5FC9wv6WcXGBNrq3nJaxJEPgzAe2ZjAyp3Gc7TnrN2
         Ke1BXY6cRvhzmUYnhZfxj1zf/DUa3u86m52D+tyWYrhtR9uYZ6Bbw2Sn6vjDeo1CjK
         zNT/Cat4fJMwR2gqxqFKqrAajRuHL5f0w4bAXQLc=
Received: from [192.168.211.131] (192.168.211.131) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 29 Sep 2021 19:38:29 +0300
Message-ID: <e6161f84-fe87-d8b3-6e02-d3811152c0d0@paragon-software.com>
Date:   Wed, 29 Sep 2021 19:38:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v2] fs/ntfs3: Forbid FALLOC_FL_PUNCH_HOLE for normal files
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.131]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FALLOC_FL_PUNCH_HOLE isn't allowed with normal files.
Filesystem must remember info about hole, but for normal file
we can only zero it and forget.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Now xfstests generic/016 generic/021 generic/022 pass.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 5fb3508e5422..43b1451bff53 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -587,8 +587,11 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
                truncate_pagecache(inode, vbo_down);
 
                if (!is_sparsed(ni) && !is_compressed(ni)) {
-                       /* Normal file. */
-                       err = ntfs_zero_range(inode, vbo, end);
+                       /*
+                        * Normal file, can't make hole.
+                        * TODO: Try to find way to save info about hole.
+                        */
+                       err = -EOPNOTSUPP;
                        goto out;
                }
 
-- 
2.33.0

