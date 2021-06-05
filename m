Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE6339C47D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 02:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhFEAf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 20:35:28 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:25908 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229847AbhFEAf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 20:35:27 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1550TNCh031089;
        Sat, 5 Jun 2021 00:33:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by mx0a-0064b401.pphosted.com with ESMTP id 38yxg2g0c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Jun 2021 00:33:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lv8LuUC1REu1y5bqkIIiJzTgu1LHZ79iZPm9TN0l/AZPWcEg/1tmWZcuXn6KsYpENATtqasTn/hI4m5glMRINydPtM7yvdSMpVzYMBB+a+LRxiy2G6XlsEO8j12LKj3/j7Ef0tAz9scrlfUszqv9F8905JVeNauJvsVMy15aKRzCbJ5YwCH1xiHHIm1wQaMr1NZT+E3lIBqUmrQ7uWp4U4XUiubSc9mgqPgihqpSg86LjNwfOsz8v/zmyh3TzQ3HtT1XdloLsg57/q39i+U3xuytHQvKFrff/coYiKgnLNGVk3+ZUTY44GKouxKZ8APn6BHjdDJ01OW+GF/HDWWzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUNw+JoZLnfll8BCMTJ1tCgBhVaKWGZLCECcIHFuOlc=;
 b=oNWB2oVGI0FVKXDBI+tPbmOMNrsF0zKWXqwlhGNC8ZSlIbObS0/MO6yUxo8qZp7lW+Gx9npnHHYpEYhpA43BxvHpTue7Kegdv1g0i8GvzHCLmyEpDqa+sMSCjNotU2LXYC/Wy83ydn2h0ubC6BFP6OPjQyOERvEizJeMThyUo+sgnAFXSbzOxfGw/pNNMGtRpWZKNB3FXmZEtbEZaEuXLOQbsYh2YWP4HGb44EpvGnedxVH/tdQRAC2PXO1j3qJrFSubkhQMoOkVKFJTEh/HppBhp+VbFzv2wzjzN0mMSiTiOJizAI4RTuEBXXhsjVD5bou+5t2yFToVYTYr8Jr+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUNw+JoZLnfll8BCMTJ1tCgBhVaKWGZLCECcIHFuOlc=;
 b=FeSmHZxfd5pHA9rsf9I8o3qCET8CxHHHsV4+mbtKr50VyH+ZRA88YXAx5ClTUOTlC3+VDe5nTpnVLXAsylaWlyVaA+ct4KrGdpdTmiYa3jEafeuU5ALekQeVxyyooijNfe6y6KJIG+hVGYXLAejthQ5U4mx2IFvYPZOj1byugS8=
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM6PR11MB3580.namprd11.prod.outlook.com (2603:10b6:5:138::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Sat, 5 Jun
 2021 00:18:24 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::3590:5f5:9e9e:ed18%7]) with mapi id 15.20.4195.024; Sat, 5 Jun 2021
 00:18:24 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/super: simplify superblock destroy action
Thread-Topic: [PATCH] fs/super: simplify superblock destroy action
Thread-Index: AQHXUTLnwceG1e6FF0eBv+5SZ6F2oKsEnS0y
Date:   Sat, 5 Jun 2021 00:18:24 +0000
Message-ID: <DM6PR11MB420216C857EAE36F8E5B8FA4FF3A9@DM6PR11MB4202.namprd11.prod.outlook.com>
References: <20210525065520.23596-1-qiang.zhang@windriver.com>
In-Reply-To: <20210525065520.23596-1-qiang.zhang@windriver.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [240e:305:7882:5579:1fd:e8d9:ca6e:a0c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1393bfe8-c89a-4806-e18c-08d927b76f17
x-ms-traffictypediagnostic: DM6PR11MB3580:
x-microsoft-antispam-prvs: <DM6PR11MB3580B96B6A4B940572B1E874FF3A9@DM6PR11MB3580.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:151;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPlq0xCZM030oDabJsWbjMmGAqn5ACiPi4AvDq5YgXnN7a+ttXdD4KBRZU5F45UJMXB5aD1lf0CH6/8QUCJ0D8DEnMLGflTd832ztobSFvIJSVvcLeO9WgdOy/Ow8lCHcOV2M0MCjxZGo76k6i2TSRHTs1tsIBlBOHscJcjoYpSkzCZeU54JlRq8VJQI4ac46pU3YwP7dUmkXKVAYwSBSUTPL0eYIWGdvPKHrKN7ayCdLli7JTWw4uuSbfuubwR36M3wIZuuguedVzvHIw6ggvLkfClBESilKFklBsOV6QJ5zrsqFTv6Pk/HtDkpRg3DIIjOkABTOdGEp/9OoAWfdQZE7L+VTbbTHxXDuGEBYUAXK9PC3ekn95H8Z+12of4K3cI+eXvTBbKFodKqBWZYkmSskIYIaS9XI+NKM3GL/rIeFRv6cSF1nl5tHfsaMw3mlwKzyzR1drXVJVTtl2a1/PcleNaaQUPPndDcPf6S4neYXxEBQJ1uBr0XO73MejUXqnXgiOY/bJ/1Nb4DEhcPLUx5QS/AIspXQhRDLr5e2WsLnqKwNUYAtcwQ9SlWmu1LiBWdLQ5M7oKWOJeZcDzRfgvltz1gbnNj5aMcBtFhpXQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(136003)(346002)(376002)(396003)(366004)(38100700002)(7696005)(66946007)(5660300002)(122000001)(66476007)(91956017)(64756008)(66556008)(66446008)(71200400001)(4326008)(33656002)(6506007)(53546011)(83380400001)(52536014)(186003)(86362001)(8936002)(55016002)(54906003)(110136005)(8676002)(76116006)(9686003)(478600001)(2906002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?++E9NcuYy5WWbw/bQfb15SEKu/sR62Gi3+2JrNW8agE/S23g+3dySAjtH+IW?=
 =?us-ascii?Q?yjg5Ikp84gBQeJ1B7BGzBWjI3Ix9gUIohiB50caBN3PWZFdJTgMI3s6j/zY+?=
 =?us-ascii?Q?5LFnqXg7n1PEgkfdEXqd9LbkdBle5LYSgDDzv8xWsk663RW3y96FypzX9ISg?=
 =?us-ascii?Q?p32Z79fXrYUl0gQEi6DHvlW6Q+TMEAKz+Gu3DouBKorRH4titVpinqqBRUG5?=
 =?us-ascii?Q?etSQJlx0B7x/nwlTz6NKWJM9H66k8Rd1fLRrmJCiftqr04eYLkvMYN4kjTrC?=
 =?us-ascii?Q?+3sQLkj1YpnmiwAcSPmXQZ3jvFCLAdy/MGzLcUyl9MpOa/LuIg3w9pn0QP32?=
 =?us-ascii?Q?Z3hLMKSoE8/CkTdXP93Umu2NS9yfrKkhpTkK38yVNhoQSAMoGxmn2NEKOkrO?=
 =?us-ascii?Q?YWoVZCTuV+3O0gYggT+1OVjQnzAAEyijesy5cBkRioSRCcLV4x5au5qWC8LY?=
 =?us-ascii?Q?0dKy8C5J9KXwRJ1z71Oiojid8eh8SkZJebaCfNIChbrGX99uBTs/qStRI+lO?=
 =?us-ascii?Q?NgSP7hK7Aazg9l8nl5BmDDb3Mi/agGEWemb7t/DcCRGLKH9w+/jMQkYJC4bn?=
 =?us-ascii?Q?891+AirRcEeLrWA3V2lNFC2rAiqaWYtj1bepZ9rJTHOI2tbbe3T4kZj6QnLc?=
 =?us-ascii?Q?bfzuyk1qzskZiZO9qg9DQYlz5RGlP+Ol/Uma8U+wJPDtAMBYvXm0Fcjfb3yq?=
 =?us-ascii?Q?OVOLRS3K9MAzDGtsTA9dofpPipdexzhvqGe4T122iF2f1Dzlr0IqS9gv+1/s?=
 =?us-ascii?Q?IfEqwJiF08s02Jm0uAyjAiB45YFZr875ophmeMHd9tPLZZnxOy5fGDBPta19?=
 =?us-ascii?Q?vmF208vT3ivrHLhmM1ViDsYEPHckczdq7JaiIIUt3TppZwzycyxx+o2knKtO?=
 =?us-ascii?Q?ZNQ/pBMLdgQFu53A6D/q15lejDIZ1xkvxl62TFb8/sp5YacEaJ5GJxSa21K1?=
 =?us-ascii?Q?2Wg16kI0oxJUL9cc0uKYDKDImlO2o01d/lwCMMjklhF6F4eu2MjfZOKUqv5S?=
 =?us-ascii?Q?ZUZEPcfL2cUxmcOLVAtHTNZzytSGKgkIWqcydP4GhXTcyGBBRxQStXLU2Ls2?=
 =?us-ascii?Q?sF4Gj/MCb/T7sjftPwlWQ0Yb9GHZLM45w3kZRuNCdYYI0naNemu3APes3vI2?=
 =?us-ascii?Q?gxFTtznHWHOnZfP+9eK2yniljFXzqBaVg+P3ieqm3FOzuZNen3ye3CJJfEbQ?=
 =?us-ascii?Q?eBNRjnN1WXYwu02eV4c+527vuRo++aypbMImNOkooXhJEMH1NUnDtGSay2na?=
 =?us-ascii?Q?vdXOOa+ZmDZJggSbD16S2bkJ/Nw//a1ReO77Xmw4FftTLoWUf5AGHwAIu3w9?=
 =?us-ascii?Q?NmMkgdCAIsY058yd1izb2i08DbQnkwVxOXNZVN3p2ndc7N9cOAw4MqO22cIr?=
 =?us-ascii?Q?Y8ZYfOc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1393bfe8-c89a-4806-e18c-08d927b76f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2021 00:18:24.5230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERvJtMmgKZgz5GVELJTuNyXtDuGTnm6BALCWHiR3uEOz+wGIUjs/Dly+cywyBld3om/qvgnOmKy+mTzFEPv8+pbl7itmeaswGRqfJgVXD8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3580
X-Proofpoint-GUID: SlhyeA3nbX4eTz43aNjvaALkxIpxdxKS
X-Proofpoint-ORIG-GUID: SlhyeA3nbX4eTz43aNjvaALkxIpxdxKS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_16:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106050001
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello AI Viro=0A=
Can you review this patch?=0A=
=0A=
Thanks=0A=
Qiang=0A=
=0A=
________________________________________=0A=
From: Zhang, Qiang <qiang.zhang@windriver.com>=0A=
Sent: Tuesday, 25 May 2021 14:55=0A=
To: viro@zeniv.linux.org.uk; akpm@linux-foundation.org=0A=
Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org=0A=
Subject: [PATCH] fs/super: simplify superblock destroy action=0A=
=0A=
From: Zqiang <qiang.zhang@windriver.com>=0A=
=0A=
The superblock is freed through call_rcu() and schedule_work(),=0A=
these two steps can be replaced by queue_rcu_work().=0A=
=0A=
Signed-off-by: Zqiang <qiang.zhang@windriver.com>=0A=
---=0A=
 fs/super.c         | 15 +++++----------=0A=
 include/linux/fs.h |  3 +--=0A=
 2 files changed, 6 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/fs/super.c b/fs/super.c=0A=
index 11b7e7213fd1..6b796bbc5ba3 100644=0A=
--- a/fs/super.c=0A=
+++ b/fs/super.c=0A=
@@ -156,8 +156,8 @@ static unsigned long super_cache_count(struct shrinker =
*shrink,=0A=
=0A=
 static void destroy_super_work(struct work_struct *work)=0A=
 {=0A=
-       struct super_block *s =3D container_of(work, struct super_block,=0A=
-                                                       destroy_work);=0A=
+       struct super_block *s =3D container_of(to_rcu_work(work), struct su=
per_block,=0A=
+                                                       rcu_work);=0A=
        int i;=0A=
=0A=
        for (i =3D 0; i < SB_FREEZE_LEVELS; i++)=0A=
@@ -165,12 +165,6 @@ static void destroy_super_work(struct work_struct *wor=
k)=0A=
        kfree(s);=0A=
 }=0A=
=0A=
-static void destroy_super_rcu(struct rcu_head *head)=0A=
-{=0A=
-       struct super_block *s =3D container_of(head, struct super_block, rc=
u);=0A=
-       INIT_WORK(&s->destroy_work, destroy_super_work);=0A=
-       schedule_work(&s->destroy_work);=0A=
-}=0A=
=0A=
 /* Free a superblock that has never been seen by anyone */=0A=
 static void destroy_unused_super(struct super_block *s)=0A=
@@ -185,7 +179,7 @@ static void destroy_unused_super(struct super_block *s)=
=0A=
        kfree(s->s_subtype);=0A=
        free_prealloced_shrinker(&s->s_shrink);=0A=
        /* no delays needed */=0A=
-       destroy_super_work(&s->destroy_work);=0A=
+       destroy_super_work(&s->rcu_work.work);=0A=
 }=0A=
=0A=
 /**=0A=
@@ -249,6 +243,7 @@ static struct super_block *alloc_super(struct file_syst=
em_type *type, int flags,=0A=
        spin_lock_init(&s->s_inode_list_lock);=0A=
        INIT_LIST_HEAD(&s->s_inodes_wb);=0A=
        spin_lock_init(&s->s_inode_wblist_lock);=0A=
+       INIT_RCU_WORK(&s->rcu_work, destroy_super_work);=0A=
=0A=
        s->s_count =3D 1;=0A=
        atomic_set(&s->s_active, 1);=0A=
@@ -296,7 +291,7 @@ static void __put_super(struct super_block *s)=0A=
                fscrypt_sb_free(s);=0A=
                put_user_ns(s->s_user_ns);=0A=
                kfree(s->s_subtype);=0A=
-               call_rcu(&s->rcu, destroy_super_rcu);=0A=
+               queue_rcu_work(system_wq, &s->rcu_work);=0A=
        }=0A=
 }=0A=
=0A=
diff --git a/include/linux/fs.h b/include/linux/fs.h=0A=
index c3c88fdb9b2a..2fe2b4d67af2 100644=0A=
--- a/include/linux/fs.h=0A=
+++ b/include/linux/fs.h=0A=
@@ -1534,8 +1534,7 @@ struct super_block {=0A=
         */=0A=
        struct list_lru         s_dentry_lru;=0A=
        struct list_lru         s_inode_lru;=0A=
-       struct rcu_head         rcu;=0A=
-       struct work_struct      destroy_work;=0A=
+       struct rcu_work         rcu_work;=0A=
=0A=
        struct mutex            s_sync_lock;    /* sync serialisation lock =
*/=0A=
=0A=
--=0A=
2.17.1=0A=
=0A=
