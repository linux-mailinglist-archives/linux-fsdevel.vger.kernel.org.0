Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39FF3A8378
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 16:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhFOPAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 11:00:35 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:47978 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231522AbhFOPAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:00:33 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FEw8RW005628;
        Tue, 15 Jun 2021 07:58:18 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-0064b401.pphosted.com with ESMTP id 3969p50u13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 07:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEpJqDkaiYoiT2Ff11yCkaLwUXR+OKtnb2NKQayuyskldWs+/9ooMG22Gsxev2R3RJmCpoOnSzW6dHpF8fBzc4xU528J+psYzR+bl/THEIyP7vJ/zBxlYqegP/khivHEtQeFGTEB1QbdxR6/+7mmmZ7SsrpX/VnLlozBezHJeQz+NP2E5Rj0mRxmqQqA5MgobIUma11gqrn8oTAqKmHD9a/DJ/0ui8ZArO2O0xjpcttouU7X0Gd+ucclrxPqxbWVmsFLqw7GOxE4td8Y4pa9OhKvuECybHsK/mVJ5kJM409HSEcDeyWxpYwSqJNuo3dbGpSxNttDW23do599bjjR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifx+oPE2TBEGhP6ufR1rYOM/OX8TIoEjho491s47xk8=;
 b=nisr/OxOPgxCGRdJvZlJ93JHXkTX1DGp8nKgQ3Ae3lfyJknGiNFcFVgb3pW/VcX+2kugS86TQ6aM30QkloeBiYgo9VR3j3DE7kAZf85t4HTXYZ4KDOtk7jaGw0s0P3kXgjx4okmKXL+rxxAobCwdPdtyu7aMqbNUop4Z7j1nwxri7eucuJUSApmX0wz9nmapD471WHc+o3nxDYZKKeT8lFaELQ3t9R7ofoRi+KPfw5m/UpVHqgs0tOl0RqGHqBcDhfGmFnh66zEf59r+cuAazO9vu6BaEpsMs7tRL/iHbT1wZuF62eLwta3dWIO9FpgkWi3o1OpPdhD3Jf9dfbXmNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifx+oPE2TBEGhP6ufR1rYOM/OX8TIoEjho491s47xk8=;
 b=XTQflUxMCNoiC4BVAO/NZ53uUbYJS3IOYYnccaqrkqotiJFtv6eZnFI7rUEBHFAfYqfczCRPjY6+5TT47Q3EXVQVCS2kifHKPk5S7Yyzo3vkW/Jg/NPoIDXdcvQXogFgVblWlGUEnxfZiuPjfRMHVnFUhSnIcReXFgbIs5CrIVA=
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM5PR11MB1963.namprd11.prod.outlook.com (2603:10b6:3:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 14:58:15 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::9981:cc81:a806:a578]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::9981:cc81:a806:a578%6]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 14:58:14 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@ftp.linux.org.uk" <viro@ftp.linux.org.uk>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] eventfd: convert global percpu eventfd_wake_count to
 ctx percpu eventfd_wake_count
Thread-Topic: [PATCH v3] eventfd: convert global percpu eventfd_wake_count to
 ctx percpu eventfd_wake_count
Thread-Index: AQHXXQeQIedvR8T9ykux8WVsY3Vix6sVMZfP
Date:   Tue, 15 Jun 2021 14:58:14 +0000
Message-ID: <DM6PR11MB4202EF122EB1EE2384731FD2FF309@DM6PR11MB4202.namprd11.prod.outlook.com>
References: <20210609081526.27104-1-qiang.zhang@windriver.com>
In-Reply-To: <20210609081526.27104-1-qiang.zhang@windriver.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [240e:305:7882:5579:f400:ff11:779c:c3df]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64d8d8bc-ba95-4293-faf1-08d9300e00c3
x-ms-traffictypediagnostic: DM5PR11MB1963:
x-microsoft-antispam-prvs: <DM5PR11MB1963BFE9A11AA7D693169862FF309@DM5PR11MB1963.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8LgZS1Y66xYAGOoGLrGbVDFVrjiGe0fh2R5CpLmvNb585EhgSSdAsxZTYUiRCx9dI5WEtZZq1loeQvOPhCRfqNtNcSCF4eSSYn7ixfBWbR4sbN+5vXskWM0vRDImTyPJHWMslC6zVCN53mNRJx1wxZZZM+h0tcCa0velqzx96KpLiwcDkSVyWvcIwsjxSv44AM/ufilmYrq0z58wZK4H710yQzSJtsFus79wRNyRSha0J5rMkZfyhGehaflPu8s28K3XKUuLHD8OlYdH7dC3huaio0BNhc3bMzGvMmfJEKwXQ3ZCo6fywGdUjlqUmDiyyvd4K7MwOk4NAwdmoLypLVtPGAyeP4kOmN+Yi0KaFerF8cqEsYYNiSFJduVVG1JUR6aX6JuK3gbSOE1IYDMtf2uzd6WZ52cAFGlqUC21NgAS/rmeRtyXt0vczRgR50jjHs4AbvlWpCpZj5ZSEFbC74kEI+8fNLcPNVUo42kRSG/uVhspYA3Eq2FmsYL9sWqq5PxER88gxbpHlFFBvyZYtgz4Qw1CkjIlKi56XNKTrInq+xEf94VUyV4vzNhZZYKIkYzA59HjGmOc9CKSHkZB6rwpWAporD6pcmh8OTt0oAA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(2906002)(5660300002)(52536014)(84040400003)(186003)(76116006)(8936002)(33656002)(91956017)(54906003)(83380400001)(71200400001)(8676002)(38100700002)(122000001)(6506007)(53546011)(86362001)(55016002)(66446008)(66476007)(66556008)(498600001)(66946007)(9686003)(7696005)(64756008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zdCEs6XiVew9qidvW9cq2MNqPybxI8kLt+u/cKNZbYWspLARcbuHWt1676hf?=
 =?us-ascii?Q?P+Wu3Blcf6FF4DsFzw2Nb8DTCAODs2n5lHB9HczGbC9pq+z4gPuWsdOB4XuD?=
 =?us-ascii?Q?GNElxnHIVg0lUpU0rszq0Txl5oi0BCu8UR7shBjDcQCtXKxpl1dUAcghhUbj?=
 =?us-ascii?Q?pTYZi3Ci6gQqmsVglqSmidf+HvWrubuiG3hx+vusDaHBxOv3Jfr1Fhrj0tlb?=
 =?us-ascii?Q?Kxn8Be/+N6ShVfHw3hNBAfGJHLRPmDfgf28yZHMo4KTmtX0cGah5CjEtJqgs?=
 =?us-ascii?Q?1llPofY2M3R9D1p1xsav3sCTo8EcWJOu3nWl/Bfe/cMhZ6IOykp7KZcDuZ0x?=
 =?us-ascii?Q?uMXzAIHs1bHNTcUlHuY8MwEC6QXdwF79CAK9W97Y3MXQ3OpSNv6RahOpVeC2?=
 =?us-ascii?Q?bmQorf9Vpaw0g4DzxRdB3SCZlvPpnywfXbZEe2oei9KRADBSbxqgy0V8nhpo?=
 =?us-ascii?Q?sxFC/kZNXc0N59GXoV7rtqdE7LbwgxEcsrxYAyRJj4Xiqd+IrhKAGR20tti/?=
 =?us-ascii?Q?rYw7EzwVAIPitFzF3+GgNk7Qg/JBO6JOnTxkJdeHmLsjpnKLzpYSl7xO6j+q?=
 =?us-ascii?Q?rBWxn6sp7qEMMTdA5ghWcHut4anfAe2pL2M9zDuArUgTVyH9eJeW0OjC4UBU?=
 =?us-ascii?Q?9hljMVVRS6WUU1sDfcHJkw36XrQ0P4xu0H/k/761BuO1uhDS/PCuvxA4KryR?=
 =?us-ascii?Q?wZ1OCZIveGMwoYwQs4eu2OArtWquEEBj0S7qZ75Bu1cgUvx98mmwq4rJnZ9V?=
 =?us-ascii?Q?9pAM7kmXanaZoCwxVSENrqOjfdX7a6qCQCSmVbOclJoswMMq/wGd4iWZICw8?=
 =?us-ascii?Q?GIogWFUu8HWN0C4FxSa+ZMB0aU1IkThaWzxnp2LyhVQwcg13Zip68qB/xqi2?=
 =?us-ascii?Q?QgHJvLfMJ6UzYtcnfWHl0Io66f1JZ1JATTPXoFGwpO/DTQ3doPjM/Pi94Pt5?=
 =?us-ascii?Q?J/gKn83vLy7s1AKUwp9lf9fdZjAbvCa1LfhfcFMDMYord1kH3bj79VIHlqm2?=
 =?us-ascii?Q?tUDfPjzC5V87IjZFDzmmP+uSHhc8se1HPY/vSStFK8JqSyQt+2HKLP7/C40l?=
 =?us-ascii?Q?a2JuPqrnRtbTaD6oBlB3ux2Ynx99nFlccmyJOI6gDNjLVp+nGBc6EN8snr5m?=
 =?us-ascii?Q?zePOp2Q+h0zyi4RDerkKeTtKurxEoBi/xUZtGlUCNLFGcgn7BvWMa90phUB2?=
 =?us-ascii?Q?jJEyGcYfwfcHM40CoOCMaZC+Utr4HRVecSdNQXPVtmN99zco/cacc++pG3Sj?=
 =?us-ascii?Q?hGeLfg0pKgoYLTTtH+tc21MZbuMGKOxjIwavURXKia+eK49JbrV6R1mBZ/Eo?=
 =?us-ascii?Q?4+uRWi0/g4CqVR6cyToJQ+a97gR9y6Bk+lVXNfiatKQQHgw/01/la/WB20cX?=
 =?us-ascii?Q?kH+RyXM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d8d8bc-ba95-4293-faf1-08d9300e00c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 14:58:14.7426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z4xN+OAZjDAdcKCBzKAqCkI8VkUhYFG8exBrHP+/rYvBZgfv1fYwSeFgrM7T56V17CeeKEYwjwqS4fU06WfGMZ76MsytXB/l6J4ek91P/Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1963
X-Proofpoint-GUID: qkHZpcdpDCz0Hcg6DLRQsKDR6dlaw44V
X-Proofpoint-ORIG-GUID: qkHZpcdpDCz0Hcg6DLRQsKDR6dlaw44V
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_07:2021-06-14,2021-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150094
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello AI Viro,  Jens

There was no response to this patch for a long time,
can you help with the review?   I will thank you very much and look forward=
 to your reply .

Thanks
Qiang

________________________________________
From: Zhang, Qiang <qiang.zhang@windriver.com>
Sent: Wednesday, 9 June 2021 16:15
To: axboe@kernel.dk
Cc: viro@zeniv.linux.org.uk; linux-kernel@vger.kernel.org; linux-fsdevel@vg=
er.kernel.org
Subject: [PATCH v3] eventfd: convert global percpu eventfd_wake_count to ct=
x percpu eventfd_wake_count

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
@@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entry *wai=
t, unsigned mode, int sync,
                list_del(&iocb->ki_list);
                iocb->ki_res.res =3D mangle_poll(mask);
                req->done =3D true;
-               if (iocb->ki_eventfd && eventfd_signal_count()) {
+               if (iocb->ki_eventfd && eventfd_signal_count(iocb->ki_event=
fd)) {
                        iocb =3D NULL;
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
-       struct kref kref;
-       wait_queue_head_t wqh;
-       /*
-        * Every time that a write(2) is performed on an eventfd, the
-        * value of the __u64 being written is added to "count" and a
-        * wakeup is performed on "wqh". A read(2) will return the "count"
-        * value to userspace, and will reset "count" to zero. The kernel
-        * side eventfd_signal() also, adds to the "count" counter and
-        * issue a wakeup.
-        */
-       __u64 count;
-       unsigned int flags;
-       int id;
-};
-
 /**
  * eventfd_signal - Adds @n to the eventfd counter.
  * @ctx: [in] Pointer to the eventfd context.
@@ -71,17 +54,17 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
         * it returns true, the eventfd_signal() call should be deferred to=
 a
         * safe context.
         */
-       if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+       if (WARN_ON_ONCE(this_cpu_read(*ctx->eventfd_wake_count)))
                return 0;

        spin_lock_irqsave(&ctx->wqh.lock, flags);
-       this_cpu_inc(eventfd_wake_count);
+       this_cpu_inc(*ctx->eventfd_wake_count);
        if (ULLONG_MAX - ctx->count < n)
                n =3D ULLONG_MAX - ctx->count;
        ctx->count +=3D n;
        if (waitqueue_active(&ctx->wqh))
                wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-       this_cpu_dec(eventfd_wake_count);
+       this_cpu_dec(*ctx->eventfd_wake_count);
        spin_unlock_irqrestore(&ctx->wqh.lock, flags);

        return n;
@@ -92,6 +75,9 @@ static void eventfd_free_ctx(struct eventfd_ctx *ctx)
 {
        if (ctx->id >=3D 0)
                ida_simple_remove(&eventfd_ida, ctx->id);
+
+       if (ctx->eventfd_wake_count)
+               free_percpu(ctx->eventfd_wake_count);
        kfree(ctx);
 }

@@ -421,6 +407,10 @@ static int do_eventfd(unsigned int count, int flags)
        if (!ctx)
                return -ENOMEM;

+       ctx->eventfd_wake_count =3D alloc_percpu(int);
+       if (!ctx->eventfd_wake_count)
+               goto err;
+
        kref_init(&ctx->kref);
        init_waitqueue_head(&ctx->wqh);
        ctx->count =3D count;
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
+       struct kref kref;
+       wait_queue_head_t wqh;
+       /*
+       * Every time that a write(2) is performed on an eventfd, the
+       * value of the __u64 being written is added to "count" and a
+       * wakeup is performed on "wqh". A read(2) will return the "count"
+       * value to userspace, and will reset "count" to zero. The kernel
+       * side eventfd_signal() also, adds to the "count" counter and
+       * issue a wakeup.
+       */
+       __u64 count;
+       unsigned int flags;
+       int id;
+       int __percpu *eventfd_wake_count;
+};
+
 void eventfd_ctx_put(struct eventfd_ctx *ctx);
 struct file *eventfd_fget(int fd);
 struct eventfd_ctx *eventfd_ctx_fdget(int fd);
@@ -43,11 +60,10 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *c=
tx, wait_queue_entry_t *w
                                  __u64 *cnt);
 void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);

-DECLARE_PER_CPU(int, eventfd_wake_count);

-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_count(struct eventfd_ctx *ctx)
 {
-       return this_cpu_read(eventfd_wake_count);
+       return this_cpu_read(*ctx->eventfd_wake_count);
 }

 #else /* CONFIG_EVENTFD */
@@ -78,7 +94,7 @@ static inline int eventfd_ctx_remove_wait_queue(struct ev=
entfd_ctx *ctx,
        return -ENOSYS;
 }

-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_count(struct eventfd_ctx *ctx)
 {
        return false;
 }
--
2.17.1

