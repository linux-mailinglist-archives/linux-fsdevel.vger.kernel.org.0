Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951A15D6ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 21:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfGBTbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 15:31:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54280 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbfGBTbm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:31:42 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62JToSY026489;
        Tue, 2 Jul 2019 12:30:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=mppx4FLBiOac/STDzA0e2oKlDa48wRKnZw4fy6/xPlc=;
 b=Sl2hfYv7BKnoXDEV6t5+vb+gHPHKTRGE9nl2b/t5suoVFtFpQHYtcj5qhBmv+yHz7LJV
 t+uoABQDo2kuUu3wA0jpuUoLIyc/lDfOEn0d63UcevCBgPkCpuIyi6FbPDHjTUqm2tC8
 jbHJIaKyrtTEzBA6SIm2ZhIAawwGUleeHEg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tgcmf0dck-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 12:30:49 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 2 Jul 2019 12:30:46 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 2 Jul 2019 12:30:46 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 2 Jul 2019 12:30:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mppx4FLBiOac/STDzA0e2oKlDa48wRKnZw4fy6/xPlc=;
 b=IRNQCbfTPXOGzWmovInNOQNAMQy3AEeUph5ZYNTBCU5nqqexohVGS+GKA1a78vw8fENTvo1+sbilmNMMS1VBCZyqGAMcCAZVIgiwbW8gRXBfSOUUu0xI5l6zF9E+h6GFlVcZzG01KzCRUwViG8nnpEUTeqTHdROeWGgBc1xwfg0=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3025.namprd15.prod.outlook.com (20.178.221.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 19:30:44 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::a169:14b9:5076:a1ff]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::a169:14b9:5076:a1ff%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 19:30:44 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
Thread-Topic: [PATCH] mm, slab: Extend slab/shrink to shrink all the memcg
 caches
Thread-Index: AQHVMQU0aiPYUCU7kUq+agLP0TSFvKa3tzYA
Date:   Tue, 2 Jul 2019 19:30:44 +0000
Message-ID: <20190702193038.GA9224@tower.DHCP.thefacebook.com>
References: <20190702183730.14461-1-longman@redhat.com>
In-Reply-To: <20190702183730.14461-1-longman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:301:5f::30) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::b250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f1708b0-0142-4697-d297-08d6ff23c697
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB3025;
x-ms-traffictypediagnostic: BN8PR15MB3025:
x-microsoft-antispam-prvs: <BN8PR15MB3025D79ABECDE7CADAEAEF7FBEF80@BN8PR15MB3025.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(376002)(396003)(366004)(199004)(189003)(6436002)(6916009)(66946007)(81156014)(316002)(4326008)(6486002)(7416002)(54906003)(486006)(68736007)(2906002)(5660300002)(6506007)(6512007)(53936002)(25786009)(9686003)(229853002)(1076003)(64756008)(446003)(33656002)(46003)(11346002)(66556008)(102836004)(476003)(478600001)(52116002)(14454004)(73956011)(66446008)(256004)(186003)(71190400001)(71200400001)(7736002)(76176011)(8936002)(86362001)(99286004)(6246003)(81166006)(6116002)(8676002)(66476007)(386003)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3025;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6/+UzvC4gKxruJAPYFEWI/Rlwab3Nqm+b5+MiLwi1uKuyNMm4cDDC8f3B1pgNNTtZjQKRiy+v8PgepEIfpyOyqHK+JXTmGfznbMUvni/sGoje9DD8CG1rNN47i/XFQWcg6bimGyGSXpyrmqYzriQxxId5EXSvvV5jRViuOaK0F+X093GiM0qRSWBC9NVpB9a0pgvZyHmkhlnSEPhahiFaz4eudaF0zGoA35xtWJjlK86dr8WgbA9lcUmYn/xw3cFQPnUUdKXVyadcv5aKzWV6bTFG1IyDlJgj4DwQf06Bl/HQCvJyu3TsSQ1wVsUakLoVm00XcI6dGn7k/Be+e7p4VnSUmqQLBTOpWF6j3uCJ7dMGV1uc8hlzUnPryZiGv4XUdC8QyVH1WLeoEP0VNXCVNVbSkWcs6udpf38ckxegYI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98243A29FC6FF44DA4B92FB487069E95@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1708b0-0142-4697-d297-08d6ff23c697
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 19:30:44.3119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3025
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=606 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020215
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 02, 2019 at 02:37:30PM -0400, Waiman Long wrote:
> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
> file to shrink the slab by flushing all the per-cpu slabs and free
> slabs in partial lists. This applies only to the root caches, though.
>=20
> Extends this capability by shrinking all the child memcg caches and
> the root cache when a value of '2' is written to the shrink sysfs file.
>=20
> On a 4-socket 112-core 224-thread x86-64 system after a parallel kernel
> build, the the amount of memory occupied by slabs before shrinking
> slabs were:
>=20
>  # grep task_struct /proc/slabinfo
>  task_struct         7114   7296   7744    4    8 : tunables    0    0
>  0 : slabdata   1824   1824      0
>  # grep "^S[lRU]" /proc/meminfo
>  Slab:            1310444 kB
>  SReclaimable:     377604 kB
>  SUnreclaim:       932840 kB
>=20
> After shrinking slabs:
>=20
>  # grep "^S[lRU]" /proc/meminfo
>  Slab:             695652 kB
>  SReclaimable:     322796 kB
>  SUnreclaim:       372856 kB
>  # grep task_struct /proc/slabinfo
>  task_struct         2262   2572   7744    4    8 : tunables    0    0
>  0 : slabdata    643    643      0
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks, Waiman!
