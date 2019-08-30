Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F78A3C4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 18:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfH3Qmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 12:42:49 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:40046 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727976AbfH3Qms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:42:48 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7UGglUr029605
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2019 12:42:47 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7UGggAF011207
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2019 12:42:47 -0400
Received: by mail-qt1-f197.google.com with SMTP id t5so7645512qtd.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2019 09:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=AMywH1n1mw6t5p5hLpZTz0Q6W8htDSaR2tsRwWJpbB4=;
        b=a7se+sdexIGjMQVn8wMNiZ7PRWN32c/jG2DoaglPN2MmN0ia99YEQN0BAAy0cNQOnv
         g0BRP97kk0MephzHcxkNWa6kjNlST4QEXBXmuXXrTO47OAEPEfufHvg1w1yDsGN5o3Oc
         4o5l6IGaDw9waVAuBQwiVnWjhZVG+SvydL67nWoaZwG87GHuTE3yqWmjQimfzf45ebsp
         dwDlNgBkSTUr2HIl96Y8z6+KOVAs3D1D+vHaHMboQPTwmKWwcozG86R1Sdrzqt6j1iHU
         /GQIPj3BrIVbPkrkEVLyOhHZvSGmHbcRTQCu/GxHCtimOxlaeNbtN6muhn966BnOVKZF
         P9zw==
X-Gm-Message-State: APjAAAVulUC4thjnEUP6Cj3MH5q9ZicJRUFjK82WK8ZdddsHtIPJWhCU
        CFZn8w5ZWz5a+tKveSsIALodgF+xCu4f/2gAhDVhO3KNQpAZF1n7sHtzoYYkeNk7i9P7lIMAnlx
        1rjvlhfM5abZpr+QyuH3ig+kGj79LiVVS6S4+
X-Received: by 2002:ac8:120c:: with SMTP id x12mr8899867qti.315.1567183361958;
        Fri, 30 Aug 2019 09:42:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwaY2l4b6tk1M6trceqg9AZjRhcMlNGwJvpCK2NExWnBnD86JM81kuWaQfA7O5TUsj17REnaA==
X-Received: by 2002:ac8:120c:: with SMTP id x12mr8899847qti.315.1567183361693;
        Fri, 30 Aug 2019 09:42:41 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id f27sm2703076qkl.25.2019.08.30.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 09:42:40 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/staging/exfat - by default, prohibit mount of fat/vfat
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 30 Aug 2019 12:42:39 -0400
Message-ID: <245727.1567183359@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Concerns have been raised about the exfat driver accidentally mounting
fat/vfat file systems.  Add an extra configure option to help prevent that.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
index 78b32aa2ca19..1df177b1dc72 100644
--- a/drivers/staging/exfat/Kconfig
+++ b/drivers/staging/exfat/Kconfig
@@ -4,6 +4,14 @@ config EXFAT_FS
 	help
 	  This adds support for the exFAT file system.
 
+config EXFAT_DONT_MOUNT_VFAT
+	bool "Prohibit mounting of fat/vfat filesysems by exFAT"
+	default y
+	help
+	  By default, the exFAT driver will only mount exFAT filesystems, and refuse
+	  to mount fat/vfat filesystems.  Set this to 'n' to allow the exFAT driver
+	  to mount these filesystems.
+
 config EXFAT_DISCARD
 	bool "enable discard support"
 	depends on EXFAT_FS
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5b5c2ca8c9aa..7fdb5b8bc928 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -486,10 +486,16 @@ static int ffsMountVol(struct super_block *sb)
 			break;
 
 	if (i < 53) {
+#ifdef CONFIG_EXFAT_DONT_MOUNT_VFAT
+		ret = -EINVAL;
+		printk(KERN_INFO "EXFAT: Attempted to mount VFAT filesystem\n");
+		goto out;
+#else
 		if (GET16(p_pbr->bpb + 11)) /* num_fat_sectors */
 			ret = fat16_mount(sb, p_pbr);
 		else
 			ret = fat32_mount(sb, p_pbr);
+#endif
 	} else {
 		ret = exfat_mount(sb, p_pbr);
 	}

