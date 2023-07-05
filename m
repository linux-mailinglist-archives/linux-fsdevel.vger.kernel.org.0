Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C57748CFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjGETFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjGETFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:05:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F184A1BCD;
        Wed,  5 Jul 2023 12:03:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D41A361702;
        Wed,  5 Jul 2023 19:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98412C433C9;
        Wed,  5 Jul 2023 19:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583830;
        bh=EkEDsbsq0gEwanNdh7DFtJ1vDCUiiAF7B/nTe8m875k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBxSrlLhwot8ixu9Af7vP4IOcseCDxNSs9rRs5a/63QIOm6XbGKwsC816HQs2kvdp
         UTn+t3q0xhyWI5sau4Hc3lfzaafnm4OLXKZ6uDzLJqXpIrnpZF7W/A60OAIQ+vrGWX
         suV056vSmTk6M/6jGGVzkKsIoJNKvAcGkGArowRrynh0wdT2Sgol80nL2wa5nw2yxR
         bN4k5Co0U/eaXA1O0HkRaxwAMnc4INwMuIrsg2vWN4nF0k4c/p57B7vN6IkWqwPq5J
         CIFXBgU1n8k5YY43S1q/2WJEvoQ30hkc8/KA+66XHDoliieToqzokIVusEHRb1Zp7e
         ps1NxDN/64PyQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/92] befs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:00:52 -0400
Message-ID: <20230705190309.579783-25-jlayton@kernel.org>
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

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/befs/linuxvfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index eee9237386e2..9a16a51fbb88 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -363,7 +363,7 @@ static struct inode *befs_iget(struct super_block *sb, unsigned long ino)
 	inode->i_mtime.tv_sec =
 	    fs64_to_cpu(sb, raw_inode->last_modified_time) >> 16;
 	inode->i_mtime.tv_nsec = 0;   /* lower 16 bits are not a time */
-	inode->i_ctime = inode->i_mtime;
+	inode_set_ctime_to_ts(inode, inode->i_mtime);
 	inode->i_atime = inode->i_mtime;
 
 	befs_ino->i_inode_num = fsrun_to_cpu(sb, raw_inode->inode_num);
-- 
2.41.0

