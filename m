Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D117B8BF3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244822AbjJDSyr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244619AbjJDSye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4339D1BD0;
        Wed,  4 Oct 2023 11:54:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDD5C433C9;
        Wed,  4 Oct 2023 18:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445640;
        bh=kZrh+m6BDY/ck3IWsHLCZAJqaOXaS2UN3A122cBdzhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gAhF7P5lMuXWXH49Rpf51O/OLX0M0ZEsgDfjQrpk9W2DK0YUYYoRh/f2aSH+KL6d5
         sgZiX73KgobMg9z/BizZRGIb/g4ShNe7EAbv5CiOoRsKhsfaonx7KRYcPFpD4UN+42
         YWr5DBFHgoC0WwTPHZUvCHFP+IIdtoLMYGuB+JfOdzekgLCmjOyTPjxxUgadDKFXrB
         GpulwzDj85mve/HJCVE+IEVzBDiJJLduRqeCpk0AktG6V11OnymLPp18Z8M2wzZE2S
         UDchCCh5Q4H5W+VYlrxt6ZRID9uJAFYOxagHFZi4vfLBCG36iUNdQeU0FCpydHksbH
         H7O4/nPJ1qP1Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2 13/89] legacy: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:51:58 -0400
Message-ID: <20231004185347.80880-11-jlayton@kernel.org>
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
 drivers/usb/gadget/legacy/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index ce9e31f3d26b..cdc0926100fd 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1969,7 +1969,7 @@ gadgetfs_make_inode (struct super_block *sb,
 		inode->i_mode = mode;
 		inode->i_uid = make_kuid(&init_user_ns, default_uid);
 		inode->i_gid = make_kgid(&init_user_ns, default_gid);
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		inode->i_private = data;
 		inode->i_fop = fops;
 	}
-- 
2.41.0

