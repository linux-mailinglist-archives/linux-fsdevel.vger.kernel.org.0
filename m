Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0D0342DE6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 16:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCTPq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 11:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCTPqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:46:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA033C061574;
        Sat, 20 Mar 2021 08:46:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u5so14393041ejn.8;
        Sat, 20 Mar 2021 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=stA9eMTsiClMTTVbDXG9ikJ8gl/7VEUDLTDJT6ZFsMs=;
        b=RACW76s6YnIVeZwc7956uumK/HRcBwuVNnT5bq2UupIGQkV4SynucRbhXHBnn4ZSih
         k65pa4hYTnkNvCQ9+WtIJB8+mpZ8SKP3Wfo1yq5ncSEf7yC+eV6T4WSzwhj/Yvggj45a
         HDaskvoZg5lVWzepFqoDr9P/DBunNoOnj8UJgkNFVFehOC3gRVCDrmf+2tDBODMPQdBJ
         qNwOQyCLzCwXOWMHgW1fAe7Au/ScP4x9gXBP6Z8tdEtQOmb/Sy2O7EJjI3y7CgvqOR4x
         t+Zp9C+SIXvzCxygCnEakdXB1AAMgVLauuavgzMNXvguuSfuGegSS7aOFqm9Ku8x9t7a
         snVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=stA9eMTsiClMTTVbDXG9ikJ8gl/7VEUDLTDJT6ZFsMs=;
        b=FMRTpsbxqR51SHV/x0s4kS8piRU7lMSWzEOvQiJyNE4A8XkAqpHJXHH4Ly5ih9ielP
         o/DjuoeJC0WwAG9gpN/nPSImfGTEW4evZ089XP6dFrRpZT4IQ9hODK7AbCs/jrE9lZT6
         qGUMTHiILpU2xsvbEM+7eTMHBOufEQeIKUTKOrT7gRiiIlX+cI3RMpMkVW2gMd+5kmeY
         cungSDO9gFQKr9xWkYFYz4BYNajcYTlJwbvwF0vHrod3KypKxexBR5UohvNChtSpzKs9
         ZO/FBxqNZyWTXWeI71AnIMIWQZjgSn7JD6kSyHMeFvly3hM9x8T99qbWIM7cKnqMdNSv
         JGpg==
X-Gm-Message-State: AOAM5327rtdz4MDIbKI3aAe4noOMMXWlqRdoxjxm7I6G4j8e8mM153vW
        wuHFJTvjWfASCALY4BDwsG/MNEAaXg==
X-Google-Smtp-Source: ABdhPJwirMMG06CCssedXvaSNJHOhQEyCH9q732f0z8ipH87lvWgLjzq0Gxn/KL1IQ1VHPMysJwhhw==
X-Received: by 2002:a17:907:20e4:: with SMTP id rh4mr10368501ejb.369.1616255170315;
        Sat, 20 Mar 2021 08:46:10 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.213])
        by smtp.gmail.com with ESMTPSA id t14sm5410736ejc.121.2021.03.20.08.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 08:46:10 -0700 (PDT)
Date:   Sat, 20 Mar 2021 18:46:08 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gladkov.alexey@gmail.com
Subject: [PATCH] proc: delete redundant subset=pid check
Message-ID: <YFYYwIBIkytqnkxP@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Two checks in lookup and readdir code should be enough to not have
third check in open code.

Can't open what can't be looked up?

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/inode.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -483,7 +483,6 @@ proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr,
 
 static int proc_reg_open(struct inode *inode, struct file *file)
 {
-	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 	struct proc_dir_entry *pde = PDE(inode);
 	int rv = 0;
 	typeof_member(struct proc_ops, proc_open) open;
@@ -497,9 +496,6 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 		return rv;
 	}
 
-	if (fs_info->pidonly == PROC_PIDONLY_ON)
-		return -ENOENT;
-
 	/*
 	 * Ensure that
 	 * 1) PDE's ->release hook will be called no matter what
