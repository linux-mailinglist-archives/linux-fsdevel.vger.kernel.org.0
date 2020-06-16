Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3011FBFF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 22:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbgFPUVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 16:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgFPUVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:21:41 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC92C061573;
        Tue, 16 Jun 2020 13:21:41 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c12so16579788qtq.11;
        Tue, 16 Jun 2020 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fn4EkDtyCwWOYjkj5abb0ivOrfVPzRJ74WkGvYptq6M=;
        b=dg/HgUWfWS+M4LYIXTdMrGl3x3ZRCXBAitiRGyBsR/f//oA0ExU5pFXfOj5RutZfPo
         eKtzh4Lj8nDNTmhzIPK+EevDMuqxYgCckV1AIRXbnODOOOvMqrMAUo7VceZ86IDGmZGF
         bOip7xlLpxKsZSanlH9iesa0jpyFMaeM94CRD+F8E7K/7VXU4GOIFgQmL6Uyxys2aSVm
         wwAQxoXNACyomKG9viuY/h2q0DEdPoe0wrHR4OebvwXqgg+CkCBAoaY8BKqhAXsFFN4B
         hIzjT0oO2mjsaGEucqtfy7vOx7/itxVxyQYfYa6GDlbpawx55bbdKjSiLMypeKtMoixV
         KI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fn4EkDtyCwWOYjkj5abb0ivOrfVPzRJ74WkGvYptq6M=;
        b=VyDhH8OVwfSizaQ2SGlj1w3qHowfPjvuiAPAk/W5SBRuxjQ9xM1bpXseANfg7EamBA
         7V0MFYujQ/zlzSjo9uERX1hdg6jFtA4Jyq6v9+rfbYK2Wm3vYY37WVrfWp7HXBw6cUI0
         AJJijN+duWHQGQRr7XBR/IMEleFqC/7nhdf8ONIRQnlpbBElhKnJvIAOeleph2oUsW8U
         eaIZRFkUNR8WHVM9GeAqo6eKk8CvVn8yGyyO2rDAVZlNJPOUxws3SDVTwOTKx7469Lw/
         ew3lZWNHYMJW8v2DCpoo5tIdTOQi6Be4GugVyk86Ld8IswrV+m6TDLnotY59HrQciiP1
         E7mg==
X-Gm-Message-State: AOAM530J4mHY0k7NdRfSbQHaGdd90eu+Q+hzQ79IEDDe2DBAgGjxvHhL
        vxj8TW8w/7YYUpsd1HLJfQ==
X-Google-Smtp-Source: ABdhPJwVNG6Y075bcXUmYimMU9ZVj2934sQIGstMjpXrJVeRJ0GvNAgeGtyjpRV91E8NQqr2ZXc6OA==
X-Received: by 2002:aed:21d7:: with SMTP id m23mr22545244qtc.342.1592338900651;
        Tue, 16 Jun 2020 13:21:40 -0700 (PDT)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id k20sm16401468qtu.16.2020.06.16.13.21.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 13:21:40 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Date:   Tue, 16 Jun 2020 16:21:23 -0400
Message-Id: <20200616202123.12656-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

/proc/mounts doesn't show 'i_version' even if iversion
mount option is set to XFS.

iversion mount option is a VFS option, not ext4 specific option.
Move the handler to show_sb_opts() so that /proc/mounts can show
'i_version' on not only ext4 but also the other filesystem.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 fs/ext4/super.c     | 2 --
 fs/proc_namespace.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a29e8ea1a7ab..879289de1818 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2325,8 +2325,6 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 		SEQ_OPTS_PRINT("min_batch_time=%u", sbi->s_min_batch_time);
 	if (nodefs || sbi->s_max_batch_time != EXT4_DEF_MAX_BATCH_TIME)
 		SEQ_OPTS_PRINT("max_batch_time=%u", sbi->s_max_batch_time);
-	if (sb->s_flags & SB_I_VERSION)
-		SEQ_OPTS_PUTS("i_version");
 	if (nodefs || sbi->s_stripe)
 		SEQ_OPTS_PRINT("stripe=%lu", sbi->s_stripe);
 	if (nodefs || EXT4_MOUNT_DATA_FLAGS &
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 3059a9394c2d..848c4afaef05 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 		{ SB_DIRSYNC, ",dirsync" },
 		{ SB_MANDLOCK, ",mand" },
 		{ SB_LAZYTIME, ",lazytime" },
+		{ SB_I_VERSION, ",i_version" },
 		{ 0, NULL }
 	};
 	const struct proc_fs_opts *fs_infop;
-- 
2.18.4

