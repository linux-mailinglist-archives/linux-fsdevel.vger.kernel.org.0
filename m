Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FAB2FEE9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbhAUP1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:27:42 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48510 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbhAUNYI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:24:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDEw0A095496;
        Thu, 21 Jan 2021 13:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=ql0wC9LxRsGgSrOHu3fRQsna06B8LdR/VErJMQR/XfM=;
 b=JVod1dEdB5Z5+ycpndwCZHxyDUxY9WQL3XSTTZ+5wrAhWMOZCFaciabNZYgMoUUhgNZz
 SQ3NFYPq1BPWMjAgygYYSSLakocigr5f8SAz/kSqoHYt4veUYuBNasCKKQzX+LtYjTGa
 IRV7mav+nTjZBVW4X246ZbHtUvx9oAj7TgXNAvw+KhR/C03KDPhxZfdS4n/Ox8Gnen15
 bfX0gwQ6KcipvqE0w/kloUhJOnXpSLJ4e8lOXhYV7LAevEYx7pPVVMj6HR4nH9SIvuR7
 MMXEV9iyLT8wV2VjuKcJOT8dJb8NMM8jHwjh+O2d+Vm4spaxhkiMfTsJQ7sj5JcDe4IU hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 3668qrfa03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:23:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDFjEK106643;
        Thu, 21 Jan 2021 13:21:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3668rexrcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:21:25 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10LDKZJH123118;
        Thu, 21 Jan 2021 13:21:24 GMT
Received: from gmananth-linux.oraclecorp.com (dhcp-10-166-171-141.vpn.oracle.com [10.166.171.141])
        by userp3030.oracle.com with ESMTP id 3668rexq88-6;
        Thu, 21 Jan 2021 13:21:24 +0000
From:   Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     viro@zeniv.linux.org.uk, matthew.wilcox@oracle.com,
        khlebnikov@yandex-team.ru, gautham.ananthakrishna@oracle.com
Subject: [PATCH RFC 5/6] dcache: push releasing dentry lock into sweep_negative
Date:   Thu, 21 Jan 2021 18:49:44 +0530
Message-Id: <1611235185-1685-6-git-send-email-gautham.ananthakrishna@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
References: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210072
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Release the dentry lock inside the sweep_negative() function.  This
is in preparation for a follow up patch and doesn't change runtime
behavior.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Gautham Ananthakrisha <gautham.ananthakrishna@oracle.com>
---
 fs/dcache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 492a42f..22c990b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -638,13 +638,14 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
  * Must be called at dput of negative dentry.
  */
 static void sweep_negative(struct dentry *dentry)
+	__releases(dentry->d_lock)
 {
 	struct dentry *parent;
 
 	if (!d_is_tail_negative(dentry)) {
 		parent = lock_parent(dentry);
 		if (!parent)
-			return;
+			goto out;
 
 		if (!d_count(dentry) && d_is_negative(dentry) &&
 		    !d_is_tail_negative(dentry)) {
@@ -654,6 +655,8 @@ static void sweep_negative(struct dentry *dentry)
 
 		spin_unlock(&parent->d_lock);
 	}
+out:
+	spin_unlock(&dentry->d_lock);
 }
 
 /*
@@ -922,7 +925,8 @@ void dput(struct dentry *dentry)
 		if (likely(retain_dentry(dentry))) {
 			if (d_is_negative(dentry))
 				sweep_negative(dentry);
-			spin_unlock(&dentry->d_lock);
+			else
+				spin_unlock(&dentry->d_lock);
 			return;
 		}
 
-- 
1.8.3.1

