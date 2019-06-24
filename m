Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C66F950D3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfFXOE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:04:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19916 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbfFXOE0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:04:26 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5ODwvEn011621;
        Mon, 24 Jun 2019 07:01:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=l42/hh6dsvPxxVCT5jkmxUTzJlp8YhLKOjGK7XP7s+I=;
 b=iBz59DtmDg+GVP1sXQXK6nJxVxG9spKS2Cka0aA1VvnaC1lTIp1L9VEFRK6Q96XSXc1Z
 5Qb5IZeHbbUKETYOpO1f0ZZO7Jt9T/qrb1Nm9FMDFugc73Dd7vGR742XrpQROMvRpRpY
 bhKM++HQN9ekk4ydLT8w7Fl5nGlLw+EcrC8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tawbt8gf8-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Jun 2019 07:01:44 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Jun 2019 07:01:35 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Jun 2019 07:01:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l42/hh6dsvPxxVCT5jkmxUTzJlp8YhLKOjGK7XP7s+I=;
 b=Q2Qw/OEfrX75XTlWIuzLzxlw6xQA7FBHT8aF5O3gS/JwMSON92kI263CbhajKvYBk/yDOwbHEYbC6Xgm+hJH5expvBozDscTbfXgN3kv9Apmjai+UYWlCMvMEe322s0QBX3oox0Ds729zQ9cfR9/H58uqi/+9lq7O9lNn44BuxM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1853.namprd15.prod.outlook.com (10.174.255.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 14:01:34 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 14:01:34 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hdanton@sina.com" <hdanton@sina.com>
Subject: Re: [PATCH v7 6/6] mm,thp: avoid writes to file with THP in pagecache
Thread-Topic: [PATCH v7 6/6] mm,thp: avoid writes to file with THP in
 pagecache
Thread-Index: AQHVKYdFkYGF24iU+UCtXh4EHn17Bqaqw38AgAAUGQA=
Date:   Mon, 24 Jun 2019 14:01:34 +0000
Message-ID: <623599AD-71C3-49B9-83A0-F1B8771E0EAE@fb.com>
References: <20190623054749.4016638-1-songliubraving@fb.com>
 <20190623054749.4016638-7-songliubraving@fb.com>
 <20190624124936.2vq55jc3qstxrujj@box>
In-Reply-To: <20190624124936.2vq55jc3qstxrujj@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:d642]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36fc0874-3b87-4c0e-bf08-08d6f8ac77a2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1853;
x-ms-traffictypediagnostic: MWHPR15MB1853:
x-microsoft-antispam-prvs: <MWHPR15MB18535C06A44E7DFD0D99A71DB3E00@MWHPR15MB1853.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(346002)(136003)(199004)(189003)(6512007)(53546011)(6506007)(2906002)(50226002)(316002)(102836004)(76176011)(99286004)(54906003)(7736002)(68736007)(478600001)(71190400001)(71200400001)(76116006)(81166006)(6436002)(66556008)(66476007)(305945005)(66446008)(66946007)(4326008)(86362001)(25786009)(5660300002)(8676002)(6916009)(6116002)(81156014)(8936002)(14454004)(33656002)(73956011)(57306001)(486006)(64756008)(256004)(186003)(11346002)(46003)(446003)(2616005)(476003)(229853002)(36756003)(6486002)(53936002)(6246003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1853;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Fm8g1k6RipUQo/vdaJxmjK8QPmVnKx4NCqZq8BjHjcSgsrgBlvzMvxZMDIEOd/0UlC7kOpxRb+2oBsIgCIikS+PtcY2lBCwnRnn/4RcGtgsrDhh2U0aiKjzyf/5pz5P+7Kv5p2LN7Qky31LkElOvZVoqKYfhBxVnkZflV3x1S4GOJ9UwMhL8Kb0ulkM1oRG/i+hyQPuF8/FCIAjA4XDFs34bB5uOLvAa0jN0k0kR7jMdYSg3pROpbuWhnTupqv/wJJQKSwkA0sX8wXZH/VpmFBxEmi5Eg3Yp0iP3t5OlbaR4AyotrSuQyN5eFnkDKw3n3I0UfV5ISF22gd/0LMRd2x/YRGhPVEmLvr3Y+i+ixAy4UpN+zfsYijktHQq0KFLsLtDHqTspx5W2YeKgvSLTYwrW/la/GLIKhHT8BbDDbs8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8E94E97BC547842BF5B5B4D416E0474@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fc0874-3b87-4c0e-bf08-08d6f8ac77a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 14:01:34.3180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1853
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=828 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240115
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 24, 2019, at 5:49 AM, Kirill A. Shutemov <kirill@shutemov.name> wr=
ote:
>=20
> On Sat, Jun 22, 2019 at 10:47:49PM -0700, Song Liu wrote:
>> In previous patch, an application could put part of its text section in
>> THP via madvise(). These THPs will be protected from writes when the
>> application is still running (TXTBSY). However, after the application
>> exits, the file is available for writes.
>>=20
>> This patch avoids writes to file THP by dropping page cache for the file
>> when the file is open for write. A new counter nr_thps is added to struc=
t
>> address_space. In do_last(), if the file is open for write and nr_thps
>> is non-zero, we drop page cache for the whole file.
>>=20
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> fs/inode.c         |  3 +++
>> fs/namei.c         | 22 +++++++++++++++++++++-
>> include/linux/fs.h | 32 ++++++++++++++++++++++++++++++++
>> mm/filemap.c       |  1 +
>> mm/khugepaged.c    |  4 +++-
>> 5 files changed, 60 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/inode.c b/fs/inode.c
>> index df6542ec3b88..518113a4e219 100644
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -181,6 +181,9 @@ int inode_init_always(struct super_block *sb, struct=
 inode *inode)
>> 	mapping->flags =3D 0;
>> 	mapping->wb_err =3D 0;
>> 	atomic_set(&mapping->i_mmap_writable, 0);
>> +#ifdef CONFIG_READ_ONLY_THP_FOR_FS
>> +	atomic_set(&mapping->nr_thps, 0);
>> +#endif
>> 	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
>> 	mapping->private_data =3D NULL;
>> 	mapping->writeback_index =3D 0;
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 20831c2fbb34..de64f24b58e9 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -3249,6 +3249,22 @@ static int lookup_open(struct nameidata *nd, stru=
ct path *path,
>> 	return error;
>> }
>>=20
>> +/*
>> + * The file is open for write, so it is not mmapped with VM_DENYWRITE. =
If
>> + * it still has THP in page cache, drop the whole file from pagecache
>> + * before processing writes. This helps us avoid handling write back of
>> + * THP for now.
>> + */
>> +static inline void release_file_thp(struct file *file)
>> +{
>> +#ifdef CONFIG_READ_ONLY_THP_FOR_FS
>=20
> Please, use IS_ENABLED() where it is possible.
>=20
I will fix them all.=20

Thanks,
Song

