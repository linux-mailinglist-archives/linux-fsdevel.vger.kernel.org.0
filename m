Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9666A6D56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 14:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCANqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 08:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCANqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:46:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424173BD8C
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 05:46:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD06521A94;
        Wed,  1 Mar 2023 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677678401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwC6p7p7EWQuA/jOntkfena8fBOR8ngnNxaV8uDKAtU=;
        b=gJmOqP2DIOUUTqez6c6rMsD/V6Z4XuO2tDTrV6g+p/bdVhez1PIxDDaQGHLbT3D7q4aN9x
        AGrUzCLR+e5eeLzaClqvemEktZPMyVzOEOdu1yTEz1Q5jXVz8uaUp9SUMzxDeZip+hBnFR
        nNj3ZrUzsFFmA2a9C54n51/IeDq9/FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677678401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwC6p7p7EWQuA/jOntkfena8fBOR8ngnNxaV8uDKAtU=;
        b=13nHOBvKvyPfZxPneoSfPxpN8Uc+QX7Y3T8rEAURbX/hZ5mtlfJHJicEvQGnW/c42onFkx
        8HUh17Ipg1OKqECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0DE313A64;
        Wed,  1 Mar 2023 13:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id owX9MkFX/2OWIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 13:46:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 54FD5A06FD; Wed,  1 Mar 2023 14:46:41 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] udf: Warn if block mapping is done for in-ICB files
Date:   Wed,  1 Mar 2023 14:46:37 +0100
Message-Id: <20230301134641.11819-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230301133937.24267-1-jack@suse.cz>
References: <20230301133937.24267-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=812; i=jack@suse.cz; h=from:subject; bh=JOtxpQycosan9JktofQYmnBk83p3THdLOYshQDwXg6g=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj/1c83Ix4zZ+PInjK8z5PjQNFDgGlyTH4piUvedvy M0Q1pCOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY/9XPAAKCRCcnaoHP2RA2adEB/ wNw1rHvSNao+f8oq3XisGC2FXKVSC42fgInmdk8HK4WsGoPM1jdRM2Y8qdGEMjfLlgq94p98vshNMb 44O2Sv1Tp+DtgVYjLlUA2+6aBi/umAizKPq8xT+ai1xmsgA0rbJyjKQHlGrPf0oIWg+JZFkOyZC4Gg Y2qLVKkrm0TMFLpFJVzvQGfqNVANqQgxnZKcAJ/4FLkF6sVzbnv+am9PA+nB/NRzYVV7eKlxL25EUd EiT/E0/47bPHbIvEVlITgsOng1tNFjlBto60G/H5RnUeSgTm5svcTG9CZC/GK8wDmbP1dP5SxhxPoW HddSFpCXfxVZQOlRmfDIb7LIBQM9vb
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that address space operations are merge dfor in-ICB and normal
files, it is more likely some code mistakenly tries to map blocks for
in-ICB files. WARN and return error instead of silently returning
garbage.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 0cb7d8fba2c8..2210e5eb1ea0 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -416,6 +416,9 @@ static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
 	int err;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 
+	if (WARN_ON_ONCE(iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB))
+		return -EFSCORRUPTED;
+
 	map->oflags = 0;
 	if (!(map->iflags & UDF_MAP_CREATE)) {
 		struct kernel_lb_addr eloc;
-- 
2.35.3

