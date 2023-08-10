Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5BC77794A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 15:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjHJNMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 09:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjHJNMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE76191;
        Thu, 10 Aug 2023 06:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84AE062EE1;
        Thu, 10 Aug 2023 13:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5727DC433CA;
        Thu, 10 Aug 2023 13:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691673131;
        bh=sWnTCUjG/8VJ8vbCcrMecGrqt9k5P6DlV83pYz2Oy94=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=N7x/taN4/Vz2LHtz89xLrAuRlFkXnRDYaEWTg2eYgLJhwmJFX59yXTxQdOfAI0ONd
         1hM/Q9E+YZMn70nTReoZGbro31vQGQ4oUhypoXrzcDG6BRx7jKUEHarZ6rFw2IDScy
         UkvioLq7puUHg6E2jZADC3CR/XYkbaxeVzSRNfKN2EGWeLLrm+87sZ+8uo/8Ni8lqB
         USzP1VZIbV/0soeWEA70+SI+01eJ10GsG7rRXvLkpDLmeFmxoYFTxTTBHfGjFEzeYq
         KS9xyCO6ZkKGMGFhUaZUcgDSH9XBd1erEZk8nXMk5Byqhe4NUf4Gmf8rgMqorSp6db
         WMJd90EK2a0vQ==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 10 Aug 2023 09:12:05 -0400
Subject: [PATCH 2/2] fat: make fat_update_time get its own timestamp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-ctime-fat-v1-2-327598fd1de8@kernel.org>
References: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
In-Reply-To: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Frank Sorenson <sorenson@redhat.com>, Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sWnTCUjG/8VJ8vbCcrMecGrqt9k5P6DlV83pYz2Oy94=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk1OIoFsZaNNKC83Oz7ClMXf2h3TADk4VzazKCo
 yTo7933ROyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNTiKAAKCRAADmhBGVaC
 FUQMD/4uSUbtoyOw/8HxuFSZeAJrv4k7WqZJzPyEPIJQ3YYV9r8kbJnYM/K5GOEVKFxW1/CA/6W
 bfZ0CaEgZCvps13bbARi0eMuAjzOZs1FvyRMP39RxjoyjQufvWqlpg+sefj1YDCZ2PzsixtXagD
 XZ5b02Kj4SFWD0t2DIX+BgDmaZld3jz/1oWGg7p335WGiLnA7CIbBvAM24yQZsoGsjqwfz8DAtw
 Se+TJrDVLA/Rt/dPzLHpzz5gIA2tZ/W2htf6Q5Sd2Ty4H0waSx46qJDbNTqC469Xx8zsh0bf0qY
 DUzt1xfC+1UvAH6QapYSnn9UAYfYf+bFxtsepEVHB+gY6Ayhpn8RblARq4PIotKitjqsIHNTRHv
 oAT7ql5Em83p40vmawKCiY8yxn1TR/s8n3WJQ70M+pg2EDSAFMSnQvpN4CJWyG0rQhC92hBkUPd
 e5NXhr8zsPecE5upofGgBaW/IbwqeZV0U9+6Dh8chJ7u7/d6UTrSMFdfuHvQN2LGJ3ELcwRlHLk
 gwNxWPuFyS1DW+6TQ8mByh7xGSdq99+ynkC7mb1XI9pe1DUKESm8q2RJTGFB9wRbO0vc6StnvpT
 Orkn8jOhtB28yVotD84G4AoSeJBnHoHwElUQIZr59Zgs/zOhjxtdX0dGC6tVa/vuJRwcbCmkavC
 vhoEOHO7jj0vV8Q==
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

In later patches, we're going to drop the "now" parameter from the
update_time operation. Fix fat_update_time to fetch its own timestamp.
It turns out that this is easily done by just passing a NULL timestamp
pointer to fat_truncate_time.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fat/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 37f4afb346af..f2304a1054aa 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -347,7 +347,7 @@ int fat_update_time(struct inode *inode, int flags)
 		return 0;
 
 	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
-		fat_truncate_time(inode, now, flags);
+		fat_truncate_time(inode, NULL, flags);
 		if (inode->i_sb->s_flags & SB_LAZYTIME)
 			dirty_flags |= I_DIRTY_TIME;
 		else

-- 
2.41.0

