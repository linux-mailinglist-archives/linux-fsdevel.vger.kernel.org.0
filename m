Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0847819A01A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 22:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbgCaUrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 16:47:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52535 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbgCaUrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:47:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id t8so700922wmi.2;
        Tue, 31 Mar 2020 13:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9pqr4LoLjaDLiZNl5zhVO+6x9Rgi07DZM6v33kTSHwU=;
        b=mkT9qPlSEyyDPDBiySMwbTeFCtCft4P6CbyCSlSZrsnZQ0x7nybYiQd45J2GYRbKYw
         QenF2i43dgS7P64TcUVHmb5sG7UaLyEpD8AcEwLhI2WJkzhV1/MuR4ImiV2/FfOGnCr6
         BLzM8S7t2+EmBSerDbeY/Cp8Lo2plfJcdpd/4rH4K3xSwXTNbOUfITEDiG/6CljjXHu0
         iNIKNrPCki/FiGrWTzswdtOdzMTYostyAJKuo4kxaj9rUvHl+SAuB+R0BJiUKcjBKqiK
         xoKzH5rkuvsV076WRBLpnTbMiLIKBJmBkOyuY/C9wjsHzp1DnrodXKUFrLcCKaB3RZRH
         YQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pqr4LoLjaDLiZNl5zhVO+6x9Rgi07DZM6v33kTSHwU=;
        b=RCZ+cpItRoc17V0vA4ldAOpmvGuAQtrSHbKkPQdifeUfcAnKX9p3yL/mCSJVXdz/vk
         w3GeB7R/vyehL6yQ/kPvg5gyl3nWR+mjJOQkd5wc9e7y81zj7mDkEuELxg6u/ljSY4Qn
         79ppjwvG1pwxWLYsP38XqvafBNPePhX1GactKBgFlk2C5oLjtYtHT712AT1yNg1Cnzq7
         V1QvYSqdl2hq7RaJ9dSBd2HBQr7vomlimANgoIO1WNTLbRlqdMQE4Mgyqgok94foUcG+
         Bk/p6Q0nhoxt+KetgpHvYenXHqSSs8oqNESjVyuyypUKtjp7YdsGSRyP3qLW5aGPWFub
         WI1g==
X-Gm-Message-State: AGi0PuYABpJD59AmIOkq/sZmqiqcdiC8T32cA994u1ktAAH8P4s7zbI/
        ifjLwGaUNsehbJCaTuLizMyGiNu9pQ==
X-Google-Smtp-Source: APiQypKILmhixo4bPDa+CotQ/wKbhVUvuBuivhTflRw7OPJSHU0jvlpRscLBsW37+C+3wmTAqH2mFQ==
X-Received: by 2002:a1c:ba04:: with SMTP id k4mr684690wmf.165.1585687631534;
        Tue, 31 Mar 2020 13:47:11 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id o9sm28335491wrx.48.2020.03.31.13.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:47:11 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure))
Subject: [PATCH 1/7] fs: Add missing annotation for iput_final()
Date:   Tue, 31 Mar 2020 21:46:37 +0100
Message-Id: <20200331204643.11262-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331204643.11262-1-jbi.octave@gmail.com>
References: <0/7>
 <20200331204643.11262-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sparse reports a warning at iput_final()

warning: context imbalance in iput_final() - unexpected unlock

The root cause is the missing annotation at input_final()
Add the missing __releases(&inode->i_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/inode.c b/fs/inode.c
index 3b06c5c59883..6902e39a4298 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1536,6 +1536,7 @@ EXPORT_SYMBOL(generic_delete_inode);
  * shutting down.
  */
 static void iput_final(struct inode *inode)
+	__releases(&inode->i_lock)
 {
 	struct super_block *sb = inode->i_sb;
 	const struct super_operations *op = inode->i_sb->s_op;
-- 
2.24.1

