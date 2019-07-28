Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 337B577E4D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2019 08:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfG1GmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jul 2019 02:42:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58790 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbfG1GmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jul 2019 02:42:00 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6S6bQCB007136;
        Sat, 27 Jul 2019 23:41:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3I2kcmT90WweFer52wY/VNVfeBhfzP3p4KoHzd+NRE4=;
 b=WPSEgu1fhn/rSOxaIawEMmKa6RlIyo7hOlvgRrTeN6mE+9GPDuCXbhXNJVhL+I1CH/GL
 lLlkn+kwL67ESuJlBdQ/fm/aJIHQXkI295RZ5ec7aeSrb0i2lr8IlDa5CUA6gp6nVkt4
 Ht2uJJoeUN7eX0L14f+VK2ADyUfrwPQ5ltw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u0nwkt7py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 27 Jul 2019 23:41:26 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 27 Jul 2019 23:41:25 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 27 Jul 2019 23:41:25 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 27 Jul 2019 23:41:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCfFjH1Ud3lcvlTwmV13eK4dQR3jOYdnI8pfnpaV0+Sd3NeMW2yYxEYGR5sle5vBD58/rPn+VWi4aJk7fv7/lEbQC9r/F86dcgArautA2eFpk+SUsqZW//FufoveQkiIcqCONEGistsOPm6aCAYPeO3ucEetxIhIuAeeNoTaqWOijVBH3rQI8Wrun4E+fNYNiE4cf4sYx6IQO/DFc++0J21WWicLiaK15VbIH4y9QvBF0spopIjUhz0w3oi18kQ4u9DdCCjYD38OYBDhyKlKxGtR3zQhulZEwWT+h2nkOWYdOOG0O6jf2G3QNbHxdD9/S82mIh+zVtPex49ysO/89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I2kcmT90WweFer52wY/VNVfeBhfzP3p4KoHzd+NRE4=;
 b=ZNzLgZpWx2Bm4ch2QJrt69SKigQtA4RlLLE9nTRZI9eprNprecS+WP9xP2issnzHn4FlC3wghQUsQG+vWNF8z3keVkqQqH/fDCDpw92Js2o877CPhSS2VmQTg4sMA92ychLZVuZsO/xNxGKSSFi9JU+cfPpxn2rx9mFyYtCYz59okkBCxvwAlKAtB6s2id8PxN3X9ko9IIQzrF8A54RPvkSnu4Sq6V4FQ3x/rPmrDAWa6SQA9VRGLihwA6VNdgh5rQPN95ABI5zvw51QRx1RO/7+AJX78NfGOm+askycih5Jnq1Ujf7hiBEM23qdWXi8fID1Eqwfbiy+EEqCwJ6vlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I2kcmT90WweFer52wY/VNVfeBhfzP3p4KoHzd+NRE4=;
 b=XghOdHzlv5kYuMhF0epBkWcF5XhkxqQUIBM9EPcnDj+YCEvsbt+AxphuS6Kk+jF4QHp3kQHNLZK4AXMyEgQmIqyIy6sQDkqHSYHIfopZcW/k0CkRebIzyNC+3veyZ0Sym4cL1Tc/T8jF5CleBlFVBsZ8EQZR8vLUTJa7519EAoE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1886.namprd15.prod.outlook.com (10.174.255.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Sun, 28 Jul 2019 06:41:23 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b%2]) with mapi id 15.20.2115.005; Sun, 28 Jul 2019
 06:41:23 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Huang, Kai" <kai.huang@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "hdanton@sina.com" <hdanton@sina.com>,
        "Kernel Team" <Kernel-team@fb.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>
Subject: Re: [PATCH v9 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Topic: [PATCH v9 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Index: AQHVKurnm0pZpZevHki8fTgvnJjHiqbZD5wAgAa5fgA=
Date:   Sun, 28 Jul 2019 06:41:23 +0000
Message-ID: <0858B3CD-D3AA-402E-B34E-2B218553910E@fb.com>
References: <20190625001246.685563-1-songliubraving@fb.com>
 <20190625001246.685563-6-songliubraving@fb.com>
 <1563926391.8456.1.camel@intel.com>
In-Reply-To: <1563926391.8456.1.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:e89a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8707eed1-1e6e-4614-0966-08d713269b93
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1886;
x-ms-traffictypediagnostic: MWHPR15MB1886:
x-microsoft-antispam-prvs: <MWHPR15MB188636DDD2BAE193FBCA79ACB3C20@MWHPR15MB1886.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 01128BA907
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(71190400001)(486006)(57306001)(256004)(76176011)(46003)(68736007)(8676002)(6506007)(6116002)(2616005)(476003)(11346002)(36756003)(102836004)(81156014)(71200400001)(53546011)(81166006)(14454004)(2906002)(446003)(6486002)(186003)(8936002)(66476007)(86362001)(6436002)(64756008)(66946007)(66556008)(50226002)(99286004)(66446008)(53936002)(305945005)(316002)(7736002)(478600001)(33656002)(25786009)(76116006)(54906003)(6916009)(4326008)(6246003)(5660300002)(6512007)(229853002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1886;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4wHcU7M51h+3ON9lIqxduwemTnQRgH3Q00TQDI7l8iGo1ithUSbwXvnc+tXjNm8sdfPIqLkMDEv1kdYjKQSlsalsGTVGd43UkFFmtInSteyt5idK2/whG/megxwtb96SXzU8tJRtbxfmq3ONP+zcChVwnydet9xpbcAgAtrJdsI7I4N2OE5fPr0FljzEBDdPm3owoiI9r5IhjaiFumnCitYn6jCay34OgnTW3GWp6KT5pApSgyNiFIQwn2D+mDw87zRQoare7Gm5nso5/DNkrX8Ze0JgIdd1ISO2CFJJ+MwRf+67dfBOmakQDjx4jhWr8jqIKeA0LMDpx6EE5K8Ywvol5or16EvYpIXd8ZsWK59iSmmD7qNdoPooQjO1ogijNVXXKudH+4eu4w46QZvEYxtJKVKfGtgW1f4RPMT3KLo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E97D3C8D83917143997EB9A7DF469C77@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8707eed1-1e6e-4614-0966-08d713269b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2019 06:41:23.4012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1886
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=986 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907280084
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 23, 2019, at 4:59 PM, Huang, Kai <kai.huang@intel.com> wrote:
>=20
> On Mon, 2019-06-24 at 17:12 -0700, Song Liu wrote:
>> This patch is (hopefully) the first step to enable THP for non-shmem
>> filesystems.
>>=20
>> This patch enables an application to put part of its text sections to TH=
P
>> via madvise, for example:
>>=20
>>    madvise((void *)0x600000, 0x200000, MADV_HUGEPAGE);
>>=20
>> We tried to reuse the logic for THP on tmpfs.
>>=20
>> Currently, write is not supported for non-shmem THP. khugepaged will onl=
y
>> process vma with VM_DENYWRITE. sys_mmap() ignores VM_DENYWRITE requests
>> (see ksys_mmap_pgoff). The only way to create vma with VM_DENYWRITE is
>> execve(). This requirement limits non-shmem THP to text sections.
>>=20
>> The next patch will handle writes, which would only happen when the all
>> the vmas with VM_DENYWRITE are unmapped.
>>=20
>> An EXPERIMENTAL config, READ_ONLY_THP_FOR_FS, is added to gate this
>> feature.
>>=20
>> Acked-by: Rik van Riel <riel@surriel.com>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> mm/Kconfig      | 11 ++++++
>> mm/filemap.c    |  4 +--
>> mm/khugepaged.c | 94 +++++++++++++++++++++++++++++++++++++++++--------
>> mm/rmap.c       | 12 ++++---
>> 4 files changed, 100 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index f0c76ba47695..0a8fd589406d 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -762,6 +762,17 @@ config GUP_BENCHMARK
>>=20
>> 	  See tools/testing/selftests/vm/gup_benchmark.c
>>=20
>> +config READ_ONLY_THP_FOR_FS
>> +	bool "Read-only THP for filesystems (EXPERIMENTAL)"
>> +	depends on TRANSPARENT_HUGE_PAGECACHE && SHMEM
>=20
> Hi,
>=20
> Maybe a stupid question since I am new, but why does it depend on SHMEM?

Not stupid at all. :)

We reuse a lot of code for shmem thp, thus the dependency. Technically, we=
=20
can remove the dependency. However, we will remove this config option when
THP for FS is more mature. So it doesn't make sense to resolve the=20
dependency at this stage.

Thanks,
Song

