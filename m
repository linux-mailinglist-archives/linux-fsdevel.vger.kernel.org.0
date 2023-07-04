Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C94F74711A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjGDMXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjGDMXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:23:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4106110E5;
        Tue,  4 Jul 2023 05:22:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 83D192056C;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQwr5UuHNfhTbPltKjuSdQnPV1mAcWzpyJqrIN8BW0I=;
        b=nOacVS8tJH8o+KaEeK8T7qQ2qZYGpNHZrHdl+D2d/5NBZt18W9D0GubEG33ybqDnC+6s4b
        woJwgxkqsTmLNCBW6yzXws0T/lFkAzjqGC/Yy8oLTY1XTT79XS0OVHlS+Az39XvC4Fhvf/
        fTQKQqeL1Cagw+Jr9qukz7p0SJj9fXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQwr5UuHNfhTbPltKjuSdQnPV1mAcWzpyJqrIN8BW0I=;
        b=VGVnKUg83uI2bRH7vJbEMJqY/TZfXogwFhtgNjI67oPxV8qlVbBcLGITDC+i2IDdUDpfZL
        i2qifN45iJK9VYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70B8913A26;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xUKDGwIPpGRTMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3A9F4A078B; Tue,  4 Jul 2023 14:22:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-nilfs@vger.kernel.org
Subject: [PATCH 27/32] nilfs2: Convert to use blkdev_get_handle_by_path()
Date:   Tue,  4 Jul 2023 14:21:54 +0200
Message-Id: <20230704122224.16257-27-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2354; i=jack@suse.cz; h=from:subject; bh=DtdezkZSK/EN7RM1qSQYRSnndqPmr+l0kbPMp17XFJg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7iDlB6QtnlTTlGdMJScOFDAX2JZEdaLV5wnQzq wfPr4T+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO4gAKCRCcnaoHP2RA2WRuB/ 93sM8/9dGNutmxHoGEwtGYIIHvJjLz0OrPGr/rt39+sF5c9+WtfclsNZKrDE94oblL8T2o3nX5R/LN wiAFHzzgZYgg/12m8Za2axys3zh+uos763PGHIk2KfJ+6Fo+mFYKKZKIRKiviewfu6XgdJv4Qo0+Sb psBZY1rOU3m/HWCVvqcfugnu4hJN3rdUqYbpGcLYB6UEM1PEg+oSPR4kf30dV8D3q48lMGy+1vNmj1 5IRRSUYNFyHdzvBXDpA+Hsis5vX0vfXijjPcmhb2D2Km2OntPST3pnilGdLVKp2XkkBuTbXx29A01B iSQmxGUB40YvRnmZFjGSZXIVogEbjT
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

Convert nilfs2 to use blkdev_get_handle_by_path() and initialize the
superblock with the handle.

CC: linux-nilfs@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/nilfs2/super.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 0ef8c71bde8e..0aba0daa06d2 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1283,14 +1283,15 @@ static int nilfs_identify(char *data, struct nilfs_super_data *sd)
 
 static int nilfs_set_bdev_super(struct super_block *s, void *data)
 {
-	s->s_bdev = data;
+	s->s_bdev_handle = data;
+	s->s_bdev = s->s_bdev_handle->bdev;
 	s->s_dev = s->s_bdev->bd_dev;
 	return 0;
 }
 
 static int nilfs_test_bdev_super(struct super_block *s, void *data)
 {
-	return (void *)s->s_bdev == data;
+	return s->s_bdev == ((struct bdev_handle *)data)->bdev;
 }
 
 static struct dentry *
@@ -1298,15 +1299,17 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 	     const char *dev_name, void *data)
 {
 	struct nilfs_super_data sd;
+	struct bdev_handle *bdev_handle;
 	struct super_block *s;
 	struct dentry *root_dentry;
 	int err, s_new = false;
 
-	sd.bdev = blkdev_get_by_path(dev_name, sb_open_mode(flags), fs_type,
-				     NULL);
-	if (IS_ERR(sd.bdev))
-		return ERR_CAST(sd.bdev);
+	bdev_handle = blkdev_get_handle_by_path(dev_name, sb_open_mode(flags),
+				fs_type, NULL);
+	if (IS_ERR(bdev_handle))
+		return ERR_CAST(bdev_handle);
 
+	sd.bdev = bdev_handle->bdev;
 	sd.cno = 0;
 	sd.flags = flags;
 	if (nilfs_identify((char *)data, &sd)) {
@@ -1326,7 +1329,7 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 		goto failed;
 	}
 	s = sget(fs_type, nilfs_test_bdev_super, nilfs_set_bdev_super, flags,
-		 sd.bdev);
+		 bdev_handle);
 	mutex_unlock(&sd.bdev->bd_fsfreeze_mutex);
 	if (IS_ERR(s)) {
 		err = PTR_ERR(s);
@@ -1374,7 +1377,7 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 	}
 
 	if (!s_new)
-		blkdev_put(sd.bdev, fs_type);
+		blkdev_handle_put(bdev_handle);
 
 	return root_dentry;
 
@@ -1383,7 +1386,7 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 
  failed:
 	if (!s_new)
-		blkdev_put(sd.bdev, fs_type);
+		blkdev_handle_put(bdev_handle);
 	return ERR_PTR(err);
 }
 
-- 
2.35.3

