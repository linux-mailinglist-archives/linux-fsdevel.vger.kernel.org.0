Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874E12FEF53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbhAUPo2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:44:28 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40314 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbhAUNVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:21:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDEIqj072777;
        Thu, 21 Jan 2021 13:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=1ICsrqapL3ySfipx1CqkUwjx8sVX170UdxFWoaZRPKg=;
 b=Dwf3AeNzs9pJLPymom3kFuVhbJLNe5LImJzpT7QXc0tv6KrL8rA8Cx9eIEP+jEx9ZwPG
 wv3N0N2+0HFu3L+GPrp62abNO+x5sN7Y3dQKeJgGWU9YvFt9LwIaMRCoYo548czWd4w2
 X8bBAlZ4zjAhPc50vV6vSwvdUb+kBztFYpAJgs2GM46neQhTkJ1UIXCjNcYzokMn/wEY
 KtKX+p7CeAiDOZ1kps+eqfEXNfxWn9hcrw+wRArNywZM2T8HukVf9N9+5vSp350jPifP
 DZc74YmzA1ti6Pz3k/h7WImUWSedNaz9VB9Ls5+APQBNpUxQuZMZ+SpwpFpp88kG0bwU qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3668qmy8xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:20:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDFj0K106656;
        Thu, 21 Jan 2021 13:20:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3668rexqa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:20:35 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10LDKZJ7123118;
        Thu, 21 Jan 2021 13:20:35 GMT
Received: from gmananth-linux.oraclecorp.com (dhcp-10-166-171-141.vpn.oracle.com [10.166.171.141])
        by userp3030.oracle.com with ESMTP id 3668rexq88-1;
        Thu, 21 Jan 2021 13:20:35 +0000
From:   Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     viro@zeniv.linux.org.uk, matthew.wilcox@oracle.com,
        khlebnikov@yandex-team.ru, gautham.ananthakrishna@oracle.com
Subject: [PATCH RFC 0/6] fix the negative dentres bloating system memory usage
Date:   Thu, 21 Jan 2021 18:49:39 +0530
Message-Id: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210072
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For most filesystems result of every negative lookup is cached, content of
directories is usually cached too. Production of negative dentries isn't
limited with disk speed. It's really easy to generate millions of them if
system has enough memory.

Getting this memory back ins't that easy because slab frees pages only when
all related objects are gone. While dcache shrinker works in LRU order.

Typical scenario is an idle system where some process periodically creates
temporary files and removes them. After some time, memory will be filled
with negative dentries for these random file names.

Simple lookup of random names also generates negative dentries very fast.
Constant flow of such negative denries drains all other inactive caches.
Too many negative dentries in the system can cause memory fragmentation
and memory compaction.

Negative dentries are linked into siblings list along with normal positive
dentries. Some operations walks dcache tree but looks only for positive
dentries: most important is fsnotify/inotify. Hordes of negative dentries
slow down these operations significantly.

Time of dentry lookup is usually unaffected because hash table grows along
with size of memory. Unless somebody especially crafts hash collisions.

This patch set solves all of these problems:

Move negative denries to the end of sliblings list, thus walkers could
skip them at first sight (patches 1-4).

Keep in dcache at most three unreferenced negative denties in row in each
hash bucket (patches 5-6).

We tested this patch set recently and found it limiting negative dentry to a
small part of total memory. The following is the test result we ran on two
types of servers, one is 256G memory with 24 CPUS and another is 3T memory
with 384 CPUS. The test case is using a lot of processes to generate negative
dentry in parallel, the following is the test result after 72 hours, the
negative dentry number is stable around that number even after running longer
for much longer time. Without the patch set, in less than half an hour 197G was
taken by negative dentry on 256G system, in 1 day 2.4T was taken on 3T system.

system memory   neg-dentry-number   neg-dentry-mem-usage
256G            55259084            10.6G
3T              202306756           38.8G

For perf test, we ran the following, and no regression found.

1. create 1M negative dentry and then touch them to convert them to positive
   dentry

2. create 10K/100K/1M files

3. remove 10K/100K/1M files

4. kernel compile

To verify the fsnotify fix, we used inotifywait to watch file create/open in
some directory where there is a lot of negative dentry, without the patch set,
the system would run into soft lockup, with it, no soft lockup was found.

We also tried to defeat the limitation by making different processes generate
negative dentry with the same name, that will make one negative dentry being
accessed couple times around same time, DCACHE_REFERENCED will be set on it
and it can't be trimmed easily.

There were a lot of customer cases on this issue. It makes no sense to leave
so many negative dentry, it just causes memory fragmentation and compaction
and does not help a lot.

Konstantin Khlebnikov (6):
  dcache: sweep cached negative dentries to the end of list of siblings
  fsnotify: stop walking child dentries if remaining tail is negative
  dcache: add action D_WALK_SKIP_SIBLINGS to d_walk()
  dcache: stop walking siblings if remaining dentries all negative
  dcache: push releasing dentry lock into sweep_negative
  dcache: prevent flooding with negative dentries

 fs/dcache.c            | 135 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/libfs.c             |   3 ++
 fs/notify/fsnotify.c   |   6 ++-
 include/linux/dcache.h |   6 +++
 4 files changed, 145 insertions(+), 5 deletions(-)

-- 
1.8.3.1

