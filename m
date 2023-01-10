Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A8866374D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 03:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbjAJCZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 21:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjAJCZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:25:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB436262
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 18:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iq87xx+SY/euP2O+1uW6GCncWBIYuADxh+E+XsxmLVA=; b=np7kMxe1cEHJXTLtI6LO+Qo3qH
        VkhuHlNnLfVwrBEQAnstbJSt4r5FNCs72WqB7lo7t/JTAiQvo/H2H1Xu+PlAot4+rzgBLNIT4rbUm
        1aJGDWWBxs7K7IMpW/tRNIGpmW/JRyFa+nCRkzlsc9SSHiT8qECFq2J+ZwuF7WZDwxDdXkqnR0GkV
        JN7BFPaKUBHyteZua2J0QdxCyw1FtInzvf5hWP4cTWDz0QhfXpbMR7WFag8W65g1JxsCIL5gc09+x
        C/yQHrLDeDeOpRUdiv+hbfw2TVhgPErRF7XaiaepPgG/TCp0kB4GjY0dINU+TULbYgDh8AALw4a1j
        r3RvzxVw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pF4Kp-004yfa-7b; Tue, 10 Jan 2023 02:25:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
        hch@infradead.org, john.johansen@canonical.com,
        dhowells@redhat.com, mcgrof@kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC 1/3] apparmor: use SB_* flags for private sb flags
Date:   Mon,  9 Jan 2023 18:25:52 -0800
Message-Id: <20230110022554.1186499-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230110022554.1186499-1-mcgrof@kernel.org>
References: <20230110022554.1186499-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 2ea3ffb7782 ("apparmor: add mount mediation") John Johansen
added mount mediation support. However just the day before this commit
David Howells modified the internal sb flags through commit e462ec50cb5
("VFS: Differentiate mount flags (MS_*) from internal superblock flags").

Use the modified sb flags to make things clear and avoid further uses
of the old MS_* flags for superblock internal flags. This will let us
later remove the MS_* sb internal flags as userspace should not be
using them.

This commit does not fix anything as the old flags used map to the
same bitmask, this just tidies things up. I split up the flags to
make it clearer which ones are for the superblock and used internally.

Cc: John Johansen <john.johansen@canonical.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 security/apparmor/include/mount.h | 3 ++-
 security/apparmor/lsm.c           | 1 +
 security/apparmor/mount.c         | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/include/mount.h b/security/apparmor/include/mount.h
index a710683b2496..f90e03405e38 100644
--- a/security/apparmor/include/mount.h
+++ b/security/apparmor/include/mount.h
@@ -23,7 +23,8 @@
 #define AA_AUDIT_DATA		0x40
 #define AA_MNT_CONT_MATCH	0x40
 
-#define AA_MS_IGNORE_MASK (MS_KERNMOUNT | MS_NOSEC | MS_ACTIVE | MS_BORN)
+#define AA_MS_IGNORE_MASK (MS_KERNMOUNT)
+#define AA_SB_IGNORE_MASK (SB_NOSEC | SB_ACTIVE | SB_BORN)
 
 int aa_remount(struct aa_label *label, const struct path *path,
 	       unsigned long flags, void *data);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c6728a629437..f3880956bffd 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -583,6 +583,7 @@ static int apparmor_sb_mount(const char *dev_name, const struct path *path,
 		flags &= ~MS_MGC_MSK;
 
 	flags &= ~AA_MS_IGNORE_MASK;
+	flags &= ~AA_SB_IGNORE_MASK;
 
 	label = __begin_current_label_crit_section();
 	if (!unconfined(label)) {
diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index cdfa430ae216..c37c451e8226 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -74,7 +74,7 @@ static void audit_mnt_flags(struct audit_buffer *ab, unsigned long flags)
 		audit_log_format(ab, ", iversion");
 	if (flags & MS_STRICTATIME)
 		audit_log_format(ab, ", strictatime");
-	if (flags & MS_NOUSER)
+	if (flags & SB_NOUSER)
 		audit_log_format(ab, ", nouser");
 }
 
-- 
2.35.1

