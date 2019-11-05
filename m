Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2439AF045D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 18:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390402AbfKERvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 12:51:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54539 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbfKERvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:51:11 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iS2yy-00078j-Ji; Tue, 05 Nov 2019 17:51:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: vboxsf: fix dereference of pointer dentry before it is null checked
Date:   Tue,  5 Nov 2019 17:51:08 +0000
Message-Id: <20191105175108.79824-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the pointer dentry is being dereferenced before it is
being null checked.  Fix this by only dereferencing dentry once
we know it is not null.

Addresses-Coverity: ("Dereference before null check")
Fixes: df4028658f9d ("staging: Add VirtualBox guest shared folder (vboxsf) support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/vboxsf/utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vboxsf/utils.c b/drivers/staging/vboxsf/utils.c
index 1870b69c824e..34a49e6f74fc 100644
--- a/drivers/staging/vboxsf/utils.c
+++ b/drivers/staging/vboxsf/utils.c
@@ -174,7 +174,7 @@ int vboxsf_stat_dentry(struct dentry *dentry, struct shfl_fsobjinfo *info)
 
 int vboxsf_inode_revalidate(struct dentry *dentry)
 {
-	struct vboxsf_sbi *sbi = VBOXSF_SBI(dentry->d_sb);
+	struct vboxsf_sbi *sbi;
 	struct vboxsf_inode *sf_i;
 	struct shfl_fsobjinfo info;
 	struct timespec64 prev_mtime;
@@ -187,6 +187,7 @@ int vboxsf_inode_revalidate(struct dentry *dentry)
 	inode = d_inode(dentry);
 	prev_mtime = inode->i_mtime;
 	sf_i = VBOXSF_I(inode);
+	sbi = VBOXSF_SBI(dentry->d_sb);
 	if (!sf_i->force_restat) {
 		if (time_before(jiffies, dentry->d_time + sbi->o.ttl))
 			return 0;
-- 
2.20.1

