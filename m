Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E05679742
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjAXMGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjAXMGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:06:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5172542DE5
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:06:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0E4D21872;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674561991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUNsigO42UKlZzM/npKTxr/a+9VF26HvLakw/u/66XM=;
        b=sqRAN5I58aWJJrOJ3mfiTtA0Eox3sWPcMDzo3yBIcHoAmcQtsqx7iQ8+89OdEo3GGLmQTq
        BWsxSH4JBR37Q8AwHma1++ARQpdd+ZY5h0+syBd6r6UDZcci+6BC2ycV2Idazk4WBTxUId
        exmEViqsNmy3Thc5Z8/TP1lupYtIMYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674561991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUNsigO42UKlZzM/npKTxr/a+9VF26HvLakw/u/66XM=;
        b=bl6kB+sDgclbJ647Y36sDJSMOzE10l72W4Wl+ZUiorWtQ8XsEW/wc1SJEKhxhcFnVjV0Ic
        96qFtB0LHt0fCzDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D38EF139FB;
        Tue, 24 Jan 2023 12:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BFOoM8fJz2MLMQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:06:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3F236A06D0; Tue, 24 Jan 2023 13:06:31 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 06/10] udf: Add handling of in-ICB files to udf_bmap()
Date:   Tue, 24 Jan 2023 13:06:17 +0100
Message-Id: <20230124120628.24449-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120221.31585-1-jack@suse.cz>
References: <20230124120221.31585-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=763; i=jack@suse.cz; h=from:subject; bh=MCO/4rTn0U00y2bP1Aw7PWrhPbOM8v+P/OKYeSTHORM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8m4Ljet75Ff18+3Ce26zp7Ix0Hav2IPKfjY5l8F Kwx0kqGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/JuAAKCRCcnaoHP2RA2aVnB/ 9x6X38J9m6OJ9YPIMeXTk7lQg4HUSStyXSzAz7RTEom6eYa7CTck8re79rustZVKyoR+y268RFXnN4 mqrHJXcdc0+MriiCV6dmlbV9CdJyHlwY+h/YXjCwcHHD5OinRcdw2YUdMrMITWUEcMiBS1Fws9Ggep t7xrReOcBeSc+UDTlfOSYq9bXtgvJnSNrxX1/PkCQN0scLAhbWn5flS2YlW+NgNBVJnloxnq82UETw /09xIYKvfIfywdBThcxiHfa9UlTYE4idK1ttEaa+LFK67TaqxDYNmns4J7x2fS4bHjRBRlAu+6hYIf KFRn5Rv7p4K1p5agi+ty/HBQtTFma3
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

Add detection of in-ICB files to udf_bmap() and return error in that
case. This will allow us o use single address_space_operations in UDF.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 91758c8d77e5..703db2a4516b 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -296,6 +296,10 @@ ssize_t udf_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 static sector_t udf_bmap(struct address_space *mapping, sector_t block)
 {
+	struct udf_inode_info *iinfo = UDF_I(mapping->host);
+
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
+		return -EINVAL;
 	return generic_block_bmap(mapping, block, udf_get_block);
 }
 
-- 
2.35.3

