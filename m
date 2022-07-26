Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492A6580F3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 10:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiGZIji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 04:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiGZIje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:39:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F832F65B;
        Tue, 26 Jul 2022 01:39:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A09D1FA7D;
        Tue, 26 Jul 2022 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658824772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h7anLCQCvfEImdQ3rav9hS9LwqBH1cP+khrPsehktI0=;
        b=coTDEuxmww/n2W0eQV0iZwOQjiuYXNgrhTMsgSfLeJReyFKhbTyCt/hHyQZYEygPjDMEBi
        VBrDHmOAr1Md2GxoNjysW8xu57GwfhKW9lQR/PE5jMFIYg9z7rOt2lFGVtRyGrDvGPQhSV
        WhBrJkgP7pXN4LUpiAz11Xs3i/KaWNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658824772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h7anLCQCvfEImdQ3rav9hS9LwqBH1cP+khrPsehktI0=;
        b=eD+HSjvtlrQJuxer+rSnBoLdpxDHTxDU1UUnH+j1en/SNmlVzeoF77uwafBj24upQPoeih
        TVefNtvXW3mqwuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3D8F13A7C;
        Tue, 26 Jul 2022 08:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qLf1NkOo32LYDQAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 26 Jul 2022 08:39:31 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Petr Vorel <pvorel@suse.cz>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] exfat: Define NLS_NAME_* as bit flags explicitly
Date:   Tue, 26 Jul 2022 10:39:26 +0200
Message-Id: <20220726083929.1684-3-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220726083929.1684-1-tiwai@suse.de>
References: <20220726083929.1684-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NLS_NAME_* are bit flags although they are currently defined as enum;
it's casually working so far (from 0 to 2), but it's error-prone and
may bring a problem when we want to add more flag.

This patch changes the definitions of NLS_NAME_* explicitly being bit
flags.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 fs/exfat/exfat_fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 4a7a2308eb72..f431327af459 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -27,9 +27,9 @@ enum exfat_error_mode {
  * exfat nls lossy flag
  */
 enum {
-	NLS_NAME_NO_LOSSY,	/* no lossy */
-	NLS_NAME_LOSSY,		/* just detected incorrect filename(s) */
-	NLS_NAME_OVERLEN,	/* the length is over than its limit */
+	NLS_NAME_NO_LOSSY =	0,	/* no lossy */
+	NLS_NAME_LOSSY =	1 << 0,	/* just detected incorrect filename(s) */
+	NLS_NAME_OVERLEN =	1 << 1,	/* the length is over than its limit */
 };
 
 #define EXFAT_HASH_BITS		8
-- 
2.35.3

