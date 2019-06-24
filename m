Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B4151E5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 00:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfFXWe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 18:34:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41856 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726397AbfFXWe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:34:57 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5OMWGaE031494;
        Mon, 24 Jun 2019 15:34:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yWBoxyxrfYTIir4UEH96celI9RYHLQtE4HQNhnZk66U=;
 b=Xn1zg9acwhVMIggUjNpahKyM/FblpDg4/syrSWuJzXKdSsWnL1sswR0yJmxQLWcNwblp
 v8QpMWy/oDMQI/sYICcvrfnM+EQJwSDijUKIBddbubJqAhqStH0XvAd30W93iO8Bwcgd
 nMamMzw52ZMmpD+BLcEfd1/jFfAKdSpy0ZQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2t9g0ag9yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Jun 2019 15:34:30 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Jun 2019 15:34:30 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Jun 2019 15:34:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWBoxyxrfYTIir4UEH96celI9RYHLQtE4HQNhnZk66U=;
 b=fvm9/RRZAZTgW5ZivadEoUQ3Btkup/9riISQFC4TWBorfwIRs4+KTk3ZLJkJqlpGfZ2fCrmWuku6Ye52quoPOQFHwZE0VEFcuDU7fiWEX0+dxRG29ifdopyzLrVFaNuiifxHbTJD1XFexC9ILZGVN8TjmiBA7mU2sSNMtRynliQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1278.namprd15.prod.outlook.com (10.175.3.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 22:34:29 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 22:34:29 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Linux-MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Kernel Team" <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hdanton@sina.com" <hdanton@sina.com>
Subject: Re: [PATCH v8 0/6] Enable THP for text section of non-shmem files
Thread-Topic: [PATCH v8 0/6] Enable THP for text section of non-shmem files
Thread-Index: AQHVKtxbf9M9JYvZyE29Ijo3qgVrlqarZD2A
Date:   Mon, 24 Jun 2019 22:34:29 +0000
Message-ID: <D1AFAFC0-56BC-4865-A6B7-4AAF30315BE5@fb.com>
References: <20190624222951.37076-1-songliubraving@fb.com>
In-Reply-To: <20190624222951.37076-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:78ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 385f32fd-e573-4d74-e130-08d6f8f41edd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1278;
x-ms-traffictypediagnostic: MWHPR15MB1278:
x-microsoft-antispam-prvs: <MWHPR15MB1278173CE9FA972BD8B1538DB3E00@MWHPR15MB1278.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(446003)(64756008)(66556008)(66946007)(46003)(66446008)(66476007)(6246003)(25786009)(6486002)(71200400001)(73956011)(5660300002)(2501003)(486006)(71190400001)(6436002)(53936002)(86362001)(229853002)(4326008)(6116002)(11346002)(99286004)(476003)(57306001)(68736007)(6512007)(76176011)(81166006)(558084003)(50226002)(8936002)(76116006)(53546011)(102836004)(81156014)(6506007)(8676002)(305945005)(2906002)(2616005)(186003)(7736002)(36756003)(33656002)(14454004)(256004)(316002)(110136005)(54906003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1278;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ke8NFVkdEP/tsZAnqXnuLclSzNDtD23piJr2iRkbefFSxMAmDXPSsil5+/0MVlw7UoLD4PVIndjvDQtwGCriJFKkUteNAIOPIiIuyg+5Hh7DlVxcxKlQNtWfEC3iDZXNFctDynzd0ux/JFBuZk6BlLKo72sZOf7IhmqBADrGrhBgqcEX2yAIc/moEA5MXXdy+bsUQ8uXZlOVD31ayIyfBx/FTSzs4RRdvrAO6/l46AbtIIocfP36iU5Jfxw0VVUbCLHhXY7ELh/pNxy5WrOx7DR67f4CjeU6oTjsB+qWEPWTTf0xs7JBFSZTbbLbBhNad+1SDCvtpcNLR3MVdm24d4gUuL7TzFMjnPfgdHjsAA1ScqXuWTEWxqIjakmrB6UZz49xdrM/ZvMO9tJGmjiyufgh8efhEan+k3kIXWaYwpk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2B3F7FBF4FEA4741B1BFDE92301624E8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 385f32fd-e573-4d74-e130-08d6f8f41edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 22:34:29.0497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1278
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=923 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240177
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 24, 2019, at 3:29 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> Changes v7 =3D> v8:
> 1. Use IS_ENABLED wherever possible (Kirill A. Shutemov);

I messed up with IS_ENABLED. Please ignore this version. v9 coming soon.

Sorry for the noise.=20

Song

