Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C93466125
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 11:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356626AbhLBKJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 05:09:39 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54246 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346226AbhLBKJg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:09:36 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D44C71FD39;
        Thu,  2 Dec 2021 10:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638439570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=loQalLe5TvCZw/CypigFARcwYLjl+dWE1SMmoMgvWTs=;
        b=AnANZHUQg6zvDXSqf3vByd3ZkYLKt89AQaGJhfbx6j9lMObs4FMwTi6fI22TH1I31BrhfT
        VinpHdE08f9URRFBWkoZ8abY21M7J1/I2t3ZySMQV6jKtq0H9MWymO4HO0B2GXT2VHZgXE
        FTpzvM7KGmzdJSddZ4XOH67WJ2sGY5A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0A7313D73;
        Thu,  2 Dec 2021 10:06:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H1FUJpKaqGFBWgAAMHmgww
        (envelope-from <ailiop@suse.com>); Thu, 02 Dec 2021 10:06:10 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mount: warn only once about timestamp range expiration
Date:   Thu,  2 Dec 2021 11:02:53 +0100
Message-Id: <20211202100253.17139-1-ailiop@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit f8b92ba67c5d ("mount: Add mount warning for impending timestamp
expiry") introduced a mount warning regarding filesystem timestamp
limits, that is printed upon each writable mount or remount.

This can result in a lot of unnecessary messages in the kernel log in
setups where filesystems are being frequently remounted (or mounted
multiple times).

Avoid this by setting a superblock flag which indicates that the warning
has been emitted at least once for any particular mount, as suggested in
[1].

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

[1] https://lore.kernel.org/CAHk-=wim6VGnxQmjfK_tDg6fbHYKL4EFkmnTjVr9QnRqjDBAeA@mail.gmail.com/
---
 fs/namespace.c     | 2 ++
 include/linux/fs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 659a8f39c61a..21deeefe0af1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2561,6 +2561,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 	struct super_block *sb = mnt->mnt_sb;
 
 	if (!__mnt_is_readonly(mnt) &&
+	   (!(sb->s_iflags & SB_I_TS_EXPIRY_WARNED)) &&
 	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
 		char *buf = (char *)__get_free_page(GFP_KERNEL);
 		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
@@ -2575,6 +2576,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 			tm.tm_year+1900, (unsigned long long)sb->s_time_max);
 
 		free_page((unsigned long)buf);
+		sb->s_iflags |= SB_I_TS_EXPIRY_WARNED;
 	}
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbf812ce89a8..21cbb1812196 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1441,6 +1441,7 @@ extern int send_sigurg(struct fown_struct *fown);
 
 #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
 #define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
+#define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
 
 /* Possible states of 'frozen' field */
 enum {
-- 
2.34.1

