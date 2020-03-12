Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11163182A5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 09:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388269AbgCLID3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 04:03:29 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:40938 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbgCLIDV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:03:21 -0400
Received: by mail-pj1-f73.google.com with SMTP id d2so2671270pjz.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2020 01:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y1s6MQhHqkVnqFsukeC5Awzp5ivr6jiv6hUkDCpLIsA=;
        b=KzIl0HFRPFDpD4RamPtkjTfVB+xlCCtT2LraTA/0B61n8m3pmGmHCmX//ov5FQWva1
         iYJlQp482tSC5I2bo99tpHHJ83S7G8ADGOz7zWIcbKo61d/pzYzpgAtx/XF3B40tTB2L
         08Buyphz0C7bGnN/8BNgIoGFuzOzPNTT1lNpCXWLEaTeYsLCr5NkvsomPH32QHvETm2e
         cbx2fvY1WsWGae2mbukMCmTFpDWExMCaGZs+GkpgZdHEHCGohcjNdY8UPWueJDnqYTOq
         YPmE8xd4qMF2HvQ8st4aUTOgFO8ZFisWbqW0TuVW8QMV51Kx78cclESONoHGqC55LBtz
         gTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y1s6MQhHqkVnqFsukeC5Awzp5ivr6jiv6hUkDCpLIsA=;
        b=Pgv6KgTKvvBHHL8E2b3n0jSJedsix8B1nXrUhod5p+Lc+cEECHdPjRcGEpaVZCziqo
         pZdNpmVAfUw1xZ+0Ll211POlHqtE1pzvIwq5owb5sjPxpGzqGV/Cq0NeKN/5q/UPRV3j
         yFafHjZoeAy2XiHW0cyXqFuX4FMyjSndziyo8m5PSxbacGljk8kM0WZpkf86OzF26WZT
         oFM1Y+n4Lq+0I3T4R5U1m+NHQJHyF8j07bU/rD1dXYvILgxKO1ryROsjPWHvw6bPC09t
         JwDUUBUJsFxJOIUvjY+DYLTnQNhiqkUl9iEbZOAkn8FTyR6s3x0kusgAjwVWvtLzeW8l
         OC9A==
X-Gm-Message-State: ANhLgQ3znFDEbNSepaYFWN5gLC7yZ2Emz4QrXN2R8vdC06fBYyVUhMm/
        7Q6EFdw052dxl3D1sOteyQ/zu4uoFeI=
X-Google-Smtp-Source: ADFU+vuXOMA8mZEN+vMh9qFbvN0gW4bbscIe10bvEJpl4bpEIDzYzV5f0sZE06RcCDamrRg4MYFMPmlFhx0=
X-Received: by 2002:a17:90a:c687:: with SMTP id n7mr2803267pjt.159.1584000198723;
 Thu, 12 Mar 2020 01:03:18 -0700 (PDT)
Date:   Thu, 12 Mar 2020 01:02:50 -0700
In-Reply-To: <20200312080253.3667-1-satyat@google.com>
Message-Id: <20200312080253.3667-9-satyat@google.com>
Mime-Version: 1.0
References: <20200312080253.3667-1-satyat@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 08/11] fs: introduce SB_INLINECRYPT
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
blk-crypto for file content en/decryption.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/proc_namespace.c | 1 +
 include/linux/fs.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 273ee82d8aa9..8bf195d3bda6 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 		{ SB_DIRSYNC, ",dirsync" },
 		{ SB_MANDLOCK, ",mand" },
 		{ SB_LAZYTIME, ",lazytime" },
+		{ SB_INLINECRYPT, ",inlinecrypt" },
 		{ 0, NULL }
 	};
 	const struct proc_fs_info *fs_infop;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6b845e..08a0395674dd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1370,6 +1370,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* inodes in SB use blk-crypto */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-- 
2.25.1.481.gfbce0eb801-goog

