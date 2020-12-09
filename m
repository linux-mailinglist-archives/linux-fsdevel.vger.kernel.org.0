Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6972D4E71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 00:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgLIXCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 18:02:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46916 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgLIXCP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:02:15 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9MxajI033824;
        Wed, 9 Dec 2020 23:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9QWI+7ihNGdD7szLffSO2nbJojU6tCKTKIyvT3UlYJY=;
 b=w3Rb5q0a6A2pRfpm1JhIid6JF+K3D7l16Y19wsU470CQvsK0Qej7JFs22cYEKbjufTTM
 4nn7B3wr3xkZI0ecYpKfC2WmpRRz3ZOlSJ/JrUnaoilDChvvQYZqD4AJRGrYDeTo1KjC
 NasdBY1Fq+8h7pX8IyibzFlo8UUcH9yov71xnv4A8t6UVLjoOvXi5gy0ycMmiZTflHH+
 IUK9b85H0AsfNCx94Ht1oskI6aJZqznMY5LRFhpeK3xR4w0DPmJNhAPs6G3UYqfWhQkK
 PwYI/2WHdg42aP618D+gvniKvF45SUFp38N9wyOS9qvM3b7t/tAm40JqZsu9LMRO71St +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 357yqc2vsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 23:01:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9N0qxB095436;
        Wed, 9 Dec 2020 23:01:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 358ksqsjp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 23:01:27 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B9N1OXf020270;
        Wed, 9 Dec 2020 23:01:25 GMT
Received: from dhcp-10-159-152-235.vpn.oracle.com (/10.159.152.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Dec 2020 15:01:24 -0800
Subject: Re: [PATCH RFC 0/8] dcache: increase poison resistance
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Waiman Long <longman@redhat.com>,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        matthew.wilcox@oracle.com
References: <158893941613.200862.4094521350329937435.stgit@buzz>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <97ece625-2799-7ae6-28b5-73c52c7c497b@oracle.com>
Date:   Wed, 9 Dec 2020 15:01:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <158893941613.200862.4094521350329937435.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=3
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxlogscore=999
 clxscore=1011 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090158
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Konstantin,

We tested this patch set recently and found it limiting negative dentry 
to a small part of total memory. And also we don't see any performance 
regression on it. Do you have any plan to integrate it into mainline? It 
will help a lot on memory fragmentation issue causing by dentry slab, 
there were a lot of customer cases where sys% was very high since most 
cpu were doing memory compaction, dentry slab was taking too much memory 
and nearly all dentry there were negative.

The following is test result we run on two types of servers, one is 256G 
memory with 24 CPUS and another is 3T memory with 384 CPUS. The test 
case is using a lot of processes to generate negative dentry in 
parallel, the following is the test result after 72 hours, the negative 
dentry number is stable around that number even running longer time. If 
without the patch set, in less than half an hour 197G was took by 
negative dentry on 256G system, in 1 day 2.4T was took on 3T system.

                 neg-dentry-number        neg-dentry-mem-usage

256G 55259084 10.6G

3T 202306756 38.8G

For perf test, we run the following, and no regression found.

- create 1M negative dentry and then touch them to convert them to 
positive dentry

- create 10K/100K/1M files

- remove 10K/100K/1M files

- kernel compile

To verify the fsnotify fix, we used inotifywait to watch file 
create/open in some directory where there is a lot of negative dentry, 
without the patch set, the system will run into soft lockup, with it, no 
soft lockup.

We also try to defeat the limitation by making different processes 
generating negative dentry with the same naming way, that will make one 
negative dentry being accessed couple times around same time, 
DCACHE_REFERENCED will be set on it and then it can't be trimmed easily. 
We do see negative dentry will take all the memory slowly from one of 
our system with 120G memory, for above two system, we see the memory 
usage were increased, but still a small part of total memory. This looks 
ok, since the common negative dentry user case will be create some temp 
files and then remove it, it will be rare to access same negative dentry 
around same time.

Thanks,

Junxiao.


On 5/8/20 5:23 AM, Konstantin Khlebnikov wrote:
> For most filesystems result of every negative lookup is cached, content of
> directories is usually cached too. Production of negative dentries isn't
> limited with disk speed. It's really easy to generate millions of them if
> system has enough memory.
>
> Getting this memory back ins't that easy because slab frees pages only when
> all related objects are gone. While dcache shrinker works in LRU order.
>
> Typical scenario is an idle system where some process periodically creates
> temporary files and removes them. After some time, memory will be filled
> with negative dentries for these random file names.
>
> Simple lookup of random names also generates negative dentries very fast.
> Constant flow of such negative denries drains all other inactive caches.
>
> Negative dentries are linked into siblings list along with normal positive
> dentries. Some operations walks dcache tree but looks only for positive
> dentries: most important is fsnotify/inotify. Hordes of negative dentries
> slow down these operations significantly.
>
> Time of dentry lookup is usually unaffected because hash table grows along
> with size of memory. Unless somebody especially crafts hash collisions.
>
> This patch set solves all of these problems:
>
> Move negative denries to the end of sliblings list, thus walkers could
> skip them at first sight (patches 3-6).
>
> Keep in dcache at most three unreferenced negative denties in row in each
> hash bucket (patches 7-8).
>
> ---
>
> Konstantin Khlebnikov (8):
>        dcache: show count of hash buckets in sysctl fs.dentry-state
>        selftests: add stress testing tool for dcache
>        dcache: sweep cached negative dentries to the end of list of siblings
>        fsnotify: stop walking child dentries if remaining tail is negative
>        dcache: add action D_WALK_SKIP_SIBLINGS to d_walk()
>        dcache: stop walking siblings if remaining dentries all negative
>        dcache: push releasing dentry lock into sweep_negative
>        dcache: prevent flooding with negative dentries
>
>
>   fs/dcache.c                                   | 144 +++++++++++-
>   fs/libfs.c                                    |  10 +-
>   fs/notify/fsnotify.c                          |   6 +-
>   include/linux/dcache.h                        |   6 +
>   tools/testing/selftests/filesystems/Makefile  |   1 +
>   .../selftests/filesystems/dcache_stress.c     | 210 ++++++++++++++++++
>   6 files changed, 370 insertions(+), 7 deletions(-)
>   create mode 100644 tools/testing/selftests/filesystems/dcache_stress.c
>
> --
> Signature
