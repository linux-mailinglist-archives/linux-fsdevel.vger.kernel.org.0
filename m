Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798014B4073
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 04:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbiBNDm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Feb 2022 22:42:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiBNDm3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:42:29 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924B455BF7;
        Sun, 13 Feb 2022 19:42:22 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJSFp-001dbD-E1; Mon, 14 Feb 2022 03:42:21 +0000
Date:   Mon, 14 Feb 2022 03:42:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clean overflow checks in count_mounts() a bit
Message-ID: <YgnPnbd6Kny5DPx4@zeniv-ca.linux.org.uk>
References: <20220123100448.GA1468@haolee.io>
 <YgnGuy0GJzlqCSRj@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgnGuy0GJzlqCSRj@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 14, 2022 at 03:04:27AM +0000, Al Viro wrote:

> 	I don't believe it's worth the trouble.  Sure, you run that loop
> only once, instead of once per copy.  And if that's more than noise,
> compared to allocating the same mounts we'd been counting, connecting
> them into tree, hashing, etc., I would be *very* surprised.
> 
> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

BTW, speaking of count_mounts(), the wraparound checks there are somewhat
confused: x + y wraparound will lead to both x + y < x and x + y < y - no
need to check both (the value of x + y is either their sum as natural
numbers, in which case there's no wraparound and both checks are false,
or the sum minus 2^32, in which case both checks are true since both x and
y are below 2^32).

IMO more straightforward code would be better here.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index 13d025a9ecf5d..42d4fc21263b2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2069,22 +2069,23 @@ static int invent_group_ids(struct mount *mnt, bool recurse)
 int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
 {
 	unsigned int max = READ_ONCE(sysctl_mount_max);
-	unsigned int mounts = 0, old, pending, sum;
+	unsigned int mounts = 0;
 	struct mount *p;
 
+	if (ns->mounts >= max)
+		return -ENOSPC;
+	max -= ns->mounts;
+	if (ns->pending_mounts >= max)
+		return -ENOSPC;
+	max -= ns->pending_mounts;
+
 	for (p = mnt; p; p = next_mnt(p, mnt))
 		mounts++;
 
-	old = ns->mounts;
-	pending = ns->pending_mounts;
-	sum = old + pending;
-	if ((old > sum) ||
-	    (pending > sum) ||
-	    (max < sum) ||
-	    (mounts > (max - sum)))
+	if (mounts > max)
 		return -ENOSPC;
 
-	ns->pending_mounts = pending + mounts;
+	ns->pending_mounts += mounts;
 	return 0;
 }
 
