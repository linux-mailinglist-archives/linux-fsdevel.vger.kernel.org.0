Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304152FEEC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbhAUPaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:30:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47080 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbhAUNWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:22:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDEq8m095432;
        Thu, 21 Jan 2021 13:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=QBObwOkC+BCQ8yX5EsfVIOGtrp1YnjhtZHLKG9PfSg8=;
 b=ZLX20WzQQ/bo7PLkOdw15YtVaBo7IiJKDMmC2uFMUemQwoBdEE/5cIYQijHL0FmAaxdm
 wmmSLdDxID++3AVb28cgltLX62yIhusODAt98dB+0Ix/Mvmytq6P03KaarmV8pVshsP6
 J8l9Hrxxz6r5i6TYX9VHM1EEj0Jciy6/QUFsO2Z9yPU35wv9eDAt0O7Rq0NsG3UzQoy6
 89j1QUSK+z42B4eQVoOIsZUZgrlgpxI+nACcDa68BgxSXhR2mAbsEMqWlLAp1i63aVbg
 KPigXqfCiMGR5ZoPPp5b3+MsEv2C9YYRY6cV6ND1f+o8zddwCltPyxeSajmnbRK1gdms IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 3668qrf9qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:21:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDFkUG106713;
        Thu, 21 Jan 2021 13:21:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3668rexrf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:21:28 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10LDKZJJ123118;
        Thu, 21 Jan 2021 13:21:28 GMT
Received: from gmananth-linux.oraclecorp.com (dhcp-10-166-171-141.vpn.oracle.com [10.166.171.141])
        by userp3030.oracle.com with ESMTP id 3668rexq88-7;
        Thu, 21 Jan 2021 13:21:28 +0000
From:   Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     viro@zeniv.linux.org.uk, matthew.wilcox@oracle.com,
        khlebnikov@yandex-team.ru, gautham.ananthakrishna@oracle.com
Subject: [PATCH RFC 6/6] dcache: prevent flooding with negative dentries
Date:   Thu, 21 Jan 2021 18:49:45 +0530
Message-Id: <1611235185-1685-7-git-send-email-gautham.ananthakrishna@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
References: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=321 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210072
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Without memory pressure count of negative dentries isn't bounded.
They could consume all memory and drain all other inactive caches.

Typical scenario is an idle system where some process periodically creates
temporary files and removes them. After some time, memory will be filled
with negative dentries for these random file names. Reclaiming them took
some time because slab frees pages only when all related objects are gone.
Time of dentry lookup is usually unaffected because hash table grows along
with size of memory. Unless somebody especially crafts hash collisions.
Simple lookup of random names also generates negative dentries very fast.

This patch implements heuristic which detects such scenarios and prevents
unbounded growth of completely unneeded negative dentries. It keeps up to
three latest negative dentry in each bucket unless they were referenced.

At first dput of negative dentry when it swept to the tail of siblings
we'll also clear it's reference flag and look at next dentries in chain.
Then kill third in series of negative, unused and unreferenced denries.

This way each hash bucket will preserve three negative dentry to let them
get reference and survive. Adding positive or used dentry into hash chain
also protects few recent negative dentries. In result total size of dcache
asymptotically limited by count of buckets and positive or used dentries.

Before patch: tool 'dcache_stress' could fill entire memory with dentries.

nr_dentry = 104913261   104.9M
nr_buckets = 8388608    12.5 avg
nr_unused = 104898729   100.0%
nr_negative = 104883218 100.0%

After this patch count of dentries saturates at around 3 per bucket:

nr_dentry = 24619259    24.6M
nr_buckets = 8388608    2.9 avg
nr_unused = 24605226    99.9%
nr_negative = 24600351  99.9%

This heuristic isn't bulletproof and solves only most practical case.
It's easy to deceive: just touch same random name twice.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
---
 fs/dcache.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 22c990b..6281938 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -633,6 +633,58 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
 }
 
 /*
+ * Called at first dput of each negative dentry.
+ * Prevents filling cache with never reused negative dentries.
+ *
+ * This clears reference and then looks at following dentries in hash chain.
+ * If they are negative, unused and unreferenced then keep two and kill third.
+ */
+static void trim_negative(struct dentry *dentry)
+	__releases(dentry->d_lock)
+{
+	struct dentry *victim, *parent;
+	struct hlist_bl_node *next;
+	int keep = 2;
+
+	rcu_read_lock();
+
+	dentry->d_flags &= ~DCACHE_REFERENCED;
+	spin_unlock(&dentry->d_lock);
+
+	next = rcu_dereference_raw(dentry->d_hash.next);
+	while (1) {
+		victim = hlist_bl_entry(next, struct dentry, d_hash);
+
+		if (!next || d_count(victim) || !d_is_negative(victim) ||
+		    (victim->d_flags & DCACHE_REFERENCED)) {
+			rcu_read_unlock();
+			return;
+		}
+
+		if (!keep--)
+			break;
+
+		next = rcu_dereference_raw(next->next);
+	}
+
+	spin_lock(&victim->d_lock);
+	parent = lock_parent(victim);
+
+	rcu_read_unlock();
+
+	if (d_count(victim) || !d_is_negative(victim) ||
+	    (victim->d_flags & DCACHE_REFERENCED)) {
+		if (parent)
+			spin_unlock(&parent->d_lock);
+		spin_unlock(&victim->d_lock);
+		return;
+	}
+
+	__dentry_kill(victim);
+	dput(parent);
+}
+
+/*
  * Move cached negative dentry to the tail of parent->d_subdirs.
  * This lets walkers skip them all together at first sight.
  * Must be called at dput of negative dentry.
@@ -654,6 +706,8 @@ static void sweep_negative(struct dentry *dentry)
 		}
 
 		spin_unlock(&parent->d_lock);
+
+		return trim_negative(dentry);
 	}
 out:
 	spin_unlock(&dentry->d_lock);
-- 
1.8.3.1

