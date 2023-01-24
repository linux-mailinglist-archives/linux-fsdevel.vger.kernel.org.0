Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D572679783
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjAXMSS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjAXMSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB9A442EE
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D8AFF1FDFC;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5YEYQTPee+bHiWAf9SXhfgsWbBxRwpDlvsCt6+VsNs=;
        b=PxjEV2V+/s89fu/JCw0ogho67mYekfZRbiiSK6Yl9qJ5AO+Dsvv0V5t1wgviLBEY0zVP8S
        wi88KEVdutG/Tvtz/Hiw2sLKR6pjVdMWfECjTU7VH/0BU+6slAAJpQGNMYCLCIlbl8G47t
        e4jG9erqoKztLyvJIrLiuJ7vg78zrAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5YEYQTPee+bHiWAf9SXhfgsWbBxRwpDlvsCt6+VsNs=;
        b=/yNgHj3epYtLM4JoZglHjlENkFgsHbVPCf8dXmyo2ePVQM3gHiM/a+0Tt+fiucntovVH7U
        idx3it1eopwg90AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD188139FB;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5koPMobMz2PZNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1D4DDA06D0; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 05/22] udf: Use udf_bread() in udf_get_pblock_virt15()
Date:   Tue, 24 Jan 2023 13:17:51 +0100
Message-Id: <20230124121814.25951-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=jack@suse.cz; h=from:subject; bh=RFJSVugjUdOJBCZPb34/YpPlYyUVOl3Dphv2WOBy0hk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8xwpfqiFS19wfsP67DXE7gsoPEq2nCkreQqgBIq 6hn1Ww2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/McAAKCRCcnaoHP2RA2cp+B/ 42GKbw/0bmRZdq3h1fFejDJmCrUvlANL51oL6HxR2NFBW28G2WcHbMAUgI9bp6ncepOftAKLyBACzg DnxTaWE0rxoqr4BVstzJ6RHO2ppJWBRIlwx8j5d0vMNSToUcnGXFwV4jrW+KZknnZ7XVtMb2pNUerU ecZGqKOP6UOE1zSzViyAjMvlvM2CwuNKpfa8kxJyLHvOrS1nsps0aLm2TOD0D8y/TRVfVHyYOwvylf 6s1l3cfrKNdcJ+gI9Lt1dQ1raNy2HuUuPeWWE8uFCQ3V7l8PC/9hWsGA3zqa0HEsjGqVcxhT0Jwdra Arycgw8PzNtiXVxwKKoS9htuuZW+HV
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

Use udf_bread() instead of mapping and reading buffer head manually in
udf_get_pblock_virt15().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/partition.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/udf/partition.c b/fs/udf/partition.c
index 4cbf40575965..92765d2f6958 100644
--- a/fs/udf/partition.c
+++ b/fs/udf/partition.c
@@ -54,6 +54,7 @@ uint32_t udf_get_pblock_virt15(struct super_block *sb, uint32_t block,
 	struct udf_part_map *map;
 	struct udf_virtual_data *vdata;
 	struct udf_inode_info *iinfo = UDF_I(sbi->s_vat_inode);
+	int err;
 
 	map = &sbi->s_partmaps[partition];
 	vdata = &map->s_type_specific.s_virtual;
@@ -79,9 +80,7 @@ uint32_t udf_get_pblock_virt15(struct super_block *sb, uint32_t block,
 		index = vdata->s_start_offset / sizeof(uint32_t) + block;
 	}
 
-	loc = udf_block_map(sbi->s_vat_inode, newblock);
-
-	bh = sb_bread(sb, loc);
+	bh = udf_bread(sbi->s_vat_inode, newblock, 0, &err);
 	if (!bh) {
 		udf_debug("get_pblock(UDF_VIRTUAL_MAP:%p,%u,%u) VAT: %u[%u]\n",
 			  sb, block, partition, loc, index);
-- 
2.35.3

