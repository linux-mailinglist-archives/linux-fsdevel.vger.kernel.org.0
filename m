Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB05A3317
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 02:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345049AbiH0A21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 20:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbiH0A2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:28:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE75EA899
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 17:28:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3641F1F9AC;
        Sat, 27 Aug 2022 00:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661560101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkHOMCgteBaqkUHJLwtS9lLMQwIPe7zjThZ34GlLVjg=;
        b=pFtCjH88UuGgZVI98KBXwDTablD3NbxKYy0efxWzPjBOOrHy2q1BfJ9cBKoZlINMya2EuY
        OVYQh+p7pGccJW8A5yB/QGVcapS9YkU+Z8j9uhwbznrQEbEKFy6mlCPG4TmuDhZm+LgmwV
        e0D1di1OEoFaTtxMh71afwj9THcLBRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661560101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkHOMCgteBaqkUHJLwtS9lLMQwIPe7zjThZ34GlLVjg=;
        b=sn4D/Kks/d2bW/pVeOvdSpcDwye2zZSfsCAhXEa6My+hAOvkGt1WH3UqmOlJJoR6ZZE+RL
        jd/qwXfqoYJXBPBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E363133A6;
        Sat, 27 Aug 2022 00:28:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MHjSESRlCWNQCgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Sat, 27 Aug 2022 00:28:20 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
        Li Wang <liwang@redhat.com>, Martin Doucha <mdoucha@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        automated-testing@lists.yoctoproject.org,
        Tim Bird <tim.bird@sony.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/6] tst_fs_type: Add nsfs, vfat, squashfs to tst_fs_type_name()
Date:   Sat, 27 Aug 2022 02:28:10 +0200
Message-Id: <20220827002815.19116-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827002815.19116-1-pvorel@suse.cz>
References: <20220827002815.19116-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_fs.h  | 5 ++++-
 lib/tst_fs_type.c | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 8159b99eb..a6f934b0f 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -5,7 +5,7 @@
 #ifndef TST_FS_H__
 #define TST_FS_H__
 
-/* man 2 statfs or kernel-source/include/linux/magic.h */
+/* man 2 statfs or kernel-source/include/uapi/linux/magic.h */
 #define TST_BTRFS_MAGIC    0x9123683E
 #define TST_NFS_MAGIC      0x6969
 #define TST_RAMFS_MAGIC    0x858458f6
@@ -32,6 +32,9 @@
 #define TST_FUSE_MAGIC     0x65735546
 #define TST_VFAT_MAGIC     0x4d44 /* AKA MSDOS */
 #define TST_EXFAT_MAGIC    0x2011BAB0UL
+#define TST_SQUASHFS_MAGIC 0x73717368
+/* kernel-source/fs/ntfs/ntfs.h */
+#define TST_NTFS_MAGIC     0x5346544e
 
 enum {
 	TST_BYTES = 1,
diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
index 9de80224b..de4facef5 100644
--- a/lib/tst_fs_type.c
+++ b/lib/tst_fs_type.c
@@ -88,6 +88,12 @@ const char *tst_fs_type_name(long f_type)
 		return "fuse";
 	case TST_EXFAT_MAGIC:
 		return "exfat";
+	case TST_NTFS_MAGIC:
+		return "ntfs";
+	case TST_SQUASHFS_MAGIC:
+		return "squashfs";
+	case TST_VFAT_MAGIC:
+		return "vfat";
 	default:
 		return "unknown";
 	}
-- 
2.37.2

