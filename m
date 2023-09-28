Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9367B1ABF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjI1LWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjI1LWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:22:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C513730C2;
        Thu, 28 Sep 2023 04:05:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAB7C433C9;
        Thu, 28 Sep 2023 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899148;
        bh=/OzpYTerhvIxS1I7NYNGCj7AfHI9vs2n0+hMzd5zjnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DuP/wv+atLxYolVz3TsVy7tiJ9223Z4WvylhKVREmBxsCU+CN1xVxwsq/2PSJlKEj
         0SeFCWDbJDEV2ld8iYUItZxaNPQKwnCASz+Napuig4CEsneZ1BjStWwJ4HAb+OA7cy
         SC9iG6X9UH80RRDJ1thj83wDn1k8f+8TcsKMLv9fjOR20LSA6H5T9oflMf7xc2GvJF
         O+eaXZLTN+H3mhRL9ttNl/zo0SzNSOVAPN7PO6IE8z90ITg/kKteuIEqbh6j7HpWoT
         JbjgE6gSfyISnBqy3vYQBrzvpMobxvgl/MqrGENhf1ZBiEdRbysBwAoi7vgbpwg+Lw
         0YxsoKatJ28nA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
Subject: [PATCH 79/87] kernel/bpf: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:28 -0400
Message-ID: <20230928110413.33032-78-jlayton@kernel.org>
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
 kernel/bpf/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 99d0625b6c82..1aafb2ff2e95 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -118,8 +118,7 @@ static struct inode *bpf_get_inode(struct super_block *sb,
 		return ERR_PTR(-ENOSPC);
 
 	inode->i_ino = get_next_ino();
-	inode->i_atime = inode_set_ctime_current(inode);
-	inode->i_mtime = inode->i_atime;
+	simple_inode_init_ts(inode);
 
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 
@@ -147,7 +146,7 @@ static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
 	d_instantiate(dentry, inode);
 	dget(dentry);
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 }
 
 static int bpf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-- 
2.41.0

