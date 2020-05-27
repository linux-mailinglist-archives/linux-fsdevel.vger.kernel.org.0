Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2B91E3F5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 12:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgE0KtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 06:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgE0KtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 06:49:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB50C061A0F
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 03:49:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nu7so1403966pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0NWZYU1lxcrwaW23MbfWedBJs/ZrKLhC3NzbNi3U6p0=;
        b=SeWBxOYv+3g39jn7O9nFSx1aTgIEdN4uciG2Osp99q7bSNFZBv1GRdCzoDgWU1HSm9
         XK4IBVi5FdqXDx+ZfT8JZ24EuxbPR5ZXw21X5wDAP03eH2CdPemtnHF7x09M1LrfsKgG
         F3MNvE54gPvrM6jstfVoFuim5XlSYp4m0EtiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0NWZYU1lxcrwaW23MbfWedBJs/ZrKLhC3NzbNi3U6p0=;
        b=X95VmtaONWIX4X990joQikTOkqoqFY8wkpnv+2yco+Wi+oA9B0zgvzoH89WJV3Isgc
         xTtPF4Rk0EMHH4+I6JYeBvspzxuDOJ/+GNM1N4FLHlwPCfT/lsfeLKN6sNJbbE4z9MSl
         Vcbqp/178JQCPOITE+8ZpE+Bd6kvKpaIIbrY08IfuzAfPfss52yspFOlIxkVpVCmyjle
         SDA3PzEVL1SYhExo/Zn9hwh8ba+sUgrUjvKJFmpo4oovNgGNb4bNQUVQMgJlGUR3E40q
         8uv/UijvJx/d/VAghr7bA5SeBjCFVBgS8HVrIo7yBgKp5SjHYanw1jUpk95jFIUKjKh+
         UhtQ==
X-Gm-Message-State: AOAM530TYT6WchXC8Ub5xluGkUXgZuSl/+WY/2hIrxuszKtQkHzJ8RhH
        vCqh89nreif+jQhOlCaWjkTlcbCuuJ4oZfX6q4dIN27wo1jwiHOKxoPP8lUKbSqca1DMV4AsICn
        NuJGYopL4X9qeNfxvknNGvG163/SJnJtC/RHtiDwERDw2u0Ipu2RoZnkAj5nSqa05mORdBdsb+r
        GI4mdks5I01OA=
X-Google-Smtp-Source: ABdhPJzd36B5M/VwVyPeqIgGVw3cgyrqkYVGRWHYKVAef1hdEnWsqd13DPzk1ONSfQ8/LHwcGb5ldQ==
X-Received: by 2002:a17:90a:23e7:: with SMTP id g94mr4559859pje.210.1590576540509;
        Wed, 27 May 2020 03:49:00 -0700 (PDT)
Received: from nixbox ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id u14sm1873017pfc.87.2020.05.27.03.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 03:48:59 -0700 (PDT)
Date:   Wed, 27 May 2020 13:48:48 +0300
From:   Boris Sukholitko <boris.sukholitko@broadcom.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Subject: [PATCH] __register_sysctl_table: do not drop subdir
Message-ID: <20200527104848.GA7914@nixbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Successful get_subdir returns dir with its header.nreg properly
adjusted. No need to drop the dir in that case.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
Fixes: 7ec66d06362d (sysctl: Stop requiring explicit management of sysctl directories)
---
 fs/proc/proc_sysctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b6f5d459b087..6f237f0eb531 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1286,8 +1286,8 @@ struct ctl_table_header *__register_sysctl_table(
 {
 	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
+	struct ctl_dir *dir, *start_dir;
 	const char *name, *nextname;
-	struct ctl_dir *dir;
 	struct ctl_table *entry;
 	struct ctl_node *node;
 	int nr_entries = 0;
@@ -1307,6 +1307,7 @@ struct ctl_table_header *__register_sysctl_table(
 
 	spin_lock(&sysctl_lock);
 	dir = &set->dir;
+	start_dir = dir;
 	/* Reference moved down the diretory tree get_subdir */
 	dir->header.nreg++;
 	spin_unlock(&sysctl_lock);
@@ -1333,7 +1334,8 @@ struct ctl_table_header *__register_sysctl_table(
 	if (insert_header(dir, header))
 		goto fail_put_dir_locked;
 
-	drop_sysctl_table(&dir->header);
+	if (start_dir == dir)
+		drop_sysctl_table(&dir->header);
 	spin_unlock(&sysctl_lock);
 
 	return header;
-- 
2.23.1

