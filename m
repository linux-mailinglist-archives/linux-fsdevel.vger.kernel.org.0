Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6B23495F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfFDNuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:50:09 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40268 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbfFDNuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5+eXF3cP/ofa5etol15vHEJqRCC5PTLJ3QqHbQ5ci5w=; b=mpPv+c0ALwKQAycd46qJQ1R68L
        LepmKrnI3XGz9ELRCL5a1/afo6xA5V919Hv13oWeSsPTebopI4ugN6t2PzAkFrIfds5adc80wAFW8
        rBY7yy3iV91wZbPKt7ukHmYZtxcjAJGZKVyLEyNSEnL8jCdr/2ssoVEtOeMkKrjXwGqZxmv3adPNs
        MpRfrn9uAv847Ok5EuweibKAW01uDIvikob6+wx5MFd61t0knl6KmEKn+3k5kGDqy25326P/iNuPu
        wrUvIa23M3sxLogkMBrO9Abh7CX6H9whN6xKL7oUJmqDzunmc/TCxq4p+T2+N22vWa6MDrirUDKZz
        lC7Kdmiw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53120 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9pE-0001bm-SS; Tue, 04 Jun 2019 14:50:04 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9pD-00085C-Ba; Tue, 04 Jun 2019 14:50:03 +0100
In-Reply-To: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
References: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/12] fs/adfs: super: correct superblock flags
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hY9pD-00085C-Ba@rmk-PC.armlinux.org.uk>
Date:   Tue, 04 Jun 2019 14:50:03 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't support atime updates of any kind, and we ought to set the
read-only bit if we are compiled without write support.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 0beaecd7be3b..1e6afc324f61 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -19,6 +19,8 @@
 #include "dir_f.h"
 #include "dir_fplus.h"
 
+#define ADFS_SB_FLAGS SB_NOATIME
+
 #define ADFS_DEFAULT_OWNER_MASK S_IRWXU
 #define ADFS_DEFAULT_OTHER_MASK (S_IRWXG | S_IRWXO)
 
@@ -227,7 +229,7 @@ static int parse_options(struct super_block *sb, char *options)
 static int adfs_remount(struct super_block *sb, int *flags, char *data)
 {
 	sync_filesystem(sb);
-	*flags |= SB_NODIRATIME;
+	*flags |= ADFS_SB_FLAGS;
 	return parse_options(sb, data);
 }
 
@@ -377,7 +379,7 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	struct inode *root;
 	int ret = -EINVAL;
 
-	sb->s_flags |= SB_NODIRATIME;
+	sb->s_flags |= ADFS_SB_FLAGS;
 
 	asb = kzalloc(sizeof(*asb), GFP_KERNEL);
 	if (!asb)
-- 
2.7.4

