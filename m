Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7568757E306
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiGVO30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 10:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiGVO3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:29:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7399E9D509;
        Fri, 22 Jul 2022 07:29:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 29510380E6;
        Fri, 22 Jul 2022 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658500161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26tMlYb8gCcseuVDtBr5aDvYQknciTTUMDfRuR1RFY0=;
        b=ewR6H64AI9QbUT/9UhyzQ4eKfuCArua5Pr0coWF+1vivwcDwenPFz5u+FARRApYNy42yFn
        HF/4sz6qPzdvPUAAue7V2POk/RaIuR/c9r+3QWLEbsaKbuMrEbXoBMtyvELVRgoV7JCF2h
        WwjUyXbf8gBXww9q7hEwqYd1ZiyOToc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658500161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26tMlYb8gCcseuVDtBr5aDvYQknciTTUMDfRuR1RFY0=;
        b=hUxtx3V1s0dutZktRa+32TjJVqq2SFooIUC30NSjHYK8Po7oW+I3sIw6KMQeV4J9D66vXo
        hPU7QeOaB1bjpWCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 057CA13ABC;
        Fri, 22 Jul 2022 14:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OBSGAEG02mJ7bwAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 22 Jul 2022 14:29:21 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] exfat: Return ENAMETOOLONG consistently for oversized paths
Date:   Fri, 22 Jul 2022 16:29:13 +0200
Message-Id: <20220722142916.29435-2-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220722142916.29435-1-tiwai@suse.de>
References: <20220722142916.29435-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

LTP has a test for oversized file path renames and it expects the
return value to be ENAMETOOLONG.  However, exfat returns EINVAL
unexpectedly in some cases, hence LTP test fails.  The further
investigation indicated that the problem happens only when iocharset
isn't set to utf8.

The difference comes from that, in the case of utf8,
exfat_utf8_to_utf16() returns the error -ENAMETOOLONG directly and
it's treated as the final error code.  Meanwhile, on other iocharsets,
exfat_nls_to_ucs2() returns the max path size but it sets
NLS_NAME_OVERLEN to lossy flag instead; the caller side checks only
whether lossy flag is set or not, resulting in always -EINVAL
unconditionally.

This patch aligns the return code for both cases by checking the lossy
flag bit and returning ENAMETOOLONG when NLS_NAME_OVERLEN bit is set.

BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1201725
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 fs/exfat/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index c6eaf7e9ea74..bcb6445eb3b3 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -462,7 +462,7 @@ static int __exfat_resolve_path(struct inode *inode, const unsigned char *path,
 		return namelen; /* return error value */
 
 	if ((lossy && !lookup) || !namelen)
-		return -EINVAL;
+		return (lossy & NLS_NAME_OVERLEN) ? -ENAMETOOLONG : -EINVAL;
 
 	exfat_chain_set(p_dir, ei->start_clu,
 		EXFAT_B_TO_CLU(i_size_read(inode), sbi), ei->flags);
-- 
2.35.3

