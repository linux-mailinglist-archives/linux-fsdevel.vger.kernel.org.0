Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3520641C30D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 12:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245592AbhI2K4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 06:56:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47820 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245599AbhI2K4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:56:13 -0400
Received: from localhost.localdomain (unknown [IPv6:2401:4900:1c20:3124:6d32:b2f4:daed:4666])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 126401F43FB5;
        Wed, 29 Sep 2021 11:54:29 +0100 (BST)
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        krisman@collabora.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 2/2] fs: ext4: Fix the inconsistent name exposed by /proc/self/cwd
Date:   Wed, 29 Sep 2021 16:23:39 +0530
Message-Id: <8402d1c99877a4fcb152de71005fa9cfb25d86a8.1632909358.git.shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1632909358.git.shreeya.patel@collabora.com>
References: <cover.1632909358.git.shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

/proc/self/cwd is a symlink created by the kernel that uses whatever
name the dentry has in the dcache. Since the dcache is populated only
on the first lookup, with the string used in that lookup, cwd will
have an unexpected case, depending on how the data was first looked-up
in a case-insesitive filesystem.

Steps to reproduce :-

root@test-box:/src# mkdir insensitive/foo
root@test-box:/src# cd insensitive/FOO
root@test-box:/src/insensitive/FOO# ls -l /proc/self/cwd
lrwxrwxrwx 1 root root /proc/self/cwd -> /src/insensitive/FOO

root@test-box:/src/insensitive/FOO# cd ../fOo
root@test-box:/src/insensitive/fOo# ls -l /proc/self/cwd
lrwxrwxrwx 1 root root /proc/self/cwd -> /src/insensitive/FOO

Above example shows that 'FOO' was the name used on first lookup here and
it is stored in dcache instead of the original name 'foo'. This results
in inconsistent name exposed by /proc/self/cwd since it uses the name
stored in dcache.

To avoid the above inconsistent name issue, handle the inexact-match string
( a string which is not a byte to byte match, but is an equivalent
unicode string ) case in ext4_lookup which would store the original name
in dcache using d_add_ci instead of the inexact-match string name.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 fs/ext4/namei.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index da7698341d7d..3598f0e47067 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1801,6 +1801,19 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 	}
 
 #ifdef CONFIG_UNICODE
+	if (inode && IS_CASEFOLDED(dir))
+		if (dentry && strcmp(dentry->d_name.name, de->name)) {
+			struct dentry *new;
+			struct qstr ciname;
+
+			ciname.len = de->name_len;
+			ciname.name = kstrndup(de->name, ciname.len, GFP_NOFS);
+			if (!ciname.name)
+				return ERR_PTR(-ENOMEM);
+			new = d_add_ci(dentry, inode, &ciname);
+			kfree(ciname.name);
+			return new;
+	}
 	if (!inode && IS_CASEFOLDED(dir)) {
 		/* Eventually we want to call d_add_ci(dentry, NULL)
 		 * for negative dentries in the encoding case as
-- 
2.30.2

