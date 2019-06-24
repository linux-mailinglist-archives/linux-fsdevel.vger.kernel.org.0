Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C918A51CFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 23:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfFXVSN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 17:18:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29854 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726385AbfFXVSN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:18:13 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OL3xIO030830;
        Mon, 24 Jun 2019 14:17:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XHYjB6xwKC2VbVPIGgcfPd1ROYigU8BTLpb1YSsXrfU=;
 b=jJMeLtXUtabLMsNHXv39sQhoxtQwMNWcWt094AnXoXvzMKA+GdWNfV9Zi+06kgNub1FM
 N//Z9gkQA+IZZmjtMv2DdAqCezS8TU6ABajllFvMdnxp5HPmCCUzq+zlPGu0P3Xu6Lfm
 Qa029vGaXXEXtFh3N1we1mnwPVPKoc0fQZg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tawbta6vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 14:17:50 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 24 Jun 2019 14:17:49 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Jun 2019 14:17:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHYjB6xwKC2VbVPIGgcfPd1ROYigU8BTLpb1YSsXrfU=;
 b=NKmAxGgRmo2XfeyjQ+s/FBVkQysRKp+QNVLgIc6W+c7aG+A5eyXn0SVlNM6up4rFm4vFh64cfurXpDMuLKtRTebY5/I4PTV86xzJEl1jaZ9beMssK0cwLlBtPwEIa0rrHtXhequNApqJA0+pg7cB7cZO+br77/dy0KNbKdzKJP0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1566.namprd15.prod.outlook.com (10.173.234.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 21:17:48 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 21:17:48 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 5/6] mm,thp: add read-only THP support for
 (non-shmem)FS
Thread-Topic: [PATCH v7 5/6] mm,thp: add read-only THP support for
 (non-shmem)FS
Thread-Index: AQHVKmE7SeDKx5ckAk2qpQWHcXeIzKarT8eA
Date:   Mon, 24 Jun 2019 21:17:47 +0000
Message-ID: <1A3A4BB5-C16B-4A11-AC90-420DDFE3D6F9@fb.com>
References: <20190624074816.10992-1-hdanton@sina.com>
In-Reply-To: <20190624074816.10992-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:78ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 818a18f6-d0f1-4088-783f-08d6f8e96852
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1566;
x-ms-traffictypediagnostic: MWHPR15MB1566:
x-microsoft-antispam-prvs: <MWHPR15MB1566F7DDD5828E5DF07338D0B3E00@MWHPR15MB1566.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(2616005)(6246003)(6436002)(476003)(6486002)(11346002)(6506007)(76176011)(6916009)(486006)(99286004)(6512007)(256004)(53546011)(446003)(33656002)(102836004)(186003)(14454004)(6116002)(316002)(54906003)(46003)(53936002)(8676002)(81166006)(2906002)(4326008)(229853002)(7736002)(305945005)(73956011)(66476007)(66556008)(57306001)(66946007)(478600001)(66446008)(86362001)(64756008)(76116006)(5660300002)(25786009)(50226002)(71190400001)(71200400001)(68736007)(81156014)(8936002)(36756003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1566;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hpC1tkx6C8df9LT6zNnjxjkU3txnSXjOFb/MHeotvGbWE65gGWDk3vpCpcGbXeskvLQfKoKBcjtL/taqbaLC08r1JKYaQiVQfXuA1Hef/gJNz6KTep+ERtGanqOA1/kaCTZM9vDU/pU65Aj+rpYZkHzTs200nW4+4UACYI3X2VKKytodtgeChGcASxA2dpsf+p87yB4GO/wlDqL5rPxONWgLINuBMEoVKq9nk3Q5q6PYlhqYcRaIYRxGCDc2mug73YrOIRlsGLw88wFKVeYAyfU5aTDGobvtJ7u8/Jsj/zsqlbCc/rtaZ+nH/RJTlJIThPnfZDH9Dw2qJQZFNKuNbt8oIbnXziXxmhiRsxWVop+eJdFLjfKXcsEXLlRzaAJOx2pEztESLN28w800hlZNghhGOiZ2UmoN4Qop2304Usk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9122F56767262C47B3E2DFDC81754ADF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 818a18f6-d0f1-4088-783f-08d6f8e96852
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 21:17:47.9966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1566
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240168
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 24, 2019, at 12:48 AM, Hillf Danton <hdanton@sina.com> wrote:
>=20
>=20
> Hello
>=20
> On Mon, 24 Jun 2019 12:28:32 +0800 Song Liu wrote:
>>=20
>> Hi Hillf,
>>=20
>>> On Jun 23, 2019, at 8:16 PM, Hillf Danton <hdanton@sina.com> wrote:
>>>=20
>>>=20
>>> Hello
>>>=20
>>> On Sun, 23 Jun 2019 13:48:47 +0800 Song Liu wrote:
>>>> This patch is (hopefully) the first step to enable THP for non-shmem
>>>> filesystems.
>>>>=20
>>>> This patch enables an application to put part of its text sections to =
THP
>>>> via madvise, for example:
>>>>=20
>>>>   madvise((void *)0x600000, 0x200000, MADV_HUGEPAGE);
>>>>=20
>>>> We tried to reuse the logic for THP on tmpfs.
>>>>=20
>>>> Currently, write is not supported for non-shmem THP. khugepaged will o=
nly
>>>> process vma with VM_DENYWRITE. The next patch will handle writes, whic=
h
>>>> would only happen when the vma with VM_DENYWRITE is unmapped.
>>>>=20
>>>> An EXPERIMENTAL config, READ_ONLY_THP_FOR_FS, is added to gate this
>>>> feature.
>>>>=20
>>>> Acked-by: Rik van Riel <riel@surriel.com>
>>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>>> ---
>>>> mm/Kconfig      | 11 ++++++
>>>> mm/filemap.c    |  4 +--
>>>> mm/khugepaged.c | 90 ++++++++++++++++++++++++++++++++++++++++---------
>>>> mm/rmap.c       | 12 ++++---
>>>> 4 files changed, 96 insertions(+), 21 deletions(-)
>>>>=20
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index f0c76ba47695..0a8fd589406d 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -762,6 +762,17 @@ config GUP_BENCHMARK
>>>>=20
>>>> 	  See tools/testing/selftests/vm/gup_benchmark.c
>>>>=20
>>>> +config READ_ONLY_THP_FOR_FS
>>>> +	bool "Read-only THP for filesystems (EXPERIMENTAL)"
>>>> +	depends on TRANSPARENT_HUGE_PAGECACHE && SHMEM
>>>> +
>>> The ext4 mentioned in the cover letter, along with the subject line of
>>> this patch, suggests the scissoring of SHMEM.
>>=20
>> We reuse khugepaged code for SHMEM, so the dependency does exist.
>>=20
> On the other hand I see collapse_file() and khugepaged_scan_file(), and
> wonder if ext4 files can be handled by the new functions. If yes, we can
> drop that dependency in the game of RO thp to make ext4 be ext4, and
> shmem be shmem, as they are.

Ext4 files can be handled by these functions. We will need fs specific
code for writable THPs (in the future).=20

In longer term, once the code (with write support) become more stable,=20
we will drop this config. As of now, I think it is OK to depend on SHMEM.=20

Thanks,
Song





