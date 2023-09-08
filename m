Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C47E79915B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 23:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbjIHVFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 17:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIHVFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:05:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9C7DC;
        Fri,  8 Sep 2023 14:05:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24F6C433C8;
        Fri,  8 Sep 2023 21:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694207140;
        bh=dxWq3a40k4nq/qHAcdtI8V30AcoMjsEC7R5DUmpbfdg=;
        h=From:Date:Subject:To:Cc:From;
        b=odd96rv24s+evSelU7hMhmYgDjmzjTmM8nYKIIHwlmhvivVRQ9KmHGmt1sj2UtCKg
         Oj01mXLeg+9zD2VIe1S4SeJtxLNbliZeYbh5NY/TejcqmCl+PUGo+9tLoPYglXqrXH
         Xc7Ep9DC2DipuLQ5/RxejOy1KIMH3f7wgjTEnSQRAOYaNz8X51DUQjalGRvAHm0aNB
         uAht53f+BR3FWqbrS4Uf3TTEdPzR1ybemvOyBmpxq54QOTJ6W4Jhfib1HNl+lbtbVn
         kVVj1rROe4kEueEVlOeeok/6MCi9KAa7DnxIbBMB6/QW3mUsgB/EVIiunW5efN/TYB
         eI6omge8uTszA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 08 Sep 2023 17:05:27 -0400
Subject: [PATCH] fs: fix regression querying for ACL on fs's that don't
 support them
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230908-acl-fix-v1-1-1e6b76c8dcc8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJaM+2QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSwML3cTkHN20zApdszSLNAszS2ODNGMjJaDqgqJUoDDYpOjY2loAFB6
 0GlkAAAA=
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dxWq3a40k4nq/qHAcdtI8V30AcoMjsEC7R5DUmpbfdg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk+4yevlsFLk7zQiTjnLAzT41hSIXwyqtHtuLCH
 RFYntk2bTKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPuMngAKCRAADmhBGVaC
 FWZwEACuuHr6UkgTusVlJX2MpCk/15F3oQnuqNe8rulZLY0t9TxM8lFPNain5C8DP46oHzHXp5g
 u/FSgjtfZtPpxsOLAMqPVIPU2JLC3H9mYQBaS0vQVPN/z7xdpnJYES0T2yoitsgfwV0ejY/xfKa
 T/qlYRqBf2EvcS1Wu/Qdm+K1xSkL+A3SQcV+ivJZwpGWmSMkFv6qETAfMx06SkOi/IPM7TmI9pb
 boVfrUfkRi+QboDVYvdAgwNTObF5nhI2urJp8XiJHX4WonQFCNSahshEl4Q/nJzK/JH5WtcyGNZ
 jD29Kw0PSdlb+ta4tGKisgqPKokZ8oqyFsuar2kEdYC7nB/lnye6HHd6p8CHFfFArq3ud9dfpBG
 MynjtLmCpONQUoU6ZGSrNIrD0x7QdVRA3AJJ5juNHtPSHuYlTslnZXVmpFgh886TajYzWeATO7H
 vrz8CvI0iFlHXuHkJEoEzZ/fZ/V5p7OadpZ9M0a0teSkL5F1eKqIBxC9gBB97uB0G657burAJXN
 ATeaLm+d+SeHJFGlF7aVLbDfXVlUGBHdkBtmAiif62IO9+AjVRy2xIYa2a3JVg5k5RwI++7xRO0
 dK6VkZThTTmnU32GDLUez0Pr4TmDWmpEtsRazKf+EAwcI1WJq6riB98XjTIJsVFeNnuBWAPaY8S
 3CEVNB4JhDhlWYw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the not too distant past, the VFS ACL infrastructure would return
-EOPNOTSUPP on filesystems (like NFS) that set SB_POSIXACL but that
don't supply a get_acl or get_inode_acl method. On more recent kernels
this returns -ENODATA, which breaks one method of detecting when ACLs
are supported.

Fix __get_acl to also check whether the inode has a "get_(inode_)?acl"
method and to just return -EOPNOTSUPP if not.

Reported-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This patch is another approach to fixing this issue. I don't care too
much either way which approach we take, but this may fix the problem
for other filesystems too. Should we take a belt and suspenders
approach here and fix it in both places?
---
 fs/posix_acl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index a05fe94970ce..4c7c62040c43 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -130,8 +130,12 @@ static struct posix_acl *__get_acl(struct mnt_idmap *idmap,
 	if (!is_uncached_acl(acl))
 		return acl;
 
-	if (!IS_POSIXACL(inode))
-		return NULL;
+	/*
+	 * NB: checking this after checking for a cached ACL allows tmpfs
+	 * (which doesn't specify a get_acl operation) to work properly.
+	 */
+	if (!IS_POSIXACL(inode) || (!inode->i_op->get_acl && !inode->i_op->get_inode_acl))
+		return ERR_PTR(-EOPNOTSUPP);
 
 	sentinel = uncached_acl_sentinel(current);
 	p = acl_by_type(inode, type);

---
base-commit: a48fa7efaf1161c1c898931fe4c7f0070964233a
change-id: 20230908-acl-fix-6f8f86930f32

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

