Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D14752439
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjGMNwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjGMNwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:52:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8831992;
        Thu, 13 Jul 2023 06:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0187F612E6;
        Thu, 13 Jul 2023 13:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3534C433C8;
        Thu, 13 Jul 2023 13:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689256371;
        bh=yQE/06XtN9J0/9x5jyBU+rANpjW1fPpTd29gKkhEkO4=;
        h=From:To:Cc:Subject:Date:From;
        b=mTynh6tFaqDyWig0CZnR9oUbpU1b4pvoLSwLuRSd2dGG8NF7GucdHnkvBfErhpO27
         BMqrS5fa25Y/XKs+tTD3vVjLWCYzR4LsUfJgMZehWtiZuCuVs3pecG8uRujZMAuyl6
         xqh9TE5V+KnJNWKop6hnKA/IqoI55QAYzlRsb+VNG02UNFYUp2j0ADgkH37uc71IEi
         f1wQ6t//knMMsD6Yy7zUh4jhAmMhNIiar4Ge5yH3VhvkdmekfvMYzu8VKjrGDHzI9p
         SRKi/GX4BQGvQuATVDVprXwYxsjqBN5NyCSe3PX1fIL9Zlf4IHRCeDBjYtu3cQ2ANs
         6jr5cHk2W92Iw==
From:   Jeff Layton <jlayton@kernel.org>
To:     brauner@kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: fix timestamp handling on quota inodes
Date:   Thu, 13 Jul 2023 09:52:48 -0400
Message-ID: <20230713135249.153796-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While these aren't generally visible from userland, it's best to be
consistent with timestamp handling. When adjusting the quota, update the
mtime and ctime like we would with a write operation on any other inode,
and avoid updating the atime which should only be done for reads.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/gfs2/quota.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Christian,

Would you mind picking this into the vfs.ctime branch, assuming the GFS2
maintainers ack it? Andreas and I had discussed this privately, and I
think it makes sense as part of that series.

Thanks,
Jeff

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 704192b73605..aa5fd06d47bc 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -871,7 +871,7 @@ static int gfs2_adjust_quota(struct gfs2_inode *ip, loff_t loc,
 		size = loc + sizeof(struct gfs2_quota);
 		if (size > inode->i_size)
 			i_size_write(inode, size);
-		inode->i_mtime = inode->i_atime = current_time(inode);
+		inode->i_mtime = inode_set_ctime_current(inode);
 		mark_inode_dirty(inode);
 		set_bit(QDF_REFRESH, &qd->qd_flags);
 	}
-- 
2.41.0

