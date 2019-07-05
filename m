Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB060A49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfGEQal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 12:30:41 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:52061 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfGEQal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:30:41 -0400
Received: by mail-yb1-f201.google.com with SMTP id h35so4587336ybi.18
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jul 2019 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HGTWQFDxYVMCMUJdNYUyNG/FKXXlxIV2zrqsyrgnOLI=;
        b=WkkUt0LyKQsbN0xk0dY4mHPc1O2nPXbz7w2egGziV95fDI3u52YGBpBbdpMZwBKO3W
         YS2xFk7//eojhE6wXj4v15i7Cj4aW7vrYtSE23eu+l4owgufAQL0XLoSCmgwTokx431L
         2RyF/pKgRn7U1+2mD+hmWu+voWoEXttPq2PkZJGvgGNk7mIt1wT3MUliG2orf2xiWfCH
         35TjLUvNDF4EzaIr7FgAleR1nZsR9+L6pB97hwmhJnsp47P2DPSS1jJoFKU2AlO8rRg2
         cftwue0TmYGDKiQ47L32Ip0RIjt8L6xhGWiklPkU4I7aHVucarWEQBBxMt4SZzU2BSE/
         ylQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HGTWQFDxYVMCMUJdNYUyNG/FKXXlxIV2zrqsyrgnOLI=;
        b=Rwmp0/ZkeM8sE7WulHtCpA131U8EeXEcMaN0fEW6tyou2vxV+c0Jqzk3nIWeitpwNt
         OqZI28WZc/SPGRY1R/C74bR6s3zXINlcYm2bOTCz6AzWTe3FGCtJnMiMy+Key6UybHh6
         y59ka1yntURRq76//xgQy4X0kjuWJNbqA1kZ12BNK1Rz7BHVkgg0JgIYkbWSn0nVeAP5
         oaN6pr6xFDiNqOF9PPDp9LYOD8kytvIoDcKGGEthjcYjm6rKXR6ad0/jxarJ4HsvEl1V
         f5UlYfm9uCdE80348HGeQlxNwIscfhowa2ab/xZnER9hT0X2R0p8ejlF1DGy5ltyxd3r
         Ddvw==
X-Gm-Message-State: APjAAAVp7qhBV0sSkHbc8/bXV0vum8PsGrBTAfoy1Z9u/5Mizc/r3Tpp
        DEiQKJ9rPESlvkXMtFjxCmtzYRCXejU=
X-Google-Smtp-Source: APXvYqwZ4OKhEzX5lujcHH6VcKquOZyDhPFBRHBTWl6GHZ0kfdO/wP1Swcx12SgftW+x+Rv7faRgM6uFwOc=
X-Received: by 2002:a81:f012:: with SMTP id p18mr2538485ywm.375.1562344240222;
 Fri, 05 Jul 2019 09:30:40 -0700 (PDT)
Date:   Fri,  5 Jul 2019 18:30:21 +0200
Message-Id: <20190705163021.142924-1-rburny@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2] fs: Fix the default values of i_uid/i_gid on /proc/sys inodes.
From:   Radoslaw Burny <rburny@google.com>
To:     "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jsperbeck@google.com, Radoslaw Burny <rburny@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This also fixes a problem where, in a user namespace without root user
mapping, it is not possible to write to /proc/sys/kernel/shmmax.

The problem was introduced by the combination of the two commits:
* 81754357770ebd900801231e7bc8d151ddc00498: fs: Update
  i_[ug]id_(read|write) to translate relative to s_user_ns
    - this caused the kernel to write INVALID_[UG]ID to i_uid/i_gid
    members of /proc/sys inodes if a containing userns does not have
    entries for root in the uid/gid_map.
* 0bd23d09b874e53bd1a2fe2296030aa2720d7b08: vfs: Don't modify inodes
  with a uid or gid unknown to the vfs
    - changed the kernel to prevent opens for write if the i_uid/i_gid
    field in the inode is invalid

This commit fixes the issue by defaulting i_uid/i_gid to
GLOBAL_ROOT_UID/GID. Note that these values are not used for /proc/sys
access checks, so the change does not otherwise affect /proc semantics.

Tested: Used a repro program that creates a user namespace without any
mapping and stat'ed /proc/$PID/root/proc/sys/kernel/shmmax from outside.
Before the change, it shows the overflow uid, with the change it's 0.

Signed-off-by: Radoslaw Burny <rburny@google.com>
---
Changelog since v1:
- Updated the commit title and description.

 fs/proc/proc_sysctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c74570736b24..36ad1b0d6259 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -499,6 +499,10 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 
 	if (root->set_ownership)
 		root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
+	else {
+		inode->i_uid = GLOBAL_ROOT_UID;
+		inode->i_gid = GLOBAL_ROOT_GID;
+	}
 
 	return inode;
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

