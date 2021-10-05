Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2516422E57
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 18:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhJEQuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 12:50:23 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:49357 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236600AbhJEQuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:50:22 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id A5F4681FEE;
        Tue,  5 Oct 2021 19:48:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1633452510;
        bh=Zre4cSfIxDvE43kuIW5Oeh8hW2AAvbtXh8IQ7/+ZDcs=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=UYuie3A7wmuGhbI41tthfPTda1G616JH5ZT6R5rpmokX9evrCztGcEtqNOPcMrN2a
         hZlhVFA0ZVtO4qXxifBW5OGdGbpYQVjUwTRwO94WrNCy0KN+LxFwcftvaTkCImExaO
         4rUG+gweNN+FY5z/PEoNfOYpOf66LTrzxKeXEdS0=
Received: from [192.168.211.181] (192.168.211.181) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 5 Oct 2021 19:48:30 +0300
Message-ID: <0310433c-d9dc-da5b-f642-2ad4298a8918@paragon-software.com>
Date:   Tue, 5 Oct 2021 19:48:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: [PATCH 5/5] fs/ntfs3: Refactor ntfs_read_mft
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

[PATCH 5/5] fs/ntfs3: Refactor ntfs_read_mft

Don't save size of attribute reparse point as size of symlink.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index bdebbbd53e76..859951d785cb 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -222,9 +222,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		if (!attr->non_res) {
 			ni->i_valid = inode->i_size = rsize;
 			inode_set_bytes(inode, rsize);
-			t32 = asize;
-		} else {
-			t32 = le16_to_cpu(attr->nres.run_off);
 		}
 
 		mode = S_IFREG | (0777 & sbi->options->fs_fmask_inv);
@@ -313,17 +310,14 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		rp_fa = ni_parse_reparse(ni, attr, &rp);
 		switch (rp_fa) {
 		case REPARSE_LINK:
-			if (!attr->non_res) {
-				inode->i_size = rsize;
-				inode_set_bytes(inode, rsize);
-				t32 = asize;
-			} else {
-				inode->i_size =
-					le64_to_cpu(attr->nres.data_size);
-				t32 = le16_to_cpu(attr->nres.run_off);
-			}
+			/*
+			 * Normal symlink.
+			 * Assume one unicode symbol == one utf8.
+			 */
+			inode->i_size = le16_to_cpu(rp.SymbolicLinkReparseBuffer
+							    .PrintNameLength) /
+					sizeof(u16);
 
-			/* Looks like normal symlink. */
 			ni->i_valid = inode->i_size;
 
 			/* Clear directory bit. */
@@ -420,7 +414,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		ni->std_fa &= ~FILE_ATTRIBUTE_DIRECTORY;
 		inode->i_op = &ntfs_link_inode_operations;
 		inode->i_fop = NULL;
-		inode_nohighmem(inode); // ??
+		inode_nohighmem(inode);
 	} else if (S_ISREG(mode)) {
 		ni->std_fa &= ~FILE_ATTRIBUTE_DIRECTORY;
 		inode->i_op = &ntfs_file_inode_operations;
-- 
2.33.0


