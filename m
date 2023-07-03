Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722FA745ED9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 16:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjGCOng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 10:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGCOnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:43:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70946199A
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 07:43:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ACE6521A44;
        Mon,  3 Jul 2023 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688395394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TuZDlXOE8Z1YaCJ7ElpxZRrG1BNpDjE6iOyqgGSwTcI=;
        b=HHZJAoSGse/TGmXcbQ8DraQ54Qpv92cOuLSJ+l++HbICJLPxP6d7yZ07ejKtxf7KjqXFkH
        P4Pf607y8/9KpSuh3L4Wb/ejDP9TxSufROefCQnzEMtUiSLSTIAuxBFMYqKqMSx6R8OEu4
        WazcQgCMX6xm36+M3GjgE8+HGje/vBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688395394;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TuZDlXOE8Z1YaCJ7ElpxZRrG1BNpDjE6iOyqgGSwTcI=;
        b=zNo63mOG+7DE7kSyScla0ygG34AcyC3Mmu1/bLhkIq6fp74u/e9USYETIgHWxrpPNbNdZU
        knjce6T0ZtEkfXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0C201358E;
        Mon,  3 Jul 2023 14:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L7A3J4LeomQuRgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 03 Jul 2023 14:43:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 34904A0722; Mon,  3 Jul 2023 16:43:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] fs: Drop pointless 'source' check from vfs_rename()
Date:   Mon,  3 Jul 2023 16:43:06 +0200
Message-Id: <20230703144306.32639-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=jack@suse.cz; h=from:subject; bh=GlyKpAqu9mbSXwRlpYQXbfH5IsE2U1kvv28OfU26mr0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkot50cV2pIjlNvsa2/LO0HzWp/698IgEiPU1Ecl0y 3pR3/d+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKLedAAKCRCcnaoHP2RA2UScB/ 94z+SIZP+cwhdMRtmUXY3mR37mAD9FJursQnbexNwHUmNGLgGVXXOF/AsUHd93jMGaJLqifGWBzngH FOGMpu6mo4QACnkpUXQ/4AXRatCJ89hoKetkkEv2LD/zlF33Vj6vWme/gz2GCj5Cp/KX3wAJYR3YP5 05TafHbOdrW8GAhrnulCfUHox5JWxt9uZPD4OzKOirqJp4m3T8QMiWfbwddZ9SCt4UivHHF/DXEPFj 94SH9BZkz54G3J0ouNX4IjDoOfMAt+d6aUEQ+cAQ+/bXVXBZdGBJY2VV0+K0M4RRFQLIsWPOmYJ9ZW u2MZrAVAQxIbTxIg21piZGYBseYOsp
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The check for 'source' being non-NULL before unlocking it is pointless
as 'source' is guaranteed to exist in vfs_rename(). Drop it.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202307030026.9sE2pk2x-lkp@intel.com/
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 91171da719c5..e56ff39a79bc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4874,8 +4874,7 @@ int vfs_rename(struct renamedata *rd)
 			d_exchange(old_dentry, new_dentry);
 	}
 out:
-	if (source)
-		inode_unlock(source);
+	inode_unlock(source);
 	if (target)
 		inode_unlock(target);
 	dput(new_dentry);
-- 
2.35.3

