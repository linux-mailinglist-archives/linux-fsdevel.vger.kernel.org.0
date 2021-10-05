Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E921422E50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 18:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhJEQtp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 12:49:45 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:49202 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236402AbhJEQto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:49:44 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id B382D81FEE;
        Tue,  5 Oct 2021 19:47:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1633452472;
        bh=quBU1mR1RrqkwyVnquG48EtBwZjzQ1thh2lG+82YiH0=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=XpJ7aZ2WLz9rvu4Ut+a7ng6nhJ26TDt2nosis2qux4cZJh5BN0JKC94JrVNsbe1th
         ypJRC0qH9CTqLqlYBDUc5l1YoQ8ylR8LWGOJ/QslkddNs45ZD6y0hN2/II2pFX0mhl
         DZLRsoiiwcbCCJBm52PDbRYIi9GF2bvRaL30ZGlg=
Received: from [192.168.211.181] (192.168.211.181) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 5 Oct 2021 19:47:52 +0300
Message-ID: <2dc232a1-effd-0c06-6b6a-7e4019bb9ace@paragon-software.com>
Date:   Tue, 5 Oct 2021 19:47:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: [PATCH 3/5] fs/ntfs3: Refactor ntfs_create_inode
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <98a166e4-f894-8bff-9479-05ef5435f1ed@paragon-software.com>
In-Reply-To: <98a166e4-f894-8bff-9479-05ef5435f1ed@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.181]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Set size for symlink, so we don't need to calculate it on the fly.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index d618b0573533..bdebbbd53e76 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1488,7 +1488,10 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		asize = ALIGN(SIZEOF_RESIDENT + nsize, 8);
 		t16 = PtrOffset(rec, attr);
 
-		/* 0x78 - the size of EA + EAINFO to store WSL */
+		/*
+		 * Below function 'ntfs_save_wsl_perm' requires 0x78 bytes.
+		 * It is good idea to keep extened attributes resident.
+		 */
 		if (asize + t16 + 0x78 + 8 > sbi->record_size) {
 			CLST alen;
 			CLST clst = bytes_to_cluster(sbi, nsize);
@@ -1523,14 +1526,14 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 			}
 
 			asize = SIZEOF_NONRESIDENT + ALIGN(err, 8);
-			inode->i_size = nsize;
 		} else {
 			attr->res.data_off = SIZEOF_RESIDENT_LE;
 			attr->res.data_size = cpu_to_le32(nsize);
 			memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), rp, nsize);
-			inode->i_size = nsize;
 			nsize = 0;
 		}
+		/* Size of symlink equals the length of input string. */
+		inode->i_size = size;
 
 		attr->size = cpu_to_le32(asize);
 
@@ -1567,6 +1570,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		inode->i_op = &ntfs_link_inode_operations;
 		inode->i_fop = NULL;
 		inode->i_mapping->a_ops = &ntfs_aops;
+		inode->i_size = size;
+		inode_nohighmem(inode);
 	} else if (S_ISREG(mode)) {
 		inode->i_op = &ntfs_file_inode_operations;
 		inode->i_fop = &ntfs_file_operations;
-- 
2.33.0


