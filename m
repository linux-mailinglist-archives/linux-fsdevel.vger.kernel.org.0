Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C589B650592
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 00:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiLRXYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 18:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiLRXXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 18:23:38 -0500
Received: from ms11p00im-qufo17281301.me.com (ms11p00im-qufo17281301.me.com [17.58.38.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005BEBCB1
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Dec 2022 15:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671405812;
        bh=tv8Rf5ihdxdQfuJc2Vv4j++4j0iFH7YIU+fu3T81ngo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=C7X037N4cwx+DvGSoNyqz7QLRx54rrfsS1EOHzLgaisYXtqvxkxYAXAX4KaXetvYE
         oQGiturQ/YLy1Sa/2UcE49SzJsbMURzcvRXk/M7rxBDiJed+iVFBxr7oKucVh/6YoO
         TJhmGsTWeHj0coYN/dwWPImceld7aW2J2Npsx9xQwvj7ts/pqB6AO7eXqYxkK0S4gT
         Yp1XnswpIY1twAc2iNWkzkBDwsyWsD55HhSDbc1z1/0q+CF8Cs9VqI87E9aQ5sH33h
         gE3diBA3lX5MxCj8MV6j9/VLhNSp0cAAjJUNqi1HZrLtjt7aWG+De9L57Qs8R+C9Jm
         FNhjBz6a8cIYA==
Received: from thundercleese.localdomain (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17281301.me.com (Postfix) with ESMTPSA id C3555CC036F;
        Sun, 18 Dec 2022 23:23:31 +0000 (UTC)
From:   Eric Van Hensbergen <evanhensbergen@icloud.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Subject: [PATCH v2 04/10] Remove unnecessary superblock flags
Date:   Sun, 18 Dec 2022 23:22:15 +0000
Message-Id: <20221218232217.1713283-5-evanhensbergen@icloud.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221218232217.1713283-1-evanhensbergen@icloud.com>
References: <20221217183142.1425132-1-evanhensbergen@icloud.com>
 <20221218232217.1713283-1-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lNZgeoIIXyB6IsnYJRUa4owkNnYAVGuH
X-Proofpoint-GUID: lNZgeoIIXyB6IsnYJRUa4owkNnYAVGuH
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212180222
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

