Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C597D748D72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjGETK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjGETKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7825A26A0;
        Wed,  5 Jul 2023 12:05:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2533B616F0;
        Wed,  5 Jul 2023 19:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132EAC433C7;
        Wed,  5 Jul 2023 19:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583939;
        bh=fuAcROkTvzWt2oLhwWrBRUVTBdgYfzuMksRnIzfqmIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6fBOQcWDc/pi/H95I+kf1JujNXMjelHZVfb8qt4mTiNkNM6c6jDvFKaihRMDr5AG
         ZbTxTPNng7DHr+2qgsCcMoh1vXTuuBrUh60Kz20uVdmvRFACmim8lw7S/nX74+8Phi
         JVojm6xelMYsFECol+OmTAfJiVC6IOtTOqRg8StKBa2mUapqgcgeyk0OsG0DiJHMxq
         F5iUXroxJyxAh6dglCanl133Fy67F9KKjMrbY9vxv4eHozCZojPMr5mF8u78WGKdru
         zc/SidxREFDoR8sGbx2kwknTcaksqY+qzmc7U7+0UXqNqwFI21TmSKnMuG75Iw5F0i
         uiuomrNVRF2Hw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH v2 86/92] bpf: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:51 -0400
Message-ID: <20230705190309.579783-84-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 kernel/bpf/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 4174f76133df..99d0625b6c82 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -118,9 +118,8 @@ static struct inode *bpf_get_inode(struct super_block *sb,
 		return ERR_PTR(-ENOSPC);
 
 	inode->i_ino = get_next_ino();
-	inode->i_atime = current_time(inode);
+	inode->i_atime = inode_set_ctime_current(inode);
 	inode->i_mtime = inode->i_atime;
-	inode->i_ctime = inode->i_atime;
 
 	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
 
@@ -148,8 +147,7 @@ static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
 	d_instantiate(dentry, inode);
 	dget(dentry);
 
-	dir->i_mtime = current_time(dir);
-	dir->i_ctime = dir->i_mtime;
+	dir->i_mtime = inode_set_ctime_current(dir);
 }
 
 static int bpf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-- 
2.41.0

