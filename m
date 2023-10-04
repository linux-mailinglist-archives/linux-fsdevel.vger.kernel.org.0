Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36AA7B8BA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244741AbjJDSzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244777AbjJDSyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BE81BE4;
        Wed,  4 Oct 2023 11:54:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88108C433C8;
        Wed,  4 Oct 2023 18:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445657;
        bh=/UW/4oYqeLROuN+IeHSLI4LxkY5cLiAitabYGolkAO4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TK6uZHH3/dWRky4EpYJAO46sCCpL0usYO2CbmVlrDLQLC09ynkIurYaECv+m8Tefr
         6N/dkkpriT7VMqX2sggy1PLKj4K3mv1yCqsNLWSGgXcd3BrzUP78+KrVk+GDMOoWVO
         hf1SiZqzEAHksI7t4A9I6m1nv2PcuhGXWR/VR+l4L736A34Pa6gRXY0sa1QJnC00BW
         8Icev5qJwx416LmAfl2KOFIthjQv+DcKATTbPJu0H+GXJfIcw4orHOUOJxKW7YcROV
         kCmLDRRZdl+BrNHQGm+gjNJhCKjDMi2NifWIvEgNzdIaj0aTcTwY/kZM7RpTg8PPoh
         c5Cm5j/v5+SaQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/89] cramfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:12 -0400
Message-ID: <20231004185347.80880-25-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
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

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cramfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 2fbf97077ce9..60dbfa0f8805 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -133,8 +133,8 @@ static struct inode *get_cramfs_inode(struct super_block *sb,
 	}
 
 	/* Struct copy intentional */
-	inode->i_mtime = inode->i_atime = inode_set_ctime_to_ts(inode,
-								zerotime);
+	inode_set_mtime_to_ts(inode,
+			      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, zerotime)));
 	/* inode->i_nlink is left 1 - arguably wrong for directories,
 	   but it's the best we can do without reading the directory
 	   contents.  1 yields the right result in GNU find, even
-- 
2.41.0

