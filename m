Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047B64941B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 21:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357299AbiASUaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 15:30:07 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55140 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357292AbiASUaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:30:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 364C1212C8;
        Wed, 19 Jan 2022 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642624205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=uZCg3wYXWrxrjgYiJjCYzIEhgvSwdTdXDWWFM7+lkDU=;
        b=fNYfNP6Cw/TJL7NbdSFuU/UgKANhcUJpWtK3dEcgC/91AJSoS1Qe8vvRBEYzOqpHJczIfs
        4xT0WlOv6pVmMLw+8I9O+/zKujFDg3BuVZaI3cemZsx7XDOPIdaTY4vSgP3++0I7Y70crG
        IAl89lFmUAqeaR6v6E2xY3ozz8n+8ck=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27B0713B9A;
        Wed, 19 Jan 2022 20:30:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JdZKCc106GFPCwAAMHmgww
        (envelope-from <ailiop@suse.com>); Wed, 19 Jan 2022 20:30:05 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] mount: warn only once about timestamp range expiration
Date:   Wed, 19 Jan 2022 21:29:34 +0100
Message-Id: <20220119202934.26495-1-ailiop@suse.com>
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
index c6feb92209a6..fec0f79aa2eb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2583,6 +2583,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 	struct super_block *sb = mnt->mnt_sb;
 
 	if (!__mnt_is_readonly(mnt) &&
+	   (!(sb->s_iflags & SB_I_TS_EXPIRY_WARNED)) &&
 	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
 		char *buf = (char *)__get_free_page(GFP_KERNEL);
 		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
@@ -2597,6 +2598,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 			tm.tm_year+1900, (unsigned long long)sb->s_time_max);
 
 		free_page((unsigned long)buf);
+		sb->s_iflags |= SB_I_TS_EXPIRY_WARNED;
 	}
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f3daaea16554..5c537cd9b006 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1435,6 +1435,7 @@ extern int send_sigurg(struct fown_struct *fown);
 
 #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
 #define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
+#define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
 
 /* Possible states of 'frozen' field */
 enum {
-- 
2.34.1

