Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ED73A0E9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 10:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhFIIRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 04:17:13 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:17830 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237541AbhFIIRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:17:09 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15989Gh9018681;
        Wed, 9 Jun 2021 08:15:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-0064b401.pphosted.com with ESMTP id 3929drgs59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 08:15:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHsV0S2XAYsATLicOPsQnqPbXUKiVpYn90cbfPK5spL8X95gcNt9mjuxZoS32+w+k7ry1UwwsDRjwaZQlVxfr73yjwUeWbq6rMa7q4hjPn5hcj3vnv/ncdaUp9nGPltfAvQfwmaxZiW8WcYfafo2iAbPJQZTTqC4H+z7jzKwqaAiRKDmrT82QeiP1tuQ115c0nDH2jb/fgbijSsWJ/4hvAvX5WK6/GsOwdaffLSoIwuLRiES/s/5cuTg9Y2sjur2+1T0rEGiqbnAJDpv464y5tIJtjR0fZwYdR4uwBiud1vIz9xAWYimcrDKwY3k1Kwlk7jNi/omRgZz6FqsOrx2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFhGXxwacLtMrS4PKxLljKGeka7jbXmQSymkWTk5yGc=;
 b=O4xrUEk4ysLoRNxt5HZmYDB9cKVekU4x32VCoSWZj3CYhF29MxlQciis9+7XSIgwNIKyJEgrk8ZnVT0I2IDaiQBloh0GvQ1JYvRl1kzDPeQAWxn/2NsfHPo8epv3vl1pdGnyNaySknys1693klM2rk7+BFMZ84CIQbYkJ+RbXUvZ0KfVTjMU/dse8qW7am5ZlIF2AC8npMdgZqTlvQChjM/BrTP69ezQWm3//snLfPO7yblyyEF4sBgmeyFJHR3XaDD2c/Fb1qU5LCl31KbH0ZsUEfSsnVZfNY5Y6MdHzsyQoeITGLHjR5B2HM2MxO9y5AquooqqoRVPnMbFP2f2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFhGXxwacLtMrS4PKxLljKGeka7jbXmQSymkWTk5yGc=;
 b=fM+CEVZ6PMWFYmRlcT1C5ciq/6h+H4ok8v8GDAs09kncL/QQ/fgkpLoq4vpjhBTM6hN6kpxO9liGdJzcPHXTmulEM7HmaxaUwSkeBQKa1IOnfSm71O2VlnauR92IhG2xVjsDHecRMsqmbgkvigFmiNoNG+hDv/QudnNbEqK22+A=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM6PR11MB2537.namprd11.prod.outlook.com (2603:10b6:5:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 08:15:10 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18%7]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 08:15:10 +0000
From:   qiang.zhang@windriver.com
To:     axboe@kernel.dk
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] eventfd: convert global percpu eventfd_wake_count to ctx percpu eventfd_wake_count
Date:   Wed,  9 Jun 2021 16:15:26 +0800
Message-Id: <20210609081526.27104-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:202:2::17) To DM6PR11MB4202.namprd11.prod.outlook.com
 (2603:10b6:5:1df::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK2PR0401CA0007.apcprd04.prod.outlook.com (2603:1096:202:2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 08:15:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 862ddf00-9f8c-4470-eac9-08d92b1eb311
X-MS-TrafficTypeDiagnostic: DM6PR11MB2537:
X-Microsoft-Antispam-PRVS: <DM6PR11MB25371DDC30946448F738D432FF369@DM6PR11MB2537.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phgvQxW9u97HY0DVMmDR54EXuC/XD/gjJu7AC23gttsj9YUlnhEgQqzy7smA8jrJ3AYs0jeGMfTCETa6MZOZ+ZWpCf5wHQMENenqcWOA/QmSdQyDoLOFYjucKHbfg/y3L9HiUa/HfjJyjWuQq6LwK/Ovhc/tcXtoS0y0PLKHJpOxeex7wBlYeLDg+wE4pu7Od2lp0oU79FMP0K56yEMPAO0zlfiCqQjFGUVe77rWeOkX4ol23Aj2kbNrQ1kIXmEowRCXKf3gHYs/eajZk52V8pJZIF1BdgfTrIUnz2EyF/YBL8xC0UOppYd/yjKeeF7ovllI1pPHecQqpePlfDaT+OXwliIen0QYV9n6nHNw133li3cUppwPYfg3i5537ecpL/ONhf7uB/F8zfgFoDsRLx91/Lmasdv06PHna6k94DAm9jWDiwULXMKqfsDz+VhBHTlebWqz9vfZgZc0KEAqJ9vsjnZ9QkHgunl1gW9eUweorudUTV31D0iq7MqhTNUmd+oHRdocXU8xLNcF6Z1w6Hz4nYeFlshIXG/PDyqlJaq5BUhX3Fg2hFjB8bITFPzcYAy2HxkdiGtteTuqORn6aB5OPLONfxOAxfzuzlaFv1QrHxs5/o9TQ6DcIn2ZWM9rrFPEtB798X9uIMq5XWUsPCiUO6ciusWYav7e6RjhLts=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39840400004)(136003)(346002)(366004)(6916009)(86362001)(478600001)(8676002)(8936002)(4326008)(38100700002)(6666004)(5660300002)(6506007)(316002)(36756003)(83380400001)(2906002)(52116002)(38350700002)(186003)(16526019)(26005)(9686003)(1076003)(66946007)(66556008)(6512007)(66476007)(6486002)(956004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GKuuWSUv5CkDuD2SbTNtnpihWtyyJ2QnPnRiHQelRrvT/h7zkS4uY08J4Ssm?=
 =?us-ascii?Q?fOoJlds7mjZgIKRZTwSlXSj69C8dHIJ4F+Mm4gWcpemZrh2IeMip7xtASUGT?=
 =?us-ascii?Q?WUmGKFuH8nQFUjCx4YhFxIQQzWjm5AvdtnCANqFqIBpaI/FW8ZaztZWS9/V6?=
 =?us-ascii?Q?l3aksUX9VnszRfhDVElgNBUioypoVtWA9sxSmt3ysiC3eRsIekNVGkoDMr9x?=
 =?us-ascii?Q?/PgJBj1IWbf8/ui9Fuf/bFnauyh69y6y4Z8vHswxSP1ece1sJ+iReaQ+bhbc?=
 =?us-ascii?Q?dy2X6HtgxWpcTNLLI0gRLj8DpH1XDD6iNCX6lK96C4Q2L82686dzV6886s29?=
 =?us-ascii?Q?RZlfZ3xHZCqu3dXDNy4mNpPnKZQuS0oMXYinI571p61kmCzrG7+hvUjnEn8k?=
 =?us-ascii?Q?aGXE/oGqwdc1zpsWguX1mPLRkSRTitHgU1pRs+GINTHZVrIB5BaqLul2oc/2?=
 =?us-ascii?Q?W7ykNKi1eRJF09Fijh96lNTL9lw9z4JXjC7XEpT8QuwtCORr1a61cWOGQnIp?=
 =?us-ascii?Q?kIvNBf8U90LgvKhcir9QT7rkeGr9dvroRV/b8gdtTLRtyoGum3ur7jBLQBDy?=
 =?us-ascii?Q?b7Xn2RKk642MEHNOPKLx8qBSYfoZE+pC3td0Dt3jCxmIQ+NFeHecS/gdDDJR?=
 =?us-ascii?Q?C/KAsUcFQeWpv0tQrlj5+7rSvnzcg1DtpMuD2Oo+5SE+rJATa4yiRTnt+0Ml?=
 =?us-ascii?Q?OrltzF/tffMT/79ATjmlDEtZZYWyOZVRILtvMAH/TAMEZX3DfDh7z8Ho7e4G?=
 =?us-ascii?Q?3TqLlWkTf96i3PqRA3cLeUGZvWoUovDtv37FcxPKPacMnruAS/8Hr+MWCwyu?=
 =?us-ascii?Q?1f04ybNAkRwVIL8LK+Txsdq2jwdN/ZE7Ff1FhwIFhjZlCYmrb9jD3E3rfqAF?=
 =?us-ascii?Q?0SFzlSSqGGC8WSVrTiPH0Uw2AhxSIbRwH6vcxlRR7N+2O/WEZyFsLAcQCOyL?=
 =?us-ascii?Q?sDF5ZhInm9A5sag7luDrcHwoiMnvLMBF4rFTuPJ+SS0cEi1OJDIZeIEtEFmh?=
 =?us-ascii?Q?2U/ZSyZwI7DaxGvV0qRyGZ0ZfC16y/XpTWXS/YojGc7x79dnpcXw6huW4wqx?=
 =?us-ascii?Q?HXehTc/TMTEwDD+Ck90TxFJyXZf1s3cCwKuF07vhf9a95YO9KT9V7bUiUWOQ?=
 =?us-ascii?Q?0cZMImH/tdsYn1d8WZsojzHSTf1okqyv30Syxf99hd0SuHgsG902TcIeEVTs?=
 =?us-ascii?Q?jlMTLYljW41vQtqhPe0UllAEi2DSlcO1GbrrD3fFDUNbELfW45NJByF9M8pa?=
 =?us-ascii?Q?sM/hc9bFQ26dzZ6X5E66slZwtxCc3eqYniNG6DZUaEq0+v7e9rLktF2BXjeC?=
 =?us-ascii?Q?nBD4hXs6KbiiLnQgw3PlERCL?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862ddf00-9f8c-4470-eac9-08d92b1eb311
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 08:15:10.4474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVc0kb9TAGUup/thFb+KDEKFKdIDXF6IoTvyg12I96Uijh5hTYIxMkWpGEwMwN/GpYz+jwieiBpJiKnVcgGUJeHBPsi2j7kgmO4rQ6/sNfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2537
X-Proofpoint-ORIG-GUID: 5m6zGHRRt4M2yJfXJDHNbOdyHRyo5GEf
X-Proofpoint-GUID: 5m6zGHRRt4M2yJfXJDHNbOdyHRyo5GEf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_04:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090035
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
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 v1->v2:
 Modify submission information.
 v2->v3:
 Fix compilation error in riscv32.

 fs/aio.c                |  2 +-
 fs/eventfd.c            | 30 ++++++++++--------------------
 include/linux/eventfd.h | 26 +++++++++++++++++++++-----
 3 files changed, 32 insertions(+), 26 deletions(-)

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
index fa0a524baed0..6311b931ac6f 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/percpu-defs.h>
 #include <linux/percpu.h>
+#include <linux/kref.h>
 
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
@@ -29,11 +30,27 @@
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
@@ -43,11 +60,10 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *w
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
@@ -78,7 +94,7 @@ static inline int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx,
 	return -ENOSYS;
 }
 
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_count(struct eventfd_ctx *ctx)
 {
 	return false;
 }
-- 
2.17.1

