Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A15631F910
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 13:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhBSMJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 07:09:40 -0500
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:34102 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBSMJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:09:32 -0500
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Feb 2021 07:09:30 EST
Received: from SZ-11126892.vivo.xyz (unknown [58.250.176.228])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id C4257801C1;
        Fri, 19 Feb 2021 20:01:58 +0800 (CST)
From:   Fengnan Chang <changfengnan@vivo.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     Fengnan Chang <changfengnan@vivo.com>
Subject: [PATCH] fs: use sb_end_write instend of __sb_end_write
Date:   Fri, 19 Feb 2021 20:01:49 +0800
Message-Id: <20210219120149.1056-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.29.2.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTEMYTENJHRhLHhhOVkpNSkhMSE1KSkJLSkJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjI6Kww5ED8QAxoUOQ4WLEo4
        NQ4aCj9VSlVKTUpITEhNSkpCSEhPVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOS1VKTE1VSUlDWVdZCAFZQUpIT0s3Bg++
X-HM-Tid: 0a77ba2b0a79b037kuuuc4257801c1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__sb_end_write is an internal function, use sb_end_write instead of __sb_end_write.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c17..6b2e6f9035a5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2784,7 +2784,7 @@ static inline void file_end_write(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return;
-	__sb_end_write(file_inode(file)->i_sb, SB_FREEZE_WRITE);
+	sb_end_write(file_inode(file)->i_sb);
 }
 
 /*
-- 
2.29.0

