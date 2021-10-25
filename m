Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA31439C31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 18:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhJYRBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 13:01:23 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:49452 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231171AbhJYRBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:01:23 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 510311D18;
        Mon, 25 Oct 2021 19:58:58 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1635181138;
        bh=jnW3fikU6EVWEd3OzbjOZKH3DPUoCU9GhULna6KOPoU=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=iF3XqL1V6LY9qjku8E4icQB9diWSj4nAwon3Knb3fIB/WRCb4YKrWOdPZKhL+KSnP
         xuNzq2SqtoU5T6rSHWRAUCjPjSouLa52cLCjbS7eVjIkkrPkloGoegFyV63M/1ME/a
         Ye1+lG3GsXm8LltelpG9TpCqlvE4nuinDtZgoems=
Received: from [192.168.211.155] (192.168.211.155) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 25 Oct 2021 19:58:57 +0300
Message-ID: <e206b37a-9d71-67d5-5144-58033036a744@paragon-software.com>
Date:   Mon, 25 Oct 2021 19:58:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: [PATCH 2/4] fs/ntfs3: Fix fiemap + fix shrink file size (to remove
 preallocated space)
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
In-Reply-To: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.155]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Two problems:
1. ntfs3_setattr can't truncate preallocated space;
2. if allocated fragment "cross" valid size, then fragment splits into two parts:
- normal part;
- unwritten part (here we must return FIEMAP_EXTENT_LAST).
Before this commit we returned FIEMAP_EXTENT_LAST for whole fragment.
Fixes xfstest generic/092
Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c    |  2 +-
 fs/ntfs3/frecord.c | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 43b1451bff53..5418e5ba64b3 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -761,7 +761,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		}
 		inode_dio_wait(inode);
 
-		if (attr->ia_size < oldsize)
+		if (attr->ia_size <= oldsize)
 			err = ntfs_truncate(inode, attr->ia_size);
 		else if (attr->ia_size > oldsize)
 			err = ntfs_extend(inode, attr->ia_size, 0, NULL);
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 6f47a9c17f89..18842998c8fa 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1964,10 +1964,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 
 		vcn += clen;
 
-		if (vbo + bytes >= end) {
+		if (vbo + bytes >= end)
 			bytes = end - vbo;
-			flags |= FIEMAP_EXTENT_LAST;
-		}
 
 		if (vbo + bytes <= valid) {
 			;
@@ -1977,6 +1975,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 			/* vbo < valid && valid < vbo + bytes */
 			u64 dlen = valid - vbo;
 
+			if (vbo + dlen >= end)
+				flags |= FIEMAP_EXTENT_LAST;
+
 			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
 						      flags);
 			if (err < 0)
@@ -1995,6 +1996,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 			flags |= FIEMAP_EXTENT_UNWRITTEN;
 		}
 
+		if (vbo + bytes >= end)
+			flags |= FIEMAP_EXTENT_LAST;
+
 		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
 		if (err < 0)
 			break;
-- 
2.33.0


