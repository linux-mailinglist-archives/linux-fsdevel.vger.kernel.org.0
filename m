Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCC66A6D58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 14:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCANqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 08:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCANqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:46:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325BC3D0AB
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 05:46:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D65E221A90;
        Wed,  1 Mar 2023 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677678401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZdwhReJi4XNpuO25dxH7OOoj+xqrb1d+JZ/S+SICEA=;
        b=gdBPsKDtEkpQiJDx6y4gXiSMSwU3k49w85s2eW28q1yPUzPMYP4s72UYSgIyvKRrNVtK+0
        3CJQ9Ovxtbk6s2IxCM8pTlKKWp7VAJqf8bpTUhHGkFrr1gLV+051FFYHemA6Lrfs/TaReN
        9qOMPRmf3zT7rkADYIgubV7yE33Cea8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677678401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZdwhReJi4XNpuO25dxH7OOoj+xqrb1d+JZ/S+SICEA=;
        b=M0MznNNFgEJswfzBiE0bYbWHsrtAlyVIMI5XlYJ+hfvpDgacnbaFxjfx5rmDUA53s/mO7d
        St9i4mZCyQc+SjCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C55D213A3E;
        Wed,  1 Mar 2023 13:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hZwcMEFX/2OVIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 13:46:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4EC55A06F3; Wed,  1 Mar 2023 14:46:41 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] udf: Fix reading of in-ICB files
Date:   Wed,  1 Mar 2023 14:46:36 +0100
Message-Id: <20230301134641.11819-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230301133937.24267-1-jack@suse.cz>
References: <20230301133937.24267-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=jack@suse.cz; h=from:subject; bh=Yd1Gk45+R/Rtpj58o/PburCl2kErIZquHQ9LCprc5hc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj/1c7NK6bpqmNJlup9nz67qqqbXwQwFs+sEpVCMEs 6gAbEJaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY/9XOwAKCRCcnaoHP2RA2Q4LB/ 0T1hh2wtG2Xnwwg7OpQ2M90rUIbY/u6Eoe3eZOih/7Ecgr9ByCsDFLfK3oNFHUpaafW9IcNa/YYEXl +6vtppiY+bgIm8Hb7sNRnsISfg0qqCLlXe27mmnSlAEzTWuCzl7ghP83jtIIkrDOvnhOk5cq1qg0av 0P7yV8CI71bPioV0CYjKQNsiMV8tWFh7nR+e3VCrJ3NzWvToMhAuMKR2cDi96puE8ge6zLFsCEttxb UdqUF9C7MCg9OnqaJRQ7S8iO8YRPbV/Zpvi9oL39D5anCsUzgEy5x3YXY/+YJDLJ36Esrg6Taku9gc hjbe30xGCyfedOGSKQDBjtiqsW97OI
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

After merging address space operations of normal and in-ICB files,
readahead could get called for in-ICB files which resulted in
udf_get_block() being called for these files. udf_get_block() is not
prepared to be called for in-ICB files and ends up returning garbage
results as it interprets file data as extent list. Fix the problem by
skipping readahead for in-ICB files.

Fixes: 37a8a39f7ad3 ("udf: Switch to single address_space_operations")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index facaf3a20625..0cb7d8fba2c8 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -241,6 +241,15 @@ static int udf_read_folio(struct file *file, struct folio *folio)
 
 static void udf_readahead(struct readahead_control *rac)
 {
+	struct udf_inode_info *iinfo = UDF_I(rac->mapping->host);
+
+	/*
+	 * No readahead needed for in-ICB files and udf_get_block() would get
+	 * confused for such file anyway.
+	 */
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
+		return;
+
 	mpage_readahead(rac, udf_get_block);
 }
 
-- 
2.35.3

