Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DFA2FEEA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732731AbhAUP26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:28:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42504 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbhAUNYE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:24:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDEVIh072889;
        Thu, 21 Jan 2021 13:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=ZE8IsY7P4ozut4mYRdoD4bNb9GcUENrj7M6f6C6UVV4=;
 b=0DwwfQ1uPbgN3FIQaCYnbaoDbzrD1UuDk1zmCF24XNxgCBh40W7jNisxbNIiuv0db0IM
 Nf0a3GxIufyjt9uEEGHxu3MShho9TgJAtYaorOzTzqz5iRoaHrIrgpFF3xX7FNvHzP4h
 5gydTY/HBF7BZH4da9l+RiXHSPOBSQUaTtDclMMKbPGWgCxZ0wIjx2HNY5Lik6pHQgS7
 AuvyiFlQc5t7UXPYjSc4xGrREnlbXISTiFMucvRg42zMBo5d6qiZZ6pictA55JCpxfEa
 li/+f/TgSDRrpIOcJ5WibZIc9C74OYBvQX/l0GudHYcxKG6Rn4PqpFfZti5+LgH9xiKX ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3668qmy98t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:23:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDFjEG106643;
        Thu, 21 Jan 2021 13:21:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3668rexr9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:21:21 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10LDKZJF123118;
        Thu, 21 Jan 2021 13:21:20 GMT
Received: from gmananth-linux.oraclecorp.com (dhcp-10-166-171-141.vpn.oracle.com [10.166.171.141])
        by userp3030.oracle.com with ESMTP id 3668rexq88-5;
        Thu, 21 Jan 2021 13:21:20 +0000
From:   Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     viro@zeniv.linux.org.uk, matthew.wilcox@oracle.com,
        khlebnikov@yandex-team.ru, gautham.ananthakrishna@oracle.com
Subject: [PATCH RFC 4/6] dcache: stop walking siblings if remaining dentries all negative
Date:   Thu, 21 Jan 2021 18:49:43 +0530
Message-Id: <1611235185-1685-5-git-send-email-gautham.ananthakrishna@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
References: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210072
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Most walkers are interested only in positive dentries.

Changes in simple_* libfs helpers are mostly cosmetic: it shouldn't cache
negative dentries unless uses d_delete other than always_delete_dentry().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
---
 fs/dcache.c | 9 +++++++++
 fs/libfs.c  | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 894e6da..492a42f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1459,6 +1459,8 @@ static enum d_walk_ret path_check_mount(void *data, struct dentry *dentry)
 	struct check_mount *info = data;
 	struct path path = { .mnt = info->mnt, .dentry = dentry };
 
+	if (d_is_tail_negative(dentry))
+		return D_WALK_SKIP_SIBLINGS;
 	if (likely(!d_mountpoint(dentry)))
 		return D_WALK_CONTINUE;
 	if (__path_is_mountpoint(&path)) {
@@ -1705,6 +1707,10 @@ void shrink_dcache_for_umount(struct super_block *sb)
 static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
 {
 	struct dentry **victim = _data;
+
+	if (d_is_tail_negative(dentry))
+		return D_WALK_SKIP_SIBLINGS;
+
 	if (d_mountpoint(dentry)) {
 		__dget_dlock(dentry);
 		*victim = dentry;
@@ -3174,6 +3180,9 @@ static enum d_walk_ret d_genocide_kill(void *data, struct dentry *dentry)
 {
 	struct dentry *root = data;
 	if (dentry != root) {
+		if (d_is_tail_negative(dentry))
+			return D_WALK_SKIP_SIBLINGS;
+
 		if (d_unhashed(dentry) || !dentry->d_inode)
 			return D_WALK_SKIP;
 
diff --git a/fs/libfs.c b/fs/libfs.c
index 7124c2e..15d5ecf 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -410,6 +410,9 @@ int simple_empty(struct dentry *dentry)
 
 	spin_lock(&dentry->d_lock);
 	list_for_each_entry(child, &dentry->d_subdirs, d_child) {
+		if (d_is_tail_negative(child))
+			break;
+
 		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
 		if (simple_positive(child)) {
 			spin_unlock(&child->d_lock);
-- 
1.8.3.1

