Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A3539D390
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 05:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFGDnQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 23:43:16 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:19088 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230139AbhFGDnO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 23:43:14 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1573f28J022540;
        Mon, 7 Jun 2021 03:41:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-0064b401.pphosted.com with ESMTP id 390r6sgff5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 03:41:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+wKphjOnLgKmwwSyTI6dUR7OVLWfzVhgPnbbbfWStRbjsOw6O04W4L9iUQvpB7GzRJuHFhIrCAl0y7MwfRNpkF4QO7g4/vUN7ZiBGEnPC/9WTNEnUSEC5EBS9tqOAwUgl2DXRRhG4eC28vXS5pf5w0GPx65/9tScLv1XMvZTTHqG6yWN+eBU/p60HbyUNuzWkhLOgu2mxnv/ymClKH7M6Zd1lt0G89bFKoqpYezkO9MsWE6Uu+cCNvLzJjEnzIHJzls8tCbK8sybDVYawtxC5xHNZqw8F+33Lt6/6EVOOSJ8JQB08HTN2uUHAmD4EhNom4N1TB3Q875WPxEie85aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/JvREcLZr22QeZHyu+v0QEJXIGN33jhiffpcTqFcJQ=;
 b=Sj+MORbCy9xiCWCpU7B4kn4yDZIZSs/NdaITuoPabiN++de9KHsa7BB8R7jy0gRNl84Y5HHELIydv3h2eZEsarFsCn4a5BWWCwrKPivR/Wq9jdfkqU7GYTq57JPV7fYVYtk2o3qERog+toBq87fgOjq8GLMkGbE5MqL7+TB5CKflGmvMSdsnBw2Q+vMus2LyQ2RRW1IVrCbB8PR4KWJ9nRO3geYLIzJFo298ZzWYK92DOBCnX/G3++9WvXsI13d+WX2R0g+cC2PUWIri9zk7THQbEOttUZLXTvVV8S1IzaLBS5e7wjZV+HvkzMo0vRqfqjefnNlhT89xoiYIvECGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/JvREcLZr22QeZHyu+v0QEJXIGN33jhiffpcTqFcJQ=;
 b=ATq1rR+fm/MKPZiwxD56Xi6HK2rsY9AYGP4N/khN/JwJsM/mtmnA5HLVgrCTSytaoFIK0OsfVgOlJzfOE+oELj6itr+2WfGwyObrtZcI0wF+qrg+ktyjxMkUYnZ1EXf8noOq/g2JdmR2/FmM7IXh7BrC0+epfEFTzfPiN288nMs=
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM4PR11MB5277.namprd11.prod.outlook.com (2603:10b6:5:388::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Mon, 7 Jun
 2021 03:40:59 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 03:40:59 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eventfd: convert global percpu eventfd_wake_count to ctx
 percpu eventfd_wake_count
Thread-Topic: [PATCH] eventfd: convert global percpu eventfd_wake_count to ctx
 percpu eventfd_wake_count
Thread-Index: AQHXWRUb7fI9ufDw5UKUaUEUiNVkl6sH6wI0
Date:   Mon, 7 Jun 2021 03:40:59 +0000
Message-ID: <DM6PR11MB4202E5606CEDB6E44B206F34FF389@DM6PR11MB4202.namprd11.prod.outlook.com>
References: <20210604074212.17808-1-qiang.zhang@windriver.com>
In-Reply-To: <20210604074212.17808-1-qiang.zhang@windriver.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7d87358-12d7-47f8-87a7-08d9296610a0
x-ms-traffictypediagnostic: DM4PR11MB5277:
x-microsoft-antispam-prvs: <DM4PR11MB5277C8B45F6AA24859D22664FF389@DM4PR11MB5277.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NMVB7lXlQwCKfeXSBHOFG8okzv1WiahfVkM+hfSykq4sbZQacS2qjqyhp5ub/dXahpvK+/Rx4UmHfYXPhT9rrVcIbtYW3WU82irI6SpEP45vBNzrRH1hRAeyJpYZSlHtf/LSBfEEd1WnMMx3ReQaqxa16sgU17ufbKc+wNeSixKvQttdr7odwQWeBx2AChMB5duqybtt93zq8Zqtxh2IMmhbjT0y9o83FPIgPIiIdSvWNnbb7T48GL3dLcFsUub02z8inyXT2cMuTY+OUbJiEvJJtWoXMPg7aeJREqyJ0rFnp+oH9FBhnUwUOWTsQEhyhEn3iaMaL8r1BA/kZ6BbjdyCbzDC4f49G1KIr0pyzNvbh++cXwj+6w6sLV15AF0JoVrNRDOFURrf2BFnl4Z80tud4fgmdrP+IrSFroHl7pgn0Pn5ZwObucyXvGbG7EW8RwMsrvChJ1yZ77dAFEIVOLH1EwBK65ALkQsJ5cPfWbplo9sjH01AuOIVhP3hSybzuJVsiGyg2Jpb57RpzGBPzy19qCVIJmWbR2RboYkO2TXoBUrVB6tTlk4M1JQ5BHDfnJQhmoMviovIC7WRlgjbxNuQFdog+uKGXqiOWm512HE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39830400003)(396003)(376002)(8676002)(8936002)(478600001)(53546011)(7696005)(4326008)(26005)(33656002)(186003)(6506007)(84040400003)(122000001)(71200400001)(2906002)(38100700002)(54906003)(76116006)(9686003)(5660300002)(66446008)(64756008)(66556008)(66476007)(83380400001)(66946007)(110136005)(86362001)(316002)(52536014)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yBRIkGiXQ8LuLdA8F3OCKKRVCpQyywMndUT8F9+Kt45/sw+QJtX2rUeZx420?=
 =?us-ascii?Q?yJYr8+lEWDNaIgqxo5b6vEgghxD5e1A8beW5K2r38kiAXnNErTXrQX1ieyGW?=
 =?us-ascii?Q?wLudGLcNNHtZsHrDXfm1c7NF4hkUbI3xm3k6JhXO+Wz59Ha5FBJHOpBcbPV+?=
 =?us-ascii?Q?apvbV3O97QmW0F0stkVPe86iWwpE7P9ecWxN3sgyaYj5w/eZ3txJZ0hoUVMn?=
 =?us-ascii?Q?EeFgziRBG6AHtK6AAJCXk3HJjXY1eyaLfO4OanJPDCgKgUnGOMbwDoxji+xV?=
 =?us-ascii?Q?dkCwVZifITxJTt8w2hVqcGMuv3PmGi2uMZ+ZpC/Mfgt5wT0NCq6PzrbzK2xC?=
 =?us-ascii?Q?ss4t0TPfmT8xFOQt0We/CZ9sxesc2p6qEyXWXMrqdmXcoAZWRK7dwsIVvvaA?=
 =?us-ascii?Q?XokI5sk/8Lkwjyb+Xb+zXtK5793duFds/rc/zqAStoOpYD50snk/yiWc/rGI?=
 =?us-ascii?Q?2PKIfruN9yGfxdGUL6k0/GqR8Un3yFsSSsmRMMfTCxeZwA3E3/Y71hH2UZ2Y?=
 =?us-ascii?Q?0npAxBRQGUMzd3osK1xfRaM9RBgs2Hmu4t0rPR92jmpmwnS3SYD4MRuQucAV?=
 =?us-ascii?Q?62KpaVzQOuCNNofMsctbdcvF8h13mTapOQ/JojWJy1X/Tu86kuzJdtci+Ku8?=
 =?us-ascii?Q?7FVQXb6Un0Ok5eVDdcAadCz6eNMHZsNXg9v/QQT9ydD29FI+a9JJOtuGPl0T?=
 =?us-ascii?Q?wYoUgufJUtQ9dXAq+XHN9spzTUGK976HRG2/U6p0BubAEOcAbfW7d5IiTGJB?=
 =?us-ascii?Q?Yl6MLDDX96qu8udsKGMlTuZNlJ9ACbUogNP/RIUvGw4IqGdTmh9rsBJ8oO3s?=
 =?us-ascii?Q?H1RP+f1mFUKSjYSehwn/8NpF3bHUeD42Jg5bLhq81CBa0qkglM9N6QdOWI//?=
 =?us-ascii?Q?7Eca/EQ5DBhGPaDTKGrroyhsuRKQx0mA08EtBfUNkDkePbsv6d1etPcOD5Ca?=
 =?us-ascii?Q?vk0T4nquLKYhV7hYdHKr3nrRQQqTOhC249T+iIzR/DorvDS9w/RYl5wRxpOx?=
 =?us-ascii?Q?ojFMd5t+iz+W5bI4LgWlk2qIZPqyEjeZkB2lYW/bBmqfrSX362o5a6Ox4hNf?=
 =?us-ascii?Q?svGC72QnoxstdKbbxGOzosSG9Pv3V2aTSUvR/pmKDF2luaV8WzfWjoaK1ar8?=
 =?us-ascii?Q?9yf6r+mluDrVoCyQxHlxYWnUnh5OSAOY1Vpc2UUUUVcR5ESLuKt7T5OIrOWc?=
 =?us-ascii?Q?NU8bRzT2uV0kDkKpeu8nBFE1uVHBLzAlND9SVA5pMHwjONerOoyoiAgcExk0?=
 =?us-ascii?Q?9BbFpuqBJsGbE0mwGUt7z46ootvGhkT6q8Yc+nFTJJaa1RphpI7NT6tLvAcg?=
 =?us-ascii?Q?4pg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d87358-12d7-47f8-87a7-08d9296610a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 03:40:59.0445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GO18+7fFzdNnnc2mKDeofSWUTcb4eKu5GcxcKJG7/q9rAPDi4EfghyQecW2EWpL0Tl6U0DSGuBzpOre79GGUpL7uaehYSLzFJ1stpt0jgcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5277
X-Proofpoint-GUID: LqZNuBcQk5cpha-HeXksqv46Z2CnsMj-
X-Proofpoint-ORIG-GUID: LqZNuBcQk5cpha-HeXksqv46Z2CnsMj-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_03:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070024
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Axboe=0A=
=0A=
Can you help with the review ?=0A=
In RT system, I test and find calltrace: =0A=
=0A=
=0A=
BUG: using smp_processor_id() in preemptible [00000000] code: vhost-5257/52=
62=0A=
caller is debug_smp_processor_id+0x17/0x20=0A=
CPU: 1 PID: 5262 Comm: vhost-5257 Not tainted 5.10.41-rt34-yocto-preempt-rt=
 #1=0A=
Hardware name: Intel(R) Client Systems NUC7i5DNKE/NUC7i5DNB, BIOS DNKBLi5v.=
86A.0064.2019.0523.1933 05/23/2019=0A=
Call Trace:=0A=
dump_stack+0x60/0x76=0A=
check_preemption_disabled+0xce/0xd0=0A=
debug_smp_processor_id+0x17/0x20=0A=
print_stop_info+0x20/0x40=0A=
dump_stack_print_info+0xac/0xc0=0A=
show_regs_print_info+0x9/0x10=0A=
show_regs+0x1a/0x50=0A=
__warn+0x84/0xc0=0A=
? eventfd_signal+0x85/0xa0=0A=
report_bug+0xa1/0xc0=0A=
handle_bug+0x45/0x90=0A=
exc_invalid_op+0x19/0x70=0A=
asm_exc_invalid_op+0x12/0x20=0A=
RIP: 0010:eventfd_signal+0x85/0xa0=0A=
Code: 00 00 be 03 00 00 00 4c 89 f7 e8 26 0e e2 ff 65 ff 0d cf 4c 17 60 4c =
89 f7 e8 d7 f1 be 00 4c 89 e0 5b 41 5c 41 5d 41 5e 5d c3 <0f> 0b 45 31 e4 5=
b 4c 89 e0 41 5c 41 5d 41 5e 5d c3 66 2e 0f 1f 84=0A=
RSP: 0018:ffffb12902617d00 EFLAGS: 00010202=0A=
RAX: 0000000000000001 RBX: ffff8fe2f3a60120 RCX: 0000000000000000=0A=
RDX: 00000000000092e2 RSI: 0000000000000001 RDI: ffff8fe1c36d2d20=0A=
RBP: ffffb12902617d20 R08: 0000044e00000061 R09: 0000000000000000=0A=
R10: 00000000fffffe4e R11: ffff8fe2f38ff800 R12: 0000000000000000=0A=
R13: ffff8fe2f3a60270 R14: ffff8fe2f3a60000 R15: ffff8fe2f3a60120=0A=
vhost_add_used_and_signal_n+0x41/0x50 [vhost]=0A=
handle_rx+0xb9/0x9e0 [vhost_net]=0A=
handle_rx_net+0x15/0x20 [vhost_net]=0A=
vhost_worker+0x95/0xe0 [vhost]=0A=
kthread+0x19c/0x1c0=0A=
? vhost_dev_reset_owner+0x50/0x50 [vhost]=0A=
? __kthread_parkme+0xa0/0xa0=0A=
ret_from_fork+0x22/0x30=0A=
=0A=
________________________________________=0A=
From: Zhang, Qiang <qiang.zhang@windriver.com>=0A=
Sent: Friday, 4 June 2021 15:42=0A=
To: axboe@kernel.dk; viro@zeniv.linux.org.uk=0A=
Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org=0A=
Subject: [PATCH] eventfd: convert global percpu eventfd_wake_count to ctx p=
ercpu eventfd_wake_count=0A=
=0A=
From: Zqiang <qiang.zhang@windriver.com>=0A=
=0A=
In RT system, the spinlock_irq be replaced by rt_mutex, when=0A=
call eventfd_signal(), if the current task is preempted after=0A=
increasing the current CPU eventfd_wake_count, when other task=0A=
run on this CPU and  call eventfd_signal(), find this CPU=0A=
eventfd_wake_count is not zero, will trigger warning and direct=0A=
return, miss wakeup.=0A=
In no-RT system, even if the eventfd_signal() call is nested, if=0A=
if it's different eventfd_ctx object, it is not happen deadlock.=0A=
=0A=
Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")=0A=
Signed-off-by: Zqiang <qiang.zhang@windriver.com>=0A=
---=0A=
 fs/aio.c                |  2 +-=0A=
 fs/eventfd.c            | 21 +++++++++++++++++----=0A=
 include/linux/eventfd.h |  9 ++-------=0A=
 3 files changed, 20 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/fs/aio.c b/fs/aio.c=0A=
index 76ce0cc3ee4e..b45983d5d35a 100644=0A=
--- a/fs/aio.c=0A=
+++ b/fs/aio.c=0A=
@@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entry *wai=
t, unsigned mode, int sync,=0A=
                list_del(&iocb->ki_list);=0A=
                iocb->ki_res.res =3D mangle_poll(mask);=0A=
                req->done =3D true;=0A=
-               if (iocb->ki_eventfd && eventfd_signal_count()) {=0A=
+               if (iocb->ki_eventfd && eventfd_signal_count(iocb->ki_event=
fd)) {=0A=
                        iocb =3D NULL;=0A=
                        INIT_WORK(&req->work, aio_poll_put_work);=0A=
                        schedule_work(&req->work);=0A=
diff --git a/fs/eventfd.c b/fs/eventfd.c=0A=
index e265b6dd4f34..ef92d3dedde8 100644=0A=
--- a/fs/eventfd.c=0A=
+++ b/fs/eventfd.c=0A=
@@ -25,7 +25,6 @@=0A=
 #include <linux/idr.h>=0A=
 #include <linux/uio.h>=0A=
=0A=
-DEFINE_PER_CPU(int, eventfd_wake_count);=0A=
=0A=
 static DEFINE_IDA(eventfd_ida);=0A=
=0A=
@@ -43,8 +42,15 @@ struct eventfd_ctx {=0A=
        __u64 count;=0A=
        unsigned int flags;=0A=
        int id;=0A=
+       int __percpu *eventfd_wake_count;=0A=
 };=0A=
=0A=
+inline bool eventfd_signal_count(struct eventfd_ctx *ctx)=0A=
+{=0A=
+       return this_cpu_read(*ctx->eventfd_wake_count);=0A=
+}=0A=
+EXPORT_SYMBOL_GPL(eventfd_signal_count);=0A=
+=0A=
 /**=0A=
  * eventfd_signal - Adds @n to the eventfd counter.=0A=
  * @ctx: [in] Pointer to the eventfd context.=0A=
@@ -71,17 +77,17 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)=
=0A=
         * it returns true, the eventfd_signal() call should be deferred to=
 a=0A=
         * safe context.=0A=
         */=0A=
-       if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))=0A=
+       if (WARN_ON_ONCE(this_cpu_read(*ctx->eventfd_wake_count)))=0A=
                return 0;=0A=
=0A=
        spin_lock_irqsave(&ctx->wqh.lock, flags);=0A=
-       this_cpu_inc(eventfd_wake_count);=0A=
+       this_cpu_inc(*ctx->eventfd_wake_count);=0A=
        if (ULLONG_MAX - ctx->count < n)=0A=
                n =3D ULLONG_MAX - ctx->count;=0A=
        ctx->count +=3D n;=0A=
        if (waitqueue_active(&ctx->wqh))=0A=
                wake_up_locked_poll(&ctx->wqh, EPOLLIN);=0A=
-       this_cpu_dec(eventfd_wake_count);=0A=
+       this_cpu_dec(*ctx->eventfd_wake_count);=0A=
        spin_unlock_irqrestore(&ctx->wqh.lock, flags);=0A=
=0A=
        return n;=0A=
@@ -92,6 +98,9 @@ static void eventfd_free_ctx(struct eventfd_ctx *ctx)=0A=
 {=0A=
        if (ctx->id >=3D 0)=0A=
                ida_simple_remove(&eventfd_ida, ctx->id);=0A=
+=0A=
+       if (ctx->eventfd_wake_count)=0A=
+               free_percpu(ctx->eventfd_wake_count);=0A=
        kfree(ctx);=0A=
 }=0A=
=0A=
@@ -421,6 +430,10 @@ static int do_eventfd(unsigned int count, int flags)=
=0A=
        if (!ctx)=0A=
                return -ENOMEM;=0A=
=0A=
+       ctx->eventfd_wake_count =3D alloc_percpu(int);=0A=
+       if (!ctx->eventfd_wake_count)=0A=
+               goto err;=0A=
+=0A=
        kref_init(&ctx->kref);=0A=
        init_waitqueue_head(&ctx->wqh);=0A=
        ctx->count =3D count;=0A=
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h=0A=
index fa0a524baed0..1deda815ef1b 100644=0A=
--- a/include/linux/eventfd.h=0A=
+++ b/include/linux/eventfd.h=0A=
@@ -43,12 +43,7 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ct=
x, wait_queue_entry_t *w=0A=
                                  __u64 *cnt);=0A=
 void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);=0A=
=0A=
-DECLARE_PER_CPU(int, eventfd_wake_count);=0A=
-=0A=
-static inline bool eventfd_signal_count(void)=0A=
-{=0A=
-       return this_cpu_read(eventfd_wake_count);=0A=
-}=0A=
+inline bool eventfd_signal_count(struct eventfd_ctx *ctx);=0A=
=0A=
 #else /* CONFIG_EVENTFD */=0A=
=0A=
@@ -78,7 +73,7 @@ static inline int eventfd_ctx_remove_wait_queue(struct ev=
entfd_ctx *ctx,=0A=
        return -ENOSYS;=0A=
 }=0A=
=0A=
-static inline bool eventfd_signal_count(void)=0A=
+static inline bool eventfd_signal_count(struct eventfd_ctx *ctx)=0A=
 {=0A=
        return false;=0A=
 }=0A=
--=0A=
2.17.1=0A=
=0A=
