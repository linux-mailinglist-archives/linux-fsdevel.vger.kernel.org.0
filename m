Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03CF653E21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 11:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiLVKQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 05:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiLVKQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:16:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC00F8FF0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 02:16:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 525DC8D58C;
        Thu, 22 Dec 2022 10:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671704176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMcltPErAnUaZ2E8MZ1BVqgqjs7++N3jLvuu2D02bdA=;
        b=GjD1/ZyPCwZp1afDCrVUXi/sHHH2fb+zONb6hbFWNenuQysNGJX61zjKeT3CRYbDDDUkBA
        ACGUqAlYCuXPVTiS+ThjrA+ef5lRcWTNbzXf3kaZ5ueb9hJkTI7O7WG+xFpUHRSdDpv5BO
        8iNOD+3s/4h9biBfrBGDxF4Jo5Fzwss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671704176;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMcltPErAnUaZ2E8MZ1BVqgqjs7++N3jLvuu2D02bdA=;
        b=aXTjB5FzRsGpQRVfH4gj4xVCHjrpzmkXS5427f+lkQI/6QXA8XFz9Opd4g8d5gAHTn23G0
        8bG3TOx52VVYe6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E3DE1391A;
        Thu, 22 Dec 2022 10:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EpFgB3AupGM9WwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 10:16:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 28BB0A0744; Thu, 22 Dec 2022 11:16:12 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 6/7] udf: Fix extension of the last extent in the file
Date:   Thu, 22 Dec 2022 11:16:03 +0100
Message-Id: <20221222101612.18814-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221222101300.12679-1-jack@suse.cz>
References: <20221222101300.12679-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=jack@suse.cz; h=from:subject; bh=Gcl4YFJQZhSE3h/xrjpJZCPX9KgF4bSBNznIlnESTJk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjpC5jkulY2Mkvbs8L3Gkl+AQm8ZZweMRXSQKWDIR0 21bd1xWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY6QuYwAKCRCcnaoHP2RA2bTzB/ wPMa0bbWfkqdbhGQr0wKo/UKXsZHBwX2pAskSH2znfzgnkRDSh4Sn22H5GVm91kz7QtHMqm1htLGRW SutQlDYYXgY3Cc7RGits9ToA1qHM8fFM+62ynHWwD+3CmOe9lYYYuGcdUzDeQASpi7CCrBp3pKXZqE thRW/2KoS4mRjK6KAS00mpYnDB0vN771J70K3DXHY3sVCta9RebaUYah119r6GYKtqSayvx+7OmMlG D889fhcwecEIM6GlUNgdLZj1egu1jGMXy8BPfiqD+aarDiAyTBi9zApl6CSiNkDmlWROQkehfWBjc7 hfZuHIviM3SHZZvc7HPfFWmia3MYbV
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When extending the last extent in the file within the last block, we
wrongly computed the length of the last extent. This is mostly a
cosmetical problem since the extent does not contain any data and the
length will be fixed up by following operations but still.

Fixes: 1f3868f06855 ("udf: Fix extending file within last block")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index fe5b0ba600fa..075e0a9d766c 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -516,7 +516,7 @@ static void udf_do_extend_final_block(struct inode *inode,
 	 */
 	if (new_elen <= (last_ext->extLength & UDF_EXTENT_LENGTH_MASK))
 		return;
-	added_bytes = (last_ext->extLength & UDF_EXTENT_LENGTH_MASK) - new_elen;
+	added_bytes = new_elen - (last_ext->extLength & UDF_EXTENT_LENGTH_MASK);
 	last_ext->extLength += added_bytes;
 	UDF_I(inode)->i_lenExtents += added_bytes;
 
-- 
2.35.3

