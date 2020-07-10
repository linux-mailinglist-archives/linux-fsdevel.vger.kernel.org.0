Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1AB21B453
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 13:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgGJL6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 07:58:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55431 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726757AbgGJL6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594382290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WrAUzsslcQ6587N6bpxNIRSuTpr2lTJ8ANwKcgAAxbY=;
        b=J7ik3vDKDwRTf5NEXx3+aFI3lcGl7YDCjrLLsJ6Lu55k0Xu07MLhFn5g+z3Aw8xzNc5sF6
        OL8djkXWdTrvFNDMjbKnsW0J/uw0Hf2YZjmC7h0Q0lbHB31ZfxlMqLk6DENE6OqaFZg0+j
        kpgjKG4aL4GHWLaZS8rkyvCgOLEOTOw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-7UFkL8X4OFC7qMuk69y4Fw-1; Fri, 10 Jul 2020 07:58:09 -0400
X-MC-Unique: 7UFkL8X4OFC7qMuk69y4Fw-1
Received: by mail-ed1-f71.google.com with SMTP id c25so6693839edr.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 04:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WrAUzsslcQ6587N6bpxNIRSuTpr2lTJ8ANwKcgAAxbY=;
        b=j15oIOR4wTtIj5ztaL0teIR0bNPd1TSX24kR32qpzOyVr4wVHZAH7KyIBa721MVUVS
         5DpTy0RswIKF8kjTSVjOBKcRT+r0lG7l8UebUAf2vZth53wx1dwG0JTz+qOjZpuiYukr
         j2rVlUPPn0LKG/xuqss6klpFvtTf7U50CVHaifL5mxgGOsM253ibe0JJWGL5f21s1FN8
         kOTdhhxsYTPkWq1hjwobKVTScX+uF+VLQFmOjmQgttUeqWr5dqMGXMrrpDzck9+uiyf9
         u+reQqzeQUXlPacpCT69Sk1fYxflEzQHxk+OSQ8NYDCs2XUjZhg7iBr6IQ1p3eVQLXeg
         8sOw==
X-Gm-Message-State: AOAM532TgKCSNIh4UqKi9WVDnsk5cN1JxLUU2HtiqWi17DmcMLY6FS6i
        mfbt9pwaJZIw+HzSsux60Tm/gpmisxDWzRtrKuQ+RlyJ6zv/RknXgFn9pWVn+JS5BDCu7axuq3D
        qJUAAI6FhDYfadBYOrC6Rps5qEw==
X-Received: by 2002:a17:906:69d3:: with SMTP id g19mr41788068ejs.402.1594382287934;
        Fri, 10 Jul 2020 04:58:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDuJCnhjKq7P41NLwcaIkbXSfBf3rS02RRzO4bSzyOQBnJMkwuSDs+EhrikFKVkS77vA9vUg==
X-Received: by 2002:a17:906:69d3:: with SMTP id g19mr41788051ejs.402.1594382287748;
        Fri, 10 Jul 2020 04:58:07 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id a8sm3536951ejp.51.2020.07.10.04.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:58:07 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Stefan Priebe <s.priebe@profihost.ag>,
        David Howells <dhowells@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 1/3] fuse: use ->reconfigure() instead of ->remount_fs()
Date:   Fri, 10 Jul 2020 13:58:03 +0200
Message-Id: <20200710115805.4478-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

s_op->remount_fs() is only called from legacy_reconfigure(), which is not
used after being converted to the new API.

Convert to using ->reconfigure().  This restores the previous behavior of
syncing the filesystem and rejecting MS_MANDLOCK on remount.

Fixes: c30da2e981a7 ("fuse: convert to use the new mount API")
Cc: <stable@vger.kernel.org> # v5.4
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/inode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5b4aebf5821f..be39dff57c28 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -121,10 +121,12 @@ static void fuse_evict_inode(struct inode *inode)
 	}
 }
 
-static int fuse_remount_fs(struct super_block *sb, int *flags, char *data)
+static int fuse_reconfigure(struct fs_context *fc)
 {
+	struct super_block *sb = fc->root->d_sb;
+
 	sync_filesystem(sb);
-	if (*flags & SB_MANDLOCK)
+	if (fc->sb_flags & SB_MANDLOCK)
 		return -EINVAL;
 
 	return 0;
@@ -817,7 +819,6 @@ static const struct super_operations fuse_super_operations = {
 	.evict_inode	= fuse_evict_inode,
 	.write_inode	= fuse_write_inode,
 	.drop_inode	= generic_delete_inode,
-	.remount_fs	= fuse_remount_fs,
 	.put_super	= fuse_put_super,
 	.umount_begin	= fuse_umount_begin,
 	.statfs		= fuse_statfs,
@@ -1296,6 +1297,7 @@ static int fuse_get_tree(struct fs_context *fc)
 static const struct fs_context_operations fuse_context_ops = {
 	.free		= fuse_free_fc,
 	.parse_param	= fuse_parse_param,
+	.reconfigure	= fuse_reconfigure,
 	.get_tree	= fuse_get_tree,
 };
 
-- 
2.21.1

