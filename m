Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0794BD814
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 09:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346600AbiBUH4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 02:56:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiBUH4x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:56:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A372E30A;
        Sun, 20 Feb 2022 23:56:29 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L7IIni028101;
        Mon, 21 Feb 2022 07:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=CCqmkySOc3aBhQz9eC5aaA3YFMYTK/Uy6oCgShKaL44=;
 b=gyIbHuoESQqgCSU3PZKQ0XV8Ww2tquo7yTLfHgVjai1wxLe3USoNDwuW+FxUjlo2VQZo
 JZ96PBlZv1fbcfYdd3ufmbDzEtqhKqpu5O2Y7mhbr6UpU4ezIQJou5uq/ITkHvKizZ9a
 +5krSixlvTMx8IQ0OAxmN8J4AyjlHfkQG/yYe30J0q9yWo57JcVLiwRgMdVYvMdmr6i3
 XZpujSWk9dGn4DLiXptVAUNWihdUcrrBSJ2vInv+h6RYBCz2p7FlSqAph5XshKZBTBBy
 926tQvwwzFoaE/8BTyRnoyRJa/4GL3OCQHFzAPoGcNV+xuVCbibz6BTA25D1QW3FqefQ 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ec67wrm3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 07:56:25 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21L7rkwA016571;
        Mon, 21 Feb 2022 07:56:25 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ec67wrm33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 07:56:25 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21L7iqej028223;
        Mon, 21 Feb 2022 07:56:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3ear68rguq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 07:56:22 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21L7uKwl51053008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 07:56:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BA7D52059;
        Mon, 21 Feb 2022 07:56:20 +0000 (GMT)
Received: from localhost (unknown [9.43.127.119])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EA9E952051;
        Mon, 21 Feb 2022 07:56:19 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 0/1] ext4: Performance scalability improvement with fast_commit
Date:   Mon, 21 Feb 2022 13:26:14 +0530
Message-Id: <cover.1645426817.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _AwPUv_VK4pq1_wQckBdstdVxjUDAHK1
X-Proofpoint-ORIG-GUID: 4FeuvPwH96sfZ8JTn6iSDZ3v4XrX0_4Z
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_02,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=445 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210047
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Please find the v2 of this patchset after addressing review comments from
Harshad.

[RFC/v1]: https://lore.kernel.org/all/cover.1644809996.git.riteshh@linux.ibm.com/

xfstests results(v2)
=====================
This has survived my fstests testing with -g 'auto' group for ext4_4k_fc & ext4_4k
configs with CONFIG_KASAN enabled. I haven't found any regression due to this
patch in my testing.

But to avoid me missing any corner slippery edges of fast_commit feature, a
careful review would really help as always :)


<Original cover letter>
======================
Hello,

I have recently started playing with some filesystem performance scalability testing,
mainly ext4 for now and in this patch it is with fast_commit feature.

While running fs_mark (with -s0 -S5) for scalability runs with fast_commit enabled,
I noticed some heavy contention in ext4_fc_commit() -> ext4_fc_commit_dentry_updates().

Analysis
===========
This is because -
1. To commit all the dentry updates using FC, we first loop in for_each dentry
   entry in sbi->s_fc_dentry_q.
2. Then within that loop, for each of the above fc_dentry nodes, we again loop in
   for_each inode in sbi->s_fc_q. This is to get the corresponding inode entry
   belonging to fc_dentry->fcd_ino.
Second loop above, is mainly done to get corresponding inode so that before
committing dentry updates into FC area, we first write inode data, inode and
then dentry. This turns the whole ext4_fc_commit() path into quadratic time complexity.

This is fine until a multi-threaded application is making the updates to limited no.
of open files and then issuing fsync for each/any of the files.
But as no. of open files (tracked in FC list) increases, we see significant
performance impact with higher no. of open files (see below table for more details).

This RFC patch thus improves the performance of ext4_fc_commit() path by making
it linear time for doing dentry updates (ext4_fc_commit_dentry_updates()).


Observations on perf table results
===================================
If we look at the table below, we start seeing performance problems from row 6th
onwards, where the numbers actually decrease as compared to previous row (row 5).
And then from row 7th onwards the numbers are significantly low. In fact, I was
observing the fs_mark getting completely stuck for quite some time and
progressing very slowly (with params of row 7th onwards).


Observations on perf profile
===============================
Similar observations can be seen in below perf profile which is taken with params of
row-8th. Almost 87% of the time is being wasted in that O(N^2) loop to just find
the right corresponding inode for fc_dentry->fcd_ino.

[Table]: Perf absolute numbers in avg file creates per sec (from fs_mark in 1K order)
=======================================================================
#no. 	Order 		without-patch(K) 	with-patch(K) 		Diff(%)
1	1 		16.90 			17.51 			+3.60
2	2,2 		32.08 			31.80 			-0.87
3	3,3 		53.97 			55.01 			+1.92
4	4,4 		78.94 			76.90 			-2.58
5	5,5 		95.82 			95.37 			-0.46
6	6,6 		87.92 			103.38 			+17.58
7	6,10 		 0.73 			126.13 			+17178.08
8	6,14 		 2.33 			143.19 			+6045.49

Scalability run plots with different directory ways (/ threads) and no. of dirs/file
(w/o patches)
================================================================================

(Avg files/sec x1000) 				'fc_perf.txt' using 3:xtic(2)
  100 +--------------------------------------------------------------------+
      |       +      +       +       +      *       +       +      +       |
   90 |-+                            	    *       *   	         +-|
      |                                     *       *                      |
   80 |-+                            *      *       *                    +-|
      |                              *      *       *                      |
   70 |-+                            *      *       *                    +-|
      |                              *      *       *                      |
   60 |-+                            *      *       *                    +-|
      |                      *       *      *       *                      |
   50 |-+                    *       *      *       *                    +-|
      |                      *       *      *       *                      |
   40 |-+                    *       *      *       *                    +-|
      |                      *       *      *       *                      |
   30 |-+            *       *       *      *       *                    +-|
      |              *       *       *      *       *                      |
   20 |-+            *       *       *      *       *                    +-|
      |       *      *       *       *      *       *                      |
   10 |-+     *      *       *       *      *       *                    +-|
      |       *      *       *       *      *       *       +      +       |
    0 +--------------------------------------------------------------------+
             1,1     2,2     3,3     4,4    5,5     6,6    6,10   6,14 (order,dir & files)

	^^^^ extremely poor numbers at higher X values (w/o patch)

X-axis: 2^order dir ways, 2^dir & 2^files.
	For e.g. with x coordinate of 6,10 (2^6 == 64 && 2^10 == 1024)
	echo /run/riteshh/mnt/{1..64} |sed -E 's/[[:space:]]+/ -d /g' | xargs -I {} bash -c "sudo fs_mark -L 100 -D 1024 -n 1024 -s0 -S5 -d {}"

Y-axis: Avg files per sec (x1000).
	For e.g. a y coordinate of 100 represent 100K avg file creates per sec. with fs_mark


Perf profile
(w/o patches)
=============================
87.15%  [kernel]  [k] ext4_fc_commit 			--> Heavy contention/bottleneck
 1.98%  [kernel]  [k] perf_event_interrupt
 0.96%  [kernel]  [k] power_pmu_enable
 0.91%  [kernel]  [k] update_sd_lb_stats.constprop.0
 0.67%  [kernel]  [k] ktime_get


Scalability run plots with different directory ways (/ threads) and no. of dirs/file
(with patch)
================================================================================
(Avg files/sec x1000)
  160 +--------------------------------------------------------------------+
      |       +      +       +       +      +       +       +      +       |
  140 |-+                            'fc_perf.txt' using 4:xtic(2) *     +-|
      |                                                            *       |
      |                                                     *      *       |
  120 |-+                                                   *      *     +-|
      |                                                     *      *       |
  100 |-+                                           *       *      *     +-|
      |                                     *       *       *      *       |
      |                                     *       *       *      *       |
   80 |-+                            *      *       *       *      *     +-|
      |                              *      *       *       *      *       |
   60 |-+                            *      *       *       *      *     +-|
      |                      *       *      *       *       *      *       |
      |                      *       *      *       *       *      *       |
   40 |-+                    *       *      *       *       *      *     +-|
      |              *       *       *      *       *       *      *       |
   20 |-+            *       *       *      *       *       *      *     +-|
      |       *      *       *       *      *       *       *      *       |
      |       *      *       *       *      *       *       *      *       |
    0 +--------------------------------------------------------------------+
            1,1     2,2     3,3     4,4    5,5     6,6    6,10   6,14 (order, dir & files)

	^^^^ Shows linear scaling with this patch ;)

Perf profile
(with patch)
===========================
21.41%  [kernel]     [k] snooze_loop
18.67%  [kernel]     [k] _raw_spin_lock
12.34%  [kernel]     [k] _raw_spin_lock_irq
 5.02%  [kernel]     [k] update_sd_lb_stats.constprop.0
 1.91%  libc-2.31.so [.] __random
 1.85%  [kernel]     [k] _find_next_bit


xfstests results
==================
This has survived my fstests testing with -g log,metadata,auto group.
(CONFIG_KASAN disabled). I haven't found any regression due to this patch in my testing.

But to avoid me missing any corner slippery edges of fast_commit feature, a careful
review would really help as always :)

[Fast-commit]: https://lwn.net/Articles/842385/

Ritesh Harjani (1):
  ext4: Improve fast_commit performance and scalability

 fs/ext4/ext4.h        |  2 ++
 fs/ext4/fast_commit.c | 74 ++++++++++++++++++++++++++++++++-----------
 fs/ext4/fast_commit.h |  1 +
 3 files changed, 59 insertions(+), 18 deletions(-)

--
2.31.1

