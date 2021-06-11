Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B53A3956
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 03:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFKBlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 21:41:18 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:13970 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230280AbhFKBlQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 21:41:16 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15B1XEhb032208;
        Fri, 11 Jun 2021 01:39:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-0064b401.pphosted.com with ESMTP id 393hwa0jnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 01:39:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHdhTtQhwRgxc51X/wRPEXccYNscaBH4b7lZj/h1ug+DQCTKO5RIBzmuxwVJs+zv8M0Ut+b+wDIsaMyPliPGsrjdtQ6okaCcfwYzmaOii7hJZUPzEhgz2UCfWCm8diZ7oRYF5xabplxkL6MsL1dOWZt3nHHTTJIDM7xHkAtrxkEw6wvttWATlCsVTT9Fhj4dF13pfIIzv7C88OAi4V6fXW+30n09CXKYXRqrRj5CiXoWquoWbKF1izKtDczQn9N6ux/W/hGVj2gvEYfrS/ZI5/0grYoTDAOK1jU9MHjCYLpsHlHfWFCiTHMihhWLk+t9Fr5E1mtTRt2q8msvKtLadg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5xOA+ukR/F3K4h02HQX859HHeqhuIUaBNfZCozTUpk=;
 b=J2PkuK1ZExBAIbn3G20lUBsd9+0tIZI89RkfkmzgPytFbKy+Og1GC91nUjf41t8KST+12Nhb3dx17Jb0v02DlNO6mbMW+emxdhG/s257V6X4kKIfV9SVPCh2vQZdIiCOMzNK6eBkr3LvO5BU4lMDg63Yca0VTlKcBi76y8CWcU0l4/n3ns9ULcnV6H/Z9ipNwfCG4v/ww/QC0CiFS9GC41tl8pRrBPHxoGMwhd7Yk2tykI2Gd758qfBO4np6xNeVZFEJQv7RcJFTwNveGTJHl/bN0MI+9/mHNaSvOd15Yb/SeHrlouC2/kF8eVRMIBrsRiNjYTsppTX+pAs89ALCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5xOA+ukR/F3K4h02HQX859HHeqhuIUaBNfZCozTUpk=;
 b=DTOhu0y46xWmPBu1oFLBwWGHeApGxP+L5sS/8Mt/Ggz3WgmachOZLygu/dlVgtFAUZSK0c/51DV0JJahVz/6Z0/gGlZhepEMhYA3wKqPh3MPhoJABOv/uDdcM6ib2XYAICMUZsJGItg6irZngq47a8fgP0DsR7dUhVmGVwhekSM=
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM6PR11MB4347.namprd11.prod.outlook.com (2603:10b6:5:200::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 01:39:14 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18%7]) with mapi id 15.20.4195.032; Fri, 11 Jun 2021
 01:39:13 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "davidel@xmailserver.org" <davidel@xmailserver.org>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [PATCH v3] eventfd: convert global percpu eventfd_wake_count to
 ctx percpu eventfd_wake_count
Thread-Topic: [PATCH v3] eventfd: convert global percpu eventfd_wake_count to
 ctx percpu eventfd_wake_count
Thread-Index: AQHXXQeQIedvR8T9ykux8WVsY3Vix6sOCRRz
Date:   Fri, 11 Jun 2021 01:39:13 +0000
Message-ID: <DM6PR11MB420291B550A10853403C7592FF349@DM6PR11MB4202.namprd11.prod.outlook.com>
References: <20210609081526.27104-1-qiang.zhang@windriver.com>
In-Reply-To: <20210609081526.27104-1-qiang.zhang@windriver.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75dc786d-e0bf-4156-cea6-08d92c79b804
x-ms-traffictypediagnostic: DM6PR11MB4347:
x-microsoft-antispam-prvs: <DM6PR11MB43471CAF14CD1F39F5CEFF42FF349@DM6PR11MB4347.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CpdmcNTL6sYGKV9NbYOzpcpsGI6d6Ye7DX222EoT0ck4IIsY86dhngAcywWN35MsTKe4NNy4UEoqbPF+vSfAol/yGFz9no3mJqFrgmT1T2JPWDj0KuxzuIYQnLK1bx55hA8+nkvWUXjv/UQvhT78PvDpJgpt0/S9YHqQe/BMoWzuMQ/vFOHTTRijY1/j7TUlPYc+g25WBj3szRIomyXQfSyMU4ez6kigZTGDZ7LoKOGOE6eIsu7I4i19kfe3O39wajWVjlHaAuDLhIuaH+HFvgkE9FQ+dacOKgoNs9GuujgAq/oOQOVsP2YQj8kKbKCWgVpiUgcEq8u4gsVa+9nxUKIKitt6QWJatOthwKSqy2r2frmUBOD/2pFX2hYXS5E12ABKREHWr3z+qAXBRBu315QobWKnCf2OIcsheeKBBVkRcHwyJ8VGoiJ+mIO8MlDUo+vkmGBqsKxnSz1Vt435jJG+e7Wi1tFxFkq+pZSVR88H29C7t5XuXqsr24CIQ6t4BMsz4/SeTjJsyaHaa0oS+yKURCuTWUaeXNSqPxUDg/kCbjac6ViRo9itxxezQvBxP1KsQHFB/nUPqUTQwon45xQqe4MW5W3jvugBKMQTtEE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(136003)(396003)(346002)(376002)(6916009)(8676002)(8936002)(26005)(186003)(6506007)(53546011)(52536014)(66446008)(91956017)(4326008)(478600001)(66476007)(76116006)(83380400001)(9686003)(64756008)(66556008)(71200400001)(38100700002)(2906002)(66946007)(316002)(7696005)(54906003)(122000001)(86362001)(55016002)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vbnLbu228CyefPZekGizeVsTWEgDE+WyFwz5tAVH6iHNqQwj44jjkCU+16ra?=
 =?us-ascii?Q?hAOPIFAvufqubN0CthW8uFBcVmRGFc2ybKl5pQuf3OtdPk2g4ea4ry3K7oGo?=
 =?us-ascii?Q?dit78v7gHPwSUBc7GIlXvI2KvI0/7vMJmaiLwwEua9AZruYSvaGTqtFQKJTh?=
 =?us-ascii?Q?suXrSB5eGtJs9gU6H36NGJvIRPiURveSb59QIpeHx+XwpVyt6fcuynUqkngH?=
 =?us-ascii?Q?QNinmdnYEYdg0Ffo9JeOleR9m7ss69nvV6W7uzpwOXaKmQCeBWRJ07r6F3WN?=
 =?us-ascii?Q?kSv2K+T8LPr6el8lFWdfm7WOeRG/ARoiuwA3uXnrFNRnqd1dGoPTSDfhXa5p?=
 =?us-ascii?Q?e4eE9zzefAZMfPwGzX3fWhgDBOVCaC4LnlziRATXeYZfRvYP1GRRJmm7jbOZ?=
 =?us-ascii?Q?Qm6n5IlZHx1E2leOLLo0DjuKjmhXLSoq29h49t7f0cyLdIHV0R9DxVpR+3CE?=
 =?us-ascii?Q?oncdNtkIrXCTPga1VSLltmJDwNDWbcP9iGIMMTt+h/KYb80ZRBmkwv1mwnkH?=
 =?us-ascii?Q?9gRHSoz/UADGTxfZyLvTclphgiFlJpia6jSmmepxMiFe4cmcMWLXKAK1BNiJ?=
 =?us-ascii?Q?uWCynrM9x2CCjsSlxRpRGY2Z/IGio7kBRZw5FaNugUj53BfJ08TzqCjTtZfQ?=
 =?us-ascii?Q?H8IAgwK2MokisuG3YzcR4n/kpGL2+AToToNaAmAdKzcf4LxMiwKUf5uW0J8r?=
 =?us-ascii?Q?lmgRHWuCibJH2bi3IQoCbFtKjGwAEivny+bMImfpYCQisAm9rHakGp5Da0Ue?=
 =?us-ascii?Q?s4glkKQFzGpS/yzPBVJqAtauxEgRCRXfEn68WHAbiEHhh4LEFJVaebpsjS/a?=
 =?us-ascii?Q?LMAei/mC6wfA0W88CSo6V98HFPdYBFiWPkzAtZb6jq7sQ8CKGskRJQSIFFAl?=
 =?us-ascii?Q?kFQkBckC5Zuknr7X2L4bn+nvsYd4CFx/dABWn8sCgOJJ7n8oNENRf7QrBBg6?=
 =?us-ascii?Q?b/p4fvlXAxNG20tT746IuE7esO3hGFYO+HsU7+WtkfSqm1x2/nDSWvrfa53E?=
 =?us-ascii?Q?bqdwyydBEoQ8CUIJE9yUWSR4cY++eyw9R8V/RId0/jjc3MKkDldawpruBFUP?=
 =?us-ascii?Q?DF+nXiU1R1dDazBfvXt719zAM0O8dZFU4sktn9WP5zOt2ufvMDSsu8gBQ7JZ?=
 =?us-ascii?Q?fAe1uCjCDXNXnfawZDbkUbJLkbvWB/ViAIIY/z7Bn590CJQocxhO3tFTmCKy?=
 =?us-ascii?Q?lAowQuh8rbWaZjhiFr6bUYvXsf9le5BKCBzWc+zgO1DwkiQ8dRJhRGAZdycx?=
 =?us-ascii?Q?OQkylmAQrT4hvURHuIu+JOAwT6AMW2euV1HuUsZnYf/B4QOS2ewMjOxUQyub?=
 =?us-ascii?Q?WEo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dc786d-e0bf-4156-cea6-08d92c79b804
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 01:39:13.8194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 967BAsUIDWt8Hk2CMZeenHG4PzbpNoMW11dGAk0vSZ/cayYjDoEjx7w/FOKdIUZgBkMgUPAzyayUz1yOfwAES8KOYzw1pDN8j0OA4L6nvFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4347
X-Proofpoint-GUID: 7lW00888K8yndWoHSA84N2ImIORpdrpP
X-Proofpoint-ORIG-GUID: 7lW00888K8yndWoHSA84N2ImIORpdrpP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_14:2021-06-10,2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110007
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jens=0A=
=0A=
Excuse me, this change need to be review by you,  I didn't think of a bette=
r way to avoid the problem I described,  I hope I can get your opinion.=0A=
=0A=
Thanks=0A=
Qiang=0A=
________________________________________=0A=
From: Zhang, Qiang <qiang.zhang@windriver.com>=0A=
Sent: Wednesday, 9 June 2021 16:15=0A=
To: axboe@kernel.dk=0A=
Cc: viro@zeniv.linux.org.uk; linux-kernel@vger.kernel.org; linux-fsdevel@vg=
er.kernel.org=0A=
Subject: [PATCH v3] eventfd: convert global percpu eventfd_wake_count to ct=
x percpu eventfd_wake_count=0A=
=0A=
From: Zqiang <qiang.zhang@windriver.com>=0A=
=0A=
In RT system, the spinlock_irq be replaced by rt_mutex, when=0A=
call eventfd_signal(), if the current task is preempted after=0A=
increasing the current CPU eventfd_wake_count, when other task=0A=
run on this CPU and  call eventfd_signal(), find this CPU=0A=
eventfd_wake_count is not zero, will trigger warning and direct=0A=
return, miss wakeup.=0A=
=0A=
RIP: 0010:eventfd_signal+0x85/0xa0=0A=
vhost_add_used_and_signal_n+0x41/0x50 [vhost]=0A=
handle_rx+0xb9/0x9e0 [vhost_net]=0A=
handle_rx_net+0x15/0x20 [vhost_net]=0A=
vhost_worker+0x95/0xe0 [vhost]=0A=
kthread+0x19c/0x1c0=0A=
ret_from_fork+0x22/0x30=0A=
=0A=
In no-RT system, even if the eventfd_signal() call is nested, if=0A=
if it's different eventfd_ctx object, it is not happen deadlock.=0A=
=0A=
Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")=0A=
Reported-by: kernel test robot <lkp@intel.com>=0A=
Signed-off-by: Zqiang <qiang.zhang@windriver.com>=0A=
---=0A=
 v1->v2:=0A=
 Modify submission information.=0A=
 v2->v3:=0A=
 Fix compilation error in riscv32.=0A=
=0A=
 fs/aio.c                |  2 +-=0A=
 fs/eventfd.c            | 30 ++++++++++--------------------=0A=
 include/linux/eventfd.h | 26 +++++++++++++++++++++-----=0A=
 3 files changed, 32 insertions(+), 26 deletions(-)=0A=
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
index e265b6dd4f34..b1df2c5720a7 100644=0A=
--- a/fs/eventfd.c=0A=
+++ b/fs/eventfd.c=0A=
@@ -25,26 +25,9 @@=0A=
 #include <linux/idr.h>=0A=
 #include <linux/uio.h>=0A=
=0A=
-DEFINE_PER_CPU(int, eventfd_wake_count);=0A=
=0A=
 static DEFINE_IDA(eventfd_ida);=0A=
=0A=
-struct eventfd_ctx {=0A=
-       struct kref kref;=0A=
-       wait_queue_head_t wqh;=0A=
-       /*=0A=
-        * Every time that a write(2) is performed on an eventfd, the=0A=
-        * value of the __u64 being written is added to "count" and a=0A=
-        * wakeup is performed on "wqh". A read(2) will return the "count"=
=0A=
-        * value to userspace, and will reset "count" to zero. The kernel=
=0A=
-        * side eventfd_signal() also, adds to the "count" counter and=0A=
-        * issue a wakeup.=0A=
-        */=0A=
-       __u64 count;=0A=
-       unsigned int flags;=0A=
-       int id;=0A=
-};=0A=
-=0A=
 /**=0A=
  * eventfd_signal - Adds @n to the eventfd counter.=0A=
  * @ctx: [in] Pointer to the eventfd context.=0A=
@@ -71,17 +54,17 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)=
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
@@ -92,6 +75,9 @@ static void eventfd_free_ctx(struct eventfd_ctx *ctx)=0A=
 {=0A=
        if (ctx->id >=3D 0)=0A=
                ida_simple_remove(&eventfd_ida, ctx->id);=0A=
+=0A=
+       if (ctx->eventfd_wake_count)=0A=
+               free_percpu(ctx->eventfd_wake_count);=0A=
        kfree(ctx);=0A=
 }=0A=
=0A=
@@ -421,6 +407,10 @@ static int do_eventfd(unsigned int count, int flags)=
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
index fa0a524baed0..6311b931ac6f 100644=0A=
--- a/include/linux/eventfd.h=0A=
+++ b/include/linux/eventfd.h=0A=
@@ -14,6 +14,7 @@=0A=
 #include <linux/err.h>=0A=
 #include <linux/percpu-defs.h>=0A=
 #include <linux/percpu.h>=0A=
+#include <linux/kref.h>=0A=
=0A=
 /*=0A=
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining=0A=
@@ -29,11 +30,27 @@=0A=
 #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)=0A=
 #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)=0A=
=0A=
-struct eventfd_ctx;=0A=
 struct file;=0A=
=0A=
 #ifdef CONFIG_EVENTFD=0A=
=0A=
+struct eventfd_ctx {=0A=
+       struct kref kref;=0A=
+       wait_queue_head_t wqh;=0A=
+       /*=0A=
+       * Every time that a write(2) is performed on an eventfd, the=0A=
+       * value of the __u64 being written is added to "count" and a=0A=
+       * wakeup is performed on "wqh". A read(2) will return the "count"=
=0A=
+       * value to userspace, and will reset "count" to zero. The kernel=0A=
+       * side eventfd_signal() also, adds to the "count" counter and=0A=
+       * issue a wakeup.=0A=
+       */=0A=
+       __u64 count;=0A=
+       unsigned int flags;=0A=
+       int id;=0A=
+       int __percpu *eventfd_wake_count;=0A=
+};=0A=
+=0A=
 void eventfd_ctx_put(struct eventfd_ctx *ctx);=0A=
 struct file *eventfd_fget(int fd);=0A=
 struct eventfd_ctx *eventfd_ctx_fdget(int fd);=0A=
@@ -43,11 +60,10 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *c=
tx, wait_queue_entry_t *w=0A=
                                  __u64 *cnt);=0A=
 void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);=0A=
=0A=
-DECLARE_PER_CPU(int, eventfd_wake_count);=0A=
=0A=
-static inline bool eventfd_signal_count(void)=0A=
+static inline bool eventfd_signal_count(struct eventfd_ctx *ctx)=0A=
 {=0A=
-       return this_cpu_read(eventfd_wake_count);=0A=
+       return this_cpu_read(*ctx->eventfd_wake_count);=0A=
 }=0A=
=0A=
 #else /* CONFIG_EVENTFD */=0A=
@@ -78,7 +94,7 @@ static inline int eventfd_ctx_remove_wait_queue(struct ev=
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
