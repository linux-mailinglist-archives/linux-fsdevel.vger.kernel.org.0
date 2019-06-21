Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 772CD4EEDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfFUSmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 14:42:23 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:21294 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFUSmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1561142538;
        s=strato-dkim-0002; d=pinc-software.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=STBik00mBqmEMQGHJb7F0XIWyxHIt223mOwbnCAgOAM=;
        b=EUeJuktgXGpH5YC0sSxMDQjHwxVLNllnv1jkrIsiTXIjPCUwf6OHHqe/OCRdPZSWnA
        /vkw910mHak9NHGR6lcqGqI0TVGJUIgLe4ECZ3RNAp+8xE2qX15CHJTyvlLB5fnFMKeZ
        nJugqzrqN1TPEJxVjVTM2SRfJYczz4KsJ79/ReKHA0ZvsuxICSLmnsIjz6/gE77nP9jB
        HnjjHswGGLtWpXunp/KMk069ftLLHf3WaSZ8rZ6Zfmc4Gkp/Nkc0IWSbllu4HVZjkEl9
        TBNls/wF9rwfFy7g1tgLVwC9GiSQKXE319WnIclrOwzoD1LGFex2nbgQJAUGGSlqsSsM
        grYg==
X-RZG-AUTH: ":LXQBeUSIa/ZoedDIRs9YOPxY4/Y41LMYtYgA+S704F0fcsNycI1rqp7htm44FTK51uMij61Yqhw="
X-RZG-CLASS-ID: mo00
Received: from localhost
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id z087d6v5LIgIRbr
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 21 Jun 2019 20:42:18 +0200 (CEST)
From:   =?UTF-8?q?Axel=20D=C3=B6rfler?= <axeld@pinc-software.de>
To:     Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Axel=20D=C3=B6rfler?= <axeld@pinc-software.de>
Subject: [PATCH RESEND] befs: Allow file sizes beyond 2GiB
Date:   Fri, 21 Jun 2019 20:42:08 +0200
Message-Id: <20190621184208.15417-1-axeld@pinc-software.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This just enables LFS support in the VFS. The implementation already
supports large files.

Signed-off-by: Axel Dörfler <axeld@pinc-software.de>
---
 fs/befs/linuxvfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 462d096ff3e9..1d7d91c2e63f 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -891,6 +891,7 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_magic = BEFS_SUPER_MAGIC;
 	/* Set real blocksize of fs */
 	sb_set_blocksize(sb, (ulong) befs_sb->block_size);
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_op = &befs_sops;
 	sb->s_export_op = &befs_export_operations;
 	root = befs_iget(sb, iaddr2blockno(sb, &(befs_sb->root_dir)));
-- 
2.17.1

