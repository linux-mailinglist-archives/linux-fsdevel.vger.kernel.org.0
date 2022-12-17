Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B539264FBFD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 20:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLQTFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 14:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiLQTFS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 14:05:18 -0500
X-Greylist: delayed 425 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Dec 2022 10:59:48 PST
Received: from ms11p00im-qufo17291601.me.com (ms11p00im-qufo17291601.me.com [17.58.38.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D32D13F48
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Dec 2022 10:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671303172;
        bh=tv8Rf5ihdxdQfuJc2Vv4j++4j0iFH7YIU+fu3T81ngo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=QgV90wLcmfY0Xy2YR3+w+PEVMBvX4siVZsOdmLkD4Tnf2bMwuhsZb4b2sOgfrmt2v
         lqiki3e6k6RvIUuWiQAAiDI8vldQXGfIo186pzWehYp7mlzpsRBxLw4CILXE/B0+KW
         DWBKF+Prtz7YS+owlLO7NxhuUWyYh2Rz6Lrt48HahcwGWTzQaTa1fjNrQ/oBp5MqYa
         UApSZC13GYyn8DkMWT4nhgCNDDeVjGcueXIReKyCqbMl+LdbaVUryxH/m25xU5i+J5
         DJkUr+zM/VuyK2dIIFA/DDrFcg0Qh+TQtPJbdtW3vsnTj1IPn1ajOJyoNODWE63quK
         tyj4REyPCB2sw==
Received: from thundercleese.localdomain (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17291601.me.com (Postfix) with ESMTPSA id A8A713A04A7;
        Sat, 17 Dec 2022 18:52:51 +0000 (UTC)
From:   Eric Van Hensbergen <evanhensbergen@icloud.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Subject: [PATCH 5/6] Remove unnecessary superblock flags
Date:   Sat, 17 Dec 2022 18:52:09 +0000
Message-Id: <20221217185210.1431478-6-evanhensbergen@icloud.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221217185210.1431478-1-evanhensbergen@icloud.com>
References: <20221217185210.1431478-1-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RnbgEI1NLLk12Oamr9yrZNdhbhR61zAj
X-Proofpoint-ORIG-GUID: RnbgEI1NLLk12Oamr9yrZNdhbhR61zAj
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212170174
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These flags just add unnecessary extra operations.
When 9p is run without cache, it inherently implements
these options so we don't need them in the superblock
(which ends up sending extraneous fsyncs, etc.).  User
can still request these options on mount, but we don't
need to set them as default.

Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>
---
 fs/9p/vfs_super.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 266c4693e20c..65d96fa94ba2 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -84,9 +84,7 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 		sb->s_bdi->io_pages = v9ses->maxdata >> PAGE_SHIFT;
 	}
 
-	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
-	if (!v9ses->cache)
-		sb->s_flags |= SB_SYNCHRONOUS;
+	sb->s_flags |= SB_ACTIVE;
 
 #ifdef CONFIG_9P_FS_POSIX_ACL
 	if ((v9ses->flags & V9FS_ACL_MASK) == V9FS_POSIX_ACL)
-- 
2.37.2

