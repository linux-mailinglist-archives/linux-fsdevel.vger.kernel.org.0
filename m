Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928454E9B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 15:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfFUNoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 09:44:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18274 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbfFUNoG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:44:06 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LDhwRJ025530;
        Fri, 21 Jun 2019 06:43:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=r3x1pwntNGzkUuJmIw9PCli1qzU2mIYDRKvjHzI+7ok=;
 b=MkRs+77BN11INZVHRTqWdTaHUzJ3gS0a6Ks9lUI87mqRRroCj0QosmxVU3IC1eBH6fIi
 mrA0YHla6nygw9vUG0UyJtMNhwjOSU/JB5uornBc9bUlA90MwG7B/1QiV05L74khf7hs
 +pm5uQAKsVt45bXXMMHaaHzKF62nYst4CeI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t8gchb35g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 06:43:57 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 21 Jun 2019 06:43:44 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 21 Jun 2019 06:43:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3x1pwntNGzkUuJmIw9PCli1qzU2mIYDRKvjHzI+7ok=;
 b=h4xWEJzzKI7ME2eGCGCxyGQz+drv0lyKT+fSrDJ+v7mpsX1yPL//OncdGNYgIaDccolU0pNsaWquIHpuVC4DttkfDW6WZDwGjTvNO0ujfjDKrc5qXopFnG+d816NQGGhRBvF6gbpFWyslZ3jxLJgP4M5GGeUA+CpsCyp0JCI/jE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1119.namprd15.prod.outlook.com (10.175.8.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 21 Jun 2019 13:43:42 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.014; Fri, 21 Jun 2019
 13:43:42 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Linux-MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Kernel Team" <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 6/6] mm,thp: avoid writes to file with THP in pagecache
Thread-Topic: [PATCH v5 6/6] mm,thp: avoid writes to file with THP in
 pagecache
Thread-Index: AQHVJ6piUxjnrZaN9U27pEvDQgjQg6amFUcAgAAA5oCAAAgUAIAAARcA
Date:   Fri, 21 Jun 2019 13:43:42 +0000
Message-ID: <FA332FEC-B64D-4E60-A591-AD04311F21FF@fb.com>
References: <20190620205348.3980213-1-songliubraving@fb.com>
 <20190620205348.3980213-7-songliubraving@fb.com>
 <20190621130740.ehobvjjj7gjiazjw@box>
 <ABE906A7-719A-4AFF-8683-B413397C9865@fb.com>
 <20190621133948.2pvagzfwpwwk6rho@box>
In-Reply-To: <20190621133948.2pvagzfwpwwk6rho@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:ed23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e89474d5-4912-41c8-3f42-08d6f64e79b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1119;
x-ms-traffictypediagnostic: MWHPR15MB1119:
x-microsoft-antispam-prvs: <MWHPR15MB11190F87CBC866F1CD8647AEB3E70@MWHPR15MB1119.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(39860400002)(396003)(189003)(199004)(66946007)(6506007)(53546011)(2906002)(102836004)(6116002)(6512007)(81166006)(81156014)(8676002)(86362001)(76176011)(68736007)(33656002)(186003)(76116006)(305945005)(66476007)(66446008)(66556008)(64756008)(7736002)(73956011)(256004)(99286004)(5660300002)(53936002)(36756003)(25786009)(316002)(71190400001)(71200400001)(6916009)(478600001)(6486002)(46003)(6246003)(14454004)(229853002)(486006)(50226002)(57306001)(446003)(11346002)(476003)(6436002)(2616005)(54906003)(8936002)(4326008)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1119;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KPO2cCSdwQNcMt+AGbPUnKRKOJWnoQlQd7sd2fC1+8aj6dWbctaY/Anf6BqZED0aqZ9Lkx07DQ1h3RQ8uXVjNOADnwQGN1rm6UPsh/EJZMS8wTTP+NLS68IIjHUxnR/5s43bpwaOg+f1U7tErVlKAhqjB1rmuJoXzdhJe0eeDyl/rnXBio64CtE/KVr72Cqsypq4E810OqU/gLSkW10CfPvZigx7OdyWQDPp9IKkMuFej6/7ERxwl4PKkAMOMjRYb+y1Wsh2SOkBWicrGgaaje2NRRlVGoq6OAJiQR9fAQHsrC4sCOCU7V67MCotLqBmpBErCnQGvc1nvC+4KhaK9eH86TzL2Rw3iI/FUmVR/EJ0wqcurYxSVhiH3DE+LbbXNkWgBDxyX3PZB9MnKMebtMKOv6+tPdZpTK12kbZDfuI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <429167CCB0708345806FE238F1E5CCDF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e89474d5-4912-41c8-3f42-08d6f64e79b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 13:43:42.7309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1119
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=779 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210115
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 21, 2019, at 6:39 AM, Kirill A. Shutemov <kirill@shutemov.name> wr=
ote:
>=20
> On Fri, Jun 21, 2019 at 01:10:54PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Jun 21, 2019, at 6:07 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>>>=20
>>> On Thu, Jun 20, 2019 at 01:53:48PM -0700, Song Liu wrote:
>>>> In previous patch, an application could put part of its text section i=
n
>>>> THP via madvise(). These THPs will be protected from writes when the
>>>> application is still running (TXTBSY). However, after the application
>>>> exits, the file is available for writes.
>>>>=20
>>>> This patch avoids writes to file THP by dropping page cache for the fi=
le
>>>> when the file is open for write. A new counter nr_thps is added to str=
uct
>>>> address_space. In do_last(), if the file is open for write and nr_thps
>>>> is non-zero, we drop page cache for the whole file.
>>>>=20
>>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>>> ---
>>>> fs/inode.c         |  3 +++
>>>> fs/namei.c         | 22 +++++++++++++++++++++-
>>>> include/linux/fs.h | 31 +++++++++++++++++++++++++++++++
>>>> mm/filemap.c       |  1 +
>>>> mm/khugepaged.c    |  4 +++-
>>>> 5 files changed, 59 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/fs/inode.c b/fs/inode.c
>>>> index df6542ec3b88..518113a4e219 100644
>>>> --- a/fs/inode.c
>>>> +++ b/fs/inode.c
>>>> @@ -181,6 +181,9 @@ int inode_init_always(struct super_block *sb, stru=
ct inode *inode)
>>>> 	mapping->flags =3D 0;
>>>> 	mapping->wb_err =3D 0;
>>>> 	atomic_set(&mapping->i_mmap_writable, 0);
>>>> +#ifdef CONFIG_READ_ONLY_THP_FOR_FS
>>>> +	atomic_set(&mapping->nr_thps, 0);
>>>> +#endif
>>>> 	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
>>>> 	mapping->private_data =3D NULL;
>>>> 	mapping->writeback_index =3D 0;
>>>> diff --git a/fs/namei.c b/fs/namei.c
>>>> index 20831c2fbb34..de64f24b58e9 100644
>>>> --- a/fs/namei.c
>>>> +++ b/fs/namei.c
>>>> @@ -3249,6 +3249,22 @@ static int lookup_open(struct nameidata *nd, st=
ruct path *path,
>>>> 	return error;
>>>> }
>>>>=20
>>>> +/*
>>>> + * The file is open for write, so it is not mmapped with VM_DENYWRITE=
. If
>>>> + * it still has THP in page cache, drop the whole file from pagecache
>>>> + * before processing writes. This helps us avoid handling write back =
of
>>>> + * THP for now.
>>>> + */
>>>> +static inline void release_file_thp(struct file *file)
>>>> +{
>>>> +#ifdef CONFIG_READ_ONLY_THP_FOR_FS
>>>> +	struct inode *inode =3D file_inode(file);
>>>> +
>>>> +	if (inode_is_open_for_write(inode) && filemap_nr_thps(inode->i_mappi=
ng))
>>>> +		truncate_pagecache(inode, 0);
>>>> +#endif
>>>> +}
>>>> +
>>>> /*
>>>> * Handle the last step of open()
>>>> */
>>>> @@ -3418,7 +3434,11 @@ static int do_last(struct nameidata *nd,
>>>> 		goto out;
>>>> opened:
>>>> 	error =3D ima_file_check(file, op->acc_mode);
>>>> -	if (!error && will_truncate)
>>>> +	if (error)
>>>> +		goto out;
>>>> +
>>>> +	release_file_thp(file);
>>>=20
>>> What protects against re-fill the file with THP in parallel?
>>=20
>> khugepaged would only process vma with VM_DENYWRITE. So once the
>> file is open for write (i_write_count > 0), khugepage will not=20
>> collapse the pages.=20
>=20
> I have not look at the patch very closely. Do you only create THP by
> khugepaged? Not in fault path?

Right. My set only creates THP in khugepaged. William Kucharski is
working on the fault path.=20

Thanks,
Song

