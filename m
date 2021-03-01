Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8A3327D5D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 12:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhCALex (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 06:34:53 -0500
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:50710 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbhCALe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:34:26 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Mar 2021 06:34:25 EST
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id 816FC5401C5;
        Mon,  1 Mar 2021 19:26:05 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] fs: Return -EFAULT if copy_to_user() fails
Date:   Mon,  1 Mar 2021 19:26:00 +0800
Message-Id: <1614597960-32681-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSRpKSkJPSR0fGEIfVkpNSk9OQkxCTU5MT01VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MSI6CRw6Tj8XNRBRQzpCPBMp
        DDgwFC9VSlVKTUpPTkJMQk1NSUNOVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKSENJNwY+
X-HM-Tid: 0a77ed89c75fb038kuuu816fc5401c5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The copy_to_user() function returns the number of bytes remaining to be
copied, but we want to return -EFAULT if the copy doesn't complete.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 fs/select.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/select.c b/fs/select.c
index 37aaa83..93cd35b
--- a/fs/select.c
+++ b/fs/select.c
@@ -400,7 +400,7 @@ static inline unsigned long __must_check
 set_fd_set(unsigned long nr, void __user *ufdset, unsigned long *fdset)
 {
 	if (ufdset)
-		return __copy_to_user(ufdset, fdset, FDS_BYTES(nr));
+		return __copy_to_user(ufdset, fdset, FDS_BYTES(nr)) ? -EFAULT : 0;
 	return 0;
 }
 
-- 
2.7.4

