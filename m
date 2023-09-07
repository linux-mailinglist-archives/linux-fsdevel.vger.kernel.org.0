Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1857977D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjIGQf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbjIGQf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:35:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EA5E57;
        Thu,  7 Sep 2023 09:34:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724F9C433CB;
        Thu,  7 Sep 2023 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694104440;
        bh=JP9tUiLZ6T/k5I6nBBltrDdOGnjoSsJgaiX+JXKr3so=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hdFbPPEzdSggibPtiqud6tUTPGMrh4MM86UWNxl9U3J28kRJoe+NUIQq+qzv2mje6
         Ja2aq6qq2GkG+BDPQWzl2bIZr2AYMmYYX0dvu9txwAR4+BmCRL6iQAy+l5BS2KHf9R
         L7gsz0OgS9poH0dwdoqLJSmHoBhTg83wfdN8XiSGVTxJwtQqvmVnNieX3WtGq7Qxi7
         FCTHt945til2Bt8OkSEcyzDaickDMZjoM49bzDucTwOY4Iex0VDRJpj99XZB9yMrvc
         7HL/KThu0iddy0hyBBpdZIX105Oq1xfP4aj41OqLFYN4/CHe1Y3crJbtWHCWTcUgVc
         WvJQz1IJXrm3A==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 07 Sep 2023 12:33:47 -0400
Subject: [PATCH 1/2] fs: initialize inode->__i_ctime to the epoch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-ctime-fixes-v1-1-3b74c970d934@kernel.org>
References: <20230907-ctime-fixes-v1-0-3b74c970d934@kernel.org>
In-Reply-To: <20230907-ctime-fixes-v1-0-3b74c970d934@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        kernel test robot <oliver.sang@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JP9tUiLZ6T/k5I6nBBltrDdOGnjoSsJgaiX+JXKr3so=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk+ft2F+0r47Otgg6Kb6XEIaO9dJBYAFU8gjygE
 8uEhYSQQs2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPn7dgAKCRAADmhBGVaC
 Fc5OD/0bSZpmszFw2mR0jS9vvjyJK3F4b0SARjnyo1q9za9QbR3U8c8lrWzVlySgIRm6ISqeg+C
 irV1RBOgwNkJRO3/EnwPLcA0K8UAN1VzTC2pn9M7qy6uaxpRlBsFN67vJcdj6I+lmO2QWeTtkkf
 lMZqAWOh2lR7jc7LqoFT7/Q0hLd0mWFiqtsw2SsSUNj7kIJ8O/QRbpXEfdwPS2Kp4vXtxBFZ34s
 uyVJFb9N2ZMnDUJiP6cHCnJ8zkAd/ggrB3G5Ea/ydtkv94vSMnJdmr2JYmnUp4QyrNG0qSID0YH
 XYiQZtdNX8+RGKgBqo4yvR2jrzy8nYAdtXJfejw++Yg22v9gtG26j2eXD9TZWFrYg9w3iPns1mz
 WRGVVRFZTlfDxJnZggpAYC/S1kCq9xgc4+gFVwmJYfELyIkG74thIdPu8+RSFGQIfTzarjCCytX
 LoO0DjJMuDA7fcIq7CHGvrn6XLG7AFr1K13ECVagnzBxBXalayHS+ynyi6Al8lW+JjwnIwwd0d8
 DbnQCw/H+jM1pllv2qM00QHrq8zwnNekLI/jcZ9OojuPzfxmBby3hA+imSR8zeZdfwRasO7RNZC
 twEjfkwQ5XzhrFa1e/DlzOrJC2JW/JAqjeXKtqoLrQ0YUIqE1KyW0qN8Aeb5BvS/kH42jezqvTp
 kG2YAXIFgW/nmJw==
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

With the advent of multigrain timestamps, we use inode_set_ctime_current
to set the ctime, which can skip updating if the existing ctime appears
to be in the future. Because we don't initialize this field at
allocation time, that could prevent the ctime from being initialized
properly when the inode is instantiated.

Always initialize the ctime field to the epoch so that the filesystem
can set the timestamps properly later.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202309071017.a64aca5e-oliver.sang@intel.com
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 35fd688168c5..54237f4242ff 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -168,6 +168,8 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_fop = &no_open_fops;
 	inode->i_ino = 0;
 	inode->__i_nlink = 1;
+	inode->__i_ctime.tv_sec = 0;
+	inode->__i_ctime.tv_nsec = 0;
 	inode->i_opflags = 0;
 	if (sb->s_xattr)
 		inode->i_opflags |= IOP_XATTR;

-- 
2.41.0

