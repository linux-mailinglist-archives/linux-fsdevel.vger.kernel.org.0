Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20FB422D17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhJEP5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 11:57:39 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:33702 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233913AbhJEP5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:57:38 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 2CFE31D39;
        Tue,  5 Oct 2021 18:55:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1633449345;
        bh=/gfbbuiOSNq4drucxDzOCK9oky1obIbH1XZM3jxuHik=;
        h=Date:To:CC:From:Subject;
        b=HBH7eNdTjDZv8pLrprVHBehsFzRcgCAIq2knQDb9nYWFPAvAgLDibbWj/nkpT1Xpe
         sHaUwTK+kKe8fYgIZd2xpr1Q0Mtq/oJrV2ZmZwYUIjOYRTkjQuePuGLJO0r5lHoTYC
         TAiXAagdd2F8GTv3fSjXZO3uCW4qyYvaemvHFjj0=
Received: from [192.168.211.181] (192.168.211.181) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 5 Oct 2021 18:55:44 +0300
Message-ID: <bb2782a2-d6af-ef7e-2e35-3b1d87a11ff7@paragon-software.com>
Date:   Tue, 5 Oct 2021 18:55:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kari.argillander@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v2] fs/ntfs3: Keep prealloc for all types of files
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.181]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before we haven't kept prealloc for sparse files because we thought that
it will speed up create / write operations.
It lead to situation, when user reserved some space for sparse file,
filled volume, and wasn't able to write in reserved file.
With this commit we keep prealloc.
Now xfstest generic/274 pass.
Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
v2:
  Expanded commit message.

 fs/ntfs3/attrib.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 8a00fa978f5f..e8c00dda42ad 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -447,11 +447,8 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 again_1:
 	align = sbi->cluster_size;
 
-	if (is_ext) {
+	if (is_ext)
 		align <<= attr_b->nres.c_unit;
-		if (is_attr_sparsed(attr_b))
-			keep_prealloc = false;
-	}
 
 	old_valid = le64_to_cpu(attr_b->nres.valid_size);
 	old_size = le64_to_cpu(attr_b->nres.data_size);
@@ -461,9 +458,6 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	new_alloc = (new_size + align - 1) & ~(u64)(align - 1);
 	new_alen = new_alloc >> cluster_bits;
 
-	if (keep_prealloc && is_ext)
-		keep_prealloc = false;
-
 	if (keep_prealloc && new_size < old_size) {
 		attr_b->nres.data_size = cpu_to_le64(new_size);
 		mi_b->dirty = true;
-- 
2.33.0

