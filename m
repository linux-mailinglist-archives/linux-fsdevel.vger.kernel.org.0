Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABA378AEC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjH1L1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjH1L05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FAAE7
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 04:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9141163EFE
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 11:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23261C433CA;
        Mon, 28 Aug 2023 11:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693222013;
        bh=6HqMh6WW1m/5g0qRrdiQOhhzc/BJB/K8t5YbewNQ5Wo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PVmgtM7yeCULIt8L7Fbal+6K283uWN4YGQ5dvQYhguolgreQGbPh9MRfMMRdK7efF
         S7++0Kxh+9xZiSafRarzWmDx5DuOZKFGdxODt0JZpaJumJZcOAcgyyQoSOAuchqvqx
         Ecaae+O9w1sKIJXF0vOo6RH1cZpn1bcJG6fR/plys1vc/Oo3EH3YrB34KCp3WJJiPs
         gml2VlSGBjwvZau0gnp6w9B0vl92mgrg+JURpGf/urAyi5ikWmE6TNJUqLAFv1+16Q
         FM4D9UNiPu9dN+4lgaBM1bkD56mi7SYRfYwosFmuahbuYh5V06nucwY0zIL3kWxyBn
         Ug2AW/MG1vTfQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 28 Aug 2023 13:26:23 +0200
Subject: [PATCH 1/2] super: move lockdep assert
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-vfs-super-fixes-v1-1-b37a4a04a88f@kernel.org>
References: <20230828-vfs-super-fixes-v1-0-b37a4a04a88f@kernel.org>
In-Reply-To: <20230828-vfs-super-fixes-v1-0-b37a4a04a88f@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=670; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6HqMh6WW1m/5g0qRrdiQOhhzc/BJB/K8t5YbewNQ5Wo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS8aanadZSd22nTi90/p9W4+Halbnl1Sc+57OEzrdX+S42O
 zVj8r6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAifxYwMlw69Sr7Wph4nUPQyXWxv3
 sPeLp1P2hP7k3cHJW8dtU71nKGf7Z19ya6bpfez+u43WyKBAPH8tCmCRkCvD96Izd+DJ7pyAkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix braino and move the lockdep assertion after put_super() otherwise we
risk a use-after-free.

Fixes: 2c18a63b760a ("super: wait until we passed kill super")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index ef87103e2a51..779247eb219c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -570,8 +570,8 @@ static bool grab_super_dead(struct super_block *sb)
 		return true;
 	}
 	wait_var_event(&sb->s_flags, wait_dead(sb));
-	put_super(sb);
 	lockdep_assert_not_held(&sb->s_umount);
+	put_super(sb);
 	return false;
 }
 

-- 
2.34.1

