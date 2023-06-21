Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7EC738019
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 13:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjFUJwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjFUJwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:52:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D621BC0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 02:52:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 059001FD77;
        Wed, 21 Jun 2023 09:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687341124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5BhSxAcFAgPIs5f2ybCu90SwzgG8PQs+fRvRVrGTBj0=;
        b=D9ZCi/1epuk1DueJ6phkBPjrlTdp9TLcU7aih35BP8JyUbsJVpYnHln9QIbrrvltpKrY1W
        nNXkW8WiHYlKuR+3b9J5fHLhvj1T8RGah0HQ2CDUfDI/BsOHOWNmgJE6SjMplIodzdHhV6
        Lw3pWZ4ftIskMKci/O2fmvBosaq3rI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687341124;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5BhSxAcFAgPIs5f2ybCu90SwzgG8PQs+fRvRVrGTBj0=;
        b=GgQiFwaTsmXLdPRqjeMFpzis3kLOrdO04h+djWpZns62+Hs/RV1AcBxYoLJ5ngc6c+2nNj
        eEK7af8rOcNXq+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB7FB133E6;
        Wed, 21 Jun 2023 09:52:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nuV5OUPIkmS9ewAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 09:52:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 86E94A075D; Wed, 21 Jun 2023 11:52:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+cd311b1e43cc25f90d18@syzkaller.appspotmail.com
Subject: [PATCH] udf: Fix uninitialized array access for some pathnames
Date:   Wed, 21 Jun 2023 11:52:01 +0200
Message-Id: <20230621095201.16481-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062; i=jack@suse.cz; h=from:subject; bh=RDogboHkvIwgtm363dPV9LVKm0sxG2wJaLAeTctREFI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkksg6m2CmzJe5JjFofDF0MnZcXgB5c/paFJk1SeAM kyqv5G+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZJLIOgAKCRCcnaoHP2RA2YrHB/ 93+hPOdlkiCFKGv3WY/5OmMeaU4WphISiwphXPAV99ap+AmTwZLijiJtk9Mb5bJNK+FSaGbQ9ajp2p eGj8pW+eRrirlMQ0u7befvKHpp56TMbiLOdeVqs1RTlcXbZJUYE2vu0dSWxTpVc6030k7F+BwLQTH8 5CRMFaSFYnLLRmpp8KdyzTHK7x0qUx+88yhcZbAJAkxScOUXQgs8L8ArE05LH6yFlEda4jTTxQ+s68 zrZfXkIsGLOnmQ0YR1t+IsPbUypLz11Gc+TZm2DT7B5jbD1aoNdt/RFnC0YY21qpHJePKuGyhspkOu zjzb9422f/e4ljZ4MpJphGwR8hE0LR
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For filenames that begin with . and are between 2 and 5 characters long,
UDF charset conversion code would read uninitialized memory in the
output buffer. The only practical impact is that the name may be prepended a
"unification hash" when it is not actually needed but still it is good
to fix this.

Reported-by: syzbot+cd311b1e43cc25f90d18@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000e2638a05fe9dc8f9@google.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/unicode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

I plan to merge this fix through my tree.

diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
index 622569007b53..2142cbd1dde2 100644
--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -247,7 +247,7 @@ static int udf_name_from_CS0(struct super_block *sb,
 	}
 
 	if (translate) {
-		if (str_o_len <= 2 && str_o[0] == '.' &&
+		if (str_o_len > 0 && str_o_len <= 2 && str_o[0] == '.' &&
 		    (str_o_len == 1 || str_o[1] == '.'))
 			needsCRC = 1;
 		if (needsCRC) {
-- 
2.35.3

