Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEC37B1ADC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjI1LXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjI1LXZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:23:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31CB30E6;
        Thu, 28 Sep 2023 04:05:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93135C4339A;
        Thu, 28 Sep 2023 11:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899153;
        bh=WVJs4r3gn56zBo47yqZI/s5Yoqse5Zyy37O4JYc3re8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LKbza3JZRSUAdtu/GjX1l2se+pcdi6B1agIk6YbWgnEjMfFnb0fBX9Ccw57h/EwVp
         nxPI/qEMicp0DmqTli8iGdhp56iW5KnID9GMhitMPWXAvWLPDrQYJlvfET7eOB6P3n
         RP9bGQ5yVoLBd8Wx1e7q/eFZeI+q4nKR4BrZw4lDt7BZYsp+URE9c3JehU5eRQF+xd
         8GQO3r6ar7/zT8GGJ25AwSdRqDqBqgR5zE8TjkKcOY4A7fzBn9p7dfR6w901Cs0DDF
         ttZVyDpIoLFPfNLUtn/R8wfxpK1ETx0s2faFpFe8ZSCuBUDVJ2+9yCwX9Mj/8oLLrc
         1IKETsFzHXJXA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     selinux@vger.kernel.org
Subject: [PATCH 83/87] security/selinux: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:32 -0400
Message-ID: <20230928110413.33032-82-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 security/selinux/selinuxfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 6fa640263216..6c596ae7fef9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1198,7 +1198,7 @@ static struct inode *sel_make_inode(struct super_block *sb, umode_t mode)
 
 	if (ret) {
 		ret->i_mode = mode;
-		ret->i_atime = ret->i_mtime = inode_set_ctime_current(ret);
+		simple_inode_init_ts(ret);
 	}
 	return ret;
 }
-- 
2.41.0

