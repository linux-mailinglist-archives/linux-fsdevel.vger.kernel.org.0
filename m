Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF53A0A92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 05:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhFIDY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 23:24:56 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:19048 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233222AbhFIDYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:24:55 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1593N0Tu020883;
        Tue, 8 Jun 2021 20:23:00 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-0064b401.pphosted.com with ESMTP id 392htwg5cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 20:23:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKqVa/PSkoMazAdiyQG6cR6NeLVlLr9M8DiqFed4UKte9xVGDz0VlAVIeKwVW6yOS0DAEpKfvjVt2E1Fc4s+cvsi16dEoJGd1I3g/G/ebiBB7FVReUauyix/rFg9n0V1jlwzUhocB0A7dj8mKauY8B31Co8iEevBrh4dCx+prNiax0npdpkwnJ8jLID9br3sigx6W44okIjKSnHhCqrNs1l+JIYm11wenwnS3ZMnGkwPTpyoryKZ2UhOdxKU53mWYGhCzQanNfmoZyDxRqXRl7R6dWuccqh65wYpET4anTwK9yBYLZOzwatuj4woF0PiXh1iiX0mGD6KhCGwrc7vKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umICI1y9ixy/dRvlhACieiLqNcjpRVE8FpHpuQt2O/s=;
 b=nF3/x+E3mmexdZO/6NjHRt6EApFMDtrl7Ke5FEmLcpEwCjybCyl4ZLWcwblQoBoFOLF7ndkLbvW2HQ0dubaXgKRZbk+G6E7l82R1+g13jjihGLo9Jw5QrQHWIWXWDVmLY8jp4tM9IPy07ZiKnCfUT2r4r2iOinwPcmvYGuQJHUG+iAPXlD05Q44kxWkEES3P07KXZiKK4iB8e8m01tNagXFKd/zS1s30ZnSi6vnuwQv+w2ZwWbJQTLc+ssVRIqWfBU2Z5trk8GpfdfnDnkECVQ5BfNV8YQfCvyTcRS/l9+rxqPaA3pgr/Dyb9TM5TIoYuFH6aoB4nvSZ5GkwR5d33Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umICI1y9ixy/dRvlhACieiLqNcjpRVE8FpHpuQt2O/s=;
 b=gf6K90MMrjcuBES+l9Ia1FfvRwVnoyCHlYi3Tl9NILkKZIJY5eFbBA1HYFsOOQxh+sXw/uB2AUOM86MVpWu3LQgRm358S6t2cQmSUVqfJ1x0AhCBnB4HTFxJN/dcTJszamh6wiTGVW3YQkKMu87tG0FyR0QOdVoB7qeG6DcWG2I=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM5PR1101MB2268.namprd11.prod.outlook.com (2603:10b6:4:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 9 Jun
 2021 03:22:57 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18%7]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 03:22:57 +0000
From:   qiang.zhang@windriver.com
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] eventfd: convert global percpu eventfd_wake_count to ctx percpu eventfd_wake_count
Date:   Wed,  9 Jun 2021 11:23:14 +0800
Message-Id: <20210609032314.27232-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To DM6PR11MB4202.namprd11.prod.outlook.com
 (2603:10b6:5:1df::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by SJ0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:33b::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.11 via Frontend Transport; Wed, 9 Jun 2021 03:22:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e07853b3-de86-43f2-e9da-08d92af5e094
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2268:
X-Microsoft-Antispam-PRVS: <DM5PR1101MB2268978CC3042F0E1CCB2558FF369@DM5PR1101MB2268.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: na5A4DToiSqk+YWLL57qaV866qmeewDD0yyNDa15LZ227K+yMdk85XYWU7L8necXXDvzxspbBAAEN635Y6IHD0J18QVA+zvT+vaBKNnRJda3tW3C8o9ERWC1hCYpaS2MPES2MkCdfbpqoZbd5bnf6t+GU+CwymHk5zwF4OhamhEuRbuiiqrMtW5UrDBYjY0T53jZxwfHzDwMmJ88miSb3agntBiHV1Q4HzL/b3uf8VpMIwcUxWgsp9VOAfeDPK+JwuZWipNnodYzuZ/ZUcr+VL1Uh3diLewAXVGl6GHRoSe8pkuzC60uoeDlpT0c0mrE6QS/7tqNNjkaxyNr0ic7+OXEKm7xpufePIVWvv0cjvC6jjXAkbbB1n5QRC/FGV3pdr6LvVvDfkF57FBTaOzcwUJfAJMYw+SafhubZofAz6fvsc8NkaR35yeILsbpFO1RD+/qKhWfihE0TCPBj+h4xu47BPyVEw8DF2t87f5xwgdmkaKFfRRcUSSESLso8Rex+FIJBMjo4bAVZqT2cztSLGqeBMJ+fnfcSNGgxb12rJ8WyHHjr4lz77WX8DtUshE/EAmi/JwJI0o5km+TW1iK/nJajEBgIP2iRVZjbpq8oJDd5n/E37V8TWGRLPC0QMPk2ru5T5rbci7pCB8xIQ5DCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(396003)(366004)(136003)(346002)(36756003)(6666004)(9686003)(66476007)(8936002)(4326008)(26005)(8676002)(66556008)(38350700002)(186003)(38100700002)(5660300002)(83380400001)(16526019)(1076003)(66946007)(316002)(6506007)(956004)(6512007)(86362001)(6486002)(2906002)(2616005)(478600001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dG3o7cRqxak7q33SnzMhUmxkFGXlLCGjHPovYcXemxMTmGEFHQyQqyWbpheI?=
 =?us-ascii?Q?US51LPOfnikERBiJbQDquSt63H5m0NbBqvwLsEwtizM+tBKTs4lN9IwgT5KC?=
 =?us-ascii?Q?YHaNZ63wSqd3lbTeAJkGhYbcYLehHF30DU//kr/sgNMD2xJaZo2lc24k82GK?=
 =?us-ascii?Q?hP0Wi61mWClsr97DZ0F3U3DNvZxCVau6VNlj/7ZwmDl0Qs6ub8ZX7FnTWhZL?=
 =?us-ascii?Q?hI3+8RyUum5ibr2xGEgmOAR31DJt8Upx4UqTqS3O2/P311POiqJfqJo6q945?=
 =?us-ascii?Q?p5T8wFUZZtbWQ+MTSWBhkMYiKgo7nduDSCwP22Ni5hL+3XMCsohZm93MEivf?=
 =?us-ascii?Q?ZhNHhNL6wO5BxfMpLNRUD6OqZfU3W1JSgt+8fkRZDdZTjY/yDQGgJPnI1MNH?=
 =?us-ascii?Q?H/VCPs4RXzdtv0Nz/XzkqZ8YlUUqskyk3cqThnbuFOpeYGQ6y3nMWxfPKkl6?=
 =?us-ascii?Q?ZDxJ6YFYilWXce+idFFEwRWpVoklTTDw2WHrwQpBfG2upYVLbG/2zvJaa0H0?=
 =?us-ascii?Q?+qCqcpEKRskpVlGw96feWSEqmZ/HO/9eExur3Sr47xnQTBWy4fQ9QqKglW7b?=
 =?us-ascii?Q?ik3ERnRjnFdMjpCwIPhvltTusa2usk2osQ4N3bxq1pAWcEgk9AuhPOsI/dv6?=
 =?us-ascii?Q?zWstjcueCuAQt2c2bkyo1Ijc1uhQ2/KCQirPxJgMERQucHDOUJvyJuXq+iUl?=
 =?us-ascii?Q?5a7/pjRLFcHIE6znpKpPIzl6/4Fer2kszfcpzI+2uvRVLoLxv4Sjaa+3akBQ?=
 =?us-ascii?Q?gQUvekmA4Vpgh3S9NBkMElaCW0zGmDszCAR/Z+V1G2l60SJZqDnGs68Wb6mY?=
 =?us-ascii?Q?WJrBH0+xR2gVm80dEEXiyi6MXWMlTEkEl3NLy4Sag7IVnT0n6Zqqm74TmWeD?=
 =?us-ascii?Q?4A/K4g9oNel8ci5aHZX2ITCaDOGfSLqhAlSGsRs5ilwlSxjvo+JDcF/lqw6m?=
 =?us-ascii?Q?jvrYl6ahyRWV6DtBjjooLPOodobKj0gLsOQwhVyK3S9FobgtDWfp8KrF3uju?=
 =?us-ascii?Q?8ZEmsBMXmYEEMb3hOZ3Ca2YtAlWwx9Al1QI+V+B/za6nYFlkNVCTSrv4Kjn5?=
 =?us-ascii?Q?DCgWxxJOwPmfklwwHsYfnePAKhA+f92ff2AUwRMy9wgT3j8BdNDHMn06uCCM?=
 =?us-ascii?Q?YCiV9NxGUzxd+8M3CMYY6gSOlUMxLuk3iloOGMI+iVr/3j8zKeMPGQ0hL6Y3?=
 =?us-ascii?Q?SDHJxqsNFnTpR9hKotxcFqvn83xxEyCNB+Ur0uBrw1zwutYmfD5vQeHDgTY8?=
 =?us-ascii?Q?8Q2vM36SvNy6i14UY2HM8U+bnzXSN8/StPvW7LBSjRcp32n83GTqtMofP1/E?=
 =?us-ascii?Q?xZB12Hh5nmEOHQk2l8qQVoew?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07853b3-de86-43f2-e9da-08d92af5e094
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 03:22:57.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd5kQoiAJrAzFbUhfcXoFEQmZn3Ww1xy7wjTrmgNjLpiDfSnLKBoKK43yE031TdGHVH2KIQup6E6rCAGCp56FJe+fFGQGR85/42RBpM9NLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2268
X-Proofpoint-GUID: MHsqZpVV0thSF_XuZFyY7sgfCpOYyOK2
X-Proofpoint-ORIG-GUID: MHsqZpVV0thSF_XuZFyY7sgfCpOYyOK2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_17:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090001
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

In RT system, the spinlock_irq be replaced by rt_mutex, when
call eventfd_signal(), if the current task is preempted after
increasing the current CPU eventfd_wake_count, when other task
run on this CPU and  call eventfd_signal(), find this CPU
eventfd_wake_count is not zero, will trigger warning and direct
return, miss wakeup.

RIP: 0010:eventfd_signal+0x85/0xa0
vhost_add_used_and_signal_n+0x41/0x50 [vhost]
handle_rx+0xb9/0x9e0 [vhost_net]
handle_rx_net+0x15/0x20 [vhost_net]
vhost_worker+0x95/0xe0 [vhost]
kthread+0x19c/0x1c0
ret_from_fork+0x22/0x30

In no-RT system, even if the eventfd_signal() call is nested, if
if it's different eventfd_ctx object, it is not happen deadlock.

Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 v1->v2:
 Modify submission information. 

 fs/aio.c                |  2 +-
 fs/eventfd.c            | 30 ++++++++++--------------------
 include/linux/eventfd.h | 25 ++++++++++++++++++++-----
 3 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 76ce0cc3ee4e..b45983d5d35a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
 		req->done = true;
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
+		if (iocb->ki_eventfd && eventfd_signal_count(iocb->ki_eventfd)) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6dd4f34..b1df2c5720a7 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -25,26 +25,9 @@
 #include <linux/idr.h>
 #include <linux/uio.h>
 
-DEFINE_PER_CPU(int, eventfd_wake_count);
 
 static DEFINE_IDA(eventfd_ida);
 
-struct eventfd_ctx {
-	struct kref kref;
-	wait_queue_head_t wqh;
-	/*
-	 * Every time that a write(2) is performed on an eventfd, the
-	 * value of the __u64 being written is added to "count" and a
-	 * wakeup is performed on "wqh". A read(2) will return the "count"
-	 * value to userspace, and will reset "count" to zero. The kernel
-	 * side eventfd_signal() also, adds to the "count" counter and
-	 * issue a wakeup.
-	 */
-	__u64 count;
-	unsigned int flags;
-	int id;
-};
-
 /**
  * eventfd_signal - Adds @n to the eventfd counter.
  * @ctx: [in] Pointer to the eventfd context.
@@ -71,17 +54,17 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * it returns true, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	if (WARN_ON_ONCE(this_cpu_read(*ctx->eventfd_wake_count)))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	this_cpu_inc(eventfd_wake_count);
+	this_cpu_inc(*ctx->eventfd_wake_count);
 	if (ULLONG_MAX - ctx->count < n)
 		n = ULLONG_MAX - ctx->count;
 	ctx->count += n;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-	this_cpu_dec(eventfd_wake_count);
+	this_cpu_dec(*ctx->eventfd_wake_count);
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 
 	return n;
@@ -92,6 +75,9 @@ static void eventfd_free_ctx(struct eventfd_ctx *ctx)
 {
 	if (ctx->id >= 0)
 		ida_simple_remove(&eventfd_ida, ctx->id);
+
+	if (ctx->eventfd_wake_count)
+		free_percpu(ctx->eventfd_wake_count);
 	kfree(ctx);
 }
 
@@ -421,6 +407,10 @@ static int do_eventfd(unsigned int count, int flags)
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->eventfd_wake_count = alloc_percpu(int);
+	if (!ctx->eventfd_wake_count)
+		goto err;
+
 	kref_init(&ctx->kref);
 	init_waitqueue_head(&ctx->wqh);
 	ctx->count = count;
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index fa0a524baed0..7288328bdbc8 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -29,11 +29,27 @@
 #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
 
-struct eventfd_ctx;
 struct file;
 
 #ifdef CONFIG_EVENTFD
 
+struct eventfd_ctx {
+	struct kref kref;
+	wait_queue_head_t wqh;
+       /*
+	* Every time that a write(2) is performed on an eventfd, the
+	* value of the __u64 being written is added to "count" and a
+	* wakeup is performed on "wqh". A read(2) will return the "count"
+	* value to userspace, and will reset "count" to zero. The kernel
+	* side eventfd_signal() also, adds to the "count" counter and
+	* issue a wakeup.
+	*/
+	__u64 count;
+	unsigned int flags;
+	int id;
+	int __percpu *eventfd_wake_count;
+};
+
 void eventfd_ctx_put(struct eventfd_ctx *ctx);
 struct file *eventfd_fget(int fd);
 struct eventfd_ctx *eventfd_ctx_fdget(int fd);
@@ -43,11 +59,10 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *w
 				  __u64 *cnt);
 void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
 
-DECLARE_PER_CPU(int, eventfd_wake_count);
 
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_count(struct eventfd_ctx *ctx)
 {
-	return this_cpu_read(eventfd_wake_count);
+	return this_cpu_read(*ctx->eventfd_wake_count);
 }
 
 #else /* CONFIG_EVENTFD */
@@ -78,7 +93,7 @@ static inline int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx,
 	return -ENOSYS;
 }
 
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_count(struct eventfd_ctx *ctx)
 {
 	return false;
 }
-- 
2.17.1

