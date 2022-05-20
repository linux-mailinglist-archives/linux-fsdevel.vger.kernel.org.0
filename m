Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3111D52E312
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 05:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbiETDXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 23:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbiETDXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 23:23:23 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D55C11AFC0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 20:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=04ALj0I47W7dDUBtT9vhcc/md8Jaw1rvMJ6LElze67U=; b=dBYAToFDOi+5/UDZI90Y6Xek+1
        0HAfHaQ9QzhOR7A1DQX+7tXe1rNrm4Dv+F+XTrsDM4zjKkx/LHZL30mj2Igi/RwBjwEYy6XHG/+Yp
        KvNPQaiPenqXhM49X2qyDWtxP8aVEeLDUZwjQLJgrd3XxTadBTsnuujOofrDbCp/ZsVc3pMQsCpCK
        cLCC5n7EY6TBo25JdtHP3TsQkAUNxQd4mGcnPLUT2rM3DFEQstkPwDz7qvYAKes8mEGorItKU4uAJ
        NO20Aw75FJ3Jaz73cCZy7mOggIfHHNympGch/yIJkeMFxtxm2KPCUqRhia9r0qYUkfeoEqZ2iNcv1
        F35A1T3g==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrtEW-00GUBg-UO; Fri, 20 May 2022 03:23:21 +0000
Date:   Fri, 20 May 2022 03:23:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH] blob_to_mnt(): kern_unmount() is needed to undo kern_mount()
Message-ID: <YocJqCkNoTaehfYL@zeniv-ca.linux.org.uk>
References: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
 <YocIiPQjR7tuYdkP@zeniv-ca.linux.org.uk>
 <YocI5jIou18bDDuy@zeniv-ca.linux.org.uk>
 <YocJDUARbpklMJgo@zeniv-ca.linux.org.uk>
 <YocJbOh4O/2efVjM@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YocJbOh4O/2efVjM@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

plain mntput() won't do.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/usermode_driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/usermode_driver.c b/kernel/usermode_driver.c
index 9dae1f648713..8303f4c7ca71 100644
--- a/kernel/usermode_driver.c
+++ b/kernel/usermode_driver.c
@@ -28,7 +28,7 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
 
 	file = file_open_root_mnt(mnt, name, O_CREAT | O_WRONLY, 0700);
 	if (IS_ERR(file)) {
-		mntput(mnt);
+		kern_unmount(mnt);
 		return ERR_CAST(file);
 	}
 
@@ -38,7 +38,7 @@ static struct vfsmount *blob_to_mnt(const void *data, size_t len, const char *na
 		if (err >= 0)
 			err = -ENOMEM;
 		filp_close(file, NULL);
-		mntput(mnt);
+		kern_unmount(mnt);
 		return ERR_PTR(err);
 	}
 
-- 
2.30.2

