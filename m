Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9A16B52DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 22:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjCJV2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 16:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjCJV1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:27:52 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F1C13D50;
        Fri, 10 Mar 2023 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VA7GQANYVnARyMnplWzRqBTUEotzK+8D+MrS+L6xGWk=; b=SYPSSuPsfU1Id8eJY7beRwxxKy
        dyYY8mpnRVuhmIth5N53JBf5R6SSA/nwpDgR789CzCo4024lcvhn0S/6WMJOqjRMxLuuIDtw/ow5X
        mobHTNTGiCW+0ESucvxLq7xjZm/tl2fIBXutWkJTr4sKiuR9stLD4Ofua4wXdumF9aJ8DH+8wYy+V
        C/HPCrcsrG6qEfl+k+6fVLw64EEwDgSnXpBriPneC5I+OOMbIaNbfWBK8IkU+57wMIliACnEJs6Jo
        /1Yruu4MEImZXk9+38JL3BLwMSgfa72yV26OEmSFDePC98WihNkqvQEOkfkajmuN1UQW+jzUgkqjK
        vG3DlGTQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pakHG-00FR6M-0h;
        Fri, 10 Mar 2023 21:27:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] cgroup_get_from_fd(): switch to fdget_raw()
Date:   Fri, 10 Mar 2023 21:27:47 +0000
Message-Id: <20230310212748.3679076-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310212748.3679076-1-viro@zeniv.linux.org.uk>
References: <20230310212536.GX3390869@ZenIV>
 <20230310212748.3679076-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/cgroup/cgroup.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 935e8121b21e..4b249f81c693 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6856,14 +6856,12 @@ EXPORT_SYMBOL_GPL(cgroup_get_from_path);
 struct cgroup *cgroup_v1v2_get_from_fd(int fd)
 {
 	struct cgroup *cgrp;
-	struct file *f;
-
-	f = fget_raw(fd);
-	if (!f)
+	struct fd f = fdget_raw(fd);
+	if (!f.file)
 		return ERR_PTR(-EBADF);
 
-	cgrp = cgroup_v1v2_get_from_file(f);
-	fput(f);
+	cgrp = cgroup_v1v2_get_from_file(f.file);
+	fdput(f);
 	return cgrp;
 }
 
-- 
2.30.2

