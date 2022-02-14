Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D934B5D6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 23:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiBNWLw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 17:11:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiBNWLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:11:51 -0500
X-Greylist: delayed 3597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 14:11:42 PST
Received: from slate.cs.rochester.edu (slate.cs.rochester.edu [128.151.167.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1082EB820A;
        Mon, 14 Feb 2022 14:11:41 -0800 (PST)
Received: from node1x10a.cs.rochester.edu (node1x10a.cs.rochester.edu [192.5.53.74])
        by slate.cs.rochester.edu (8.14.7/8.14.7) with ESMTP id 21ELAx5P010783
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Feb 2022 16:10:59 -0500
Received: from node1x10a.cs.rochester.edu (localhost [127.0.0.1])
        by node1x10a.cs.rochester.edu (8.15.2/8.15.1) with ESMTP id 21ELAxL3031113;
        Mon, 14 Feb 2022 16:10:59 -0500
Received: (from szhai2@localhost)
        by node1x10a.cs.rochester.edu (8.15.2/8.15.1/Submit) id 21ELAuk4031106;
        Mon, 14 Feb 2022 16:10:56 -0500
From:   Shuang Zhai <szhai2@cs.rochester.edu>
To:     mgorman@techsingularity.net
Cc:     akpm@linux-foundation.org, djwong@kernel.org, efault@gmx.de,
        hakavlad@inbox.lv, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        regressions@lists.linux.dev, riel@surriel.com, vbabka@suse.cz
Subject: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to make progress
Date:   Mon, 14 Feb 2022 16:10:50 -0500
Message-Id: <20220214211050.31049-1-szhai2@cs.rochester.edu>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20211202150614.22440-1-mgorman@techsingularity.net>
References: <20211202150614.22440-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mel,

Mel Gorman wrote:
>
> Mike Galbraith, Alexey Avramov and Darrick Wong all reported similar
> problems due to reclaim throttling for excessive lengths of time.
> In Alexey's case, a memory hog that should go OOM quickly stalls for
> several minutes before stalling. In Mike and Darrick's cases, a small
> memcg environment stalled excessively even though the system had enough
> memory overall.
>

I recently found a regression when I tested MGLRU with fio on Linux
5.16-rc6 [1]. After this patch was applied, I re-ran the test with Linux
5.16, but the regression has not been fixed yet. 

The workload is to let fio perform random access on files with buffered
IO. The total file size is 2x the memory size. Files are stored on pmem.
For each configuration, I ran fio 10 times and reported the average and
the standard deviation.

Fio command
===========

$ numactl --cpubind=0 --membind=0 fio --name=randread \
  --directory=/mnt/pmem/ --size={10G, 5G} --io_size=1000TB \
  --time_based --numjobs={40, 80} --ioengine=io_uring \
  --ramp_time=20m --runtime=10m --iodepth=128 \
  --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
  --rw=randread --random_distribution=random \
  --direct=0 --norandommap --group_reporting

Results in throughput (MB/s):
=============================

+------------+------+-------+------+-------+----------+-------+
| Jobs / CPU | 5.15 | stdev | 5.16 | stdev | 5.17-rc3 | stdev |
+------------+------+-------+------+-------+----------+-------+
| 1          | 8411 | 75    | 7459 | 38    | 7331     | 36    |
+------------+------+-------+------+-------+----------+-------+
| 2          | 8417 | 54    | 7491 | 41    | 7383     | 15    |
+------------+------+-------+------+-------+----------+-------+

[1] https://lore.kernel.org/linux-mm/20220105024423.26409-1-szhai2@cs.rochester.edu/

Thanks!

Shuang
