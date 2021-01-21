Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A4B2FEECF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbhAUPaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:30:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46040 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731924AbhAUNWL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:22:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDDfln043163;
        Thu, 21 Jan 2021 13:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=m2knT8uSI6MLG69Ij4awUn0WhOK6WWXgzwRlQjg273U=;
 b=NUNs4uOJ1YNaFJUN18BDLqeYKsrNxZ2U0j9SnM1jH08gmuKtV/Llw6L1qOOzqUG8PccB
 sTYIdaGy7B6hnYUOhoP2PRQeLOV4OJVjQwHuSDB1+4SJO/T5m8cThriPn0XQsGDYT6ZO
 d2GFjVmel3tjP1XDYA5ZzwcJBuYeO+4R3jGEC+H7z2KFET7ph+5bFF0K0kgYAZ03HFjn
 cm6diN/JDzuIFtdXLWr6189cWN68e+djsIhcsoUf/AH7avReVXRJF0cuzYRfa3PblbhX
 uNgY8rH3oVjqOxNYHFpnI2LZyjrZfY7wdbBG0DzaIq+sCtY6ruYbtg0d6uMk2aT9Puwe pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3668qaf9jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:21:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDFkhP106711;
        Thu, 21 Jan 2021 13:21:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3668rexr2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:21:12 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10LDKZJB123118;
        Thu, 21 Jan 2021 13:21:12 GMT
Received: from gmananth-linux.oraclecorp.com (dhcp-10-166-171-141.vpn.oracle.com [10.166.171.141])
        by userp3030.oracle.com with ESMTP id 3668rexq88-3;
        Thu, 21 Jan 2021 13:21:12 +0000
From:   Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     viro@zeniv.linux.org.uk, matthew.wilcox@oracle.com,
        khlebnikov@yandex-team.ru, gautham.ananthakrishna@oracle.com
Subject: [PATCH RFC 2/6] fsnotify: stop walking child dentries if remaining tail is negative
Date:   Thu, 21 Jan 2021 18:49:41 +0530
Message-Id: <1611235185-1685-3-git-send-email-gautham.ananthakrishna@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
References: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=973
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210072
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

When notification starts/stops listening events from inode's children it
have to update dentry->d_flags of all positive child dentries. Scanning
may took a long time if directory has a lot of negative child dentries.

This is main beneficiary of sweeping cached negative dentries to the end.

Before patch:

nr_dentry = 24172597    24.2M
nr_buckets = 8388608    2.9 avg
nr_unused = 24158110    99.9%
nr_negative = 24142810  99.9%

inotify time: 0.507182 seconds

After patch:

nr_dentry = 24562747    24.6M
nr_buckets = 8388608    2.9 avg
nr_unused = 24548714    99.9%
nr_negative = 24543867  99.9%

inotify time: 0.000010 seconds

Negative dentries no longer slow down inotify op at parent directory.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
---
 fs/notify/fsnotify.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 8d3ad5e..4ccb59d 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -127,8 +127,12 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 		 * original inode) */
 		spin_lock(&alias->d_lock);
 		list_for_each_entry(child, &alias->d_subdirs, d_child) {
-			if (!child->d_inode)
+			if (!child->d_inode) {
+				/* all remaining children are negative */
+				if (d_is_tail_negative(child))
+					break;
 				continue;
+			}
 
 			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
 			if (watched)
-- 
1.8.3.1

